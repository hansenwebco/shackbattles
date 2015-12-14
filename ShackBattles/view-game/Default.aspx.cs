using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.view_game
{
    public partial class Default : System.Web.UI.Page
    {
        protected string _gameImage = string.Empty;
        protected int _userKey = 0;
        protected int _followCount = 0;
        protected bool _following = false;
        protected int _gameKey = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            using (SBEntities db = new SBEntities())
            {
                UserSession user = Helper.GetUserSession();

                _gameKey = int.Parse(Page.RouteData.Values["id"].ToString());
                _userKey = user.userKey;

                GameDetails gd = db.GetGame(_gameKey);
                LiteralGameName.Text = gd.Game.GameName;
                LiteralGameDetails.Text = Helper.FormatTextToHtml(gd.Game.OverView);
                try
                {
                    LiteralReleaseDate.Text = ((DateTime)gd.Game.ReleaseDate).ToShortDateString();
                }
                catch
                {
                    LiteralReleaseDate.Text = "Not Set";
                }
                LiteralGameSystemName.Text = gd.GameSystemName;
                _gameImage = gd.Game.CoverImage;

                GameFollowerDetails gfd = db.GetGameFollowerDetails(user.userKey, _gameKey);
                _followCount = gfd.FollowerCount;
                _following = gfd.UserFollowing;

                RepeaterUpcomingBattles.DataSource = db.GetGameUpcomingBattles(_gameKey, _userKey).ToList();
                RepeaterUpcomingBattles.DataBind();

                RepeaterUpcomingBattles.Visible = RepeaterUpcomingBattles.Items.Count > 0;
                LabelNoBattles.Visible = RepeaterUpcomingBattles.Items.Count == 0;


            }
        }
    }
}