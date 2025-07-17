<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorie_Crud.aspx.cs" Inherits="INTRA.Catalogo.Categorie_Crud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .ps-container .ps-scrollbar-y-rail {
            display: block !important;
        }

        .card-footer {
            margin-top: 24px !important;
        }
    </style>
    <link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <%--    <link href="/_Icon_picker_1/simple-iconpicker.min.css" rel='stylesheet' type='text/css' />--%>
    <dx:ASPxHiddenField runat="server" ID="HfFile" ClientInstanceName="HfFile"></dx:ASPxHiddenField>

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
            UploadedFilesTokenBox.SetText('');
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
        var keyValue;
        function OnMoreInfoClick(element, key) {
            Anteprima_CallbackPnl.SetContentHtml("");
            Anteprima_Popup.Show();
            keyValue = key;
        }
        function popup_Shown(s, e) {
            Anteprima_CallbackPnl.PerformCallback(keyValue);
        }
    </script>
    <style>
        .hover {
            background-color: lightblue;
        }

        .activeHover {
            background-color: lightgray;
        }

        .ui-draggable-dragging {
            background-color: lightgreen;
            color: White;
        }

        .dxgvControl_Office365 .dxgvTable_Office365 .dxgvFocusedRow_Office365, .dxgvControl_Office365 .dxgvTable_Office365 .dxgvFocusedRow_Office365.dxgvDataRowHover_Office365 {
            background-color: lightsalmon;
        }
    </style>
    <script type="text/javascript">
        function tlData_Init(s, e) {

            if (e.command === 'StartEditNewNode') {
                if (Value) {
                    Set_Cmb.SetValue(Value);
                    Set_Cmb.SetEnabled(false);
                    Value = null;
                } else {
                    CreaSession_cb.PerformCallback(`IsPadre|1|Set_Cmb`);
                    Set_Cmb.SetEnabled(true);
                    CatM_Cmb.SetValue('000');
                    CatM_Cmb.SetEnabled(false);
                }
            }
            if (e.command === 'UpdateEdit' || e.command === "DeleteNode") {
                showNotification();
            }
            //btMoveUp.SetEnabled(s.cpbtMoveUp_Enabled);
            //btMoveDown.SetEnabled(s.cpbtMoveDown_Enabled);
        }

        function tlData_StartDragNode(s, e) {
            var nodeKeys = s.GetVisibleNodeKeys();
            e.targets.length = 0;
            for (var i = 0; i < nodeKeys.length; i++) {
                if (s.GetNodeHtmlElement(nodeKeys[i]).getAttribute("nodeParent") == s.GetNodeHtmlElement(e.nodeKey).getAttribute("nodeParent")) {
                    e.targets.push(s.GetNodeHtmlElement(nodeKeys[i]));
                }
            }
        }

        function tlData_EndDragNode(s, e) {
            var nodeKeys = s.GetVisibleNodeKeys();
            for (var i = 0; i < nodeKeys.length; i++) {
                if (s.GetNodeHtmlElement(nodeKeys[i]) == e.targetElement) {
                    s.PerformCallback("DRAGNODE" + e.nodeKey + "|" + nodeKeys[i]);
                    return;
                }
            }

            e.cancel = true;
        }

        function btMoveUp_Click(s, e) {
            TreeListMenu.PerformCallback("MOVEUP");
        }

        function btMoveDown_Click(s, e) {
            TreeListMenu.PerformCallback("MOVEDOWN");
        }

        var Value = null;
        function OnCustomButtonClick(s, e) {

            s.GetNodeValues(e.nodeKey, ["Settore", "CategoryID"], function (value) {
                Value = value[0];
                CreaSession_cb.PerformCallback(`IsPadre|0|Set_Cmb`);
                CreaSession_cb.PerformCallback(`ParentID|${value[1]}|NULL`);
            });
            s.StartEditNewNode();
        }
    </script>

    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Gestione categorie</h4>


                    <%--  <table>
                        <tr>
                            <td valign="bottom">
                                <dx:ASPxButton ID="btMoveUp" runat="server" Text="Move Up" Width="100%" AutoPostBack="false">
                                    <ClientSideEvents Click="btMoveUp_Click" />
                                </dx:ASPxButton>
                            </td>
                    
                            <td valign="top">
                                <dx:ASPxButton ID="btMoveDown" runat="server" Text="Move Down" Width="100%" AutoPostBack="false">
                                    <ClientSideEvents Click="btMoveDown_Click" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="2" width="80%">--%>


                    <dx:ASPxTreeList ID="TreeListMenu" ClientInstanceName="TreeListMenu" SettingsBehavior-AllowFocusedNode="true" SettingsEditing-ConfirmDelete="true" SettingsText-ConfirmDelete="Confermi di voler eliminare questa categoria?" EnableViewState="False" runat="server" AutoGenerateColumns="False" DataSourceID="Generic_SqlDataSource" KeyFieldName="CategoryID" ParentFieldName="ParentCategoryID" Style="margin-top: 0px" OnNodeInserting="TreeListMenu_NodeInserting" OnNodeUpdating="TreeListMenu_NodeUpdating" OnCommandColumnButtonInitialize="TreeListMenu_CommandColumnButtonInitialize" OnStartNodeEditing="TreeListMenu_StartNodeEditing" OnCellEditorInitialize="TreeListMenu_CellEditorInitialize" OnDataBound="TreeListMenu_DataBound" OnCustomJSProperties="TreeListMenu_CustomJSProperties" OnLoad="TreeListMenu_Load" OnDataBinding="TreeListMenu_DataBinding" OnHtmlRowPrepared="TreeListMenu_HtmlRowPrepared" OnCustomCallback="TreeListMenu_CustomCallback" OnInitNewNode="TreeListMenu_InitNewNode">
                        <ClientSideEvents Init="tlData_Init" EndCallback="tlData_Init" EndDragNode="tlData_EndDragNode"
                            StartDragNode="tlData_StartDragNode" />
                        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="2"></SettingsEditing>
                        <SettingsPopup EditForm-Caption="Modifica categoria" CustomizationWindow-AutoUpdatePosition="true" EditForm-HorizontalAlign="WindowCenter" EditForm-VerticalAlign="WindowCenter" EditForm-Width="1000px"></SettingsPopup>
                        <Styles>
                            <AlternatingNode BackColor="#f0f0f0" Enabled="True"></AlternatingNode>
                            <Header Wrap="True"></Header>
                        </Styles>
                        <Toolbars>
                            <dx:TreeListToolbar>
                                <Items>
                                    <dx:TreeListToolbarItem Alignment="left">
                                        <Template>
                                            <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%">
                                                <Buttons>
                                                    <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                </Buttons>
                                            </dx:ASPxButtonEdit>
                                        </Template>
                                    </dx:TreeListToolbarItem>
                                    <dx:TreeListToolbarItem Command="ExportToXlsx" Text="Esporta" />

                                </Items>
                            </dx:TreeListToolbar>

                        </Toolbars>
                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <SettingsExport EnableClientSideExportAPI="true" FileName="Lista" />
                        <SettingsEditing AllowNodeDragDrop="True" />
                        <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                        <Columns>
                            <dx:TreeListTextColumn FieldName="PictureID" VisibleIndex="0" ReadOnly="true" Visible="false">
                            </dx:TreeListTextColumn>
                            <dx:TreeListTextColumn FieldName="DisplayName" VisibleIndex="0">
                                <EditFormSettings CaptionLocation="Top" />
                                <PropertiesTextEdit>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" RequiredField-IsRequired="true"></ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:TreeListTextColumn>
                            <dx:TreeListTextColumn FieldName="TitPiccoloBoxHomeP" VisibleIndex="0">

                                <EditFormSettings CaptionLocation="Top" />
                                <PropertiesTextEdit>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" RequiredField-IsRequired="true"></ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:TreeListTextColumn>
                            <dx:TreeListTextColumn FieldName="TitGrandeBoxHomeP" VisibleIndex="0">
                                <EditFormSettings CaptionLocation="Top" />
                                <PropertiesTextEdit>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" RequiredField-IsRequired="true"></ValidationSettings>
                                </PropertiesTextEdit>

                                <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true"></PropertiesTextEdit>
                            </dx:TreeListTextColumn>

                            <dx:TreeListDataColumn FieldName="Description" AllowEllipsisInText="True" VisibleIndex="1" Caption="Descrizione">
                                <EditFormSettings CaptionLocation="Top" />
                                <EditFormSettings VisibleIndex="10" />
                                <EditCellTemplate>
                                    <dx:ASPxHtmlEditor runat="server" ID="Description_Html" Html='<%# Bind("Description") %>' Width="100%" SettingsValidation-RequiredField-IsRequired="true" SettingsValidation-ValidationGroup='<% Container.ValidationGroup %>'></dx:ASPxHtmlEditor>
                                </EditCellTemplate>
                            </dx:TreeListDataColumn>
                            <dx:TreeListDataColumn FieldName="PathImmagine" Caption="Immagine" VisibleIndex="2" Width="80px">
                                <EditFormSettings CaptionLocation="Top" VisibleIndex="11" />
                                <%--<DataCellTemplate>
                                    <dx:ASPxImage runat="server" ID="ImmagineCat_Image" ImageUrl='<%# Eval("PathImmagine") %>' Width="100px"></dx:ASPxImage>
                                </DataCellTemplate>--%>
                                <DataCellTemplate>
                                    <span style='display: <%# Eval("PathImmagine")==DBNull.Value ? "none" : "inline" %>'><a href="javascript:void(0);" onclick="OnMoreInfoClick(this, '<%# Container.NodeKey %>')"><i class="fa fa-search"></i></a></span>
                                </DataCellTemplate>
                            </dx:TreeListDataColumn>
                            <dx:TreeListCheckColumn FieldName="Published" VisibleIndex="2" HeaderStyle-HorizontalAlign="Center" Caption="Pubblicata">
                                <EditFormSettings CaptionLocation="Top" />
                            </dx:TreeListCheckColumn>
                            <dx:TreeListCheckColumn FieldName="ShowOnHomePage" VisibleIndex="2" HeaderStyle-HorizontalAlign="Center" Caption="Mostra in HomePage">
                                <EditFormSettings CaptionLocation="Top" />
                            </dx:TreeListCheckColumn>
                            <dx:TreeListCheckColumn FieldName="Settore" VisibleIndex="2" Visible="false">
                                <EditFormSettings CaptionLocation="Top" />
                            </dx:TreeListCheckColumn>
                            <dx:TreeListCheckColumn FieldName="CatM" VisibleIndex="2" Visible="false">
                                <EditFormSettings CaptionLocation="Top" />
                            </dx:TreeListCheckColumn>

                            <dx:TreeListDataColumn FieldName="DisplayOrder" Width="0" Caption="." VisibleIndex="2" Visible="false">
                            </dx:TreeListDataColumn>


                            <dx:TreeListCommandColumn VisibleIndex="4" ShowNewButtonInHeader="True">
                                <EditButton Visible="True" Text=" ">
                                    <Image Width="30" Url="../img/DevExButton/edit.png"></Image>
                                </EditButton>
                                <NewButton Visible="false" Text=" ">
                                    <Image Width="30" Url="../img/DevExButton/new.png"></Image>
                                </NewButton>
                                <DeleteButton Visible="True" Text=" ">
                                    <Image Width="30" Url="../img/DevExButton/delete.png"></Image>
                                </DeleteButton>
                                <UpdateButton Visible="true" Text=" ">
                                    <Image Width="30" Url="../img/DevExButton/save.png"></Image>
                                </UpdateButton>
                                <CancelButton Visible="true" Text=" ">
                                    <Image Width="30" Url="../img/DevExButton/cancel.png"></Image>
                                </CancelButton>
                                <CustomButtons>
                                    <dx:TreeListCommandColumnCustomButton ID="NewCustom" Text=" " Visibility="AllNodes">
                                        <Image Width="30" Url="../img/DevExButton/new.png"></Image>
                                    </dx:TreeListCommandColumnCustomButton>
                                </CustomButtons>
                            </dx:TreeListCommandColumn>

                        </Columns>
                        <Templates>
                            <EditForm>
                                <div class="row" style="padding: 10px">
                                    <div class="col-lg-12">
                                        <div class="col-lg-3">
                                            Display Name:
                                            <dx:ASPxTextBox ID="DisplayName_Edit" runat="server" Width="100%" Value='<%#Bind("DisplayName") %>' Caption="" CaptionSettings-Position="Top">
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </div>

                                        <div class="col-lg-3">
                                            Titolo piccolo box home:
                                            <dx:ASPxTextBox ID="TitPiccoloBoxHomeP_Edit" runat="server" Width="100%" Value='<%#Bind("TitPiccoloBoxHomeP") %>' CaptionSettings-Position="Top">
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </div>
                                        <div class="col-lg-3">
                                            Titolo grande box home:
                                            <dx:ASPxTextBox ID="TitGrandeBoxHomeP_Edit" runat="server" Width="100%" Value='<%#Bind("TitGrandeBoxHomeP") %>' CaptionSettings-Position="Top">
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </div>
                                        <div class="col-lg-3">
                                            Tipo catalogo:
                                            <dx:ASPxComboBox runat="server" ID="TipoCatalogo_Combobox" DataSourceID="CatalogoTipo_Sql" ValueField="ValueField" TextField="Descrizione" ValueType="System.Int32" SelectedIndex="2" Width="100%" ClientEnabled="false">
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </div>

                                    </div>
                                    <div class="col-lg-12">

                                        <div class="col-lg-3">
                                            Pubblica:
                                            
                                        <dx:ASPxCheckBox ID="Published_Edit" runat="server" Width="100%" Value='<%#Bind("Published") %>'>
                                        </dx:ASPxCheckBox>
                                        </div>
                                        <div class="col-lg-3">
                                            Visualizza Nella Home:
                                        <dx:ASPxCheckBox ID="ShowOnHomePage_Edit" runat="server" Width="100%" Value='<%#Bind("ShowOnHomePage") %>'>
                                        </dx:ASPxCheckBox>
                                        </div>
                                        <div class="col-lg-3">
                                            Settore:
                                            <%--<dx:ASPxTextBox ID="Settore_Txt" runat="server" Width="100%" Value='<%#Bind("Settore") %>' CaptionSettings-Position="Top">
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>--%>
                                            <dx:ASPxComboBox runat="server" ID="Set_Cmb" ClientInstanceName="Set_Cmb" DataSourceID="Settori_Dts" ValueField="CodSet" TextField="Descrizione" ValueType="System.String" Width="100%" Value='<%#Bind("Settore") %>'>
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                                <%--<ClientSideEvents SelectedIndexChanged="function(s,e){CreaSession_cb.PerformCallback(`Settore|${s.GetValue()}|Set_Cmb`);}"/>--%>
                                            </dx:ASPxComboBox>
                                        </div>
                                        <div class="col-lg-3">
                                            Categoria Merceologica:
                                            <%--<dx:ASPxTextBox ID="CatM_Txt" runat="server" Width="100%" Value='<%#Bind("CatM") %>' CaptionSettings-Position="Top">
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>--%>
                                            <dx:ASPxComboBox runat="server" ID="CatM_Cmb" ClientInstanceName="CatM_Cmb" DataSourceID="Categorie_Dts" ValueField="CodCat" TextField="Descrizione" Width="100%" Value='<%#Bind("CatM") %>'>
                                                <ValidationSettings ValidationGroup="TreeEditForm" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </div>


                                    </div>
                                    <div class="col-lg-12" style="padding-top: 20px">

                                        <div class="col-lg-8">

                                            <dx:ASPxHtmlEditor runat="server" ID="Description_Html" Caption="Display Name" CaptionSettings-Position="Top" Html='<%# Bind("Description") %>' Settings-AllowHtmlView="false" Settings-AllowPreview="false" Width="100%" SettingsValidation-RequiredField-IsRequired="true" SettingsValidation-ValidationGroup='<% Container.ValidationGroup %>'>
                                            </dx:ASPxHtmlEditor>
                                        </div>
                                        <div class="col-lg-4">

                                            <div class="col-lg-12" style="padding-top: 20px">
                                                <div id="dropZone">
                                                    <dx:ASPxUploadControl runat="server" ID="DocumentsUploadControl" ClientInstanceName="DocumentsUploadControl"
                                                        AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Aggiungi Documenti" FileUploadMode="OnPageLoad"
                                                        OnFileUploadComplete="DocumentsUploadControl_FileUploadComplete" Theme="SoftOrange" AdvancedModeSettings-EnableFileList="true" Width="100%">
                                                        <BrowseButton Text="Aggiungi Documenti">
                                                        </BrowseButton>
                                                        <AdvancedModeSettings
                                                            EnableMultiSelect="True" EnableDragAndDrop="true" ExternalDropZoneID="dropZone">
                                                        </AdvancedModeSettings>
                                                        <ValidationSettings MaxFileCount="1" MaxFileSize="9999999999" AllowedFileExtensions=".jpg, .tif, .png">
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
                                                        <dx:ASPxImage runat="server" ID="ImmagineCaricata_Img" Value='<%# Eval("PathImmagine") %>'></dx:ASPxImage>
                                                    </div>
                                                    <br />
                                                    <dx:ASPxValidationSummary runat="server" ID="ValidationSummary" ClientInstanceName="ValidationSummary"
                                                        RenderMode="Table" Width="50%" ShowErrorAsLink="false">
                                                    </dx:ASPxValidationSummary>
                                                </div>
                                            </div>
                                            <div style="float: right; padding-top: 30px !important">
                                                <a href="javascript: UpdateTreelist();">
                                                    <img src="../img/DevExButton/save.png" style="width: 30px !important" /></a>
                                                <dx:ASPxTreeListTemplateReplacement ID="ASPxGridViewTemplateReplacement1" ReplacementType="CancelButton" runat="server"></dx:ASPxTreeListTemplateReplacement>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </EditForm>
                        </Templates>
                        <SettingsBehavior AllowFocusedNode="True" AutoExpandAllNodes="True" />
                        <SettingsSelection Enabled="false" />
                    </dx:ASPxTreeList>
                    <%--        </td>
                        </tr>
                    </table>--%>
                    <script>
                        function UpdateTreelist() {
                            if (ASPxClientEdit.ValidateGroup("TreeEditForm")) {
                                TreeListMenu.UpdateEdit();
                            }


                        }
                    </script>

                    <%-- Sezione callback --%>
                    <script>
                        function CreaSessionCallbackComplete(s, e) {
                            if (e.result && e.result != 'NULL') {
                                var element = eval(e.result);
                                if (element) { element.PerformCallback(); }
                            }
                        }
                    </script>

                    <dx:ASPxCallback runat="server" ID="CreaSession_cb" ClientInstanceName="CreaSession_cb" OnCallback="CreaSession_cb_Callback">
                        <ClientSideEvents CallbackComplete="CreaSessionCallbackComplete" />
                    </dx:ASPxCallback>

                    <%-- Sezione data sources --%>
                    <asp:SqlDataSource ID="DisplayOrder_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="select 1" UpdateCommand="UPDATE SHP_Category SET DisplayOrder = @DisplayOrder WHERE (CategoryID = @Id)">
                        <UpdateParameters>
                            <asp:Parameter Name="DisplayOrder"></asp:Parameter>
                            <asp:Parameter Name="Id"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource runat="server" ID="Vincoli_Sql" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT CodVincolo, TextValue FROM RM_VincoliRegistrazioneAna"></asp:SqlDataSource>

                    <asp:SqlDataSource ID="CatalogoTipo_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT RM_CatalogoTipo_View.* FROM RM_CatalogoTipo_View"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="TipoSconto_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT TextField, ValueField FROM [PRT_DropDown_Elementi_View] where CodFamilyFilter = 'RmShopQuotaRidotta' "></asp:SqlDataSource>
                    <asp:SqlDataSource runat="server" ID="AppoggioImg_Sql" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' DeleteCommand="U_SHP_Picture_Delete" SelectCommand="select  1 " DeleteCommandType="StoredProcedure" InsertCommand="U_SHP_Picture_Ins" InsertCommandType="StoredProcedure" OnInserted="AppoggioImg_Sql_Inserted">
                        <DeleteParameters>
                            <asp:Parameter Name="PictureID"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="IDImmagine" Type="Int32" Direction="ReturnValue"></asp:Parameter>
                            <asp:Parameter Name="PathImmagine" Type="String"></asp:Parameter>
                            <asp:Parameter Direction="InputOutput" Name="IDImmagine" Type="Int32"></asp:Parameter>
                        </InsertParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="Generic_SqlDataSource" OnInserted="Generic_SqlDataSource_Inserted" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' DeleteCommand="DELETE FROM U_SHP_Category WHERE (CategoryID = @CategoryID)"
                        InsertCommand="INSERT INTO U_SHP_Category(DisplayName, NameRw, Description, ParentCategoryID, PictureID, Published, TitPiccoloBoxHomeP, TitGrandeBoxHomeP, ShowOnHomePage, LevelCategory, RmCatalogoTipo, Settore, CatM) VALUES (@DisplayName, @NameRw, @Description, @ParentCategoryID, @PictureID, @Published, @TitPiccoloBoxHomeP, @TitGrandeBoxHomeP, @ShowOnHomePage, @LevelCategory, @RmCatalogoTipo, @Settore, @CatM)"
                        SelectCommand="SELECT ISNULL(U_SHP_Category.DisplayOrder, 0) AS DisplayOrder, U_SHP_Category.CategoScontoQuotaRidotta, U_SHP_Category.CategoryID, U_SHP_Category.DisplayName, U_SHP_Category.NameRw, U_SHP_Category.ShortDescription, U_SHP_Category.Description, U_SHP_Category.ParentCategoryID, U_SHP_Category.LevelCategory, U_SHP_Category.TitPiccoloBoxHomeP, U_SHP_Category.TitGrandeBoxHomeP, U_SHP_Category.ShowOnHomePage, U_SHP_Category.Published, U_SHP_Category.Deleted, U_SHP_Category.DisplayOrder AS Expr1, U_SHP_Category.CreatedOn, U_SHP_Category.UpdatedOn, U_SHP_Category.Locked, U_SHP_Category.MetaKeywords, U_SHP_Category.MetaDescription, U_SHP_Category.MetaTitle, U_SHP_Picture.PathImmagine, U_SHP_Category.PictureID, U_SHP_Category.RmCatalogoTipo, U_SHP_Category.RM_VicoliRegistrazioneAna, U_SHP_Category.RM_VincoliAttivi, U_SHP_Category.Settore, U_SHP_Category.CatM FROM U_SHP_Category LEFT OUTER JOIN U_SHP_Picture ON U_SHP_Category.PictureID = U_SHP_Picture.PictureID ORDER BY DisplayOrder"
                        UpdateCommand="UPDATE U_SHP_Category SET DisplayName = @DisplayName, NameRw = @NameRw, Description = @Description, ParentCategoryID = @ParentCategoryID, PictureID = @PictureID, Published = @Published, UpdatedOn = GETDATE(), TitPiccoloBoxHomeP = @TitPiccoloBoxHomeP, TitGrandeBoxHomeP = @TitGrandeBoxHomeP, ShowOnHomePage = @ShowOnHomePage, RmCatalogoTipo = @RmCatalogoTipo, Settore = @Settore, CatM = @CatM WHERE (CategoryID = @CategoryID)">
                        <DeleteParameters>
                            <asp:Parameter Name="CategoryID"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="DisplayName" Type="String" />
                            <asp:Parameter Name="NameRw" Type="String" />
                            <asp:Parameter Name="Description" Type="String" />
                            <asp:Parameter Name="ParentCategoryID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="PictureID" Type="Int32" />
                            <asp:Parameter Name="Published" Type="Boolean"></asp:Parameter>
                            <asp:Parameter Name="TitPiccoloBoxHomeP" Type="String"></asp:Parameter>
                            <asp:Parameter Name="TitGrandeBoxHomeP" Type="String"></asp:Parameter>
                            <asp:Parameter Name="ShowOnHomePage" Type="Boolean"></asp:Parameter>
                            <asp:Parameter Name="LevelCategory" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="RmCatalogoTipo"></asp:Parameter>
                            <asp:Parameter Name="Settore"></asp:Parameter>
                            <asp:Parameter Name="CatM"></asp:Parameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="DisplayName" />
                            <asp:Parameter Name="NameRw" />
                            <asp:Parameter Name="Description" />
                            <asp:Parameter Name="ParentCategoryID"></asp:Parameter>
                            <asp:Parameter Name="PictureID"></asp:Parameter>
                            <asp:Parameter Name="Published"></asp:Parameter>
                            <asp:Parameter Name="TitPiccoloBoxHomeP"></asp:Parameter>
                            <asp:Parameter Name="TitGrandeBoxHomeP"></asp:Parameter>
                            <asp:Parameter Name="ShowOnHomePage"></asp:Parameter>
                            <asp:Parameter Name="RmCatalogoTipo"></asp:Parameter>
                            <asp:Parameter Name="Settore"></asp:Parameter>
                            <asp:Parameter Name="CatM"></asp:Parameter>
                            <asp:Parameter Name="CategoryID"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource runat="server" ID="Settori_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodSet, Descrizione, isPadre FROM (SELECT DISTINCT TabSet.CodSet, TabSet.Descrizione, 1 AS isPadre FROM TabSet LEFT OUTER JOIN U_SHP_Category ON TabSet.CodSet = U_SHP_Category.Settore WHERE (U_SHP_Category.CategoryID IS NULL) UNION SELECT DISTINCT CodSet, Descrizione, 0 AS isPadre FROM TabSet AS TabSet_1) AS Appoggio WHERE (isPadre = @IsPadrea) ORDER BY CodSet">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="IsPadre" Name="IsPadrea"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource runat="server" ID="Categorie_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT TabCatM.CodCat, TabCatM.Descrizione FROM TabCatM LEFT OUTER JOIN U_SHP_Category ON TabCatM.CodCat = U_SHP_Category.CatM WHERE (U_SHP_Category.CategoryID IS NULL)"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
    <%--    <script src="/assets/js/jquery-3.2.1.min.js"></script>--%>
    <script src="/assets/js/bootstrap-notify.js"></script>
    <dx:ASPxPopupControl runat="server" AllowDragging="true" ID="Anteprima_Popup" ClientInstanceName="Anteprima_Popup" Width="400px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" HeaderText="Anteprima Immagine" ScrollBars="Vertical" Height="400px">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl" runat="server">
                <div style="vertical-align: middle">
                    <dx:ASPxCallbackPanel runat="server" ID="Anteprima_CallbackPnl" ClientInstanceName="Anteprima_CallbackPnl" OnCallback="Anteprima_CallbackPnl_Callback">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <dx:ASPxImage runat="server" ID="Cat_Img" ClientInstanceName="Cat_Img" Width="400px"></dx:ASPxImage>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents Shown="popup_Shown" />
    </dx:ASPxPopupControl>

</asp:Content>
