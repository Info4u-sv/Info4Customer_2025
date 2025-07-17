using System.Web.Optimization;

namespace INTRA
{
    public class BundleConfig
    {
        // Per altre informazioni sulla creazione di bundle, vedere https://go.microsoft.com/fwlink/?LinkID=303951
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/CoreJS").Include(
                /* "~/assets/js/index.umd.js",*/
                "~/assets/js/jquery.min.js",
                "~/assets/js/bootstrap.min.js",
                "~/assets/js/material.min.js",
                "~/assets/js/perfect-scrollbar.jquery.min.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/WidgetJS").Include(
                   "~/assets/js/material-dashboard.js",
                    //< !--Library for adding dinamically elements-- >
                    "~/assets/js/arrive.min.js",
                    //Notifications Plugin
                    "~/assets/js/bootstrap-notify.js",
                    //Sliders Plugin
                    "~/assets/js/nouislider.min.js",
                    //Plugin for Select
                    "~/assets/js/jquery.select-bootstrap.js",
                    //Sweet Alert 2 plugin
                    "~/assets/js/sweetalert2.js",
                    //Plugin for Tags
                    "~/assets/js/jquery.tagsinput.js"
                ));
            bundles.Add(new StyleBundle("~/assets/css/AllMyCss").Include(
                //Bootstrap core CSS
                "~/assets/css/bootstrap.min.css"
                //Material Dashboard CSS
                //"~/assets/css/material-dashboard.css"
                ////IconPicker
                //"~/assets/IconPicker-master/dist/fontawesome-5.11.2/css/all.min.css"
                //"~/assets/css/RootColor.css",
                //"~/assets/css/material-dashboard-css4u-button-standard.css",
                //Material Dashboard CUSTOM CSS
                //"~/assets/css/material-dashboard-Intranet-Custom.css"

                ));
            BundleTable.EnableOptimizations = false;

        }
    }
}