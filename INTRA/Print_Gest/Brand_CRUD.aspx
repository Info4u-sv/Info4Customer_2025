<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Brand_CRUD.aspx.cs" Inherits="INTRA.Print_Gest.Brand_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css' />
    <link href="../ImageCropper_4U/dist/style.css" rel="stylesheet" />
    <style>
        .dxeBinImgEmptySys img, .dxeBinImgPreviewContainerSys img {
            cursor: zoom-in;
        }
        /* The Modal (background) */
        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: black;
        }

        /* Modal Content */
        .modal-content {
            position: relative;
            background-color: #fefefe;
            margin: auto;
            padding: 0;
            width: 90%;
            max-width: 1200px;
        }

        /* The Close Button */
        .close {
            color: white;
            position: absolute;
            top: 10px;
            right: 25px;
            font-size: 35px;
            font-weight: bold;
        }

            .close:hover,
            .close:focus {
                color: #999;
                text-decoration: none;
                cursor: pointer;
            }

        .mySlides {
            display: none;
        }

        .cursor {
            cursor: pointer;
        }

        /* Next & previous buttons */
        .prev,
        .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -50px;
            color: white;
            font-weight: bold;
            font-size: 20px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
            -webkit-user-select: none;
        }

        /* Position the "next button" to the right */
        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }

            /* On hover, add a black background color with a little bit see-through */
            .prev:hover,
            .next:hover {
                background-color: rgba(0, 0, 0, 0.8);
            }

        /* Number text (1/3 etc) */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }

        img {
            margin-bottom: -4px;
        }

        .caption-container {
            text-align: center;
            background-color: black;
            padding: 2px 16px;
            color: white;
        }

        .demo {
            opacity: 0.6;
        }

            .active,
            .demo:hover {
                opacity: 1;
            }

        img.hover-shadow {
            transition: 0.3s;
        }

        .hover-shadow:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        img[class^="dx"] {
            max-width: 1000px !important;
        }

        .tastocss {
            width: 30px !important;
        }

        .w3-black {
            background-color: var(--main-primary-color) !important;
        }

        .thin-txt {
            font-weight: 100 !important;
        }

        .w3-modal.cropper {
            position: fixed !important;
            z-index: 999999 !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100% !important;
            background-color: rgba(0, 0, 0, 0.8) !important;
        }

        .w3-modal-content {
            position: relative !important;
            z-index: 1000000 !important;
            margin: auto !important;
            max-width: 1200px !important;
        }
    </style>
    <style>
        .custom-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            z-index: 9999;
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .hidden {
            opacity: 0;
            pointer-events: none;
            transform: translateY(-20px);
        }

        .toast-icon {
            background-color: white;
            color: #4CAF50;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.2rem;
        }

        .toast-message {
            flex: 1;
            font-weight: 500;
        }

        .toast-close {
            cursor: pointer;
            margin-left: 1rem;
            font-size: 1.2rem;
        }
    </style>
    <div id="custom-toast" class="custom-toast hidden">
        <div class="toast-icon">🔔</div>
        <div class="toast-message">PROCEDURA ESEGUITA CON SUCCESSO!</div>
        <div class="toast-close" onclick="hideToast()">✕</div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Lista Brand</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Brand_Dts" OnRowInserting="Generic_gridview_RowInserting" OnRowUpdating="Generic_gridview_RowUpdating" KeyFieldName="ID" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showSuccessNotification();}}"
                            CustomButtonClick="function(s,e){if(e.buttonID == 'Elimina'){OnGetRowValuesElimina(e.visibleIndex);}}" />
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
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Depositi" />
                        <SettingsCustomizationDialog Enabled="true" />

                        <Settings ShowFilterRow="True"></Settings>
                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
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
                        <SettingsEditing EditFormColumnCount="1" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="True" ShowClearFilterButton="true" Width="60px">
                                <%--                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="StampaRpt" IconCssClass="icon4u icon-print image" CssClass="btn btn-sm btn-custom-padding action-btn print" Text="" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Vai" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" Text="" />
                                </CustomButtons>--%>
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                        </Columns>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" EditFormSettings-Visible="False" Width="80px" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Nome" VisibleIndex="2" Caption="Nome">
                                <EditFormSettings ColumnSpan="1" />
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataBinaryImageColumn FieldName="PhotoBytes" Caption="Immagine" VisibleIndex="3" Width="10%">
                                <EditItemTemplate>
                                    <dx:ASPxBinaryImage ID="Printer_PhotoBytes_Edit" runat="server"
                                        ImageHeight="170px" ImageWidth="160px"
                                        ClientInstanceName="Modello_img"
                                        ShowLoadingImage="true" LoadingImageUrl="../static/img/utente-anonimo.png"
                                        ImageSizeMode="FillAndCrop"
                                        OnCustomCallback="Generic_Image_CustomCallback"
                                        Value='<%# Bind("PhotoBytes") %>'>
                                        <EditingSettings Enabled="true">
                                            <UploadSettings>
                                                <UploadValidationSettings MaxFileSize="4194304" />
                                            </UploadSettings>
                                        </EditingSettings>
                                        <ValidationSettings ValidationGroup="DocValid" RequiredField-IsRequired="true" />
                                    </dx:ASPxBinaryImage>
                                    <a class="btn btn-sm position btn-warning dxbs-button" href="javascript:ShowCrop('Modello_img');" style="width: 152px !important;">
                                        <span class="badge BadgeBtn thin-txt">
                                            <span class="fas fa-crop image" style="font-size: 20px;"></span>
                                            <span>Edit</span>
                                        </span>
                                        <div class="ripple-container"></div>
                                    </a>
                                </EditItemTemplate>
                            </dx:GridViewDataBinaryImageColumn>
                            <%-- GVD_CreatedOn--%>
                            <dx:GridViewDataDateColumn FieldName="UpdatedOn" Caption="Data Modifica" VisibleIndex="4" EditFormSettings-CaptionLocation="Top" EditFormSettings-Visible="False" Width="7%">
                            </dx:GridViewDataDateColumn>
                            <%-- EditUser--%>
                            <dx:GridViewDataTextColumn FieldName="EditUser" Caption="Modificato Da" VisibleIndex="5" EditFormSettings-CaptionLocation="Top" EditFormSettings-Visible="False" Width="7%">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <EditFormLayoutProperties SettingsItemCaptions-Location="Top">
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="Nome" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="PhotoBytes" />
                                <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                            </Items>
                        </EditFormLayoutProperties>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <%-- Popup modal per cropp image --%>
    <div class="w3-modal cropper">
        <div class="w3-modal-content">
            <span class="w3-button w3-black w3-hover-red w3-display-topright w3-theme close-modal">&times;</span>
            <h2 class="w3-black w3-center w3-padding"><strong>Modifica immagine</strong></h2>
            <div class="w3-container w3-white">
                <div id="ic-image" style="display: none !important;">
                    <img id="image1" src="" alt="Immagine" style="max-width: 150px;" />
                </div>
                <!-- Aggiungi questo pulsante per avviare l'ImageCropper -->
                <%--                <button id="ic-start-btn">Avvia ImageCropper</button>--%>
                <dx:ASPxButton runat="server" ID="ic_start_btn" ClientIDMode="Static" AutoPostBack="false" Text="Avvia ImageCropper" ClientVisible="false"></dx:ASPxButton>
                <div id="ic-main" class="ibox">
                    <div class="ic-btns clearfix" style="display: none !important;">
                        <div id="ic-upload-btn" class="l but lrg file-button w3-button w3-blue">
                            <span id="ic-upload-btn-label" style="font-family: inherit; font-size: inherit;">Upload Image</span>
                            <input class="file-input" type="file" id="fileInput" />
                        </div>
                    </div>
                    <div class="col-md-6 no-padding no-margin">
                        <div id="ic-cropper-wrap"></div>
                        <div id="ic-crop-btn-wrap" class="ic-hidden ic-crop-btn-wrap">
                            <br />
                            <div id="ic-rotate-btn" class="l but lrg w3-button w3-grey">
                                <svg x="0px" y="0px" width="50px" height="50px" viewBox="0 0 50 50" enable-background="new 0 0 50 50" xml:space="preserve">
                                    <path d="M41.038,24.1l-7.152,9.342L26.734,24.1H31.4c-0.452-4.397-4.179-7.842-8.696-7.842c-4.82,0-8.742,3.922-8.742,8.742 s3.922,8.742,8.742,8.742c1.381,0,2.5,1.119,2.5,2.5s-1.119,2.5-2.5,2.5c-7.576,0-13.742-6.165-13.742-13.742 s6.166-13.742,13.742-13.742c7.274,0,13.23,5.686,13.697,12.842H41.038z" />
                                </svg>
                                Ruota
                            </div>
                            <div id="ic-flip-btn" class="l but lrg w3-button w3-grey">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000" height="800px" width="800px" version="1.1" id="Capa_1" viewBox="0 0 60.001 60.001" xml:space="preserve">
                                    <g>
                                        <path d="M27.209,0.023c-0.46-0.102-0.928,0.138-1.122,0.568l-26,58c-0.139,0.31-0.111,0.668,0.073,0.953   c0.184,0.284,0.5,0.456,0.839,0.456h26c0.552,0,1-0.447,1-1v-58C28,0.529,27.671,0.122,27.209,0.023z" />
                                        <path d="M59.913,58.592l-26-58c-0.192-0.431-0.66-0.67-1.122-0.568C32.33,0.122,32,0.529,32,1.001v58c0,0.553,0.448,1,1,1h26   c0.339,0,0.655-0.172,0.839-0.456C60.024,59.26,60.052,58.901,59.913,58.592z" />
                                    </g>
                                </svg>
                                Rifletti
                            </div>
                            <a id="ic-crop-btn" class="l but lrg w3-button w3-grey">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000" version="1.1" id="Layer_1" viewBox="0 0 24 24" xml:space="preserve">
                                    <style type="text/css">
                                        .st0 {
                                            fill: none;
                                        }
                                    </style>
                                    <path d="M19.3,5.3L9,15.6l-4.3-4.3l-1.4,1.4l5,5L9,18.4l0.7-0.7l11-11L19.3,5.3z" />
                                    <rect class="st0" width="24" height="24" />
                                </svg>
                                Applica modifiche</a>
                        </div>
                    </div>
                    <div class="col-md-6 no-padding no-margin">
                        <div id="ic-result-wrap" class="ic-hidden ic-result-wrap" style="margin-top: 20px;">
                            <div class="result-container" style="position: relative; width: fit-content; block-size: fit-content; padding: 0px; z-index: 1;">
                                <div class="theresult" style="position: relative; width: fit-content; block-size: block; padding: 0px; margin: 0px;"></div>
                            </div>
                            <div class="col-md-12 no-padding no-margin" style="padding-top: 38px">
                                <dx:BootstrapButton runat="server" ID="SalvaMod_btn" ClientIDMode="Static" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding">
                                    <SettingsBootstrap RenderOption="Success" />
                                    <Badge Text="Salva" IconCssClass="far fa-save" />
                                </dx:BootstrapButton>
                            </div>

                        </div>

                    </div>
                    <div id="ic-download-wrap" class="ic-hidden ic-download-wrap" style="display: none !important;">
                        <div class="select">
                            <select class="w3-select" id="ic-download-type" style="width: 100px; display: inline-block;">
                                <option value="image/jpeg">jpeg</option>
                                <option value="image/png">png</option>
                            </select>
                            <a class="l but lrg w3-button w3-grey">Download</a>
                        </div>
                        <hr />
                        Size: <span id="ic-info"></span>
                    </div>
                </div>
                <br />
                <br />
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Brand_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT Brand.* FROM Brand"
        InsertCommand="INSERT INTO Brand(Nome, PhotoBytes, CreatedUser) VALUES (@Nome, @PhotoBytes, @CreatedUser)"
        UpdateCommand="UPDATE Brand SET Nome = @Nome, PhotoBytes = @PhotoBytes, EditUser = @EditUser, UpdatedOn = GETDATE() WHERE (ID = @ID)"
        DeleteCommand="DELETE FROM Brand WHERE (ID = @ID)">

        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Nome"></asp:Parameter>
            <asp:Parameter Name="PhotoBytes"></asp:Parameter>
            <asp:Parameter Name="CreatedUser"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Nome"></asp:Parameter>
            <asp:Parameter Name="PhotoBytes"></asp:Parameter>
            <asp:Parameter Name="EditUser"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare il Brand selezionato?", "Conferma", "Annulla", Elimina, null, index, null);
        }
        function Elimina(Valore) {
            Generic_Gridview.DeleteRow(Valore);
        }
        function ConfermaOperazioneWithClientFunction(Title, Testo, BtnConfirmTxt, BtnCancelTxt, Function, FunctionCancel = null, FunctionParam = null, FunctionCancelParam = null) {

            swal({

                title: Title,

                text: Testo,

                type: 'warning',

                showCancelButton: true,

                confirmButtonClass: 'btn btn-success',

                cancelButtonClass: 'btn btn-danger',

                confirmButtonText: BtnConfirmTxt,

                buttonsStyling: false,

                cancelButtonText: BtnCancelTxt,

            }).then(function (isConfirm) {

                if (isConfirm) {

                    if (FunctionParam != null) {

                        Function(FunctionParam);

                    } else {

                        Function();

                    }

                }



            }).catch(function () {

                console.log("Test");

                if (FunctionCancelParam != null) {

                    FunctionCancel(FunctionCancelParam);

                } else {

                    FunctionCancel();

                }

            });

        }
    </script>
    <script src='https://jasonlau.biz/cropper-dev/jquery-1.12.4.js'></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


    <script>
        function showSuccessNotification(message = "PROCEDURA ESEGUITA CON SUCCESSO!") {
            const toast = document.getElementById("custom-toast");
            toast.querySelector(".toast-message").textContent = message;
            toast.classList.remove("hidden");

            setTimeout(() => {
                hideToast();
            }, 4000);
        }

        function hideToast() {
            document.getElementById("custom-toast").classList.add("hidden");
        }
    </script>
    <script>
        function EndCallback() {
            showSuccessNotification();
        }
    </script>

    <script src="../ImageCropper_4U/dist/script.js"></script>

    <script>

        function ApriPopup() {
            $('#PopupZoom_Div').modal('show');
        }

        function openModal() {
            ImmaginiLightbox_Popup.Show();
        }

        function closeModal() {
            ImmaginiLightbox_Popup.Hide();
        }

        var slideIndex = 1;
        showSlides(slideIndex);

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {

            showSlides(slideIndex = n);
        }
        function currentDocView(CName) {
            //var _PreviewDocimg = Document.getElementById("PreviewDocimg");
            var _CName = eval(CName);

            var CUrl = _CName.GetValue();
            //ASPxBinaryImagePreview.ContentBytes = _CName.ContentBytes;
            document.getElementById("PreviewDocimg").src = 'DXB.axd?DXCache=' + CUrl;
            //showSlides(slideIndex = n);
        }

        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("demo");
            var captionText = document.getElementById("caption");
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            //slides[slideIndex - 1].style.display = "block";
        }
    </script>
</asp:Content>
