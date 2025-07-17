using Microsoft.AspNet.FriendlyUrls;
using System.Web.Routing;

namespace INTRA
{
    public static class RouteConfig
    {
        //public static void RegisterRoutes(RouteCollection routes)
        //{
        //    var settings = new FriendlyUrlSettings();
        //    settings.AutoRedirectMode = RedirectMode.Permanent;
        //    routes.EnableFriendlyUrls(settings);
        //}

        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings
            {
                // commento altrimenti le immagini dei report non si vedono
                // AutoRedirectMode = RedirectMode.Permanent
            };
            //routes.EnableFriendlyUrls(settings);
            //routes.Ignore("{*allaspx}", new { allaspx = @".*(CrystalImageHandler).*" });
            //routes.Ignore("Pratiche_TRS/{resource}.aspx/{*pathInfo}");
        }
    }
}
