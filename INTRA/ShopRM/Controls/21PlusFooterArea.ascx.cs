using DevExpress.Web;
using info4lab.Portal;
using INTRA.ShopRM.AppCode;
using System;
using System.Web;
using System.Web.UI;

namespace INTRA.ShopRM.Controls
{
    public partial class _21PlusFooterArea : System.Web.UI.UserControl
    {
        public string MapGoogleLat { get; set; }
        public string MapGoogleLong { get; set; }
        public string MapGoogleMsg { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            string CompanyFooter;
            //string LblCopyright_string = "";
            Portal4Set_SA PortalConfig = new Portal4Set_SA();
            //string Company = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
            //string CompanyPIva = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyPIva);
            //string CompanyAddress = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyAddress);
            //string CompanyCity = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyCity);
            //string CompanyProvince = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyProvince);
            //MapGoogleLat = PortalConfig.GetConfigurationValue(Portal4Set.Settings.MapGoogleLat);
            //MapGoogleLong = PortalConfig.GetConfigurationValue(Portal4Set.Settings.MapGoogleLong);

            CompanyFooter = string.Format("{0} - P.I. {1} - {2} - {3} ({4})", "Adriana Servizi", "", "", "Milano", "MI");

            //LblCopyright_string = string.Format("{0} | P.I. {1} | {2} | {3} ({4})", Company, CompanyPIva, CompanyAddress, CompanyCity, CompanyProvince);


            //LblCopyright.Text = ShopRM_FunzioniGenerali_23.CreateFooterForOrderBody(new CAT_CRUD()[HttpContext.Current.User.Identity.Name]);
            //CompanyLbl.Text = CompanyFooter;
            string MetaDescrGlobal = PortalConfig.GetConfigurationValue(Portal4Set_SA.Settings.MetaDescrGlobal);
            string MetaKeywordsGlobal = PortalConfig.GetConfigurationValue(Portal4Set_SA.Settings.MetaKeywordsGlobal);
            string MetaTitleGlobal = PortalConfig.GetConfigurationValue(Portal4Set_SA.Settings.MetaTitleGlobal);



            Page.MetaDescription = MetaDescrGlobal;
            Page.MetaKeywords = MetaKeywordsGlobal;
            Page.Title = MetaTitleGlobal;

            //MapGoogleMsg = string.Format("<b>{0}</b> <br /><br /> {1} - {2} ({3}) <br /><br /> <b>Orari di Apertura</b><br/> <br />{4}", Company, CompanyAddress, CompanyCity, CompanyProvince, Orari);
            //string CompanyLbltxt = string.Format("<b>{0}</b> <br /> {1} - {2} ({3}) <br /><br />", Company, CompanyAddress, CompanyCity, CompanyProvince);
            //LblOrariApertura.Text = Orari;
            //CompanyLbl.Text = CompanyLbltxt;
            //codice di gestione google analytics 
            //aggiungo all'head della pagina lo script di google analytics 

            //string GoogleAnalytics = PortalConfig.GetConfigurationValue(Portal4Set.Settings.googleAnalytics);
            //HtmlHead head = Page.Header;

            //LiteralControl lctl = new LiteralControl(GoogleAnalytics);

            //head.Controls.Add(lctl);

        }

        protected void CompanyLbl_Init(object sender, EventArgs e)
        {
            string CompanyFooter;

            CompanyFooter = string.Format("{0} - P.Iva: {1} - {2} - {3} ({4})", "Info4u Srl", "04905690964", "Viale Lunigiana, 24", "20125 Milano", "MI");
            ASPxLabel lbl = (sender) as ASPxLabel;

            lbl.Text = CompanyFooter;
        }
    }
}