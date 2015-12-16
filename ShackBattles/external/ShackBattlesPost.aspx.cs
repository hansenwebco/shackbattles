using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.external
{
    public partial class ShackBattlesPost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String baseURL = Helper.GetSiteBaseURL();

            Response.ContentType = "text/plain";

            StringBuilder sb = new StringBuilder();

            using (SBEntities db = new SBEntities())
            {
                List<GetUpcomingBattlesAllUsers_Result> upcoming = db.GetUpcomingBattlesAllUsers().ToList();
                if (upcoming.Count > 0)
                {
                    foreach (var battle in upcoming)
                    {
                        sb.AppendLine("b[b{" + battle.Title + "}b]b");
                        sb.AppendLine("Playing y{" + battle.GameName + "}y on the y{" + battle.GameSystemName + "}y at b[" + battle.BattleDate.ToLocalTime().ToString("MM/dd/yyyy h:mm") + " EST]b");
                        sb.AppendLine("Created by g{" + battle.CreatorName + "}g");
                        sb.AppendLine("Details and Enlistment : " + baseURL + "view-battle/" + battle.BattleGUID + "/");
                        sb.AppendLine();
                    }
                }
                else
                {
                    List<string> quotes = new List<string>();
                    quotes.Add("There was never a good war, or a bad peace. - y{Benjamin Franklin}y");
                    quotes.Add("Let him who desires peace prepare for war. - y{Publius Flavius Vegetius Renatus}y");
                    quotes.Add("Know thy self, know thy enemy. A thousand battles, a thousand victories. - y{Sun Tzu}y");
                    quotes.Add("The two most powerful warriors are patience and time. - y{Leo Tolstoy}y");
                    quotes.Add("God created war so that Americans would learn geography. - y{Mark Twain}y");
                    quotes.Add("War is peace. Freedom is slavery. Ignorance is strength. - y{George Orwell}y");
                    quotes.Add("The true soldier fights not because he hates what is in front of him, but because he loves what is behind him. - y{G.K. Chesterton}y");
                    quotes.Add("Only the dead have seen the end of war. - y{Plato}y");
                    quotes.Add("Veni, vidi, vici. - y{Gaius Iulius Caesar}y");
                    quotes.Add("Cry havoc and let slip the dogs of war! - y{General Chang}y");
                    quotes.Add("May God have mercy for my enemies because I won't. - y{George S. Patton Jr.}y");
                    quotes.Add("You cannot simultaneously prevent and prepare for war. - y{Albert Einstein}y");
                    quotes.Add("Sometime they'll give a war and nobody will come. - y{Carl Sandburg}y");
                    quotes.Add("Either war is obsolete or men are. - y{R. Buckminster Fuller}y");
                    quotes.Add("Sometime they'll give a war and nobody will come. - y{Carl Sandburg}y");
                    quotes.Add("It is well that war is so terrible - otherwise we would grow too fond of it. - y{Robert E. Lee}y");
                    quotes.Add("The art of war is simple enough. Find out where your enemy is. Get at him as soon as you can. Strike him as hard as you can, and keep moving on. - y{Ulysses S. Grant}y");
                    quotes.Add("Wars are, of course, as a rule to be avoided; but they are far better than certain kinds of peace. - y{Theodore Roosevelt}y");
                    quotes.Add("You can't say that civilization don't advance, however, for in every war they kill you in a new way. - y{Will Rogers}y");
                    quotes.Add("The real and lasting victories are those of peace and not of war. - y{Ralph Waldo Emerson}y");
                    quotes.Add("Jaw jaw is better than war war. - y{Winston Churchill}y");
                    quotes.Add("In time of war the loudest patriots are the greatest profiteers. - y{August Bebel}y");
                    quotes.Add("We make war that we may live in peace. - y{Aristotle}y");
                    quotes.Add("War is too serious a matter to entrust to military men. - y{Georges Clemenceau}y");
                    quotes.Add("There is nothing so likely to produce peace as to be well prepared to meet the enemy. - y{George Washington}y");
                    quotes.Add("Either war is obsolete or men are. - y{R. Buckminster Fuller}y");
                    quotes.Add("Everyone's a pacifist between wars. It's like being a vegetarian between meals. - y{Colman McCarthy}y");
                    quotes.Add("A soldier will fight long and hard for a bit of colored ribbon. - y{Napoleon}y");
                    quotes.Add("War! that mad game the world so loves to play. - y{Jonathan Swift}y");
                    quotes.Add("War is the only game in which it doesn't pay to have the home-court advantage.  - y{Dick Motta}y");
                    quotes.Add("I destroy my enemies when I make them my friends. - y{Abraham Lincoln}y");
                    quotes.Add("I don't know whether war is an interlude during peace, or peace an interlude during war. - y{Georges Clemenceau}y");

                    int day = DateTime.Today.Day;
                    string quote = quotes[day-1];

                    sb.AppendLine("b[r{===}r NO BATTLES CURRENTLY SCHEDULED r{===}r]b");
                    sb.AppendLine();
                    sb.AppendLine(quote);
                    sb.AppendLine();
                }

                sb.AppendLine("Create your own battles at " + baseURL);

            }

            Response.Write(sb.ToString());

        }
    }
}