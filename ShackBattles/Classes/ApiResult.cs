using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShackBattles.Classes
{
    public class ApiResult
    {
        public bool success { get; set; }
        public string message { get; set; }
        public string data { get; set; }

        public ApiResult(bool success, string data , string message)
        {
            this.success = success;
            this.data = data;
            this.message = message;
        }
    }
}