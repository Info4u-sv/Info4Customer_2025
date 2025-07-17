using DevExpress.Web;
using DevExpress.Web.Bootstrap;
using INTRA.AppCode;
using INTRA.VIO_Utenti.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.Profile;
using System.Web.Security;

namespace INTRA.VIO_Utenti
{
    public partial class Utenti_Crud : System.Web.UI.Page
    {
        MembershipUser UserLog = Membership.GetUser();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["TipologiaSession"] = null;
                //var fileCount = (from file in Directory.EnumerateFiles(Server.MapPath("/VioletUpload/DaImportare"), "*", SearchOption.AllDirectories) select file).Count();

                //if(fileCount == 0)
                //{
                //    TotaleArt_Lbl.ForeColor = Color.IndianRed;
                //}
                //else
                //{
                //    TotaleArt_Lbl.ForeColor = Color.ForestGreen;
                //}
                //TotaleArt_Lbl.Text = "File trovati: " + fileCount;
            }
            if (Session["TipologiaSession"] != null)
            {
                Session["TipologiaSession"] = Session["TipologiaSession"];
                Generic_Gridview.DataBind();
            }
        }

        protected void Importa_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            //VIO_HotFolderCode Imp = new VIO_HotFolderCode();

            //Imp.ImportazioneMassiva(UserLog.UserName);
        }

        //protected void Tags_Tokenbx_DataBound(object sender, EventArgs e)
        //{
        //    string Tags = (string)ArticoliBozza_Gridview.GetRowValues(ArticoliBozza_Gridview.EditingRowVisibleIndex, "Tags");
        //    ASPxTokenBox Tags_Tokenbx = (ASPxTokenBox)ArticoliBozza_Gridview.FindEditRowCellTemplateControl((GridViewDataColumn)ArticoliBozza_Gridview.Columns["Tags"], "Tags_Tokenbx");
        //    if (Tags_Tokenbx.Text == null || Tags_Tokenbx.Text == "")
        //    {
        //        Tags_Tokenbx.Text = Tags;
        //    }
        //}

        //protected void ArticoliBozza_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        //{
        //    DataTable VIO_CustomFieldsLis = new DataTable();
        //    VIO_CustomFieldsLis = VIO_CustomFields.VIO_CustomFieldsList();
        //    ASPxFormLayout DetArticoloEdit_FormLy = (ASPxFormLayout)ArticoliBozza_Gridview.FindEditFormTemplateControl("DetArticoloEdit_FormLy");
        //    BootstrapMemo Descrizione_Memo = (BootstrapMemo)DetArticoloEdit_FormLy.FindControl("Descrizione_Memo");
        //    //BootstrapMemo Composizione_Txt = (BootstrapMemo)DetArticoloEdit_FormLy.FindControl("Composizione_Txt");
        //    ASPxCheckBox Bozza_Ckbx = (ASPxCheckBox)DetArticoloEdit_FormLy.FindControl("Bozza_Ckbx");

        //    ASPxTokenBox Tags_Tokenbx = (ASPxTokenBox)DetArticoloEdit_FormLy.FindControl("TagsView_Tokenbx");
        //    e.NewValues["Tags"] = Tags_Tokenbx.Text;
        //    e.NewValues["Descrizione"] = Descrizione_Memo.Text;
        //    e.NewValues["FlagBozza"] = Bozza_Ckbx.Checked;

        //    foreach (DataRow row in VIO_CustomFieldsLis.Rows)
        //    {
        //        string CampoPersonalizzato = row["name"].ToString();
        //        try
        //        {
        //            if (!(bool)row["EnableEdit"])
        //            {
        //                DetArticoloEdit_FormLy.FindItemOrGroupByName(CampoPersonalizzato).Visible = false;
        //            }
        //            else
        //            {
        //                BootstrapMemo ColXx = (BootstrapMemo)DetArticoloEdit_FormLy.FindControl(CampoPersonalizzato);
        //                e.NewValues[CampoPersonalizzato] = ColXx.Text;
        //            }
        //        }
        //        catch (Exception ex)
        //        {

        //        }
        //    }
        //}

        protected void TotaleFileTrovati_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            //var fileCount = (from file in Directory.EnumerateFiles(Server.MapPath("/VioletUpload/DaImportare"), "*", SearchOption.AllDirectories) select file).Count();

            //if (fileCount == 0)
            //{
            //    TotaleArt_Lbl.ForeColor = Color.IndianRed;
            //}
            //else
            //{
            //    TotaleArt_Lbl.ForeColor = Color.ForestGreen;
            //}
            //TotaleArt_Lbl.Text = "File trovati: " + fileCount;
        }
        protected void Sezioni_TokenBox_DataBound(object sender, EventArgs e)
        {
            //DataView dvSql = (DataView)Sezione_Dts.Select(DataSourceSelectArguments.Empty);
            //var ListaCategorie = (ASPxTokenBox)sender;

            //for (int i = 0; i < ListaCategorie.Items.Count(); i++)
            //{
            //    string Inserito = dvSql[i]["Exist"].ToString();
            //    if (Inserito == "1")
            //    {
            //        ListaCategorie.Tokens.Add(ListaCategorie.Items[i].Text);
            //    }
            //}
        }

        //protected void DetArticoloEdit_FormLy_DataBound(object sender, EventArgs e)
        //{
        //    DataTable VIO_CustomFieldsLis = new DataTable();
        //    VIO_CustomFieldsLis = VIO_CustomFields.VIO_CustomFieldsList();

        //    ASPxFormLayout DetArticoloEdit_FormLy = (ASPxFormLayout)ArticoliBozza_Gridview.FindEditFormTemplateControl("DetArticoloEdit_FormLy");

        //    foreach (DataRow row in VIO_CustomFieldsLis.Rows)
        //    {
        //        string CampoPersonalizzato = row["name"].ToString();
        //        try
        //        {
        //            if (!(bool)row["EnableEdit"])
        //            {
        //                DetArticoloEdit_FormLy.FindItemOrGroupByName(CampoPersonalizzato).Visible = false;
        //            }
        //            else
        //            {
        //                DetArticoloEdit_FormLy.FindItemOrGroupByName(CampoPersonalizzato).Caption = (string)row["Caption"];
        //                DetArticoloEdit_FormLy.FindItemOrGroupByName(CampoPersonalizzato).ColumnSpan = (int)row["ColumnSpan"];
        //                BootstrapMemo ColXx = (BootstrapMemo)DetArticoloEdit_FormLy.FindControl(CampoPersonalizzato);
        //                //ColXx.Caption = (string)row["Caption"];
        //                ColXx.Rows = (int)row["TotRowEdit"];
        //            }
        //        }
        //        catch (Exception ex) { }

        //    }
        //}

        //protected void ArticoliBozza_Gridview_FocusedRowChanged(object sender, EventArgs e)
        //{
        //    //if (!IsPostBack)
        //    //{
        //    //    string key = ArticoliBozza_Gridview.GetRowValues(ArticoliBozza_Gridview.FocusedRowIndex, "ID").ToString();
        //    //    Session["IDArtSess"] = key;
        //    //}
        //}

        protected void Sezioni_CallbackPnl_Callback(object source, CallbackEventArgs e)
        {
            Session["IDArtSess"] = e.Parameter;
        }
        protected void Stampa_Btn_Click(object sender, EventArgs e)
        {
            //LinkButton btn = (LinkButton)(sender);
            //string IDArticolo = cardView_Aperti.GetCardValues(Convert.ToInt32(btn.CommandArgument), "ID").ToString();
            //string CodiceArticolo = cardView_Aperti.GetCardValues(Convert.ToInt32(btn.CommandArgument), "CodArt").ToString();
            //string url = "/VIO_Immagini/VisualizzaPDF.aspx?code=" + IDArticolo + "&CA=" + CodiceArticolo;

            //Server.Transfer(url);
            ////StringBuilder sb = new StringBuilder();
            ////sb.Append("<script type = 'text/javascript'>");
            ////sb.Append("window.open('");
            ////sb.Append(url);
            ////sb.Append("');");
            ////sb.Append("</script>");
            ////ClientScript.RegisterStartupScript(this.GetType(), "script", sb.ToString());
        }
        protected void Generic_CardView_PageIndexChanged(object sender, EventArgs e)
        {
            int PageIndex = (sender as ASPxCardView).PageIndex;
            Session["PageIndexSession"] = PageIndex;


        }

        protected void Cards_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            //var Parametri = e.Parameter.Split(';');
            //string TipologiaUtente = Parametri[0];
            //if (Parametri.Count() == 2)
            //{
            //    VIO_ImageCrud.VIO_WishList_Dettaglio_RimuoviArticolo(Convert.ToInt32(TipologiaUtente));
            //}

            Session["TipologiaSession"] = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();

            //EditCardView_Dts.DataBind();
            Generic_Gridview.CancelEdit();
        }

        protected void RimuoviImmagineWL_Callback_Callback(object sender, CallbackEventArgsBase e)
        {

        }

        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            //ASPxTextBox Ruolo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Ruolo_Txt");
            //Ruolo_Txt.Text = 
            //string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
            ASPxTextBox Nome_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Nome_txt");
            ASPxTextBox Cognome_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            ASPxTokenBox CodAge_Combobox = (ASPxTokenBox)Edit_FormLayout.FindControl("CodAge_Combobox");
            ASPxTextBox Telefono_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            ASPxTextBox Fax_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Fax_Txt");
            ASPxTextBox Codicefiscale_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            ASPxTextBox Indirizzo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            ASPxTextBox Cap_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            ASPxTextBox Citta_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            ASPxTextBox Provincia_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            ASPxTextBox NomeUtenteIntranet_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            ASPxTextBox Password_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Password_Txt");
            //ASPxTextBox Email_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Email_Txt");
            string emailCasuale = GeneraEmail(10);
            ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");
            MembershipUser newUser = Membership.CreateUser(NomeUtenteIntranet_Txt.Text, Password_Txt.Text, emailCasuale);
            newUser.Comment = string.Empty;
            Membership.UpdateUser(newUser);
            
            Roles.AddUserToRole(NomeUtenteIntranet_Txt.Text, grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString());
            // aggiungere i l'accesso alle pagine del menù
            INTRA.AppCode.PRT_Privilege _objPriv = new INTRA.AppCode.PRT_Privilege();
            _objPriv.tbl_um_privilege_By_UserVsRoles_SET(NomeUtenteIntranet_Txt.Text);

            dynamic MyProfile = ProfileBase.Create(NomeUtenteIntranet_Txt.Text, true);
            MyProfile.nome = Nome_txt.Text;
            MyProfile.cognome = Cognome_Txt.Text;
            MyProfile.Societa = ConfigurationManager.AppSettings["RagSoc"].ToString();
            //MyProfile.CodiceFiscale = Codicefiscale_Txt.Text;
            //MyProfile.Indirizzo = Indirizzo_Txt.Text;
            //MyProfile.Cap = Cap_Txt.Text;
            //MyProfile.citta = Citta_Txt.Text;
            //MyProfile.Provincia = Provincia_Txt.Text;
            //MyProfile.Telefono = Telefono_txt.Text;
            //MyProfile.fax = Fax_Txt.Text;

            MyProfile.Save();

            e.NewValues["UtenteIntranet"] = NomeUtenteIntranet_Txt.Text;
            e.NewValues["EmailContatto"] = emailCasuale;
            e.NewValues["DataBlocco"] = DataBlocco_DateEdit.Date;
            e.NewValues["Tipologia"] = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();
            e.NewValues["Azienda"] = ConfigurationManager.AppSettings["RagSoc"].ToString();
            e.NewValues["Nome"] = Nome_txt.Text;
            e.NewValues["Cognome"] = Cognome_Txt.Text;
            e.NewValues["CodAge"] = CodAge_Combobox.Text;
            string TipoAgeVar = "Interno";
            if (grid.GetRowValues(grid.FocusedRowIndex, "Description").ToString().Contains("AgeEsterno"))
            {
                TipoAgeVar = "Esterno";
            }
            e.NewValues["TipoAge"] = TipoAgeVar;

            EditForm_CallbackPanel.JSProperties["cpDatiValidi"] = 1;

            Generic_Gridview.EndUpdate();
            //InsUpdRagioneSociale_Rivenditore(RagioneSociale_fl, false, NomeUtenteIntranet_Txt.Text);

        }
        public static string GeneraEmail(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            StringBuilder result = new StringBuilder(length);
            Random random = new Random();

            for (int i = 0; i < length; i++)
            {
                result.Append(chars[random.Next(chars.Length)]);
            }
            result.Append("@adriana.it");
            return result.ToString();
        }
        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ASPxFormLayout RagioneSociale_fl = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("RagioneSociale_fl");
            //ASPxTextBox Ruolo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Ruolo_Txt");
            //Ruolo_Txt.Text = 
            //string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
            ASPxTextBox Nome_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Nome_txt");
            ASPxTextBox Cognome_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            ASPxTextBox Telefono_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            ASPxTextBox Fax_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Fax_Txt");
            ASPxTextBox Codicefiscale_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            ASPxTextBox Indirizzo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            ASPxTextBox Cap_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            ASPxTextBox Citta_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            ASPxTextBox Provincia_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            ASPxTextBox NomeUtenteIntranet_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            ASPxTextBox Password_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Password_Txt");
            ASPxTextBox Email_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Email_Txt");
            ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");


            dynamic MyProfile = ProfileBase.Create(NomeUtenteIntranet_Txt.Text, true);
            MyProfile.nome = Nome_txt.Text;
            MyProfile.cognome = Cognome_Txt.Text;
            //MyProfile.CodiceFiscale = Codicefiscale_Txt.Text;
            //MyProfile.Indirizzo = Indirizzo_Txt.Text;
            //MyProfile.Cap = Cap_Txt.Text;
            //MyProfile.citta = Citta_Txt.Text;
            //MyProfile.Provincia = Provincia_Txt.Text;
            //MyProfile.Telefono = Telefono_txt.Text;
            //MyProfile.fax = Fax_Txt.Text;
            MyProfile.Save();

            e.NewValues["EmailContatto"] = Email_Txt.Text;
            e.NewValues["DataBlocco"] = DataBlocco_DateEdit.Date;
            if (grid.GetRowValues(grid.FocusedRowIndex, "Description").ToString().Contains("AgeEsterno"))
            {
                InsUpdRagioneSociale_Rivenditore(RagioneSociale_fl, true, NomeUtenteIntranet_Txt.Text);
            }
            EditForm_CallbackPanel.JSProperties["cpDatiValidi"] = 1;
        }

        protected void EditForm_CallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {


            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ASPxFormLayout RagioneSociale_fl = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("RagioneSociale_fl");
            ASPxTextBox Nome_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Nome_txt");
            ASPxTextBox Cognome_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            ASPxTokenBox CodAge_Combobox = (ASPxTokenBox)Edit_FormLayout.FindControl("CodAge_Combobox");

            ASPxTextBox Telefono_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            ASPxTextBox Fax_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Fax_Txt");
            ASPxTextBox Codicefiscale_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            //ASPxTextBox Indirizzo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            ASPxTextBox Cap_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            ASPxTextBox Citta_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            ASPxTextBox Provincia_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            ASPxTextBox Password_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Password_Txt");
            BootstrapButton SalvaEdit_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("SalvaEdit_Btn");
            BootstrapButton Salva_Btn = (BootstrapButton)EditForm_CallbackPanel.FindControl("Salva_Btn");
            ASPxTextBox CheckPassword_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("CheckPassword_Txt");

            ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");

            ASPxTextBox NomeUtenteIntranet_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            ASPxTextBox Email_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Email_Txt");
            AppCode.ProfileInfo Check = new AppCode.ProfileInfo();
            bool EsisteUtente = false;
            bool EsisteEmail = false;
            INTRA.AppCode.VIO_Parametri Get = new INTRA.AppCode.VIO_Parametri();
            int GiorniDaAggiungere = Convert.ToInt32(Get.GetValue("Value", "GiorniScadenza", "VIO_Parametri", "Name"));
            if (grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString() == "Agente")
            {
                CodAge_Combobox.ValidationSettings.RequiredField.IsRequired = true;
                CodAge_Combobox.ValidationSettings.ValidationGroup = "NuovoUtenteValid";
                DataBlocco_DateEdit.Date = DateTime.Now.AddDays(GiorniDaAggiungere);
            }
            Password_Txt.ClientVisible = e.Parameter == "1";
            CheckPassword_Txt.ClientVisible = e.Parameter == "1";
            Salva_Btn.ClientVisible = e.Parameter == "1";
            SalvaEdit_Btn.ClientVisible = e.Parameter != "1";
            if (e.Parameter == "1") // inserisci 
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


                //EsisteEmail = Check.EsistenzaValoreUtente_Check("Email", Email_Txt.Text, "aspnet_Membership");
                //if (EsisteEmail)
                //{
                //    EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 0;
                //    EditForm_CallbackPanel.JSProperties["cpNEmailNonValida"] = Email_Txt.Text;
                //}
                //else
                //{
                //    EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 1;
                //}
                EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 1;
            }
            else if (e.Parameter == "2") // salva modifiche
            {
                string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();

                MembershipUser UserLog = Membership.GetUser(Username);

                dynamic MyProfile = ProfileBase.Create(Username);
                NomeUtenteIntranet_Txt.Enabled = false;
                Email_Txt.Enabled = true;
                Salva_Btn.ClientVisible = false;
                SalvaEdit_Btn.ClientVisible = true;
                Password_Txt.Visible = false;
                CheckPassword_Txt.Visible = false;
                EditForm_CallbackPanel.JSProperties["cpEmailValido"] = 1;
                EditForm_CallbackPanel.JSProperties["cpNomeUtenteValido"] = 1;
                EditForm_CallbackPanel.JSProperties["cpUpdate"] = 1;


                // aggiorno i dati dell'agente 09/11/2022 Simone
                VIO_Utenti_CRUD _obj = new VIO_Utenti_CRUD();
                _obj.UtenteIntranet = Username;
                _obj.Nome = Nome_txt.Text;
                _obj.Cognome = Cognome_Txt.Text;
                _obj.EmailContatto = Email_Txt.Text;
                _obj.VIO_Utenti_Update(_obj);

            }

            else if (e.Parameter == "3")
            {
                //ASPxTextBox Ruolo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Ruolo_Txt");
                //Ruolo_Txt.Text = 

                CodAge_Combobox.ClientEnabled = false;
                string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
                string CodAge = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "CodAge").ToString();
                MembershipUser UserLog = Membership.GetUser(Username);

                dynamic MyProfile = ProfileBase.Create(Username);

                CodAge_Combobox.Text = CodAge;
                Nome_txt.Text = MyProfile.nome;
                Cognome_Txt.Text = MyProfile.cognome;
                if (grid.GetRowValues(grid.FocusedRowIndex, "Description").ToString().Contains("AgeEsterno"))
                {
                    Rivenditore_Det_CRUD dettaglio = new Rivenditore_Det_CRUD()[Username];

                    ASPxTextBox Denom_text = RagioneSociale_fl.FindControl("Denom_text") as ASPxTextBox;
                    ASPxComboBox Nazione_Combox = RagioneSociale_fl.FindControl("Nazione_Combox") as ASPxComboBox;
                    ASPxTextBox Indirizzo_Txt = RagioneSociale_fl.FindControl("Indirizzo_Txt") as ASPxTextBox;
                    ASPxComboBox Provincia_Combobox = RagioneSociale_fl.FindControl("Provincia_Combobox") as ASPxComboBox;
                    ASPxTextBox Cap_text = RagioneSociale_fl.FindControl("Cap_text") as ASPxTextBox;
                    ASPxTextBox Local_Txt = RagioneSociale_fl.FindControl("Local_Txt") as ASPxTextBox;
                    ASPxTextBox SitoWeb_txt = RagioneSociale_fl.FindControl("SitoWeb_txt") as ASPxTextBox;
                    ASPxTextBox EMail_text = RagioneSociale_fl.FindControl("EMail_text") as ASPxTextBox;
                    ASPxTextBox Tel_text = RagioneSociale_fl.FindControl("Tel_text") as ASPxTextBox;
                    ASPxTextBox PIva_text = RagioneSociale_fl.FindControl("PIva_text") as ASPxTextBox;
                    ASPxSpinEdit Ricarico_spin = RagioneSociale_fl.FindControl("Ricarico_spin") as ASPxSpinEdit;

                    Denom_text.Text = dettaglio.Denom;
                    Nazione_Combox.Value = dettaglio.CodNaz;
                    Indirizzo_Txt.Text = dettaglio.Ind;
                    Provincia_Combobox.Value = dettaglio.Prov;
                    Cap_text.Text = dettaglio.Cap;
                    Local_Txt.Text = dettaglio.Loc;
                    SitoWeb_txt.Text = dettaglio.SitoWeb;
                    EMail_text.Text = dettaglio.EMail;
                    Tel_text.Text = dettaglio.Tel;
                    PIva_text.Text = dettaglio.PIva;
                    Ricarico_spin.Value = dettaglio.MarginePercent;
                }
                //Codicefiscale_Txt.Text = MyProfile.CodiceFiscale;
                //Indirizzo_Txt.Text = MyProfile.Indirizzo;
                //Cap_Txt.Text = MyProfile.Cap;
                //Citta_Txt.Text = MyProfile.citta;
                //Provincia_Txt.Text = MyProfile.Provincia;
                //Telefono_txt.Text = MyProfile.Telefono;
                //Fax_Txt.Text = MyProfile.fax;
                //NomeUtenteIntranet_Txt.Enabled = false; 
                //Password_Txt.Visible = false;
                //CheckPassword_Txt.Visible = false;
                //Email_Txt.Enabled = true;
                //Salva_Btn.ClientVisible = false;
                //SalvaEdit_Btn.ClientVisible = true;
                //Password_Txt.Enabled = false;
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

        protected void Generic_Gridview_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            //ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            //ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ////ASPxTextBox Ruolo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Ruolo_Txt");
            ////Ruolo_Txt.Text = 
            //string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
            //MembershipUser UserLog = Membership.GetUser(Username);
            //ASPxTextBox Nome_txt = (ASPxTextBox)EditForm_CallbackPanel.FindControl("Nome_txt");
            ////ASPxTextBox Nome_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Nome_txt");
            //ASPxTextBox Cognome_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            //ASPxTextBox Societa_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Societa_txt");
            //ASPxTextBox Telefono_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            //ASPxTextBox Fax_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Fax_Txt");
            //ASPxTextBox Codicefiscale_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            //ASPxTextBox Indirizzo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            //ASPxTextBox Cap_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            //ASPxTextBox Citta_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            //ASPxTextBox Provincia_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            //ASPxTextBox Password_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Password_Txt");

            //dynamic MyProfile = ProfileBase.Create(Username);
            //Nome_txt.Text = MyProfile.nome;
            //Cognome_Txt.Text = MyProfile.cognome;
            //Societa_txt.Text = MyProfile.Societa;
            //Codicefiscale_Txt.Text = MyProfile.CodiceFiscale;
            //Indirizzo_Txt.Text = MyProfile.Indirizzo;
            //Cap_Txt.Text = MyProfile.Cap;
            //Citta_Txt.Text = MyProfile.citta;
            //Provincia_Txt.Text = MyProfile.Provincia;
            //Telefono_txt.Text = MyProfile.Telefono;
            //Fax_Txt.Text = MyProfile.fax;
            ////Password_Txt.Text =  Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "Password").ToString() ;

        }

        protected void Generic_Gridview_EditFormLayoutCreated(object sender, ASPxGridViewEditFormLayoutEventArgs e)
        {
            //ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            //ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ////ASPxTextBox Ruolo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Ruolo_Txt");
            ////Ruolo_Txt.Text = 
            //string Username = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "UtenteIntranet").ToString();
            //MembershipUser UserLog = Membership.GetUser(Username);
            //ASPxTextBox Nome_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Nome_txt");
            //ASPxTextBox Cognome_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cognome_Txt");
            //ASPxTextBox Societa_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Societa_txt");
            //ASPxTextBox Telefono_txt = (ASPxTextBox)Edit_FormLayout.FindControl("Telefono_txt");
            //ASPxTextBox Fax_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Fax_Txt");
            //ASPxTextBox Codicefiscale_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Codicefiscale_Txt");
            //ASPxTextBox Indirizzo_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Indirizzo_Txt");
            //ASPxTextBox Cap_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Cap_Txt");
            //ASPxTextBox Citta_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Citta_Txt");
            //ASPxTextBox Provincia_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Provincia_Txt");
            //ASPxTextBox Password_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("Password_Txt");


            //dynamic MyProfile = ProfileBase.Create(Username);
            //Nome_txt.Text = MyProfile.nome;
            //Cognome_Txt.Text = MyProfile.cognome;
            //Societa_txt.Text = MyProfile.Societa;
            //Codicefiscale_Txt.Text = MyProfile.CodiceFiscale;
            //Indirizzo_Txt.Text = MyProfile.Indirizzo;
            //Cap_Txt.Text = MyProfile.Cap;
            //Citta_Txt.Text = MyProfile.citta;
            //Provincia_Txt.Text = MyProfile.Provincia;
            //Telefono_txt.Text = MyProfile.Telefono;
            //Fax_Txt.Text = MyProfile.fax;
        }

        protected void DataBlocco_DateEdit_DataBinding(object sender, EventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ASPxDateEdit DataBlocco_DateEdit = (ASPxDateEdit)Edit_FormLayout.FindControl("DataBlocco_DateEdit");
            INTRA.AppCode.VIO_Parametri Get = new INTRA.AppCode.VIO_Parametri();
            int GiorniDaAggiungere = Convert.ToInt32(Get.GetValue("Value", "GiorniScadenza", "VIO_Parametri", "Name"));
            if (grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString() == "Cliente" && Generic_Gridview.IsNewRowEditing)
            {
                DataBlocco_DateEdit.Date = DateTime.Now.AddDays(GiorniDaAggiungere);
            }
            else if (grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString() != "Cliente" && Generic_Gridview.IsNewRowEditing)
            {
                DataBlocco_DateEdit.Date = DateTime.Now.AddYears(100);
            }
        }

        protected void Societa_txt_DataBinding(object sender, EventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            //ASPxTokenBox Societa_TokenBox = (ASPxTokenBox)Edit_FormLayout.FindControl("Societa_TokenBox");
            //string RagioneSociale = "";
            //if (grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString() != "Customer")
            //{
            //    Societa_TokenBox.Text = ConfigurationManager.AppSettings["RagSoc"].ToString();
            //}

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
            INTRA.AppCode.PRT_Utenti Set = new INTRA.AppCode.PRT_Utenti();
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
            UserLog.ChangePassword(UserLog.ResetPassword(), CheckModPassword_Txt.Text);
            Membership.UpdateUser(UserLog);
        }

        protected void UtenteDaMod_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            UtenteModPassword_Lbl.Text = Session["UsernameModPsw"].ToString();
        }
        protected void Generic_Gridview_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            Membership.DeleteUser(e.Values["UtenteIntranet"].ToString(), true);
        }

        protected void CodAge_Combobox_DataBinding(object sender, EventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ASPxTokenBox CodAge_Combobox = (ASPxTokenBox)Edit_FormLayout.FindControl("CodAge_Combobox");
            try
            {
                ASPxFormLayout RagioneSociale_fl = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("RagioneSociale_fl");
                RagioneSociale_fl.ClientVisible = grid.GetRowValues(grid.FocusedRowIndex, "Description").ToString().Contains("AgeEsterno");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERROR: {ex.Message}");
            }
#pragma warning disable CS0219 // La variabile 'RagioneSociale' è assegnata, ma il suo valore non viene mai usato
            string RagioneSociale = string.Empty;
#pragma warning restore CS0219 // La variabile 'RagioneSociale' è assegnata, ma il suo valore non viene mai usato
            if (!grid.GetRowValues(grid.FocusedRowIndex, "Description").ToString().Contains("AgenteOK"))
            {
                CodAge_Combobox.Text = "NoAge";
                CodAge_Combobox.ClientEnabled = false;
                CodAge_Combobox.ClientVisible = false;
            }
            else
            {
                CodAge_Combobox.ClientEnabled = true;
                CodAge_Combobox.ClientVisible = true;
            }
        }

        protected void grid_FocusedRowChanged(object sender, EventArgs e)
        {
            if (grid.FocusedRowIndex > -1)
            {
                Session["TipologiaSession"] = grid.GetRowValues(grid.FocusedRowIndex, "RoleName").ToString();

                string ParametriRuolo = grid.GetRowValues(grid.FocusedRowIndex, "Description").ToString();
                Session["ParametriRuoloSession"] = ParametriRuolo;
            }
        }


        protected static void InsUpdRagioneSociale_Rivenditore(ASPxFormLayout RagioneSociale_fl, bool isEdit, string Utente)
        {
            ASPxTextBox Denom_text = RagioneSociale_fl.FindControl("Denom_text") as ASPxTextBox;
            ASPxComboBox Nazione_Combox = RagioneSociale_fl.FindControl("Nazione_Combox") as ASPxComboBox;
            ASPxTextBox Indirizzo_Txt = RagioneSociale_fl.FindControl("Indirizzo_Txt") as ASPxTextBox;
            ASPxComboBox Provincia_Combobox = RagioneSociale_fl.FindControl("Provincia_Combobox") as ASPxComboBox;
            ASPxTextBox Cap_text = RagioneSociale_fl.FindControl("Cap_text") as ASPxTextBox;
            ASPxTextBox Local_Txt = RagioneSociale_fl.FindControl("Local_Txt") as ASPxTextBox;
            ASPxTextBox SitoWeb_txt = RagioneSociale_fl.FindControl("SitoWeb_txt") as ASPxTextBox;
            ASPxTextBox EMail_text = RagioneSociale_fl.FindControl("EMail_text") as ASPxTextBox;
            ASPxTextBox Tel_text = RagioneSociale_fl.FindControl("Tel_text") as ASPxTextBox;
            ASPxTextBox PIva_text = RagioneSociale_fl.FindControl("PIva_text") as ASPxTextBox;
            ASPxSpinEdit Ricarico_spin = RagioneSociale_fl.FindControl("Ricarico_spin") as ASPxSpinEdit;

            Rivenditore_Det_CRUD Rivenditore_Dettaglio = new Rivenditore_Det_CRUD();
            Rivenditore_Dettaglio.ID_VIO_Utenti = Rivenditore_Dettaglio.GetIdUtente(Utente);
            Rivenditore_Dettaglio.Denom = Denom_text.Text;
            Rivenditore_Dettaglio.CodNaz = Nazione_Combox.SelectedItem.Value.ToString();
            Rivenditore_Dettaglio.Prov = Provincia_Combobox.SelectedItem.Value.ToString();
            Rivenditore_Dettaglio.Cap = Cap_text.Text;
            Rivenditore_Dettaglio.Loc = Local_Txt.Text;
            Rivenditore_Dettaglio.Ind = Indirizzo_Txt.Text;
            Rivenditore_Dettaglio.SitoWeb = SitoWeb_txt.Text;
            Rivenditore_Dettaglio.EMail = EMail_text.Text;
            Rivenditore_Dettaglio.Tel = Tel_text.Text;
            Rivenditore_Dettaglio.PIva = PIva_text.Text;
            Rivenditore_Dettaglio.MarginePercent = Convert.ToDecimal(Ricarico_spin.Value);

            int result = isEdit ? Rivenditore_Dettaglio.DetRivenditore_Update(Rivenditore_Dettaglio) : Rivenditore_Dettaglio.DetRivenditore_Insert(Rivenditore_Dettaglio);
        }

        protected void Generic_Gridview_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            ASPxCallbackPanel EditForm_CallbackPanel = (ASPxCallbackPanel)Generic_Gridview.FindEditFormTemplateControl("EditForm_CallbackPanel");
            ASPxFormLayout RagioneSociale_fl = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("RagioneSociale_fl");
            ASPxFormLayout Edit_FormLayout = (ASPxFormLayout)EditForm_CallbackPanel.FindControl("Edit_FormLayout");
            ASPxTextBox NomeUtenteIntranet_Txt = (ASPxTextBox)Edit_FormLayout.FindControl("NomeUtenteIntranet_Txt");
            if (grid.GetRowValues(grid.FocusedRowIndex, "Description").ToString().Contains("AgeEsterno"))
            {
                InsUpdRagioneSociale_Rivenditore(RagioneSociale_fl, false, NomeUtenteIntranet_Txt.Text);
            }
        }
    }
}