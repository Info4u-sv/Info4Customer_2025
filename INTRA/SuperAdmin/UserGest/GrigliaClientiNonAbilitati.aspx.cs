using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Profile;
using System.Web.Security;

namespace INTRA.SuperAdmin.UserGest
{

    public partial class GrigliaClientiNonAbilitati : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void EditForm_CallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter == "save")
            {
                Utenti_CRUD_Class Utente = new Utenti_CRUD_Class();
                Utente.NomeUtente = NomeUtenteIntranet_Txt.Text;
                Utente.Email = Email_Txt.Text;
                int numeroUtenti = Utente.ContaUtentiPerCodCli(CodCli_Value.Text);
                string ruoloDaAssegnare = numeroUtenti == 0 ? "ClienteAdmin" : "Cliente";
                Utente.Tipologia = ruoloDaAssegnare;
                Utente.Azienda = Societa_txt.Text;
                Utente.CodCli = CodCli_Value.Text;
                Utente.Nome = Nome_txt.Text;
                Utente.Cognome = Cognome_Txt.Text;

                Utente.InsertUtente(Utente);


                MembershipUser newUser = Membership.CreateUser(NomeUtenteIntranet_Txt.Text, CreatePassword(10), Email_Txt.Text);
                newUser.Comment = string.Empty;
                Membership.UpdateUser(newUser);

                Roles.AddUserToRole(NomeUtenteIntranet_Txt.Text, ruoloDaAssegnare);
                PRT_Privilege_SA _objPriv = new PRT_Privilege_SA();
                _objPriv.tbl_um_privilege_By_UserVsRoles_SET(NomeUtenteIntranet_Txt.Text);

                VIO_Parametri Get = new VIO_Parametri();
                string ImgTecnico = Get.GetValue("Value", "DefaultUserImg", "PRT_Parameter", "CodParam");


                dynamic MyProfile = ProfileBase.Create(NomeUtenteIntranet_Txt.Text, true);
                MyProfile.nome = Nome_txt.Text;
                MyProfile.cognome = Cognome_Txt.Text;
                MyProfile.Societa = Societa_txt.Text;
                MyProfile.CodiceFiscale = Codicefiscale_Txt.Text;
                MyProfile.Indirizzo = Indirizzo_Txt.Text;
                MyProfile.Cap = Cap_Txt.Text;
                MyProfile.citta = Citta_Txt.Text;
                MyProfile.Provincia = Provincia_Txt.Text;
                MyProfile.Telefono = Telefono_txt.Text;
                //MyProfile.fax = Fax_Txt.Text;
                MyProfile.ImgTecnico = ImgTecnico;
                MyProfile.email = EmailAzienda_Txt.Text;
                //MyProfile.EmailTicket = EmailTicket_Txt.Text;

                MyProfile.CodCli = CodCli_Value.Text;
                MyProfile.CodLis = Utente.GetCodLisForCli(CodCli_Value.Text);
                MyProfile.Save();


                //#region Da decommentare finiti i test
                Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");
                WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();

                INTRA.AppCode.PRT_Parameter _objPrt = new INTRA.AppCode.PRT_Parameter();
                string mailfrom = _objPrt.GetPRT_ParameterStringByCode("RmMailShop");
                string UrlDomino = _objPrt.GetPRT_ParameterStringByCode("RmUrlDominio");

                _JsonEmail.from = mailfrom;
                _JsonEmail.to = Email_Txt.Text;
                _JsonEmail.OggettoMail = "Registrazione completata con successo";
                _JsonEmail.CodParametroTemplate = "RmMailConfermaRegistrazione";

                string mailbodyTemplate = _objPrt.GetPRT_ParameterStringByCode(_JsonEmail.CodParametroTemplate);
                string imgTemplate = _objPrt.GetPRT_ParameterStringByCode("UrlDominioPerImgEmail");
                string footer = _objPrt.GetPRT_ParameterStringByCode("FooterEmail");


                MembershipUser User = Membership.GetUser(NomeUtenteIntranet_Txt.Text);
                object UserGUID = User.ProviderUserKey;
                String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
                String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "/");
                bool MailClienteInvioAbilita = false;
                bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"], out MailClienteInvioAbilita);
                string nomeUtente = NomeUtenteIntranet_Txt.Text;
                string linkRecupero = $"{strUrl}/Users/Recupero_Dati.aspx?Userid={UserGUID}";
                string mailbody = string.Format(mailbodyTemplate, nomeUtente, linkRecupero);
                string body = EmailUtility.PrepareMailBodyWith(
                "MasterEmailV2.html", "MailTitle", _JsonEmail.OggettoMail, "MailBody", mailbody, "MailFooter", footer, "UrlSite", imgTemplate, "Company", " ");
                string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");
                if (MailClienteInvioAbilita)
                {
                    Ws.TestSendEmai(_JsonEmail.from, _JsonEmail.to, body, _JsonEmail.OggettoMail);
                }
                //SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();
                //string[] ArrayParam = { Nome_txt.Text + " " + Cognome_Txt.Text, NomeUtenteIntranet_Txt.Text, PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.SiteUrl).ToString() + "/Users/Recupero_Dati.aspx?Userid=" + UserGUID };
                //_WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);
                //#endregion

                (sender as ASPxCallbackPanel).JSProperties["cpInserted"] = "1";
            }
            else
            {
                (sender as ASPxCallbackPanel).JSProperties["cpInserted"] = "0";
            }
        }

        public string CreatePassword(int length)
        {
            const string valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            while (0 < length--)
            {
                res.Append(valid[rnd.Next(valid.Length)]);
            }
            return res.ToString();
        }
    }
}