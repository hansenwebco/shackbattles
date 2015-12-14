using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShackBattles.Data
{
    public class UpcomingBattleResult
    {
        public string Title { get; set; }
        public string BattleGUID { get; set; }
        public string GameName { get; set; }
        public string GameSystemName { get; set; }
        public string BattleDate { get; set; }
        public int Registered { get; set; }
        public string CreatorName { get; set; }
        public string RegisterURL { get; set; }
        public string Details { get; set; }
    }
}