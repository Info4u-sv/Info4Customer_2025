using DevExpress.Web;
using INTRA.AppCode;
using INTRA.VIO_Utenti.AppCode;
using System;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace INTRA.ShopRM.TecZone
{
    public partial class EditClienteTec : System.Web.UI.Page
    {
        private static string Email;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["CodCli"] = Request.Cookies["CodCli"].Value.ToString().Replace("CodCli=", "");
            CodCli_lbl.Text = Session["CodCli"] as string;

            if (!IsPostBack)
            {
                DataView dv = (DataView)Cliente_dts.Select(DataSourceSelectArguments.Empty);
                DataTable dt = dv.ToTable();
                DataRow dr = dt.Rows[0];

                Email = dr["Email"].ToString();
            }
        }

        protected void Salvataggio_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            _ = VIO_Utenti_CRUD.CreatePassword(10);
            string CodCli = Session["CodCli"] as string;
            MembershipUser User = Membership.GetUser(CodCli);
            User.Email = EMail_text.Text;
            Membership.UpdateUser(User);
            _ = VIO_Utenti_CRUD.Email_Update(CodCli, EMail_text.Text);

            ClientiCat_Crud ClienteCatInsert = new ClientiCat_Crud
            {
                CodCli = CodCli,

                Nome = Nome_text.Text,
                Cognome = Cognome_text.Text,
                Ind = Indirizzo_Txt.Text,
                Prov = Provincia_Combobox.SelectedItem.Text,
                Loc = Local_Txt.Text,
                Tel = Tel_text.Text,
                CF = CF_Txt.Text,
                EMail = EMail_text.Text,
                Cap = Cap_text.Text
            };


            _ = ClientiCat_Crud.CLienteCat_Update(ClienteCatInsert);
            if (Email != EMail_text.Text)
            {
                //string EmailBodyForPassword = ShopRM_FunzioniGenerali_23.SetPasswordCliente_CreateBodyEmail(ClienteCatInsert);
                string FromMail = PRT_Parameter_23.GetPRT_ParameterValueByCodParam("EmailMittente"); ;
                //MailMessage NewEmail = new MailMessage();
                //NewEmail.IsBodyHtml = true;
                //NewEmail.From = from;
                //NewEmail.Subject = PortalConf.GetConfigurationValue(Portal4Set.Settings.SiteName) + " - Richiesta reset password";

                object UserGUID = User.ProviderUserKey;
                string strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
                string strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "/");
                //NewEmail.Body = PopulateBody(User_Txt.Text, strUrl + "/Users/Recupero_Dati.aspx?Userid=" + UserGUID);
                //NewEmail.To.Add(User.Email);

                webservice_secondo.WebService_primoSoapClient _WebS_primo = new webservice_secondo.WebService_primoSoapClient("WebService_primoSoap");
                webservice_secondo.JsonEmail _JsonEmail = new webservice_secondo.JsonEmail
                {
                    // webservice_secondo.WebService_primoSoap _WebS_primo = new webservice_secondo.WebService_primoSoap();
                    //_WebS_primo.SoapVersion = System.Web.Services.Protocols.SoapProtocolVersion.Default;
                    //JsonEmail _test = new JsonEmail();
                    from = FromMail,
                    to = User.Email,
                    OggettoMail = "Recupero dati",
                    CodParametroTemplate = "MailRecuperaPasswordStandard" // passo il nome del paramentro della PRT_Parameter_Crud
                };
                string[] ArrayParam = { User.UserName, strUrl + "/Users/Recupero_Dati.aspx?Userid=" + UserGUID };
                _WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);
                Email = EMail_text.Text;
            }
            //e.Result = UtenteInsert.CodCli + "|" + ClienteCatInsert.Cognome + "|" + ClienteCatInsert.Nome;
        }

        protected void ImpostaCliPerOrdine_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["CodCli"];
            HttpCookie CodCLiDett_cookie = HttpContext.Current.Request.Cookies["CodCliDet"];

            string[] DettCli = e.Parameter.Split('|');

            if (cookie != null && CodCLiDett_cookie != null)
            {
                PRT_Cookie_Crud_23.RewriteCoockies("CodCli", DettCli[0], "CodCliDet", DettCli[1] + " " + DettCli[2]);
            }
            else
            {
                cookie = new HttpCookie("CodCli");
                cookie.Values.Add("CodCli", DettCli[0]);
                cookie.Expires = DateTime.MaxValue;
                Response.Cookies.Add(cookie);


                CodCLiDett_cookie = new HttpCookie("CodCliDet");
                CodCLiDett_cookie.Values.Add("CodCliDet", DettCli[1] + " " + DettCli[2]);
                CodCLiDett_cookie.Expires = DateTime.MaxValue;
                Response.Cookies.Add(CodCLiDett_cookie);
            }
        }

        protected void EmailCheck_pnl_Callback(object sender, CallbackEventArgsBase e)
        {
            ASPxCallbackPanel panel = (ASPxCallbackPanel)sender;
            bool IsValid = false;
            if (panel.FindControl("EMail_text") is ASPxTextBox txt)
            {
                string email = txt.Text;

                MembershipUserCollection users = Membership.FindUsersByEmail(email);

                IsValid = !string.IsNullOrEmpty(email) && users.Count == 0;

            }
            //txt.IsValid = IsValid;
            panel.JSProperties["cpResult"] = IsValid ? "0" : "1";
        }

        protected void EmailCheck_callback_Callback(object source, CallbackEventArgs e)
        {

            bool IsValid = false;
            if (EMail_text != null)
            {
                string email = EMail_text.Text;

                MembershipUserCollection users = Membership.FindUsersByEmail(email);

                IsValid = !string.IsNullOrEmpty(email) && users.Count == 0;

                if (users.Count > 0 && users.Count < 2)
                {
                    try
                    {
                        MembershipUser user = users[Session["CodCli"] as string];
                        IsValid = user != null;
                    }
                    catch
                    {
#pragma warning disable CS1717 // Assegnazione fatta alla stessa variabile
                        IsValid = IsValid;
#pragma warning restore CS1717 // Assegnazione fatta alla stessa variabile
                    }
                }

            }
            //txt.IsValid = IsValid;
            e.Result = IsValid ? "0" : "1";
        }
    }
}