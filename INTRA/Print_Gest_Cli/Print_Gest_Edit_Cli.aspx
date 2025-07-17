<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Print_Gest_Edit_Cli.aspx.cs" Inherits="INTRA.Print_Gest_Cli.Print_Gest_Edit_Cli" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">


    <script>
        function OnCustomButtonClickGeneric(s, e) {
            var prelievo = "Expr1";

            Articoli_Grw.GetRowValues(e.visibleIndex, prelievo, function (value) {
                IDContratto_Txt.SetText(value);
                ArticoloPopUp.Hide();
            });
        }
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

                    if (grid.globalName == 'Printer_Rilevamento_Copie_GW') {
                        Printer_Rilevamento_Copie_GW.GetRowValues(visibleIndex, 'ID', function (value) {
                            Gestione_Copie_Delete_Callback.PerformCallback(value);
                        });
                    }
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
    <div class="row">
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
                        <div class="col-md-6">
                            <dx:ASPxCallbackPanel runat="server" ID="Edit_CallbackPnl_Callback_Cli" ClientInstanceName="Edit_CallbackPnl" OnCallback="Edit_CallbackPnl_Callback">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxFormLayout ID="Printer_Edit_Form_Cli" ClientInstanceName="Printer_Edit_Form_Cli" runat="server" DataSourceID="Printer_Edit_Dts_Cli" Width="100%">
                                            <Items>
                                                <dx:LayoutGroup Caption="Gestione Printer" GroupBoxDecoration="None" ColumnCount="1">
                                                    <Items>
                                                        <dx:LayoutGroup ColumnCount="2" ShowCaption="False">
                                                            <Items>
                                                                <dx:LayoutItem FieldName="PhotoBytes" ShowCaption="False" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxBinaryImage ID="Printer_PhotoBytes_View" runat="server" Width="50%"
                                                                                ImageHeight="170px" ImageWidth="160px" EnableServerResize="True" />
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem FieldName="Expr4" ShowCaption="False" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxBinaryImage ID="Printer_Expr4_View" runat="server" Width="50%"
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
                                                                            <dx:ASPxTextBox ID="Modello" runat="server" Width="100%" InvalidStyle-BackColor="LightPink" ReadOnly="true">
                                                                            </dx:ASPxTextBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="CodiceProdotto" Caption="Codice Prodotto" CaptionSettings-Location="Top">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxTextBox ID="Printer_CodiceProdotto_Edit" runat="server" Width="100%" ReadOnly="true">
                                                                            </dx:ASPxTextBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="Tipologia" Caption="Tipologia" CaptionSettings-Location="Top">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxTextBox ID="ID_Tipologia" runat="server" Width="100%" ReadOnly="true">
                                                                            </dx:ASPxTextBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="N_Colori" Caption="Numero di Colori" CaptionSettings-Location="Top" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxSpinEdit runat="server" ID="ASPxSpinEdit1" ClientInstanceName="Printer_N_Colori_Edit_Spin" MinValue="1" MaxValue="4" Increment="1" Width="100%" ReadOnly="true"></dx:ASPxSpinEdit>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem FieldName="Nome" Caption="Brand" CaptionSettings-Location="Top">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxTextBox ID="Nome" runat="server" Width="100%" ReadOnly="true">
                                                                            </dx:ASPxTextBox>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                            </Items>
                                                        </dx:LayoutGroup>
                                                    </Items>
                                                </dx:LayoutGroup>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
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
                                                                    <dx:ASPxTextBox runat="server" RadOnly="true" Width="100%" Enabled="false"></dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%-- Campo Codice Cliente --%>
                                                        <dx:LayoutItem FieldName="Cod_Cliente" Caption="Codice Cliente | Nome Cliente" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxComboBox runat="server" ID="Printer_Cod_Cliente_Edit" AutoPostBack="false" DataSourceID="Printer_Codice_Cliente_Dts" ValueField="CodCli" TextField="Denom" TextFormatString="{0} | {1}" Width="100%">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                        <Columns>
                                                                            <dx:ListBoxColumn FieldName="Denom"></dx:ListBoxColumn>
                                                                            <dx:ListBoxColumn FieldName="CodCli"></dx:ListBoxColumn>
                                                                        </Columns>
                                                                    </dx:ASPxComboBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
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
                                                        <%-- Campo Rif Contratto King --%>
                                                        <dx:LayoutItem FieldName="" Caption="Riferimento Contratto King" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <div class="d-flex align-items-center gap-1">
                                                                        <dx:ASPxTextBox
                                                                            ID="IDContratto_Txt"
                                                                            runat="server"
                                                                            ClientInstanceName="IDContratto_Txt"
                                                                            Width="100%" />
                                                                        <dx:BootstrapButton
                                                                            runat="server"
                                                                            ID="CodArt_Btn"
                                                                            ClientInstanceName="CodArt_Btn"
                                                                            AutoPostBack="false"
                                                                            UseSubmitBehavior="false"
                                                                            CausesValidation="false"
                                                                            Badge-CssClass="BadgeBtn"
                                                                            CssClasses-Control="btn btn-sm btn-info btn-padding-right-txtbox codart-btn-css">
                                                                            <Badge IconCssClass="fa fa-list" />
                                                                            <ClientSideEvents Click="function(s,e){ ArticoloPopUp.Show(); }" />
                                                                        </dx:BootstrapButton>
                                                                    </div>
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
                                                        <%-- Campo Totale anni noleggio --%>
                                                        <dx:LayoutItem FieldName="Totale_Anni_Noleggio" Caption="Totale Anni Noleggio" CaptionSettings-Location="Top" ColSpan="1">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxSpinEdit runat="server" Width="100%" ID="Totale_Anni_Noleggio_SE" ClientInstanceName="Totale_Anni_Noleggio_SE" Increment="1">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit"></ValidationSettings>
                                                                    </dx:ASPxSpinEdit>
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
                                <dx:ASPxButton ID="Update_Btn" ClientInstanceName="Update_Btn" runat="server" Text="Aggiorna" AutoPostBack="false" BackColor="#0055A6">
                                    <ClientSideEvents Click="function(s,e){
