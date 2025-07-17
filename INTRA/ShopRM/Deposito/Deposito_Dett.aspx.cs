using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM.Deposito
{
    public partial class Deposito_Dett : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MembershipUser u = Membership.GetUser(Context.User.Identity.Name);
                Session["UtenteLoggato"] = u.UserName;
                Giornate_Dts.DataBind();
                shopList2.DataBind();

            }

            if (Convert.ToInt32(Session["AzioneEseguita"] ?? 0) == 1)
            {

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "showNotificationtoastr()", true);


                Session["AzioneEseguita"] = null;
            }

        }

        protected void AggiungiAlCarrello_Callback_Callback(object source, CallbackEventArgs e)
        {
            // da verificare
            //ShopList1.DataBind();
            MembershipUser UserLog = Membership.GetUser();


            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
            int VisibleIndex = 0;
            decimal Qta = 0;
            string[] Parametri = e.Parameter.Split(';');
            string ProductCod = string.Empty;


            if (Parametri.Count() > 1)
            {
                VisibleIndex = Convert.ToInt32(Parametri[0]);
                Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
                ProductCod = ShopList1.GetCardValues(VisibleIndex, "CodArt").ToString();

                for (int j = 0; j < ShopList1.VisibleCardCount; j++)
                {
                    if (ShopList1.GetCardValues(j, "CodArt").ToString() == ProductCod)
                    {
                        VisibleIndex = j;
                    }
                }
            }

            //_ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "Prezzo_Lbl");


            //string Price = ShopList1.GetCardValues(VisibleIndex, "Price").ToString();
            string DisplayName = ShopList1.GetCardValues(VisibleIndex, "Descrizione").ToString();
            //string ShortDescription = ShopList1.GetCardValues(VisibleIndex, "ShortDescription").ToString();
            //string PromoPrice = ShopList1.GetCardValues(VisibleIndex, "PromoPrice").ToString();
            _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "ProductCod_lbl");
            _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "DisplayName_lbl");

            //ASPxPanel DXPromoPanel = (ASPxPanel)ShopList1.FindCardTemplateControl(VisibleIndex, "DXPromoPanel");
            //Panel PromoPanel = (Panel)ShopList1.FindCardTemplateControl(VisibleIndex, "PromoPanel");
            //ASPxTextBox Qta_Txt = (ASPxTextBox)ShopList1.FindCardTemplateControl(VisibleIndex, "QtaDef_Txt");

            //ASPxLabel SpeseTrasporto_Lbl = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "SpeseTrasporto_Lbl");
            //ASPxCheckBox SpeseTrasporto_Ckbx = (ASPxCheckBox)ShopList1.FindCardTemplateControl(VisibleIndex, "SpeseTrasporto_Ckbx");
            decimal ItemPrice = 0;
            string descrizione = DisplayName;
            _ = new StoredShoppingCart();
            int IdContattoRM = 0;

            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
            CodDep = CodDep.Replace("CodDep=", string.Empty);
            decimal verificacart = StoredShoppingCart.VerificaItemStatic(ProductCod, CodDep);
            decimal qtasel = Qta;

            string NomeContattoRM = MyProfile.Name + " " + MyProfile.cognome;
            int CategoryId = 0;
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CategoryId FROM U_SHP_Category WHERE DisplayName = @DisplayName", new SqlParameter() { ParameterName = "@DisplayName", Value = ShopList1.GetCardValues(VisibleIndex, "Categoria").ToString() });
            if (reader.Read())
            {
                CategoryId = Convert.ToInt32(reader["CategoryId"]);
            }
            _ = new SHP_Articoli();
            SHP_Articoli _ArticoloSelect = SHP_Articoli.U_GetDettaglioSHP_Articolo(ProductCod, CategoryId);

            if (verificacart == -1)
            {
                //_ = _ArticoloSelect.QtaXConf;
                //string CodLis = MyProfile.CodLis;
                _ = StoredShoppingCart.InsertItem(ProductCod, descrizione, qtasel, qtasel, _ArticoloSelect.CategoryID, _ArticoloSelect.UM);
                //SetSpeseTrasporto();
            }
            else
            {
                qtasel = verificacart + qtasel;
                bool EnableEditQta = true;
                _ = StoredShoppingCart.UpdateItem(ProductCod, qtasel);
                // SetSpeseTrasporto();
            }
        }

        protected void AggiornaGiacenza_Callback_Callback(object source, CallbackEventArgs e)
        {
            string[] Parametri = e.Parameter.Split(';');

            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
            int VisibleIndex = 0;
            decimal Qta = 0;
            string ProductCod = string.Empty;
            string UM = string.Empty;

            if (Parametri.Count() > 1)
            {
                VisibleIndex = Convert.ToInt32(Parametri[0]);
                Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
                ProductCod = ShopList1.GetCardValues(VisibleIndex, "CodArt").ToString();
                UM = ShopList1.GetCardValues(VisibleIndex, "Misura").ToString();

                for (int j = 0; j < ShopList1.VisibleCardCount; j++)
                {
                    if (ShopList1.GetCardValues(j, "CodArt").ToString() == ProductCod)
                    {
                        VisibleIndex = j;
                    }
                }
            }
            int Giacenza = Convert.ToInt32(ShopList1.GetCardValues(VisibleIndex, "Giacenza"));

            if ((Giacenza - Qta) >= 0)
            {
                string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
                CodDep = CodDep.Replace("CodDep=", string.Empty);

                Sql4Gestionale objSqlHelper = new Sql4Gestionale();
                SqlParameter[] objParams = new SqlParameter[4];
                objParams[0] = new SqlParameter("@CodDep", CodDep);
                objParams[1] = new SqlParameter("@Qta", Qta);
                objParams[2] = new SqlParameter("@CodArt", ProductCod);
                objParams[3] = new SqlParameter("@UM", UM);
                objSqlHelper.ExecuteNonQuery("U_I_King_Scarico_Prodotti_Finiti", objParams);
                AggiornaGiacenza_Callback.JSProperties["cpError"] = false;
            }
            else
            {
                AggiornaGiacenza_Callback.JSProperties["cpError"] = true;
            }
            Inventario_Dts.DataBind();
            //ShopList1.DataBind();
        }
    }
}