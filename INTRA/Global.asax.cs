using DevExpress.Web;
using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace INTRA
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Codice eseguito all'avvio dell'applicazione
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            // DevExpress.XtraReports.Web.ASPxWebDocumentViewer.StaticInitialize();
            BundleTable.EnableOptimizations = true;

            ASPxWebControl.BackwardCompatibility.DataControlAllowReadUnlistedFieldsFromClientApiDefaultValue = true;
            //Set this property only if you have a valid license key, otherwise do not
            //set it so DocumentUltimate runs in trial mode.
            //DocumentUltimateConfiguration.Current.LicenseKey = "QECHM2U6CL-H5E3P24L5W-5NUUSNHA1K-CVXFQZ1CVG-BHAPW27KXK-4RU7WJFX88-E6MAW6BKUX";

            //The default CacheLocation value is "~/App_Data/DocumentCache"
            //Both virtual and physical paths are allowed (or a Location instance for one of the supported 
            //file systems like Amazon S3 and Azure Blob).
            //DocumentUltimateWebConfiguration.Current.CacheLocation = "~/App_Data/DocumentCache";

        }
        void Application_BeginRequest(Object sender, EventArgs e)
        {
            //// Code that runs on application startup
            //HttpCookie cookie = HttpContext.Current.Request.Cookies["LanguageGomsilIntra"];
            //if (cookie != null)
            //{
            //    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(cookie.Value);
            //    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(cookie.Value);
            //}
            //else
            //{
            //    HttpCookie cookieVar = new HttpCookie("LanguageGomsilIntra");
            //    cookieVar.Expires = DateTime.Now.AddDays(10000);
            //    cookieVar.Value = "it-IT";
            //    Response.Cookies.Add(cookieVar);
            //    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo("it-IT");
            //    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("it-IT");
            //}
        }

    }
}