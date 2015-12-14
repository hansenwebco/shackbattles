using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.account
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserControlShackTags.TargetControlID = TextBoxBio.ClientID;
            if (!IsPostBack)
            {
                using (SBEntities db = new SBEntities())
                {
                    UserSession uc = Helper.GetUserSession();
                    User u = db.GetUser(uc.userKey);

                    TextBoxGamerTag.Text = u.GamerTag;
                    TextBoxPSN.Text = u.PSNID;
                    TextBoxBattleNet.Text = u.BattleNet;
                    TextBoxSteam.Text = u.SteamAccount;
                    TextBoxOrigin.Text = u.OriginAccount;
                    TextBoxBio.Text = u.Bio;

                    var userBattles = (from b in db.Battles
                                       where b.CreatorKey == uc.userKey
                                       select new { b.Title,b.BattleGUID,b.BattleDate }).Take(10).ToList();


                    RepeaterPreviousBattles.DataSource = userBattles;
                    RepeaterPreviousBattles.DataBind();
                }
            }
        }

        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            using (SBEntities db = new SBEntities())
            {
                UserSession uc = Helper.GetUserSession();
                User u = db.GetUser(uc.userKey);

                u.GamerTag = TextBoxGamerTag.Text.Trim();
                u.PSNID = TextBoxPSN.Text.Trim();
                u.BattleNet = TextBoxBattleNet.Text.Trim();
                u.SteamAccount = TextBoxSteam.Text.Trim();
                u.OriginAccount = TextBoxOrigin.Text.Trim();
                u.Bio = TextBoxBio.Text.Trim();

                db.SaveChanges();
            }
        }
    }
}