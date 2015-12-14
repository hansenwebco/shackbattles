using ShackBattles.Classes;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;
using ShackBattles.Data;
namespace ShackBattles
{
    public partial class Default : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                try
                {
                    Boolean loginSuccess = ValidateLogin();
                    if (loginSuccess)
                    {
                        int userKey = UpdateDbUser(TextBoxLogin.Text.Trim());

                        UserSession us = new UserSession();
                        us.username = TextBoxLogin.Text.Trim();
                        us.userKey = userKey;
                        Session["user"] = us;

                        if (!string.IsNullOrEmpty(Request.QueryString["returnURL"]))
                            Response.Redirect("~/" + Request.QueryString["returnURL"], true);
                        else
                            Response.Redirect("~/home/", true);
                    }
                    else
                    {
                        LiteralError.Text = "Login Failed, Please Try Again.";
                    }
                }
                catch (Exception ex)
                {
                    LiteralError.Text = "<b>ERROR:</b><br/>" + ex.Message;
                }

            }
        }
        private bool ValidateLogin()
        {
            try
            {

                string conn = Helper.GetBaseAPIURl();
                using (WebClient wc = new WebClient())
                {
                    NameValueCollection fields = new NameValueCollection();
                    fields.Add("username", TextBoxLogin.Text.Trim());
                    fields.Add("password", TextBoxPassword.Text.Trim());
                    byte[] response = wc.UploadValues(conn + "verifyCredentials", fields);
                    string result = wc.Encoding.GetString(response);

                    JObject json = JObject.Parse(result);
                    Boolean loginSuccess = (Boolean)json["isValid"];

                    //TODO: remove debug
                    //return true;

                    return loginSuccess;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("There was a failure contacting the Shack API.<br/><br/>" + ex.Message);

            }
        }
        private int UpdateDbUser(string username)
        {
            try
            {

                using (SBEntities dc = new SBEntities())
                {

                    User u;
                    u = dc.Users.Where(w => w.Username == TextBoxLogin.Text.Trim()).FirstOrDefault();
                    if (u == null)
                    {
                        u = new User();
                        u.Username = username;
                        u.DateCreated = DateTime.UtcNow;
                        dc.Users.Add(u);
                    }
                    u.LastLogin = DateTime.UtcNow;
                    dc.SaveChanges();

                    return u.UserKey;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("There was a failure contacting the ShackBattles database.<br/><br/>" + ex.Message);
            }

        }
    }
}