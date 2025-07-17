<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InserimentoProspect.ascx.cs" Inherits="INTRA.Controls.InserimentoProspect" %>


<script type="text/javascript">
    // Gestione ASPxFloatingActionButton
    function OnInitFloatingActionButton(s, e) {
        fab.SetActionContext("NewRowContext", true);
        // AttachEvents();
    }
    function OnActionItemClick(s, e) {
        if (e.actionName === "NewRow") {
            InserimentoArticolo_Popup.Show();
        }
    }
    function onFileUploadCompleteGridviewDocumenti(s, e) {
        CaricamentoDoc_LoadingPnl.Hide();
        showNotification();
        InserimentoBigliettoDaVisita_Popup.Hide();
    }
</script>

<style>
    /*    .dropdown-menu li > a {
        padding: 5px !important;
    }

    .dxflCaption_Office365 {
        font-weight: bold !important;
        font-size: large !important;
        color: #808080 !important;
    }

    .material-icons {
        font-size: 26px;
    }

    .badge.BadgeTopBtn {
        margin-left: 0em;
        border-radius: 5px !important;
        font-size: large !important;
    }

    .btn:not(.btn-just-icon):not(.btn-fab) .fa, .navbar .navbar-nav > li > a.btn:not(.btn-just-icon):not(.btn-fab) .fa {
        font-size: 32px !important;
    }

    .TopBtn {
        padding: 4px !important;
    }

    .card .card-header.card-header-text {
        display: inline-block;
        padding-top: 15px !important;
    }

    .EditCaption {
        display: none !important;
    }

    .captionPadding {
        padding-bottom: 10px !important;
    }
*/
    .PopUpBtn {
        display: inline;
        float: right;
    }

    .adapt-caption {
        padding-top: 3px !important;
    }

    .to-right {
        float: right !important;
    }
</style>

<script type="text/javascript">
    var isProspect;

    function SaveIfProsp(isProsp) {
        isProspect = isProsp;
    }
    function ControlloPartitaIva_EndCallback(s, e) {
        //if (Provincia_Combobox.isValid) {
        //    if (Provincia_Combobox.GetSelectedItem().value == 'EE') {
        //        PIva_text.SetIsValid(true);
        //        ProspectGiaInserito_Grw.PerformCallback(0);
        //        if (ASPxClientEdit.ValidateGroup('NuovoProspectValidator')) {
        //            ConfermaOperazione('Conferma inserimento prospect', 'Salvataggio_Callback', '');
        //        }
        //    }
        //    else {
        //        if (PIva_text.cp_ValidazionePiva == '1') {
        //            PIva_text.SetIsValid(true);
        //            ProspectGiaInserito_Grw.PerformCallback(0);
        //            if (ASPxClientEdit.ValidateGroup('NuovoProspectValidator')) {
        //                ConfermaOperazione('Conferma inserimento prospect', 'Salvataggio_Callback', '');
        //            }
        //            else { ClientLoadingPanel.Hide(); }

        //        }
        //        else {
        //            ClientLoadingPanel.Hide();
        //            PIva_text.SetIsValid(false);
        //            ProspectGiaInserito_Grw.PerformCallback(1);
        //            PIva_text.SetErrorText('La partita iva è già presente nell\' archivio dei prospect.');
        //        }
        //    }
        //}
        //else {
        if (ASPxClientEdit.ValidateGroup('NuovoProspectValidator')) {
            ConfermaOperazione('Conferma inserimento prospect', 'Salvataggio_Callback', '');
        }

        /*}*/
    }

    function ValidazionePiva(s, e) {
        if (Provincia_Combobox.GetValue() != null) {
            if (Provincia_Combobox.GetSelectedItem().value == 'EE') {
                PIva_text.SetIsValid(true);
            }
        } else { PIva_text.SetIsValid(true); }
    }

    function OnButtonClick(text) {
        var msg;
        if (text == "Insert") {
            msg = "Conferma l'offerta con il Prospect inserito";
        } else { msg = "Conferma operazione"; }
        ConfermaOperazione(msg, 'ProspectDuplicato_CallbackPnl', text);
    }
    function SetCodDocValue(e) {
        var result = e.result;
        CodDoc_lbl.SetText("Codice documento -- " + result);

    }

    function OnSelectedProspectClick(s, e) {
        ConfermaOperazione('Conferma inserimento dati prospect selezionato', 'ProspectDuplicato_CallbackPnl', 'ButtonPressed');
    }

    function PerformCallbacks(s) {
        const splittedString = s.cp_Callbacks.split("|");
        var callbacks = [];
        var isSingleCallback;
        var lastIsDb = splittedString[splittedString.length - 1];
        var callback;
        var param = "";
        var i = 1;
        if (splittedString[0] == "M") {
            isSingleCallback = false;
            while (splittedString[i] != "P") {
                callbacks.push(eval(splittedString[i]));
                i++;
            }
        } else {
            isSingleCallback = true;
            callback = eval(splittedString[1]);
        }

        if (isSingleCallback) {
            for (j = 3; j < splittedString.length; j++) {
                if (j != splittedString.length - 1) {
                    param = param + splittedString[j] + "|";
                } else { param = param + splittedString[j]; }
            }
            callback.PerformCallback(param);
        } else {
            for (j = i + 1; j < splittedString.length; j++) {
                if (j != splittedString.length - 1) {
                    param = param + splittedString[j] + "|";
                } else { param = param + splittedString[j]; }
            }
            for (a = 0; a < callbacks.length; a++) {
                if (a != callbacks.length - 1) {
                    callbacks[a].PerformCallback(param);
                } else if (lastIsDb == "S") {
                    var splittedParam = param.split('|');
                    var InsertParam = splittedParam[0];
                    callbacks[a].PerformCallback("Insert|" + InsertParam);
                } else { callbacks[a].PerformCallback(param); }
            }
        }
    }

    function AdaptPopUp() {
        var ProspOrCli = isProspect ? "Prospect" : "Cliente";
        isPropect_txt.SetText(ProspOrCli);
        EtichettaPopUp_lbl.SetText("Nuovo " + ProspOrCli);
        ClearPopUP();
    }

    function ClearPopUP() {
        Denom_text.SetText("");
        Nazione_Combox.SetText("");
        CodAge_Combox.SetText("");
        Indirizzo_Txt.SetText("");
        Provincia_Combobox.SetText("");
        Cap_text.SetText("");
        Local_Txt.SetText("");
        Referente_txt.SetText("");
        EMail_text.SetText("");
        Tel_text.SetText("");
        PIva_text.SetText("");
        CF_Txt.SetText("");
    }

    function refresh_grid() {
        var GridName = GridName_txt.GetText();

        var grid = eval(GridName);

        grid.Refresh();
    }
