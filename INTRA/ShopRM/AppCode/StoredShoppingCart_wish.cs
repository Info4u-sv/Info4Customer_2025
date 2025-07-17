using System.Collections.Generic;
using System.Web;

namespace INTRA.ShopRM.AppCode
{
    public class StoredShoppingCart_wish
    {
        public static ShoppingCart_wish Read()
        {
            return FetchCart();
        }
        public static int Update(decimal DeliveryCharge)
        {
            ShoppingCart_wish cart = FetchCart();

            cart.DeliveryCharge = DeliveryCharge; return 1;
        }

        public static List<CartItem_wish> ReadItems()
        {
            ShoppingCart_wish cart = FetchCart();

            return cart.Items;
        }

        public static int UpdateItem(string MenuItemID, string ItemName, int qtasel, int Quantity, decimal prezzo, int IdContattoRM, bool EnableEditQta)
        {
            ShoppingCart_wish cart = StoredShoppingCart_wish.FetchCart();
            // MsgBox(MenuItemID)
            cart.Update(MenuItemID, qtasel, ItemName, Quantity, prezzo, IdContattoRM, EnableEditQta);
            return 1;
        }

        public static int DeleteItem(string MenuItemID, int qtasel, int IdContattoRM)
        {
            ShoppingCart_wish cart = FetchCart();

            cart.Delete(MenuItemID, qtasel, IdContattoRM); return 1;
        }
        public static int InsertItem(string MenuItemID, string ItemName, int qtasel, int Quantity,
            decimal ItemPrice, int IdContattoRM, string NomeContattoRM, decimal Quota,
            decimal QuotaRidotta, string ScontoApplicato, decimal PercentualeSconto, string TokenAttributi, bool EnableEditQta, string Stagione, bool GiorniRichiestiFlag, int CategoryID)
        {
            ShoppingCart_wish cart = FetchCart();

            cart.Insert(MenuItemID, ItemName, qtasel, Quantity,
             ItemPrice, IdContattoRM, NomeContattoRM, Quota,
             QuotaRidotta, ScontoApplicato, PercentualeSconto, TokenAttributi, EnableEditQta, Stagione, GiorniRichiestiFlag, CategoryID);
            return 0;
        }
        // era private
        public static ShoppingCart_wish FetchCart()
        {

            // Fetch the cart from the session
            ShoppingCart_wish cart = (ShoppingCart_wish)HttpContext.Current.Session["Cart"];

            // If it isn't in the session, then create a new cart
            // and place it in the session
            if (cart == null)
            {
                cart = new ShoppingCart_wish();
                HttpContext.Current.Session["Cart"] = cart;
            }

            return cart;
        }
        // **********************************************************************************
        public static int verifica(string MenuItemID, int IdContattoRM)
        {
            ShoppingCart_wish cart = FetchCart();
            // MsgBox(MenuItemID)
            int qta = cart.verifica(MenuItemID, IdContattoRM);
            return qta;
        }
        public static decimal SetSpeseTrasporto(decimal SpeseTrasporto)
        {
            ShoppingCart_wish cart = FetchCart();

            cart.DeliveryCharge = SpeseTrasporto;

            return cart.DeliveryCharge;
        }
        public static decimal GetSubTotale()
        {
            ShoppingCart_wish cart = FetchCart();
            return cart.SubTotal;
        }
    }
}