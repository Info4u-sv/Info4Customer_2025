using DevExpress.CodeParser;
using Info4U.Models;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using Microsoft.Exchange.WebServices.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebService4u;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace INTRA
{
    public partial class TestInvioEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Click(object sender, EventArgs e)
        {
            MembershipUser User = Membership.GetUser(Context.User.Identity.Name);
            WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();
            PRT_Parameter parametersGest = new PRT_Parameter();
            object UserGUID = User.ProviderUserKey;
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "/");
            bool MailClienteInvioAbilita = false;
            bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"], out MailClienteInvioAbilita);

            _JsonEmail.from = parametersGest.GetPRT_ParameterStringByCode("RmMailShop");
            _JsonEmail.to = User.Email;
            _JsonEmail.OggettoMail = "Recupero dati";
            _JsonEmail.CodParametroTemplate = "RmMailRecuperaPassword";

            string mailbodyTemplate = parametersGest.GetPRT_ParameterStringByCode(_JsonEmail.CodParametroTemplate);
            string imgTemplate = parametersGest.GetPRT_ParameterStringByCode("UrlDominioPerImgEmail");
            string footer = parametersGest.GetPRT_ParameterStringByCode("FooterEmail");
            string nomeUtente = User.UserName;
            string linkRecupero = $"{strUrl}/Users/Recupero_Dati.aspx?Userid={UserGUID}";

            string mailbody = string.Format(mailbodyTemplate, nomeUtente, linkRecupero);

            string body = EmailUtility.PrepareMailBodyWith(
                "MasterEmailV2.html", "MailTitle", _JsonEmail.OggettoMail, "MailBody", mailbody, "MailFooter", footer, "UrlSite", imgTemplate, "Company", " ");

            string mailfrom = "m.lamacchia@info4lab.it";

            string query = "SELECT Email FROM U_Workflow_Email WHERE CodParam = @CodParam";
            SqlDataReader reader = new AppCode.Sql4Helper().ExecuteReader(query, new SqlParameter() { ParameterName = "@CodParam", Value = "TestInsert" });
            if (reader.Read())
            {
                foreach (string EmailCliente in reader["Email"].ToString().Split(','))
                {
                    Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");
                    string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");

                    if (string.IsNullOrEmpty(erroreConnessione))
                    {
                        if (MailClienteInvioAbilita)
                        {
                            Ws.TestSendEmai(mailfrom, EmailCliente, body, _JsonEmail.OggettoMail);
                        }
                    }
                }
            }
        }

    }
}