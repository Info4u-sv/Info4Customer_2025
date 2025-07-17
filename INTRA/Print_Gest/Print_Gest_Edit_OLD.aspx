<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Print_Gest_Edit_OLD.aspx.cs" Inherits="INTRA.Print_Gest.Print_Gest_Edit_OLD" %>

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
                grid.StartEditRow(e.visibleIndex);
            }
            if (e.buttonID.includes("Delete")) {
                ConfermaGridViewDeleteRowNoCallback('Cancella il dato!', grid, e.visibleIndex);
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


        function ConfermaGridViewDeleteRowNoCallback(Testo, grid, visibleIndex) {
            var retvar = false;
            swal({

                title: 'Confermi l\'operazione?',

                text: Testo,

                type: 'warning',

                showCancelButton: true,

                confirmButtonClass: 'btn btn-success',

                cancelButtonClass: 'btn btn-danger',

                confirmButtonText: 'INVIA',

                buttonsStyling: false,

                cancelButtonText: 'ANNULLA',

            }).then(function (isConfirm) {

                if (isConfirm) {

                    // var ClientInstanceNameVar = eval(ClientInstanceName);

                    grid.DeleteRow(visibleIndex);
                }
            });

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
                <div class="card-header card-header-icon" data-background-color="orange">
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
                        <h4 class="card-title">Gestione Pinter</h4>
                        <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Text="Caricamento in corso..." Modal="true"></dx:ASPxLoadingPanel>
                        <div class="col-md-12" style="max-height: 600px; overflow: auto">
                            <dx:ASPxCallbackPanel runat="server" ID="Edit_CallbackPnl" ClientInstanceName="Edit_CallbackPnl" OnCallback="Edit_CallbackPnl_Callback">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxFormLayout ID="Printer_Edit_Form" ClientInstanceName="Printer_Edit_Form" runat="server" DataSourceID="Printer_Edit_Dts" Width="100%">
                                            <Items>
                                                <dx:LayoutGroup Caption="Gestione Printer" ColumnCount="3">
                                                    <Items>
                                                        <%-- campo ID --%>
                                                        <dx:LayoutItem FieldName="ID" Caption="ID" Visible="false" CaptionSettings-Location="Top">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" ReadOnly="true" Width="100%" Enabled="false"></dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- campo Modello --%>
                                                        <dx:LayoutItem FieldName="Modello" Caption="Modello Printer" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" Width="100%" ID="Printer_Morello_Edit" InvalidStyle-BackColor="LightPink">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo id tipologia --%>
                                                        <dx:LayoutItem FieldName="ID_Tipologia" Caption="Tipologia" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxComboBox runat="server" ID="Printer_Id_Tipologia_Edit" DataSourceID="Printer_Id_Tipologia_Dts" ValueField="ID" TextField="Tipologia" Width="100%">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxComboBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Codice Cliente --%>
                                                        <dx:LayoutItem FieldName="Cod_Cliente" Caption="Codice Cliente | Nome Cliente" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxComboBox runat="server" ID="Printer_Cod_Cliente_Edit" DataSourceID="Printer_Codice_Cliente_Dts" ValueField="CodCli" TextField="Denom" TextFormatString="{0} | {1}" Width="100%">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                        <Columns>
                                                                            <dx:ListBoxColumn FieldName="Denom"></dx:ListBoxColumn>
                                                                            <dx:ListBoxColumn FieldName="CodCli"></dx:ListBoxColumn>
                                                                        </Columns>
                                                                    </dx:ASPxComboBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%--Campo Data Verifica--%>
                                                        <%--  <dx:LayoutItem FieldName="Data_Verifica" Caption="Data Verifica" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="Printer_Data_Verifica_Edit">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxDateEdit>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>--%>
                                                        <%-- Campo ID_Status --%>
                                                        <%-- <dx:LayoutItem FieldName="ID_Status" Caption="Status" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxComboBox runat="server" ID="Printer_Id_Status_Edit" DataSourceID="Printer_Id_Status_Dts" ValueField="ID" TextField="Status" Width="100%">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxComboBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>--%>
                                                        <%-- Campo Matricola --%>
                                                        <dx:LayoutItem FieldName="Matricola" Caption="Matricola" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" Width="100%" ID="Printer_Matricola_Edit" InvalidStyle-BackColor="LightPink">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Data Prima Installazione --%>
                                                        <dx:LayoutItem FieldName="Data_Prima_Installazione" Caption="Data Prima Installazione" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="Printer_Data_Prima_installazione_Edit">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxDateEdit>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Numero Colori --%>
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
                                                        <%-- Campo Rif Contratto King --%>
                                                        <dx:LayoutItem FieldName="Rif_Contratto_King" Caption="Riferimento Contratto King" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" Width="100%" ID="Printer_Rif_Contratto_King_Dts" InvalidStyle-BackColor="LightPink">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Num Copie BN Comprese --%>
                                                        <dx:LayoutItem FieldName="N_Copie_Bn_Comprese" Caption="Numero Copie B/N Comprese" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxSpinEdit runat="server" Width="100%" ID="Printer_N_CopieBN_Comprese_Edit" ClientInstanceName="Printer_N_CopieBN_Comprese_Edit">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>

                                                                    </dx:ASPxSpinEdit>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Num Copie Colori Comprese --%>
                                                        <dx:LayoutItem FieldName="N_Copie_Col_Comprese" Caption="Numero Copie A Colori Comprese" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxSpinEdit runat="server" Width="100%" ID="Printer_N_CopieCol_Comprese_edit" ClientInstanceName="Printer_N_CopieCol_Comprese_edit">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>

                                                                    </dx:ASPxSpinEdit>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Stato della Stampante (Installata - Rientrata - Rottamata - Riasegnata --%>
                                                        <%--     <dx:LayoutItem FieldName="Status_Printer" Caption="Stato Printer" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxComboBox runat="server" ID="Printer_Status_Stampante_Edit" ValueField="ID" TextField="Status" Width="100%">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="Installata" Value="Installata" />
                                                                            <dx:ListEditItem Text="Rientrata" Value="Rientrata" />
                                                                            <dx:ListEditItem Text="Rottamata" Value="Rottamata" />
                                                                            <dx:ListEditItem Text="Riassegnata" Value="Riassegnata" />
                                                                        </Items>
                                                                    </dx:ASPxComboBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>--%>
                                                        <%-- Campo Codice Cliente Riassegno --%>
                                                        <dx:LayoutItem FieldName="Cod_Cli_Riassegno" Caption="Codice Cliente Riassegno" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" Width="100%" ID="Printer_Cod_Cli_Riassegno_Edit" InvalidStyle-BackColor="LightPink">
                                                                        <%--<ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>--%>
                                                                    </dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Ubicazione --%>
                                                        <dx:LayoutItem FieldName="Ubicazione_Printer" Caption="Ubicazione Printer" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" Width="100%" ID="Printer_Ubicazione_Edit" InvalidStyle-BackColor="LightPink">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- campo vendita --%>
                                                        <dx:LayoutItem FieldName="Vendita" Caption="Vendita" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxComboBox runat="server" ID="Vendita_Edit" ValueField="Vendita" TextField="Vendita" Width="100%">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="Finanziaria" Value="Finanziaria" />
                                                                            <dx:ListEditItem Text="Info4U" Value="Info4U" />
                                                                        </Items>
                                                                    </dx:ASPxComboBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>

                                                        <%--Campo Lettura--%>
                                                        <dx:LayoutItem FieldName="Lettura" Caption="Lettura" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTokenBox runat="server" ID="Printer_Lettura_TB" ClientInstanceName="Printer_Lettura_TB" Width="100%" InvalidStyle-BackColor="LightPink">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                        <ClientSideEvents ValueChanged="tokenBoxLettura" />
                                                                        <Items>
                                                                            <dx:ListEditItem Text="Annuale" Value="Annuale" />
                                                                            <dx:ListEditItem Text="Trimestrale" Value="Trimestrale" />
                                                                        </Items>
                                                                    </dx:ASPxTokenBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%--Campo Mese Lettura--%>
                                                        <dx:LayoutItem FieldName="Mese_Lettura" Caption="Mese Lettura" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTokenBox runat="server" ID="Printer_Mese_Lettura_TB" ClientInstanceName="Printer_Mese_Lettura_TB" Width="100%" InvalidStyle-BackColor="LightPink">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                        <ClientSideEvents ValueChanged="tokenBoxMesi" />
                                                                        <Items>
                                                                            <dx:ListEditItem Text="Marzo" Value="Marzo" />
                                                                            <dx:ListEditItem Text="Giugno" Value="Giugno" />
                                                                            <dx:ListEditItem Text="Settembre" Value="Settembre" />
                                                                            <dx:ListEditItem Text="Dicembre" Value="Dicembre" />
                                                                        </Items>
                                                                    </dx:ASPxTokenBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                    </Items>
                                                </dx:LayoutGroup>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>

                            <div class="col-md-12" style="padding-bottom: 40px; padding-top: 40px;">
                                <dx:ASPxButton ID="Update_Btn" ClientInstanceName="Update_Btn" runat="server" Text="Aggiorna" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s,e){
                                        if(ASPxClientEdit.ValidateGroup('ValidazioneEdit')){                                
    
                                        ConfermaOperazione('Confermi di voler aggiornare il progetto con i dati inseriti?','Update_Callback');
                                        }
                                        else{
                                        showNotificationError('Alcuni dati non sono stati compilati, controllare e riprovare.')
                                        }
                                        }" />
                                </dx:ASPxButton>
                                <dx:ASPxCallback ID="Update_Callback" ClientInstanceName="Update_Callback" runat="server" OnCallback="Update_Callback_Callback" Style="float: right">
                                    <ClientSideEvents
                                        BeginCallback="function(s,e){LoadingPanel.Show();}"
                                        EndCallback="function(s,e){LoadingPanel.Hide(); showNotification();Edit_CallbackPnl.PerformCallback();}" />
                                </dx:ASPxCallback>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- sezione rilevamento copie e manutenzione --%>
    <div class="row" style="padding-bottom: 25px">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
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
                        <h4 class="card-title">Gestione Copie</h4>

                        <%--GridView della tabella Rilevamento copie--%>
                        <%-- <dx:ASPxGridView runat="server" ID="Printer_Rilevamento_Copie_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" OnRowInserting="Printer_Rilevamento_Copie_GW_RowInserting" OnRowUpdating="Printer_Rilevamento_Copie_GW_RowUpdating" ClientInstanceName="Printer_Rilevamento_Copie_GW" DataSourceID="Printer_Rilevamento_Copie_Dts" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID">--%>
                        <dx:ASPxGridView runat="server" ID="Printer_Rilevamento_Copie_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Printer_Rilevamento_Copie_GW" DataSourceID="Printer_Rilevamento_Copie_Dts" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID">
                            <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                            <%--Aggiunge il controllo sui filtri, il filtro si applica alla pressione del tasto invio--%>
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
                                <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

                            <Columns>

                                <%-- colonna bottoni di edit --%>
                                <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="true" ShowEditButton="True" ShowDeleteButton="true" Width="80px">
                                    <CustomButtons>
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                    </CustomButtons>
                                </dx:GridViewCommandColumn>
                                <%-- colonna data --%>
                                <dx:GridViewDataDateColumn FieldName="DataRilevamento" VisibleIndex="1" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesDateEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <%--colonna numero copie bianco/nero rilevate--%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Bn" Caption="Copie Bianco/Nero Rilevate" VisibleIndex="3" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                    <EditItemTemplate>
                                        <dx:ASPxSpinEdit runat="server" ID="N_Copie_Bn_Edit" ClientInstanceName="N_Copie_Bn_Edit" MinValue="0" Increment="1" Width="100%" Text='<%# Bind("N_Copie_Bn") %>'>
                                            <ClientSideEvents ValueChanged="onN_Copie_Bn_Changed" />
                                        </dx:ASPxSpinEdit>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%--colonna numero copie colori rilevate--%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Colori" Caption="Copie Colori Rilevate" VisibleIndex="5" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                    <EditItemTemplate>
                                        <dx:ASPxSpinEdit runat="server" ID="N_Copie_Colori_Edit" ClientInstanceName="N_Copie_Colori_Edit" MinValue="0" Increment="1" Width="100%" Text='<%# Bind("N_Copie_Colori") %>'>
                                            <ClientSideEvents ValueChanged="onN_Copie_Colori_Changed" />
                                        </dx:ASPxSpinEdit>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%--colonna numero copie bianco e nero eccedenti--%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Bn_Eccedenti" Caption="Copie Bianco/Nero Eccedenti" ReadOnly="true" VisibleIndex="4" EditFormSettings-CaptionLocation="Top">
                                    <EditItemTemplate>
                                        <dx:ASPxTextBox runat="server" ID="N_Copie_Bn_Eccedenti_Edit" ClientInstanceName="N_Copie_Bn_Eccedenti_Edit" Width="100%" Text='<%# Bind("N_Copie_Bn_Eccedenti") %>'></dx:ASPxTextBox>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%-- colonna numero copie colori eccedenti --%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Col_Eccedenti" Caption="Copie Colori Eccedenti" ReadOnly="true" VisibleIndex="6" EditFormSettings-CaptionLocation="Top">
                                    <EditItemTemplate>
                                        <dx:ASPxTextBox runat="server" ID="N_Copie_Col_Eccedenti_Edit" ClientInstanceName="N_Copie_Col_Eccedenti_Edit" Width="100%" Text='<%# Bind("N_Copie_Col_Eccedenti") %>'></dx:ASPxTextBox>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%-- colonna mese competenza --%>
                                <dx:GridViewDataComboBoxColumn FieldName="Mese_Competenza" Caption="Mese Di Competenza" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                    <EditItemTemplate>
                                        <dx:ASPxComboBox runat="server" ID="Printer_Mese_Competenza" ClientInstanceName="Printer_Mese_Competenza" ValueField="Mese_Competenza" Width="100%" TextField="Mese_Competenza" Value='<%# Bind ("Mese_Competenza") %>'>
                                            <Items>
                                                <dx:ListEditItem Text="Marzo" Value="Marzo" />
                                                <dx:ListEditItem Text="Giugno" Value="Giugno" />
                                                <dx:ListEditItem Text="Settembre" Value="Settembre" />
                                                <dx:ListEditItem Text="Dicembre" Value="Dicembre" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </EditItemTemplate>
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                        </dx:ASPxGridView>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="padding-bottom: 25px">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
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
                        <h4 class="card-title">Gestione Rilevamento Manutenzione</h4>

                        <%--GridView della tabella Rilevamento Manutenzione--%>
                        <dx:ASPxGridView runat="server" ID="Printer_Rilevamento_Manutenzione_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Printer_Rilevamento_Manutenzione_GW" DataSourceID="Printer_Rilevamento_Manutenzione_Dts" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID">
                            <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                            <%--Aggiunge il controllo sui filtri, il filtro si applica alla pressione del tasto invio--%>
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
                                <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                            <Columns>
                                <%-- colonna bottoni di edit --%>
                                <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="true" ShowEditButton="True" ShowDeleteButton="true" Width="80px">
                                    <CustomButtons>
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit_2" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete_2" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                    </CustomButtons>
                                </dx:GridViewCommandColumn>
                                <%-- colonna data Rilevamento Manutenzione --%>
                                <%-- <dx:GridViewDataDateColumn FieldName="Data_Rilev_Manutenzione" Caption="Data Manutenzione" VisibleIndex="1" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesDateEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>--%>
                                <%-- colonna numero Ore Manutenzione --%>
                                <dx:GridViewDataTextColumn FieldName="Ore_Manutenzione" Caption="Ore Manutenzione" VisibleIndex="3" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                    <EditItemTemplate>
                                        <dx:ASPxSpinEdit runat="server" ID="Ore_Manutenzione_Spin" ClientInstanceName="Ore_Manutenzione_Spin" Width="100%" MinValue="0.5" Increment="0.5" MaxValue="8" Text='<%# Bind("Ore_Manutenzione") %>'></dx:ASPxSpinEdit>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%-- <%--colonna descrizione manutenzione --%>
                                <dx:GridViewDataMemoColumn FieldName="Manutenzione_Desc" Caption="Descizione Manutenzione" VisibleIndex="5" EditFormSettings-CaptionLocation="Top" EditFormSettings-ColumnSpan="2">
                                    <PropertiesMemoEdit ValidationSettings-RequiredField-IsRequired="true" Rows="5" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesMemoEdit>
                                </dx:GridViewDataMemoColumn>
                                <%--<dx:GridViewDataTextColumn FieldName="Manutenzione_Desc" Caption="Descrizione Manutenzione" VisibleIndex="3" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>--%>
                                <%--colonna tecnico --%>
                                <dx:GridViewDataTextColumn FieldName="Tecnico" Caption="Tecnico" VisibleIndex="4" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <%--colonna data richiesta intervento --%>
                                <dx:GridViewDataDateColumn FieldName="Data_Richiesta" Caption="Data Richiesta Intervento" VisibleIndex="1" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesDateEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <%--colonna data chiusura intervento --%>
                                <dx:GridViewDataDateColumn FieldName="Data_Chiusura" Caption="Data Chiusura Intervento" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesDateEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                            </Columns>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- sezione consumabili --%>
    <div class="row" style="padding-bottom: 25px">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
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
                        <h4 class="card-title">Elenco Codici Consumabili</h4>

                        <%--GridView della tabella Elenco codici consumabili--%>
                        <dx:ASPxGridView runat="server" ID="Printer_Elenco_Codici_Consumabili_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Printer_Elenco_Codici_Consumabili_GW" DataSourceID="Printer_Elenco_Codici_Consumabili_Dts" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID">
                            <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                            <%--Aggiunge il controllo sui filtri, il filtro si applica alla pressione del tasto invio--%>
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
                                <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                            <Columns>
                                <%-- colonna bottoni di edit --%>
                                <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="true" ShowEditButton="True" ShowDeleteButton="true" Width="80px">
                                    <CustomButtons>
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit_3" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete_3" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                    </CustomButtons>
                                </dx:GridViewCommandColumn>
                                <%-- colonna descrizione consumabili --%>
                                <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Descrizione" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <%-- colonna codice consumabile --%>
                                <dx:GridViewDataTextColumn FieldName="Cod_Consumabile" Caption="Codice Consumabile" VisibleIndex="1" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <%-- colonna colore consumabile --%>
                                <dx:GridViewDataComboBoxColumn FieldName="Colore" VisibleIndex="3" Caption="Colore" EditFormSettings-CaptionLocation="Top">
                                    <EditItemTemplate>
                                        <dx:ASPxComboBox ID="Colore_CB" runat="server" ClientInstanceName="Colore_CB"
                                            Value='<%# Bind("Colore") %>' Width="100%"
                                            ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                            ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="none"
                                            InvalidStyle-BackColor="LightPink">
                                            <Items>
                                                <dx:ListEditItem Text="Black" Value="Black" />
                                                <dx:ListEditItem Text="Ciano" Value="Ciano" />
                                                <dx:ListEditItem Text="Magenta" Value="Magenta" />
                                                <dx:ListEditItem Text="Yellow" Value="Yellow" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </EditItemTemplate>
                                </dx:GridViewDataComboBoxColumn>
                                <%-- colonna copie stimate bianco e nero --%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Stim_BN" Caption="Numero Copie Stimate BN" VisibleIndex="4" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <%-- colonna copie stimate colore --%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Stim_Colore" Caption="Numero Copie Stimate Colore" VisibleIndex="5" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row" style="padding-bottom: 25px">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
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
                        <h4 class="card-title">Mesi rilevazione</h4>

                        <dx:ASPxGridView runat="server" ID="Rilevamento_Mesi_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Rilevamento_Mesi_GW" DataSourceID="Rilevamento_Mesi_Dts" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID">
                            <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                            <%--Aggiunge il controllo sui filtri, il filtro si applica alla pressione del tasto invio--%>
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
                                <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                            </SettingsPopup>

                            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

                            <Columns>

                                <%-- colonna bottoni di edit --%>
                                <%--  <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="true" ShowEditButton="True" ShowDeleteButton="true" Width="80px">
                                    <CustomButtons>
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                    </CustomButtons>
                                </dx:GridViewCommandColumn>--%>
                                <%-- colonna data --%>
                                <dx:GridViewDataDateColumn FieldName="DataRilevamento" Caption="Data Rilevamento" VisibleIndex="1" EditFormSettings-CaptionLocation="Top">
                                </dx:GridViewDataDateColumn>

                                <dx:GridViewDataTextColumn FieldName="Mese_Competenza" Caption="Mese" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Anno_Competenza" Caption="Anno" VisibleIndex="3" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>

                            </Columns>
                        </dx:ASPxGridView>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- SqlDataSource per FormLayout --%>
    <asp:SqlDataSource ID="Printer_Edit_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID, Modello, ID_Tipologia, Cod_Cliente, Data_Verifica, ID_Status, Matricola, Data_Prima_Installazione, N_Colori, Rif_Contratto_King, N_Copie_Bn_Comprese, N_Copie_Col_Comprese, Status_Printer, Cod_Cli_Riassegno, Ubicazione_Printer, Lettura, Mese_Lettura, Vendita FROM Printer_ANA WHERE (ID = @ID)"
        UpdateCommand="UPDATE Printer_ANA SET Modello = @Modello, ID_Tipologia = @ID_Tipologia, Cod_Cliente = @Cod_Cliente, Data_Verifica = @Data_Verifica, ID_Status = @ID_Status, Matricola = @Matricola, Data_Prima_Installazione = @Data_Prima_Installazione, N_Colori = @N_Colori, Rif_Contratto_King = @Rif_Contratto_King, N_Copie_Bn_Comprese = @N_Copie_Bn_Comprese, N_Copie_Col_Comprese = @N_Copie_Col_Comprese, Status_Printer = @Status_Printer, Cod_Cli_Riassegno = @Cod_Cli_Riassegno, Ubicazione_Printer = @Ubicazione_Printer, Lettura = @Lettura, Mese_Lettura = @Mese_Lettura, Vendita = @Vendita WHERE (ID = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Modello"></asp:Parameter>
            <asp:Parameter Name="ID_Tipologia"></asp:Parameter>
            <asp:Parameter Name="Cod_Cliente"></asp:Parameter>
            <asp:Parameter Name="Data_Verifica"></asp:Parameter>
            <asp:Parameter Name="ID_Status"></asp:Parameter>
            <asp:Parameter Name="Matricola"></asp:Parameter>
            <asp:Parameter Name="Data_Prima_Installazione"></asp:Parameter>
            <asp:Parameter Name="N_Colori"></asp:Parameter>
            <asp:Parameter Name="Rif_Contratto_King"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Bn_Comprese"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Col_Comprese"></asp:Parameter>
            <asp:Parameter Name="Status_Printer"></asp:Parameter>
            <asp:Parameter Name="Cod_Cli_Riassegno"></asp:Parameter>
            <asp:Parameter Name="Ubicazione_Printer"></asp:Parameter>
            <asp:Parameter Name="Lettura"></asp:Parameter>
            <asp:Parameter Name="Mese_Lettura"></asp:Parameter>
            <asp:Parameter Name="Vendita"></asp:Parameter>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID"></asp:QueryStringParameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <%-- SqlDataSource per ID_Tipologia --%>
    <asp:SqlDataSource ID="Printer_Id_Tipologia_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID, Tipologia FROM Tipologia_Printer_ANA"></asp:SqlDataSource>

    <%-- SqlDataSource per Codice cliente --%>
    <asp:SqlDataSource ID="Printer_Codice_Cliente_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT Clienti_King.* FROM Clienti_King"></asp:SqlDataSource>

    <%-- SqlDataSource per Status --%>
    <asp:SqlDataSource ID="Printer_Id_Status_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID, Status, ID_Semaforo FROM Status_Printer_ANA"></asp:SqlDataSource>

    <%-- SqlDatasource Rilevamento Copie --%>
    <asp:SqlDataSource ID="Printer_Rilevamento_Copie_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        DeleteCommand="DELETE FROM Printer_Rilevamento_Copie WHERE (ID = @ID)"
        InsertCommand="INSERT INTO Printer_Rilevamento_Copie(ID_Printer, DataRilevamento, N_Copie_Bn, N_Copie_Colori, N_Copie_Bn_Eccedenti, N_Copie_Col_Eccedenti, Mese_Competenza, Anno_Competenza) VALUES (@ID_Printer, @DataRilevamento, @N_Copie_Bn, @N_Copie_Colori, @N_Copie_Bn_Eccedenti, @N_Copie_Col_Eccedenti, @Mese_Competenza, YEAR(GETDATE()))"
        SelectCommand="SELECT ID, ID_Printer, DataRilevamento, N_Copie_Bn, N_Copie_Colori, N_Copie_Bn_Eccedenti, N_Copie_Col_Eccedenti, Mese_Competenza, Anno_Competenza FROM Printer_Rilevamento_Copie WHERE (ID_Printer = @id)"
        UpdateCommand="UPDATE Printer_Rilevamento_Copie SET DataRilevamento = @DataRilevamento, N_Copie_Bn = @N_Copie_Bn, N_Copie_Colori = @N_Copie_Colori, N_Copie_Bn_Eccedenti = @N_Copie_Bn_Eccedenti, N_Copie_Col_Eccedenti = @N_Copie_Col_Eccedenti, Mese_Competenza = @Mese_Competenza, Anno_Competenza = YEAR(GETDATE()) WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID_Printer"></asp:QueryStringParameter>
            <asp:Parameter Name="DataRilevamento"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Bn"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Colori"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Bn_Eccedenti"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Col_Eccedenti"></asp:Parameter>
            <asp:Parameter Name="Mese_Competenza"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DataRilevamento"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Bn"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Colori"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Bn_Eccedenti"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Col_Eccedenti"></asp:Parameter>
            <asp:Parameter Name="Mese_Competenza"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <%-- SqlDataSource Rilevamento Manutenzione --%>
    <asp:SqlDataSource ID="Printer_Rilevamento_Manutenzione_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        DeleteCommand="DELETE FROM Printer_Rilevamento_Manutenzione WHERE (ID = @ID)"
        InsertCommand="INSERT INTO Printer_Rilevamento_Manutenzione(ID_Printer, Data_Rilev_Manutenzione, Ore_Manutenzione, Manutenzione_Desc, Tecnico, Data_Richiesta, Data_Chiusura) VALUES (@ID_Printer, @Data_Rilev_Manutenzione, @Ore_Manutenzione, @Manutenzione_Desc, @Tecnico, @Data_Richiesta, @Data_Chiusura)"
        SelectCommand="SELECT ID, ID_Printer, Data_Rilev_Manutenzione, Ore_Manutenzione, Manutenzione_Desc, Tecnico, Data_Richiesta, Data_Chiusura FROM Printer_Rilevamento_Manutenzione WHERE (ID_Printer = @ID)"
        UpdateCommand="UPDATE Printer_Rilevamento_Manutenzione SET Data_Rilev_Manutenzione = @Data_Rilev_Manutenzione, Ore_Manutenzione = @Ore_Manutenzione, Manutenzione_Desc = @Manutenzione_Desc, Tecnico = @Tecnico, Data_Richiesta = @Data_Richiesta, Data_Chiusura = @Data_Chiusura WHERE (ID = @ID)">

        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID_Printer"></asp:QueryStringParameter>
            <asp:Parameter Name="Data_Rilev_Manutenzione"></asp:Parameter>
            <asp:Parameter Name="Ore_Manutenzione"></asp:Parameter>
            <asp:Parameter Name="Manutenzione_Desc"></asp:Parameter>
            <asp:Parameter Name="Tecnico"></asp:Parameter>
            <asp:Parameter Name="Data_Richiesta"></asp:Parameter>
            <asp:Parameter Name="Data_Chiusura"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Data_Rilev_Manutenzione"></asp:Parameter>
            <asp:Parameter Name="Ore_Manutenzione"></asp:Parameter>
            <asp:Parameter Name="Manutenzione_Desc"></asp:Parameter>
            <asp:Parameter Name="Tecnico"></asp:Parameter>
            <asp:Parameter Name="Data_Richiesta"></asp:Parameter>
            <asp:Parameter Name="Data_Chiusura"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <%-- SqlDataSource Codici Consumabili --%>
    <asp:SqlDataSource ID="Printer_Elenco_Codici_Consumabili_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        DeleteCommand="DELETE FROM Printer_Elenco_Codici_Consumabili WHERE (ID = @ID)"
        InsertCommand="INSERT INTO Printer_Elenco_Codici_Consumabili(ID_Printer, Descrizione, Cod_Consumabile, Colore, N_Copie_Stim_BN, N_Copie_Stim_Colore) VALUES (@ID_Printer, @Descrizione, @Cod_Consumabile, @Colore, @N_Copie_Stim_BN, @N_Copie_Stim_Colore)"
        SelectCommand="SELECT ID, ID_Printer, Descrizione, Cod_Consumabile, Colore, N_Copie_Stim_BN, N_Copie_Stim_Colore FROM Printer_Elenco_Codici_Consumabili WHERE (ID_Printer = @ID)"
        UpdateCommand="UPDATE Printer_Elenco_Codici_Consumabili SET Descrizione = @Descrizione, Cod_Consumabile = @Cod_Consumabile, Colore = @Colore, N_Copie_Stim_BN = @N_Copie_Stim_BN, N_Copie_Stim_Colore = @N_Copie_Stim_Colore WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID_Printer"></asp:QueryStringParameter>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="Cod_Consumabile"></asp:Parameter>
            <asp:Parameter Name="Colore"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Stim_BN"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Stim_Colore"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="Cod_Consumabile"></asp:Parameter>
            <asp:Parameter Name="Colore"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Stim_BN"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Stim_Colore"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="Rilevamento_Mesi_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="Printer_Mesi_Rilevazione" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