</script>


<dx:ASPxLoadingPanel ID="CaricamentoDoc_LoadingPnl" ClientInstanceName="CaricamentoDoc_LoadingPnl" Modal="true" runat="server"></dx:ASPxLoadingPanel>

<%--<dx:ASPxFloatingActionButton VerticalPosition="Bottom" ID="ASPxFloatingActionButton1"
    runat="server" ClientInstanceName="fab" HorizontalMargin="25" ContainerElementID="form1">
    <ClientSideEvents ActionItemClick="OnActionItemClick" Init="OnInitFloatingActionButton" />
    <Items>
        <dx:FABAction ActionName="NewRow" ContextName="NewRowContext" Text="Nuovo">
        </dx:FABAction>
        <dx:FABActionGroup ContextName="FocusedRowContext">
        </dx:FABActionGroup>
    </Items>
</dx:ASPxFloatingActionButton>--%>

<%--<dx:ASPxLoadingPanel ID="InserimentoArticolo_LoadingPnl" ClientInstanceName="InserimentoArticolo_LoadingPnl" Modal="true" runat="server" Text="Estrazione colore dall'immagine ed inserimento nel database in corso..."></dx:ASPxLoadingPanel>--%>
<dx:ASPxTextBox runat="server" ID="GridName_txt" ClientInstanceName="GridName_txt" ClientVisible="false"></dx:ASPxTextBox>
<dx:ASPxPopupControl ID="InserimentoArticolo_Popup" ClientInstanceName="InserimentoArticolo_Popup" Modal="true" runat="server" PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" HeaderText="Insert" SettingsAdaptivity-Mode="OnWindowInnerWidth" ShowPageScrollbarWhenModal="true" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="CloseButton" Width="1000px" AllowDragging="true">
    <ClientSideEvents PopUp="function(s,e){AdaptPopUp()}" />
    <ClientSideEvents CloseUp="function(s,e){
            refresh_grid();
        }" />
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowTop" MaxWidth="1000px" HorizontalAlign="WindowCenter" />
    <ContentCollection>
        <dx:PopupControlContentControl>

            <dx:ASPxCallbackPanel ID="InserimentoArt_CallbackPnl" ClientInstanceName="InserimentoArt_CallbackPnl" runat="server" Width="100%">
                <ClientSideEvents EndCallback="function(s,e){InserimentoArticolo_Popup.Show()}" />
                <PanelCollection>
                    <dx:PanelContent>
                        <dx:ASPxTextBox runat="server" ID="isPropect_txt" ClientInstanceName="isPropect_txt" ClientVisible="false"></dx:ASPxTextBox>
                        <fieldset class="col-md-12" style="padding-left: 15px; border: solid 1px rgb(0,0,0,0.8);">
                            <legend class="no-margin no-padding" style="max-width: 200px; margin-bottom: 0px !important; padding-left: 10px !important;">
                                <dx:ASPxLabel runat="server" ID="EtichettaPopUp_lbl" ClientInstanceName="EtichettaPopUp_lbl" CssClass="card-title" Font-Size="Medium"></dx:ASPxLabel>
                            </legend>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-margin no-padding">
                                <dx:ASPxFormLayout runat="server" ID="InserimentoArticolo_FormLy" ClientInstanceName="InserimentoArticolo_FormLy" Width="100%" Paddings-Padding="0" BackColor="White" ValidateRequestMode="Disabled">
                                    <SettingsAdaptivity AdaptivityMode="Off" SwitchToSingleColumnAtWindowInnerWidth="800"></SettingsAdaptivity>
                                    <Border BorderWidth="0px" />
                                    <Items>
                                        <dx:LayoutGroup ColumnCount="12" Caption="" ShowCaption="False" Paddings-Padding="0">
                                            <Border BorderStyle="None" BorderWidth="0px"></Border>

                                            <Paddings Padding="0px"></Paddings>
                                            <Items>
                                                <dx:LayoutItem Caption="" ColumnSpan="12" ShowCaption="False" RequiredMarkDisplayMode="Hidden" Border-BorderStyle="None">
                                                    <Border BorderWidth="0px" />
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <%-- Caricamento biglietto da visista --%>
                                                            <%--<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                                                <label class="control-label TitleCell">Biglietto da visita:</label>
                                                                <dx:ASPxBinaryImage ID="BigliettoDaVisita_ImageBinary" ClientInstanceName="BigliettoDaVisita_ImageBinary" runat="server" ImageSizeMode="FitProportional" EnableServerResize="false">
                                                                    <EditingSettings Enabled="true" UploadSettings-UploadValidationSettings-MaxFileSize="4194304">
                                                                        <UploadSettings>
                                                                            <UploadValidationSettings MaxFileSize="4194304"></UploadValidationSettings>
                                                                        </UploadSettings>
                                                                    </EditingSettings>
                                                                </dx:ASPxBinaryImage>
                                                            </div>--%>
                                                            <div runat="server" id="CodDoc_div" class="col-md-3" style="float: right; margin-right: -6px; display: none;">
                                                                <dx:ASPxLabel runat="server" ID="CodDoc_lbl" ClientInstanceName="CodDoc_lbl" CssClass="right" Width="100%" ClientEnabled="false" Font-Bold="true" Font-Size="Large">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                            <div class="col-md-12 no-padding" style="padding-top: 15px;">
                                                                <%-- Prima riga (Ragione sociale,Nazione,Agente)--%>
                                                                <div class="col-md-6">
                                                                    <dx:ASPxTextBox ID="Denom_text" ClientInstanceName="Denom_text" Caption="Ragione Sociale" CaptionCellStyle-CssClass="dx-caption" Width="100%" runat="server">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator" ValidateOnLeave="false">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <dx:ASPxComboBox runat="server" ID="Nazione_Combox" ClientInstanceName="Nazione_Combox" Width="100%" Caption="Nazione" DataSourceID="Nazioni_Dts" ValueField="CodNaz" TextField="Descrizione" ValueType="System.String">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxComboBox>
                                                                    <dx:ASPxCallback runat="server" ID="GetCodDoc_Callback" ClientInstanceName="GetCodDoc_Callback" OnCallback="GetCodDoc_Callback_Callback">
                                                                        <ClientSideEvents CallbackComplete="function(s,e){
                                                                            SetCodDocValue(e);
                                                                            }" />
                                                                    </dx:ASPxCallback>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <dx:ASPxComboBox runat="server" ID="CodAge_Combox" ClientInstanceName="CodAge_Combox" Width="100%" Caption="Agente" DataSourceID="Agenti_dts" ValueField="CodAge" TextField="Descrizione" ValueType="System.String" SelectedIndex="0">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxComboBox>
                                                                    <asp:SqlDataSource runat="server" ID="Agenti_dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Cognome + ' ' + Nome AS Descrizione, CodAge FROM VIO_Utenti WHERE (CodAge <> N'NoAge') AND (CodAge LIKE @FiltroUtente)">
                                                                        <SelectParameters>
                                                                            <asp:CookieParameter CookieName="FiltroUtente" Name="FiltroUtente"></asp:CookieParameter>
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </div>



                                                                <%-- Riga due (Ind,Prov,Cap,Loc) --%>
                                                                <div class="col-md-5">
                                                                    <dx:ASPxTextBox ID="Indirizzo_Txt" ClientInstanceName="Indirizzo_Txt" Caption="Indirizzo:" Width="100%" runat="server">
                                                                        <%--<CssClasses Caption="TitleCell"></CssClasses>--%>
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <dx:ASPxComboBox ID="Provincia_Combobox" ClientInstanceName="Provincia_Combobox" Caption="Provincia:" runat="server" Width="100%" Value='<%# Eval("Prov") %>'>
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ClearButton DisplayMode="Always"></ClearButton>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="AG" Value="AG" />
                                                                            <dx:ListEditItem Text="AL" Value="AL" />
                                                                            <dx:ListEditItem Text="AN" Value="AN" />
                                                                            <dx:ListEditItem Text="AO" Value="AO" />
                                                                            <dx:ListEditItem Text="AQ" Value="AQ" />
                                                                            <dx:ListEditItem Text="AR" Value="AR" />
                                                                            <dx:ListEditItem Text="AP" Value="AP" />
                                                                            <dx:ListEditItem Text="AT" Value="AT" />
                                                                            <dx:ListEditItem Text="AV" Value="AV" />
                                                                            <dx:ListEditItem Text="BA" Value="BA" />
                                                                            <dx:ListEditItem Text="BT" Value="BT" />
                                                                            <dx:ListEditItem Text="BL" Value="BL" />
                                                                            <dx:ListEditItem Text="BN" Value="BN" />
                                                                            <dx:ListEditItem Text="BG" Value="BG" />
                                                                            <dx:ListEditItem Text="BI" Value="BI" />
                                                                            <dx:ListEditItem Text="BO" Value="BO" />
                                                                            <dx:ListEditItem Text="BZ" Value="BZ" />
                                                                            <dx:ListEditItem Text="BS" Value="BS" />
                                                                            <dx:ListEditItem Text="BR" Value="BR" />
                                                                            <dx:ListEditItem Text="CA" Value="CA" />
                                                                            <dx:ListEditItem Text="CL" Value="CL" />
                                                                            <dx:ListEditItem Text="CB" Value="CB" />
                                                                            <dx:ListEditItem Text="CI" Value="CI" />
                                                                            <dx:ListEditItem Text="CE" Value="CE" />
                                                                            <dx:ListEditItem Text="CT" Value="CT" />
                                                                            <dx:ListEditItem Text="CZ" Value="CZ" />
                                                                            <dx:ListEditItem Text="CH" Value="CH" />
                                                                            <dx:ListEditItem Text="CO" Value="CO" />
                                                                            <dx:ListEditItem Text="CS" Value="CS" />
                                                                            <dx:ListEditItem Text="CR" Value="CR" />
                                                                            <dx:ListEditItem Text="KR" Value="KR" />
                                                                            <dx:ListEditItem Text="CN" Value="CN" />
                                                                            <dx:ListEditItem Text="EN" Value="EN" />
                                                                            <dx:ListEditItem Text="FM" Value="FM" />
                                                                            <dx:ListEditItem Text="FE" Value="FE" />
                                                                            <dx:ListEditItem Text="FI" Value="FI" />
                                                                            <dx:ListEditItem Text="FG" Value="FG" />
                                                                            <dx:ListEditItem Text="FC" Value="FC" />
                                                                            <dx:ListEditItem Text="FR" Value="FR" />
                                                                            <dx:ListEditItem Text="GE" Value="GE" />
                                                                            <dx:ListEditItem Text="GO" Value="GO" />
                                                                            <dx:ListEditItem Text="GR" Value="GR" />
                                                                            <dx:ListEditItem Text="IM" Value="IM" />
                                                                            <dx:ListEditItem Text="IS" Value="IS" />
                                                                            <dx:ListEditItem Text="SP" Value="SP" />
                                                                            <dx:ListEditItem Text="LT" Value="LT" />
                                                                            <dx:ListEditItem Text="LE" Value="LE" />
                                                                            <dx:ListEditItem Text="LC" Value="LC" />
                                                                            <dx:ListEditItem Text="LI" Value="LI" />
                                                                            <dx:ListEditItem Text="LO" Value="LO" />
                                                                            <dx:ListEditItem Text="LU" Value="LU" />
                                                                            <dx:ListEditItem Text="MC" Value="MC" />
                                                                            <dx:ListEditItem Text="MN" Value="MN" />
                                                                            <dx:ListEditItem Text="MS" Value="MS" />
                                                                            <dx:ListEditItem Text="MT" Value="MT" />
                                                                            <dx:ListEditItem Text="VS" Value="VS" />
                                                                            <dx:ListEditItem Text="ME" Value="ME" />
                                                                            <dx:ListEditItem Text="MI" Value="MI" />
                                                                            <dx:ListEditItem Text="MO" Value="MO" />
                                                                            <dx:ListEditItem Text="MB" Value="MB" />
                                                                            <dx:ListEditItem Text="NA" Value="NA" />
                                                                            <dx:ListEditItem Text="NO" Value="NO" />
                                                                            <dx:ListEditItem Text="NU" Value="NU" />
                                                                            <dx:ListEditItem Text="OG" Value="OG" />
                                                                            <dx:ListEditItem Text="OT" Value="OT" />
                                                                            <dx:ListEditItem Text="OR" Value="OR" />
                                                                            <dx:ListEditItem Text="PD" Value="PD" />
                                                                            <dx:ListEditItem Text="PA" Value="PA" />
                                                                            <dx:ListEditItem Text="PR" Value="PR" />
                                                                            <dx:ListEditItem Text="PV" Value="PV" />
                                                                            <dx:ListEditItem Text="PG" Value="PG" />
                                                                            <dx:ListEditItem Text="PU" Value="PU" />
                                                                            <dx:ListEditItem Text="PE" Value="PE" />
                                                                            <dx:ListEditItem Text="PC" Value="PC" />
                                                                            <dx:ListEditItem Text="PI" Value="PI" />
                                                                            <dx:ListEditItem Text="PT" Value="PT" />
                                                                            <dx:ListEditItem Text="PN" Value="PN" />
                                                                            <dx:ListEditItem Text="PZ" Value="PZ" />
                                                                            <dx:ListEditItem Text="PO" Value="PO" />
                                                                            <dx:ListEditItem Text="RG" Value="RG" />
                                                                            <dx:ListEditItem Text="RA" Value="RA" />
                                                                            <dx:ListEditItem Text="RC" Value="RC" />
                                                                            <dx:ListEditItem Text="RE" Value="RE" />
                                                                            <dx:ListEditItem Text="RI" Value="RI" />
                                                                            <dx:ListEditItem Text="RN" Value="RN" />
                                                                            <dx:ListEditItem Text="RM" Value="RM" />
                                                                            <dx:ListEditItem Text="RO" Value="RO" />
                                                                            <dx:ListEditItem Text="SA" Value="SA" />
                                                                            <dx:ListEditItem Text="SS" Value="SS" />
                                                                            <dx:ListEditItem Text="SV" Value="SV" />
                                                                            <dx:ListEditItem Text="SI" Value="SI" />
                                                                            <dx:ListEditItem Text="SR" Value="SR" />
                                                                            <dx:ListEditItem Text="SO" Value="SO" />
                                                                            <dx:ListEditItem Text="TA" Value="TA" />
                                                                            <dx:ListEditItem Text="TE" Value="TE" />
                                                                            <dx:ListEditItem Text="TR" Value="TR" />
                                                                            <dx:ListEditItem Text="TO" Value="TO" />
                                                                            <dx:ListEditItem Text="TP" Value="TP" />
                                                                            <dx:ListEditItem Text="TN" Value="TN" />
                                                                            <dx:ListEditItem Text="TV" Value="TV" />
                                                                            <dx:ListEditItem Text="TS" Value="TS" />
                                                                            <dx:ListEditItem Text="UD" Value="UD" />
                                                                            <dx:ListEditItem Text="VA" Value="VA" />
                                                                            <dx:ListEditItem Text="VE" Value="VE" />
                                                                            <dx:ListEditItem Text="VB" Value="VB" />
                                                                            <dx:ListEditItem Text="VC" Value="VC" />
                                                                            <dx:ListEditItem Text="VR" Value="VR" />
                                                                            <dx:ListEditItem Text="VV" Value="VV" />
                                                                            <dx:ListEditItem Text="VI" Value="VI" />
                                                                            <dx:ListEditItem Text="VT" Value="VT" />
                                                                            <dx:ListEditItem Text="EE" Value="EE" />
                                                                        </Items>
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator"></ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxComboBox>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <dx:ASPxTextBox ID="Cap_text" ClientInstanceName="Cap_text" Caption="Cap:" CssClasses-Caption="TitleCell" Width="100%" runat="server" MaxLength="5">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <dx:ASPxTextBox ID="Local_Txt" ClientInstanceName="Local_Txt" Caption="Località" Width="100%" runat="server">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>

                                                                <%-- Riga tre (Referente,Email,Telefono) --%>

                                                                <div class="col-md-5">
                                                                    <dx:ASPxTextBox runat="server" ID="Referente_txt" ClientInstanceName="Referente_txt" Width="100%" Caption="Referente">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <dx:ASPxTextBox ID="EMail_text" ClientInstanceName="EMail_text" Caption="EMail:" Width="100%" runat="server">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="false" ValidationGroup="NuovoProspectValidator" RegularExpression-ValidationExpression="^\w+([-+.'%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorDisplayMode="None">
                                                                            <RegularExpression ValidationExpression="^\w+([-+.&#39;%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"></RegularExpression>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="Tel_text" ClientInstanceName="Tel_text" Caption="Tel:" Width="100%" runat="server">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <%--                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />--%>
                                                                    </dx:ASPxTextBox>
                                                                </div>

                                                                <div class="col-md-12 no-padding no-margin">
                                                                    <div class="col-md-4 float-left">
                                                                        <dx:ASPxCallbackPanel ID="Piva_Callbackpnl" ClientInstanceName="Piva_Callbackpnl" runat="server" OnCallback="Piva_Callbackpnl_Callback">
                                                                            <ClientSideEvents EndCallback="ControlloPartitaIva_EndCallback" />
                                                                            <PanelCollection>
                                                                                <dx:PanelContent>
                                                                                    <dx:ASPxTextBox ID="PIva_text" ClientInstanceName="PIva_text" Caption="P.Iva:" runat="server" MaxLength="11" Width="100%">
                                                                                        <CaptionSettings Position="Top" />
                                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                        <%--                                                                                    <ValidationSettings CausesValidation="false" ValidateOnLeave="false" RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="NuovoProspectValidator">
                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                    </ValidationSettings>
                                                                                    <InvalidStyle BackColor="LightPink" />--%>
                                                                                    </dx:ASPxTextBox>
                                                                                </dx:PanelContent>
                                                                            </PanelCollection>
                                                                        </dx:ASPxCallbackPanel>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4" style="display: none !important;">
                                                                    <dx:ASPxTextBox ID="CF_Txt" ClientInstanceName="CF_Txt" Caption="Codice fiscale:" Width="100%" runat="server" ClientVisible="false">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle CssClass="dx-caption adapt-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="false" ValidationGroup="NuovoProspectValidator" ErrorDisplayMode="None">
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" style="display: none;">
                                                                <dx:ASPxComboBox runat="server" ID="CanaleAcquisizione_Combobox" Visible="false" Caption="Canale acquisizione prospect" CaptionSettings-Position="Top" ClientInstanceName="CanaleAcquisizione_Combobox" DataSourceID="CanaliAcquisizione_Sql" ValueField="id" TextField="Descrizione" Width="100%">
                                                                    <CaptionSettings Position="Top" />
                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                    <%--                                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoProspectValidator" ErrorDisplayMode="None">
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />--%>
                                                                </dx:ASPxComboBox>
                                                                <asp:SqlDataSource runat="server" ID="CanaliAcquisizione_Sql" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT id, Descrizione FROM U_CRM4U_CanaliAcquisizione"></asp:SqlDataSource>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                    <Paddings Padding="0px"></Paddings>

                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="" ShowCaption="False" ColumnSpan="5" RequiredMarkDisplayMode="Hidden">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <div class="col-md-12">
                                                            </div>
                                                            <div style="padding-top: 15px; padding-left: 25.5px; width: 100%; display: none;">
                                                                <dx:ASPxComboBox ID="CondizioniPagamento_Combobx" Visible="false" ClientInstanceName="CondizioniPagamento_Combobx" runat="server" DataSourceID="CondizioniPagamento_Dts" ValueField="CodCPag" TextField="Descrizione" Caption="Condizioni di pagamento" Width="100%">
                                                                    <CaptionSettings Position="Top" />
                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px"></CaptionCellStyle>
                                                                    <InvalidStyle BackColor="LightPink" />
                                                                </dx:ASPxComboBox>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                    <Border BorderStyle="None"></Border>
                                                </dx:LayoutItem>


                                                <%-- Non usato --%>
                                                <dx:LayoutItem ClientVisible="false" Caption="" ColumnSpan="7" RequiredMarkDisplayMode="Hidden" Width="70%">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>

                                                            <%-- Descrizione HTML editor --%>
                                                            <%--<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                                                <div class="TitleCell">
                                                                    Descrizione:
                                                                </div>
                                                                <dx:ASPxHtmlEditor ID="DescrizioneProspect_Html" ClientInstanceName="DescrizioneProspect_Html" runat="server" Settings-AllowHtmlView="false" Settings-AllowDesignView="true" Settings-AllowPreview="false" OnLoad="DescrizioneProspect_Html_Load">
                                                                    <Settings AllowHtmlView="False" AllowPreview="False"></Settings>

                                                                    <SettingsHtmlEditing>
                                                                        <PasteFiltering Attributes="class"></PasteFiltering>
                                                                    </SettingsHtmlEditing>
                                                                </dx:ASPxHtmlEditor>
                                                            </div>--%>
                                                            <dx:ASPxCallbackPanel ClientVisible="false" runat="server" ID="ProspectDuplicato_CallbackPnl" ClientInstanceName="ProspectDuplicato_CallbackPnl" OnCallback="ProspectDuplicato_CallbackPnl_Callback">
                                                                <ClientSideEvents EndCallback="function(s,e){
                                                                    //ProspectGiaInserito_Grw.Refresh();
                                                                     //var rows = ProspectGiaInserito_Grw.cp_RowCount;
                                                                     //if(rows != 0){
                                                                     //Salva_Btn.SetEnabled(false);
                                                                     //}else{
                                                                     //Salva_Btn.SetEnabled(true);
                                                                     //}
                                                                    if(s.cp_Callbacks != null){
                                                                    if(s.cp_Callbacks != 'NoCallbacks'){
                                                                        PerformCallbacks(s);
                                                                    }else{Prospectinserito_Popup.Hide();}
                                                                    }
                                                                    Prospectinserito_Popup.Hide();
                                                                    }" />
                                                                <PanelCollection>
                                                                    <dx:PanelContent>
                                                                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                                                            <div class="TitleCell" style="padding: 20px 0px;">
                                                                                Prospect/Cliente duplicato:
                                                                     <br />
                                                                            </div>
                                                                            <dx:ASPxGridView runat="server" ID="ProspectGiaInserito_Grw" Settings-ShowColumnHeaders="true" ClientInstanceName="ProspectGiaInserito_Grw" Width="100%" DataSourceID="Prospectgiainserito_Dts" AutoGenerateColumns="False" OnCustomCallback="ProspectGiaInserito_Grw_CustomCallback" Styles-AlternatingRow-BackColor="LightGray" OnCustomJSProperties="ProspectGiaInserito_Grw_CustomJSProperties">
                                                                                <Settings ShowFilterRow="True"></Settings>

                                                                                <SettingsText EmptyDataRow="Nessun prospect/cliente duplicato" />
                                                                                <SettingsBehavior AllowFocusedRow="true" />
                                                                                <ClientSideEvents FocusedRowChanged="function(s,e){
                                                                                    var rows = s.cp_RowCount;
                                                                                    if(rows != 0){
                                                                                    if(ProspectDuplicato_CallbackPnl.cp_Callbacks != 'NoUse'){
                                                                                    SelectProspect_Btn.SetVisible(true);
                                                                                    }else{SelectProspect_Btn.SetVisible(false);}
                                                                                    }
                                                                                    }" />
                                                                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                                                <Columns>
                                                                                    <dx:GridViewDataTextColumn FieldName="Denom" Caption="Nome Prospect" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="Ind" Caption="Indirizzo" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="Prov" Caption="Provincia" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="Loc" Caption="Loalità" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataDateColumn FieldName="DataUltAgg" Caption="Data ultima aggiunta" VisibleIndex="5"></dx:GridViewDataDateColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="IDProspect" Visible="true" VisibleIndex="6"></dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="CodNaz" Visible="true" VisibleIndex="7"></dx:GridViewDataTextColumn>
                                                                                </Columns>
                                                                                <%--<Templates>
                                                                                    <DataRow>
                                                                                        <div class="col-lg-12 col-md-12 col-xs-12">
                                                                                            <div class="TitleCell">
                                                                                                Prospect già inserito: 
                                                                                            </div>
                                                                                            <dx:ASPxTextBox runat="server" Enabled="false" Text='<%# Eval("Denom") %>'></dx:ASPxTextBox>
                                                                                        </div>
                                                                                        <div class="col-lg-3 col-md-3 col-xs-3">
                                                                                            <div class="TitleCell">
                                                                                                Indirizzo:
                                                                                            </div>
                                                                                            <dx:ASPxTextBox runat="server" Enabled="false" Text='<%# Eval("Ind") %>'></dx:ASPxTextBox>
                                                                                        </div>
                                                                                        <div class="col-lg-3 col-md-3 col-xs-3">
                                                                                            <div class="TitleCell">
                                                                                                Provincia:
                                                                                            </div>
                                                                                            <dx:ASPxTextBox runat="server" Enabled="false" Text='<%# Eval("Prov") %>'></dx:ASPxTextBox>
                                                                                        </div>
                                                                                        <div class="col-lg-3 col-md-3 col-xs-3">
                                                                                            <div class="TitleCell">
                                                                                                Località:
                                                                                            </div>
                                                                                            <dx:ASPxTextBox runat="server" Enabled="false" Text='<%# Eval("Loc") %>'></dx:ASPxTextBox>
                                                                                        </div>
                                                                                        <div class="col-lg-3 col-md-3 col-xs-3">
                                                                                            <div class="TitleCell">
                                                                                                Data ult. agg.:
                                                                                            </div>
                                                                                            <dx:BootstrapTextBox runat="server" Enabled="false" Text='<%# Eval("DataUltAgg") %>'></dx:BootstrapTextBox>
                                                                                        </div>
                                                                                    </DataRow>
                                                                                </Templates>--%>
                                                                            </dx:ASPxGridView>
                                                                        </div>
                                                                    </dx:PanelContent>
                                                                </PanelCollection>
                                                            </dx:ASPxCallbackPanel>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                    <Border BorderStyle="None"></Border>
                                                </dx:LayoutItem>


                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                    <Paddings Padding="0px"></Paddings>
                                </dx:ASPxFormLayout>
                                <div class="col-md-12">
                                    <dx:BootstrapButton ID="Salva_Btn" ClientInstanceName="Salva_Btn" runat="server" AutoPostBack="false" ValidationGroup="NuovoProspectValidator" Badge-CssClass="BadgeBtn"
                                        rel="tooltip" data-placement="top" data-original-title="Salva" UseSubmitBehavior="false" CssClasses-Control="btn btn-md to-right">
                                        <Badge IconCssClass="fas fa-save" Text="Salva" />
                                        <SettingsBootstrap RenderOption="Success" Sizing="Normal" />
                                        <ClientSideEvents
                                            Click="function(s,e){
                                            if (ASPxClientEdit.ValidateGroup('NuovoProspectValidator')) {
                                                      ClientLoadingPanel.Show();
                                                      Piva_Callbackpnl.PerformCallback();
                                            }
                                                    } " />
                                    </dx:BootstrapButton>
                                    <dx:BootstrapButton ID="SelectProspect_Btn" ClientInstanceName="SelectProspect_Btn" runat="server" AutoPostBack="false" ClientVisible="false" Badge-CssClass="BadgeBtn"
                                        rel="tooltip" data-placement="top" data-original-title="Select Prospect">
                                        <Badge IconCssClass="fa fa-arrow-right" />
                                        <SettingsBootstrap RenderOption="Warning" Sizing="Small" />
                                        <CssClasses Control="PopUpBtn" />
                                        <ClientSideEvents Click="OnSelectedProspectClick" />
                                    </dx:BootstrapButton>

                                    <dx:ASPxCallback runat="server" ID="SelectedProspect_Callback" ClientInstanceName="SelectedProspect_Callback" OnCallback="SelectedProspect_Callback_Callback">
                                        <ClientSideEvents EndCallback="function(s,e){
                                            Prospectinserito_Popup.Hide();
                                            }" />
                                    </dx:ASPxCallback>
                                </div>
                            </div>
                        </fieldset>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
            <br />
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
<asp:SqlDataSource runat="server" ID="Prospectgiainserito_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Denom, Ind, Prov, Loc, PIva, DataUltAgg, IDProspect, CodNaz FROM CRM4U_Prospect_Clienti WHERE (PIva = @Piva) AND (Prospect = @IsProspect)">
    <SelectParameters>
        <asp:ControlParameter ControlID="InserimentoArticolo_Popup$InserimentoArt_CallbackPnl$InserimentoArticolo_FormLy$Piva_Callbackpnl$PIva_text" Name="Piva"></asp:ControlParameter>
        <asp:SessionParameter SessionField="IsProspect" Name="IsProspect"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource runat="server" ID="CondizioniPagamento_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodCPag, Descrizione FROM TabPag"></asp:SqlDataSource>



