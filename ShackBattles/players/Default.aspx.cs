using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.players
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (SBEntities db = new SBEntities())
            {
                int userKey = int.Parse(Page.RouteData.Values["UserKey"].ToString());

                User u = db.GetUser(userKey);

                LiteralShackName.Text = u.Username;
                LiteralProfileName.Text = u.Username;
                LiteralMemberSince.Text = u.DateCreated.ToShortDateString();
                LiteralGamerTag.Text = u.GamerTag;
                LiteralPSNID.Text = u.PSNID;
                LiteralNintendoID.Text = u.NintendoAccount;
                LiteralBattleNet.Text = u.BattleNet;
                LiteralSteam.Text = u.SteamAccount;
                LiteralOrigin.Text = u.OriginAccount;
                LabelBio.Text = u.Bio;
            }
        }
    }
}