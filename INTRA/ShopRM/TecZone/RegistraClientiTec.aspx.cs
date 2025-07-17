using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using INTRA.VIO_Utenti.AppCode;
using System;
using System.Web;
using System.Web.Security;

namespace INTRA.ShopRM.TecZone
{
    public partial class RegistraClientiTec : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSaveRegister_Click(object sender, EventArgs e)
        {

        }

        protected void Salvataggio_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {

            VIO_Utenti_CRUD UtenteInsert = new VIO_Utenti_CRUD();
            _ = new VIO_Utenti_CRUD();
            VIO_Utenti_CRUD _objNuovoCliente = VIO_Utenti_CRUD.GetProssimoCodCliPerCat(HttpContext.Current.User.Identity.Name);
            string _password = VIO_Utenti_CRUD.CreatePassword(10);
            MembershipUser newUser;
            try
            {

                newUser = Membership.CreateUser(_objNuovoCliente.CodCli, _password, EMail_text.Text);
                Roles.AddUserToRole(_objNuovoCliente.CodCli.ToUpper(), "Cliente");
                PRT_Privilege_SA _objPriv = new PRT_Privilege_SA();
                _objPriv.tbl_um_privilege_By_UserVsRoles_SET(_objNuovoCliente.CodCli.ToUpper());
            }
            catch (Exception)
            {
                return;
            }

            UtenteInsert.NomeUtente = _objNuovoCliente.CodCli.ToUpper();
            UtenteInsert.Email = EMail_text.Text;
            UtenteInsert.Tipologia = "Cliente";
            UtenteInsert.Azienda = _objNuovoCliente.Azienda.ToUpper();
            UtenteInsert.CodCat = _objNuovoCliente.CodCat;
            UtenteInsert.CodCli = _objNuovoCliente.CodCli.ToUpper();
            UtenteInsert.CodTecnicoCat = HttpContext.Current.User.Identity.Name.ToUpper();
            _ = UtenteInsert.InsertUtenteClienteCat(UtenteInsert);

            ClientiCat_Crud ClienteCatInsert = new ClientiCat_Crud
            {
                CodCli = _objNuovoCliente.CodCli.ToUpper(),

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


            ClientiCat_Crud.ClienteCat_Insert(ClienteCatInsert);
            _ = ShopRM_FunzioniGenerali_23.SetPasswordCliente_CreateBodyEmail(ClienteCatInsert);
            string FromMail = PRT_Parameter_23.GetPRT_ParameterValueByCodParam("EmailMittente");
            //MailMessage NewEmail = new MailMessage();
            //NewEmail.IsBodyHtml = true;
            //NewEmail.From = from;
            //NewEmail.Subject = PortalConf.GetConfigurationValue(Portal4Set.Settings.SiteName) + " - Richiesta reset password";

            object UserGUID = newUser.ProviderUserKey;
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
                to = newUser.Email,
                OggettoMail = "Recupero dati",
                CodParametroTemplate = "MailRecuperaPasswordStandard" // passo il nome del paramentro della PRT_Parameter_Crud
            };
            string[] ArrayParam = { newUser.UserName, strUrl + "/Users/Recupero_Dati.aspx?Userid=" + UserGUID };
            _WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);
            e.Result = UtenteInsert.CodCli + "|" + ClienteCatInsert.Cognome + "|" + ClienteCatInsert.Nome;
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
    }
}