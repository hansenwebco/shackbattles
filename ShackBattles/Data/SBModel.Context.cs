﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class SBEntities : DbContext
    {
        public SBEntities()
            : base("name=SBEntities")
        {
            this.Configuration.LazyLoadingEnabled = false;
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Battle> Battles { get; set; }
        public virtual DbSet<Game> Games { get; set; }
        public virtual DbSet<GameSystem> GameSystems { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<UserBattle> UserBattles { get; set; }
        public virtual DbSet<UserFollow> UserFollows { get; set; }
        public virtual DbSet<User> Users { get; set; }
    
        public virtual ObjectResult<GetGameUpcomingBattles_Result> GetGameUpcomingBattles(Nullable<int> gameKey, Nullable<int> userKey)
        {
            var gameKeyParameter = gameKey.HasValue ?
                new ObjectParameter("GameKey", gameKey) :
                new ObjectParameter("GameKey", typeof(int));
    
            var userKeyParameter = userKey.HasValue ?
                new ObjectParameter("UserKey", userKey) :
                new ObjectParameter("UserKey", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetGameUpcomingBattles_Result>("GetGameUpcomingBattles", gameKeyParameter, userKeyParameter);
        }
    
        public virtual ObjectResult<GetUpcomingBattles_Result> GetUpcomingBattles(Nullable<int> userKey)
        {
            var userKeyParameter = userKey.HasValue ?
                new ObjectParameter("UserKey", userKey) :
                new ObjectParameter("UserKey", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetUpcomingBattles_Result>("GetUpcomingBattles", userKeyParameter);
        }
    
        public virtual ObjectResult<GetUpcomingUserBattles_Result> GetUpcomingUserBattles(Nullable<int> userKey)
        {
            var userKeyParameter = userKey.HasValue ?
                new ObjectParameter("UserKey", userKey) :
                new ObjectParameter("UserKey", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetUpcomingUserBattles_Result>("GetUpcomingUserBattles", userKeyParameter);
        }
    
        public virtual ObjectResult<GetUserUpcomingFollowedBattles_Result> GetUserUpcomingFollowedBattles(Nullable<int> userKey)
        {
            var userKeyParameter = userKey.HasValue ?
                new ObjectParameter("UserKey", userKey) :
                new ObjectParameter("UserKey", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetUserUpcomingFollowedBattles_Result>("GetUserUpcomingFollowedBattles", userKeyParameter);
        }
    
        public virtual ObjectResult<GetUpcomingBattlesAllUsers_Result> GetUpcomingBattlesAllUsers()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetUpcomingBattlesAllUsers_Result>("GetUpcomingBattlesAllUsers");
        }
    }
}