using System.Collections.Generic;
using System.Web;

namespace INTRA.ShopRM.AppCode
{
    public class StoredShoppingCart
    {
        public static List<CartItem> Read()
        {
            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
            CodDep = CodDep.Replace("CodDep=", string.Empty);


            return ESK_ShoppingCart.FetchCartLocal(CodDep);
        }
        //public static int Update(decimal DeliveryCharge)
        //{
        //    string CodCli = HttpContext.Current.Session["CodCli"].ToString();
        //    List<CartItem> cart = ESK_ShoppingCart.FetchCartLocal(CodCli);

        //    //cart.DeliveryCharge = DeliveryCharge; 

        //    return 1;
        //}

        public static List<CartItem> ReadItems(string CodDep)
        {
            //ShoppingCart cart = FetchCart();
            List<CartItem> cartLocal = new List<CartItem>();
            try
            {
                CodDep = CodDep == null ? string.Empty : CodDep.Replace("CodDep=", string.Empty);
                //string CodCli = HttpContext.Current.Session["CodCli"].ToString();
                cartLocal = ESK_ShoppingCart.FetchCartLocal(CodDep);
                if (cartLocal.Count == 0)
                {
                    //Controllare non so a cosa serve Simone 26-05-2022
                    //cartLocal.DeliveryCharge = 0;
                }
            }
            catch { }
            return cartLocal;
        }

        public static int UpdateItem(string MenuItemID, decimal Quantity)
        {
            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
            CodDep = CodDep.Replace("CodDep=", string.Empty);
            ESK_ShoppingCart.ItemsUpdateQtaLocal(MenuItemID, Quantity, CodDep);

            //ShoppingCart cart = StoredShoppingCart.FetchCart();
            //// MsgBox(MenuItemID)
            //cart.Update(MenuItemID, qtasel, ItemName, Quantity, prezzo, IdContattoRM, EnableEditQta, QtaXConf);

            return 1;
        }

        //public static int DeleteItem(string MenuItemID, int qtasel, int IdContattoRM)
        //{
        //    ShoppingCart cart = FetchCart();

        //    cart.Delete(MenuItemID, qtasel, IdContattoRM); return 1;
        //}
        public static int InsertItem(string MenuItemID, string ItemName, decimal qtasel, decimal Quantity, int CategoryID, string UM)
        {
            //ShoppingCart cart = FetchCart();
            ShoppingCart cart = new ShoppingCart();
            cart.Insert(MenuItemID, ItemName, qtasel, Quantity, CategoryID, UM);
            return 0;
        }
        // era private
        //public static ShoppingCart FetchCart()
        //{

        //    //string IDContattoSession = HttpContext.Current.Session["IDContattoSession"].ToString();
        //    // Fetch the cart from the session
        //    ShoppingCart cart = (ShoppingCart)HttpContext.Current.Session["Cart"];

        //    // If it isn't in the session, then create a new cart
        //    // and place it in the session
        //    if (cart == null)
        //    {
        //        cart = new ShoppingCart();
        //        HttpContext.Current.Session["Cart"] = cart;
        //    }

        //    return cart;
        //}
        // **********************************************************************************
        //public static int verifica(string MenuItemID, int IdContattoRM)
        //{
        //    ShoppingCart cart = FetchCart();
        //    // MsgBox(MenuItemID)
        //    //int qta = cart.verifica(MenuItemID,  IdContattoRM);

        //    int qta = cart.VerificaLocal(MenuItemID, IdContattoRM);


        //    return qta;
        //}

        public static decimal VerificaItemStatic(string MenuItemID, string CodDep)
        {
            // string CodCli recuperato dalla session Session["CodCli"]

            ShoppingCart cart = new ShoppingCart();
            // MsgBox(MenuItemID)
            //int qta = cart.verifica(MenuItemID,  IdContattoRM);

            decimal qta = cart.VerificaLocal(MenuItemID, CodDep);


            return qta;
        }

        public static decimal SetSpeseTrasporto(decimal SpeseTrasporto)
        {
            //ShoppingCart cart = FetchCart();
            ShoppingCart cart = new ShoppingCart
            {
                DeliveryCharge = SpeseTrasporto
            };

            return cart.DeliveryCharge;
        }
        public static decimal GetSubTotale()
        {
            //ShoppingCart cart = FetchCart();
            //return cart.SubTotal; 
            string CodCli = HttpContext.Current.Request.Cookies["CodCli"].Value;
            CodCli = CodCli.Replace("CodCli=", string.Empty);

            decimal SubTotalLocal = ESK_ShoppingCart.SubTotalLocal(CodCli);
            return SubTotalLocal;

        }
    }
}