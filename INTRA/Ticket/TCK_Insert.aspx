<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="TCK_Insert.aspx.cs" Inherits="INTRA.Ticket.TCK_Insert" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <style>
        .dxflFormLayout_Office365 .dxflCaption_Office365 {
            font-weight: 500;
        }

        @media (max-width: 767px) {
            .header-wrapper.style-1 {
                z-index: 999999999;
                position: absolute;
            }
        }

        @media (min-width: 768px) and (max-width: 1024px) {
            .header-wrapper.style-1 {
                z-index: 999999999;
                position: absolute;
            }
        }
    </style>

    <script src="/assets/js/IntroJS/intro.js"></script>
    <link href="/assets/js/IntroJS/introjs.css" rel="stylesheet" />
    <%--    <link href="assets/js/IntroJS/themes/introjs-dark.css" rel="stylesheet" />--%>
    <link href="/assets/js/IntroJS/themes/introjs-flattener.css" rel="stylesheet" />
    <%--    <link href="assets/js/IntroJS/themes/introjs-modern.css" rel="stylesheet" />--%>
    <%--    <link href="assets/js/IntroJS/themes/introjs-nassim.css" rel="stylesheet" />--%>
    <%--    <link href="assets/js/IntroJS/themes/introjs-nazanin.css" rel="stylesheet" />--%>
    <%--    <link href="assets/js/IntroJS/themes/introjs-royal.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

        function setCookieDemo(name, value, years) {
            var expires = "";
            if (years) {
                var date = new Date();
                date.setFullYear(2066);
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
        }

        //check for the cookie when user first arrives, if cookie doesn't exist call the intro.
        function getCookieDemo(c_name) {
            var c_value = document.cookie;
            var c_start = c_value.indexOf(" " + c_name + "=");
            if (c_start == -1) {
                c_start = c_value.indexOf(c_name + "=");
            }
            if (c_start == -1) {
                c_value = null;
            }
            else {
                c_start = c_value.indexOf("=", c_start) + 1;
                var c_end = c_value.indexOf(";", c_start);
                if (c_end == -1) {
                    c_end = c_value.length;
                }
                c_value = unescape(c_value.substring(c_start, c_end));
            }
            return c_value;
        }

        function checkCookieIntro() {
            var cookie = getCookieDemo("DemoClienti");
            if (cookie == null || cookie == "") {
                setCookieDemo("DemoClienti", "1", 20);
                introJs().setOptions({ 'skipLabel': 'Exit', 'showStepNumbers': 'true', 'showBullets': 'true', 'showProgress': 'false' }).start(); //change this to whatever function you need to call to run the intro
            }
        }
        $(document).ready(function () {
            checkCookieIntro();
            //introJs().setOptions({ 'skipLabel': 'Exit', 'showStepNumbers': 'true', 'showBullets': 'true', 'showProgress': 'false' }).start();

        });

        function ControlloNumeroTocken(s, e) {
            var tokens = s.GetTokenCollection();
            if (tokens.length > Number(1)) {
                s.RemoveToken(1);
            }
        }
        var uploadInProgress = false,
            submitInitiated = false,
            uploadErrorOccurred = false;
        uploadedFiles = [];
        function onFileUploadComplete(s, e) {
            var callbackData = e.callbackData.split("|"),
                uploadedFileName = callbackData[0],
                isSubmissionExpired = callbackData[1] === "True";
            uploadedFiles.push(uploadedFileName);
            if (e.errorText.length > 0 || !e.isValid)
                uploadErrorOccurred = true;
            if (isSubmissionExpired && UploadedFilesTokenBox.GetText().length > 0) {
                var removedAfterTimeoutFiles = UploadedFilesTokenBox.GetTokenCollection().join("\n");
                alert("The following files have been removed from the server due to the defined 5 minute timeout: \n\n" + removedAfterTimeoutFiles);
                UploadedFilesTokenBox.ClearTokenCollection();
            }
        }
        function onFileUploadStart(s, e) {
            uploadInProgress = true;
            uploadErrorOccurred = false;
            UploadedFilesTokenBox.SetIsValid(true);
        }
        function onFilesUploadComplete(s, e) {
            uploadInProgress = false;
            for (var i = 0; i < uploadedFiles.length; i++)
                UploadedFilesTokenBox.AddToken(uploadedFiles[i]);
            updateTokenBoxVisibility();
            uploadedFiles = [];
            if (submitInitiated) {
                SubmitButton.SetEnabled(true);
                SubmitButton.DoClick();
            }
        }
        function onTokenBoxValidation(s, e) {
            var isValid = DocumentsUploadControl.GetText().length > 0 || UploadedFilesTokenBox.GetText().length > 0;
            e.isValid = isValid;

            if (!isValid) {
                e.errorText = "Non sono stati caricati file, riprovare.";
            }
            return true;

            return false
        }
        function onTokenBoxValueChanged(s, e) {
            updateTokenBoxVisibility();
        }
        function updateTokenBoxVisibility() {
            var isTokenBoxVisible = UploadedFilesTokenBox.GetTokenCollection().length > 0;
            UploadedFilesTokenBox.SetVisible(isTokenBoxVisible);
        }
        function formIsValid() {
            return !ValidationSummary.IsVisible() && UploadedFilesTokenBox.GetIsValid() && !uploadErrorOccurred;
        }
        function ChangeType(s, type) {
            try {
                s.GetInputElement().type = type;
            }
            catch (err) {
                alert("\"" + type + "\"\n\r " + err.message);
            }
        }


        function onAreaValidation(s, e) {
            var SelectedIndex = e.SelectedIndex;
            if (SelectedIndex == -1) {
                return;
            }
            if (SelectedIndex > -1) {
                e.isValid = true;
            }
        }
        function onNameValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            if (name.length < 2)
                e.isValid = false;
        }

        function TimeValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            if (TxtOraFine_insert.GetText() > TxtOraInizio_insert.GetText()) { e.isValid = true; }
            else { e.isValid = false; }
        }

        function onAgeValidation(s, e) {
            var age = e.value;
            if (age == null || age == "")
                return;
            var digits = "0123456789";
            for (var i = 0; i < age.length; i++) {
                if (digits.indexOf(age.charAt(i)) == -1) {
                    e.isValid = false;
                    break;
                }
            }
            if (e.isValid && age.charAt(0) == '0') {
                age = age.replace(/^0+/, "");
                if (age.length == 0)
                    age = "0";
                e.value = age;
            }
            if (age < 18)
                e.isValid = false;
        }
        function onArrivalDateValidation(s, e) {
            var selectedDate = s.date;
            if (selectedDate == null || selectedDate == false)
                return;
            var currentDate = new Date();
            if (currentDate.getFullYear() != selectedDate.getFullYear() || currentDate.getMonth() != selectedDate.getMonth())
                e.isValid = false;
        }
        function clearEditors(s, e) {
            var container = document.getElementsByClassName("clientContainer")[0];
            ASPxClientEdit.ClearEditorsInContainer(container);
        }
        function emailvalidate(s, e) {
            var b = /^[^@@\s]+@@[^@@\.\s]+(\.[^@@\.\s]+)+$/;
            return b.test(e);
        }

    </script>
    <style>
        .submenu {
            position: fixed;
            top: 207px;
            left: 298px;
            border: 60px;
            z-index: 9999;
            padding: 10px;
            box-shadow: rgba(0, 0, 0, 0.3) 0px 2px 5px;
            display: none;
            opacity: 1.185;
        }

        .dxgvDataRow_Office365:last-child td.dxgv, .dxgvTable_Office365 {
            border-bottom: 0px solid rgba(0,0,0,0.1) !important;
        }

        .dxflRequired_Office365 {
            display: none !important;
        }

        .mail-editor {
            height: 32px !important;
            padding: 4px 10px !important;
            line-height: 24px !important;
            box-sizing: border-box;
        }

            .mail-editor .token-input {
                height: 24px !important;
                line-height: 24px !important;
            }

            .mail-editor .token {
                line-height: 24px !important;
                height: 24px !important;
                margin-top: 2px !important;
            }

        @media (max-width: 768px) {
            .dxpc-contentWrapper.dxmodalTableSys {
                position: fixed !important;
                top: 50% !important;
                left: 50% !important;
                transform: translate(-50%, -50%) !important;
                max-height: 60vh !important;
                overflow-y: auto !important;
                width: 90% !important;
                z-index: 9999 !important;
            }
        }

        .header-wrapper::after {
            content: "";
            display: block;
            height: 80px !important;
            width: 100%;
        }
    </style>
    <dx:ASPxLoadingPanel ID="InserimentoTck_LoadingPnl" ClientInstanceName="InserimentoTck_LoadingPnl" Modal="true" runat="server" Text="Inserimento ticket in corso..." LoadingDivStyle-BackColor="#eeeef2" LoadingDivStyle-Opacity="70">
    </dx:ASPxLoadingPanel>

    <dx:ASPxHiddenField ID="DatiContatto_HF" ClientInstanceName="DatiContatto_HF" runat="server"></dx:ASPxHiddenField>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" ClientInstanceName="ASPxCallbackPanel1" runat="server" OnCallback="ASPxCallbackPanel1_Callback">
        <%--<ClientSideEvents EndCallback="function(s,e){xx.Refresh();}" />--%>
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxLabel ID="eRrore_Lbl" runat="server"></dx:ASPxLabel>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <div style="position: absolute; float: right; z-index: 20; right: 50px; cursor: pointer;" data-step="1" data-title="Ciao! <br>Sei sulla pagina di inserimento ticket, segui il tour per imparare ad usare questa pagina" data-intro='In qualsiasi momento puoi avviare il tour cliccando su questa icona.' onclick=" introJs().start();"><i class="fas fa-info-circle" style="color: var(--main-primary-color); font-weight: 700; font-size: 50px; z-index: 9999999999;"></i></div>
    <div id="datiprincipaliDiv" style=" z-index: 10">
        <dx:ASPxFormLayout runat="server" ID="formlayout" ClientInstanceName="TicketAddForm" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
            <Items>

                <dx:LayoutGroup ColumnCount="4" GroupBoxStyle-Caption-Font-Size="X-Large" Caption="INSERIMENTO TICKET" Paddings-Padding="0">
                    <GridSettings>
                        <Breakpoints>
                            <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                        </Breakpoints>
                    </GridSettings>

                    <Paddings Padding="0px"></Paddings>
                    <Items>
                        <dx:LayoutItem Caption="Cliente" ColumnSpan="3" RequiredMarkDisplayMode="Required" CaptionStyle-Font-Bold="true">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <script>
                                        function onKeyDown(s, e) {
                                            if (e.htmlEvent.keyCode == 13) {
                                                ASPxClientUtils.PreventEventAndBubble(e.htmlEvent);
                                                s.filterStrategy.Filtering();
                                                s.ShowDropDown();
                                            }
                                        }
                                    </script>
                                    <dx:ASPxComboBox ID="ClientiComboBox" ClientInstanceName="ClientiComboBox" runat="server" EnableCallbackMode="false" ForceDataBinding="true" OnDataBound="ClientiComboBox_DataBound"
                                        ValueField="CodCli" DropDownStyle="DropDownList" TextFormatString="{0}" TextField="Denom" IncrementalFilteringMode="Contains" DataSourceID="Clienti_Dts">
                                        <%--<ClientSideEvents SelectedIndexChanged="function(s,e){InterventoPResso_CallbackPnl.PerformCallback()}" />--%>
                                        <ValidationSettings ValidationGroup="InserimentoTicket" SetFocusOnError="True" ErrorDisplayMode="None">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        <ClientSideEvents Validation="onAreaValidation" />
                                        <InvalidStyle BackColor="LightPink" />
                                        <ClearButton DisplayMode="Always"></ClearButton>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="Clienti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT CodCli, Denom, Ind, Loc, tel FROM Clienti where flagannullo = 0"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>

                        <%--      <dx:LayoutItem Caption="Priorità*:">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxComboBox runat="server" ID="Rbl_TCK_PrioritaRichiesta" ClientInstanceName="Rbl_TCK_PrioritaRichiesta" TextField="Descrizione" ValueField="Id" DropDownStyle="DropDownList" DataSourceID="DtsTCK_PrioritaRichiesta" IncrementalFilteringMode="None" ShowImageInEditBox="True" ImageUrlField="ImageUrl" SelectedIndex="0">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                        <ItemImage Height="30px" Width="30px" />
                                    </dx:ASPxComboBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>--%>
                        <dx:LayoutItem Caption="Area" RequiredMarkDisplayMode="Required" CaptionStyle-Font-Bold="true">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxCallbackPanel ID="AreaAss_CallbackPnl" Paddings-PaddingTop="9px" ClientInstanceName="AreaAss_CallbackPnl" runat="server" Width="100%" OnCallback="AreaAss_CallbackPnl_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>

                                                <dx:ASPxComboBox runat="server" ID="rbtAreaAss" data-step="2" data-disable-interaction="true" data-title="Passo 1<br>Seleziona Area di competenza" data-intro='Ci serve per intradare la richiesta al reparto di competenza.' ClientInstanceName="rbtAreaAss" ShowImageInEditBox="True" ImageUrlField="ImageUrl" TextField="Descrizione" ValueField="IdAreaAss" DropDownStyle="DropDownList" DataSourceID="DtsTCK_AreaCompetenza" IncrementalFilteringMode="None" Width="100%">
                                                    <ValidationSettings SetFocusOnError="false" ErrorDisplayMode="None" ValidationGroup="InserimentoTicket">
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents Validation="onAreaValidation" />
                                                    <InvalidStyle BackColor="LightPink" />
                                                    <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                    <ItemImage Height="30px" Width="30px" />
                                                </dx:ASPxComboBox>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>
                        <%-- <dx:LayoutItem Caption="Tipo Richiesta*:">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxComboBox runat="server" SelectedIndex="0" ID="rbtTipoChiamata" ClientInstanceName="rbtTipoChiamata" TextField="Descrizione" ValueField="Id" ShowImageInEditBox="True" ImageUrlField="ImageUrl" DropDownStyle="DropDownList" DataSourceID="DtsTCK_TipoRichiesta" IncrementalFilteringMode="None">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                        <ItemImage Height="30px" Width="30px" />
                                    </dx:ASPxComboBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Da Eseguire*:">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxComboBox runat="server" SelectedIndex="0" ID="Rbl_TCK_TipoEsecuzione" ClientInstanceName="Rbl_TCK_TipoEsecuzione" TextField="Descrizione" ValueField="Id" DropDownStyle="DropDownList" ShowImageInEditBox="True" ImageUrlField="ImageUrl" DataSourceID="DtsTCK_TipoEsecuzione" IncrementalFilteringMode="None">
                                        <ClientSideEvents SelectedIndexChanged="function(s,e){InterventoPResso_CallbackPnl.PerformCallback()}" />
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                        <ItemImage Height="30px" Width="30px" />
                                    </dx:ASPxComboBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>--%>

                        <%--                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>

                        </dx:LayoutItem>--%>


                        <%--  <dx:LayoutItem Caption="Intervento Presso:" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>

                                    <dx:ASPxCallbackPanel ID="InterventoPResso_CallbackPnl" ClientInstanceName="InterventoPResso_CallbackPnl" runat="server" Width="100%" OnCallback="MotivoChiamata_CallbackPnl_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxTextBox ID="InterventoPreso_Txt" runat="server" NullText="Intervento Presso?" Width="100%"></dx:ASPxTextBox>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>--%>

                        <dx:LayoutItem Caption="Contatto" ColumnSpan="1" CaptionStyle-Font-Bold="true" VerticalAlign="Middle">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxRadioButtonList runat="server" data-title="Passo 2<br>Scegli la tipologia di contatto:" data-intro='Puoi usare quello standard o inserirne uno specifico per questo ticket' ID="TipologiaContatto_RadioBtnList" ClientInstanceName="TipologiaContatto_RadioBtnList" RepeatDirection="Horizontal">
                                        <ClientSideEvents SelectedIndexChanged="function(s,e){
                                           var Selezione = s.GetValue();
                                           if(Selezione == 1)
                                           {Contatto_Txt_DX.SetText('');
                                           Telefono_Txt_DX.SetText('');
                                           Email_Txt_DX.SetText('');
                                           }
                                           else{
                                           Contatto_Txt_DX.SetText(DatiContatto_HF.Get('Nome'));
                                           Telefono_Txt_DX.SetText(DatiContatto_HF.Get('Telefono'));
                                           Email_Txt_DX.SetText(DatiContatto_HF.Get('Email'));
                                           }
                                           }" />
                                        <Items>
                                            <dx:ListEditItem Text="Standard" Value="0" Selected="true" />
                                            <dx:ListEditItem Text="Diretto" Value="1" />
                                        </Items>
                                        <ValidationSettings ValidationGroup="InserimentoTicket">
                                            <RequiredField IsRequired="true" />
                                        </ValidationSettings>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>

                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="Contatto:" ColumnSpan="1" CaptionStyle-Font-Bold="true" VerticalAlign="Middle">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>

                                    <dx:ASPxTextBox ID="Contatto_Txt_DX" ClientInstanceName="Contatto_Txt_DX" runat="server" NullText="Contatto?">
                                        <ValidationSettings ValidationGroup="InserimentoTicket" SetFocusOnError="True" ErrorDisplayMode="None">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Telefono:" ColumnSpan="1" CaptionStyle-Font-Bold="true" VerticalAlign="Middle">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox ID="Telefono_Txt_DX" ClientInstanceName="Telefono_Txt_DX" runat="server" NullText="Telefono?">
                                        <ValidationSettings ValidationGroup="InserimentoTicket" SetFocusOnError="True" ErrorDisplayMode="None">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Email:" ColumnSpan="1" CaptionStyle-Font-Bold="true" VerticalAlign="Middle">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTokenBox runat="server" ID="Email_Txt_DX" ClientInstanceName="Email_Txt_DX" ValueField="CodDiv" TextField="EMail" TextSeparator=";" Width="100%"
                                        CssClass="mail-editor"
                                        RootStyle-CssClass="mail-editor"
                                        CaptionCellStyle-CssClass="caption token-box-caption"
                                        TokenStyle-CssClass="token"
                                        TokenTextStyle-CssClass="text"
                                        TokenRemoveButtonStyle-CssClass="remove-button">
                                        <ClientSideEvents TokensChanged="ControlloNumeroTocken" />
                                        <TokenBoxInputStyle CssClass="token-input" />
                                        <ClientSideEvents Validation="emailvalidate" />
                                        <ValidationSettings ValidationGroup="InserimentoTicket" SetFocusOnError="True" ErrorDisplayMode="None">
                                            <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        <ItemStyle CssClass="contact-item" />
                                    </dx:ASPxTokenBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>



                        <dx:LayoutItem Caption="Oggetto della chiamata:" ColumnSpan="4" CaptionStyle-Font-Bold="true">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox ID="OggettoTck_Memo" ClientInstanceName="OggettoTck_Memo" runat="server" NullText="Oggetto della chiamata?">
                                        <ValidationSettings ValidationGroup="InserimentoTicket" SetFocusOnError="True" ErrorDisplayMode="None">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="Motivo della chiamata:" ColumnSpan="4" CaptionStyle-Font-Bold="true">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>

                                    <%-- <dx:ASPxHtmlEditor ID="MotivoChiamata_Html" ClientInstanceName="MotivoChiamata_Html" runat="server" Settings-AllowHtmlView="false" Settings-AllowPreview="false" Height="200px">

                                        <SettingsValidation ValidationGroup="InserimentoTicket">
                                            <RequiredField IsRequired="True" ErrorText="Il contenuto di questo campo non può essere vuoto" />
                                        </SettingsValidation>
                                        <ClientSideEvents Validation="onNameValidation" />
                                    </dx:ASPxHtmlEditor>--%>
                                    <dx:ASPxMemo ID="Motivo_Chiamata_Txt_DX" Rows="5" runat="server" NullText="Motivo della chiamata?">
                                        <ValidationSettings SetFocusOnError="True" ErrorDisplayMode="None" ValidationGroup="InserimentoTicket">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        <ClientSideEvents Validation="onNameValidation" />
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Documenti:" ColumnSpan="4" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>


                                    <dx:ASPxHiddenField runat="server" ID="HfFile" ClientInstanceName="HfFile"></dx:ASPxHiddenField>
                                    <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="1" UseDefaultPaddings="false">
                                        <Items>
                                            <dx:LayoutGroup ShowCaption="False" GroupBoxStyle-Caption-Font-Bold="true">
                                                <Items>

                                                    <dx:LayoutItem ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <div id="dropZone">

                                                                    <dx:ASPxUploadControl EnableTheming="true" runat="server" ID="DocumentsUploadControl" ClientInstanceName="DocumentsUploadControl"
                                                                        AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" FileUploadMode="OnPageLoad"
                                                                        OnFileUploadComplete="DocumentsUploadControl_FileUploadComplete" Theme="SoftOrange" AdvancedModeSettings-EnableFileList="true">
                                                                        <BrowseButton Text="Aggiungi documenti oppure trascinali">
                                                                        </BrowseButton>
                                                                        <AdvancedModeSettings EnableMultiSelect="true" EnableDragAndDrop="true" ExternalDropZoneID="dropZone">
                                                                        </AdvancedModeSettings>
                                                                        <ValidationSettings
                                                                            MaxFileSize="2000000" MaxFileCount="3">
                                                                        </ValidationSettings>
                                                                        <ClientSideEvents
                                                                            FileUploadComplete="onFileUploadComplete"
                                                                            FilesUploadComplete="onFilesUploadComplete"
                                                                            FilesUploadStart="onFileUploadStart" />
                                                                        <DropZoneStyle Border-BorderColor="LightGray" Border-BorderStyle="None">
                                                                        </DropZoneStyle>
                                                                    </dx:ASPxUploadControl>
                                                                    <br />
                                                                    <p class="Note">
                                                                        <b>Nota</b>:
                                                                        <dx:ASPxLabel runat="server" ID="NoteUploader_lbl" EncodeHtml="false"></dx:ASPxLabel>
                                                                    </p>
                                                                    <br />
                                                                    <dx:ASPxTokenBox runat="server" Width="100%" ID="UploadedFilesTokenBox" ClientInstanceName="UploadedFilesTokenBox" TextSeparator=";"
                                                                        NullText="Select the documents to submit" AllowCustomTokens="false" ClientVisible="false">

                                                                        <ClientSideEvents Init="updateTokenBoxVisibility" ValueChanged="onTokenBoxValueChanged" Validation="onTokenBoxValidation" />
                                                                        <ValidationSettings EnableCustomValidation="true"></ValidationSettings>
                                                                    </dx:ASPxTokenBox>
                                                                    <br />

                                                                    <dx:ASPxValidationSummary runat="server" ID="ValidationSummary" ClientInstanceName="ValidationSummary"
                                                                        RenderMode="Table" Width="50%" ShowErrorAsLink="false">
                                                                    </dx:ASPxValidationSummary>
                                                                </div>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>
                                        </Items>
                                    </dx:ASPxFormLayout>



                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>



                        <dx:LayoutItem ShowCaption="False" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>


                                    <dx:ASPxButton ID="InserisciTicket_Btn" runat="server" AutoPostBack="false" BackColor="Green" RenderMode="Button" Text="Inserisci Ticket" Width="100" UseSubmitBehavior="false">
                                        <ClientSideEvents Click="function(s, e) 
                                        {
                                        if(ASPxClientEdit.ValidateGroup('InserimentoTicket'))
                                        {
                                        InserimentoTicket_Callback.PerformCallback();
                                        ASPxCallbackPanel1.PerformCallback();
                                        };
                                    }" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                        </dx:LayoutItem>

                    </Items>
                </dx:LayoutGroup>
            </Items>

            <Paddings Padding="0px"></Paddings>
        </dx:ASPxFormLayout>
    </div>


    <dx:ASPxCallback ID="InserimentoTicket_Callback" runat="server" ClientInstanceName="InserimentoTicket_Callback" OnCallback="InserimentoTicket_Callback_Callback">
        <ClientSideEvents BeginCallback="function(s,e){InserimentoTck_LoadingPnl.Show();}"
            CallbackComplete="function(s,e){
        CancellazioneFile_Callback.PerformCallback();
         InserimentoTck_LoadingPnl.Hide(); 
         showNotification();
        }" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="CancellazioneFile_Callback" ClientInstanceName="CancellazioneFile_Callback" runat="server" OnCallback="CancellazioneFile_Callback_Callback"></dx:ASPxCallback>

    <asp:SqlDataSource ID="DtsTCK_TipoRichiesta" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Id, Descrizione, DisplayOrder, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl FROM TCK_TipoRichiesta order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_TipoEsecuzione" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Id, Descrizione, DisplayOrder, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl FROM TCK_TipoEsecuzione order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_AreaCompetenza" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT [Descrizione], [DisplayOrder], [LabelClass], [IdAreaAss], '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl  FROM [TCK_AreaCompetenza] order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_PrioritaRichiesta" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Descrizione, DisplayOrder, LabelClass, Id, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl  FROM TCK_PrioritaRichiesta ORDER BY DisplayOrder"></asp:SqlDataSource>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        window.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".dxflCaption_Office365").forEach(caption => {
                if (!caption.innerHTML.includes("*")) {
                    caption.innerHTML += `<span style="color: green; font-style: normal; margin-left: 4px;font-size: 0.8em;">*</span>`;
                }
            });
        });
    </script>
    <script>
        function customizeTokenBox() {
            var tokens = document.querySelectorAll('.mail-editor .remove-button');

            tokens.forEach(function (btn) {
                btn.innerHTML = '×';

                btn.style.display = 'flex';
                btn.style.alignItems = 'center';
                btn.style.justifyContent = 'center';
                btn.style.width = '20px';
                btn.style.height = '20px';
                btn.style.borderRadius = '50%';
                btn.style.backgroundColor = '#0056b3';
                btn.style.color = 'white';
                btn.style.fontSize = '14px';
                btn.style.fontWeight = 'bold';
                btn.style.cursor = 'pointer';
                btn.style.marginLeft = '6px';
                btn.style.transition = 'all 0.2s ease';

                btn.addEventListener('mouseenter', function () {
                    btn.style.backgroundColor = 'red';
                });

                btn.addEventListener('mouseleave', function () {
                    btn.style.backgroundColor = '#0056b3';
                });
            });
        }

        function ControlloNumeroTocken(s, e) {
            customizeTokenBox();
        }

        document.addEventListener('DOMContentLoaded', function () {
            customizeTokenBox();
        });
    </script>

    <style>
        .fixed-header-margin {
            padding-top: 80px !important;
        }

        @media (max-width: 1279px) {
            .fixed-header-margin {
                padding-top: 80px !important;
            }
        }

        .mail-editor .token {
            background-color: #0055A6;
            border-radius: 20px;
            padding: 5px 10px;
            display: flex;
            align-items: center;
            color: white;
            font-weight: bold;
            margin: 2px;
        }

        .mail-editor .text {
            margin-right: 8px;
            color: white;
        }

        .mail-editor .remove-button {
            background-color: #0056b3;
            border-radius: 50%;
            color: white;
            font-size: 12px;
            width: 20px;
            height: 20px;
            text-align: center;
            line-height: 20px;
            cursor: pointer;
        }

        .mail-editor .token-input {
            border: none;
            outline: none;
            padding: 4px;
            min-width: 50px;
        }

        .mail-editor.dx-tbInvalid {
            border: 2px solid #007BFF !important;
            box-shadow: 0 0 3px #007BFF;
        }
    </style>
</asp:Content>

