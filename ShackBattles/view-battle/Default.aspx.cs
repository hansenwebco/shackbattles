using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.view_battle
{
    public partial class Default : System.Web.UI.Page
    {
        protected string _boxArt = string.Empty;
        protected int _userKey = 0;
        protected string _battleGUID = string.Empty;
        protected int _joined = -1;
        protected int _creatorKey = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserSession us = Helper.GetUserSession();
            _userKey = us.userKey;

            string BattleGUID = (string)Page.RouteData.Values["BattleGUID"];
            using (SBEntities db = new SBEntities())
            {
                var battleDetails = (from b in db.Battles
                                     join g in db.Games on b.GameKey equals g.GameKey
                                     where b.BattleGUID == BattleGUID
                                     select new { b.Title, b.BattleDate, b.CreatorKey, b.Details, g.GameName, g.CoverImage, b.BattleGUID }).FirstOrDefault();

                var players = (from u in db.Users
                               join ub in db.UserBattles on u.UserKey equals ub.UsersKey
                               join b in db.Battles on ub.BattleKey equals b.BattleKey
                               where b.BattleGUID == BattleGUID
                               select new { u.Username, b.CreatorKey, u.UserKey }).ToList();


                LiteralBattleTitle.Text = battleDetails.Title;
                LiteralBattleDateTime.Text = battleDetails.BattleDate.ToLocalTime().ToString();
                LiteralBattleDetails.Text = battleDetails.Details;
                LiteralBattleLink.Text = "http://" + HttpContext.Current.Request.Url.Host + "/view-battle/" + BattleGUID;

                _creatorKey = battleDetails.CreatorKey;
                _boxArt = battleDetails.CoverImage;
                _battleGUID = battleDetails.BattleGUID;
                _joined = players.Count(w => w.UserKey == _userKey);

                RepeaterEnlisted.DataSource = players;
                RepeaterEnlisted.DataBind();
            }
        }
    }
}