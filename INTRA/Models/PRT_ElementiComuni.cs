using System;

/// <summary>
/// Descrizione di riepilogo per PRT_ElementiComuni
/// </summary>
public class PRT_ElementiComuni
{
    public PRT_ElementiComuni()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }

    public string FooterCompanyString()
    {
        // OBSOLETO 

        string CompanyFooter = string.Empty;
        //Portal4Set PortalConfig = new Portal4Set();
        ////CompanyFooter = "New Service srl - P.I. 029444469274 - Via Friuli Venezia Giulia, 4 - Cazzago di Pianiga (VE)";

        //string Company = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
        //string CompanyPIva = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyPIva);
        //string CompanyAddress = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyAddress);
        //string CompanyCity = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyCity);
        //string CompanyProvince = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyProvince);
        //string Companymail = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyMail);
        //string CompanyTel = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyTel);
        //CompanyFooter = "{0} - P.I. {1} - {2} - {4} ({5})";
        //CompanyFooter = string.Format("{0} - P.I. {1} - {2} - {3} ({4})", Company, CompanyPIva, CompanyAddress, CompanyCity, CompanyProvince);

        return CompanyFooter;
    }
    public string server_mapPath()
    {

        string server_mapPath = string.Empty;
        string cacheKey = "cacheKey";

        //string body;
        //body = (string)System.Web.HttpContext.Current.Cache[cacheKey];
        server_mapPath = (string)System.Web.HttpRuntime.Cache[cacheKey];
        if (string.IsNullOrEmpty(server_mapPath))
        {
            //read template file text
            server_mapPath = System.Web.HttpContext.Current.Server.MapPath("~/default.aspx");

            if (!string.IsNullOrEmpty(server_mapPath))
            {

                System.Web.HttpRuntime.Cache.Insert(cacheKey, server_mapPath, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration);
                //System.Web.HttpContext.Current.Cache.Insert(cacheKey, body, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration);
            }
        }

        server_mapPath = server_mapPath.Replace("\\default.aspx", string.Empty);
        return server_mapPath;

    }
}