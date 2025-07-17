using DevExpress.Web;
using DevExpress.Web.Internal;
using INTRA.SuperAdmin.AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace INTRA.SuperAdmin.UserGest
{
    public partial class edit_user_tm : System.Web.UI.Page
    {
        string username = string.Empty;
        string userId = string.Empty;
        MembershipUser user;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                userId = Request.QueryString["userId"];
                if (string.IsNullOrEmpty(userId))
                {
                    Response.Redirect("users.aspx");
                }

                user = PRT_Users_SA.GetUserById(userId);
                username = user.UserName;

                Session["username"] = username;
                Session["userName"] = username;

                CaricaDatiUtente();
                RuoliAbilitati = false;
                CaricaRuoliUtente();
                LoadPrivileges();
            }
        }
        protected void PrivilegesPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            string param = e.Parameter;
            if (param == "load")
            {
                LoadPrivileges();
            }
            else if (param == "save")
            {
                UpdatePermessi();
                LoadPrivileges();
            }
        }
        private void LoadPrivileges()
        {
            try
            {
                string username = UserTxt.Text; 
                string strQuery = $"EXEC sp_um_getUserPrivileges '{username}'";
                DataSet ds = DataControl.GetDataSet(strQuery);
                if (ds != null && ds.Tables.Count > 0)
                {
                    grdPrivileges.DataSource = ds.Tables[0];
                    grdPrivileges.DataBind();
                }
            }
            catch (Exception ex)
            {
               
            }
        }
        private void UpdatePermessi()
        {
            try
            {
                string username = UserTxt.Text; 
                for (int i = 0; i < grdPrivileges.Rows.Count; i++)
                {
                    int intFormId = int.Parse(((HiddenField)grdPrivileges.Rows[i].FindControl("hdnFormId")).Value);
                    bool isAdd = ((CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxAdd")).Checked;
                    bool isDelete = ((CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxDelete")).Checked;
                    bool isModify = ((CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxModify")).Checked;
                    bool isRead = ((CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxRead")).Checked;

                    string strQuery = $"UPDATE tbl_um_privilege SET " +
                                      $"add_permission = '{isAdd}', " +
                                      $"delete_permission = '{isDelete}', " +
                                      $"modify_permission = '{isModify}', " +
                                      $"read_permission = '{isRead}' " +
                                      $"WHERE form_id_fk = '{intFormId}' AND user_id_fk = '{username}'";

                    DataControl.ExecuteNonQuery(strQuery);
                }
            }
            catch (Exception ex)
            {
                // Log error ecc
            }
        }
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            // Carica solo se non è callback
            if (!IsCallback)
            {
                CaricaRuoliUtente();
            }
        }
        protected void CaricaDatiUtente()
        {
            username = Session["username"] as string;
            if (!string.IsNullOrEmpty(username))
            {
                user = Membership.GetUser(username);
                if (user != null)
                {
                    InfoUser.DataSource = new MembershipUser[] { user };
                    InfoUser.DataBind();

                    UserTxt.Text = user.UserName;
                    RegMailTxt.Text = user.Email;
                }
            }
        }
        protected void EditAndRolesPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string param = e.Parameter.ToUpperInvariant();
            username = Session["username"] as string;
            if (string.IsNullOrEmpty(username)) return;

            if (param.StartsWith("SALVA"))
            {
                // estraggo ruolo dalla stringa
                var parts = e.Parameter.Split('|');
                string[] selectedRoles = parts.Length > 1 ? parts[1].Split(',') : new string[0];

                SalvaRuoliUtente(selectedRoles);
                EditAndRolesPanel.JSProperties["cpShowPanel"] = true;
                UserRoles.Items.Clear();
                UserRoles.Enabled = true;

                string[] allRoles = Roles.GetAllRoles();
                string[] userRoles = Roles.GetRolesForUser(username);

                foreach (string role in allRoles)
                {
                    ListItem item = new ListItem(role);
                    item.Selected = userRoles.Contains(role);
                    UserRoles.Items.Add(item);
                }
            }

            if (param == "LOAD" || param == "SHOW")
            {
                user = Membership.GetUser(username);
                if (user != null)
                {
                    UserTxt.Text = user.UserName;
                    RegMailTxt.Text = user.Email;
                    InfoUser.DataSource = new MembershipUser[] { user };
                    InfoUser.DataBind();
                }

                UserRoles.Items.Clear();
                UserRoles.Enabled = true;

                string[] allRoles = Roles.GetAllRoles();
                string[] userRoles = Roles.GetRolesForUser(username);

                foreach (string role in allRoles)
                {
                    ListItem item = new ListItem(role);
                    item.Selected = userRoles.Contains(role);
                    UserRoles.Items.Add(item);
                }

                EditAndRolesPanel.JSProperties["cpShowPanel"] = true;
            }
        }



        protected void AnagraficaUserPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            username = Session["username"] as string;


            if (e.Parameter == "ABILITA")
            {
                // abilita campi
                NomeTxt.ClientEnabled = true;
                CognomeTxt.ClientEnabled = true;
                SocietaTxt.ClientEnabled = true;
                TipoSocietaTxt.ClientEnabled = true;
                TelPrivTxt.ClientEnabled = true;
                FaxPrivTxt.ClientEnabled = true;
                ContactMailTxt.ClientEnabled = true;
                CodFiscPrivTxt.ClientEnabled = true;
                IndPrivTxt.ClientEnabled = true;
                CapPrivTxt.ClientEnabled = true;
                CittaPrivTxt.ClientEnabled = true;
                ProvPrivTxt.ClientEnabled = true;
                btnSaveRegister.ClientEnabled = true;

                // carica profilo utente
                string username = Session["username"] as string;
                dynamic profile = ProfileBase.Create(username);
                if (profile != null)
                {
                    NomeTxt.Text = profile.nome ?? "";
                    CognomeTxt.Text = profile.cognome ?? "";
                    SocietaTxt.Text = profile.Societa ?? "";
                    //TipoSocietaTxt.Text = profile.TipoSocieta ?? "";
                    CodFiscPrivTxt.Text = profile.CodiceFiscale ?? "";
                    IndPrivTxt.Text = profile.Indirizzo ?? "";
                    CapPrivTxt.Text = profile.Cap ?? "";
                    CittaPrivTxt.Text = profile.citta ?? "";
                    ProvPrivTxt.Text = profile.Provincia ?? "";
                    TelPrivTxt.Text = profile.Telefono ?? "";
                    FaxPrivTxt.Text = profile.fax ?? "";
                    firmaTecnico.Src = profile.FirmaTecnico;
                    ImgTecnico.Src = profile.ImgTecnico;
                    ContactMailTxt.Text = profile.email ?? "";
                }
                else
                {
                    NomeTxt.Text = "Utente non trovato";
                    CognomeTxt.Text = "";
                }

                // mostra il pannello
                AnagraficaUser.JSProperties["cpShowPanel"] = true;
            }
        }

        protected void BtnSaveRegister_Click(object sender, EventArgs e)
        {
            //raccolta e salvataggio dati
            dynamic MyProfile = ProfileBase.Create(UserTxt.Text);

            try
            {
                MyProfile.nome = NomeTxt.Text;
                MyProfile.cognome = CognomeTxt.Text;
                MyProfile.Societa = SocietaTxt.Text;
                MyProfile.tipo_soc = TipoSocietaTxt.Text;
                MyProfile.CodiceFiscale = CodFiscPrivTxt.Text;
                MyProfile.Indirizzo = IndPrivTxt.Text;
                MyProfile.Cap = CapPrivTxt.Text;
                MyProfile.citta = CittaPrivTxt.Text;
                MyProfile.Provincia = ProvPrivTxt.Text;
                MyProfile.Telefono = TelPrivTxt.Text;
                MyProfile.fax = FaxPrivTxt.Text;
                MyProfile.email = ContactMailTxt.Text;
                MyProfile.ImgTecnico = ImgTextArea.Value;
                MyProfile.Save();
            }
            catch (Exception ex)
            {
                string PathIntranetAssoluto = Server.MapPath("~/").ToString();
                LogFile Errore = new LogFile();
                System.Web.Security.MembershipUser edtUsr = Membership.GetUser();
                Errore.ErrorLog(PathIntranetAssoluto + "\\Error_LogFile\\LogFile", "Errore: " + "  -  " + edtUsr.UserName + "  -  " + ex);
                Response.Redirect("edit_user_tm.aspx?username=" + UserTxt.Text + "&Msg=0");
            }

            Response.Redirect("edit_user_tm.aspx?username=" + UserTxt.Text + "&Msg=1");
        }
        protected void FirmaTecnico_LinkB_Click(object sender, EventArgs e)
        {
            Response.Redirect("Firma_Tecnico.aspx?username=" + UserTxt.Text);
        }
        protected void ASPxUploadControl1_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            Session["ImgUpload"] = null;
            Session["ImgUpload"] = e.UploadedFile.FileBytes;
        }
        protected void CaricaRuoliUtente()
        {
            if (UserRoles == null) return;

            string currentUsername = Session["username"] as string;
            if (string.IsNullOrEmpty(currentUsername))
                return;

            string[] allRoles = Roles.GetAllRoles();
            string[] userRoles = Roles.GetRolesForUser(currentUsername);

            // Se la lista è vuota, riempi (caricamento iniziale)
            if (UserRoles.Items.Count == 0)
            {
                foreach (string role in allRoles)
                {
                    ListItem item = new ListItem(role);
                    item.Selected = userRoles.Contains(role);
                    UserRoles.Items.Add(item);
                }
            }
            else
            {
                // Aggiorna solo selezione
                foreach (ListItem item in UserRoles.Items)
                {
                    item.Selected = userRoles.Contains(item.Value);
                }
            }

            UserRoles.Enabled = RuoliAbilitati;
        }

        private bool RuoliAbilitati
        {
            get { return ViewState["RuoliAbilitati"] != null && (bool)ViewState["RuoliAbilitati"]; }
            set { ViewState["RuoliAbilitati"] = value; }
        }



        private void SalvaRuoliUtente(string[] selectedRoles)
        {
            string username = Session["username"] as string;
            if (string.IsNullOrEmpty(username)) return;

            string[] ruoliAttuali = Roles.GetRolesForUser(username);

            // Aggiungi i ruoli selezionati che mancano
            foreach (var role in selectedRoles)
            {
                if (!ruoliAttuali.Contains(role))
                    Roles.AddUserToRole(username, role);
            }
            // Rimuovi i ruoli non selezionati
            foreach (var role in ruoliAttuali)
            {
                if (!selectedRoles.Contains(role))
                    Roles.RemoveUserFromRole(username, role);
            }

            var priv = new PRT_Privilege_SA();
            priv.tbl_um_privilege_By_UserVsRoles_SET(username);
        }



        protected void Button3_Click(object sender, EventArgs e)
        {
            var user = Membership.GetUser(Session["username"].ToString());
            user.ChangePassword(user.ResetPassword(), NewPassword_Txt.Text);
            Response.Redirect("edit_user_tm.aspx?username=" + UserTxt.Text + "&Msg=1");
        }

    }
}