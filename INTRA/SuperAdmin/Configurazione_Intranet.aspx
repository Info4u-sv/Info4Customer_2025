<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configurazione_Intranet.aspx.cs" Inherits="INTRA.SuperAdmin.Configurazione_Intranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var uploadInProgress = false,
            submitInitiated = false,
            uploadErrorOccurred = false;
        actualTokenBox = "";
        uploadedFiles = [];

        var GlobalSortField;

        function onFileUploadComplete(s, e) {
            var callbackData = e.callbackData.split("|"),
                uploadedFileName = callbackData[0],
                isSubmissionExpired = callbackData[1] === "True";
            actualTokenBox = callbackData[2];
            var UploadToken = eval(actualTokenBox);
            uploadedFiles.push(uploadedFileName);
            if (e.errorText.length > 0 || !e.isValid)
                uploadErrorOccurred = true;
            if (isSubmissionExpired && UploadToken.GetText().length > 0) {
                var removedAfterTimeoutFiles = UploadToken.GetTokenCollection().join("\n");
                alert("The following files have been removed from the server due to the defined 5 minute timeout: \n\n" + removedAfterTimeoutFiles);
                UploadToken.ClearTokenCollection();
            }
        }

        function onFileUploadStart(s, e) {
            uploadInProgress = true;
            uploadErrorOccurred = false;
            ArticoloImg_Token.SetIsValid(true);
            ArticoloImg_Token.ClearTokenCollection();
            ArticoloImg_Token.SetText('');
        }

        function onFilesUploadComplete(s, e) {
            uploadInProgress = false;

            var UploadToken = eval(actualTokenBox);
            for (var i = 0; i < uploadedFiles.length; i++)
                UploadToken.AddToken(uploadedFiles[i]);

            var type = actualTokenBox != "ArticoloImg_Token" ? "slide" : "imgArt";
            var externalDropZone = actualTokenBox != "ArticoloImg_Token" ? "dropZone_slide" : "dropZone_Art";

            console.log("actualTokenBox " + actualTokenBox + "; type " + type + "; externalDropZone " + externalDropZone);
            uploadedFiles = [];
            if (submitInitiated) {
                SubmitButton.SetEnabled(true);
                SubmitButton.DoClick();
            }
        }

        function showPreview(url_img, type, externalDropZoneId) { // type = slide oppure imgArt

            var txt_dropZone = document.getElementById("txt_dropZone_" + type);
            var img_prewiew_slide = document.getElementById("img_prewiew_" + type);
            var externalDropZone = document.getElementById(externalDropZoneId);
            console.log(externalDropZone);
            txt_dropZone.classList.add("hide");

            img_prewiew_slide.classList.remove("hide");
            img_prewiew_slide.src = "../public/Test/" + url_img;
            img_prewiew_slide.style.left = (externalDropZone.clientWidth - uploadedImage.width) / 2 + "px";
            img_prewiew_slide.style.top = (externalDropZone.clientHeight - uploadedImage.height) / 2 + "px";
            externalDropZone.classList.add("no-padding");
        }
        function hidePreview(type, externalDropZoneId) {
            var txt_dropZone = document.getElementById("txt_dropZone_" + type);
            var img_prewiew_slide = document.getElementById("img_prewiew_" + type);
            var externalDropZone = document.getElementById(externalDropZoneId);
            txt_dropZone.classList.remove("hide");
            img_prewiew_slide.classList.add("hide");
            externalDropZone.classList.remove("no-padding");

        }
        function checkPreview(tokenCollection, type, externalDropZoneId) {
            if (tokenCollection.length > 0) {
                var img_prewiew_slide = document.getElementById("img_prewiew_" + type);
                img_prewiew_slide.src = "../public/Test/" + tokenCollection[tokenCollection.length - 1];
            } else {
                hidePreview(type, externalDropZoneId);
            }
        }

    </script>


    <dx:ASPxHiddenField runat="server" ID="HfFile_Articolo" ClientInstanceName="HfFile_Articolo"></dx:ASPxHiddenField>

    <div class="row">
        <div class="card">
            <div class="card-header card-header-icon" data-background-color="blue">
                <i class="material-icons">format_list_bulleted</i>
            </div>
            <div class="card-content">
                <h4 class="card-title">Parametri Intranet</h4>

                <div class="col-md-6 col-lg-6" style="padding: 0 !important; margin: 0 !important">
                    <%--<div class="card">
                        <div class="card-header">
                            <div class="card-content">
                                <h4 class="card-title">Modello avvio</h4>
                                <dx:ASPxCallbackPanel runat="server" ID="ModelloAvvio_CallbackPnl" ClientInstanceName="ModelloAvvio_CallbackPnl" OnCallback="ModelloAvvio_CallbackPnl_Callback">
                                    <ClientSideEvents EndCallback="OnModelloAvvio_CallbackPnlEndCallback" />
                                    <PanelCollection>
                                        <dx:PanelContent>
                                            <dx:ASPxLabel runat="server" ID="ModAvvioLbl" Text="Abilita visualizzazione per: "></dx:ASPxLabel>

                                            <dx:BootstrapButton runat="server" Text="" ID="ModAvvioClientiBtn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                                                <Badge Text="Clienti" />
                                                <SettingsBootstrap RenderOption="Success" />
                                                <ClientSideEvents Click="function(s,e){ModelloAvvio_CallbackPnl.PerformCallback('Clienti');}" />
                                            </dx:BootstrapButton>
                                            <dx:BootstrapButton runat="server" Text="" ID="ModAvvioImpiantiBtn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                                                <Badge Text="Impianti" />
                                                <SettingsBootstrap RenderOption="Success" />
                                                <ClientSideEvents Click="function(s,e){ModelloAvvio_CallbackPnl.PerformCallback('Impianti');}" />
                                            </dx:BootstrapButton>
                                            <dx:BootstrapButton runat="server" Text="" ID="ModAvvioImpiantiAscensoristiBtn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                                                <Badge Text="Impianti per ascensoristi" />
                                                <SettingsBootstrap RenderOption="Success" />
                                                <ClientSideEvents Click="function(s,e){ModelloAvvio_CallbackPnl.PerformCallback('Ascensoristi');}" />
                                            </dx:BootstrapButton>

                                            <dx:ASPxGridView runat="server" ID="ModelloAvvioGrid" DataSourceID="ModelloAvvioDts" AutoGenerateColumns="False" KeyFieldName="CodParam" ClientInstanceName="ModelloAvvioGrid">
                                                <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                <Toolbars>
                                                    <dx:GridViewToolbar>
                                                        <Items>
                                                            <dx:GridViewToolbarItem Alignment="left">
                                                                <Template>
                                                                    <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                                                        <Buttons>
                                                                            <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                                        </Buttons>
                                                                    </dx:ASPxButtonEdit>
                                                                </Template>
                                                            </dx:GridViewToolbarItem>
                                                            <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                                        </Items>
                                                    </dx:GridViewToolbar>
                                                </Toolbars>

                                                <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                                                <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup>
                                                <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Clienti" />

                                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

                                                <Settings ShowFilterRow="True"></Settings>

                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CodParam" ReadOnly="True" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridView>

                                            <dx:ASPxGridView runat="server" ID="TypeCustomGrid" ClientInstanceName="TypeCustomGrid" AutoGenerateColumns="False" DataSourceID="TypeCustomDts" KeyFieldName="ID">
                                                <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'CANCELEDIT' || e.command == 'DELETEROW'){ModelloAvvioGrid.Refresh();}}" />

                                                <Settings ShowFilterRow="True" />
                                                <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>


                                                <Toolbars>
                                                    <dx:GridViewToolbar>
                                                        <Items>
                                                            <dx:GridViewToolbarItem Alignment="left">
                                                                <Template>
                                                                    <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                                                        <Buttons>
                                                                            <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                                        </Buttons>
                                                                    </dx:ASPxButtonEdit>
                                                                </Template>
                                                            </dx:GridViewToolbarItem>
                                                            <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                                        </Items>
                                                    </dx:GridViewToolbar>
                                                </Toolbars>

                                                <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                                                <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup>
                                                <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Clienti" />

                                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

                                                <SettingsCommandButton>
                                                    <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                                    </ClearFilterButton>
                                                    <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
                                                    </EditButton>
                                                    <DeleteButton RenderMode="Button" Image-ToolTip="Elimina" Text="Elimina" Styles-CssPostfix="hidebtn">
                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn delete icon4u icon-delete image"></Styles>
                                                    </DeleteButton>
                                                    <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                                                    </UpdateButton>
                                                    <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                                                    </CancelButton>
                                                    <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                                                    </NewButton>
                                                    <SelectButton RenderMode="Button" Image-ToolTip="Seleziona" Text="Seleziona" Styles-CssPostfix="hidebtn">
                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                                                    </SelectButton>
                                                </SettingsCommandButton>
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="True"></dx:GridViewCommandColumn>
                                                    <dx:BootstrapGridViewTextColumn FieldName="ID" Visible="false"></dx:BootstrapGridViewTextColumn>
                                                    <dx:BootstrapGridViewComboBoxColumn FieldName="Tipo" VisibleIndex="1">
                                                        <PropertiesComboBox DataSourceID="ElementiDts" TextField="ValueField" ValueField="ValueField" ValueType="System.String"></PropertiesComboBox>
                                                    </dx:BootstrapGridViewComboBoxColumn>
                                                    <dx:BootstrapGridViewComboBoxColumn FieldName="Parametro" VisibleIndex="2">
                                                        <PropertiesComboBox DataSourceID="ParametriDts" TextField="CodParam" ValueField="CodParam" ValueType="System.String"></PropertiesComboBox>
                                                    </dx:BootstrapGridViewComboBoxColumn>
                                                    <dx:BootstrapGridViewComboBoxColumn FieldName="Valore" VisibleIndex="3">
                                                        <PropertiesComboBox>
                                                            <Items>
                                                                <dx:BootstrapListEditItem Value="True"></dx:BootstrapListEditItem>
                                                                <dx:BootstrapListEditItem Value="False"></dx:BootstrapListEditItem>
                                                            </Items>
                                                        </PropertiesComboBox>
                                                    </dx:BootstrapGridViewComboBoxColumn>
                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                        </div>
                    </div>--%>
                    <div class="card">
                        <div class="card-header">
                            <div class="card-content">
                                <h4 class="card-title">Upload file</h4>
                            </div>
                            <div class="col-md-12" style="padding: 10px;">
                                <dx:ASPxComboBox ID="Nome_File_Cb" ClientInstanceName="Nome_File_Cb" runat="server" Caption="Scegli file:"></dx:ASPxComboBox>
                            </div>
                            <div class="col-md-12" id="dropZone_Art" style="border: 1px dashed #f17f21!important;">
                                <span id="txt_dropZone_imgArt" style="color: #f17f21;" font-weight: bolder; font-size:"medium">Trascina qui l'immagine da caricare</span>
                                <img id="img_prewiew_imgArt" src="#" class="img-preview hide" />
                            </div>
                            <div></div>
                            <div class="col-md-12">
                                <dx:ASPxUploadControl runat="server" DialogTriggerID="dropZone_Art" ID="ArticoloImg_UploadControl" ClientInstanceName="ArticoloImg_UploadControl"
                                    AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Aggiungi Documenti" FileUploadMode="OnPageLoad"
                                    OnFileUploadComplete="ArticoloImg_UploadControl_FileUploadComplete" Theme="SoftOrange" AdvancedModeSettings-EnableFileList="true" Width="100%">
                                    <BrowseButton Text="Aggiungi Documenti">
                                    </BrowseButton>
                                    <AdvancedModeSettings
                                        EnableMultiSelect="True" EnableDragAndDrop="true" ExternalDropZoneID="dropZone_Art">
                                    </AdvancedModeSettings>
                                    <ValidationSettings MaxFileCount="1" MaxFileSize="9999999999" AllowedFileExtensions=".jpg, .tif">
                                    </ValidationSettings>
                                    <ClientSideEvents
                                        FileUploadComplete="onFileUploadComplete"
                                        FilesUploadComplete="onFilesUploadComplete"
                                        FilesUploadStart="onFileUploadStart" />
                                    <DropZoneStyle Border-BorderColor="White" Border-BorderStyle="None">
                                    </DropZoneStyle>
                                </dx:ASPxUploadControl>
                            </div>

                            <div class="col-md-12" style="padding-top: 5px;">
                                <dx:ASPxTokenBox runat="server" Width="100%" ID="ArticoloImg_Token" ClientInstanceName="ArticoloImg_Token" NullText="Select the documents to submit" AllowCustomTokens="false" ClientVisible="true">
                                    <ClientSideEvents TokensChanged="function(s,e){
                                                                                        console.log('SHPPictureSlideUno_Token conteggio token' + s.GetTokenCollection().length);
                                                                                    checkPreview(s.GetTokenCollection(),'imgArt','dropZone_Art');
                                                                                    }" />

                                </dx:ASPxTokenBox>

                                <dx:ASPxCallbackPanel runat="server" ID="uploadCallBackPanel" ClientInstanceName="uploadCallBackPanel" OnCallback="uploadCallBackPanel_Callback">
                                    <ClientSideEvents EndCallback="function(s,e){

                                    
                                                showPreview(ArticoloImg_Token.GetTokenCollection()[0], 'imgArt', 'dropZone_Art');
}" />

                                </dx:ASPxCallbackPanel>

                                <dx:BootstrapButton runat="server" Text="" ID="SalvaImmagini" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                                    <Badge IconCssClass="fa fa-check" Text="Salva" />
                                    <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                    <ClientSideEvents Click="function(s,e){uploadCallBackPanel.PerformCallback();}" />
                                </dx:BootstrapButton>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Loghi</h4>
                        </div>
                        <h4 class="card-title">Principali</h4>
                        <div class="col-md-12" style="background-color: black">
                            <div class="col-md-6 col-lg-6" style="background-color: black; min-height: 60px">
                                <img src="../assets/img_customer/brand-logo.png" class="PhotoHeader" style="width: 45px; height: 45px; margin-top: 10px" />
                            </div>
                            <div class="col-md-6 col-lg-6" style="background-color: black; min-height: 60px">
                                <img src="../assets/img_customer/logo.png" style="height: 35px; width: auto" />
                            </div>
                        </div>
                        <h4 class="card-title">logo-esteso-login.png</h4>

                        <img src="../assets/img_customer/logo-esteso-login.png" style="max-width: 400px; height: auto" />

                        <img rel="apple-touch-icon" sizes="76x76" src="../assets/img_customer/apple-icon.png" style="height: 76px; width: auto" />
                        <img rel="apple-touch-icon" sizes="76x76" src="../assets/img_customer/favicon.png" style="height: 76px; width: auto" />
                        <img src="../assets/img_customer/brand-logo-report.jpg"/>
                        <img src="../assets/img_customer/logo-email.png" />
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Colori</h4>

                            <dx:ASPxCallbackPanel runat="server" ID="ColorContainer_Pnl" ClientInstanceName="ColorContainer_Pnl" OnCallback="ColorContainer_Pnl_Callback">
                                <ClientSideEvents EndCallback="OnColorContainer_PnlEndCallback" />
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxPanel runat="server" ID="container"></dx:ASPxPanel>


                                    </dx:PanelContent>
                                </PanelCollection>

                            </dx:ASPxCallbackPanel>
                            <dx:BootstrapButton runat="server" Text="" ID="NewColorBtn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                                <Badge IconCssClass="fa fa-check" Text="Salva" />
                                <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                <ClientSideEvents Click="function(s,e){ColorContainer_Pnl.PerformCallback();}" />
                            </dx:BootstrapButton>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="ModelloAvvioDts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT LFT_Parameter.CodParam, LFT_Parameter.Descrizione, LFT_Parameter.Value
