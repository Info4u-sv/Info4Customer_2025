using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM
{
    public partial class PP_conferma_ordine : System.Web.UI.Page
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

            List<Order> MyOrder = new List<Order>();
            MyOrder = Order.GetOrders_IDorder_testata(OrderId);
            int i = 0;

            List<OrderItem> MyOrderItems = new List<OrderItem>();
            MyOrderItems = Order.GetOrderItems(OrderId);
            //MsgBox(ordinenum)
            //paso i dati al carrello-----------------
            //Dim myShoppingCart As ShoppingCart
            // myShoppingCart = StoredShoppingCart.Read();
            //Dim totcart As Decimal = myShoppingCart.Total
            string totcartStr = null;

            decimal totcart = MyOrder[0].TotalAmount;

            MyMessageBox1.Visible = true;
            MyMessageBox1.Show(MyMessageBox.MessageType.Success, "L'ordine è stato inoltrato, riceverai a breve una mail di conferma.");
            SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();
            string subject = "Conferma ordine n. " + MyOrder[0].OrderID;
            string corpo = MailBodyCreatePaypal(MyOrder[0].OrderID);
            string UrlAssoluto = Request.ApplicationPath.TrimEnd('/') + "/";
            //controllato
            string body = EmailUtility.PrepareMailBodyWith("MasterEmailV2.html", "MailTitle", subject, "MailBody", corpo, "MailFooter", " ", "UrlSite", PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.SiteUrl), "Company", PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.Company));
            body.Replace("../static", UrlAssoluto);
            MembershipUser u = Membership.GetUser(Context.User.Identity.Name);

            SHP_OrderBodyMail Get = new SHP_OrderBodyMail();

            WebReference4u.WebService_primo _WebS_primo = new WebReference4u.WebService_primo();
            WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();
            _JsonEmail.from = "tesseramento@rugbymilano.it";
            _JsonEmail.to = u.Email;
            _JsonEmail.OggettoMail = "Conferma ordine N." + MyOrder[0].OrderID;
            _JsonEmail.CodParametroTemplate = "RmMailGenerazioneOrdine";
            string[] ArrayParam = { HttpContext.Current.User.Identity.Name, "https://rugbymilano.info4lab.it/", MyOrder[0].OrderID.ToString(), Get.CreaOrdineBodyMail(Convert.ToInt32(MyOrder[0].OrderID)) };


            _WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);

            //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.PRTMail), u.Email + "," + PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.PRTMail), subject, body);
            ShoppingCart cart = (ShoppingCart)StoredShoppingCart.Read();
            cart.Items.Clear();
            ShoppingCart cartTestata = (ShoppingCart)HttpContext.Current.Session["Cart"];
            cartTestata = null;
            StoredShoppingCartObjectDS.DataBind();
            StoredShoppingCartListView.Visible = false;
            TotalPanel.Visible = false;
            return true;
        }
    }
}