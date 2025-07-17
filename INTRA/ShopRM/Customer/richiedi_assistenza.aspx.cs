using DevExpress.Web;
using INTRA.AppCode;
using INTRA.SuperAdminMiele.AppCode;
using System;
using System.Web.Security;

namespace INTRA.ShopRM.Customer
{
    public partial class richiedi_assistenza : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void InviaEmail_callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            MembershipUser User = Membership.GetUser();
            string FromMail = PRT_Parameter_23.GetPRT_ParameterValueByCodParam("EmailMittente"); ;
            try
            {
                webservice_secondo.WebService_primoSoapClient _WebS_primo = new webservice_secondo.WebService_primoSoapClient("WebService_primoSoap");
                webservice_secondo.JsonEmail _JsonEmail = new webservice_secondo.JsonEmail();
                string EmailCat = new SuperAdminMiele.AppCode.CAT_CRUD()[User.UserName].EMail;

                _JsonEmail.from = FromMail;
                _JsonEmail.EmailToSendTo = new string[2];
                _JsonEmail.EmailToSendTo[0] = User.Email;
                _JsonEmail.EmailToSendTo[1] = EmailCat;
                _JsonEmail.OggettoMail = Oggetto_txt.Text;
                _JsonEmail.CodParametroTemplate = "TemplateEmailRichiestaAssistenza"; // passo il nome del paramentro della PRT_Parameter_Crud
                ClientiCat_Crud cliente = ClientiCat_Crud.GetClienteDataForEmail(User.UserName);
                CAT CatData = new CAT_CRUD()[User.UserName];
                string[] ArrayParam = { cliente.NomeCompleto, cliente.Tel, cliente.EMail, Oggetto_txt.Text, Message_memo.Text, CatData.RagSoc };

                _WebS_primo.SendMultipleMailDBTemplate(_JsonEmail, ArrayParam);
            }
            catch (Exception ex)
            {
                ((ASPxCallback)source).JSProperties["cpError"] = ex.Message;
            }
        }
    }
}