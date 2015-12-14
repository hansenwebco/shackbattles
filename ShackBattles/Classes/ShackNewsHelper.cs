using Newtonsoft.Json.Linq;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace ShackBattles.Classes
{
    public static class ShackNewsHelper
    {
        public static bool SendShackMessage(string to, string subject, string body)
        {
            string username = ConfigurationManager.AppSettings["ShackAccoutLogin"];
            string password = ConfigurationManager.AppSettings["ShackAccountPass"];

            try
            {
                string conn = Helper.GetBaseAPIURl();
                using (WebClient wc = new WebClient())
                {
                    NameValueCollection fields = new NameValueCollection();
                    fields.Add("username", username);
                    fields.Add("password", password);
                    fields.Add("to", to);
                    fields.Add("subject", subject);
                    fields.Add("body", body);
                    byte[] response = wc.UploadValues(conn + "sendMessage", fields);
                    string result = wc.Encoding.GetString(response);

                    JObject json = JObject.Parse(result);
                    Boolean loginSuccess = (String)json["result"] == "success";

                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
        public static void SendBattleCreation(string to, int battleKey)
        {
            try
            {
                using (SBEntities db = new SBEntities())
                {
                    Battle b = db.Battles.Where(w => w.BattleKey == battleKey).FirstOrDefault();

                    if (b != null)
                    {
                        StringBuilder sb = new StringBuilder();
                        sb.AppendLine("Title: " + b.Title);
                        sb.AppendLine("Battle Date: " + b.BattleDate.ToLocalTime().ToString() + " EST");
                        sb.AppendLine("");
                        sb.AppendLine("Share or Your Battle:");
                        sb.AppendLine("http://shackbattl.es/view-battle/" + b.BattleGUID);
                        sb.AppendLine("");
                        sb.AppendLine("Edit your battle:");
                        sb.AppendLine("http://shackbattl.es/edit-battle/" + b.BattleGUID);

                        SendShackMessage(to, "Your ShackBattle Has Been Created!", sb.ToString());
                    }
                }
            }
            catch
            {
                // swallow this error we don't really care if this doesn't work.. kinda..
            }
        }
    }
}