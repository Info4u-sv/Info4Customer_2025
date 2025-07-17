using DevExpress.Web;
using INTRA.AppCode;
using System;

namespace INTRA.Controls
{
    public partial class InvioEmail_PopupAscx : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void InvioEmail_Callback_Callback(object source, CallbackEventArgs e)
        {


            string Mittente = Mittente_Txt.Text;
            string Destinatario = TokenBoxTo.Text;
            string CopiaConoscenza = CopiaConoscenza_Tokenbox.Text;
            string CopiaConoscenzaNascosta = CopiaConoscenzaNascosta_Tokenbox.Text;
            string Oggetto = Oggetto_Txt.Text;
            string Messaggio = Messaggio_HtmlEdit.Html;

#pragma warning disable CS0219 // La variabile 'format' è assegnata, ma il suo valore non viene mai usato
            string format = "pdf";
#pragma warning restore CS0219 // La variabile 'format' è assegnata, ma il suo valore non viene mai usato
#pragma warning disable CS0219 // La variabile 'fileName' è assegnata, ma il suo valore non viene mai usato
            string fileName = string.Empty;
#pragma warning restore CS0219 // La variabile 'fileName' è assegnata, ma il suo valore non viene mai usato


        }

        protected void Mittente_Txt_Init(object sender, EventArgs e)
        {

        }

        protected void InvioEmail_Callbackpnl_Callback(object sender, CallbackEventArgsBase e)
        {
            var Parametri = e.Parameter.Split(';');
            string Destinatario = Parametri[0];
            string Oggetto = Parametri[1];
            string Messaggio = Parametri[2];

            PRT_Parameter _objPrt = new PRT_Parameter();
            string mailfrom = _objPrt.GetPRT_ParameterStringByCode("RmMailShop");
            Mittente_Txt.Text = mailfrom;

            TokenBoxTo.Tokens.Add(Destinatario);
            Oggetto_Txt.Text = Oggetto;
            Messaggio_HtmlEdit.Html = Messaggio;
        }
    }

}