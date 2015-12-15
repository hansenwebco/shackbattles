using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Routing;
using System.Web.Http.WebHost;
using System.Web.Http;
using System.Web.Optimization;

namespace ShackBattles
{
    public class Global : System.Web.HttpApplication
    {

        void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("HomeRoute", "home/", "~/home/default.aspx");
            routes.MapPageRoute("CreateBattle", "create-battle/", "~/manage-battle/default.aspx");
            routes.MapPageRoute("EditBattle", "edit-battle/{BattleGUID}", "~/manage-battle/default.aspx");
            routes.MapPageRoute("ViewGameRoute","game/{id}/{GameSystem}/{gamename}","~/view-game/default.aspx");
            routes.MapPageRoute("ViewBattle", "view-battle/{BattleGUID}", "~/view-battle/default.aspx");
            routes.MapPageRoute("ViewPlayer", "player/{userKey}/{playerName}", "~/players/default.aspx");
           
            routes.MapHttpRoute(
            name: "Default2Api",
                   routeTemplate: "{controller}/{action}/{id}",
                   defaults: new { id = RouteParameter.Optional }
                   );
        }


        protected void Application_Start(object sender, EventArgs e)
        {
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
            GlobalConfiguration.Configuration.Formatters.Remove(GlobalConfiguration.Configuration.Formatters.XmlFormatter);

            RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}