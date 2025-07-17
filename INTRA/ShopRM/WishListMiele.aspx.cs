using DevExpress.Web;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;

namespace INTRA.ShopRM
{
    public partial class WishListMiele : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.Header.DataBind();
            _ = new List<CartItem_wish>();
            List<CartItem_wish> MyCartItems = StoredShoppingCart_wish.ReadItems();
            string ListFilter = "'0',";
            if (MyCartItems.Count > 0)
            {
                for (int i = 0; i < MyCartItems.Count; i++)
                {
                    ListFilter += "'" + MyCartItems[i].MenuItemID.ToString() + "',";
                }
            }
            string sqltxt = ArticoliinWishlist_Sdt.SelectCommand.ToString();
            sqltxt = sqltxt + " OR ProductCod IN (" + ListFilter.Remove(ListFilter.Length - 1) + ")";
            ArticoliinWishlist_Sdt.SelectCommand = sqltxt;
            _ = ArticoliinWishlist_Sdt.Select(DataSourceSelectArguments.Empty);
            ArticoliinWishlist_Sdt.DataBind();
            ShopList1.DataBind();

        }

        protected string ImmaginePrincipale(object id)
        {
            string classe = "url";

            if (id != null)
            {
                if (id.ToString() == Request.QueryString["cod"])
                {
                    classe = "immagineSelezionata";
                }
            }

            return classe;
        }

        protected void RimuoviDalCarrello_Callback_Callback(object source, CallbackEventArgs e)
        {

            int VisibleIndex = Convert.ToInt32(e.Parameter);
            string ProductId = ShopList1.GetCardValues(VisibleIndex, "ProductCod").ToString();
            _ = StoredShoppingCart_wish.DeleteItem(ProductId, 0, 0);

        }

        protected void SvuotaWishList_CallB_Callback(object source, CallbackEventArgs e)
        {
            HttpContext.Current.Session["Cart"] = null;
        }
    }

}