if(ASPxClientEdit.ValidateGroup('ValidazioneEdit')){                                
    
ConfermaOperazione('Confermi di voler aggiornare il progetto con i dati inseriti?','Update_FormLayout_Callback');
}
else{
showNotificationError('Alcuni dati non sono stati compilati, controllare e riprovare.')
}
}" />
                                </dx:ASPxButton><br /><br />
                        </div>
                        <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Text="Caricamento in corso..." Modal="true"></dx:ASPxLoadingPanel>
                        <div class="col-md-6">
                            <%--GridView della tabella Elenco codici consumabili--%>
                            <dx:ASPxGridView runat="server" ID="Printer_Elenco_Codici_Consumabili_GW_Cli" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Printer_Elenco_Codici_Consumabili_GW_Cli" DataSourceID="Printer_Elenco_Codici_Consumabili_Dts_Cli" Width="100%" Style="margin-left: 0 auto" AutoGenerateColumns="False" KeyFieldName="ID">
                                <Settings ShowGroupPanel="false" ShowHeaderFilterButton="false" ShowFilterRow="True"></Settings>
                                <%--Aggiunge il controllo sui filtri, il filtro si applica alla pressione del tasto invio--%>
                                <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="Bottom"></SettingsPager>

                                <SettingsBehavior FilterRowMode="OnClick" AllowEllipsisInText="true" />
                                <Styles AlternatingRow-Enabled="True"></Styles>
                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                <%--                                            <Toolbars>
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

                                            </Toolbars>--%>

                                <%-- Serve per farlo funzionare --%>
                                <%--                                            <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>--%>
                                <%-- export button --%>

                                <%--                                            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />--%>
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

                                <SettingsSearchPanel Visible="false"></SettingsSearchPanel>
                                <Columns>
                                    <%-- colonna bottoni di edit --%>
                                    <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" Visible="false" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="false" ShowEditButton="false" ShowDeleteButton="false" Width="80px">
                                        <%--<CustomButtons>
                                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit_3" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete_3" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                                    </CustomButtons>--%>
                                    </dx:GridViewCommandColumn>
                                    <%-- colonna codice modello --%>
                                    <dx:GridViewDataTextColumn FieldName="Expr4" Caption="Codici Consumabili" VisibleIndex="2" Width="15%" EditFormSettings-CaptionLocation="Top" ReadOnly="true" Visible="true">
                                        <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" />
                                    </dx:GridViewDataTextColumn>
                                    <%-- colonna Descrizione--%>
                                    <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Descrizione" VisibleIndex="3" ReadOnly="true" Visible="true" EditFormSettings-Visible="False">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataBinaryImageColumn FieldName="Expr5" VisibleIndex="1" Caption="Immagine" Width="15%" EditFormSettings-Visible="False">
                                        <PropertiesBinaryImage ImageWidth="50%" EnableServerResize="True">
                                        </PropertiesBinaryImage>
                                    </dx:GridViewDataBinaryImageColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="ColoreID" Caption="Colore" VisibleIndex="5" Width="80px" EditFormSettings-Visible="False" Settings-AllowHeaderFilter="False" Settings-AllowAutoFilter="false">
                                        <PropertiesComboBox DataSourceID="Printer_Elenco_Codici_Consumabili_Dts_Cli" ValueField="ID" TextField="Descrizione">
                                        </PropertiesComboBox>
                                        <DataItemTemplate>
                                            <%# GetColorDotAndName((int)Eval("ColoreID")) %>
                                        </DataItemTemplate>
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn FieldName="Expr6" Caption="Tipo Prodotto" VisibleIndex="4" Width="15%" EditFormSettings-CaptionLocation="Top" ReadOnly="true">
                                        <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" />
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>

                                <%-- callback per aggiornamento dati del FormLayout alla pressione del tasto Aggiorna --%>
                                <dx:ASPxCallback ID="Update_FormLayout_Callback" ClientInstanceName="Update_FormLayout_Callback" runat="server" OnCallback="Update_FormLayout_Callback_Callback" Style="float: right">
                                    <ClientSideEvents
                                        BeginCallback="function(s,e){LoadingPanel.Show();}"
                                        EndCallback="function(s,e){LoadingPanel.Hide(); Update_Scandenze_Copie_Callback.PerformCallback(); Edit_CallbackPnl_Callback.PerformCallback();showNotification();}" />
                                </dx:ASPxCallback>
                                <%-- callback per l'aggiornamento di gestione copie alla pressione del tasto Aggiorna --%>
                                <dx:ASPxCallback ID="Update_Scandenze_Copie_Callback" ClientInstanceName="Update_Scandenze_Copie_Callback" runat="server" OnCallback="Update_Scandenze_Copie_Callback_Callback" Style="float: right">
                                    <ClientSideEvents
                                        EndCallback="function(s,e){showNotification();Printer_Rilevamento_Copie_GW.Refresh();}" />
                                </dx:ASPxCallback>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxPopupControl runat="server" ID="ArticoloPopUp" ClientInstanceName="ArticoloPopUp" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" CloseAction="CloseButton" CloseOnEscape="true" Modal="True" Maximized="false" MinWidth="1400px"
        HeaderText="Seleziona Contratto" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="false">
        <ClientSideEvents Shown="function(s,e){Articoli_Grw.ClearFilter();}" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxGridView runat="server" ID="Articoli_Grw" ClientInstanceName="Articoli_Grw" DataSourceID="Contratti_King_Dts" KeyFieldName="Expr1" Width="100%" Styles-AlternatingRow-Enabled="True" AutoGenerateColumns="False">
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
                                <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo1" IconCssClass="icon4u icon-check-square image" CssClass="btn btn-sm btn-custom-padding action-btn go" />
                            </CustomButtons>
                        </dx:GridViewCommandColumn>
                    </Columns>
                    <Columns>
                        <dx:GridViewDataColumn FieldName="Expr1" Caption="Id Contratto" VisibleIndex="1" />
                        <dx:GridViewDataColumn FieldName="ArtMag" Caption="Art Mag" VisibleIndex="2" />
                        <dx:GridViewDataDateColumn FieldName="DataDec" Caption="Data Dec" VisibleIndex="3"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn FieldName="DataScad" Caption="Data Scad" VisibleIndex="4"></dx:GridViewDataDateColumn>
                    </Columns>
                </dx:ASPxGridView>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <%-- sezione rilevamento copie --%>
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
                        <h4 class="card-title">Gestione Copie</h4>

                        <%--GridView della tabella Rilevamento copie--%>
                        <dx:ASPxGridView runat="server" ID="Printer_Rilevamento_Copie_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Printer_Rilevamento_Copie_GW" DataSourceID="Printer_Rilevamento_Copie_Dts" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID" OnRowUpdating="Printer_Rilevamento_Copie_GW_RowUpdating" OnRowInserting="Printer_Rilevamento_Copie_GW_RowInserting">
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
                            <ClientSideEvents EndCallback="function(s, e) { ASPxClientHint.Update(); Rilevamento_Mesi_GW.Refresh() }" />
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
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Bn" Caption="Copie Bianco/Nero Rilevate" VisibleIndex="4" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                    <EditItemTemplate>
                                        <dx:ASPxSpinEdit runat="server" ID="N_Copie_Bn_Edit" ClientInstanceName="N_Copie_Bn_Edit" MinValue="0" Increment="1" Width="100%" Text='<%# Bind("N_Copie_Bn") %>'>
                                            <ClientSideEvents ValueChanged="onN_Copie_Bn_Changed" />
                                        </dx:ASPxSpinEdit>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%--colonna numero copie colori rilevate--%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Colori" Caption="Copie Colori Rilevate" VisibleIndex="6" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                    <EditItemTemplate>
                                        <dx:ASPxSpinEdit runat="server" ID="N_Copie_Colori_Edit" ClientInstanceName="N_Copie_Colori_Edit" MinValue="0" Increment="1" Width="100%" Text='<%# Bind("N_Copie_Colori") %>'>
                                            <ClientSideEvents ValueChanged="onN_Copie_Colori_Changed" />
                                        </dx:ASPxSpinEdit>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%--colonna numero copie bianco e nero eccedenti--%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Bn_Eccedenti" Caption="Copie Bianco/Nero Eccedenti" VisibleIndex="5" EditFormSettings-CaptionLocation="Top">
                                    <EditItemTemplate>
                                        <dx:ASPxTextBox runat="server" ID="N_Copie_Bn_Eccedenti_Edit" ClientInstanceName="N_Copie_Bn_Eccedenti_Edit" Width="100%" Text='<%# Bind("N_Copie_Bn_Eccedenti") %>'></dx:ASPxTextBox>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <%-- colonna numero copie colori eccedenti --%>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Col_Eccedenti" Caption="Copie Colori Eccedenti" VisibleIndex="7" EditFormSettings-CaptionLocation="Top">
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
                                <%-- colonna anno competenza --%>
                                <dx:GridViewDataTextColumn FieldName="Anno_Competenza" Caption="Anno Di Competenza" VisibleIndex="3" EditFormSettings-CaptionLocation="Top">
                                    <EditItemTemplate>
                                        <dx:ASPxTextBox runat="server" ID="Anno_Competenza" ClientInstanceName="Anno_Competenza" Width="100%" ReadOnly="true" Text='<%# Bind("Anno_Competenza") %>'></dx:ASPxTextBox>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Sezione rilevamento manutenzione --%>
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

    <%--sezione censimento mesi rilevazione--%>
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
                        <h4 class="card-title">Mesi rilevazione</h4>

                        <dx:ASPxGridView runat="server" ID="Rilevamento_Mesi_GW" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Rilevamento_Mesi_GW" DataSourceID="Rilevamento_Mesi_Dts" Width="100%" AutoGenerateColumns="False">
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

                                <dx:GridViewDataTextColumn FieldName="Mese_Competenza" Caption="Mese" VisibleIndex="3" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                    <CellStyle HorizontalAlign="Right" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Anno_Competenza" Caption="Anno" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Bn" Caption="Numero Copie B/N" VisibleIndex="4" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Bn_Eccedenti" Caption="Numero Copie B/N Eccedenti" VisibleIndex="5" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Colori" Caption="Numero Copie Colori" VisibleIndex="6" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="N_Copie_Col_Eccedenti" Caption="Numero Copie Colori Eccedenti" VisibleIndex="7" EditFormSettings-CaptionLocation="Top">
                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>

                            </Columns>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <dx:ASPxCallback runat="server" ID="Gestione_Copie_Delete_Callback" ClientInstanceName="Gestione_Copie_Delete_Callback" OnCallback="Gestione_Copie_Delete_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Printer_Rilevamento_Copie_GW.Refresh(); showNotification();}" />
    </dx:ASPxCallback>

    <%-- SqlDataSource per FormLayout --%>
    <asp:SqlDataSource ID="Printer_Edit_Dts_Cli" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        Printer_ANA.ID AS Expr1, Printer_ANA.Modello AS Expr2, Printer_ANA.ID_Tipologia AS Expr3, Multifunzione_ANA.ID, Multifunzione_ANA.Modello, Multifunzione_ANA.ID_Tipologia, Multifunzione_ANA.PhotoBytes, 
                         Multifunzione_ANA.BrandId, Multifunzione_ANA.CodiceProdotto, Multifunzione_ANA.N_Colori, Tipologia_Printer_ANA.Tipologia, Brand.Nome, Brand.PhotoBytes AS Expr4
