using System;

namespace INTRA.ShopRM.Controls
{
    public partial class _21Plusheader : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string CompanyFooter = "";
            //Portal4Set PortalConfig = new Portal4Set();
            //string Company = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
            //string CompanyPIva = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyPIva);
            //string CompanyAddress = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyAddress);
            //string CompanyCity = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyCity);
            //string CompanyProvince = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyProvince);
            //CompanyTel = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyTel);
            string LblCopyright_string = string.Format("{0}<br />Tutti i Diritti Riservati.", string.Empty);
            LblCopyright.Text = LblCopyright_string;


        }
        public string CompanyTel { set; get; }

        protected void PopupCarrello_callbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            StoredShoppingCartListView.DataBind();
            TotalRepeater.DataBind();
        }
        protected void Wishlist_Popup_callbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            WishList_StoredShoppingCartListView.DataBind();
            Wishlist_TotalRepeater.DataBind();
        }
    }
}