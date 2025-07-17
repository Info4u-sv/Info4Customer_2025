using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;

namespace INTRA.ShopRM
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Session["CodCli"] = HttpContext.Current.User.Identity.Name.ToUpper();

                dynamic MyProfile = ProfileBase.Create(HttpContext.Current.User.Identity.Name.ToUpper(), true);


                MyProfile.CodCli = HttpContext.Current.User.Identity.Name.ToUpper();

                MyProfile.Save();
                _ = Request.Cookies["MyToken"];
                _ = ConfigurationManager.AppSettings;

                HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
                if(CodDep_cookie != null)
                {
                    string codDep = CodDep_cookie.Value;
                    //dep_div.Visible = !string.IsNullOrEmpty(codDep);
                    //seleziona_div.Visible = false;
                }
                else
                {
                    //dep_div.Visible = false;
                    //seleziona_div.Visible = true;
                }
                if (Convert.ToInt32(Session["AzioneEseguita"] ?? 0) == 1)
                {

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "showNotificationtoastr()", true);


                    Session["AzioneEseguita"] = null;
                }
            }

        }
        //protected void AggiungiAlCarrello_Callback_Callback(object source, CallbackEventArgs e)
        //{
        //    MembershipUser UserLog = Membership.GetUser();


        //    dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
        //    int VisibleIndex = 0;
        //    decimal Qta = 0;
        //    string[] Parametri = e.Parameter.Split(';');
        //    string ProductCod = string.Empty;


        //    if (Parametri.Count() > 1)
        //    {
        //        VisibleIndex = Convert.ToInt32(Parametri[0]);
        //        Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
        //        ProductCod = ShopList1.GetCardValues(VisibleIndex, "CodArt").ToString();

        //        for (int j = 0; j < ShopList1.VisibleCardCount; j++)
        //        {
        //            if (ShopList1.GetCardValues(j, "CodArt").ToString() == ProductCod)
        //            {
        //                VisibleIndex = j;
        //            }
        //        }
        //    }
        //    string DisplayName = ShopList1.GetCardValues(VisibleIndex, "Descrizione").ToString();
        //    _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "ProductCod_lbl");
        //    _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "DisplayName_lbl");
        //    decimal ItemPrice = 0;
        //    string descrizione = DisplayName;
        //    _ = new StoredShoppingCart();
        //    int IdContattoRM = 0;

        //    string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
        //    CodDep = CodDep.Replace("CodDep=", string.Empty);
        //    decimal verificacart = StoredShoppingCart.VerificaItemStatic(ProductCod, CodDep);
        //    decimal qtasel = Qta;

        //    string NomeContattoRM = MyProfile.Name + " " + MyProfile.cognome;
        //    int CategoryId = 0;
        //    SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CategoryId FROM U_SHP_Category WHERE DisplayName = @DisplayName", new SqlParameter() { ParameterName = "@DisplayName", Value = ShopList1.GetCardValues(VisibleIndex, "Categoria").ToString() });
        //    if (reader.Read())
        //    {
        //        CategoryId = Convert.ToInt32(reader["CategoryId"]);
        //    }
        //    _ = new SHP_Articoli();
        //    SHP_Articoli _ArticoloSelect = SHP_Articoli.U_GetDettaglioSHP_Articolo(ProductCod, CategoryId);

        //    if (verificacart == -1)
        //    {
        //        _ = StoredShoppingCart.InsertItem(ProductCod, descrizione, qtasel, qtasel, _ArticoloSelect.CategoryID, _ArticoloSelect.UM);
        //    }
        //    else
        //    {
        //        qtasel = verificacart + qtasel;
        //        bool EnableEditQta = true;
        //        _ = StoredShoppingCart.UpdateItem(ProductCod, qtasel);
        //    }
        //}
    }
}