<dx:ASPxPopupControl ID="InserimentoBigliettoDaVisita_Popup" ClientInstanceName="InserimentoBigliettoDaVisita_Popup" Modal="true" runat="server" PopupHorizontalAlign="WindowCenter" HeaderText="Nuovo Prospect da biglietto da visita" SettingsAdaptivity-Mode="OnWindowInnerWidth" ShowPageScrollbarWhenModal="true" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="CloseButton" Width="500px">
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowTop" MaxWidth="500px" HorizontalAlign="WindowCenter" />

    <ContentCollection>
        <dx:PopupControlContentControl>


            <dx:ASPxUploadControl ID="UploadDoc_UploadControl" runat="server" ClientInstanceName="UploadControl" Width="100%"
                NullText="Scatta foto biglietto da visita" UploadMode="Advanced" ShowUploadButton="false" ShowProgressPanel="True"
                OnFileUploadComplete="UploadDoc_UploadControl_FileUploadComplete">
                <AdvancedModeSettings EnableMultiSelect="false" EnableFileList="false" EnableDragAndDrop="false" />
                <ValidationSettings MaxFileSize="4194304">
                </ValidationSettings>
                <ClientSideEvents TextChanged="function(s,e){AssociaCliente_Btn.SetEnabled(true)}" FilesUploadStart="function(s, e) {CaricamentoDoc_LoadingPnl.Show();}"
                    FileUploadComplete="onFileUploadCompleteGridviewDocumenti" />
            </dx:ASPxUploadControl>


            <dx:BootstrapButton ID="AssociaCliente_Btn" runat="server" ClientInstanceName="AssociaCliente_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ToolTip="Inserisci biglietto da visita prospect">
                <Badge IconCssClass="fa fa-user" Text="Inserisci" />
                <ClientSideEvents Click="function(s,e){
                    
                    if(UploadControl.GetText() != ''){
                    UploadControl.Upload();
                    }
                    }" />
                <SettingsBootstrap RenderOption="Success" />
            </dx:BootstrapButton>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

