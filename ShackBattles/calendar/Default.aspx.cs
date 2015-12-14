using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShackBattles.calendar
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<CalEvent> events = new List<CalEvent>();
            CalEvent ev = new CalEvent();
            ev.start = DateTime.Parse("12/5/2015 8:00 PM");
            ev.end = DateTime.Parse("12/5/2015 11:59 PM");
            ev.name = "Shack Battle 1";
            ev.id = "1";
            events.Add(ev);

             ev = new CalEvent();
            ev.start = DateTime.Parse("12/17/2015 7:00 PM");
            ev.end = DateTime.Parse("12/17/2015 11:00 PM");
            ev.name = "Shack Battle 2";
            ev.id = "2";
            events.Add(ev);


            DayPilotCalendar.DataSource = events;
            DayPilotCalendar.DataStartField = "start";
            DayPilotCalendar.DataEndField = "end";
            DayPilotCalendar.DataTextField = "name";
            DayPilotCalendar.DataIdField = "id";
            
            DayPilotCalendar.DataBind();
            


        }

        public class CalEvent
        {
            public string id { get; set; }
            public DateTime start { get; set; }
            public DateTime end { get; set; }
            public String name { get; set; }
        }

    }
}