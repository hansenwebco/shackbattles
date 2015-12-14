using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShackBattles.Data
{
    public partial class SBEntities
    {
        public List<GameSystem> GetGameSystems()
        {
            return this.GameSystems.OrderBy(o => o.GameSystemName).ToList();
        }
        public List<Game> GetSystemGames(int gameSystemKey)
        {
            return this.Games.Where(w => w.GameSystemKey == gameSystemKey).OrderBy(o => o.GameName).ToList();
        }
        public List<GameDetails> GetAllGames()
        {
            var result = (from g in this.Games
                          join gs in this.GameSystems on g.GameSystemKey equals gs.GameSystemKey
                          orderby g.GameName ascending
                          select new GameDetails { Game = g, GameSystemName = gs.GameSystemName }).ToList();

            return result;
        }
        public GameDetails GetGame(int gameKey)
        {
            GameDetails result = (from g in this.Games
                                  join gs in this.GameSystems on g.GameSystemKey equals gs.GameSystemKey
                                  where g.GameKey == gameKey
                                  select new GameDetails { Game = g, GameSystemName = gs.GameSystemName }).FirstOrDefault();

            return result;
        }

        public List<GameDetails> GetUserFollowedGames(int userKey)
        {
            List<GameDetails> result = (from g in this.Games
                                        join uf in this.UserFollows on g.GameKey equals uf.GameKey
                                        join gs in this.GameSystems on g.GameSystemKey equals gs.GameSystemKey
                                        where uf.UserKey == userKey && uf.Following == true
                                        select new GameDetails { Game = g, GameSystemName = gs.GameSystemName, Following = uf.Following }).ToList();

            return result;
        }
        public GameFollowerDetails GetGameFollowerDetails(int userKey, int gameKey)
        {
            GameFollowerDetails gfd = new GameFollowerDetails();
            gfd.FollowerCount = this.UserFollows.Where(w => w.GameKey == gameKey && w.Following == true).Count();
            var result = this.UserFollows.Where(w => w.GameKey == gameKey && w.UserKey == userKey).FirstOrDefault();
            if (result == null)
                gfd.UserFollowing = false;
            else
                gfd.UserFollowing = result.Following;

            return gfd;
        }

        public BattleDetails GetBattle(string battleGUID)
        {
            BattleDetails bt = new BattleDetails();
            bt.Battle = this.Battles.Where(w => w.BattleGUID.ToString() == battleGUID).FirstOrDefault();
            bt.BoxImage = this.Games.Where(w => w.GameKey == bt.Battle.GameKey).FirstOrDefault().GameName;
            return bt;
        }
 
        public bool UpdateGameFollow(int userKey, int gameKey, bool followed)
        {
            try
            {
                UserFollow uf = this.UserFollows.Where(w => w.GameKey == gameKey && w.UserKey == userKey).FirstOrDefault();
                if (uf == null)
                {
                    uf = new UserFollow();
                    uf.UserKey = userKey;
                    uf.GameKey = gameKey;
                    this.UserFollows.Add(uf);
                }
                uf.Following = followed;
                this.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public User GetUser(int userKey)
        {
            return this.Users.Where(w => w.UserKey == userKey).FirstOrDefault();
        }
    }
}