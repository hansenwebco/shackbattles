using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.manage_battle
{
    public partial class Default : System.Web.UI.Page
    {
        protected string _battleGUID = string.Empty;
        protected int _userKey = 0;
        protected int _creatorKey = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserSession user = Helper.GetUserSession();
            _userKey = user.userKey;

            UserControlShackTags.TargetControlID = TextBoxDetails.ClientID;

            if (!IsPostBack)
            {
                using (SBEntities db = new SBEntities())
                {

                    // set hours
                    DropDownListHours.DataSource = Enumerable.Range(0, 96).Select(i => DateTime.Today.AddHours(0).AddMinutes(-1 * ((i + 1) * 15)).ToString("hh:mm tt")).ToList();
                    DropDownListHours.DataBind();

                    DropDownListSystem.DataSource = db.GetGameSystems();
                    DropDownListSystem.DataValueField = "GameSystemKey";
                    DropDownListSystem.DataTextField = "GameSystemName";
                    DropDownListSystem.DataBind();
                    DropDownListSystem.Items.Insert(0, new ListItem("--- SELECT SYSTEM ---", "0"));

                    _battleGUID = (string)Page.RouteData.Values["BattleGUID"];
                    if (!string.IsNullOrEmpty(_battleGUID))
                    {
                        var battleInfo = (from b in db.Battles
                                          join g in db.Games on b.GameKey equals g.GameKey
                                          join gs in db.GameSystems on g.GameSystemKey equals gs.GameSystemKey
                                          where b.BattleGUID == _battleGUID
                                          select new { b.BattleGUID, b.Title, b.Details, b.GameKey, b.CreatorKey, gs.GameSystemKey, b.BattleDate }).FirstOrDefault();

                        if (battleInfo != null)
                        {
                            if (battleInfo.CreatorKey != user.userKey) // shoudl not be editing
                                Response.Redirect("~/home", true);

                            if (battleInfo.CreatorKey == _userKey)
                                ButtonDelete.Visible = true;
                        }

                        DropDownListSystem.Items.FindByValue(battleInfo.GameSystemKey.ToString()).Selected = true;
                        DropDownListGames.DataSource = db.Games.Where(w => w.GameSystemKey == battleInfo.GameSystemKey).ToList();
                        DropDownListGames.DataValueField = "GameKey";
                        DropDownListGames.DataTextField = "GameName";
                        DropDownListGames.DataBind();
                        DropDownListGames.Items.FindByValue(battleInfo.GameKey.ToString()).Selected = true;

                        DateTime battleDate = battleInfo.BattleDate.ToLocalTime();

                        TextBoxDate.Text = battleDate.ToString("MM/dd/yyyy");
                        DropDownListHours.Items.FindByValue(battleDate.ToString("hh:mm tt")).Selected = true;

                        TextBoxTitle.Text = battleInfo.Title;
                        TextBoxDetails.Text = battleInfo.Details;

                        PanelShareURL.Visible = true;
                        TextBoxShareURL.Text = "http://" + HttpContext.Current.Request.Url.Host + "/view-battle/" + battleInfo.BattleGUID;
                    }
                }
            }
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            String battleGUID = (string)Page.RouteData.Values["BattleGUID"];
            try
            {
                Helper.DeleteShackBattle(battleGUID);
                Response.Redirect("~/home", true);
            }
            catch (Exception)
            {
                // TODO: swallow this for now.
            }

        }
    }
}