<asp:SqlDataSource ID="ClienteDaBDV_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' InsertCommand="" SelectCommand="select 1 where 1= 2">
    <InsertParameters>
        <asp:Parameter Name="ImgBigliettoVisita" DbType="Byte"></asp:Parameter>
        <asp:Parameter Name="CodAge"></asp:Parameter>
    </InsertParameters>
</asp:SqlDataSource>

<dx:ASPxPopupControl ID="Prospectinserito_Popup" ClientInstanceName="Prospectinserito_Popup" Modal="true" runat="server" PopupHorizontalAlign="WindowCenter" HeaderText="Prospect inserito" SettingsAdaptivity-Mode="OnWindowInnerWidth" ShowPageScrollbarWhenModal="true" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="CloseButton">
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="400px" HorizontalAlign="WindowCenter" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <div class="row">
                <div class="col-lg-12">
                    <div class="col-lg-12" style="padding-bottom: 20px">
                        <dx:ASPxCallbackPanel ID="ProspectInserito_Callbackpnl" ClientInstanceName="ProspectInserito_Callbackpnl" runat="server" Width="100%" OnCallback="ProspectInserito_Callbackpnl_Callback">
                            <ClientSideEvents EndCallback="function(s,e){InserimentoArticolo_Popup.Hide();
                                if(s.cp_show == 'y'){Prospectinserito_Popup.Show();}
                                }" />
                            <PanelCollection>
                                <dx:PanelContent>
                                    <dx:ASPxLabel ID="Prospect_Lbl" runat="server" Font-Size="X-Large" Font-Bold="true"></dx:ASPxLabel>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                    <div class="col-lg-12">
                        <dx:BootstrapButton runat="server" ID="Vaialprospect_Btn" ClientInstanceName="Vaialprospect_Btn" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding"
                            rel="tooltip" data-placement="top" data-original-title="Vai alla lista prospect">
                            <Badge IconCssClass="fa fa-play" />
                            <SettingsBootstrap RenderOption="Success" Sizing="Normal" />
                            <CssClasses Control="PopUpBtn" />
                            <ClientSideEvents Click="function(s,e){OnButtonClick('Go');}" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton runat="server" ID="InserisciProspect" ClientInstanceName="Vaialprospect_Btn" Badge-CssClass="BadgeBtn" AutoPostBack="false" CssClasses-Control="btn btn-sm btn-custom-padding"
                            rel="tooltip" data-placement="top" data-original-title="Vai alla lista prospect">
                            <Badge IconCssClass="fa fa-upload" />
                            <SettingsBootstrap RenderOption="Info" Sizing="Normal" />
                            <CssClasses Control="PopUpBtn" />
                            <ClientSideEvents Click="function(s,e){OnButtonClick('Insert');}" />
                        </dx:BootstrapButton>
                    </div>
                </div>
            </div>

        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

