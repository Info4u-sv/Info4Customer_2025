<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Print_Gest_Edit.aspx.cs" Inherits="INTRA.Print_Gest.Print_Gest_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">


    <script>

        //Funzione per calcolo differenza copie bianco/nere
        function onN_Copie_Bn_Changed(s, e) {
            // Recupera il valore di N_Copie_Bn
            var N_Copie_Bn = s.GetValue();
            console.log(s)

            // Recupera il valore di N_Copie_Bn_Comprese
            var N_Copie_Bn_Comprese = Printer_N_CopieBN_Comprese_Edit.GetText();

            // Calcola la differenza
            var difference = N_Copie_Bn - N_Copie_Bn_Comprese;

            // Aggiorna il valore di N_Copie_Bn_Eccedenti
            N_Copie_Bn_Eccedenti_Edit.SetText(difference);


            var element = document.getElementById(N_Copie_Bn_Eccedenti_Edit.GetMainElement().id);

            //console.log(element)

            if (difference <= 0) {

                element.style.backgroundColor = "lightgreen";

            } else {
                element.style.backgroundColor = "red";
            }


        }

        //Funzione per calcolo differenza copie colore
        function onN_Copie_Colori_Changed(s, e) {
            var N_Copie_Col = s.GetValue();
            //console.log(N_Copie_Col)
            var N_Copie_Col_Comprese = Printer_N_CopieCol_Comprese_edit.GetText();
            var difference = N_Copie_Col - N_Copie_Col_Comprese;
            N_Copie_Col_Eccedenti_Edit.SetText(difference);

            var element = document.getElementById(N_Copie_Col_Eccedenti_Edit.GetMainElement().id);

            if (difference <= 0) {

                element.style.backgroundColor = "lightgreen";

            } else {
                element.style.backgroundColor = "red";

            }
        }

        //Funzione per tokenbox scelta Annuale o Trimestrale
        function tokenBoxLettura(s, e) {
            // Ottieni il testo dell'elemento 's' (ASPxTokenBox) e lo assegna alla variabile 'controllo'
            var controllo = s.GetText();

            // Divide il testo 'controllo' in un array utilizzando la virgola come delimitatore
            var controllo_Array = controllo.split(",");

            // Se l'array 'controllo_Array' ha più di un elemento
            if (controllo_Array.length > 1) {
                // Pulisce il testo dell'elemento 's'
                s.SetText("");

                // Imposta il testo dell'elemento 's' al secondo elemento dell'array 'controllo_Array' (indice 1)
                s.SetText(controllo_Array[1]);
            }

            // Ottiene il valore selezionato dell'elemento 's'
            var selectedValue = s.GetValue();

            // Se il valore selezionato è 'Trimestrale'
            if (selectedValue === 'Trimestrale') {
                // Disabilita l'elemento 'Printer_Mese_Lettura_TB'
                Printer_Mese_Lettura_TB.SetEnabled(false)
                // Imposta il testo dell'elemento 'Printer_Mese_Lettura_TB' a 'Marzo,Giugno,Settembe,Dicembre'
                Printer_Mese_Lettura_TB.SetText("Marzo,Giugno,Settembe,Dicembre");

            } else { // Altrimenti, se il valore selezionato non è 'Trimestrale'

                // Abilita l'elemento 'Printer_Mese_Lettura_TB'
                Printer_Mese_Lettura_TB.SetEnabled(true);
                // Pulisce il testo dell'elemento 'Printer_Mese_Lettura_TB'
                Printer_Mese_Lettura_TB.SetText("");
            }

        }

        //Funzione per tokenbox scelta un solo mese se impostato "Annuale"
        function tokenBoxMesi(s, e) {

            // se la scelta è impostata su annuale
            if (Printer_Lettura_TB.GetText() === 'Annuale') {

                // assegna il testo di s alla variabile controllo
                var controllo = s.GetText();
                // Divide il testo 'controllo' in un array utilizzando la virgola come delimitatore
                var controllo_Array = controllo.split(",")

                // Se l'array 'controllo_Array' ha più di un elemento
                if (controllo_Array.length > 1) {
                    // Pulisce il testo dell'elemento 's'
                    s.SetText("");
                    // Imposta il testo dell'elemento 's' al secondo elemento dell'array 'controllo_Array' (indice 1)
                    s.SetText(controllo_Array[1]);
                }
            }

        }
        function SetFunctionOnClick(s, Function) {
            console.log(`Function => ${Function}`);
            if (s.GetEnabled()) {
                s.GetMainElement().onclick = Function;
            }
        }
        function OnCustomButtonClickGeneric(s, e) {
            var prelievo = "CodiceProdotto;Descrizione;ColoreNome";
            var idConsumabile = s.GetRowKey(e.visibleIndex);
            var idMultifunzione = GetQueryStringParam("ID");

            console.log("idMultifunzione:", idMultifunzione);
            console.log("idConsumabile:", idConsumabile);

            Articoli_Grw.GetRowValues(e.visibleIndex, prelievo, function (values) {
                Articolo_Txt.SetText(values[0]);
                //Descrizione_Txt.SetText(values[1]);
                //ColoreID_Cmb.SetText(values[2]);

                ArticoloPopUp.Hide();

                if (idMultifunzione && idConsumabile) {
                    console.log("Calling Insert_Consumabile_Callback with:", idMultifunzione + "|" + idConsumabile);
                    Insert_Consumabile_Callback.PerformCallback(idMultifunzione + "|" + idConsumabile);
                }
            });
        }

        function GetQueryStringParam(key) {
            var params = new URLSearchParams(window.location.search);
            return params.get(key);
        }

        //Insert_Consumabile_Callback.EndCallback = function (s, e) {
        //    console.log("Insert callback ended, result:", e.result);

        //    if (e.result === "refresh") {
        //        console.log("Chiamo il refresh della griglia!");
        //        Printer_Elenco_Codici_Consumabili_GW.PerformCallback();
        //        showNotification('Inserito correttamente!');
        //    } else if (e.result === "exists") {
        //        showNotification("È già presente!", "warning");
        //    } else if (e.result && e.result.startsWith("error|")) {
        //        const msg = e.result.split("|")[1];
        //        showNotification("Errore: " + msg, "error");
        //    }
        //};


        function OnCustomButtonClick(s, e) {

            var grid = s;
            var index = grid.GetFocusedRowIndex();
            console.log(e);

            if (e.buttonID.includes("Avvio")) {
                grid.GetRowValues(e.visibleIndex, 'id', GotoNewPage);
            }

            if (e.buttonID.includes("GoTo")) {
                grid.GetRowValues(e.visibleIndex, 'id', GotoNewPage);
            }
            if (e.buttonID.includes("Edit")) {
                e.processOnServer = false;
                ArticoloPopUp.Show();
            }
            if (e.buttonID.includes("Delete")) {
                OnGetRowValuesElimina(e.visibleIndex);
            }
            if (e.buttonID.includes("Print")) {
                grid.GetRowValues(e.visibleIndex, 'ID', function (value) {
                    var getUrl = window.location;
                    var baseUrl = getUrl.protocol + "//" + getUrl.host + "/";
                    window.open(baseUrl + "/Device_Gest/ViewDoc_Empty.aspx?ID=" + value, "mywindow", "menubar=1,resizable=1,width=1000,height=1000");

                });

            }
        }
        function GotoNewPage(value) {

            window.location = "Prospect_Client_det.aspx?Cli=" + value;
        }
        function ShowHint(s, e) {
            var clientObject = Object.getOwnPropertyNames(s.options);

            /*alert(clientObject);*/
            e.contentElement.innerHTML = '<div class="hintContent">' +
                '<div>Click this button to add a new record.' + '' + '</div>' +
                '</div>';
            ASPxClientHint.UpdatePosition(e.hintElement);
        }




    </script>

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
            z-index: 1;
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
    </style>
    <style>
        .custom-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            z-index: 9999;
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .hidden {
            opacity: 0;
            pointer-events: none;
            transform: translateY(-20px);
        }

        .toast-success {
            background-color: #4CAF50;
            color: white;
        }

        .toast-error {
            background-color: #f44336;
            color: white;
        }

        .toast-icon {
            background-color: white;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.2rem;
        }

            .toast-icon.success {
                color: #4CAF50;
            }

            .toast-icon.error {
                color: #f44336;
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
    <dx:ASPxHint ID="ASPxHint1" runat="server" TargetSelector=".dx-vam">
        <%--  <ClientSideEvents Showing="ShowHint" />--%>
    </dx:ASPxHint>
    <dx:ASPxHint ID="ASPxHint2" runat="server" TargetSelector=".btn:hover" Content="ccc">
        <%--  <ClientSideEvents Showing="ShowHint" />--%>
    </dx:ASPxHint>



    <%-- inizio formLayout --%>
    <div class="row" style="padding-bottom: 25px">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">edit</i>
                </div>
                <div class="card-content">
                    <div class="card-content">
                        <style>
                            .sticky {
                                position: sticky;
                                top: 20px;
                                z-index: 5000 !important;
                            }
                        </style>
                        <h4 class="card-title">Gestione Printer</h4>
                        <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Text="Caricamento in corso..." Modal="true"></dx:ASPxLoadingPanel>
                        <div class="col-md-4">
                            <dx:ASPxCallbackPanel runat="server" ID="Edit_CallbackPnl" ClientInstanceName="Edit_CallbackPnl" OnCallback="Edit_CallbackPnl_Callback">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxFormLayout ID="Printer_Edit_Form" ClientInstanceName="Printer_Edit_Form" runat="server" DataSourceID="Printer_Edit_Dts" Width="100%">
                                            <Items>
                                                <dx:LayoutGroup Caption="Gestione Printer" GroupBoxDecoration="None" ColumnCount="1">
                                                    <Items>
                                                        <dx:LayoutGroup ColumnCount="2" ShowCaption="False">
                                                            <Items>
                                                                <dx:LayoutItem FieldName="PhotoBytes" Caption="Immagine" ShowCaption="False" CaptionSettings-Location="Top" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxBinaryImage ID="Printer_PhotoBytes_Edit" runat="server" HelpText="Puoi caricare JPG, GIF o PNG. LA dimensione massima del file è 4MB." ClientInstanceName="Modello_img" ImageHeight="170px" ImageWidth="160px" ShowLoadingImage="true" LoadingImageUrl="../static/img/utente-anonimo.png" ImageSizeMode="FillAndCrop" OnCustomCallback="Generic_Image_CustomCallback">
                                                                                <ClientSideEvents Click="function(s,e){openModal();currentDocView('Modello_img')}" />
                                                                                <ValidationSettings ValidationGroup="DocValid" RequiredField-IsRequired="true" Display="Dynamic" ErrorDisplayMode="none">
                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                </ValidationSettings>
                                                                                <EditingSettings Enabled="true">
                                                                                    <UploadSettings>
                                                                                        <UploadValidationSettings MaxFileSize="4194304"></UploadValidationSettings>
                                                                                    </UploadSettings>
                                                                                </EditingSettings>
                                                                                <InvalidStyle BackColor="LightPink" />
                                                                            </dx:ASPxBinaryImage>
                                                                            <a class="btn btn-sm position btn-warning dxbs-button" href="javascript: ShowCrop('Modello_img');" style='width: 152px !important;'>
                                                                                <span class="badge BadgeBtn thin-txt">
                                                                                    <span class="fas fa-crop image" style="font-size: 20px;"></span>
                                                                                    <span>Edit</span>
                                                                                </span>
                                                                                <div class="ripple-container"></div>
                                                                            </a>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="Expr2" ShowCaption="False" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxBinaryImage ID="Printer_PhotoBytes_View" runat="server" Width="50%"
                                                                                ImageHeight="170px" ImageWidth="160px" EnableServerResize="True" />
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                            </Items>
                                                        </dx:LayoutGroup>

                                                        <dx:LayoutGroup ShowCaption="False" ColumnCount="2">
                                                            <Items>
                                                                <dx:LayoutItem FieldName="Modello" Caption="Modello Printer" CaptionSettings-Location="Top">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxTextBox ID="Printer_Morello_Edit" runat="server" Width="100%" InvalidStyle-BackColor="LightPink">
                                                                                <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit" />
                                                                            </dx:ASPxTextBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="CodiceProdotto" Caption="Codice Prodotto" CaptionSettings-Location="Top">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxTextBox ID="Printer_CodiceProdotto_Edit" runat="server" Width="100%" InvalidStyle-BackColor="LightPink">
                                                                                <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit" />
                                                                            </dx:ASPxTextBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="ID_Tipologia" Caption="Tipologia" CaptionSettings-Location="Top">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxComboBox ID="Printer_Id_Tipologia_Edit" runat="server" Width="100%"
                                                                                DataSourceID="Printer_Id_Tipologia_Dts" ValueField="ID" TextField="Tipologia">
                                                                                <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit" />
                                                                            </dx:ASPxComboBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="N_Colori" Caption="Numero di Colori" CaptionSettings-Location="Top" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxSpinEdit runat="server" ID="Printer_N_Colori_Edit_Spin" ClientInstanceName="Printer_N_Colori_Edit_Spin" MinValue="1" MaxValue="4" Increment="1" Width="100%"></dx:ASPxSpinEdit>
                                                                            <%--<dx:ASPxTextBox runat="server" Width="100%" ID="Printer_N_Colori_Edit" InvalidStyle-BackColor="LightPink">--%>
                                                                            <validationsettings requiredfield-isrequired="true" errordisplaymode="None" validationgroup="ValidazioneEdit"></validationsettings>
                                                                            <%-- </dx:ASPxTextBox>--%>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="BrandId" Caption="Brand" CaptionSettings-Location="Top">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxComboBox ID="Printer_BrandId_Edit" runat="server" Width="100%"
                                                                                DataSourceID="Brand_Dts" ValueField="ID" TextField="Nome" AutoPostBack="false">
                                                                                <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit" />
                                                                            </dx:ASPxComboBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                            </Items>
                                                        </dx:LayoutGroup>
                                                    </Items>
                                                </dx:LayoutGroup>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                        <div class="col-md-12" style="padding-bottom: 40px; padding-top: 40px;">
                                            <dx:ASPxButton ID="Update_Btn" ClientInstanceName="Update_Btn" runat="server" Text="Aggiorna" AutoPostBack="false" BackColor="#0055A6">
                                                <ClientSideEvents Click="function(s,e){
        if(ASPxClientEdit.ValidateGroup('ValidazioneEdit')){                                
            ConfermaOperazione('Confermi di voler aggiornare il progetto con i dati inseriti?','Update_FormLayout_Callback');
        }
        else{
            showNotificationError('Alcuni dati non sono stati compilati, controllare e riprovare.')
        }
    }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </div>
                        <dx:ASPxPopupControl ID="ImmaginiLightbox_Popup" HeaderText=" " ClientInstanceName="ImmaginiLightbox_Popup" runat="server" Modal="True" CloseOnEscape="true" CloseAction="OuterMouseClick" AutoUpdatePosition="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter">
                            <ContentCollection>
                                <dx:PopupControlContentControl>

                                    <img src="" id="PreviewDocimg" style="max-height: 700px; max-width: 700px" />
                                </dx:PopupControlContentControl>
                            </ContentCollection>
                        </dx:ASPxPopupControl>

                        <div class="col-md-8" style="overflow: hidden;">
                            <div style="display: flex; align-items: flex-end; gap: 8px;">
                                <dx:ASPxTextBox runat="server" Width="20%" ID="Articolo_Txt" ClientInstanceName="Articolo_Txt" Caption="Codice Articolo" CaptionStyle-CssClass="caption-art-css" CaptionSettings-Position="Top">
                                    <ClientSideEvents Init="function(s,e){SetFunctionOnClick(s,function(){ArticoloPopUp.Show();});}" />
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="GiacenzaValid">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                <dx:BootstrapButton runat="server" ID="CodArt_Btn" ClientInstanceName="CodArt_Btn" AutoPostBack="false"
                                    Badge-CssClass="BadgeBtn"
                                    CssClasses-Control="btn btn-sm btn-info btn-padding-right-txtbox codart-btn-css">
                                    <Badge IconCssClass="fa fa-list" />
                                    <ClientSideEvents Click="function(s,e){ArticoloPopUp.Show();}" />
                                </dx:BootstrapButton>
                            </div>
                            <%--GridView della tabella Elenco codici consumabili--%>
                            <dx:ASPxGridView runat="server" ID="Printer_Elenco_Codici_Consumabili_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Printer_Elenco_Codici_Consumabili_GW" DataSourceID="Printer_Elenco_Codici_Consumabili_Dts" Width="100%" Style="margin-left: 0 auto" AutoGenerateColumns="False" KeyFieldName="ID" OnInitNewRow="Printer_Elenco_Codici_Consumabili_GW_InitNewRow">
                                <Settings ShowGroupPanel="false" ShowHeaderFilterButton="false" ShowFilterRow="True"></Settings>
                                <%--Aggiunge il controllo sui filtri, il filtro si applica alla pressione del tasto invio--%>
                                <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                                <SettingsBehavior FilterRowMode="OnClick" />
                                <Styles AlternatingRow-Enabled="True"></Styles>
                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
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

                                <%-- Serve per farlo funzionare --%>
                                <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                                <%-- export button --%>

                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                                <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                                <ClientSideEvents EndCallback="function(s, e) { ASPxClientHint.Update(); }" />
                                <SettingsCommandButton>
                                    <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                    </ClearFilterButton>
                                    <%--  <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica"  Styles-CssPostfix="hidebtn">
              <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
              </EditButton>--%>
                                    <%--  <DeleteButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
              <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn delete icon4u icon-delete image"></Styles>
              </DeleteButton>--%>
                                    <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                                    </UpdateButton>
                                    <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                                    </CancelButton>
                                    <NewButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                                    </NewButton>
                                    <SelectButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                                    </SelectButton>

                                </SettingsCommandButton>

                                <%--PopUp Edit Form ****  EditFormColumnCount mette due 2 colonne l'inserimento --%>

                                <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />

                                <SettingsPopup EditForm-VerticalAlign="Middle" EditForm-HorizontalAlign="Center" EditForm-Modal="true">
                                    <EditForm AllowResize="True" AutoUpdatePosition="True" Width="900px" Height="450px"></EditForm>
                                </SettingsPopup>

                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                <Columns>
                                    <%-- colonna bottoni di edit --%>
                                    <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="false" ShowEditButton="false" ShowDeleteButton="true" Width="80px">
                                        <CustomButtons>
                                            <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit_3" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                            <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete_3" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                        </CustomButtons>
                                    </dx:GridViewCommandColumn>
                                    <%-- colonna codice modello --%>
                                    <dx:GridViewDataTextColumn FieldName="ID_Multifunzione" Caption="Codice Modello" VisibleIndex="1" EditFormSettings-CaptionLocation="Top" ReadOnly="true" Visible="false">
                                        <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" />
                                    </dx:GridViewDataTextColumn>
                                    <%-- colonna Descrizione--%>
                                    <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Descrizione" VisibleIndex="3" ReadOnly="true" Visible="true" EditFormSettings-Visible="False">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataBinaryImageColumn FieldName="PhotoBytes" VisibleIndex="4" Caption="Immagine" EditFormSettings-Visible="False">
                                        <PropertiesBinaryImage ImageHeight="100" EnableServerResize="True">
                                        </PropertiesBinaryImage>
                                    </dx:GridViewDataBinaryImageColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="ColoreID" Caption="Colore" VisibleIndex="5" Width="80px" EditFormSettings-Visible="False" Settings-AllowHeaderFilter="False" Settings-AllowAutoFilter="false">
                                        <PropertiesComboBox DataSourceID="Printer_Elenco_Codici_Consumabili_Dts" ValueField="ID" TextField="Descrizione">
                                        </PropertiesComboBox>
                                        <DataItemTemplate>
                                            <%# GetColorDotAndName((int)Eval("ColoreID")) %>
                                        </DataItemTemplate>
                                    </dx:GridViewDataComboBoxColumn>
                                    <%--  ID_Ricambi comboBox--%>
                                    <dx:GridViewDataTextColumn
                                        FieldName="CodiceProdotto"
                                        Caption="Codici Consumabili"
                                        VisibleIndex="2"
                                        Settings-AllowHeaderFilter="False"
                                        Settings-AllowAutoFilter="True"
                                        Settings-AutoFilterCondition="Contains"
                                        EditFormSettings-Visible="False" />

                                    <dx:GridViewDataComboBoxColumn
                                        FieldName="ID_Consumabile"
                                        Visible="false"
                                        EditFormSettings-Visible="True">

                                        <PropertiesComboBox
                                            DataSourceID="Ricambi_Dts"
                                            ValueField="ID"
                                            TextField="CodiceProdotto">
                                        </PropertiesComboBox>

                                        <EditItemTemplate>
                                            <dx:ASPxComboBox
                                                runat="server"
                                                ID="Ricambi_CB"
                                                ClientInstanceName="Ricambi_CB"
                                                DataSourceID="Ricambi_Dts"
                                                ValueField="ID"
                                                TextField="CodiceProdotto"
                                                Value='<%# Bind("ID_Consumabile") %>'
                                                ValueType="System.Int32"
                                                ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                                InvalidStyle-BackColor="LightPink"
                                                Width="100%">

                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="CodiceProdotto"></dx:ListBoxColumn>
                                                    <dx:ListBoxColumn FieldName="ColoreNome"></dx:ListBoxColumn>
                                                    <dx:ListBoxColumn FieldName="TipologiaNome"></dx:ListBoxColumn>
                                                    <dx:ListBoxColumn FieldName="Descrizione" Width="100%"></dx:ListBoxColumn>
                                                </Columns>

                                                <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None"></ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </EditItemTemplate>
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn FieldName="TipologiaNome" Caption="Tipo Prodotto" VisibleIndex="6" EditFormSettings-CaptionLocation="Top" ReadOnly="true">
                                        <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" />
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>


                            <%-- callback per aggiornamento dati del FormLayout alla pressione del tasto Aggiorna --%>
                            <dx:ASPxCallback ID="Update_FormLayout_Callback" ClientInstanceName="Update_FormLayout_Callback" runat="server" OnCallback="Update_FormLayout_Callback_Callback" Style="float: right">
                                <ClientSideEvents
                                    BeginCallback="function(s,e){LoadingPanel.Show();}"
                                    EndCallback="function(s,e){
    LoadingPanel.Hide(); 
    Update_Scandenze_Copie_Callback.PerformCallback(); 
    Edit_CallbackPnl.PerformCallback();showSuccessNotification();
}" />
                            </dx:ASPxCallback>
                            <%-- callback per l'aggiornamento di gestione copie alla pressione del tasto Aggiorna --%>
                            <dx:ASPxCallback ID="Update_Scandenze_Copie_Callback" ClientInstanceName="Update_Scandenze_Copie_Callback" runat="server" OnCallback="Update_Scandenze_Copie_Callback_Callback" Style="float: right">
                                <ClientSideEvents
                                    EndCallback="function(s,e){showSuccessNotification();Printer_Rilevamento_Copie_GW.Refresh();}" />
                            </dx:ASPxCallback>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxPopupControl runat="server" ID="ArticoloPopUp" ClientInstanceName="ArticoloPopUp" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" CloseAction="CloseButton" CloseOnEscape="true" Modal="True" Maximized="false" MinWidth="1400px"
        HeaderText="Seleziona articolo" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="false">
        <ClientSideEvents Shown="function(s,e){Articoli_Grw.ClearFilter();}" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxGridView runat="server" ID="Articoli_Grw" ClientInstanceName="Articoli_Grw" Width="100%" Styles-AlternatingRow-Enabled="True" AutoGenerateColumns="False" DataSourceID="Ricambi_Dts" KeyFieldName="ID">
                    <Settings ShowGroupPanel="false" ShowHeaderFilterButton="false" ShowFilterRow="True" VerticalScrollBarMode="Auto" VerticalScrollableHeight="400"></Settings>
                    <SettingsPager Mode="EndlessPaging" />
                    <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                    <Toolbars>
                        <dx:GridViewToolbar>
                            <Items>
                                <dx:GridViewToolbarItem Alignment="left">
                                    <Template>
                                        <dx:ASPxButtonEdit ID="tbToolbarSearchMatPrima" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
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
                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearchMatPrima"></SettingsSearchPanel>
                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                    <ClientSideEvents CustomButtonClick="OnCustomButtonClickGeneric" />
                    <SettingsCommandButton>
                        <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                        </ClearFilterButton>
                        <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                        </UpdateButton>
                        <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                        </CancelButton>
                        <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                        </NewButton>
                    </SettingsCommandButton>
                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                    <Columns>
                        <dx:GridViewCommandColumn Caption=" " ShowClearFilterButton="true" ShowDeleteButton="false" ShowEditButton="false" ShowNewButtonInHeader="false" Width="40px">
                            <CustomButtons>
                                <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo" IconCssClass="icon4u icon-check-square image" CssClass="btn btn-sm btn-custom-padding action-btn go" />
                            </CustomButtons>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="CodiceProdotto" Caption="Codice Prodotto" VisibleIndex="1" EditFormSettings-CaptionLocation="Top" ReadOnly="true" Visible="true" Width="10%">
                            <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" />
                        </dx:GridViewDataTextColumn>
                        <%-- colonna Descrizione--%>
                        <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Descrizione" VisibleIndex="3" ReadOnly="true" Visible="true" EditFormSettings-Visible="False">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataBinaryImageColumn FieldName="PhotoBytes" VisibleIndex="4" Caption="Immagine" EditFormSettings-Visible="False" Width="15%">
                            <PropertiesBinaryImage ImageHeight="100" EnableServerResize="True">
                            </PropertiesBinaryImage>
                        </dx:GridViewDataBinaryImageColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="ColoreID" Caption="Colore" VisibleIndex="5" Width="80px" EditFormSettings-Visible="False">
                            <PropertiesComboBox DataSourceID="Printer_Elenco_Codici_Consumabili_Dts" ValueField="ID" TextField="Descrizione">
                            </PropertiesComboBox>
                            <DataItemTemplate>
                                <%# GetColorDotAndName((int)Eval("ColoreID")) %>
                            </DataItemTemplate>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn FieldName="TipologiaNome" Caption="Codice Prodotto" VisibleIndex="6" EditFormSettings-CaptionLocation="Top" ReadOnly="true" Visible="true" Width="10%">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

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

    <dx:ASPxCallback runat="server" ID="Gestione_Copie_Delete_Callback" ClientInstanceName="Gestione_Copie_Delete_Callback" OnCallback="Gestione_Copie_Delete_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Printer_Rilevamento_Copie_GW.Refresh(); showSuccessNotification();}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="Insert_Consumabile_Callback" runat="server" ClientInstanceName="Insert_Consumabile_Callback"
        OnCallback="Insert_Consumabile_Callback_Callback">
        <ClientSideEvents EndCallback="function(s, e) {
        var result = s.cpResult;  // prendi il valore che abbiamo impostato in JSProperties

        console.log('Insert callback result:', result);

        if (result === 'refresh') {
            Printer_Elenco_Codici_Consumabili_GW.Refresh();
            showSuccessNotification();
        }
        else if (result === 'exists') {
            showErrorNotification();
        }
        else if (result && result.startsWith('error|')) {
            const msg = result.split('|')[1];
            showNotification('Errore: ' + msg, 'error');
        }
        else {
            console.log('Callback result non gestito:', result);
        }
    }" />
    </dx:ASPxCallback>

    <%-- SqlDataSource per FormLayout --%>
    <asp:SqlDataSource ID="Printer_Edit_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Multifunzione_ANA.ID, Multifunzione_ANA.Modello, Multifunzione_ANA.ID_Tipologia, Multifunzione_ANA.PhotoBytes, Multifunzione_ANA.BrandId, Multifunzione_ANA.CodiceProdotto, Multifunzione_ANA.ID AS Expr1, Brand.PhotoBytes AS Expr2, Multifunzione_ANA.N_Colori FROM Multifunzione_ANA INNER JOIN Brand ON Multifunzione_ANA.BrandId = Brand.ID WHERE (Multifunzione_ANA.ID = @ID)" UpdateCommand="UPDATE Multifunzione_ANA SET Modello = @Modello, ID_Tipologia = @ID_Tipologia, BrandId = @BrandId, CodiceProdotto = @CodiceProdotto, PhotoBytes = @PhotoBytes, N_Colori = @N_Colori WHERE (ID = @ID)" OnUpdating="Printer_Edit_Dts_Updating">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Modello"></asp:Parameter>
            <asp:Parameter Name="ID_Tipologia"></asp:Parameter>
            <asp:Parameter Name="BrandId"></asp:Parameter>
            <asp:Parameter Name="CodiceProdotto"></asp:Parameter>
            <asp:Parameter Name="PhotoBytes"></asp:Parameter>
            <asp:Parameter Name="N_Colori"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <%-- SqlDataSource per ID_Tipologia --%>
    <asp:SqlDataSource ID="Printer_Id_Tipologia_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID, Tipologia FROM Tipologia_Printer_ANA"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="Brand_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Brand.* FROM Brand"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Ricambi_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID, CodiceProdotto, Descrizione, DettaglioProd, CopiePreviste, BrandId, PhotoBytes, TipoProdID, ColoreID, 
        CASE ColoreID
          WHEN 1 THEN 'Nero'
          WHEN 2 THEN 'Giallo'
          WHEN 3 THEN 'Magenta'
          WHEN 4 THEN 'Ciano'
          WHEN 5 THEN 'Waste'
          WHEN 7 THEN 'Nessuno'
          WHEN 9 THEN 'CMYK'
          ELSE 'Sconosciuto'
        END AS ColoreNome,
        CASE TipoProdID
        WHEN 1 THEN 'Toner'
        WHEN 2 THEN 'Fotoricettore'
        WHEN 3 THEN 'Transfer Belt'
        WHEN 4 THEN 'IBT Cleaner'
        WHEN 5 THEN 'Rullo polarizzato'
        WHEN 6 THEN '2° Rullo di trasferimento polarizzato'
        WHEN 7 THEN 'Maintenance Kit'
        WHEN 8 THEN 'Fusore'
        WHEN 9 THEN 'Punti Metallici'
        WHEN 10 THEN 'Inchiostro'
        END AS TipologiaNome
    FROM Ricambi_Consumabili WHERE (BrandId = @BrandId)">
        <SelectParameters>
            <asp:SessionParameter SessionField="BrandId" Name="BrandId"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <%-- SqlDataSource Codici Consumabili --%>
    <asp:SqlDataSource ID="Printer_Elenco_Codici_Consumabili_Dts" runat="server" OnInserting="Printer_Elenco_Codici_Consumabili_Dts_Inserting" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Elenco_codici_consumabili_vs_printer.ID, Elenco_codici_consumabili_vs_printer.ID_Consumabile, Ricambi_Consumabili.Descrizione, Ricambi_Consumabili.PhotoBytes, Ricambi_Consumabili.ColoreID, Ricambi_Consumabili.CodiceProdotto, Elenco_codici_consumabili_vs_printer.ID_Multifunzione, Ricambi_Consumabili.TipoProdID,
        CASE TipoProdID
        WHEN 1 THEN 'Toner'
        WHEN 2 THEN 'Fotoricettore'
        WHEN 3 THEN 'Transfer Belt'
        WHEN 4 THEN 'IBT Cleaner'
        WHEN 5 THEN 'Rullo polarizzato'
        WHEN 6 THEN '2° Rullo di trasferimento polarizzato'
        WHEN 7 THEN 'Maintenance Kit'
        WHEN 8 THEN 'Fusore'
        WHEN 9 THEN 'Punti Metallici'
        WHEN 10 THEN 'Inchiostro'
        END AS TipologiaNome 
        FROM Elenco_codici_consumabili_vs_printer INNER JOIN Ricambi_Consumabili ON Elenco_codici_consumabili_vs_printer.ID_Consumabile = Ricambi_Consumabili.ID WHERE (Elenco_codici_consumabili_vs_printer.ID_Multifunzione = @ID) ORDER BY  ColoreID"
        InsertCommand="INSERT INTO Elenco_codici_consumabili_vs_printer(ID_Multifunzione, ID_Consumabile) VALUES (@ID_Multifunzione, @ID_Consumabile)" UpdateCommand="UPDATE Elenco_codici_consumabili_vs_printer SET ID_Multifunzione = @ID_Multifunzione, ID_Consumabile = @ID_Consumabile WHERE (ID = @ID)" DeleteCommand="DELETE FROM Elenco_codici_consumabili_vs_printer WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_Multifunzione"></asp:Parameter>
            <asp:Parameter Name="ID_Consumabile"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID_Multifunzione"></asp:Parameter>
            <asp:Parameter Name="ID_Consumabile"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare il codice consumabile selezionato?", "Conferma", "Annulla", Elimina, null, index, null);
            showSuccessNotification();
        }
        function Elimina(Valore) {
            Printer_Elenco_Codici_Consumabili_GW.DeleteRow(Valore);
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

    <script src="../ImageCropper_4U/dist/script.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


    <script>
        function showToast(message, type = "success") {
            const toast = document.getElementById("custom-toast");
            const icon = toast.querySelector(".toast-icon");
            const msgElement = toast.querySelector(".toast-message");

            toast.classList.remove("hidden", "toast-success", "toast-error");
            icon.classList.remove("success", "error");

            msgElement.textContent = message;

            if (type === "success") {
                toast.classList.add("toast-success");
                icon.classList.add("success");
                icon.innerHTML = "✔️";
            } else if (type === "error") {
                toast.classList.add("toast-error");
                icon.classList.add("error");
                icon.innerHTML = "❌";
            }

            setTimeout(() => {
                hideToast();
            }, 4000);
        }

        function showSuccessNotification(message = "PROCEDURA ESEGUITA CON SUCCESSO!") {
            showToast(message, "success");
        }

        function showErrorNotification(message = "Consumabile già presente") {
            showToast(message, "error");
        }

        function hideToast() {
            const toast = document.getElementById("custom-toast");
            toast.classList.add("hidden");
        }
    </script>
    <script>
        function EndCallback() {
            showSuccessNotification();
        }
    </script>

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

