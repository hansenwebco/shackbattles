using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.find_battle
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
                RepeaterUpcomingBattles.DataSource = db.GetUpcomingBattles(_userKey);
                RepeaterUpcomingBattles.DataBind();

                RepeaterGames.DataSource = db.GetAllGames();
                RepeaterGames.DataBind();
            }


        }
    }
}