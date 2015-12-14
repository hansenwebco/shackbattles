using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShackBattles.Data
{
    public class BattleDetails
    {
        public Battle Battle { get; set; }
        public string BoxImage { get; set; }
        public List<User> Players { get; set; }
    }
}
