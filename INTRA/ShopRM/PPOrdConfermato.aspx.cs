using System;
using System.Collections.Generic;
using System.Web;
using INTRA.ShopRM.AppCode;
using System.Web.Security;
namespace INTRA.ShopRM
{
    public partial class PPOrdConfermato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfermaOrdineConPaypal(Convert.ToInt32(Request.QueryString["ok"]));
            }
        }
        protected bool ConfermaOrdineConPaypal(int OrderId)
        {
            INTRA.ShopRM.AppCode.Order.UpdateOrder(OrderId, "EP");
            List<Order> MyOrder = new List<Order>();
            MyOrder = Order.GetOrders_IDorder_testata(OrderId);
            int i = 0;
            List<OrderItem> MyOrderItems = new List<OrderItem>();
            MyOrderItems = Order.GetOrderItems(OrderId);           
            string totcartStr = null;
            decimal totcart = MyOrder[0].TotalAmount;         
            MembershipUser u = Membership.GetUser(Context.User.Identity.Name);
            SHP_OrderBodyMail Get = new SHP_OrderBodyMail();
            WebReference4u.WebService_primo _WebS_primo = new WebReference4u.WebService_primo();
            WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();
            INTRA.AppCode.PRT_Parameter _objPrt = new INTRA.AppCode.PRT_Parameter();
            string MailFromRM = _objPrt.GetPRT_ParameterStringByCode("RmMailShop");


            _JsonEmail.from = MailFromRM;
            _JsonEmail.to = u.Email;
            _JsonEmail.OggettoMail = "Conferma ordine N." + MyOrder[0].OrderID;
            _JsonEmail.CodParametroTemplate = "RmMailPPOrdConfermato";
            string UrlDomino = _objPrt.GetPRT_ParameterStringByCode("RmUrlDominio");
            string[] ArrayParam = { HttpContext.Current.User.Identity.Name, UrlDomino, MyOrder[0].OrderID.ToString(), Get.CreaOrdineBodyMail(Convert.ToInt32(MyOrder[0].OrderID)) };
            _WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);
            ShoppingCart cart = (ShoppingCart)StoredShoppingCart.Read();
            cart.Items.Clear();
            ShoppingCart cartTestata = (ShoppingCart)HttpContext.Current.Session["Cart"];
            cartTestata = null;           
            return true;
        }
    }
}