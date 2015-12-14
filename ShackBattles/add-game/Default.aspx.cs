using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace ShackBattles.add_game
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.EnableViewState = true;
            if (!IsPostBack)
            {
                using (SBEntities db = new SBEntities())
                {
                    DropDownListSystem.DataSource = db.GetGameSystems();
                    DropDownListSystem.DataValueField = "GameSystemKey";
                    DropDownListSystem.DataTextField = "GameSystemName";
                    DropDownListSystem.DataBind();
                    DropDownListSystem.Items.Insert(0, new ListItem("--- SELECT SYSTEM ---", "0"));
                }
            }
        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            try
            {
                using (SBEntities db = new SBEntities())
                {
                    int systemID = int.Parse(DropDownListSystem.SelectedValue);
                    string platform = db.GameSystems.Where(w => w.GameSystemKey == systemID).FirstOrDefault().GameDBPlatformID;
                    string search = "http://thegamesdb.net/api/GetGamesList.php?name=" + HttpUtility.UrlEncode(TextBoxSearch.Text) + "&platform=" + HttpUtility.UrlEncode(platform);

                    MemoryStream stream = new MemoryStream();
                    XmlTextWriter writer = new XmlTextWriter(stream, Encoding.UTF8);
                    XmlDocument doc = new XmlDocument();
                    doc.Load(search);

                    List<GameDBGamesListResult> searchResults = new List<GameDBGamesListResult>();
                    XmlNodeList games = doc.SelectNodes("Data/Game");
                    foreach (XmlNode result in games)
                    {
                        GameDBGamesListResult game = new GameDBGamesListResult();
                        game.Title = result.SelectSingleNode("GameTitle").InnerText;
                        game.ReleaseDate = result.SelectSingleNode("ReleaseDate").InnerText;
                        game.id = result.SelectSingleNode("id").InnerText;
                        searchResults.Add(game);
                    }
                    RepeaterResults.DataSource = searchResults;
                    RepeaterResults.DataBind();
                }
            }
            catch (Exception ex)
            {
                SetError("There was an error searching GameDb.net.  This happens from time to time, you might want to search again.<br/><br/>" + ex.Message);
            }

        }
        private void SetError(string message)
        {
            PanelError.Visible = true;
            LiteralError.Text = message;
        }
        protected void AddGame_Command(object sender, CommandEventArgs e)
        {
            int gameID = int.Parse(e.CommandArgument.ToString());
            using (SBEntities db = new SBEntities())
            {
                Game g = db.Games.Where(w => w.GamesDbId == gameID).FirstOrDefault();
                if (g != null)
                {
                    // show error
                    SetError("This game is already in the system.");
                    return;
                }
                else
                {
                    g = new Game();
                }

                // if not call and get game details
                string search = "http://thegamesdb.net/api/GetGame.php?id=" + gameID.ToString();

                MemoryStream stream = new MemoryStream();
                XmlTextWriter writer = new XmlTextWriter(stream, Encoding.UTF8);
                XmlDocument doc = new XmlDocument();
                doc.Load(search);

                List<GameDBGamesListResult> searchResults = new List<GameDBGamesListResult>();
                XmlNode games = doc.SelectSingleNode("Data/Game");
                g.GameSystemKey = int.Parse(DropDownListSystem.SelectedValue);
                g.GameName = games.SelectSingleNode("GameTitle").InnerText;

                string boxArtPath = "";
                try
                {
                    g.OverView = games.SelectSingleNode("Overview").InnerText;
                }
                catch { g.OverView = ""; }
                g.GamesDbId = int.Parse(games.SelectSingleNode("id").InnerText);
                try
                {
                    g.ReleaseDate = DateTime.Parse(games.SelectSingleNode("ReleaseDate").InnerText);
                }
                catch
                {
                    g.ReleaseDate = null;
                }
                try
                {
                    XmlNode images = games.SelectSingleNode("Images/boxart[@side='front']");
                    g.CoverImage = Path.GetFileName(images.InnerText);
                    boxArtPath = images.InnerText;
                }
                catch
                {
                    g.CoverImage = "missing.jpg";
                }

                db.Games.Add(g);
                db.SaveChanges();

                try
                {
                    // download and store cover
                    if (!string.IsNullOrEmpty(g.CoverImage) && !string.IsNullOrEmpty(boxArtPath) && g.CoverImage != "missing.jpg")
                    {
                        using (WebClient wc = new WebClient())
                        {
                            string imageUrl = "http://thegamesdb.net/banners/" + boxArtPath;
                            wc.DownloadFile(imageUrl, Server.MapPath("~") + "images/boxart/" + Path.GetFileName(imageUrl));

                            try
                            {
                                Helper.ResizeImage(Server.MapPath("~") + "images/boxart/" + Path.GetFileName(imageUrl), Server.MapPath("~") + "images/boxart/" + Path.GetFileName(imageUrl), 300, 423, false);
                            }
                            catch { }
                        }
                    }
                }
                catch { 
                    // image grab failed
                    g.CoverImage = "missing.jpg";
                    db.SaveChanges();
                }

                // done
                PanelMain.Visible = false;
                PanelDone.Visible = true;
            }
        }
    }
}