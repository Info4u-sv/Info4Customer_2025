using info4lab.Portal;
using INTRA.Age_Ordini.AppCode;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Users
{
    public partial class Invio_Email_RecuperoDati : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Manually register the event-handling methods.
            //PasswordRecovery1.SendingMail += new MailMessageEventHandler(this._SendingMail);
            //PasswordRecovery1.SendMailError += new SendMailErrorEventHandler(this._SendMailError);



        }

        protected void _SendingMail(object sender, MailMessageEventArgs e)
        {
            try
            {
                Portal4Set PortalConf = new Portal4Set();

                System.Net.Mail.MailAddress from = new System.Net.Mail.MailAddress(PortalConf.GetConfigurationValue(Portal4Set.Settings.CompanyMail), PortalConf.GetConfigurationValue(Portal4Set.Settings.SiteName));
                //System.Net.Mail.MailAddress copy = new System.Net.Mail.MailAddress("simone.db@info4u.it", "simone");

                e.Message.From = from;
                //e.Message.CC.Add(copy);
                e.Message.Subject = PortalConf.GetConfigurationValue(Portal4Set.Settings.SiteName) + " - Richiesta invio password";
                e.Message.IsBodyHtml = true;


                e.Message.DeliveryNotificationOptions = System.Net.Mail.DeliveryNotificationOptions.OnSuccess;
            }
            catch (Exception ex)
            {
                //MessageBox.Show(ex.ToString());
            }
        }

        protected void _SendMailError(object sender, SendMailErrorEventArgs e)
        {

            //// The MySamplesSite event source has already been created by an administrator.
            //System.Diagnostics.EventLog myLog = new System.Diagnostics.EventLog();
            //myLog.Source = "MySamplesSite";
            //myLog.Log = "Application";
            //myLog.WriteEntry(
            //  "Sending mail via SMTP failed with the following error: " +
            //  e.Exception.Message.ToString(),
            //  System.Diagnostics.EventLogEntryType.Error);

            //e.Handled = true;
        }

        protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
        {
            Portal4Set PortalConf = new Portal4Set();

            System.Net.Mail.MailAddress from = new System.Net.Mail.MailAddress(PortalConf.GetConfigurationValue(Portal4Set.Settings.CompanyMail), PortalConf.GetConfigurationValue(Portal4Set.Settings.SiteName));
            //System.Net.Mail.MailAddress copy = new System.Net.Mail.MailAddress("simone.db@info4u.it", "simone");

            e.Message.From = from;
            //e.Message.CC.Add(copy);
            e.Message.Subject = PortalConf.GetConfigurationValue(Portal4Set.Settings.SiteName) + " - Richiesta invio password";
            e.Message.IsBodyHtml = true;
            EmailUtility.SendMailNoEmbedImg(e.Message);
        }

        protected void InviaMailRecupero_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            MembershipUser User = Membership.GetUser(User_Txt.Text);
            PRT_Parameter parametersGest = new PRT_Parameter();

            object UserGUID = User.ProviderUserKey;
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "/");
            bool MailClienteInvioAbilita = false;
            bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"]?.Trim(), out MailClienteInvioAbilita);

            WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();
            Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");


            _JsonEmail.from = parametersGest.GetPRT_ParameterStringByCode("RmMailShop");
            _JsonEmail.to = User.Email;
            _JsonEmail.OggettoMail = "Recupero dati";
            _JsonEmail.CodParametroTemplate = "RmMailRecuperaPassword";
            

            string mailbodyTemplate = parametersGest.GetPRT_ParameterStringByCode(_JsonEmail.CodParametroTemplate);
            string imgTemplate = parametersGest.GetPRT_ParameterStringByCode("UrlDominioPerImgEmail");
            string footer = parametersGest.GetPRT_ParameterStringByCode("FooterEmail");

            string nomeUtente = User_Txt.Text;
            string linkRecupero = $"{strUrl}/Users/Recupero_Dati.aspx?Userid={UserGUID}";

            string mailbody = string.Format(mailbodyTemplate, nomeUtente, linkRecupero);

            string body = EmailUtility.PrepareMailBodyWith(
                "MasterEmailV2.html", "MailTitle", _JsonEmail.OggettoMail, "MailBody", mailbody, "MailFooter", footer, "UrlSite", imgTemplate, "Company", " ");

            string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");
            if (MailClienteInvioAbilita)
            {
                Ws.TestSendEmai(_JsonEmail.from, _JsonEmail.to, body, _JsonEmail.OggettoMail);
            }
            InviaEmail_Btn.Visible = false;
        }

        private string PopulateBody(string userName, string url)
        {
            Portal4Set PortalConf = new Portal4Set();
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("/MailTemplates/PasswordRecovery.htm")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("<%Username%>", userName);
            body = body.Replace("<%LinkRecupero%>", url);
            body = body.Replace("<%MailFooter%>", PortalConf.GetConfigurationValue(Portal4Set.Settings.Company) + " - " + PortalConf.GetConfigurationValue(Portal4Set.Settings.CompanyAddress)) + ", " + PortalConf.GetConfigurationValue(Portal4Set.Settings.CompanyCap) + ", " + PortalConf.GetConfigurationValue(Portal4Set.Settings.CompanyCity) + " (" + PortalConf.GetConfigurationValue(Portal4Set.Settings.CompanyProvince) + ")";
            return body;
        }

    }
}