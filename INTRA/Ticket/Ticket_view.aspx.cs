using DevExpress.Web;
using DevExpress.Web.Data;
using DevExpress.XtraPrinting.Native;
using info4lab.Portal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ticket
{
    public partial class Ticket_view : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Imposta i FormView in modalità edit solo al primo caricamento
                FormViewTicket.DefaultMode = FormViewMode.Edit;
                FormViewTicket.DataBind();
                FormViewDettagliIntervento.DefaultMode = FormViewMode.Edit;
                FormViewDettagliIntervento.DataBind();
            }
        }

        protected void MotivoChiamata_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            Portal4Set PortalConfig = new Portal4Set();

            if (FormViewTicket.CurrentMode == FormViewMode.Edit)
            {
                // Recupera il controllo ClientiComboBox
                ASPxComboBox clientiCombo = FormViewTicket.FindControl("ClientiComboBox") as ASPxComboBox;
                // Recupera il controllo InterventoPreso_Txt
                ASPxTextBox interventoPresoTxt = FormViewTicket.FindControl("InterventoPreso_Txt") as ASPxTextBox;
                // Recupera il RadioButtonList
                RadioButtonList tipoEsecuzione = FormViewTicket.FindControl("Rbl_TCK_TipoEsecuzione") as RadioButtonList;

                if (tipoEsecuzione != null && (tipoEsecuzione.SelectedIndex == 0 || Convert.ToInt32(tipoEsecuzione.SelectedValue) == 1 || Convert.ToInt32(tipoEsecuzione.SelectedValue) == 5))
                {
                    // Se è un certo tipo di esecuzione, popola il campo con dati del cliente selezionato
                    if (clientiCombo != null && clientiCombo.SelectedItem != null)
                        interventoPresoTxt.Text = clientiCombo.SelectedItem.GetFieldValue("Denom") + " - " + clientiCombo.SelectedItem.GetFieldValue("Loc") + " - " + clientiCombo.SelectedItem.GetFieldValue("Ind");
                    else
                        interventoPresoTxt.Text = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
                }
                else
                {
                    // Per altri tipi di esecuzione, usa valore di default
                    interventoPresoTxt.Text = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
                }
            }
        }
        protected void Edit_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            FormViewTicket.DataBind();
        }
        protected void Update_FormLayout_Callback_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            try
            {
                ASPxFormLayout layout = FormViewTicket.FindControl("formlayout") as ASPxFormLayout;
                if (layout == null) return;
                // Recupera i controlli necessari dal layout
                var oggettoMemo = layout.FindControl("OggettoTck_Memo") as ASPxMemo;
                var areaAss = layout.FindControl("rbtAreaAss") as ASPxComboBox;
                var priorita = layout.FindControl("Rbl_TCK_PrioritaRichiesta") as ASPxComboBox;
                var tipoChiamata = layout.FindControl("rbtTipoChiamata") as ASPxComboBox;
                var tipoEsecuzione = layout.FindControl("Rbl_TCK_TipoEsecuzione") as ASPxComboBox;
                var contattoTxt = layout.FindControl("Contatto_Txt_DX") as ASPxTextBox;
                var telefonoTxt = layout.FindControl("Telefono_Txt_DX") as ASPxTextBox;
                var emailTxt = layout.FindControl("Email_Txt_DX") as ASPxTextBox;
                var motivoMemo = layout.FindControl("Motivo_Chiamata_Txt_DX") as ASPxMemo;
                var clientiCombo = layout.FindControl("ClientiComboBox") as ASPxComboBox;
                // Setta i parametri dello SqlDataSource (DtsTestataRapp) usando i valori dei controlli
                DtsTestataRapp.UpdateParameters["CodCli"].DefaultValue = clientiCombo?.Value?.ToString() ?? "";
                DtsTestataRapp.UpdateParameters["TCK_AreaCompetenza"].DefaultValue = areaAss?.Value?.ToString() ?? "0";
                DtsTestataRapp.UpdateParameters["TCK_PrioritaRichiesta"].DefaultValue = priorita?.Value?.ToString() ?? "0";
                DtsTestataRapp.UpdateParameters["TCK_TipoRichiesta"].DefaultValue = tipoChiamata?.Value?.ToString() ?? "0";
                DtsTestataRapp.UpdateParameters["TCK_TipoEsecuzione"].DefaultValue = tipoEsecuzione?.Value?.ToString() ?? "0";
                DtsTestataRapp.UpdateParameters["PersonaDaContattare"].DefaultValue = contattoTxt?.Text ?? "";
                DtsTestataRapp.UpdateParameters["Telefono"].DefaultValue = telefonoTxt?.Text ?? "";
                DtsTestataRapp.UpdateParameters["Email"].DefaultValue = emailTxt?.Text ?? "";
                DtsTestataRapp.UpdateParameters["OggettoTCK"].DefaultValue = oggettoMemo?.Text ?? "";
                DtsTestataRapp.UpdateParameters["MotivoChiamata"].DefaultValue = motivoMemo?.Text ?? "";
                DtsTestataRapp.UpdateParameters["IdTicket"].DefaultValue = Request.QueryString["IdTicket"] ?? "";

                DtsTestataRapp.Update();
            }
            catch (Exception ex)
            {
            }
        }
        protected void Update_FormLayoutDettagli_Intervento_Callback(object sender, CallbackEventArgs e)
        {
            try
            {
                ASPxFormLayout layout = FormViewDettagliIntervento.FindControl("formlayoutDettagliIntervento") as ASPxFormLayout;
                ASPxFormLayout layoutEseguito = FormViewEseguito.FindControl("FormViewEseguito") as ASPxFormLayout;
                if (layout == null) return;
                // Recupera i controlli necessari dal layout e layoutEseguito
                var oggettoMemo = layout.FindControl("OggettoTck_Memo") as ASPxMemo;
                var motivoMemo = layout.FindControl("Motivo_Chiamata_Txt_DX") as ASPxMemo;
                var descrizioneMemo = layout.FindControl("DescrPrest_Txt_DX") as ASPxMemo;
                var noteMemo = layout.FindControl("Note_Txt_DX") as ASPxMemo;
                var tipoEsecuzione = layoutEseguito.FindControl("Rbl_TCK_TipoEsecuzione") as ASPxRadioButtonList;
                var tipoFatturazione = layout.FindControl("TCK_TipoChiusuraChiamataFattura_Combobox") as ASPxComboBox;


                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                {
                    string query = @"UPDATE TCK_TestataTicket
                     SET OggettoTCK = @OggettoTCK, MotivoChiamata = @MotivoChiamata, LavoroEseguito = @LavoroEseguito, Note = @Note, TCK_TipoEsecuzione = @TCK_TipoEsecuzione, TCK_TipoChiusuraChiamataFattura = @TCK_TipoChiusuraChiamataFattura
                     WHERE CodRapportino = @IdTicket";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@OggettoTCK", oggettoMemo?.Text ?? "");
                        cmd.Parameters.AddWithValue("@MotivoChiamata", motivoMemo?.Text ?? "");
                        cmd.Parameters.AddWithValue("@LavoroEseguito", descrizioneMemo?.Text ?? "");
                        cmd.Parameters.AddWithValue("@Note", noteMemo?.Text ?? "");
                        cmd.Parameters.AddWithValue("@TCK_TipoEsecuzione", tipoEsecuzione?.Value ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@TCK_TipoChiusuraChiamataFattura", tipoFatturazione?.Value?.ToString() ?? "0");
                        cmd.Parameters.AddWithValue("@IdTicket", Request.QueryString["IdTicket"] ?? "");

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    DataRowView row = DtsTestataRapp.Select(DataSourceSelectArguments.Empty).Cast<DataRowView>().FirstOrDefault();
                    if (row != null)
                    {
                        int idStatus = Convert.ToInt32(row["idStatus"]);

                        if (layout == null) return;
                        // Trovo il RadioButtonList
                        ASPxRadioButtonList rblChiusura = layout.FindControl("Rbl_TCK_StatusChiamata_chiusura") as ASPxRadioButtonList;

                        if (rblChiusura != null)
                        {
                            // Abilita la lista se lo stato è 3
                            rblChiusura.Enabled = (idStatus == 3);
                            using (SqlConnection connChiusura = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                            {
                                string queryChiusura = @"UPDATE TCK_TestataTicket
                                     SET TCK_StatusChiamataChiusura = @TCK_StatusChiamataChiusura
                                     WHERE CodRapportino = @IdTicket";

                                using (SqlCommand cmd = new SqlCommand(queryChiusura, connChiusura))
                                {
                                    cmd.Parameters.AddWithValue("@TCK_StatusChiamataChiusura", rblChiusura?.Value ?? DBNull.Value);
                                    cmd.Parameters.AddWithValue("@IdTicket", Request.QueryString["IdTicket"] ?? "");

                                    connChiusura.Open();
                                    cmd.ExecuteNonQuery();
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }
        protected void Eseguito_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            FormViewEseguito.DataBind();
            FormViewDettagliIntervento.DataBind();
        }
        protected void Tecnici_Gridview_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            e.NewValues["DataIntervento"] = DateTime.Today;
        }
        protected void Tecnici_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            //Recupera i controlli dalla EditForm personalizzata
            var grid = (ASPxGridView)sender;

            ASPxTextBox txtInizio = (ASPxTextBox)grid.FindEditFormTemplateControl("Inizio_Txt");
            ASPxTextBox txtFine = (ASPxTextBox)grid.FindEditFormTemplateControl("Fine_Txt");
            ASPxDateEdit dataInterventoEdit = (ASPxDateEdit)grid.FindEditFormTemplateControl("DataInterventoEdit");

            //Salva orario inizio/fine come TimeSpan nel record
            if (txtInizio != null && txtFine != null)
            {
                DateTime oraInizio = Convert.ToDateTime(txtInizio.Text);
                DateTime oraFine = Convert.ToDateTime(txtFine.Text);

                e.NewValues["OraInizio"] = oraInizio.TimeOfDay;
                e.NewValues["OraFine"] = oraFine.TimeOfDay;
            }

            //Imposta la data intervento (oggi di default)
            if (dataInterventoEdit != null && dataInterventoEdit.Value != null)
                e.NewValues["DataIntervento"] = Convert.ToDateTime(dataInterventoEdit.Value);
            else
                e.NewValues["DataIntervento"] = DateTime.Today;

            //Collega il tecnico al ticket corrente tramite querystring
            int codRapportino = 0;
            if (Request.QueryString["IdTicket"] != null)
                int.TryParse(Request.QueryString["IdTicket"], out codRapportino);

            e.NewValues["CodRapportino"] = codRapportino;
        }
        protected void Tecnici_Gridview_RowInserted(object sender, ASPxDataInsertedEventArgs e)
        {
            //Recupera l'ID del ticket dalla query string
            int codRapportino = 0;
            if (Request.QueryString["IdTicket"] != null)
                int.TryParse(Request.QueryString["IdTicket"], out codRapportino);

            if (codRapportino > 0)
            {
                //Connessione DB per verificare quanti tecnici ci sono sul ticket
                string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    //Conta i tecnici già collegati al ticket
                    SqlCommand countCmd = new SqlCommand("SELECT COUNT(*) FROM TCK_DettTecniciTicket WHERE CodRapportino = @CodRapportino", conn);
                    countCmd.Parameters.AddWithValue("@CodRapportino", codRapportino);
                    int count = (int)countCmd.ExecuteScalar();

                    //Se almeno 1 tecnico inserito, aggiorna lo stato chiamata da "non assegnato" (1) a "aperto" (2)
                    if (count > 0)
                    {
                        SqlCommand updateStatusCmd = new SqlCommand(@"
                    UPDATE TCK_TestataTicket 
                    SET TCK_StatusChiamata = 2 
                    WHERE CodRapportino = @CodRapportino AND TCK_StatusChiamata = 1", conn);
                        updateStatusCmd.Parameters.AddWithValue("@CodRapportino", codRapportino);
                        updateStatusCmd.ExecuteNonQuery();
                    }
                }
            }
        }

        protected void Tecnici_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            // Recupera controlli dalla EditForm (orari e data intervento)
            var grid = (ASPxGridView)sender;

            ASPxTextBox txtInizio = (ASPxTextBox)grid.FindEditFormTemplateControl("Inizio_Txt");
            ASPxTextBox txtFine = (ASPxTextBox)grid.FindEditFormTemplateControl("Fine_Txt");
            ASPxDateEdit dataInterventoEdit = (ASPxDateEdit)grid.FindEditFormTemplateControl("DataInterventoEdit");

            // Converte orari e assegna a NewValues
            if (txtInizio != null && txtFine != null)
            {
                DateTime oraInizio = Convert.ToDateTime(txtInizio.Text);
                DateTime oraFine = Convert.ToDateTime(txtFine.Text);

                e.NewValues["OraInizio"] = oraInizio.TimeOfDay;
                e.NewValues["OraFine"] = oraFine.TimeOfDay;
            }

            // Assegna data intervento, default oggi se non impostata
            if (dataInterventoEdit != null && dataInterventoEdit.Value != null)
                e.NewValues["DataIntervento"] = Convert.ToDateTime(dataInterventoEdit.Value);
            else
                e.NewValues["DataIntervento"] = DateTime.Today;

            // Recupera IdTicket da querystring per controllare lo stato
            int codRapportino = 0;
            if (Request.QueryString["IdTicket"] != null)
                int.TryParse(Request.QueryString["IdTicket"], out codRapportino);

            if (codRapportino > 0)
            {
                // Connessione DB per contare tecnici collegati
                string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    SqlCommand countCmd = new SqlCommand("SELECT COUNT(*) FROM TCK_DettTecniciTicket WHERE CodRapportino = @CodRapportino", conn);
                    countCmd.Parameters.AddWithValue("@CodRapportino", codRapportino);
                    int count = (int)countCmd.ExecuteScalar();

                    // Se almeno 1 tecnico, aggiorna stato ticket a "aperto" (2)
                    if (count > 0)
                    {
                        SqlCommand updateStatusCmd = new SqlCommand(
                            "UPDATE TCK_TestataTicket SET TCK_StatusChiamata = 2 WHERE CodRapportino = @CodRapportino AND TCK_StatusChiamata = 1",
                            conn);
                        updateStatusCmd.Parameters.AddWithValue("@CodRapportino", codRapportino);
                        updateStatusCmd.ExecuteNonQuery();
                    }
                }
            }
        }
        protected void Tecnici_Gridview_RowDeleted(object sender, ASPxDataDeletedEventArgs e)
        {
            // Recupera IdTicket da querystring
            int codRapportino = 0;
            if (Request.QueryString["IdTicket"] != null)
                int.TryParse(Request.QueryString["IdTicket"], out codRapportino);

            if (codRapportino == 0) return;

            // Connessione DB per verificare quanti tecnici rimangono associati
            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Conta i tecnici ancora associati al ticket
                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM TCK_DettTecniciTicket WHERE CodRapportino = @CodRapportino", conn);
                checkCmd.Parameters.AddWithValue("@CodRapportino", codRapportino);

                int count = (int)checkCmd.ExecuteScalar();

                // Se nessun tecnico rimane, setta lo stato ticket a "non assegnati" (1)
                if (count == 0)
                {
                    SqlCommand updateStatusCmd = new SqlCommand("UPDATE TCK_TestataTicket SET TCK_StatusChiamata = 1 WHERE CodRapportino = @CodRapportino", conn);
                    updateStatusCmd.Parameters.AddWithValue("@CodRapportino", codRapportino);
                    updateStatusCmd.ExecuteNonQuery();
                }
            }
        }

        protected void Tecnici_Gridview_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
        {
            // Se la colonna è "OraInizio" o "OraFine"
            if (e.Column.FieldName == "OraInizioVuota")
            {
                e.Value = DateTime.MinValue.Add((TimeSpan)e.GetListSourceFieldValue("OraInizio"));
            }
            else if (e.Column.FieldName == "OraFineVuota")
            {
                e.Value = DateTime.MinValue.Add((TimeSpan)e.GetListSourceFieldValue("OraFine"));
            }
        }
        protected void Tecnici_Gridview_DataBound(object sender, EventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;

            // Conta quante righe sono visibili nella grid
            int totalTecnici = grid.VisibleRowCount;

            // Inizializzo la variabile che conterrà la somma totale delle ore
            double totalOre = 0;

            for (int i = 0; i < grid.VisibleRowCount; i++)
            {
                // Prende il valore dell'ora di inizio e di fine della riga corrente
                var oraInizioObj = grid.GetRowValues(i, "OraInizio");
                var oraFineObj = grid.GetRowValues(i, "OraFine");

                if (oraInizioObj != DBNull.Value && oraFineObj != DBNull.Value)
                {
                    TimeSpan oraInizio = (TimeSpan)oraInizioObj;
                    TimeSpan oraFine = (TimeSpan)oraFineObj;

                    if (oraFine > oraInizio)
                    {
                        totalOre += (oraFine - oraInizio).TotalHours;
                    }
                }
            }

            // Passa i valori al client con RegisterStartupScript
            if (Page != null && !Page.ClientScript.IsStartupScriptRegistered("updateSummary"))
            {
                string script = $@"
        document.getElementById('totalTecnici').innerText = '{totalTecnici}';
        document.getElementById('tempoTicket').innerText = '{totalOre:0.##}';
    ";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "updateSummary", script, true);
            }
        }
        protected void FormViewDettagliIntervento_DataBound(object sender, EventArgs e)
        {
            if (FormViewDettagliIntervento.CurrentMode == FormViewMode.Edit)
            {
                // Estraggo il primo DataRowView
                DataRowView row = DtsTestataRapp.Select(DataSourceSelectArguments.Empty).Cast<DataRowView>().FirstOrDefault();
                if (row != null)
                {
                    int idStatus = Convert.ToInt32(row["idStatus"]);

                    ASPxFormLayout layout = FormViewDettagliIntervento.FindControl("formlayoutDettagliIntervento") as ASPxFormLayout;
                    if (layout == null) return;
                    // Trovo il RadioButtonList
                    ASPxRadioButtonList rblChiusura = layout.FindControl("Rbl_TCK_StatusChiamata_chiusura") as ASPxRadioButtonList;

                    if (rblChiusura != null)
                    {
                        rblChiusura.Enabled = (idStatus == 3);

                        if (!rblChiusura.Enabled)
                            rblChiusura.CssClass = "disabled-radio";
                    }
                }
            }
        }

        protected void ForzaChiusura_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string noteAnnullamento = e.Parameter;
            string idTicket = Request.QueryString["IdTicket"];

            //Esegui update solo se ci sono sia ID che note compilate
            if (!string.IsNullOrEmpty(idTicket) && !string.IsNullOrEmpty(noteAnnullamento))
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(@"
                UPDATE TCK_TestataTicket 
                SET NoteAnnullamentoTck = @note, TCK_StatusChiamata = 7, TCK_StatusChiamataChiusura = 6 
                WHERE CodRapportino = @idTicket", conn))
                    {
                        cmd.Parameters.AddWithValue("@note", noteAnnullamento);
                        cmd.Parameters.AddWithValue("@idTicket", idTicket);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
        protected void ForzaRiapertura_Callback_Callback(object sender, DevExpress.Web.CallbackEventArgs e)
        {
            string idTicket = Request.QueryString["IdTicket"];

            string connectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = "UPDATE TCK_TestataTicket SET TCK_StatusChiamata = 3, TCK_StatusChiamataChiusura = 3 WHERE CodRapportino = @IdTicket";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@IdTicket", idTicket);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        protected void AvviaTicket_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string idTicket = Request.QueryString["IdTicket"];

            if (!string.IsNullOrEmpty(idTicket))
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                {
                    string query = "UPDATE TCK_TestataTicket SET TCK_StatusChiamata = 3 WHERE CodRapportino = @IdTicket";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@IdTicket", idTicket);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

    }
}