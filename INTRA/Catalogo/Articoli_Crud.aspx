<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Articoli_Crud.aspx.cs" Inherits="INTRA.Catalogo.Articoli_Crud" %>

<%@ Register Src="~/Controls/AssociaPromo.ascx" TagPrefix="uc1" TagName="AssociaPromo" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<%--    <style>
    .dxbs-textbox > div{
        text-align:right;
    }

    .dxbs-feedback{
        display:inline-block !important;
    }
    </style>--%>
    
    <script>
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
            //ImmagineCaricata_Img.SetImageUrl(DocumentsUploadControl.cpPathImmagine);
            updateTokenBoxVisibility();
            uploadedFiles = [];
            if (submitInitiated) {
                SubmitButton.SetEnabled(true);
                SubmitButton.DoClick();
            }
        }
        function onSubmitButtonInit(s, e) {
            s.SetEnabled(true);
        }
        function onSubmitButtonClick(s, e) {
            ASPxClientEdit.ValidateGroup();
            if (!formIsValid())
                e.processOnServer = false;
            else if (uploadInProgress) {
                s.SetEnabled(false);
                submitInitiated = true;
                e.processOnServer = false;
            }
        }
        function onTokenBoxValidation(s, e) {
            var isValid = DocumentsUploadControl.GetText().length > 0 || UploadedFilesTokenBox.GetText().length > 0;
            e.isValid = isValid;

            if (!isValid) {
                e.errorText = "Non sono stati caricati file.";
            }
            return true;

            return false
        }
        function onTokenBoxValueChanged(s, e) {
            updateTokenBoxVisibility();
        }
        function updateTokenBoxVisibility() {
            var isTokenBoxVisible = UploadedFilesTokenBox.GetTokenCollection().length > 0;
        }
        function formIsValid() {
            return !ValidationSummary.IsVisible() && UploadedFilesTokenBox.GetIsValid() && !uploadErrorOccurred;
        }


        //Questo è per il secondo uploadcontrol slide 1

        function onFileUploadCompleteSlideUno(s, e) {
            var callbackData = e.callbackData.split("|"),
                uploadedFileName = callbackData[0],
                isSubmissionExpired = callbackData[1] === "True";
            uploadedFiles.push(uploadedFileName);
            if (e.errorText.length > 0 || !e.isValid)
                uploadErrorOccurred = true;
            if (isSubmissionExpired && SHPPictureSlideUno_Token.GetText().length > 0) {
                var removedAfterTimeoutFiles = SHPPictureSlideUno_Token.GetTokenCollection().join("\n");
                alert("The following files have been removed from the server due to the defined 5 minute timeout: \n\n" + removedAfterTimeoutFiles);
                SHPPictureSlideUno_Token.ClearTokenCollection();
            }
        }
        function onFileUploadStartSlideUno(s, e) {
            uploadInProgress = true;
            uploadErrorOccurred = false;
            SHPPictureSlideUno_Token.SetIsValid(true);
        }
        function onFilesUploadCompleteSlideUno(s, e) {
            uploadInProgress = false;
            for (var i = 0; i < uploadedFiles.length; i++)
                SHPPictureSlideUno_Token.AddToken(uploadedFiles[i]);
            //ImmagineCaricata_Img.SetImageUrl(DocumentsUploadControl.cpPathImmagine);
            updateTokenBoxVisibility();
            uploadedFiles = [];
            if (submitInitiated) {
                SubmitButton.SetEnabled(true);
                SubmitButton.DoClick();
            }
        }

        function onTokenBoxValidationSlideUno(s, e) {
            var isValid = SHPPictureSlideUno_UploadControl.GetText().length > 0 || SHPPictureSlideUno_Token.GetText().length > 0;
            e.isValid = isValid;

            if (!isValid) {
                e.errorText = "Non sono stati caricati file.";
            }
            return true;

            return false
        }
        function onTokenBoxValueChangedSlideUno(s, e) {
            updateTokenBoxVisibility();
        }
        function updateTokenBoxVisibilitySlideUno() {
            var isTokenBoxVisible = SHPPictureSlideUno_Token.GetTokenCollection().length > 0;
        }
        function formIsValidSlideUno() {
            return !ValidationSummary.IsVisible() && SHPPictureSlideUno_Token.GetIsValid() && !uploadErrorOccurred;
        }


        function Save_btnClick(s, e) {
            ControlTreeList_Callback.PerformCallback();

        }

        function CheckDescrLength(textLength) {
            return textLength <= 150;
        }
    </script>

    <style>
        .myHtmlEditor,
        .myHtmlEditor table {
            width: 100% !important;
        }
    </style>

    <uc1:AssociaPromo runat="server" ID="AssociaPromo_Popup" />
    <dx:ASPxHiddenField runat="server" ID="HfFile" ClientInstanceName="HfFile"></dx:ASPxHiddenField>

    <dx:ASPxLoadingPanel runat="server" ID="InserimentoArticolo_LoadingPnl" Modal="true" ClientInstanceName="InserimentoArticolo_LoadingPnl"></dx:ASPxLoadingPanel>

    <dx:ASPxCallbackPanel ID="InserimentoArt_CallbackPnl" ClientInstanceName="InserimentoArt_CallbackPnl" runat="server" Width="100%" OnCallback="InserimentoArt_CallbackPnl_Callback">
        <ClientSideEvents EndCallback="function(s,e){InserimentoArticolo_Popup.Show()}" />
        <PanelCollection>
            <dx:PanelContent>
                <div class="row ">
                    <dx:ASPxCallback runat="server" ID="ControlloCodiceArticolo_Callback" ClientInstanceName="ControlloCodiceArticolo_Callback" OnCallback="ControlloCodiceArticolo_Callback_Callback">
                        <ClientSideEvents BeginCallback="function(s,e){InserimentoArticolo_LoadingPnl.Show();}" CallbackComplete="function(s,e){InserimentoArticolo_LoadingPnl.Hide();
                                    if(s.cpExistCodArt == 1)
                                    {
                                    CodArt1_Txt.SetIsValid(false);
                                    CodArtValid_Lbl.SetText('Articolo già presente');
                                    CodArtValid_Lbl.GetMainElement().style.color = 'Red';
                                    CodArtValidClona_Lbl.SetText('Articolo già presente');
                                    CodArtValidClona_Lbl.GetMainElement().style.color = 'Red';
                                    Clona_Btn.SetEnabled(false);
                                    }
                                    else
                                    {
                                    CodArtValid_Lbl.SetText('Articolo valido');
                                    CodArtValid_Lbl.GetMainElement().style.color = 'green';
                                    CodArtValidClona_Lbl.SetText('Articolo valido');
                                    CodArtValidClona_Lbl.GetMainElement().style.color = 'green';
                                    if(ASPxClientEdit.ValidateGroup('NuovoArtValid')){
                                    
                                    CaricaDocumentiLocal_CallbackPnl.PerformCallback(); 
                                    }

                                    
                                    }
                                    }" />
                    </dx:ASPxCallback>
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <dx:ASPxFormLayout ID="FormLayout" runat="server" Width="100%" UseDefaultPaddings="false" DataSourceID="Artiolo_Dts">
                            <Items>
                                <dx:LayoutGroup Caption="Seleziona i documenti da caricare">
                                    <Items>
                                        <dx:LayoutItem ShowCaption="False" FieldName="PictureUrl">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>

                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <dx:ASPxCallbackPanel ID="CaricaDocumentiLocal_CallbackPnl" ClientInstanceName="CaricaDocumentiLocal_CallbackPnl" runat="server" Width="100%" OnCallback="CaricaDocumentiLocal_CallbackPnl_Callback">
                                                                <ClientSideEvents BeginCallback="function(s,e){  InserimentoArticolo_LoadingPnl.Show();}" CallbackError="function(s,e){InserimentoArticolo_LoadingPnl.Hide();}" EndCallback="function(s,e){InserimentoArticolo_LoadingPnl.Hide(); showNotification(); cardView_Aperti.Refresh(); UploadedFilesTokenBox.ClearTokenCollection();}" />
                                                                <PanelCollection>
                                                                    <dx:PanelContent>
                                                                        <dx:ASPxCardView ID="cardView_Aperti" ClientIDMode="Static" runat="server" DataSourceID="SHP_Picture_Slider" Width="100%" ClientInstanceName="cardView_Aperti"
                                                                            EnableCardsCache="False" KeyFieldName="PictureID" AutoGenerateColumns="False" Styles-BreakpointsCard-Border-BorderWidth="0" Styles-BreakpointsCard-Paddings-Padding="0" Styles-BreakpointsCard-Height="100%">
                                                                            <SettingsPager Mode="EndlessPaging" EndlessPagingMode="OnScroll" EnableAdaptivity="true" Position="TopAndBottom" ShowSeparators="true" Summary-Visible="true">
                                                                                <SettingsBreakpointsLayout ItemsPerPage="50" />
                                                                            </SettingsPager>
                                                                            <Settings LayoutMode="Breakpoints" VerticalScrollBarMode="Hidden" />
                                                                            <SettingsAdaptivity>
                                                                                <BreakpointsLayoutSettings CardsPerRow="4">
                                                                                    <Breakpoints>
                                                                                        <dx:CardViewBreakpoint DeviceSize="XLarge" CardsPerRow="4" />
                                                                                        <dx:CardViewBreakpoint DeviceSize="Large" CardsPerRow="4" />
                                                                                        <dx:CardViewBreakpoint DeviceSize="Medium" CardsPerRow="3" />
                                                                                        <dx:CardViewBreakpoint DeviceSize="Small" CardsPerRow="3" />
                                                                                    </Breakpoints>
                                                                                </BreakpointsLayoutSettings>
                                                                            </SettingsAdaptivity>
                                                                            <SettingsPopup>
                                                                                <HeaderFilter MinHeight="140px"></HeaderFilter>
                                                                            </SettingsPopup>
                                                                            <Templates>
                                                                                <Card>
                                                                                    <div class="card card-product" title='<%# Eval("PictureID") %>'>
                                                                                        <div class="card-image" data-header-animation="true" style="margin-left: auto !important; margin-right: auto !important; width: auto !important;">
                                                                                            <img src='<%# Eval("PictureUrl") %>' />
                                                                                        </div>
                                                                                        <div class="card-content" style="padding: 0 !important">
                                                                                            <div class="card-actions" style="padding-top: 20px;">
                                                                                                <a href='javascript:CaricaDocumentiLocal_CallbackPnl.PerformCallback("<%# Eval("PictureID") %>;1;<%# Eval("PictureUrl") %>")'><i class="material-icons tooltipInfo" title="Imposta Come Principale"><%#  (bool)Eval("Principale") ? "check_box":"check_box_outline_blank"%></i></a>
                                                                                                <a href='javascript:ConfermaOperazione("Eliminazione immagine", "CaricaDocumentiLocal_CallbackPnl", "<%# Eval("PictureID") %>;-1;<%# Eval("PictureUrl") %>")'><i class="material-icons tooltipInfo" style="color: red" title="Elimina"><%#  (bool)Eval("Principale") ? "":"delete"%></i></i></a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </Card>
                                                                            </Templates>
                                                                            <Columns>
                                                                                <dx:CardViewColumn FieldName="PictureID" />
                                                                            </Columns>
                                                                            <Styles>
                                                                                <Card CssClass="cardimmagini" />
                                                                                <BreakpointsCard Height="100%" Border-BorderWidth="0px">
                                                                                    <Paddings Padding="0px"></Paddings>
                                                                                </BreakpointsCard>
                                                                            </Styles>
                                                                            <StylesExport>
                                                                                <Card BorderSize="1" BorderSides="All"></Card>
                                                                                <Group BorderSize="1" BorderSides="All"></Group>
                                                                                <TabbedGroup BorderSize="1" BorderSides="All"></TabbedGroup>
                                                                                <Tab BorderSize="1"></Tab>
                                                                            </StylesExport>
                                                                        </dx:ASPxCardView>
                                                                        <asp:SqlDataSource ID="SHP_Picture_Slider" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT SHP_Picture_Tab.PictureID, SHP_Picture_Tab.PictureUrl, SHP_Picture_Tab.Principale FROM (SELECT PictureID, PictureUrl, Principale, IdContent FROM SHP_Picture AS SHP_Picture_1 WHERE (Sezione = 'prodotti')) AS SHP_Picture_Tab INNER JOIN SHP_Product ON SHP_Picture_Tab.IdContent = SHP_Product.ProductID WHERE (SHP_Product.ProductCod = @ProductCod) ORDER BY SHP_Picture_Tab.Principale DESC" UpdateCommand="SHP_Picture_SetPrincipale" UpdateCommandType="StoredProcedure" DeleteCommand="SHP_Picture_Delete" DeleteCommandType="StoredProcedure">
                                                                            <SelectParameters>
                                                                                <asp:QueryStringParameter QueryStringField="Cod" DefaultValue="0" Name="ProductCod"></asp:QueryStringParameter>
                                                                            </SelectParameters>
                                                                            <UpdateParameters>
                                                                                <asp:Parameter Name="PictureID"></asp:Parameter>
                                                                                <asp:Parameter Name="CodArt"></asp:Parameter>
                                                                                <asp:Parameter Name="Sezione" DefaultValue="prodotti"></asp:Parameter>
                                                                            </UpdateParameters>
                                                                            <DeleteParameters>
                                                                                <asp:Parameter Name="PictureID" />

                                                                            </DeleteParameters>
                                                                        </asp:SqlDataSource>
                                                                    </dx:PanelContent>
                                                                </PanelCollection>
                                                            </dx:ASPxCallbackPanel>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div id="dropZone">
                                                                <dx:ASPxUploadControl runat="server" ID="DocumentsUploadControl" ClientInstanceName="DocumentsUploadControl"
                                                                    AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Aggiungi Documenti" FileUploadMode="OnPageLoad"
                                                                    OnFileUploadComplete="DocumentsUploadControl_FileUploadComplete" Theme="SoftOrange" AdvancedModeSettings-EnableFileList="true" Width="100%">
                                                                    <BrowseButton Text="Aggiungi Documenti">
                                                                    </BrowseButton>
                                                                    <AdvancedModeSettings
                                                                        EnableMultiSelect="True" EnableDragAndDrop="true" ExternalDropZoneID="dropZone">
                                                                    </AdvancedModeSettings>
                                                                    <ValidationSettings MaxFileCount="1" MaxFileSize="9999999999" AllowedFileExtensions=".jpg, .tif, .JPEG ,.png">
                                                                    </ValidationSettings>
                                                                    <ClientSideEvents
                                                                        FileUploadComplete="onFileUploadComplete"
                                                                        FilesUploadComplete="onFilesUploadComplete"
                                                                        FilesUploadStart="onFileUploadStart" />
                                                                    <DropZoneStyle Border-BorderColor="White" Border-BorderStyle="None">
                                                                    </DropZoneStyle>
                                                                </dx:ASPxUploadControl>
                                                                <br />
                                                                <div class=" col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                                                    <dx:ASPxTokenBox runat="server" Width="100%" ID="UploadedFilesTokenBox" ClientInstanceName="UploadedFilesTokenBox"
                                                                        NullText="Select the documents to submit" AllowCustomTokens="false" ClientVisible="true">
                                                                        <ClientSideEvents Init="updateTokenBoxVisibility" ValueChanged="onTokenBoxValueChanged" />
                                                                    </dx:ASPxTokenBox>
                                                                </div>
                                                                <br />
                                                                <dx:ASPxValidationSummary runat="server" ID="ValidationSummary" ClientInstanceName="ValidationSummary"
                                                                    RenderMode="Table" Width="50%" ShowErrorAsLink="false">
                                                                </dx:ASPxValidationSummary>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6">


                                                        <dx:BootstrapButton ID="Salva_Btn" ClientInstanceName="Salva_Btn" runat="server" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding">
                                                            <ClientSideEvents Click="function(s,e){  if(ASPxClientEdit.ValidateGroup('NuovoArtValid')){
                                                                                            ControlloCodiceArticolo_Callback.PerformCallback(CodArt1_Txt.GetText());
                                                                                        }} " />

                                                            <Badge Text="SALVA" IconCssClass="fa fa-save" />
                                                            <SettingsBootstrap RenderOption="Success" />
                                                        </dx:BootstrapButton>


                                                        <dx:BootstrapButton ID="SalvaUpd_Btn" ClientInstanceName="SalvaUpd_Btn" runat="server" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ClientVisible="false">
                                                            <ClientSideEvents Click="function(s,e){ControlTreeList_Callback.PerformCallback('Save');} " />
                                                            <Badge Text="SALVA" IconCssClass="fa fa-save" />
                                                            <SettingsBootstrap RenderOption="Warning" />
                                                        </dx:BootstrapButton>
                                                        <dx:ASPxCallback runat="server" ID="ControlTreeList_Callback" ClientInstanceName="ControlTreeList_Callback" OnCallback="ControlTreeList_Callback_Callback">
                                                            <ClientSideEvents EndCallback="function(s,e){
                                                                var callBackArgs = s.cpCategoriaSelezionata.split('|');
                                                              
                                                                if(callBackArgs[0] == '0')
                                                                {
                                                                    showNotificationErrorWithText('Selezionare prima una categoria');
                                                                }
                                                                else if(callBackArgs[1] == 'Save'){
                                                                        if (ASPxClientEdit.ValidateGroup('NuovoArtValid')) {
                                                                                CaricaDocumentiLocal_CallbackPnl.PerformCallback();
                                                                                SHPPictureSlideUno_CallbackPnl.PerformCallback();
                                                                        }
                                                                     }
                                                                else{
                                                               
                                                                    if(ASPxClientEdit.ValidateGroup('ClonaArticolo')){
                                                                                            Clone_Callback.PerformCallback();
                                                                                        }
                                                                }
                                                                }" />
                                                        </dx:ASPxCallback>
                                                    </div>
                                                    <div class="col-lg-6">

                                                        <dx:BootstrapButton ID="EliminaArticolo_Btn" ClientInstanceName="EliminaArticolo_Btn" runat="server" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" Visible='<%# Request.QueryString["Cod"] != null ? true : false %>'>
                                                            <ClientSideEvents Click="function(s,e){   ConfermaOperazione('Confermi di voler eliminare questo articolo?', 'Elimina_CallbackPnl',0)} " />
                                                            <Badge IconCssClass="fa fa-trash" Text="elimina" />
                                                            <SettingsBootstrap RenderOption="Danger" />
                                                        </dx:BootstrapButton>

                                                    </div>
                                                    <div class=" card" style='<%# Request.QueryString["Cod"] != null ? "": "display:none" %>'>
                                                        <div class="col-lg-6" style="padding-top: 10px">
                                                            <dx:ASPxTextBox ID="NuovoCodice_Clona" runat="server" ClientInstanceName="NuovoCodice_Clona" Width="100%" NullText="inserisci nuovo codice">
                                                                <ClientSideEvents TextChanged="function(s,e){if(s.GetValue() != null || s.GetValue() != ''){ControlloCodiceArticolo_Callback.PerformCallback(NuovoCodice_Clona.GetText());Clona_Btn.SetEnabled(true);}}" />

                                                                <ValidationSettings ValidationGroup="ClonaArticolo" ErrorDisplayMode="None" RequiredField-IsRequired="true"></ValidationSettings>

                                                                <InvalidStyle BackColor="LightPink" />
                                                            </dx:ASPxTextBox>
                                                            <dx:BootstrapButton ID="Clona_Btn" ClientInstanceName="Clona_Btn" ValidationGroup="ClonaArticolo" runat="server" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" Width="100%">
                                                                <%--<ClientSideEvents Click=" " />--%>
                                                                <ClientSideEvents Init="function(s,e){
                                                                        var newCod = NuovoCodice_Clona.GetValue();
                                                                        if((newCod == null) || (newCod == '')){
                                                                            Clona_Btn.SetEnabled(false);
                                                                    }
                                                                    }" />
                                                                <ClientSideEvents Click="function(s,e){ControlTreeList_Callback.PerformCallback('Clone');  } " />
                                                                <Badge Text="Clona" IconCssClass="fa fa-clone" />
                                                                <SettingsBootstrap RenderOption="Info" />
                                                            </dx:BootstrapButton>
                                                            <dx:ASPxCallback runat="server" ID="Clone_Callback" ClientInstanceName="Clone_Callback" OnCallback="Clone_Callback_Callback">
                                                                <ClientSideEvents BeginCallback="function(s,e){ClientLoadingPanel.Show();}" EndCallback="function(s,e){ClientLoadingPanel.Hide();window.location.href = s.cpRedirect}" />
                                                            </dx:ASPxCallback>
                                                        </div>
                                                        <div class="col-lg-6" style="padding-top: 10px">
                                                            <dx:ASPxLabel ID="CodArtValidClona_Lbl" runat="server" ClientInstanceName="CodArtValidClona_Lbl" Font-Bold="true"></dx:ASPxLabel>
                                                        </div>
                                                    </div>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                            </Items>
                        </dx:ASPxFormLayout>

                        <dx:ASPxCallback ID="Elimina_CallbackPnl" ClientInstanceName="Elimina_CallbackPnl" runat="server" OnCallback="Elimina_CallbackPnl_Callback">
                            <ClientSideEvents BeginCallback="function(s,e){ClientLoadingPanel.Show()}" EndCallback="function(s,e){ClientLoadingPanel.Hide(); showNotification();Generic_Grw.Refresh();}" />
                        </dx:ASPxCallback>

                        <asp:SqlDataSource runat="server" ID="AppoggioEliminazione_Sql" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' DeleteCommand="SHP_Articolo_CompleteDelete" DeleteCommandType="StoredProcedure" SelectCommand="select 1">
                            <DeleteParameters>
                                <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                        </asp:SqlDataSource>


                        <dx:ASPxTreeList ID="TreeListMenu" SettingsBehavior-AllowFocusedNode="true" SettingsEditing-ConfirmDelete="true" SettingsText-ConfirmDelete="Confermi di voler eliminare questa categoria?" EnableViewState="False" runat="server" AutoGenerateColumns="False" DataSourceID="Categorie_Dts" KeyFieldName="CategoryID" ParentFieldName="ParentCategoryID" Style="margin-top: 0px" OnDataBound="TreeListMenu_DataBound">
                            <Styles>
                                <AlternatingNode BackColor="#f0f0f0" Enabled="True"></AlternatingNode>
                                <Header Wrap="True"></Header>
                            </Styles>
                            <SettingsSearchPanel Visible="true" />
                            <SettingsSelection Enabled="True" />
                            <Columns>

                                <dx:TreeListTextColumn FieldName="DisplayName" Caption="Categorie" VisibleIndex="1">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true"></PropertiesTextEdit>
                                </dx:TreeListTextColumn>

                            </Columns>
                            <SettingsBehavior AutoExpandAllNodes="True" />
                        </dx:ASPxTreeList>
                    </div>
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <dx:ASPxFormLayout runat="server" ID="InserimentoArticolo_FormLy" ClientInstanceName="InserimentoArticolo_FormLy" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Disabled" DataSourceID="Artiolo_Dts">
                            <Items>
                                <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0" SettingsItemHelpTexts-Position="bottom" SettingsItemCaptions-ChangeCaptionLocationInAdaptiveMode="True">
                                    <Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:LayoutItem Caption="" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="ProductCod">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0 !important">
                                                        <dx:BootstrapTextBox ID="CodArt1_Txt" Caption="CodArt" CssClasses-Caption="TitleCell" ClientInstanceName="CodArt1_Txt" runat="server" Width="100%" FieldName="ProductCod">
                                                            <CssClasses Caption="TitleCell"></CssClasses>
                                                            <ClientSideEvents TextChanged="function(s,e){ControlloCodiceArticolo_Callback.PerformCallback(CodArt1_Txt.GetText());}" />
                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </dx:BootstrapTextBox>
                                                    </div>
                                                    <div class="col-lg-12" style="padding-left: 0 !important">
                                                        <dx:ASPxLabel ID="CodArtValid_Lbl" runat="server" ClientInstanceName="CodArtValid_Lbl"></dx:ASPxLabel>
                                                    </div>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="DisplayName">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0 !important">
                                                        <dx:BootstrapTextBox ID="Titolo_txt" Caption="Titolo" CssClasses-Caption="TitleCell" ClientInstanceName="Titolo_txt" runat="server" Width="100%" FieldName="DisplayName">
                                                            <CssClasses Caption="TitleCell"></CssClasses>

                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </dx:BootstrapTextBox>
                                                    </div>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Descrizione Breve" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="ShortDescription" CaptionSettings-Location="Top">
                                            <CaptionStyle CssClass="TitleCell"></CaptionStyle>
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <div style="width: 100% !important">
                                                        <dx:ASPxHtmlEditor ID="DescrizioneBreve_Memo" Caption="Descrizione breve:" CssClass="myHtmlEditor" ClientInstanceName="DescrizioneBreve_Memo" Width="100%" runat="server" Rows="2" FieldName="ShortDescription" OnDataBinding="DescrizioneBreve_Memo_DataBinding" >
                                                            <ClientSideEvents Validation="function(s,e){ 
                                                                    var Valid = CheckDescrLength(e.html.length);
                                                                    if(!Valid){
                                                                    e.isValid = false;
                                                                    e.errorText = 'La descrizione breve deve avere come lunghezza massima 150 caratteri';
                                                                }
                                                                }"/>
                                                            <SettingsValidation RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </SettingsValidation>
                                                        </dx:ASPxHtmlEditor>
                                                    </div>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Descrizione" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="FullDescription" CaptionSettings-Location="Top">
                                            <CaptionStyle CssClass="TitleCell"></CaptionStyle>
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxHtmlEditor ID="Descrizione_Memo" Caption="Descrizione" CssClass="myHtmlEditor" ClientInstanceName="Descrizione_Memo" Width="100%" runat="server" Rows="2" FieldName="FullDescription" OnDataBinding="Descrizione_Memo_DataBinding">
                                                        <SettingsValidation RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </SettingsValidation>
                                                    </dx:ASPxHtmlEditor>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="AttributesList" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="AttributesList" CaptionSettings-Location="Top">
                                            <CaptionStyle CssClass="TitleCell"></CaptionStyle>
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxHtmlEditor ID="AttributesList_Memo" Caption="AttributesList" CssClass="myHtmlEditor" ClientInstanceName="AttributesList_Memo" Width="100%" runat="server" Rows="2" FieldName="AttributesList" OnDataBinding="AttributesList_Memo_DataBinding">
                                                        <SettingsValidation RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                            <RequiredField IsRequired="false"></RequiredField>
                                                        </SettingsValidation>
                                                    </dx:ASPxHtmlEditor>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>

                                        <dx:LayoutItem Caption="Confezione" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="Confezione" CaptionSettings-Location="Top">
                                            <CaptionStyle CssClass="TitleCell"></CaptionStyle>
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxHtmlEditor ID="Confezione_Html" Caption="AttributesList" CssClass="myHtmlEditor" ClientInstanceName="Confezione_Html" Width="100%" runat="server" Rows="2" FieldName="Confezione" OnDataBinding="Confezione_Html_DataBinding">
                                                    </dx:ASPxHtmlEditor>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>


                                        <dx:LayoutItem Name="Immagine slide aggiuntiva " Caption="Slide" CaptionSettings-Location="Top">
                                            <CaptionStyle CssClass="TitleCell"></CaptionStyle>
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>

                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <dx:ASPxCallbackPanel ID="SHPPictureSlideUno_CallbackPnl" ClientInstanceName="SHPPictureSlideUno_CallbackPnl" runat="server" Width="100%" OnCallback="SHPPictureSlideUno_CallbackPnl_Callback">
                                                                <ClientSideEvents BeginCallback="function(s,e){  InserimentoArticolo_LoadingPnl.Show();}" CallbackError="function(s,e){InserimentoArticolo_LoadingPnl.Hide();}" EndCallback="function(s,e){InserimentoArticolo_LoadingPnl.Hide(); showNotification(); SHPPictureSlideUno_Cardview.Refresh(); SHPPictureSlideUno_Token.ClearTokenCollection();}" />
                                                                <PanelCollection>
                                                                    <dx:PanelContent>
                                                                        <dx:ASPxCardView ID="SHPPictureSlideUno_Cardview" ClientInstanceName="SHPPictureSlideUno_Cardview" ClientIDMode="Static" runat="server" DataSourceID="SHPPictureSlideUno_Dts" Width="100%"
                                                                            EnableCardsCache="False" KeyFieldName="PictureID" AutoGenerateColumns="False" Styles-BreakpointsCard-Border-BorderWidth="0" Styles-BreakpointsCard-Paddings-Padding="0" Styles-BreakpointsCard-Height="100%">
                                                                            <SettingsPager Mode="EndlessPaging" EndlessPagingMode="OnScroll" EnableAdaptivity="true" Position="TopAndBottom" ShowSeparators="true" Summary-Visible="true">
                                                                                <SettingsBreakpointsLayout ItemsPerPage="50" />
                                                                            </SettingsPager>
                                                                            <Settings LayoutMode="Breakpoints" VerticalScrollBarMode="Hidden" />
                                                                            <SettingsAdaptivity>
                                                                                <BreakpointsLayoutSettings CardsPerRow="4">
                                                                                    <Breakpoints>
                                                                                        <dx:CardViewBreakpoint DeviceSize="XLarge" CardsPerRow="4" />
                                                                                        <dx:CardViewBreakpoint DeviceSize="Large" CardsPerRow="4" />
                                                                                        <dx:CardViewBreakpoint DeviceSize="Medium" CardsPerRow="3" />
                                                                                        <dx:CardViewBreakpoint DeviceSize="Small" CardsPerRow="3" />
                                                                                    </Breakpoints>
                                                                                </BreakpointsLayoutSettings>
                                                                            </SettingsAdaptivity>
                                                                            <SettingsPopup>
                                                                                <HeaderFilter MinHeight="140px"></HeaderFilter>
                                                                            </SettingsPopup>
                                                                            <Templates>
                                                                                <Card>
                                                                                    <div class="card card-product" title='<%# Eval("PictureID") %>'>
                                                                                        <div class="card-image" data-header-animation="true" style="margin-left: auto !important; margin-right: auto !important; width: auto !important;">
                                                                                            <img src='<%# Eval("PictureUrl") %>' />
                                                                                        </div>
                                                                                        <div class="card-content" style="padding: 0 !important">
                                                                                            <div class="card-actions" style="padding-top: 20px;">
                                                                                                <a href='javascript:SHPPictureSlideUno_CallbackPnl.PerformCallback("<%# Eval("PictureID") %>;1;<%# Eval("PictureUrl") %>")'><i class="material-icons tooltipInfo" title="Imposta Come Principale"><%#  Convert.ToBoolean(Eval("Principale")) ? "check_box":"check_box_outline_blank"%></i></a>
                                                                                                <a href='javascript:ConfermaOperazione("Eliminazione immagine", "SHPPictureSlideUno_CallbackPnl", "<%# Eval("PictureID") %>;-1;<%# Eval("PictureUrl") %>")'><i class="material-icons tooltipInfo" style="color: red" title="Elimina"><%#  (bool)Eval("Principale") ? "":"delete"%></i></i></a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </Card>
                                                                            </Templates>
                                                                            <Columns>
                                                                                <dx:CardViewColumn FieldName="PictureID" />
                                                                            </Columns>
                                                                            <Styles>
                                                                                <Card CssClass="cardimmagini" />
                                                                                <BreakpointsCard Height="100%" Border-BorderWidth="0px">
                                                                                    <Paddings Padding="0px"></Paddings>
                                                                                </BreakpointsCard>
                                                                            </Styles>
                                                                            <StylesExport>
                                                                                <Card BorderSize="1" BorderSides="All"></Card>
                                                                                <Group BorderSize="1" BorderSides="All"></Group>
                                                                                <TabbedGroup BorderSize="1" BorderSides="All"></TabbedGroup>
                                                                                <Tab BorderSize="1"></Tab>
                                                                            </StylesExport>
                                                                        </dx:ASPxCardView>
                                                                        <asp:SqlDataSource ID="SHPPictureSlideUno_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT SHP_Picture_Tab.PictureID, SHP_Picture_Tab.PictureUrl, isnull(SHP_Picture_Tab.Principale,0) Principale FROM (SELECT PictureID, PictureUrl, Principale, IdContent FROM SHP_Picture AS SHP_Picture_1 WHERE (Sezione = 'slide')) AS SHP_Picture_Tab INNER JOIN SHP_Product ON SHP_Picture_Tab.IdContent = SHP_Product.ProductID WHERE (SHP_Product.ProductCod = @ProductCod) ORDER BY SHP_Picture_Tab.Principale DESC" UpdateCommand="SHP_Picture_SetPrincipale" UpdateCommandType="StoredProcedure" DeleteCommand="SHP_Picture_Delete" DeleteCommandType="StoredProcedure">
                                                                            <SelectParameters>
                                                                                <asp:QueryStringParameter QueryStringField="Cod" DefaultValue="0" Name="ProductCod"></asp:QueryStringParameter>
                                                                            </SelectParameters>
                                                                            <UpdateParameters>
                                                                                <asp:Parameter Name="PictureID"></asp:Parameter>
                                                                                <asp:Parameter Name="CodArt"></asp:Parameter>
                                                                                <asp:Parameter Name="Sezione" DefaultValue="slide"></asp:Parameter>
                                                                            </UpdateParameters>
                                                                            <DeleteParameters>
                                                                                <asp:Parameter Name="PictureID" />

                                                                            </DeleteParameters>
                                                                        </asp:SqlDataSource>
                                                                    </dx:PanelContent>
                                                                </PanelCollection>
                                                            </dx:ASPxCallbackPanel>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div id="dropZone">
                                                                <dx:ASPxUploadControl runat="server" ID="SHPPictureSlideUno_UploadControl" ClientInstanceName="SHPPictureSlideUno_UploadControl"
                                                                    AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Aggiungi Documenti" FileUploadMode="OnPageLoad"
                                                                    OnFileUploadComplete="SHPPictureSlideUno_UploadControl_FileUploadComplete" Theme="SoftOrange" AdvancedModeSettings-EnableFileList="true" Width="100%">
                                                                    <BrowseButton Text="Aggiungi Documenti">
                                                                    </BrowseButton>
                                                                    <AdvancedModeSettings
                                                                        EnableMultiSelect="True" EnableDragAndDrop="true" ExternalDropZoneID="dropZone">
                                                                    </AdvancedModeSettings>
                                                                    <ValidationSettings MaxFileCount="1" MaxFileSize="9999999999" AllowedFileExtensions=".jpg, .tif">
                                                                    </ValidationSettings>
                                                                    <ClientSideEvents
                                                                        FileUploadComplete="onFileUploadCompleteSlideUno"
                                                                        FilesUploadComplete="onFilesUploadCompleteSlideUno"
                                                                        FilesUploadStart="onFileUploadStartSlideUno" />
                                                                    <DropZoneStyle Border-BorderColor="White" Border-BorderStyle="None">
                                                                    </DropZoneStyle>
                                                                </dx:ASPxUploadControl>
                                                                <br />
                                                                <div class=" col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                                                    <dx:ASPxTokenBox runat="server" Width="100%" ID="SHPPictureSlideUno_Token" ClientInstanceName="SHPPictureSlideUno_Token"
                                                                        NullText="Select the documents to submit" AllowCustomTokens="false" ClientVisible="true">
                                                                        <ClientSideEvents Init="updateTokenBoxVisibilitySlideUno" ValueChanged="onTokenBoxValueChangedSlideUno" />
                                                                    </dx:ASPxTokenBox>
                                                                </div>
                                                                <br />
                                                                <dx:ASPxValidationSummary runat="server" ID="ASPxValidationSummary1" ClientInstanceName="ValidationSummary"
                                                                    RenderMode="Table" Width="50%" ShowErrorAsLink="false">
                                                                </dx:ASPxValidationSummary>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>


                                        <dx:LayoutItem Caption="" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="units">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <div class="TitleCell">Unità di misura:</div>
                                                    <br />
                                                    <dx:ASPxComboBox ID="UM_Combobox" CssClasses-Caption="TitleCell" ClientInstanceName="UM_Combobox" runat="server" Width="100%" FieldName="units" ValueType="System.String">
                                                        <Items>
                                                            <dx:ListEditItem Text="PZ." Value="PZ." />
                                                            <dx:ListEditItem Text="N." Value="N." />
                                                        </Items>
                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                    <br />
                                                    <div class="TitleCell">Quantità:</div>
                                                    <br />
                                                    <dx:BootstrapSpinEdit ID="Qta_Txt" DecimalPlaces="0" MinValue="1" MaxValue="99999" CssClasses-Caption="TitleCell" ClientInstanceName="Qta_Txt" runat="server" Width="100%" FieldName="quantity" OnDataBinding="Qta_Txt_DataBinding">
                                                        <CssClasses Caption="TitleCell"></CssClasses>

                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:BootstrapSpinEdit>
                                                    <br />
                                                    <div class="TitleCell">Prezzo di listino (IVA COMPRESA):</div>
                                                    <br />
                                                    <dx:BootstrapSpinEdit ID="PrezzoDiListino_SpinEdit" DecimalPlaces="2" MinValue="1" MaxValue="99999" CssClasses-Caption="TitleCell" ClientInstanceName="PrezzoDiListino_SpinEdit" runat="server" Width="100%" FieldName="Price" OnDataBinding="PrezzoDiListino_SpinEdit_DataBinding">
                                                        <CssClasses Caption="TitleCell"></CssClasses>

                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:BootstrapSpinEdit>
                                                    <br />
                                                    <div class="TitleCell">Percentuale per conteggio punti:</div>
                                                    <dx:BootstrapSpinEdit ID="PercentualPerPunti_spin" DecimalPlaces="2" MinValue="0" MaxValue="99999" CssClasses-Caption="TitleCell" ClientInstanceName="PercentualPerPunti_spin" runat="server" Width="100%" FieldName="PuntiInPercentuale" OnDataBinding="PercentualPerPunti_spin_DataBinding">
                                                        <CssClasses Caption="TitleCell"></CssClasses>
                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoArtValid">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:BootstrapSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutGroup Caption="Promo attive" ColumnSpan="4" ColumnCount="4" GroupBoxStyle-Caption-ForeColor="Red">
                                            <Items>
                                                <dx:LayoutItem Caption=" " ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="PromoPrice">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <div class="TitleCell">Prezzo promo:</div>
                                                            <dx:ASPxLabel runat="server" fieldname="PromoPrice" ID="PromoPrice_Lbl" OnDataBinding="PromoPrice_Lbl_DataBinding"></dx:ASPxLabel>
                                                            €
                                                  <a href='javascript: Promo_CallbackPnl.PerformCallback()'>
                                                      <dx:ASPxImage runat="server" Width="30px" ID="ModificaPromo_img" ImageUrl="../img/DevExButton/edit.png" Visible='<%# Request.QueryString["Cod"] != null ? true : false %>'></dx:ASPxImage>

                                                  </a>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption=" " ColumnSpan="1" RequiredMarkDisplayMode="Hidden" FieldName="StartDate">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <div class="TitleCell">Inizio promo:</div>
                                                            <dx:ASPxLabel runat="server" fieldname="StartDate" ID="StartDate_Lbl" OnDataBinding="StartDate_Lbl_DataBinding"></dx:ASPxLabel>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption=" " ColumnSpan="1" RequiredMarkDisplayMode="Hidden" FieldName="StopDate">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <div class="TitleCell">Fine promo:</div>
                                                            <dx:ASPxLabel runat="server" fieldname="StopDate" ID="StopDate_Lbl" OnDataBinding="StopDate_Lbl_DataBinding"></dx:ASPxLabel>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutItem Caption="" ColumnSpan="2" RequiredMarkDisplayMode="Hidden" FieldName="Published">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox runat="server" ID="Pubblica_Checkbox" ClientInstanceName="Pubblica_Checkbox" Text="Pubblica" TextAlign="Left" FieldName="Published">
                                                    </dx:ASPxCheckBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>



                                    </Items>
                                </dx:LayoutGroup>
                            </Items>
                            <Paddings Padding="0px"></Paddings>
                        </dx:ASPxFormLayout>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

    <asp:SqlDataSource ID="Marchio_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT BrandId, DisplayName FROM SHP_Brand ORDER BY DisplayOrder"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="Artiolo_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT SHP_Product.ProductID, SHP_Product.ProductCod, SHP_Product.TokenAttributi, SHP_Product.TokenTipoAttributi, SHP_Product.GiorniRichiesti, SHP_Product.GiorniRichiestiFlag, SHP_Product.DisplayName, SHP_Product.ShortDescription, SHP_Product.FullDescription, SHP_Product.BrandId, SHP_Product.units, SHP_Product.quantity, SHP_Product.Price, SHP_Product.Published, SHP_Product.QuotaRidotta, SHP_Product.AttributesList, SHP_Product.Confezione, CONVERT (date, SHP_Promo.StartDate) AS StartDate, CONVERT (date, SHP_Promo.StopDate) AS StopDate, SHP_Promo.PromoPrice, SHP_Product.PuntiInPercentuale FROM SHP_Product LEFT OUTER JOIN SHP_Promo ON SHP_Product.PromoId = SHP_Promo.PromoID WHERE (SHP_Product.ProductCod = @ProductCod)"
        InsertCommand="SHP_InserimentoArticolo" InsertCommandType="StoredProcedure" UpdateCommand="SHP_oArticolo_Update" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="ProductCod" Type="String"></asp:Parameter>
            <asp:Parameter Name="DisplayName" Type="String"></asp:Parameter>
            <asp:Parameter Name="ShortDescription" Type="String"></asp:Parameter>
            <asp:Parameter Name="FullDescription" Type="String"></asp:Parameter>
            <asp:Parameter Name="BrandId" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="units" Type="String"></asp:Parameter>
            <asp:Parameter Name="quantity" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Price" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PuntiInPercentuale" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Published" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="UrlImmagine" Type="String"></asp:Parameter>
            <asp:Parameter Name="TokenAttributi" Type="String"></asp:Parameter>
            <asp:Parameter Name="TokenTipoAttributi" Type="String"></asp:Parameter>
            <asp:Parameter Name="GiorniRichiesti" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="GiorniRichiestiFlag" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="AttributesList" Type="String"></asp:Parameter>
            <asp:Parameter Name="UrlImmagineSlide" Type="String"></asp:Parameter>
            <asp:Parameter Name="Confezione" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ProductCod" Type="String"></asp:Parameter>
            <asp:Parameter Name="DisplayName" Type="String"></asp:Parameter>
            <asp:Parameter Name="ShortDescription" Type="String"></asp:Parameter>
            <asp:Parameter Name="FullDescription" Type="String"></asp:Parameter>
            <asp:Parameter Name="BrandId" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="units" Type="String"></asp:Parameter>
            <asp:Parameter Name="quantity" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Price" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PuntiInPercentuale" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Published" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="UrlImmagine" Type="String"></asp:Parameter>
            <asp:Parameter Name="TokenAttributi" Type="String"></asp:Parameter>
            <asp:Parameter Name="TokenTipoAttributi" Type="String"></asp:Parameter>
            <asp:Parameter Name="GiorniRichiesti" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="GiorniRichiestiFlag" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="AttributesList" Type="String"></asp:Parameter>
            <asp:Parameter Name="UrlImmagineSlide" Type="String"></asp:Parameter>

            <asp:Parameter Name="Confezione" Type="String"></asp:Parameter>
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Cod" Name="ProductCod"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="Giorni_Sql" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT TextField, ValueField FROM PRT_DropDown_Elementi_View WHERE (CodFamilyFilter = 'RmShopGiorniGest')"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Categorie_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT SHP_Category.CategoryID, SHP_Category.DisplayName, SHP_Category.NameRw, SHP_Category.ShortDescription, SHP_Category.Description, SHP_Category.ParentCategoryID, SHP_Category.LevelCategory, SHP_Category.PictureID, SHP_Category.TitPiccoloBoxHomeP, SHP_Category.TitGrandeBoxHomeP, SHP_Category.ShowOnHomePage, SHP_Category.Published, SHP_Category.Deleted, SHP_Category.DisplayOrder, SHP_Category.CreatedOn, SHP_Category.UpdatedOn, SHP_Category.Locked, SHP_Category.MetaKeywords, SHP_Category.MetaDescription, SHP_Category.MetaTitle, ISNULL(derivedtbl_1.ProductID, 0) AS Flag FROM SHP_Category LEFT OUTER JOIN (SELECT ProductCategoryID, ProductID, CategoryID, IsFeaturedProduct, DisplayOrder FROM SHP_Product_Category_Mapping WHERE (ProductID = (SELECT ProductID FROM SHP_Product WHERE (ProductCod = @Cod)))) AS derivedtbl_1 ON SHP_Category.CategoryID = derivedtbl_1.CategoryID"
        InsertCommand="SHP_ArtVsCat_Ins" InsertCommandType="StoredProcedure" DeleteCommand="SHP_ArtVsCat_Delete" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ProductCod" Type="String"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ProductCod" Type="String"></asp:Parameter>
            <asp:Parameter Name="IDCategoria" Type="Int32"></asp:Parameter>
        </InsertParameters>

        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Cod" Name="Cod" DefaultValue="0"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
