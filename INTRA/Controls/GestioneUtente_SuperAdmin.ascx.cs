using DevExpress.DataAccess.DataFederation;
using DevExpress.Web;
using DevExpress.Web.ASPxHtmlEditor;
using INTRA.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace INTRA.Controls
{
    public partial class GestioneUtente_SuperAdmin : System.Web.UI.UserControl
    {
        public MembershipUser user { get; set; }
        public DetailsView UserInfo { get; set; }

        public bool GenerVIO_ClienEnabled { get; set; } = false;

        public string RefreshPanel { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = Request.QueryString["userId"];
            if (!string.IsNullOrEmpty(userId))
            {
                user = Membership.GetUser(Guid.Parse(userId));
            }
            //GeneraUtenteVIO_btn.ClientEnabled = GenerVIO_ClienEnabled;
            GeneraUtenteVIO_btn.ClientEnabled = true;
        }
        public void UnlockUser()
        {
            // Dan Clem, added 5/30/2007 post-live upgrade.

            // Unlock the user.
            user.UnlockUser();

            //// DataBind the GridView to reflect same.
            //UserInfo.DataBind();
        }

        public void DeleteUser()
        {
            //Membership.DeleteUser(username, false); // DC: My apps will NEVER delete the related data.
            try
            {
                Membership.DeleteUser(user.UserName, true); // DC: except during testing, of course!

                // Rimuovo i privilegi in base ai ruoli 
                AppCode.PRT_Privilege_SA _objPriv = new AppCode.PRT_Privilege_SA();
                _objPriv.sp_um_DeleteUserPrivileges(user.UserName);

                Response.Redirect("users.aspx");
            }

            catch (Exception ex)
            {
                string PathIntranetAssoluto = Server.MapPath("~/").ToString();
                LogFile Errore = new LogFile();
                System.Web.Security.MembershipUser edtUsr = Membership.GetUser();
                Errore.ErrorLog(PathIntranetAssoluto + "\\Error_LogFile\\LogFile", "Errore: " + "  -  " + edtUsr.UserName + "  -  " + ex);

            }
        }

        protected void UtenteGest_callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string TipoChiamata = e.Parameter;
            string result = "NoResult";
            string RefreshPanel = null;
            switch (TipoChiamata)
            {
                case "SBLOCCA":
                    UnlockUser();
                    RefreshPanel = this.RefreshPanel;
                    break;
                case "ELIMINA":
                    DeleteUser();
                    RefreshPanel = this.RefreshPanel;
                    break;
                case "GENERAVIO":
                case "OPENPOPUP":
                    ASPxTextBox Utente = (ASPxTextBox)GeneraVio_popup.FindControl("UtenteIntranet_txt");
                    ASPxTextBox Email = (ASPxTextBox)GeneraVio_popup.FindControl("Email_txt");
                    ASPxTextBox Nome = (ASPxTextBox)GeneraVio_popup.FindControl("Nome_txt");
                    ASPxTextBox Cognome = (ASPxTextBox)GeneraVio_popup.FindControl("Cognome_txt");
                    ASPxHtmlEditor FirmaUtente = (ASPxHtmlEditor)GeneraVio_popup.FindControl("FirmaEmail_html");
                    ASPxComboBox TipologiaUtente = (ASPxComboBox)GeneraVio_popup.FindControl("TipologiaUtente_combox");
                    ASPxTextBox UtenteSMTP = (ASPxTextBox)GeneraVio_popup.FindControl("UtenteSMTP_txt");
                    ASPxTextBox PasswordSMTP = (ASPxTextBox)GeneraVio_popup.FindControl("PasswordSMTP_txt");
                    if (TipoChiamata == "OPENPOPUP")
                    {
                        result = $"{user.UserName}|{user.Email}";
                    }
                    else
                    {
                        VIO_Utenti_CRUD_23 UtenteVIO = new VIO_Utenti_CRUD_23();
                        UtenteVIO.UtenteIntranet = Utente.Text;
                        UtenteVIO.EmailContatto = Email.Text;
                        UtenteVIO.Tipologia = TipologiaUtente.Value as string;
                        UtenteVIO.Nome = Nome.Text;
                        UtenteVIO.Cognome = Cognome.Text;
                        UtenteVIO.Azienda = ConfigurationManager.AppSettings["RagSoc"].ToString();
                        UtenteVIO.FirmaEmail = string.IsNullOrEmpty(FirmaUtente.Html) ? null : FirmaUtente.Html;
                        UtenteVIO.DataBlocco = DateTime.Now.AddYears(100);
                        UtenteVIO.UtenteSMTP = UtenteSMTP.Text;
                        //UtenteVIO.PasswordSMTP = DataControl.Encrypt(PasswordSMTP.Text);

                        int resultIns = UtenteVIO.VIO_Utenti_INSERT(UtenteVIO);
                    }
                    break;
            }

            e.Result = result;

            ((ASPxCallback)source).JSProperties["cpRefreshCallback"] = RefreshPanel;
        }
        protected void CheckEmailValid_Callback_Callback(object source, CallbackEventArgs e)
        {
            var Users = Membership.FindUsersByEmail(e.Parameter);
            bool validity = false;
            if (Users.Count == 1)
            {
                string UserName = Session["UsernameModPsw"] as string;
                validity = (!string.IsNullOrEmpty(UserName)) || (Users[UserName] != null && Users[UserName].UserName == UserName);
            }
            else
            {
                validity = Users.Count == 0;
            }
            e.Result = !validity ? "0" : "1";

        }
        protected string GetDecryptedPassword(string Cripted)
        {
            return DataControl.Decrypt(Cripted);
        }

        protected void Reset_Callback_Callback(object source, CallbackEventArgs e)
        {
            string username = string.Empty;
            string ruolo = Ruolo_cb.Text;
            SqlDataReader reader = new Sql4Helper().ExecuteReader("SELECT UserName FROM aspnet_Users WHERE UserId = @User", new SqlParameter { ParameterName = "@User", Value = Request["userId"] });
            if (reader.Read())
            {
                username = reader["UserName"] as string;
            }
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@Rules_id_fk", ruolo);
            objParams[1] = new SqlParameter("@UserName", username);
            objSqlHelper.ExecuteNonQueryForNews("PRT_Privilege_Reset_Users", objParams);
        }
    }
}