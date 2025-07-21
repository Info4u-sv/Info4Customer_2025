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

namespace INTRA.VIO.Utenti
{
    public partial class Gruppo_Utenti_Crud : System.Web.UI.Page
    {
        // Recupera l'utente attualmente loggato
        MembershipUser UserLog = Membership.GetUser();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Controlla se la pagina viene caricata per la prima volta
            if (!IsPostBack)
            {
                // Azzera la sessione che identifica la tipologia di utente
                Session["TipologiaSession"] = null;

                // Recupera nuovamente l'utente loggato
                MembershipUser user = Membership.GetUser();
                string username = user.UserName;

                // Estrae il codice cliente dal nome utente
                // Se il nome contiene un "-", prende la parte prima del trattino
                string codCli = username.Contains("-") ? username.Split('-')[0] : username;
                // Memorizza il codice cliente nella sessione per usi successivi
                Session["CodCliSession"] = codCli;
            }
            // Se la sessione contiene una tipologia selezionata, aggiorna la GridView
            if (Session["TipologiaSession"] != null)
            {
                Generic_Gridview.DataBind(); // Aggiorna i dati della GridView
            }
        }

        // Metodo eseguito quando viene attivato il callback del pannello
        protected void Cards_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            // Recupera il valore del campo "RoleName" dalla riga attualmente selezionata della GridView
            Session["TipologiaSession"] = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();
            // Annulla la modalità di modifica della GridView
            Generic_Gridview.CancelEdit();
        }

        // Metodo chiamato quando si inserisce una nuova riga nella GridView
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
            BootstrapTextBox Email_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Email_Txt");
            BootstrapTextBox EmailAzienda_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("EmailAzienda_Txt");
            ASPxTextBox CodLis_Llb = (ASPxTextBox)Edit_FormLayout.FindControl("CodLis_Llb");

            MembershipUser newUser = Membership.CreateUser(NomeUtenteIntranet_Txt.Text, CreatePassword(10), Email_Txt.Text);
            newUser.Comment = string.Empty;
            Membership.UpdateUser(newUser);
            Roles.AddUserToRole(NomeUtenteIntranet_Txt.Text, "Cliente");

            PRT_Privilege_SA _objPriv = new PRT_Privilege_SA();
            _objPriv.tbl_um_privilege_By_UserVsRoles_SET(NomeUtenteIntranet_Txt.Text);

            Utenti_CRUD_Class Utente = new Utenti_CRUD_Class();
            Utente.NomeUtente = NomeUtenteIntranet_Txt.Text;
            Utente.Email = Email_Txt.Text;
            Utente.Tipologia = "Cliente";
            Utente.Azienda = Societa_TokenBox.Text;
            Utente.CodCli = Societa_TokenBox.Value.ToString();
            Utente.Nome = Nome_txt.Text;
            Utente.Cognome = Cognome_Txt.Text;
            Utente.InsertUtente(Utente);

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
            MyProfile.email = EmailAzienda_Txt.Text;
            MyProfile.CodCli = Societa_TokenBox.Value.ToString();
            MyProfile.CodLis = CodLis_Llb.Text;
            MyProfile.Save();
            string fullText = Societa_TokenBox.Text;
            string azienda = fullText.Substring(fullText.IndexOf("-") + 2);

            e.NewValues["UtenteIntranet"] = NomeUtenteIntranet_Txt.Text;
            e.NewValues["EmailContatto"] = Email_Txt.Text;
            e.NewValues["Tipologia"] = "Cliente";
            e.NewValues["Azienda"] = azienda;
            e.NewValues["CodCli"] = Societa_TokenBox.Value;

            // Blocco il doppio inserimento
            e.Cancel = true;
            Generic_Gridview.CancelEdit();

            // Notifica al client che il salvataggio è andato bene
            EditForm_CallbackPanel.JSProperties["cpDatiValidi"] = 1;
        }


        // Metodo chiamato quando una riga della GridView viene aggiornata
        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            // Recupera il pannello di callback all'interno del modulo di modifica (EditForm)
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            // Recupera il layout del form all'interno del pannello di callback
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            // Recupera i controlli input del form per ciascun campo
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

            // Crea (o carica, se già esistente) un profilo utente in base al nome utente intranet
            dynamic MyProfile = ProfileBase.Create(NomeUtenteIntranet_Txt.Text, true);
            // Assegna i valori dei campi del form ai campi del profilo utente
            MyProfile.nome = Nome_txt.Text;
            MyProfile.cognome = Cognome_Txt.Text;
            MyProfile.CodiceFiscale = Codicefiscale_Txt.Text;
            MyProfile.Indirizzo = Indirizzo_Txt.Text;
            MyProfile.Cap = Cap_Txt.Text;
            MyProfile.citta = Citta_Txt.Text;
            MyProfile.Provincia = Provincia_Txt.Text;
            MyProfile.Telefono = Telefono_txt.Text;

            // Salva il profilo aggiornato
            MyProfile.Save();

            // Aggiorna il valore del campo Email nella riga che sta per essere aggiornata nella GridView
            e.NewValues["EmailContatto"] = Email_Txt.Text;
            // Imposta una proprietà JS personalizzata per segnalare al client che i dati sono validi
            EditForm_CallbackPanel.JSProperties["cpDatiValidi"] = 1;
        }

        protected void EditForm_CallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            // Recupera i controlli dal template dell'EditForm
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            // Controlli dell'interfaccia utente
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
            // Pulsanti di salvataggio
            BootstrapButton SalvaEdit_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("SalvaEdit_Btn");
            BootstrapButton Salva_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("Salva_Btn");
            //BootstrapTextBox CheckPassword_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("CheckPassword_Txt");
            BootstrapTextBox EmailAzienda_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("EmailAzienda_Txt");
            //BootstrapTextBox EmailTicket_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("EmailTicket_Txt");

            //ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");

            BootstrapTextBox NomeUtenteIntranet_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            BootstrapTextBox Email_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Email_Txt");

            // Oggetti per il controllo di esistenza utente/email
            INTRA.AppCode.ProfileInfo Check = new INTRA.AppCode.ProfileInfo();
            bool EsisteUtente = false;
            bool EsisteEmail = false;
            // Ottiene il valore di configurazione dei giorni da aggiungere
            VIO_Parametri Get = new VIO_Parametri();
            int GiorniDaAggiungere = Convert.ToInt32(Get.GetValue("Value", "GiorniScadenza", "VIO_Parametri", "Name"));
            // Se il ruolo selezionato è "Cliente", imposta la validazione obbligatoria per il campo "Società"
            if (grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString() == "Cliente")
            {
                Societa_TokenBox.ValidationSettings.RequiredField.IsRequired = true;
                Societa_TokenBox.ValidationSettings.ValidationGroup = "NuovoUtenteValid";
                //DataBlocco_DateEdit.Date = DateTime.Now.AddDays(GiorniDaAggiungere);
            }
            // Verifica esistenza utente e email
            if (e.Parameter == "1")
            {
                bool isInserting = Generic_Gridview.IsNewRowEditing;
                if (EsisteUtente)
                {
                    EditForm_CallbackPanel.JSProperties["cpNomeUtenteValido"] = 0;
                    EditForm_CallbackPanel.JSProperties["cpNomeUtenteNonValido"] = NomeUtenteIntranet_Txt.Text;
                }
                else
                {
                    EditForm_CallbackPanel.JSProperties["cpNomeUtenteValido"] = 1;
                }

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
            // Preparazione del form per la modifica utente
            else if (e.Parameter == "2")
            {
                string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
                MembershipUser UserLog = Membership.GetUser(Username);

                dynamic MyProfile = ProfileBase.Create(Username);
                // Disabilita i campi principali e imposta visibilità dei pulsanti
                NomeUtenteIntranet_Txt.Enabled = false;
                Email_Txt.Enabled = false;
                Salva_Btn.ClientVisible = false;
                SalvaEdit_Btn.ClientVisible = true;
                //CheckPassword_Txt.Enabled = false;
                // Precarica i dati della società
                Societa_TokenBox.Text = MyProfile.Societa;
                // Conferma i flag di validità
                EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 1;
                EditForm_CallbackPanel.JSProperties["cpNomeUtenteValido"] = 1;
                EditForm_CallbackPanel.JSProperties["cpUpdate"] = 1;
            }
            // Carica i dati completi dell'utente per la modifica
            else if (e.Parameter == "3")
            {
                //BootstrapTextBox Ruolo_Txt = (BootstrapTextBox)Edit_FormLayout.FindControl("Ruolo_Txt");
                //Ruolo_Txt.Text = 
                Societa_TokenBox.Enabled = false;
                string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
                MembershipUser UserLog = Membership.GetUser(Username);

                dynamic MyProfile = ProfileBase.Create(Username);
                // Caricamento dati anagrafici nel form
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
                // Disabilita campi chiave e imposta pulsanti
                NomeUtenteIntranet_Txt.Enabled = false;
                Email_Txt.Enabled = false;
                Salva_Btn.ClientVisible = false;
                SalvaEdit_Btn.ClientVisible = true;
                //CheckPassword_Txt.Enabled = false;


            }
            // Preparazione form per la creazione di un nuovo utente
            else if (e.Parameter == "4")
            {
                Societa_TokenBox.Enabled = true;

                // Recupera l'utente attualmente autenticato
                MembershipUser user = Membership.GetUser();

                string username = user.UserName; // es. "C0273-1"
                string firstPart = username.Split('-')[0];

                //Clienti_Dts.SelectParameters["CodCli"].DefaultValue = firstPart;
                //Clienti_Dts.DataBind();
                //Societa_TokenBox.DataBind();

                //Societa_TokenBox.Value = firstPart;

                // Recupera il profilo personalizzato dell'utente
                dynamic MyProfile = ProfileBase.Create(username);
                //Societa_TokenBox.Value = MyProfile.Societa;
                Societa_TokenBox.Text = Session["CodCliSession"] + " - " + MyProfile.Societa;
                Codicefiscale_Txt.Text = MyProfile.CodiceFiscale;
                Indirizzo_Txt.Text = MyProfile.Indirizzo;
                Cap_Txt.Text = MyProfile.Cap;
                Citta_Txt.Text = MyProfile.citta;
                Provincia_Txt.Text = MyProfile.Provincia;
                EmailAzienda_Txt.Text = MyProfile.email;

                Salva_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("Salva_Btn");
                SalvaEdit_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("SalvaEdit_Btn");
                Salva_Btn.ClientVisible = true;
                SalvaEdit_Btn.ClientVisible = false;

            }
            // Se il parametro era 1 o 2, ed entrambi i valori sono validi, aggiorna i dati
            if (e.Parameter == "1" || e.Parameter == "2" && !EsisteEmail && !EsisteUtente)
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
                bool Scaduto = Convert.ToBoolean(Generic_Gridview.GetRowValues(e.VisibleIndex, "Scaduto"));
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

        protected void Generic_Gridview_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            PRT_Utenti_SA Set = new PRT_Utenti_SA();
            if (e.ButtonID == "Riattiva")
            {
                Set.ID = Convert.ToInt32(Generic_Gridview.GetRowValues(e.VisibleIndex, "ID"));
                Set.VIO_Utenti_Riattivazione(Set);
                Generic_Gridview.JSProperties["cpCambiaPassword"] = 0;
            }
            if (e.ButtonID == "Sospendi")
            {
                Set.ID = Convert.ToInt32(Generic_Gridview.GetRowValues(e.VisibleIndex, "ID"));
                Set.VIO_Utenti_Sospensione(Set);
                Generic_Gridview.JSProperties["cpCambiaPassword"] = 0;
            }
            if (e.ButtonID == "Password")
            {
                Session["UsernameModPsw"] = Generic_Gridview.GetRowValues(e.VisibleIndex, "UtenteIntranet");
                Generic_Gridview.JSProperties["cpCambiaPassword"] = 1;
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