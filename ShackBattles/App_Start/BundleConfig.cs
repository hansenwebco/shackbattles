using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

public class BundleConfig
{
    public static void RegisterBundles(BundleCollection bundles)
    {
        bundles.Add(new ScriptBundle("~/bundles/main").Include(
                "~/JS/main.js",
                "~/JS/stacktable.js"
                ));

        bundles.Add(new StyleBundle("~/bundles/css").Include(
            "~/JS/stacktable.css",
            "~/CSS/main.css"
            ));

    }
}
