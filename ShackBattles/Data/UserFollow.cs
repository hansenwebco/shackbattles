//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ShackBattles.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class UserFollow
    {
        public int UsersFollowsKey { get; set; }
        public int UserKey { get; set; }
        public int GameKey { get; set; }
        public bool Following { get; set; }
    
        public virtual Game Game { get; set; }
        public virtual User User { get; set; }
    }
}
