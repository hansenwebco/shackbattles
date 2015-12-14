using ShackBattles.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.MasterPages
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                UserSession us = (UserSession)Session["user"];
                LiteralUserName.Text = us.username;
            }
            catch
            {
                HttpContext.Current.Response.Redirect("~/?returnUrl=" + HttpContext.Current.Request.Url.PathAndQuery, true);
            }
        }
    }
}