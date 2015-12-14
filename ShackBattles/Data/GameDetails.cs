using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShackBattles.Data
{
    public class GameDetails
    {
        public Game Game { get; set; }
        public String GameSystemName { get; set; }
        public bool Following { get; set; }
    }
}