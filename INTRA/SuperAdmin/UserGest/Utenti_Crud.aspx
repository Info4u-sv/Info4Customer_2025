<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Utenti_Crud.aspx.cs" Inherits="INTRA.SuperAdmin.UserGest.Utenti_Crud" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var passwordMinLength = 6;
        function GetPasswordRating(password) {
            var result = 0;
            if (password) {
                result++;
                if (password.length >= passwordMinLength) {
                    if (/[a-z]/.test(password))
                        result++;
                    if (/[A-Z]/.test(password))
                        result++;
                    if (/\d/.test(password))
                        result++;
                    if (!(/^[a-z0-9]+$/i.test(password)))
                        result++;
                }
            }
            return result;
        }
        function GetErrorText(editor) {
            if (editor === passwordTextBox) {
                if (ratingControl.GetValue() === 1)
                    return "La password è troppo semplice";
            } else if (editor === confirmPasswordTextBox) {
                if (passwordTextBox.GetText() !== confirmPasswordTextBox.GetText())
                    return "Le password inserite non corrispondono";
            }
            return "";
        }
        function OnPasswordTextBoxInit(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassChanged(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassValidation(s, e) {
            var errorText = GetErrorText(s);
            if (errorText) {
                e.isValid = false;
                e.errorText = errorText;
            }
        }

        function ApplyCurrentPasswordRating() {
            var password = passwordTextBox.GetText();
            var passwordRating = GetPasswordRating(password);
            ApplyPasswordRating(passwordRating);
        }
        function ApplyPasswordRating(value) {
            ratingControl.SetValue(value);
            switch (value) {
                case 0:
                    ratingLabel.SetValue("Inserisci password");
                    break;
                case 1:
                    ratingLabel.SetValue("Troppo semplice");
                    break;
                case 2:
                    ratingLabel.SetValue("Non sicura");
                    break;
                case 3:
                    ratingLabel.SetValue("Normale");
                    break;
                case 4:
                    ratingLabel.SetValue("Sicura");
                    break;
                case 5:
                    ratingLabel.SetValue("Molto sicura");
                    break;
                default:
                    ratingLabel.SetValue("Inserisci password");
            }
        }
        function ControlloNumeroTocken(s, e) {
            var tokens = s.GetTokenCollection();
            if (tokens.length > Number(1)) {
                s.RemoveToken(1);
            }
        }
    </script>
    <style>
        .badge.BadgeTopBtn {
            margin-left: 0em;
            border-radius: 5px !important;
            font-size: x-large !important;
        }

        .TopBtn {
            padding: 4px !important;
        }

        .btn:not(.btn-just-icon):not(.btn-fab) .fa, .navbar .navbar-nav > li > a.btn:not(.btn-just-icon):not(.btn-fab) .fa {
            font-size: 30px !important;
        }
    </style>

    <style>
        .card .card-header.card-header-text {
            display: inline-block;
            padding-top: 15px !important;
        }

        .card-header.card-header-text[data-background-color=""] {
            background: linear-gradient(60deg, rgba(74,112,175,1) 0%, rgba(85,133,212,1) 100%) !important;
        }

        .EditCaption {
            display: none !important;
        }

        .icon-password::before {
            content: "";
            display: inline-block;
            background-image: url('/img/DevExButton/Password-change.png');
            background-size: contain;
            background-repeat: no-repeat;
            width: 25px;
            height: 25px;
            vertical-align: middle;
        }

        .icon-sospendi::before {
            content: "";
            display: inline-block;
            background-image: url('/img/DevExButton/stop.png');
            background-size: contain;
            background-repeat: no-repeat;
            width: 25px;
            height: 25px;
            vertical-align: middle;
        }

        .icon-riattiva::before {
            content: "";
            display: inline-block;
            background-image: url('/img/DevExButton/Start-on-go.png');
            background-size: contain;
            background-repeat: no-repeat;
            width: 20px;
            height: 20px;
            vertical-align: middle;
        }
    </style>
    <div class="col-lg-2 col-md-3 col-sm-3">
        <div class="card">
            <div class="card-header card-header-text" data-background-color="">
                <h4 class="card-title">Tipologia utente</h4>
            </div>
            <div class="card-content">
                <div class="row">
                    <div class="col-lg-12">
                        <dx:ASPxGridView ID="grid" runat="server" KeyFieldName="RoleName" DataSourceID="Utenti_Dts" Width="100%" EnableRowsCache="false" AutoGenerateColumns="False" SettingsBehavior-AllowFocusedRow="true" OnFocusedRowChanged="grid_FocusedRowChanged">
                            <ClientSideEvents FocusedRowChanged="function(s,e){Cards_CallbackPnl.PerformCallback();}" />
                            <Settings ShowColumnHeaders="false" />
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="RoleName" VisibleIndex="0">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsPager PageSize="5" />
                        </dx:ASPxGridView>
                        <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" Text="Importazione massiva in corso..."></dx:ASPxLoadingPanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-10 col-md-9 col-sm-9">
        <script>
            var comando;
            function BeginCallbackGrid(s, e) {
                comando = e.command;
            }
            function EndCallbackGrid(s, e) {
                if (comando == "STARTEDIT") {
                    EditForm_CallbackPanel.PerformCallback(3);
                }
                if (comando == "CUSTOMBUTTON") {
                    if (s.cpCambiaPassword == 1) {
                        UtenteDaMod_CallbackPnl.PerformCallback();
                    } else {
                        showNotification();
                    }

                }
            }
            let notificationShown = false;
            function EditForm_CallbackPanel_EndCallback(s, e) {
                if (ASPxClientEdit.ValidateGroup('NuovoUtenteValid')) {
                    if (EditForm_CallbackPanel.cpDatiValidi == 1) {
                        Cards_CallbackPnl.PerformCallback();
                        if (!notificationShown) {
                            showNotification();
                            notificationShown = true;
                        }
                        delete EditForm_CallbackPanel.cpDatiValidi;
                    }
                }
                if (EditForm_CallbackPanel.cpUpdate == 1) {
                    Cards_CallbackPnl.PerformCallback();
                    if (!notificationShown) {
                        showNotification();
                        notificationShown = true;
                    }
                    delete EditForm_CallbackPanel.cpUpdate;
                }
                notificationShown = false;
            }
            function OnCustomButtonClick(s, e) {
                if (e.buttonID == 'Password') {
                    e.processOnServer = true;
                    return;
                }

                if (e.buttonID == 'Riattiva') {
                    e.processOnServer = false;
                    let riattivaIndex = e.visibleIndex;

                    ConfermaOperazioneWithClientFunction(
                        "Conferma Riattivazione",
                        "Confermi di voler riattivare l'utente selezionato?",
                        "Conferma",
                        "Annulla",
                        function () {
                            s.PerformCallback("Riattiva|" + riattivaIndex);
                        },
                        function () { },
                        0,
                        null
                    );
                }

                if (e.buttonID == 'Sospendi') {
                    e.processOnServer = false;
                    let sospendiIndex = e.visibleIndex;

                    ConfermaOperazioneWithClientFunction(
                        "Conferma Sospensione",
                        "Confermi di voler sospendere l'utente selezionato?",
                        "Conferma",
                        "Annulla",
                        function () {
                            s.PerformCallback("Sospendi|" + sospendiIndex);
                        },
                        function () { },
                        0,
                        null
                    );
                }
                if (e.buttonID == 'Elimina') { OnGetRowValuesElimina(e.visibleIndex); }
            }
            function OnEndCallback(s, e) {
                if (s.cpRefreshGrid) {
                    delete s.cpRefreshGrid;
                    s.PerformCallback();
                }
            }
            function OnGetRowValuesElimina(index) {
                ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare l\'utente selezionato?", "Conferma", "Annulla", Elimina, null, index, null);
            }
            function Elimina(Valore) {
                Generic_Gridview.DeleteRow(Valore);
            }
        </script>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header card-header-icon" data-background-color="blue">
                        <i class="material-icons">groups</i>
                    </div>
                    <div class="card-content">
                        <h4 class="card-title">Lista Utenti</h4>
                        <dx:ASPxCallbackPanel ID="Cards_CallbackPnl" ClientInstanceName="Cards_CallbackPnl" runat="server" Width="100%" OnCallback="Cards_CallbackPnl_Callback">
                            <PanelCollection>
                                <dx:PanelContent>
                                    <dx:ASPxGridView SettingsBehavior-ConfirmDelete="true" SettingsText-ConfirmDelete="Confermi l'eliminazione dell'utente?" SettingsText-PopupEditFormCaption="Modifica/Inserisci utente" Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" DataSourceID="EditCardView_Dts" runat="server" Width="100%" AutoGenerateColumns="False" OnRowInserting="Generic_Gridview_RowInserting" OnRowUpdating="Generic_Gridview_RowUpdating" KeyFieldName="ID" OnCustomButtonInitialize="Generic_Gridview_CustomButtonInitialize" OnCustomButtonCallback="Generic_Gridview_CustomButtonCallback" OnRowDeleting="Generic_Gridview_RowDeleting" OnCustomCallback="Generic_Gridview_CustomCallback">
                                        <ClientSideEvents CustomButtonClick="OnCustomButtonClick" BeginCallback="BeginCallbackGrid" EndCallback="EndCallbackGrid" />
                                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                                        <SettingsPopup>
                                            <EditForm Modal="true" Width="1000px" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter">
                                            </EditForm>
                                        </SettingsPopup>
                                        <Styles>
                                            <AlternatingRow Enabled="True"></AlternatingRow>
                                        </Styles>
                                        <SettingsAdaptivity>
                                            <AdaptiveDetailLayoutProperties ColCount="2">
                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                            </AdaptiveDetailLayoutProperties>
                                        </SettingsAdaptivity>
                                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                                        <Settings ShowFilterRow="True"></Settings>

                                        <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter">
                                            <EditForm HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" AllowResize="True" Modal="True"></EditForm>
                                        </SettingsPopup>
                                        <SettingsCommandButton>
                                            <NewButton ButtonType="Image" RenderMode="Image">
                                                <Image ToolTip="Nuovo" Url="~/img/DevExButton/new.png" Width="30px" Height="30px"></Image>
                                            </NewButton>
                                            <UpdateButton ButtonType="Image" RenderMode="Image">
                                                <Image ToolTip="Aggiorna" Height="30px" Url="~/img/DevExButton/update.png" Width="30px"></Image>
                                            </UpdateButton>
                                            <CancelButton ButtonType="Image" RenderMode="Image">
                                                <Image ToolTip="Annulla" Height="30px" Url="~/img/DevExButton/cancel.png" Width="30px"></Image>
                                            </CancelButton>
                                            <EditButton ButtonType="Image" RenderMode="Image">
                                                <Image ToolTip="Modifica" Height="30px" Url="~/img/DevExButton/edit.png" Width="30px"></Image>
                                            </EditButton>
                                            <DeleteButton ButtonType="Image" RenderMode="Image">
                                                <Image ToolTip="Elimina" Height="30px" Url="~/img/DevExButton/delete.png" Width="30px"></Image>
                                            </DeleteButton>
                                            <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                            </ClearFilterButton>
                                        </SettingsCommandButton>
                                        <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true"></SettingsDataSecurity>
                                        <SettingsSearchPanel Visible="True" />
                                        <EditFormLayoutProperties ColCount="2">
                                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                        </EditFormLayoutProperties>
                                        <Styles AlternatingRow-Enabled="True"></Styles>
                                        <Toolbars>
                                            <dx:GridViewToolbar>
                                                <Items>
                                                    <dx:GridViewToolbarItem Alignment="left">
                                                        <Template>
                                                            <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%">
                                                                <Buttons>
                                                                    <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                                </Buttons>
                                                            </dx:ASPxButtonEdit>
                                                        </Template>
                                                    </dx:GridViewToolbarItem>
                                                    <dx:GridViewToolbarItem Command="ClearFilter" Text="Cancella Flitro" />
                                                    <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />

                                                </Items>
                                            </dx:GridViewToolbar>

                                        </Toolbars>
                                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowNewButtonInHeader="false" ShowEditButton="true" ShowDeleteButton="false" VisibleIndex="0" ButtonRenderMode="Image" ShowClearFilterButton="false">
                                                <CustomButtons>
                                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Sospendi" IconCssClass="icon-sospendi" CssClass="btn btn-danger btn-sm me-1" />
                                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Riattiva" IconCssClass="icon-riattiva" CssClass="btn btn-success btn-sm me-1" />
                                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Password" IconCssClass="icon-password" CssClass="btn btn-info btn-sm me-1" />

                                                </CustomButtons>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="UtenteIntranet" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Azienda" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EmailContatto" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CodAge" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Agente" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="LastActivityDate" Caption="Ultima attività" VisibleIndex="5"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn FieldName="IsLockedOut" Caption="Bloccato" VisibleIndex="6" Width="60px"></dx:GridViewDataCheckColumn>
                                        </Columns>
                                        <Templates>
                                            <EditForm>
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <dx:ASPxCallbackPanel runat="server" ID="EditForm_CallbackPanel" ClientInstanceName="EditForm_CallbackPanel" Width="100%" OnCallback="EditForm_CallbackPanel_Callback">
                                                            <ClientSideEvents EndCallback="EditForm_CallbackPanel_EndCallback" />
                                                            <PanelCollection>
                                                                <dx:PanelContent>
                                                                    <dx:ASPxFormLayout ID="Edit_FormLayout" ClientInstanceName="Edit_FormLayout" runat="server" Width="100%">
                                                                        <Items>

                                                                            <dx:LayoutGroup ColumnCount="12" Caption="Anagrafica azienda" Paddings-Padding="0">
                                                                                <Items>
                                                                                    <dx:LayoutItem ColumnSpan="6" Caption="Società">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTokenBox ID="Societa_TokenBox" AllowCustomTokens="false" runat="server" ItemValueType="System.String" TextField="Denom" ValueField="CodCli" DataSourceID="Clienti_Dts" Width="100%">
                                                                                                    <ClientSideEvents LostFocus="function(s,e){AggiornamentoTextbox_Callback.PerformCallback(s.GetValue());}" ValueChanged="ControlloNumeroTocken" />
                                                                                                    <ValidationSettings ValidationGroup="NuovoUtenteValid" ErrorDisplayMode="None">
                                                                                                        <RequiredField IsRequired="true" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTokenBox>
                                                                                                <dx:ASPxTextBox runat="server" ID="CodLis_Llb" ClientInstanceName="CodLis_Llb" ClientVisible="false"></dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>

                                                                                    <%--  <dx:LayoutItem ColumnSpan="2" Caption="Fax">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:BootstrapTextBox runat="server" ID="Fax_Txt" ClientInstanceName="Fax_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                    </dx:LayoutItem>--%>

                                                                                    <dx:LayoutItem ColumnSpan="2" Caption="C.F./P.Iva">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Codicefiscale_Txt" ClientInstanceName="Codicefiscale_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <dx:LayoutItem ColumnSpan="2" Caption="Email Azienda">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="EmailAzienda_Txt" ClientInstanceName="EmailAzienda_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <dx:LayoutItem ColumnSpan="5" Caption="Indirizzo">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Indirizzo_Txt" ClientInstanceName="Indirizzo_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <dx:LayoutItem ColumnSpan="1" Caption="Cap">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Cap_Txt" MaxLength="5" ClientInstanceName="Cap_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <dx:LayoutItem ColumnSpan="2" Caption="Città">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Citta_Txt" ClientInstanceName="Citta_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <dx:LayoutItem ColumnSpan="1" Caption="Provincia">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Provincia_Txt" ClientInstanceName="Provincia_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <%--  <dx:LayoutItem ColumnSpan="2" Caption="Email Ticket">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:BootstrapTextBox runat="server" ID="EmailTicket_Txt" ClientInstanceName="EmailTicket_Txt" Width="100%">
                                                                                    <ValidationSettings ValidationGroup="NuovoUtenteValid">
                                                                                        <RequiredField IsRequired="true" />
                                                                                    </ValidationSettings>
                                                                                </dx:BootstrapTextBox>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                    </dx:LayoutItem>--%>
                                                                                </Items>
                                                                            </dx:LayoutGroup>
                                                                            <dx:LayoutGroup ColumnCount="12" Caption="Utente intranet" Paddings-Padding="0">
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="Nome utente" ColumnSpan="2">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="NomeUtenteIntranet_Txt" EnableClientSideAPI="True" ClientInstanceName="NomeUtenteIntranet_Txt" Width="100%" Text='<%# Bind("UtenteIntranet") %>' ValidationSettings-ValidationGroup="NuovoUtenteValid" ClientEnabled="false">
                                                                                                    <ClientSideEvents Validation="function(s,e){
                                                                                        if(EditForm_CallbackPanel.cpNomeUtenteValido != null)
                                                                                        {     
                                                                                               if(EditForm_CallbackPanel.cpNomeUtenteValido == 1 )
                                                                                               {
                                                                                                     e.isValid = true;
                                                                                                     delete EditForm_CallbackPanel.cpNomeUtenteValido; 
                                                                                                     return false;
                                                                                               }
                                                                                               else
                                                                                               {
                                                                                                    e.isValid = false;
                                                                                                    delete EditForm_CallbackPanel.cpNomeUtenteValido; 
                                                                                                    return true;
                                                                                               }
                                                                                        }
                                                                                        else
                                                                                        {    
                                                                                            if(NomeUtenteIntranet_Txt.GetText() != '')
                                                                                             {   
                                                                                                e.isValid = true;
                                                                                             }
                                                                                        }
                                                                                               }" />
                                                                                                    <ValidationSettings ValidateOnLeave="false">
                                                                                                        <RequiredField IsRequired="true" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <%--                                                                    <dx:LayoutItem Caption="Password" ColumnSpan="2">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:BootstrapTextBox runat="server" ID="Password_Txt" EnableClientSideAPI="True" ClientInstanceName="Password_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                                    <ValidationSettings>
                                                                                        <RequiredField IsRequired="true" />
                                                                                    </ValidationSettings>
                                                                                </dx:BootstrapTextBox>

                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Conferma password" ColumnSpan="2">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:BootstrapTextBox runat="server" ID="CheckPassword_Txt" EnableClientSideAPI="True" ClientInstanceName="CheckPassword_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                                    <ClientSideEvents Validation="function(s, e) {
	                                                                                                    var originalPasswd = Password_Txt.GetText();
                                                                                                        var currentPasswd = s.GetText();
                                                                                                        e.isValid = (originalPasswd  == currentPasswd );
                                                                                                    }" />
                                                                                    <ValidationSettings>
                                                                                        <RequiredField IsRequired="true" />
                                                                                    </ValidationSettings>
                                                                                </dx:BootstrapTextBox>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                    </dx:LayoutItem>--%>
                                                                                    <dx:LayoutItem Caption="Email" ColumnSpan="10">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox AutoCompleteType="Email" EnableClientSideAPI="True" runat="server" ID="Email_Txt" ClientInstanceName="Email_Txt" Width="100%" Text='<%# Bind("EmailContatto") %>' ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                                                    <ClientSideEvents Validation="
                                                                                        function(s,e)
                                                                                        {
                                                                                            if(EditForm_CallbackPanel.cpEmailValido != null)
                                                                                              {
                                                                                               if(EditForm_CallbackPanel.cpEmailValido == 1)
                                                                                                    {
                                                                                                        e.isValid = true;
                                                                                      
                                                                                                        delete EditForm_CallbackPanel.cpEmailValido; 
                                                                                                        return false;
                                                                                                    }
                                                                                               else
                                                                                                     {
                                                                                                         e.isValid = false;
                                                                                                         delete EditForm_CallbackPanel.cpEmailValido; 
                                                                                                         return true;
                                                                                                     }
                                                                                             } 
                                                                                            else
                                                                                             {
                                                                                               if(Email_Txt.GetText() != '')
                                                                                                     {
                                                                                                         e.isValid = true;
                                                                                                     }
                                                                                             }
                                                                                        }" />
                                                                                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" ErrorText="Email già presente nel database.">
                                                                                                        <RegularExpression ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorText="Email non valida" />
                                                                                                        <RequiredField IsRequired="True" ErrorText="Obbligatoria" />
                                                                                                    </ValidationSettings>

                                                                                                </dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <%-- <dx:LayoutItem Caption="Data scadenza account" ColumnSpan="2">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <dx:ASPxDateEdit ID="DataBlocco_DateEdit" EnableClientSideAPI="True" ClientInstanceName="DataBlocco_DateEdit" Width="100%" runat="server" Value='<%# Bind("DataBlocco") %>' ValidationSettings-ValidationGroup="NuovoUtenteValid" OnDataBinding="DataBlocco_DateEdit_DataBinding">
                                                                                </dx:ASPxDateEdit>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                    </dx:LayoutItem>--%>
                                                                                    <dx:LayoutItem ColumnSpan="2" Caption="Nome">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Nome_txt" ClientInstanceName="Nome_txt" Width="100%">
                                                                                                    <ValidationSettings ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="true" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <dx:LayoutItem ColumnSpan="2" Caption="Cognome">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Cognome_Txt" ClientInstanceName="Cognome_Txt" Width="100%">
                                                                                                    <ValidationSettings ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="true" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>
                                                                                    <dx:LayoutItem ColumnSpan="2" Caption="Telefono">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:BootstrapTextBox runat="server" ID="Telefono_txt" ClientInstanceName="Telefono_txt" Width="100%"></dx:BootstrapTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                    </dx:LayoutItem>

                                                                                </Items>

                                                                            </dx:LayoutGroup>
                                                                        </Items>
                                                                    </dx:ASPxFormLayout>

                                                                    <dx:BootstrapButton runat="server" Text="" ClientInstanceName="Salva_Btn" ID="Salva_Btn" AutoPostBack="false" ValidationGroup="NuovoUtenteValid" Badge-CssClass="BadgeBtn"
                                                                        CssClasses-Control="btn btn-sm btn-custom-padding" Badge-IconCssClass="fa fa-save">
                                                                        <ClientSideEvents Click="function(s,e){ 
                                                            if(ASPxClientEdit.ValidateGroup('NuovoUtenteValid')){EditForm_CallbackPanel.PerformCallback(1);}}" />
                                                                        <Badge Text="SALVA" />
                                                                        <SettingsBootstrap RenderOption="Success" />
                                                                    </dx:BootstrapButton>
                                                                    <dx:BootstrapButton runat="server" Text="" ClientInstanceName="SalvaEdit_Btn" ID="SalvaEdit_Btn" ClientVisible="false" AutoPostBack="false" ValidationGroup="NuovoUtenteValid"
                                                                        CssClasses-Control="btn btn-sm btn-custom-padding" Badge-CssClass="BadgeBtn-just-icon">
                                                                        <ClientSideEvents Click="function(s,e){ 
                                                             EditForm_CallbackPanel.PerformCallback(2);}" />
                                                                        <Badge IconCssClass="fa fa-save" Text="SALVA" />
                                                                        <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                                                    </dx:BootstrapButton>
                                                                    <dx:BootstrapButton runat="server" Text="" ClientInstanceName="ChiudiEdit_Btn" ID="ChiudiEdit_Btn"
                                                                        ClientVisible="true" AutoPostBack="false" CssClasses-Control="btn btn-sm btn-custom-padding"
                                                                        Badge-CssClass="BadgeBtn-just-icon">
                                                                        <ClientSideEvents Click="function(s,e){
                                                                            EditForm_CallbackPanel.SetVisible(false);
                                                                            Generic_Gridview.CancelEdit(); 
                                                                        }" />
                                                                        <Badge IconCssClass="fa fa-times" Text="CHIUDI" />
                                                                        <SettingsBootstrap RenderOption="Danger" Sizing="Small" />
                                                                    </dx:BootstrapButton>
                                                                </dx:PanelContent>
                                                            </PanelCollection>
                                                        </dx:ASPxCallbackPanel>
                                                    </div>
                                                </div>
                                            </EditForm>
                                        </Templates>
                                    </dx:ASPxGridView>

                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                </div>
            </div>
        </div>

        <dx:ASPxCallback runat="server" ID="AggiornamentoTextbox_Callback" ClientInstanceName="AggiornamentoTextbox_Callback" OnCallback="AggiornamentoTextbox_Callback_Callback">
            <ClientSideEvents EndCallback="function(s,e){
                Codicefiscale_Txt.SetText(s.cpCodiceFiscale);
                Indirizzo_Txt.SetText(s.cpIndirizzo);
                Cap_Txt.SetText(s.cpCap);
                Citta_Txt.SetText(s.cpCitta);
                Provincia_Txt.SetText(s.cpProvincia);
                 EmailAzienda_Txt.SetText(s.cpEmailAzienda);
                CodLis_Llb.SetText(s.cpCodLis);
                NomeUtenteIntranet_Txt.SetText(s.cpNomeUtente);
                }" />
        </dx:ASPxCallback>


        <dx:ASPxPopupControl ID="CambiaPassword_Popup" HeaderText="Modifica password" ClientInstanceName="CambiaPassword_Popup" runat="server" Width="700px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" AutoUpdatePosition="true">
            <ContentCollection>
                <dx:PopupControlContentControl>

                    <dx:ASPxCallbackPanel runat="server" ID="UtenteDaMod_CallbackPnl" ClientInstanceName="UtenteDaMod_CallbackPnl" Width="100%" OnCallback="UtenteDaMod_CallbackPnl_Callback">
                        <ClientSideEvents EndCallback="function(s,e){CambiaPassword_Popup.Show();passwordTextBox.SetText('');confirmPasswordTextBox.SetText('');}" />
                        <PanelCollection>
                            <dx:PanelContent>
                                Utente:
                                <dx:ASPxLabel runat="server" ID="UtenteModPassword_Lbl" Font-Size="Large"></dx:ASPxLabel>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                    <br />
                    <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%" ColumnCount="2">
                        <SettingsItemCaptions Location="Top" />
                        <Paddings PaddingBottom="30" PaddingTop="10" />
                        <Styles>
                            <LayoutGroupBox CssClass="fullWidth fullHeight"></LayoutGroupBox>
                            <LayoutGroup Cell-CssClass="fullHeight"></LayoutGroup>
                        </Styles>
                        <SettingsAdaptivity>
                            <GridSettings>
                                <Breakpoints>
                                    <dx:LayoutBreakpoint ColumnCount="1" MaxWidth="790" Name="S" />
                                </Breakpoints>
                            </GridSettings>
                        </SettingsAdaptivity>
                        <Items>
                            <dx:LayoutGroup Caption="Cambio password" GroupBoxDecoration="Box">
                                <GridSettings></GridSettings>
                                <SpanRules>
                                    <dx:SpanRule BreakpointName="S" ColumnSpan="1" RowSpan="1" />
                                </SpanRules>
                                <Items>
                                    <dx:LayoutItem Caption="Password">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>


                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <i class="material-icons">lock_outline</i>
                                                    </span>
                                                    <div class="form-group label-floating">
                                                        <dx:ASPxTextBox ID="passwordTextBox" runat="server" ClientInstanceName="passwordTextBox" CssClass="form-control maxWidth" NullText="Password" Password="true">
                                                            <ValidationSettings ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText" Display="Dynamic" SetFocusOnError="true">
                                                                <RequiredField IsRequired="True" ErrorText="Richiesto" />
                                                                <ErrorFrameStyle Wrap="True" />
                                                            </ValidationSettings>
                                                            <ClientSideEvents Init="OnPasswordTextBoxInit" KeyUp="OnPassChanged" Validation="OnPassValidation" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>



                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem Caption="Conferma password">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>

                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <i class="material-icons">lock_outline</i>
                                                    </span>
                                                    <div class="form-group label-floating">
                                                        <dx:ASPxTextBox ID="confirmPasswordTextBox" runat="server" ClientInstanceName="confirmPasswordTextBox" Password="true" Width="100%" CssClass="form-control maxWidth" NullText="Conferma Password">
                                                            <ValidationSettings ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText" Display="Dynamic" SetFocusOnError="true">
                                                                <RequiredField IsRequired="True" ErrorText="Richiesto" />
                                                                <ErrorFrameStyle Wrap="True" />
                                                            </ValidationSettings>
                                                            <ClientSideEvents Validation="OnPassValidation" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption=" ">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <i class="material-icons">vpn_key</i>
                                                    </span>
                                                    <div class="form-group label-floating">
                                                        <dx:ASPxRatingControl ID="ratingControl" runat="server" ReadOnly="true" ItemCount="5" Value="0" ClientInstanceName="ratingControl"></dx:ASPxRatingControl>
                                                        <br />
                                                        <div style="padding-top: 10px; padding-bottom: 10px">
                                                            <dx:ASPxLabel ID="ratingLabel" runat="server" ClientInstanceName="ratingLabel" Text="Inserire Password" />
                                                        </div>
                                                    </div>
                                                </div>

                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:BootstrapButton ID="CambiaPsw_BS_Btn" runat="server" AutoPostBack="false" Badge-Text="Modifica Password" lass="btn btn-rose btn-round" Badge-CssClass="BadgeBtn"
                                                    CssClasses-Control="btn btn-sm btn-custom-padding" Badge-IconCssClass="fa fa-check">
                                                    <SettingsBootstrap RenderOption="Success" />

                                                    <ClientSideEvents Click="function(s,e){if(passwordTextBox.isValid && confirmPasswordTextBox.isValid){SalvaPsw_Callback.PerformCallback();}}" />

                                                </dx:BootstrapButton>
                                                <%-- <dx:ASPxButton runat="server" ID="signUp" Text="Conferma Password" Width="100%" CssClass="btn" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s,e){if(passwordTextBox.isValid && confirmPasswordTextBox.isValid){CambiaPassword_Callback.PerformCallback();}}" />
                                                </dx:ASPxButton>--%>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                        </Items>
                    </dx:ASPxFormLayout>


                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

        <dx:ASPxCallback ID="SalvaPsw_Callback" ClientInstanceName="SalvaPsw_Callback" runat="server" OnCallback="SalvaPsw_Callback_Callback">
            <ClientSideEvents EndCallback="function(s,e){showNotification();CambiaPassword_Popup.Hide();}" />
        </dx:ASPxCallback>


    </div>

    <asp:SqlDataSource ID="Clienti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Clienti.CodCli, Clienti.CodCli + ' - ' +  trim(REPLACE(Clienti.Denom,'  ', '')) as Denom, Clienti.Ind, Clienti.Loc, Clienti.Tel, TCK_Aziende_Email_Tck.EmailTicket FROM Clienti LEFT OUTER JOIN TCK_Aziende_Email_Tck ON Clienti.CodCli = TCK_Aziende_Email_Tck.CodCLi WHERE (Clienti.FlagAnnullo = 0) AND (Clienti.CodAge IS NOT NULL) order by Clienti.Denom "></asp:SqlDataSource>

    <asp:SqlDataSource ID="Utenti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT RoleName FROM aspnet_Roles WHERE (Description = '1' OR Description = '2')"></asp:SqlDataSource>

    <asp:SqlDataSource ID="EditCardView_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT VIO_Utenti.ID, VIO_Utenti.UtenteIntranet, VIO_Utenti.CodCli, VIO_Utenti.Azienda, VIO_Utenti.EmailContatto, VIO_Utenti.DataBlocco, aspnet_Users.LastActivityDate, aspnet_Membership.Password, VIO_Utenti.Scaduto, CASE WHEN TCK_Aziende_Email_Tck.EmailTicket IS NULL THEN 'xxxxx' ELSE TCK_Aziende_Email_Tck.EmailTicket END AS EmailTicket, SHP_AgeForClient.Descrizione, SHP_AgeForClient.CodAge, aspnet_Membership.IsLockedOut FROM SHP_AgeForClient RIGHT OUTER JOIN VIO_Utenti ON SHP_AgeForClient.CodCli = VIO_Utenti.CodCli LEFT OUTER JOIN TCK_Aziende_Email_Tck ON VIO_Utenti.CodCli = TCK_Aziende_Email_Tck.CodCLi LEFT OUTER JOIN aspnet_Membership INNER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId AND aspnet_Membership.UserId = aspnet_Users.UserId AND aspnet_Membership.UserId = aspnet_Users.UserId AND aspnet_Membership.UserId = aspnet_Users.UserId ON VIO_Utenti.UtenteIntranet = aspnet_Users.UserName WHERE (VIO_Utenti.Tipologia = @Tipologia)" InsertCommand="VIO_Utenti_Insert" InsertCommandType="StoredProcedure" UpdateCommand="EXEC VIO_Utenti_Update @UtenteIntranet, @EmailContatto, @Nome, @Cognome" DeleteCommand="VIO_Utenti_Delete" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UtenteIntranet"></asp:Parameter>
            <asp:Parameter Name="EmailContatto"></asp:Parameter>
            <asp:Parameter Name="Nome" Type="String"></asp:Parameter>
            <asp:Parameter Name="Cognome" Type="String"></asp:Parameter>
            <asp:Parameter Name="Tipologia"></asp:Parameter>
            <asp:Parameter Name="Azienda"></asp:Parameter>
            <asp:Parameter Name="CodCli"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="TipologiaSession" Name="Tipologia"></asp:SessionParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="UtenteIntranet" Type="String" />
            <asp:Parameter Name="EmailContatto" Type="String" />
            <asp:Parameter Name="Nome" Type="String" />
            <asp:Parameter Name="Cognome" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
