using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using ShackBattles.Classes;
using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Web;
using System.Web.Http;

namespace ShackBattles.api
{
    public class APIController : ApiController
    {
        [System.Web.Http.HttpGet]
        public List<UpcomingBattleResult> GetUpcomingShackBattles()
        {
            using (SBEntities db = new SBEntities())
            {

                string baseURL = Helper.GetSiteBaseURL();

                var result = (from r in db.GetUpcomingBattlesAllUsers()
                              select new UpcomingBattleResult
                              {
                                  Title = r.Title,
                                  BattleGUID = r.BattleGUID,
                                  CreatorName =  r.CreatorName,
                                  GameSystemName =  r.GameSystemName,
                                   BattleDate= r.BattleDate.ToLocalTime().ToString() + " EST",
                                   Registered = int.Parse(r.Registered.ToString()),
                                   GameName = r.GameName,
                                   RegisterURL = baseURL + "view-battle/" + r.BattleGUID,
                                   Details = r.Details
                              }).ToList();

                return result;
            }
        }

        [System.Web.Http.HttpGet]
        public List<GameSystem> GetGameSystems()
        {
            using (SBEntities db = new SBEntities())
            {
                return db.GetGameSystems().ToList();
            }
        }

        [System.Web.Http.HttpGet]
        public List<SearchResult> ShackBattlesSearch(string query)
        {
            using (SBEntities db = new SBEntities())
            {

                List<SearchResult> result = (from g in db.Games
                                             join s in db.GameSystems on g.GameSystemKey equals s.GameSystemKey

                                             orderby g.GameName
                                             where g.GameName.Contains(query)
                                             select new SearchResult
                                             {
                                                 name = "GAME - " + g.GameName.ToString() + " [" + s.GameSystemName + "]",
                                                 url = "",
                                                 key = g.GameKey,
                                                 systemName = s.GameSystemName
                                             }).Take(5).ToList();

                result = result.Union((from u in db.Users
                                       where u.Username.Contains(query)
                                       orderby u.Username
                                       select new SearchResult
                                       {
                                           name = "USER - " + u.Username.ToString(),
                                           url = "",
                                           key = u.UserKey
                                       }).ToList().Take(5)).ToList();

                foreach (var r in result)
                {
                    if (!string.IsNullOrEmpty(r.systemName))  // returning a game 
                    {
                        r.url = "/game/" + r.key + "/" + Helper.CovertStringToSEO(r.systemName) + "/" + Helper.CovertStringToSEO(r.name);
                    }
                    else
                        r.url = "/player/" + r.key + "/" + Helper.CovertStringToSEO(r.name);
                }


                return result;
            }
        }
        [System.Web.Http.HttpGet]
        public List<Game> GetSystemGames(int id)
        {

            using (SBEntities db = new SBEntities())
            {
                return db.GetSystemGames(id).ToList();
            }
        }

        [System.Web.Http.HttpPost]
        public ApiResult FollowBattle([FromBody]string JSONData)
        {
            JObject json = JObject.Parse(JSONData);
            int UserKey = (int)json["userKey"];
            int GameKey = (int)json["gameKey"];
            bool follow = (Boolean)json["follow"];

            using (SBEntities sb = new SBEntities())
            {
                sb.UpdateGameFollow(UserKey, GameKey, follow);
            }

            return new ApiResult(true, string.Empty, "User is following set to : " + follow.ToString());
        }

        [System.Web.Http.HttpPost]
        public ApiResult JoinBattle(JObject data)
        {
            dynamic json = data;
            int UserKey = (int)json.userKey;
            String battleGUID = json.battleGUID;
            bool joinBattle = (bool)json.joinBattle;

            try
            {
                using (SBEntities db = new SBEntities())
                {
                    int battleKey = db.Battles.Where(w => w.BattleGUID == battleGUID).FirstOrDefault().BattleKey;
                    UserBattle ub = db.UserBattles.Where(w => w.BattleKey == battleKey && w.UsersKey == UserKey).FirstOrDefault();

                    if (joinBattle && ub == null)
                    {
                        ub = new UserBattle();
                        ub.BattleKey = battleKey;
                        ub.UsersKey = UserKey;
                        db.UserBattles.Add(ub);
                        db.SaveChanges();
                        return new ApiResult(true, string.Empty, "User added to battle " + battleGUID);
                    }
                    else if (!joinBattle && ub != null)
                    {
                        db.UserBattles.Remove(ub);
                        db.SaveChanges();
                        return new ApiResult(true, string.Empty, "User removed from battle " + battleGUID);
                    }
                }
            }
            catch (Exception ex)
            {
                return new ApiResult(false, string.Empty, ex.Message);
            }

            return new ApiResult(false, string.Empty, "No changes where made.");
        }

        [System.Web.Http.HttpPost]
        public Battle SaveBattle([FromBody]JObject data)
        {
            using (SBEntities db = new SBEntities())
            {
                dynamic json = data;
                try
                {

                    string battleGUID = (string)json["BattleGUID"];

                    // this should handle DST
                    TimeZoneInfo est = TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time");
                    DateTime battleDate = TimeZoneInfo.ConvertTimeToUtc(DateTime.Parse((string)json["BattleDate"]), est);
                    Battle b;
                    bool newBattle = false;
                    if (!string.IsNullOrEmpty(battleGUID))
                    {
                        b = db.Battles.Where(w => w.BattleGUID == battleGUID).FirstOrDefault();
                    }
                    else
                    {
                        newBattle = true;
                        b = new Battle();
                        b.BattleGUID = Guid.NewGuid().ToString();
                        b.DateCreated = DateTime.UtcNow;
                        db.Battles.Add(b);
                    }

                    b.GameKey = (int)json["GameKey"];
                    b.Title = (string)json["Title"];
                    b.BattleDate = battleDate;
                    b.Details = (string)json["Details"];
                    b.CreatorKey = (int)json["CreatorKey"];

                    db.SaveChanges();

                    // The user is added to their own battle
                    if (newBattle)
                    {
                        UserBattle ub = db.UserBattles.Where(w => w.UsersKey == b.CreatorKey && w.BattleKey == b.BattleKey).FirstOrDefault();
                        if (ub == null)
                        {
                            ub = new UserBattle();
                            ub.UsersKey = b.CreatorKey;
                            ub.BattleKey = b.BattleKey;
                            db.UserBattles.Add(ub);
                            db.SaveChanges();
                        }
                        try
                        {
                            User u = db.Users.Where(w => w.UserKey == b.CreatorKey).FirstOrDefault();
                            if (u != null)
                                ShackNewsHelper.SendBattleCreation(u.Username, b.BattleKey);
                        }
                        catch
                        {

                        }

                    }

                    return b;
                }
                catch (Exception)
                {
                    // TODO: handle
                }
                return null;
            }
        }
    }
}