FROM            Brand INNER JOIN
                         Multifunzione_ANA ON Brand.ID = Multifunzione_ANA.BrandId INNER JOIN
                         Tipologia_Printer_ANA ON Multifunzione_ANA.ID_Tipologia = Tipologia_Printer_ANA.ID INNER JOIN
                         Printer_ANA ON Multifunzione_ANA.ID = Printer_ANA.ID_Printer where (Printer_ANA.ID = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <%-- SqlDataSource per FormLayout --%>
    <asp:SqlDataSource ID="Printer_Edit_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID,Cod_Cliente, Data_Verifica, ID_Status, Matricola, Data_Prima_Installazione,Rif_Contratto_King, N_Copie_Bn_Comprese, N_Copie_Col_Comprese, Status_Printer, Cod_Cli_Riassegno, Ubicazione_Printer, Lettura, Mese_Lettura, Vendita, Totale_Anni_Noleggio FROM Printer_ANA WHERE (ID = @ID)"
        UpdateCommand="UPDATE Printer_ANA SET  Cod_Cliente = @Cod_Cliente,Matricola = @Matricola, Data_Prima_Installazione = @Data_Prima_Installazione, Rif_Contratto_King = @Rif_Contratto_King, N_Copie_Bn_Comprese = @N_Copie_Bn_Comprese, N_Copie_Col_Comprese = @N_Copie_Col_Comprese,Cod_Cli_Riassegno = @Cod_Cli_Riassegno, Ubicazione_Printer = @Ubicazione_Printer, Lettura = @Lettura, Mese_Lettura = @Mese_Lettura, Vendita = @Vendita, Totale_Anni_Noleggio = @Totale_Anni_Noleggio WHERE (ID = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="6" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Cod_Cliente"></asp:Parameter>
            <asp:Parameter Name="Matricola"></asp:Parameter>
            <asp:Parameter Name="Data_Prima_Installazione"></asp:Parameter>
            <asp:Parameter Name="Rif_Contratto_King"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Bn_Comprese"></asp:Parameter>
            <asp:Parameter Name="N_Copie_Col_Comprese"></asp:Parameter>
            <asp:Parameter Name="Cod_Cli_Riassegno"></asp:Parameter>
            <asp:Parameter Name="Ubicazione_Printer"></asp:Parameter>
            <asp:Parameter Name="Lettura"></asp:Parameter>
            <asp:Parameter Name="Mese_Lettura"></asp:Parameter>
            <asp:Parameter Name="Vendita"></asp:Parameter>
            <asp:Parameter Name="Totale_Anni_Noleggio"></asp:Parameter>
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
        DeleteCommand="select 1 where 1 = 2"
        InsertCommand="select 1 where 1 = 2"
        SelectCommand="SELECT ID, ID_Printer, DataRilevamento, N_Copie_Bn, N_Copie_Colori, N_Copie_Bn_Eccedenti, N_Copie_Col_Eccedenti, Mese_Competenza, Anno_Competenza, CASE WHEN Mese_Competenza = 'Gennaio' THEN 1 WHEN Mese_Competenza = 'Febbraio' THEN 2 WHEN Mese_Competenza = 'Marzo' THEN 3 WHEN Mese_Competenza = 'Aprile' THEN 4 WHEN Mese_Competenza = 'Maggio' THEN 5 WHEN Mese_Competenza = 'Giugno' THEN 6 WHEN Mese_Competenza = 'Luglio' THEN 7 WHEN Mese_Competenza = 'Agosto' THEN 8 WHEN Mese_Competenza = 'Settembre' THEN 9 WHEN Mese_Competenza = 'Ottobre' THEN 10 WHEN Mese_Competenza = 'Novembre' THEN 11 WHEN Mese_Competenza = 'Dicembre' THEN 12 END AS MeseNum FROM Printer_Rilevamento_Copie WHERE (ID_Printer = @ID_Printer) ORDER BY Anno_Competenza, MeseNum"
        UpdateCommand="select 1 where 1 = 2">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID_Printer"></asp:QueryStringParameter>
        </SelectParameters>
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
    <asp:SqlDataSource ID="Printer_Elenco_Codici_Consumabili_Dts_Cli" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        Printer_ANA.ID AS Expr1, Printer_ANA.Modello AS Expr2, Printer_ANA.ID_Tipologia AS Expr3, Multifunzione_ANA.ID, Multifunzione_ANA.Modello, Multifunzione_ANA.ID_Tipologia, Multifunzione_ANA.PhotoBytes, 
                         Multifunzione_ANA.BrandId, Multifunzione_ANA.CodiceProdotto, Multifunzione_ANA.N_Colori, Tipologia_Printer_ANA.Tipologia, Brand.Nome, Elenco_codici_consumabili_vs_printer.ID_Multifunzione, 
                         Ricambi_Consumabili.CodiceProdotto AS Expr4, Ricambi_Consumabili.Descrizione, Ricambi_Consumabili.PhotoBytes AS Expr5, Ricambi_Consumabili.ColoreID, Ricambi_Consumabili.TipoProdID, 
 Tipologia_Ricambi_Consumabili.Nome AS Expr6
FROM            Brand INNER JOIN
                         Multifunzione_ANA ON Brand.ID = Multifunzione_ANA.BrandId INNER JOIN
                         Tipologia_Printer_ANA ON Multifunzione_ANA.ID_Tipologia = Tipologia_Printer_ANA.ID INNER JOIN
                         Elenco_codici_consumabili_vs_printer ON Multifunzione_ANA.ID = Elenco_codici_consumabili_vs_printer.ID_Multifunzione INNER JOIN
                         Ricambi_Consumabili ON Elenco_codici_consumabili_vs_printer.ID_Consumabile = Ricambi_Consumabili.ID INNER JOIN
                         Printer_ANA ON Multifunzione_ANA.ID = Printer_ANA.ID_Printer INNER JOIN
                         Tipologia_Ricambi_Consumabili ON Ricambi_Consumabili.TipoProdID = Tipologia_Ricambi_Consumabili.ID
WHERE        (Printer_ANA.ID = @ID) ORDER BY
    CASE 
        WHEN Tipologia_Ricambi_Consumabili.Nome = 'Toner' THEN 0
        ELSE 1
    END,
    Tipologia_Ricambi_Consumabili.Nome;">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Rilevamento_Mesi_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="Printer_Mesi_Rilevazione" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
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
    <%-- SqlDataSource Contratti_King --%>
    <asp:SqlDataSource ID="Contratti_King_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        Clienti.CodCli, Clienti.Denom, Contratti_King.DataDec, Contratti_King.DataScad, DettVociContr_KING.IdContratto AS Expr1, DettVociContr_KING.ArtMag, Printer_ANA.ID
FROM            Contratti_King INNER JOIN
                         Clienti ON Contratti_King.CodCli = Clienti.CodCli INNER JOIN
                         DettVociContr_KING ON Contratti_King.IdContratto = DettVociContr_KING.IdContratto INNER JOIN
                         Printer_ANA ON Clienti.CodCli = Printer_ANA.Cod_Cliente
WHERE        (Contratti_King.FStato = 'A') AND (Contratti_King.TipoContr = 'FS') AND (ID = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>

