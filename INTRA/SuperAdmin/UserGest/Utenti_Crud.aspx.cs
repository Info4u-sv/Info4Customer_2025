using DevExpress.CodeParser;
using DevExpress.Web;
using DevExpress.Web.Bootstrap;
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
    public partial class Utenti_Crud : System.Web.UI.Page
    {
        MembershipUser UserLog = Membership.GetUser();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["TipologiaSession"] = null;

            }
            if (Session["TipologiaSession"] != null)
            {
                Session["TipologiaSession"] = Session["TipologiaSession"];
                Generic_Gridview.DataBind();
            }
        }


        protected void Cards_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            Session["TipologiaSession"] = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();
            Generic_Gridview.CancelEdit();
        }

        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            BootstrapTextBox Nome_txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Nome_txt");
            BootstrapTextBox Cognome_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            ASPxTokenBox Societa_TokenBox = (ASPxTokenBox)Edit_FormLayout.FindControl("Societa_TokenBox");
            BootstrapTextBox Telefono_txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            BootstrapTextBox Codicefiscale_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            BootstrapTextBox Indirizzo_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            BootstrapTextBox Cap_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            BootstrapTextBox Citta_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            BootstrapTextBox Provincia_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            BootstrapTextBox NomeUtenteIntranet_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            //BootstrapTextBox Password_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Password_Txt");
            BootstrapTextBox Email_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Email_Txt");
            BootstrapTextBox EmailAzienda_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("EmailAzienda_Txt");
            //BootstrapTextBox EmailTicket_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("EmailTicket_Txt");
            //ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");
            ASPxTextBox CodLis_Llb = (ASPxTextBox)Edit_FormLayout.FindControl("CodLis_Llb");


            MembershipUser newUser = Membership.CreateUser(NomeUtenteIntranet_Txt.Text, CreatePassword(10), Email_Txt.Text);
            newUser.Comment = string.Empty;
            Membership.UpdateUser(newUser);

            Roles.AddUserToRole(NomeUtenteIntranet_Txt.Text, grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString());
            PRT_Privilege_SA _objPriv = new PRT_Privilege_SA();
            _objPriv.tbl_um_privilege_By_UserVsRoles_SET(NomeUtenteIntranet_Txt.Text);

            VIO_Parametri Get = new VIO_Parametri();
            string ImgTecnico = Get.GetValue("Value", "DefaultUserImg", "PRT_Parameter", "CodParam");


            dynamic MyProfile = ProfileBase.Create(NomeUtenteIntranet_Txt.Text, true);
            MyProfile.nome = Nome_txt.Text;
            MyProfile.cognome = Cognome_Txt.Text;
            MyProfile.Societa = Societa_TokenBox.Text;
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

            MyProfile.CodCli = Societa_TokenBox.Value.ToString();
            MyProfile.CodLis = CodLis_Llb.Text;
            MyProfile.Save();




            //e.NewValues["EmailTicket"] = EmailTicket_Txt.Text;
            e.NewValues["UtenteIntranet"] = NomeUtenteIntranet_Txt.Text;
            e.NewValues["EmailContatto"] = Email_Txt.Text;
            //e.NewValues["DataBlocco"] = DataBlocco_DateEdit.Date;
            e.NewValues["Tipologia"] = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();
            e.NewValues["Azienda"] = Societa_TokenBox.Text;
            e.NewValues["CodCli"] = Societa_TokenBox.Value;
            EditForm_CallbackPanel.JSProperties["cpDatiValidi"] = 1;

            //WebReference4u.WebService_primo _WebS_primo = new WebReference4u.WebService_primo();
            //WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();
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
            //SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();

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

            //string[] ArrayParam = { Nome_txt.Text + " " + Cognome_Txt.Text, NomeUtenteIntranet_Txt.Text, PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.SiteUrl).ToString() + "/Users/Recupero_Dati.aspx?Userid=" + UserGUID };
            //_WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);

        }

        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            BootstrapTextBox Nome_txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Nome_txt");
            BootstrapTextBox Cognome_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            BootstrapTextBox Telefono_txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            BootstrapTextBox Codicefiscale_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            BootstrapTextBox Indirizzo_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            BootstrapTextBox Cap_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            BootstrapTextBox Citta_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            BootstrapTextBox Provincia_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            BootstrapTextBox NomeUtenteIntranet_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            BootstrapTextBox Email_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Email_Txt");

            dynamic MyProfile = ProfileBase.Create(NomeUtenteIntranet_Txt.Text, true);
            MyProfile.nome = Nome_txt.Text;
            MyProfile.cognome = Cognome_Txt.Text;
            MyProfile.CodiceFiscale = Codicefiscale_Txt.Text;
            MyProfile.Indirizzo = Indirizzo_Txt.Text;
            MyProfile.Cap = Cap_Txt.Text;
            MyProfile.citta = Citta_Txt.Text;
            MyProfile.Provincia = Provincia_Txt.Text;
            MyProfile.Telefono = Telefono_txt.Text;

            MyProfile.Save();

            e.NewValues["EmailContatto"] = Email_Txt.Text;
            EditForm_CallbackPanel.JSProperties["cpDatiValidi"] = 1;
        }

        protected void EditForm_CallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            BootstrapTextBox Nome_txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Nome_txt");
            BootstrapTextBox Cognome_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            ASPxTokenBox Societa_TokenBox = (ASPxTokenBox)Edit_FormLayout.FindControl("Societa_TokenBox");
            BootstrapTextBox Telefono_txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            //BootstrapTextBox Fax_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Fax_Txt");
            BootstrapTextBox Codicefiscale_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            BootstrapTextBox Indirizzo_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            BootstrapTextBox Cap_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            BootstrapTextBox Citta_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            BootstrapTextBox Provincia_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            BootstrapTextBox Password_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Password_Txt");
            BootstrapButton SalvaEdit_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("SalvaEdit_Btn");
            BootstrapButton Salva_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("Salva_Btn");
            //BootstrapTextBox CheckPassword_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("CheckPassword_Txt");
            BootstrapTextBox EmailAzienda_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("EmailAzienda_Txt");
            //BootstrapTextBox EmailTicket_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("EmailTicket_Txt");

            //ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");

            BootstrapTextBox NomeUtenteIntranet_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            BootstrapTextBox Email_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Email_Txt");

            INTRA.AppCode.ProfileInfo Check = new INTRA.AppCode.ProfileInfo();
            bool EsisteUtente = false;
            bool EsisteEmail = false;
            VIO_Parametri Get = new VIO_Parametri();
            int GiorniDaAggiungere = Convert.ToInt32(Get.GetValue("Value", "GiorniScadenza", "VIO_Parametri", "Name"));
            if (grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString() == "Cliente")
            {
                Societa_TokenBox.ValidationSettings.RequiredField.IsRequired = true;
                Societa_TokenBox.ValidationSettings.ValidationGroup = "NuovoUtenteValid";
                //DataBlocco_DateEdit.Date = DateTime.Now.AddDays(GiorniDaAggiungere);
            }
            if (e.Parameter == "1")
            {

                EsisteUtente = Check.EsistenzaValoreUtente_Check("UserName", NomeUtenteIntranet_Txt.Text, "vw_aspnet_Users");
                if (EsisteUtente)
                {
                    EditForm_CallbackPanel.JSProperties["cpNomeUtenteValido"] = 0;
                    EditForm_CallbackPanel.JSProperties["cpNomeUtenteNonValido"] = NomeUtenteIntranet_Txt.Text;
                }
                else
                {
                    EditForm_CallbackPanel.JSProperties["cpNomeUtenteValido"] = 1;
                }


                EsisteEmail = Check.EsistenzaValoreUtente_Check("Email", Email_Txt.Text, "aspnet_Membership");
                if (EsisteEmail)
                {
                    EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 0;
                    EditForm_CallbackPanel.JSProperties["cpNEmailNonValida"] = Email_Txt.Text;
                }
                else
                {
                    EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 1;
                }
            }
            else if (e.Parameter == "2")
            {
                string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
                MembershipUser UserLog = Membership.GetUser(Username);

                dynamic MyProfile = ProfileBase.Create(Username);
                NomeUtenteIntranet_Txt.Enabled = false;
                Email_Txt.Enabled = false;
                Salva_Btn.ClientVisible = false;
                SalvaEdit_Btn.ClientVisible = true;
                //CheckPassword_Txt.Enabled = false;
                Societa_TokenBox.Text = MyProfile.Societa;
                EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 1;
                EditForm_CallbackPanel.JSProperties["cpNomeUtenteValido"] = 1;
                EditForm_CallbackPanel.JSProperties["cpUpdate"] = 1;
            }

            else if (e.Parameter == "3")
            {
                //BootstrapTextBox Ruolo_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Ruolo_Txt");
                //Ruolo_Txt.Text = 
                Societa_TokenBox.Enabled = false;
                string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
                MembershipUser UserLog = Membership.GetUser(Username);

                dynamic MyProfile = ProfileBase.Create(Username);
                Nome_txt.Text = MyProfile.nome;
                Cognome_Txt.Text = MyProfile.cognome;
                Societa_TokenBox.Text = MyProfile.Societa;
                Codicefiscale_Txt.Text = MyProfile.CodiceFiscale;
                Indirizzo_Txt.Text = MyProfile.Indirizzo;
                //EmailTicket_Txt.Text = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "EmailTicket").ToString();
                Cap_Txt.Text = MyProfile.Cap;
                Citta_Txt.Text = MyProfile.citta;
                Provincia_Txt.Text = MyProfile.Provincia;
                Telefono_txt.Text = MyProfile.Telefono;
                EmailAzienda_Txt.Text = MyProfile.email;
                //Fax_Txt.Text = MyProfile.fax;
                NomeUtenteIntranet_Txt.Enabled = false;
                Email_Txt.Enabled = false;
                Salva_Btn.ClientVisible = false;
                SalvaEdit_Btn.ClientVisible = true;
                //CheckPassword_Txt.Enabled = false;


            }
            if (e.Parameter == "1" || e.Parameter == "2")
            {
                if (!EsisteEmail && !EsisteUtente)
                {
                    Generic_Gridview.UpdateEdit();

                }
            }
        }

        protected void DataBlocco_DateEdit_DataBinding(object sender, EventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");
            VIO_Parametri Get = new VIO_Parametri();
            int GiorniDaAggiungere = Convert.ToInt32(Get.GetValue("Value", "GiorniScadenza", "VIO_Parametri", "Name"));
            try
            {

                if (Session["TipologiaSession"].ToString() == "Cliente" && Generic_Gridview.IsNewRowEditing)
                {
                    DataBlocco_DateEdit.Date = DateTime.Now.AddDays(GiorniDaAggiungere);
                }
                else if (Session["TipologiaSession"].ToString() != "Cliente" && Generic_Gridview.IsNewRowEditing)
                {
                    DataBlocco_DateEdit.Date = DateTime.Now.AddYears(100);
                }
            }
            catch
            {
                DataBlocco_DateEdit.Date = DateTime.Now.AddDays(GiorniDaAggiungere);
            }
        }

        protected void Societa_txt_DataBinding(object sender, EventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ASPxTokenBox Societa_TokenBox = (ASPxTokenBox)Edit_FormLayout.FindControl("Societa_TokenBox");
#pragma warning disable CS0219 // La variabile 'RagioneSociale' è assegnata, ma il suo valore non viene mai usato
            string RagioneSociale = string.Empty;
#pragma warning restore CS0219 // La variabile 'RagioneSociale' è assegnata, ma il suo valore non viene mai usato
            if (grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString() != "Customer")
            {
                Societa_TokenBox.Text = ConfigurationManager.AppSettings["RagSoc"].ToString();
            }

        }


        protected void Generic_Gridview_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
        {
            EditCardView_Dts.SelectParameters["Tipologia"].DefaultValue = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();
            EditCardView_Dts.DataBind();
            Generic_Gridview.DataBind();
        }

        protected void Generic_Gridview_CustomButtonInitialize(object sender, ASPxGridViewCustomButtonEventArgs e)
        {
            if (e.VisibleIndex > -1)
            {
                bool Scaduto = Convert.ToBoolean(Generic_Gridview.GetRowValues(e.VisibleIndex, "IsLockedOut"));
                if (Scaduto)
                {
                    if (e.ButtonID == "Sospendi")
                    {
                        e.Visible = DevExpress.Utils.DefaultBoolean.False;
                    }


                }
                else
                {
                    if (e.ButtonID == "Riattiva")
                    {
                        e.Visible = DevExpress.Utils.DefaultBoolean.False;
                    }
                }
            }
        }
        protected void Generic_Gridview_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] parts = e.Parameters.Split('|');
            if (parts.Length == 2 && parts[0] == "Sospendi")
            {
                int visibleIndex = int.Parse(parts[1]);
                Generic_Gridview_CustomButtonCallback(sender, new ASPxGridViewCustomButtonCallbackEventArgs("Sospendi", visibleIndex));
            }
            if (parts.Length == 2 && parts[0] == "Riattiva")
            {
                int visibleIndex = int.Parse(parts[1]);
                Generic_Gridview_CustomButtonCallback(sender, new ASPxGridViewCustomButtonCallbackEventArgs("Riattiva", visibleIndex));
            }
        }
        protected void Generic_Gridview_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            string username = Generic_Gridview.GetRowValues(e.VisibleIndex, "UtenteIntranet")?.ToString();

            if (!string.IsNullOrEmpty(username))
            {
                MembershipUser user = Membership.GetUser(username);
                Guid userId = (Guid)user.ProviderUserKey;

                string query = string.Empty;
                switch (e.ButtonID)
                {
                    case "Riattiva":
                        query = @"UPDATE aspnet_Membership 
              SET IsLockedOut = 0
              WHERE UserId = @UserId";
                        break;

                    case "Sospendi":
                        query = @"UPDATE aspnet_Membership 
                          SET IsLockedOut = 1, LastLockoutDate = GETDATE() 
                          WHERE UserId = @UserId";
                        break;

                    case "Password":
                        Session["UsernameModPsw"] = username;
                        Generic_Gridview.JSProperties["cpCambiaPassword"] = 1;
                        return;
                }

                if (!string.IsNullOrEmpty(query))
                {
                    using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }

                    Generic_Gridview.JSProperties["cpCambiaPassword"] = 0;
                    Generic_Gridview.JSProperties["cpRefreshGrid"] = true;
                }
            }
            EditCardView_Dts.SelectParameters["Tipologia"].DefaultValue = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();
            EditCardView_Dts.DataBind();
            Generic_Gridview.DataBind();
        }

        protected void SalvaPsw_Callback_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser(Session["UsernameModPsw"].ToString());
            UserLog.ChangePassword(UserLog.ResetPassword(), passwordTextBox.Text);
            // Membership.UpdateUser(UserLog);
        }

        protected void UtenteDaMod_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            UtenteModPassword_Lbl.Text = Session["UsernameModPsw"].ToString();
        }
        protected void Generic_Gridview_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            Membership.DeleteUser(e.Values["UtenteIntranet"].ToString(), true);
        }

        protected void AggiornamentoTextbox_Callback_Callback(object source, CallbackEventArgs e)
        {

            VIO_Parametri Get = new VIO_Parametri();
            if (Get.GetValue("PIva", e.Parameter, "Clienti", "CodCli") == string.Empty)
            {
                AggiornamentoTextbox_Callback.JSProperties["cpCodiceFiscale"] = Get.GetValue("CF", e.Parameter, "Clienti", "CodCli");
            }
            else
            {
                AggiornamentoTextbox_Callback.JSProperties["cpCodiceFiscale"] = Get.GetValue("PIva", e.Parameter, "Clienti", "CodCli");
            }

            AggiornamentoTextbox_Callback.JSProperties["cpIndirizzo"] = Get.GetValue("Ind", e.Parameter, "Clienti", "CodCli");
            AggiornamentoTextbox_Callback.JSProperties["cpCap"] = Get.GetValue("Cap", e.Parameter, "Clienti", "CodCli");
            AggiornamentoTextbox_Callback.JSProperties["cpCitta"] = Get.GetValue("Loc", e.Parameter, "Clienti", "CodCli");
            AggiornamentoTextbox_Callback.JSProperties["cpProvincia"] = Get.GetValue("Prov", e.Parameter, "Clienti", "CodCli");
            AggiornamentoTextbox_Callback.JSProperties["cpEmailAzienda"] = Get.GetValue("EMail", e.Parameter, "Clienti", "CodCli");
            AggiornamentoTextbox_Callback.JSProperties["cpEmailTicket"] = Get.GetValue("EmailTicket", e.Parameter, "TCK_Aziende_Email_Tck", "NomeCliente");
            AggiornamentoTextbox_Callback.JSProperties["cpCodLis"] = Get.GetValue("CodLis", e.Parameter, "Clienti", "CodCli");
            AggiornamentoTextbox_Callback.JSProperties["cpNomeUtente"] = e.Parameter + "-" + (Convert.ToInt32(Get.GetCount("ID", e.Parameter, "VIO_Utenti", "CodCli")) + 1);

        }

        protected void grid_FocusedRowChanged(object sender, EventArgs e)
        {
            if (grid.FocusedRowIndex > -1)
            {
                Session["TipologiaSession"] = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();
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