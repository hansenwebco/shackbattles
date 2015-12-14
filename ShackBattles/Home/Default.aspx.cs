using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.Home
{
    public partial class Default : System.Web.UI.Page
    {
        protected int _userKey = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            UserSession us = Helper.GetUserSession();
            _userKey = us.userKey;

            using (SBEntities db = new SBEntities())
            {
                RepeaterFollowedGames.DataSource = db.GetUserFollowedGames(us.userKey);
                RepeaterFollowedGames.DataBind();
                RepeaterFollowedGames.Controls[RepeaterFollowedGames.Controls.Count - 1].FindControl("LabelEmptyFollowing").Visible = RepeaterFollowedGames.Items.Count == 0;

                RepeaterUserRegisteredBattles.DataSource = db.GetUpcomingUserBattles(us.userKey);
                RepeaterUserRegisteredBattles.DataBind();
                RepeaterUserRegisteredBattles.Controls[RepeaterUserRegisteredBattles.Controls.Count - 1].FindControl("LabelRegisteredBattles").Visible = RepeaterUserRegisteredBattles.Items.Count == 0;
                

                RepeaterUpcomingBattlesYouFollow.DataSource = db.GetUserUpcomingFollowedBattles(us.userKey);
                RepeaterUpcomingBattlesYouFollow.DataBind();
                RepeaterUpcomingBattlesYouFollow.Controls[RepeaterUpcomingBattlesYouFollow.Controls.Count - 1].FindControl("LabelUpcomingBattlesYouFollow").Visible = RepeaterUpcomingBattlesYouFollow.Items.Count == 0;
                
               
            }
        }
    }
}