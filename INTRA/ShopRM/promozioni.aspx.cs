using INTRA.ShopRM.AppCode;
using System;

namespace INTRA.ShopRM
{
    public partial class promozioni : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PlusContentAreaProdotti.SearchType = Catalog_settings.Promo;

        }

    }
}