FROM LFT_Check4uTypeCustom, LFT_Parameter
WHERE LFT_Check4uTypeCustom.Parametro = LFT_Parameter.CodParam OR LFT_Parameter.CodParam = 'Check4uModel'
GROUP BY LFT_Parameter.CodParam, LFT_Parameter.Descrizione, LFT_Parameter.Value"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="TypeCustomDts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, Tipo, Parametro, Valore FROM LFT_Check4uTypeCustom ORDER BY Tipo ASC"
        InsertCommand="INSERT INTO LFT_Check4uTypeCustom(Tipo, Parametro, Valore) VALUES (@Tipo, @Parametro, @Valore)" UpdateCommand="LFT_Check4uTypeCustom_Update" DeleteCommand="DELETE FROM LFT_Check4uTypeCustom WHERE (ID = @ID)" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Tipo"></asp:Parameter>
            <asp:Parameter Name="Parametro"></asp:Parameter>
            <asp:Parameter Name="Valore"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Tipo"></asp:Parameter>
            <asp:Parameter Name="Parametro"></asp:Parameter>
            <asp:Parameter Name="Valore"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="ElementiDts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ValueField FROM PRT_DropDown_Elementi WHERE (DropDown_Famiglia = 20)"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="ParametriDts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT CodParam FROM LFT_Parameter"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    
    <script>


        function OnColorchanged(s, e) {
            ColorGest_callback.PerformCallback('SaveColor');
        }

        function OnColorContainer_PnlEndCallback(s, e) {
            showNotification();
        }

        function OnModelloAvvio_CallbackPnlEndCallback(s, e) {
            ModelloAvvioGrid.Refresh();
            TypeCustomGrid.Refresh();
        }

    </script>
</asp:Content>
