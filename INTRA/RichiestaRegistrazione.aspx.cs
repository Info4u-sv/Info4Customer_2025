using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace INTRA
{
    public partial class RichiestaRegistrazione : System.Web.UI.Page
    {
        protected void Registrazione_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            try
            {
                //MembershipCreateStatus status;
                //MembershipUser newUser = Membership.GetUser(eMailTextBox.Text, passwordTextBox.Text, eMailTextBox.Text, "info4u", "yes", true, out status);

                //string Error = status.ToString();

                //if (newUser == null)
                //{
                //    if (status == MembershipCreateStatus.DuplicateUserName) { Registrazione_CallbackPnl.JSProperties["cpErrorPopup"] = 1; }
                   
                //}
                //else
                //{

                    //newUser.Comment = "";
                    //Membership.UpdateUser(newUser);

                    VIO_Parametri Get = new VIO_Parametri();
                    string ImgTecnico = Get.GetValue("Value", "DefaultUserImg", "PRT_Parameter", "CodParam");
 
                    FormLayout.Visible = false;
                    RegistrazioneAvvenuta_FormLayout.ClientVisible = true;

                    //MembershipUser mu = Membership.GetUser(eMailTextBox.Text);
                    Appoggio_Dts.InsertParameters["RagioneSociale"].DefaultValue = RagioneSOciale_Txt.Text;
                    Appoggio_Dts.InsertParameters["NomeCompleto"].DefaultValue = NomeCognome_Txt.Text;
                    Appoggio_Dts.InsertParameters["PIva"].DefaultValue = PartitaIva_Txt.Text;
                    Appoggio_Dts.InsertParameters["CFiscale"].DefaultValue = CodiceFiscale_Txt.Text;
                    Appoggio_Dts.InsertParameters["Email"].DefaultValue = Email_Txt.Text;
                    Appoggio_Dts.Insert();
                //}
            }
            catch { }

            Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");

            WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();
            INTRA.AppCode.PRT_Parameter _objPrt = new INTRA.AppCode.PRT_Parameter();
            string mailfrom = _objPrt.GetPRT_ParameterStringByCode("RmMailShop");
            string UrlDomino = _objPrt.GetPRT_ParameterStringByCode("RmUrlDominio");
            string footer = _objPrt.GetPRT_ParameterStringByCode("FooterEmail");
            string dominioImg = _objPrt.GetPRT_ParameterStringByCode("UrlDominioPerImgEmail");
            // Da rimettere
            //_JsonEmail.from = mailfrom;
            //_JsonEmail.to = mailfrom;
            // Per testare
            _JsonEmail.from = "m.lamacchia@info4lab.it";
            _JsonEmail.to = "m.lamacchia@info4lab.it";

            _JsonEmail.OggettoMail = "Richiesta registrazione";
            _JsonEmail.CodParametroTemplate = "RmMailConfermaRichiesta";
            //Da rimettere
           string mailbodyTemplate = _objPrt.GetPRT_ParameterStringByCode(_JsonEmail.CodParametroTemplate);
            string nomeCognome = NomeCognome_Txt.Text;
            // Da Rimettere
            string mailbody = string.Format(mailbodyTemplate, nomeCognome, UrlDomino);

            string body = EmailUtility.PrepareMailBodyWith(
                "MasterEmailV2.html", "MailTitle", _JsonEmail.OggettoMail, "MailBody", mailbody, "MailFooter", footer, "UrlSite", dominioImg, "Company", " ");
            string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");
            Ws.TestSendEmai(_JsonEmail.from, _JsonEmail.to, body, _JsonEmail.OggettoMail);

            //string[] ArrayParam = { NomeCognome_Txt.Text, RagioneSOciale_Txt.Text, PartitaIva_Txt.Text, UrlDomino, Email_Txt.Text };
            //_WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);

            // Da rimettere
            //_JsonEmail.from = mailfrom;
            //_JsonEmail.to = Email_Txt.Text;
            // Per testare
            _JsonEmail.from = "m.lamacchia@info4lab.it";
            _JsonEmail.to = "m.lamacchia@info4lab.it";
            _JsonEmail.OggettoMail = "Richiesta registrazione completata con successo";
            _JsonEmail.CodParametroTemplate = "RmMailConfermaRichiestaUtente";
            //Da rimettere
            //string mailbodyTemplate2 = _objPrt.GetPRT_ParameterStringByCode(_JsonEmail.CodParametroTemplate);
            nomeCognome = NomeCognome_Txt.Text;
            // Da rimettere
            //mailbody = string.Format(mailbodyTemplate2, nomeCognome, UrlDomino);
            body = EmailUtility.PrepareMailBodyWith(
               "MasterEmailV2.html", "MailTitle", "Titolo", "MailBody", "Messaggio", "MailFooter", "Footer", "UrlSite", " ", "Company", " ");
            erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");

            Ws.TestSendEmai(_JsonEmail.from, _JsonEmail.to, body, _JsonEmail.OggettoMail);


            //string[] ArrayParam2 = { NomeCognome_Txt.Text, RagioneSOciale_Txt.Text, PartitaIva_Txt.Text, UrlDomino, Email_Txt.Text };
            //_WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam2);

        }
        public MembershipUser MyCreateUser(string username, string password, string email,
                                   string question, string answer)
        {
            MembershipCreateStatus status;

            MembershipUser u = Membership.CreateUser(username, password, email, question, answer, true, out status);
            if (u == null)
            {
                string errortxt = "errore";
                string statusTxt = status.ToString();
                //switch (status)
                //{
                //    case MembershipCreateStatus.DuplicateUserName:
                //    //case MembershipCreateStatus.DuplicateUserName:
                //    //    {
                //    //        ASPxLabel1.Text = errortxt;
                //    //    }

                //}

                //error = GetErrorMessage(status);


            }

            return u;
        }

        public string GetErrorMessage(MembershipCreateStatus status)
        {
            switch (status)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Username already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A username for that email address already exists. Please enter a different email address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The email address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }

        protected void Registrazione_CallbackPnl_CustomJSProperties(object sender, DevExpress.Web.CustomJSPropertiesEventArgs e)
        {
         
        }
    }
}