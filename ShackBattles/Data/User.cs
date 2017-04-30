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
    
    public partial class User
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public User()
        {
            this.UserBattles = new HashSet<UserBattle>();
            this.UserFollows = new HashSet<UserFollow>();
            this.Battles = new HashSet<Battle>();
        }
    
        public int UserKey { get; set; }
        public string Username { get; set; }
        public System.DateTime LastLogin { get; set; }
        public System.DateTime DateCreated { get; set; }
        public string GamerTag { get; set; }
        public string PSNID { get; set; }
        public string BattleNet { get; set; }
        public string SteamAccount { get; set; }
        public string OriginAccount { get; set; }
        public string Bio { get; set; }
        public string NintendoAccount { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserBattle> UserBattles { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserFollow> UserFollows { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Battle> Battles { get; set; }
    }
}
