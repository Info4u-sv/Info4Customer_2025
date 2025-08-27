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
using System.Web.Security;
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
                FormViewTicketSpese.DefaultMode = FormViewMode.Edit;
                FormViewTicketSpese.DataBind();
                FormViewTicketMateriali.ChangeMode(FormViewMode.Insert);
                FormViewTicketMateriali.DataBind();

                // Gestione visibilità bottoni
                string idTicket = Request.QueryString["IdTicket"];
                if (!string.IsNullOrEmpty(idTicket))
                {
                    var (status, chiusura) = GetStatusChiamata(idTicket);

                    // Reset visibilità a false per tutti
                    AssociaTecnico_Btn.Visible = false;
                    AvviaTicket_Btn.Visible = false;
                    ForzaChiusura_Btn.Visible = false;
                    ModificaNoteTecnico_Btn.Visible = false;
                    TornaAllaLista_Btn.Visible = false;
                    FirmaT_Btn.Visible = false;

                    if (status == 1)
                    {
                        AssociaTecnico_Btn.Visible = true;
                        ForzaChiusura_Btn.Visible = true;
                        ModificaNoteTecnico_Btn.Visible = true;
                        TornaAllaLista_Btn.Visible = true;
                        GeneraPDF_Btn.Visible = true;
                        ApertoStatusTCK_Pnl.Visible = true;

                    }
                    else if (status == 2)
                    {
                        AvviaTicket_Btn.Visible = true;
                        ForzaChiusura_Btn.Visible = true;
                        ModificaNoteTecnico_Btn.Visible = true;
                        TornaAllaLista_Btn.Visible = true;
                        GeneraPDF_Btn.Visible = true;
                        AssegnatoStatusTCK_Pnl.Visible = true;
                    }
                    else if (status == 3)
                    {
                        ChiudiTicket_Btn.Visible = true;
                        ForzaChiusura_Btn.Visible = true;
                        ModificaNoteTecnico_Btn.Visible = true;
                        TornaAllaLista_Btn.Visible = true;
                        GeneraPDF_Btn.Visible = true;
                        LavorazioneStatusTCK_Pnl.Visible = true;
                        FirmaT_Btn.Visible = true;
                    }
                    else if (status == 7 && chiusura == 4)
                    {
                        ForzaRiapertura_Btn.Visible = true;
                        TornaAllaLista_Btn.Visible = true;
                        GeneraPDF_Btn.Visible = true;
                        ChiusoStatusTCK_Pnl.Visible = true;
                        DisableControls(FormViewTicket);
                        DisableControls(FormViewDettagliIntervento);
                        DisableControls(FormViewTicketSpese);
                        DisableControls(FormViewTicketMateriali);
                        DisableControls(FormViewEseguito);
                        UpdateTicketBtn.Visible = false;
                        BootstrapButton3.Visible = false;
                        BootstrapButton1.Visible = false;
                        BootstrapButton5.Visible = false;
                        // Disabilita tutti tranne il delete
                        Tecnici_Gridview.SettingsEditing.Mode = GridViewEditingMode.EditForm;

                        // Nascondi bottoni New ed Edit
                        Tecnici_Gridview.Columns.OfType<GridViewCommandColumn>().ToList().ForEach(col =>
                        {
                            col.ShowNewButtonInHeader = false;
                            col.ShowEditButton = false;
                        });

                        // Disabilita update automatico
                        Tecnici_Gridview.SettingsBehavior.AllowFocusedRow = false;
                    }
                    else if (status == 7 && chiusura == 6)
                    {
                        ForzaRiapertura_Btn.Visible = true;
                        TornaAllaLista_Btn.Visible = true;
                        GeneraPDF_Btn.Visible = true;
                        Annullato_Pnl.Visible = true;
                        DisableControls(FormViewTicket);
                        DisableControls(FormViewDettagliIntervento);
                        DisableControls(FormViewTicketSpese);
                        DisableControls(FormViewTicketMateriali);
                        DisableControls(FormViewEseguito);
                        UpdateTicketBtn.Visible = false;
                        BootstrapButton3.Visible = false;
                        BootstrapButton1.Visible = false;
                        BootstrapButton5.Visible = false;
                        // Disabilita tutti tranne il delete
                        Tecnici_Gridview.SettingsEditing.Mode = GridViewEditingMode.EditForm;

                        // Nascondi bottoni New ed Edit
                        Tecnici_Gridview.Columns.OfType<GridViewCommandColumn>().ToList().ForEach(col =>
                        {
                            col.ShowNewButtonInHeader = false;
                            col.ShowEditButton = false;
                        });

                        // Disabilita update automatico
                        Tecnici_Gridview.SettingsBehavior.AllowFocusedRow = false;
                    }
                }
                else
                {
                    // Nascondi tutti se manca idTicket
                    AssociaTecnico_Btn.Visible = false;
                    AvviaTicket_Btn.Visible = false;
                    ForzaChiusura_Btn.Visible = false;
                    ModificaNoteTecnico_Btn.Visible = false;
                    TornaAllaLista_Btn.Visible = false;
                    GeneraPDF_Btn.Visible = false;
                    FirmaT_Btn.Visible = false;
                    ApertoStatusTCK_Pnl.Visible = false;
                    AssegnatoStatusTCK_Pnl.Visible = false;
                    LavorazioneStatusTCK_Pnl.Visible = false;
                    ChiusoStatusTCK_Pnl.Visible = false;
                }
            }
        }


        private void DisableControls(Control parent)
        {
            foreach (Control c in parent.Controls)
            {
                if (c is WebControl wc)
                    wc.Enabled = false;

                if (c.HasControls())
                    DisableControls(c);
            }
        }
        protected void StatusTicket_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string idTicket = Request.QueryString["IdTicket"];
            if (!string.IsNullOrEmpty(idTicket))
            {
                var (status, chiusura) = GetStatusChiamata(idTicket);

                // Reset visibilità a false per tutti
                ApertoStatusTCK_Pnl.Visible = false;
                AssegnatoStatusTCK_Pnl.Visible = false;
                LavorazioneStatusTCK_Pnl.Visible = false;
                ChiusoStatusTCK_Pnl.Visible = false;

                if (status == 1)
                {
                    ApertoStatusTCK_Pnl.Visible = true;
                }
                else if (status == 2)
                {
                    AssegnatoStatusTCK_Pnl.Visible = true;
                }
                else if (status == 3)
                {
                    LavorazioneStatusTCK_Pnl.Visible = true;
                }
                else if (status == 7 && chiusura == 4)
                {
                    ChiusoStatusTCK_Pnl.Visible = true;
                }
            }
            else
            {
                // Nascondi tutti se manca idTicket
                ApertoStatusTCK_Pnl.Visible = false;
                AssegnatoStatusTCK_Pnl.Visible = false;
                LavorazioneStatusTCK_Pnl.Visible = false;
                ChiusoStatusTCK_Pnl.Visible = false;
            }
        }
        private (int StatusChiamata, int StatusChiusura) GetStatusChiamata(string idTicket)
        {
            int status = -1;
            int chiusura = -1;
            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT TCK_StatusChiamata, TCK_StatusChiamataChiusura FROM TCK_TestataTicket WHERE CodRapportino = @IdTicket";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@IdTicket", idTicket);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        status = reader["TCK_StatusChiamata"] != DBNull.Value ? Convert.ToInt32(reader["TCK_StatusChiamata"]) : -1;
                        chiusura = reader["TCK_StatusChiamataChiusura"] != DBNull.Value ? Convert.ToInt32(reader["TCK_StatusChiamataChiusura"]) : -1;
                    }
                }
            }
            return (status, chiusura);
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
            if (e.Parameter == "ChiudiTicket")
            {
                try
                {
                    ASPxFormLayout layout = FormViewDettagliIntervento.Row.FindControl("formlayoutDettagliIntervento") as ASPxFormLayout;
                    ASPxFormLayout layoutEseguito = FormViewEseguito.Row.FindControl("FormViewEseguito") as ASPxFormLayout;

                    var rblChiusura = layout.FindControl("Rbl_TCK_StatusChiamata_chiusura") as ASPxRadioButtonList;
                    var rblDaEseguire = layoutEseguito.FindControl("Rbl_TCK_TipoEsecuzione") as ASPxRadioButtonList;

                    if (rblChiusura == null || rblDaEseguire == null)
                        throw new Exception("Controlli radio non trovati.");

                    int chiusura = Convert.ToInt32(rblChiusura.Value);
                    int daEseguire = Convert.ToInt32(rblDaEseguire.Value);

                    if (chiusura != 4 && chiusura != 5 && chiusura != 6)
                    {
                        CallbackPnlFormView.JSProperties["cpResult"] = "ERROR|ValidationDettagliIntervento|Seleziona uno stato di chiusura.";
                        return;
                    }
                    if (daEseguire == 5)
                    {
                        CallbackPnlFormView.JSProperties["cpResult"] = "ERROR|ValidationEseguito|Alla chiusura del ticket il tipo di esecuzione non può essere su 'Non Definito'.";
                        return;
                    }

                    // Recupera il totale ore salvato
                    double totaleOre = 0;
                    if (ViewState["TotalOreTecnici"] != null)
                    {
                        totaleOre = (double)ViewState["TotalOreTecnici"];
                    }

                    if (totaleOre <= 0)
                    {
                        CallbackPnlFormView.JSProperties["cpResult"] = "ERROR|TotaleOre|Alla chiusura del ticket il totale ore non può essere 0.";
                        return;
                    }

                    string idTicket = Request.QueryString["IdTicket"];
                    if (string.IsNullOrEmpty(idTicket))
                        throw new Exception("Id ticket mancante.");

                    string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        string sql = @"
                    UPDATE TCK_TestataTicket
                    SET TCK_StatusChiamataChiusura = @Chiusura,
                        TCK_StatusChiamata = 7,
                        TCK_TipoEsecuzione = @DaEseguire
                    WHERE CodRapportino = @IdTicket";

                        using (SqlCommand cmd = new SqlCommand(sql, conn))
                        {
                            cmd.Parameters.AddWithValue("@Chiusura", chiusura);
                            cmd.Parameters.AddWithValue("@DaEseguire", daEseguire);
                            cmd.Parameters.AddWithValue("@IdTicket", idTicket);

                            int rows = cmd.ExecuteNonQuery();
                            if (rows == 0)
                                throw new Exception("Aggiornamento fallito, ticket non trovato.");
                        }
                    }

                    CallbackPnlFormView.JSProperties["cpResult"] = "OK";
                }
                catch (Exception ex)
                {
                    var parts = ex.Message.Split('|');
                    if (parts.Length == 2)
                        CallbackPnlFormView.JSProperties["cpResult"] = $"ERROR|Validation{parts[0]}|{parts[1]}";
                    else
                        CallbackPnlFormView.JSProperties["cpResult"] = "ERROR|GENERIC|" + ex.Message;
                }
            }
            else
            {
                FormViewTicket.DataBind();
                FormViewTicketSpese.DataBind();
                FormViewTicketMateriali.DataBind();
            }
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
        protected void Update_FormViewTicketSpe_Callback(object sender, DevExpress.Web.CallbackEventArgs e)
        {
            ASPxFormLayout layoutSpese = FormViewTicketSpese.FindControl("TicketAddFormSpese") as ASPxFormLayout;
            if (layoutSpese == null) return;

            // Recupera ID del ticket dalla querystring
            string idTicket = Request.QueryString["IdTicket"];
            if (string.IsNullOrEmpty(idTicket)) return;

            // Recupera i controlli dal FormView
            var txtDirittoFisso = layoutSpese.FindControl("TxtDirittoFisso") as ASPxTextBox;
            var txtSpeseViaggioKm = layoutSpese.FindControl("TxtSpeseViaggioKm") as ASPxTextBox;
            var txtSpeseViaggioEuro = layoutSpese.FindControl("TxtSpeseViaggioEuro") as ASPxTextBox;
            var txtTariffaOraria = layoutSpese.FindControl("TxtTariffaOraria") as ASPxTextBox;
            var txtTotaleEuroForfait = layoutSpese.FindControl("TxtTotaleEuroForfait") as ASPxTextBox;

            // Validazione
            if (txtDirittoFisso == null || txtSpeseViaggioKm == null || txtSpeseViaggioEuro == null ||
                txtTariffaOraria == null || txtTotaleEuroForfait == null)
            {
                return;
            }

            // Parsing valori
            decimal dirittoFisso = decimal.TryParse(txtDirittoFisso.Text, out decimal df) ? df : 0;
            decimal speseKm = decimal.TryParse(txtSpeseViaggioKm.Text, out decimal skm) ? skm : 0;
            decimal speseEuro = decimal.TryParse(txtSpeseViaggioEuro.Text, out decimal se) ? se : 0;
            decimal tariffa = decimal.TryParse(txtTariffaOraria.Text, out decimal t) ? t : 0;
            decimal totale = decimal.TryParse(txtTotaleEuroForfait.Text, out decimal tf) ? tf : 0;

            string query = @"
        UPDATE TCK_TestataTicket
        SET DirittoFisso = @DirittoFisso,
            SpeseViaggioKm = @SpeseViaggioKm,
            SpeseViaggioEuro = @SpeseViaggioEuro,
            TariffaOraria = @TariffaOraria,
            TotaleEuroForfait = @TotaleEuroForfait
        WHERE CodRapportino = @IdTicket";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@DirittoFisso", dirittoFisso);
                cmd.Parameters.AddWithValue("@SpeseViaggioKm", speseKm);
                cmd.Parameters.AddWithValue("@SpeseViaggioEuro", speseEuro);
                cmd.Parameters.AddWithValue("@TariffaOraria", tariffa);
                cmd.Parameters.AddWithValue("@TotaleEuroForfait", totale);
                cmd.Parameters.AddWithValue("@IdTicket", idTicket);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        protected void Update_FormViewTicketMat_Callback(object sender, DevExpress.Web.CallbackEventArgs e)
        {

            ASPxFormLayout layoutMateriali = FormViewTicketMateriali.FindControl("TicketAddFormMateriali") as ASPxFormLayout;
            if (layoutMateriali == null) return;

            string idTicket = Request.QueryString["IdTicket"];
            if (string.IsNullOrEmpty(idTicket)) return;

            // Recupera i valori
            string codMateriale = (layoutMateriali.FindControl("TxtCodMateriale") as ASPxTextBox)?.Text?.Trim();
            string descrizione = (layoutMateriali.FindControl("TxtDescrizione") as ASPxTextBox)?.Text?.Trim();
            string um = (layoutMateriali.FindControl("TxtUm") as ASPxTextBox)?.Text?.Trim();
            decimal qta = (layoutMateriali.FindControl("TxtQta") as ASPxSpinEdit)?.Number ?? 0;

            if (string.IsNullOrWhiteSpace(codMateriale) ||
                string.IsNullOrWhiteSpace(descrizione) ||
                string.IsNullOrWhiteSpace(um) ||
                qta <= 0)
            {
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string sql = @"
                INSERT INTO TCK_DettRicambiTicket
                (CodRapportino, CodMateriale, Descrizione, Um, Qta)
                VALUES
                (@CodRapportino, @CodMateriale, @Descrizione, @Um, @Qta)";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@CodRapportino", idTicket);
                        cmd.Parameters.AddWithValue("@CodMateriale", codMateriale);
                        cmd.Parameters.AddWithValue("@Descrizione", descrizione);
                        cmd.Parameters.AddWithValue("@Um", um);
                        cmd.Parameters.AddWithValue("@Qta", qta);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
            }
        // Reset campi form
        (layoutMateriali.FindControl("TxtCodMateriale") as ASPxTextBox).Text = "";
            (layoutMateriali.FindControl("TxtDescrizione") as ASPxTextBox).Text = "";
            (layoutMateriali.FindControl("TxtUm") as ASPxTextBox).Text = "";
            (layoutMateriali.FindControl("TxtQta") as ASPxSpinEdit).Number = 0;
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

            int totalTecnici = grid.VisibleRowCount;
            double totalOre = 0;

            for (int i = 0; i < grid.VisibleRowCount; i++)
            {
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

            ViewState["TotalOreTecnici"] = totalOre;

            if (Page != null && !Page.ClientScript.IsStartupScriptRegistered("updateSummary"))
            {
                string script = $@"
            document.getElementById('totalTecnici').innerText = '{totalTecnici}';
            document.getElementById('tempoTicket').innerText = '{totalOre:0.##}';
        ";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "updateSummary", script, true);
            }
        }
        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int id = Convert.ToInt32(e.Keys["id"]);
            string codMateriale = e.NewValues["CodMateriale"]?.ToString();
            string descrizione = e.NewValues["Descrizione"]?.ToString();
            string um = e.NewValues["Um"]?.ToString();
            decimal qta = 0;
            if (e.NewValues["Qta"] != null)
                decimal.TryParse(e.NewValues["Qta"].ToString(), out qta);

            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = @"UPDATE TCK_DettRicambiTicket 
                       SET CodMateriale = @CodMateriale, Descrizione = @Descrizione, Um = @Um, Qta = @Qta
                       WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@CodMateriale", codMateriale ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Descrizione", descrizione ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Um", um ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Qta", qta);
                    cmd.ExecuteNonQuery();
                }
            }

            e.Cancel = true;
            Generic_Gridview.CancelEdit();
            Generic_Gridview.DataBind();
        }

        protected void Generic_Gridview_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int id = Convert.ToInt32(e.Keys["id"]);

            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = @"DELETE FROM TCK_DettRicambiTicket WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }

            e.Cancel = true;
            Generic_Gridview.DataBind();
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
        protected void NoteTecnico_Ckbl_DataBound(object sender, EventArgs e)
        {
            var ckbl = sender as CheckBoxList;
            if (ckbl == null) return;

            int idTicket;
            if (!int.TryParse(Request.QueryString["IdTicket"], out idTicket))
                return;

            var tecniciAssegnati = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT Utente FROM TCK_DettTecniciTicket WHERE CodRapportino = @CodRapportino";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@CodRapportino", idTicket);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        tecniciAssegnati.Add(reader["Utente"].ToString());
                    }
                }
            }

            foreach (ListItem item in ckbl.Items)
            {
                item.Selected = tecniciAssegnati.Contains(item.Value);
            }
        }
        protected void CallbackPanelModificaNoteTecnico_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter == "SalvaNoteTecnico")
            {
                SalvaNoteTecnico();
                ASPxCallbackPanel panel = (ASPxCallbackPanel)sender;
                panel.JSProperties["cpSaved"] = "OK";
            }
        }
        private Webservice_primo_online.TCK_Ticket_WS GetTicketDetails(int idTicket)
        {
            var ticket = new Webservice_primo_online.TCK_Ticket_WS();

            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"
SELECT cast(TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura as nvarchar) + case when ISNULL(TCK_TestataTicket.IDContrattoAssistenza,'') = '' then '' else '-' + TCK_TestataTicket.IDContrattoAssistenza end as IDContrattoAssistenza, TCK_StatusChiamata.Id AS idStatus, TCK_TestataTicket.OggettoTCK, TCK_TestataTicket.InsertUser, TCK_TestataTicket.PersonaDaContattare, TCK_TipoRichiesta.Id , TCK_TipoRichiesta.Descrizione AS TipoChiamata, TCK_TipoRichiesta.LabelClass AS Colore, TCK_TestataTicket.CodRapportino, TCK_TestataTicket.Società, TCK_AreaCompetenza.Descrizione AS AreaAss, Clienti.Denom + ' - ' + Clienti.Loc + ' - ' + Clienti.Ind AS InterventoPresso , TCK_AreaCompetenza.LabelClass AS ColoreArea, TCK_TestataTicket.CreatedOn AS DataIns, TCK_PrioritaRichiesta.Descrizione AS PrioritaDescr, TCK_PrioritaRichiesta.LabelClass AS PrioritaColore, TCK_TipoEsecuzione.Descrizione AS TipoEsecDescr, TCK_TipoEsecuzione.LabelClass AS TipoEsecColore, TCK_TestataTicket.MotivoChiamata, TCK_TestataTicket.TCK_TipoRichiesta, TCK_TestataTicket.TCK_TipoEsecuzionePresunta, TCK_TestataTicket.TCK_AreaCompetenza, TCK_TestataTicket.TCK_TipoEsecuzione, TCK_TestataTicket.TCK_StatusChiamataChiusura, TCK_TestataTicket.TCK_StatusChiamata, TCK_TestataTicket.TCK_PrioritaRichiesta, TCK_TestataTicket.CodCli, TCK_TestataTicket.NoteTecnico, TCK_TestataTicket.Note, TCK_TestataTicket.GuastoRilevato, TCK_TestataTicket.LavoroEseguito, TCK_TestataTicket.InterventoChiuso, TCK_TestataTicket.Osservazioni, TCK_TestataTicket.DataIntervento, TCK_TestataTicket.DataIns AS Expr1, TCK_TestataTicket.NomePersonaRiferimento, TCK_TestataTicket.TelPersonaRiferimento, TCK_TestataTicket.MailPersonaRiferimento, Clienti.Denom + ' - ' + Clienti.Loc + ' - ' + Clienti.Ind AS InterventoPresso, TCK_TestataTicket.OraInzioIntervento, TCK_TestataTicket.OraFineIntervento, TCK_TestataTicket.DirittoFisso, TCK_TestataTicket.TariffaOraria, TCK_TestataTicket.SpeseViaggioKm, TCK_TestataTicket.SpeseViaggioEuro, TCK_TestataTicket.TotaleEuroForfait, TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura, TCK_TestataTicket.ImgFirmaCliente, TCK_TestataTicket.FirmaCliente, TCK_TestataTicket.ImgFirmaTecnico, TCK_TestataTicket.FirmaTecnico, TCK_TestataTicket.TicketFirmato, TCK_TestataTicket.NoteAnnullamentoTck, TCK_TestataTicket.LinkTckPdf, TCK_TestataTicket.TckInviatoA, TCK_TestataTicket.TotTecnici, TCK_TestataTicket.TempoInterventoTotale, TCK_TestataTicket.UM, Tck_StatusControlloRegistrazione.Descrizione AS RegistrazioneRapp, Tck_StatusControlloRegistrazione.StatusControlloRegistrazione, TCK_TestataTicket.NumeroRegistrazione, TCK_TestataTicket.StatusControlloFatturazioneFinale, TCK_TestataTicket.NoteFatturazioneFinale, TCK_TestataTicket.StatusCotrolloFatt, TCK_StatusCotrolloFatt.Descrizione AS StatusFinaleFatt, TCK_TestataTicket.ApprovatoDa, Clienti.Cap, Clienti.Prov AS Provincia, Clienti.Loc AS Località, Clienti.Tel AS Telefono, Clienti.EMail AS Email, Clienti.Ind AS Indirizzo, Clienti.PIva, Clienti.Fax, Clienti.Denom, Clienti.Riferim AS PersonaDaContattare FROM TCK_AreaCompetenza INNER JOIN TCK_TestataTicket ON TCK_AreaCompetenza.IdAreaAss = TCK_TestataTicket.TCK_AreaCompetenza INNER JOIN TCK_StatusChiamata ON TCK_TestataTicket.TCK_StatusChiamata = TCK_StatusChiamata.Id INNER JOIN TCK_TipoRichiesta ON TCK_TestataTicket.TCK_TipoRichiesta = TCK_TipoRichiesta.Id INNER JOIN TCK_PrioritaRichiesta ON TCK_TestataTicket.TCK_PrioritaRichiesta = TCK_PrioritaRichiesta.Id INNER JOIN TCK_TipoEsecuzione ON TCK_TestataTicket.TCK_TipoEsecuzionePresunta = TCK_TipoEsecuzione.Id INNER JOIN Clienti ON TCK_TestataTicket.CodCli = Clienti.CodCli INNER JOIN Tck_StatusControlloRegistrazione ON TCK_TestataTicket.StatusControlloRegistrazione = Tck_StatusControlloRegistrazione.StatusControlloRegistrazione INNER JOIN TCK_StatusCotrolloFatt ON TCK_TestataTicket.StatusCotrolloFatt = TCK_StatusCotrolloFatt.Id WHERE (TCK_TestataTicket.CodRapportino = @IdTicket)";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@IdTicket", idTicket);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            ticket.CodRapportino = idTicket;
                            ticket.Società = reader["Società"].ToString();
                            ticket.TCK_PrioritaRichiesta_etichetta = reader["PrioritaDescr"].ToString();
                            ticket.TCK_AreaCompetenza_etichetta = reader["AreaAss"].ToString();
                            ticket.TCK_TipoRichiesta_etichetta = reader["TipoChiamata"].ToString();
                            ticket.TCK_TipoEsecuzione_etichetta = reader["TipoEsecDescr"].ToString();
                            ticket.NoteTecnico = reader["NoteTecnico"].ToString();
                            ticket.PersonaDaContattare = reader["PersonaDaContattare"].ToString();
                            ticket.MotivoChiamata = reader["MotivoChiamata"].ToString();
                            ticket.InterventoPresso = reader["InterventoPresso"].ToString();
                            ticket.NomePersonaRiferimento = reader["PersonaDaContattare"].ToString();
                            ticket.TelPersonaRiferimento = reader["TelPersonaRiferimento"].ToString();
                        }
                    }
                }
            }

            return ticket;
        }

        protected void SalvaNoteTecnico()
        {
            int idTicket = 0;
            if (!int.TryParse(Request.QueryString["IdTicket"], out idTicket))
                return;

            var noteTxt = (DevExpress.Web.ASPxMemo)FormView2.FindControl("NoteTecnico_Txt");
            var ckbl = (CheckBoxList)FormView2.FindControl("NoteTecnico_Ckbl");
            var toggle = (CheckBox)FormView2.FindControl("ToggleSwitch");

            if (noteTxt == null || ckbl == null || toggle == null)
                return;

            string note = noteTxt.Text.Trim();
            bool inviaMail = toggle.Checked;

            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Aggiorna NoteTecnico in TCK_TestataTicket
                using (SqlCommand cmd = new SqlCommand("UPDATE TCK_TestataTicket SET NoteTecnico = @Note WHERE CodRapportino = @IdTicket", conn))
                {
                    cmd.Parameters.AddWithValue("@Note", note);
                    cmd.Parameters.AddWithValue("@IdTicket", idTicket);
                    cmd.ExecuteNonQuery();
                }

                // Per ogni tecnico selezionato inserisci in TCK_DettTecniciTicket se non già presente
                foreach (ListItem item in ckbl.Items)
                {
                    if (item.Selected)
                    {
                        string username = item.Value;

                        using (SqlCommand checkCmd = new SqlCommand(
                            "SELECT COUNT(1) FROM TCK_DettTecniciTicket WHERE CodRapportino = @IdTicket AND Utente = @Utente", conn))
                        {
                            checkCmd.Parameters.AddWithValue("@IdTicket", idTicket);
                            checkCmd.Parameters.AddWithValue("@Utente", username);

                            int count = (int)checkCmd.ExecuteScalar();
                            if (count == 0)
                            {
                                using (SqlCommand insertCmd = new SqlCommand(@"
                        INSERT INTO TCK_DettTecniciTicket 
                        (CodRapportino, Utente, DataIntervento, OraInizio, OraFine) 
                        VALUES (@IdTicket, @Utente, @DataIntervento, @OraInizio, @OraFine)", conn))
                                {
                                    insertCmd.Parameters.AddWithValue("@IdTicket", idTicket);
                                    insertCmd.Parameters.AddWithValue("@Utente", username);
                                    insertCmd.Parameters.AddWithValue("@DataIntervento", DateTime.Today);
                                    insertCmd.Parameters.AddWithValue("@OraInizio", TimeSpan.Zero);
                                    insertCmd.Parameters.AddWithValue("@OraFine", TimeSpan.Zero);

                                    insertCmd.ExecuteNonQuery();
                                }
                            }
                        }
                    }
                }
            }

            if (inviaMail)
            {
                WS_TCK_Ticket _ObjWS = new WS_TCK_Ticket();
                var _TicketWS = GetTicketDetails(idTicket);

                Webservice_primo_online.WebService_primoSoapClient _ObjService = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");

                int TicketStatus = 9;
                MembershipUser UserLog = Membership.GetUser();

                var UserLogProfile = System.Web.Profile.ProfileBase.Create(UserLog.UserName);
                string NomeUtente = UserLogProfile.GetPropertyValue("nome")?.ToString() ?? "";

                foreach (ListItem TecSelected in ckbl.Items)
                {
                    if (TecSelected.Selected)
                    {
                        MembershipUser TecnicoInfo = Membership.GetUser(TecSelected.Value);
                        dynamic TecnicoProfile = ProfileCommon.Create(TecSelected.Value, true);
                        string MailTecnico = TecnicoProfile.email;
                        string NomeDelTecnico = TecnicoProfile.GetPropertyValue("nome")?.ToString() ?? "";

                        _ObjService.SendTicketMailAim(
                            idTicket,
                            TicketStatus,
                            NomeUtente,
                            _TicketWS,
                            MailTecnico,
                            NomeDelTecnico,
                            false,
                            "NoAttach",
                            idTicket.ToString()
                        );
                    }
                }
            }

            // Ricarica la grid
            Tecnici_Gridview.DataBind();

            // Calcola totali
            int totalTecnici = Tecnici_Gridview.VisibleRowCount;
            double totalOre = 0;
            for (int i = 0; i < Tecnici_Gridview.VisibleRowCount; i++)
            {
                var oraInizioObj = Tecnici_Gridview.GetRowValues(i, "OraInizio");
                var oraFineObj = Tecnici_Gridview.GetRowValues(i, "OraFine");

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

            // Passa dati a client per aggiornare summaryPanel
            CallbackPanelModificaNoteTecnico.JSProperties["cpTotalTecnici"] = totalTecnici.ToString();
            CallbackPanelModificaNoteTecnico.JSProperties["cpTotalOre"] = totalOre.ToString("0.##");
            CallbackPanelModificaNoteTecnico.JSProperties["cpSaved"] = "OK";
        }

        protected void CallbackPanelAssociaTecnico_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter != "SalvaAssociazioneTecnico")
                return;

            CallbackPanelAssociaTecnico.JSProperties["cpSaved"] = "KO";

            int idTicket;
            if (!int.TryParse(Request.QueryString["IdTicket"], out idTicket))
                return;

            // Recupera i controlli
            var ckbl = CallbackPanelAssociaTecnico.FindControl("AssociaTecnico_Ckbl") as CheckBoxList;
            var noteTxt = CallbackPanelAssociaTecnico.FindControl("NoteTecnicoAssocia_Txt") as ASPxMemo;
            var inviaCalendarChk = CallbackPanelAssociaTecnico.FindControl("InviaCalendarChk") as CheckBox;
            var dataIntervento = CallbackPanelAssociaTecnico.FindControl("DataInterventoEdit") as ASPxDateEdit;
            var inizioTxt = CallbackPanelAssociaTecnico.FindControl("Inizio_Txt") as ASPxTextBox;
            var fineTxt = CallbackPanelAssociaTecnico.FindControl("Fine_Txt") as ASPxTextBox;

            if (ckbl == null || noteTxt == null || inviaCalendarChk == null ||
                dataIntervento == null || inizioTxt == null || fineTxt == null)
                return;

            string note = noteTxt.Text.Trim();
            DateTime data = dataIntervento.Date == DateTime.MinValue ? DateTime.Today : dataIntervento.Date;

            TimeSpan oraInizio, oraFine;
            TimeSpan.TryParse(inizioTxt.Text, out oraInizio);
            TimeSpan.TryParse(fineTxt.Text, out oraFine);

            string connStr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Salva le note
                using (SqlCommand cmd = new SqlCommand("UPDATE TCK_TestataTicket SET NoteTecnico = @Note, TCK_StatusChiamata = 2 WHERE CodRapportino = @IdTicket", conn))
                {
                    cmd.Parameters.AddWithValue("@Note", note);
                    cmd.Parameters.AddWithValue("@IdTicket", idTicket);
                    cmd.ExecuteNonQuery();
                }

                // Salva i tecnici selezionati
                foreach (ListItem item in ckbl.Items)
                {
                    if (!item.Selected) continue;

                    string username = item.Value;

                    using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM TCK_DettTecniciTicket WHERE CodRapportino = @IdTicket AND Utente = @Utente", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@IdTicket", idTicket);
                        checkCmd.Parameters.AddWithValue("@Utente", username);

                        int count = (int)checkCmd.ExecuteScalar();

                        if (count == 0)
                        {
                            using (SqlCommand insertCmd = new SqlCommand(@"
                        INSERT INTO TCK_DettTecniciTicket (CodRapportino, Utente, DataIntervento, OraInizio, OraFine)
                        VALUES (@CodRapportino, @Utente, @DataIntervento, @OraInizio, @OraFine)", conn))
                            {
                                insertCmd.Parameters.AddWithValue("@CodRapportino", idTicket);
                                insertCmd.Parameters.AddWithValue("@Utente", username);
                                insertCmd.Parameters.AddWithValue("@DataIntervento", data);
                                insertCmd.Parameters.AddWithValue("@OraInizio", oraInizio);
                                insertCmd.Parameters.AddWithValue("@OraFine", oraFine);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            // Se flag è selezionato, invia email ai tecnici selezionati
            if (inviaCalendarChk.Checked)
            {
                WS_TCK_Ticket _ObjWS = new WS_TCK_Ticket();
                var _TicketWS = GetTicketDetails(idTicket);

                Webservice_primo_online.WebService_primoSoapClient _ObjService = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");

                int TicketStatus = 2;
                MembershipUser UserLog = Membership.GetUser();

                var UserLogProfile = System.Web.Profile.ProfileBase.Create(UserLog.UserName);
                string NomeUtente = UserLogProfile.GetPropertyValue("nome")?.ToString() ?? "";

                foreach (ListItem TecSelected in ckbl.Items)
                {
                    if (TecSelected.Selected)
                    {
                        MembershipUser TecnicoInfo = Membership.GetUser(TecSelected.Value);
                        dynamic TecnicoProfile = ProfileCommon.Create(TecSelected.Value, true);
                        string MailTecnico = TecnicoProfile.email;
                        string NomeDelTecnico = TecnicoProfile.GetPropertyValue("nome")?.ToString() ?? "";

                        _ObjService.SendTicketMailAim(
                            idTicket,
                            TicketStatus,
                            NomeUtente,
                            _TicketWS,
                            MailTecnico,
                            NomeDelTecnico,
                            false,
                            "NoAttach",
                            idTicket.ToString()
                        );
                    }
                }
            }

            // Ricarica la grid
            Tecnici_Gridview.DataBind();
            // Calcola totali
            int totalTecnici = Tecnici_Gridview.VisibleRowCount;
            double totalOre = 0;
            for (int i = 0; i < Tecnici_Gridview.VisibleRowCount; i++)
            {
                var oraInizioObj = Tecnici_Gridview.GetRowValues(i, "OraInizio");
                var oraFineObj = Tecnici_Gridview.GetRowValues(i, "OraFine");

                if (oraInizioObj != DBNull.Value && oraFineObj != DBNull.Value)
                {
                    oraInizio = (TimeSpan)oraInizioObj;
                    oraFine = (TimeSpan)oraFineObj;

                    if (oraFine > oraInizio)
                    {
                        totalOre += (oraFine - oraInizio).TotalHours;
                    }
                }
            }
            CallbackPanelAssociaTecnico.JSProperties["cpTotalTecnici"] = totalTecnici.ToString();
            CallbackPanelAssociaTecnico.JSProperties["cpTotalOre"] = totalOre.ToString("0.##");
            CallbackPanelAssociaTecnico.JSProperties["cpSaved"] = "OK";
        }


    }
}