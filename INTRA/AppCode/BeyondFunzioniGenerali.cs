using System.Web.UI;

/// <summary>
/// Descrizione di riepilogo per BeyoundFunzioniGenerali
/// </summary>
/// 
namespace info4lab
{
    public class BeyondFunzioniGenerali
    {
        public BeyondFunzioniGenerali()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }
        public static void Notify1_Success(Page currentPage)
        {
            string url = currentPage.ResolveClientUrl("~/assets/js/jquery.min.js");
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key3", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/jquery.min.js") + "'></script>", false);
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key2", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/toastr/toastr.js") + "'></script>", false);
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/Info4u-Toastr-init.js") + "'></script>", false);
            string NotifyMessage = "Operazione eseguita!";
            string NotifyTypeNotify = "success";
            string NotifyIcon = "fa-check";
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "script", " Notify1('" + NotifyMessage + "', 'top-right', '5000', '" + NotifyTypeNotify + "', '" + NotifyIcon + "', true);", true);
        }
        public static void Notify1_Error(Page currentPage, string ErroreTxt)
        {
            string url = currentPage.ResolveClientUrl("~/assets/js/jquery.min.js");
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key3", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/jquery.min.js") + "'></script>", false);
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key2", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/toastr/toastr.js") + "'></script>", false);
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/Info4u-Toastr-init.js") + "'></script>", false);
            string NotifyMessage = "Si è verifato un errore! <br>" + ErroreTxt;
            string NotifyTypeNotify = "danger";
            string NotifyIcon = "fa-bolt";
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "script", " Notify1('" + NotifyMessage + "', 'top-right', '5000', '" + NotifyTypeNotify + "', '" + NotifyIcon + "', true);", true);
        }
        public static void Notify1_Success_Custom(Page currentPage, string Msg)
        {
            string url = currentPage.ResolveClientUrl("~/assets/js/jquery.min.js");
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key3", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/jquery.min.js") + "'></script>", false);
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key2", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/toastr/toastr.js") + "'></script>", false);
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "a_key", "<script type='text/javascript' src='" + currentPage.ResolveClientUrl("~/assets/js/Info4u-Toastr-init.js") + "'></script>", false);
            string NotifyMessage = "Operazione eseguita!<br>" + Msg;
            string NotifyTypeNotify = "success";
            string NotifyIcon = "fa-check";
            ScriptManager.RegisterStartupScript(currentPage, currentPage.GetType(), "script", " Notify1('" + NotifyMessage + "', 'top-right', '5000', '" + NotifyTypeNotify + "', '" + NotifyIcon + "', true);", true);
        }
    }
}