<dx:ASPxCallback ID="Salvataggio_Callback" ClientInstanceName="Salvataggio_Callback" runat="server" OnCallback="Salvataggio_Callback_Callback">
    <ClientSideEvents CallbackComplete="function(s,e){
        ClientLoadingPanel.Hide();
        showNotification();
        if(e.result == 'Show'){
        ProspectDuplicato_CallbackPnl.PerformCallback('Insert');
        }
        }" />
</dx:ASPxCallback>
<dx:ASPxHiddenField runat="server" ID="HfFile" ClientInstanceName="HfFile"></dx:ASPxHiddenField>



<asp:SqlDataSource runat="server" ID="Nazioni_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodNaz, Descrizione FROM TabNaz"></asp:SqlDataSource>

<asp:SqlDataSource ID="EditCardView_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT VIO_Picture.PictureID, VIO_Picture.PictureBinary, VIO_Picture.Extension, '/Public/ImgCatalog/thumbnails_200x200/tn_' + VIO_Picture.PictureUrl AS PictureUrl, '/Public/ImgCatalog/thumbnails_600x600/tn_' + VIO_Picture.PictureUrl AS PictureUrlOriginali,VIO_Picture.IsNew, VIO_Picture.Sezione, VIO_Picture.Principale, VIO_Picture.PathImmagine, VIO_Picture.SessionId, VIO_Picture.DateInsert, VIO_Picture.IdContent, VIO_Picture.Tags, VIO_Picture.Titolo, VIO_Picture.Descrizione, VIO_Articoli.CodArt, VIO_Articoli.Descrizione AS DescrArt, VIO_Articoli.Composizione, VIO_Articoli.Altezza, VIO_Articoli.Peso, VIO_Articoli.CodArt_Primo, VIO_Articoli.CodArt_Secondo, VIO_Articoli.CodArt_Terzo FROM VIO_Picture LEFT OUTER JOIN VIO_Articoli ON VIO_Picture.IdContent = VIO_Articoli.ID where 1 = 2 " InsertCommand="VIO_NuovoArticolo_Insert" InsertCommandType="StoredProcedure">
    <InsertParameters>
        <asp:Parameter Name="PictureURL"></asp:Parameter>
        <asp:Parameter Name="Tags"></asp:Parameter>
        <asp:Parameter Name="Composizione"></asp:Parameter>
        <asp:Parameter Name="Descrizione"></asp:Parameter>
        <asp:Parameter Name="CodArt"></asp:Parameter>
        <asp:Parameter Name="Altezza"></asp:Parameter>
        <asp:Parameter Name="Peso"></asp:Parameter>
        <asp:Parameter Name="CodArt_Primo"></asp:Parameter>
        <asp:Parameter Name="CodArt_Secondo"></asp:Parameter>
        <asp:Parameter Name="CodArt_Terzo"></asp:Parameter>
        <asp:Parameter Name="IdCatArray"></asp:Parameter>
    </InsertParameters>
</asp:SqlDataSource>
