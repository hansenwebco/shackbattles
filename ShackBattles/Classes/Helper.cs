using ShackBattles.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace ShackBattles.Classes
{
    public static class Helper
    {
        static Random rnd = new Random((int)System.DateTime.Now.Ticks);

        public static string GetBaseAPIURl()
        {
            return ConfigurationManager.AppSettings["APIBasePath"];
        }
        public static string GetSiteBaseURL()
        {
            return ConfigurationManager.AppSettings["BaseSiteURL"];
        }
        public static int GetRandomNumber(int minimumValue, int maximumValue)
        {
            return rnd.Next(minimumValue, maximumValue + 1);
        }
        public static string CovertStringToSEO(string text)
        {
            string update = Regex.Replace(text, "-", " "); // preserve already existing dashes by making them spaces.. they'll go back
            update = Regex.Replace(update, "[^a-zA-Z0-9 ]+", "").Trim().ToLower(); // only numbers letters and spaces
            update = Regex.Replace(update, "\\s{2,}", " "); // remove extra spaces
            update = Regex.Replace(update, "\\s", "-"); // replaces spaces with dashes

            return update;
        }
        public static UserSession GetUserSession()
        {
            if (HttpContext.Current.Session["user"] == null)
            {
                HttpContext.Current.Response.Redirect("~/?returnUrl=" + HttpContext.Current.Request.Url.PathAndQuery, true);
            }
            UserSession us = (UserSession)HttpContext.Current.Session["user"];
            return us;
        }
        public static void ResizeImage(string originalFile, string newFile, int newWidth, int maxHeight, bool onlyResizeIfWider)
        {
            Image fullsizeImage = Image.FromFile(originalFile);

            // Prevent using images internal thumbnail
            fullsizeImage.RotateFlip(RotateFlipType.Rotate180FlipNone);
            fullsizeImage.RotateFlip(RotateFlipType.Rotate180FlipNone);

            if (onlyResizeIfWider)
            {
                if (fullsizeImage.Width <= newWidth)
                {
                    newWidth = fullsizeImage.Width;
                }
            }

            int newHeight = fullsizeImage.Height * newWidth / fullsizeImage.Width;
            if (newHeight > maxHeight)
            {
                // Resize with height instead
                newWidth = fullsizeImage.Width * maxHeight / fullsizeImage.Height;
                newHeight = maxHeight;
            }

            Image newImage = fullsizeImage.GetThumbnailImage(newWidth, newHeight, null, IntPtr.Zero);

            // Clear handle to original file so that we can overwrite it if necessary
            fullsizeImage.Dispose();

            // Save resized picture
            newImage.Save(newFile);
        }
        public static string FormatTextToHtml(string text)
        {
            try
            {
                return text.Replace("\n", "<br/>");
            }
            catch
            {
                return text;
            }
        }
        public static void DeleteShackBattle(string battleGUID)
        {
            using (SBEntities db = new SBEntities())
            {
                Battle b = db.Battles.Where(w => w.BattleGUID == battleGUID).FirstOrDefault();
                if (b != null)
                {
                    b.Deleted = true;
                    db.SaveChanges();
                    User u = db.Users.Where(w => w.UserKey == b.CreatorKey).FirstOrDefault();
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("Your ShackBattle titled " + b.Title + " was deleted succesfully.");
                    ShackNewsHelper.SendShackMessage(u.Username, "Your ShackBattle was Deleted", sb.ToString());
                }
            }
        }

        public static string StartTimeToWords(DateTime startTime)
        {
            // < minute = now
            // < hour = minutes
            // < 24 hours = hours + minutes
            // > 24 hours = days + hours

            string started = string.Empty;
            TimeSpan span = DateTime.UtcNow - startTime;
            if (span.Seconds > 0)
                started = " ago";

            int seconds = Math.Abs((int)span.TotalSeconds);
            int minutes = Math.Abs((int)span.TotalMinutes);
            int hours = Math.Abs((int)span.TotalHours);
            int days = Math.Abs((int)span.TotalDays);
            int weeks = Math.Abs((int)span.TotalDays / 7);

            if (seconds < 60)
                return "Now!";
            else if (minutes < 60)
                return minutes.ToString() + "m " + started;
            else if (hours < 24)
                return hours.ToString() + "h " + (minutes - hours * 60) + " m " + started;
            else if (hours > 24 && weeks < 1)
                return days.ToString() + "d " + (hours - days * 24) + "h " + started;
            else
                return weeks.ToString() + "w " + (days - (weeks * 7)) + "d " + started;
        }
    }
}