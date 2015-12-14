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
    
    public partial class Game
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Game()
        {
            this.Battles = new HashSet<Battle>();
            this.UserFollows = new HashSet<UserFollow>();
        }
    
        public int GameKey { get; set; }
        public int GameSystemKey { get; set; }
        public string GameName { get; set; }
        public Nullable<System.DateTime> ReleaseDate { get; set; }
        public string CoverImage { get; set; }
        public string OverView { get; set; }
        public Nullable<int> GamesDbId { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Battle> Battles { get; set; }
        public virtual GameSystem GameSystem { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserFollow> UserFollows { get; set; }
    }
}
