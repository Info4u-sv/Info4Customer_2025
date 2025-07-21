<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inventario_Controllo_Articoli.aspx.cs" Inherits="INTRA.Depositi.Inventario_Controllo_Articoli" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <link rel="stylesheet" href="https://unpkg.com/intro.js/minified/introjs.min.css" />
    <script src="https://unpkg.com/intro.js/minified/intro.min.js"></script>
    <style>
        .non-controllato {
            background-color: lightcoral;
            color: black;
        }

        .controllato {
            background-color: lightgreen;
            color: black;
        }

        .dxcvCard_Office365, .dxcvFlowCard_Office365, .dxcvBreakpointsCard_Office365, .dxcvEmptyCard_Office365, .dxcvEmptyHiddenCard_Office365 {
            height: 0px !important;
        }

        .dxcvCard_Office365 {
            padding-bottom: 0px !important;
        }

        .dxcvTable_Office365 {
            padding-left: 0px !important;
            padding-right: 0px !important;
            padding-bottom: 0px !important;
            padding-top: 10px !important;
        }

        .input-group-addon, .input-group-btn {
            width: 50%;
        }

        .articoli_lbl {
            cursor: auto;
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 5px;
            padding-right: 5px;
            border: darkred 1px solid !important;
            border-radius: 5px;
        }

        .btn-conferma {
            margin-top: 8px !important;
            margin-bottom: 11px !important;
            border: forestgreen 1px solid !important;
        }

        .btn.btn-sm, .btn-group-sm .btn, .navbar .navbar-nav > li > a.btn.btn-sm, .btn-group-sm .navbar .navbar-nav > li > a.btn {
            padding: 4px 5px 5px 5px !important;
        }

        .btn-lg > span .fas, .fa {
            font-size: small !important;
        }

        .gest-art {
            width: 50% !important;
        }

        .btn-primary {
            background-color: #0055A6 !important;
        }

        .qtaOrd_lbl {
            cursor: auto;
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 5px;
            padding-right: 5px;
            border: darkblue 1px solid !important;
            border-radius: 5px;
        }

        .btn-visualizza {
            margin-top: 8px !important;
            margin-bottom: 11px !important;
            border: darkblue 1px solid !important;
        }

        .btn-cancella {
            margin-top: 8px !important;
            margin-bottom: 11px !important;
            border: darkred 1px solid !important;
        }
    </style>
    <script>
        function Add(ID, VisibleIndex, IDRiga) {
            //LoadingPanel.Show();
            var ValoreInput = document.getElementById(ID).value;
            var InputEdit = document.getElementById(ID);
            var RigaEdit = document.getElementById(IDRiga);
            console.log('ValoreInput ' + ValoreInput + ' InputEdit ' + InputEdit);
            var Incremento = "";
            if (ValoreInput != "" && ValoreInput != "." && (ValoreInput / 1) == ValoreInput) {
                Aggiungi_Inventario_Callback.PerformCallback(VisibleIndex + ";" + ValoreInput);
                RigaEdit.classList.remove("non-controllato");
                RigaEdit.classList.add("controllato");
                var Collection = document.getElementsByClassName("non-controllato");
                Articoli_Lbl.SetText("Articoli da Controllare: " + Collection.length);
                if (Collection.length == 0) {
                    Conferma_Inventario_Btn.SetEnabled(true);
                }
            }
            else {
                document.getElementById(ID).value = Incremento;
                showNotificationErrortoastr("Caratteri non ammessi");
            }
        }
        function Articoli_Lbl_Init() {
            var Collection = document.getElementsByClassName("non-controllato");
            Articoli_Lbl.SetText("Articoli da Controllare: " + Collection.length);
        }
        function Conferma_Inventario() {
            ConfermaOperazioneWithClientFunction("Conferma Inventario", "Se confermi verrà inviata un email al responsabile con il riepilogo.", "Conferma", "Annulla", Invio_Email, null, null, null);
        }
        function Invio_Email() {
            Invio_Email_Callback.PerformCallback();
        }
        function Invio_Email_Callback_EndCallback() {
            LoadingPanel.Hide();
            showNotification();
            Lista_Articoli_Cv.Refresh();
            Articoli_Cv.Refresh();
            UltimoControllo_lbl.SetText("ULTIMO CONTROLLO: " + Invio_Email_Callback.cpDataControllo);
            Lista_Articoli_Cv.EndCallback.AddHandler(function () {
                var Collection = document.getElementsByClassName("non-controllato");
                Articoli_Lbl.SetText("Articoli da Controllare: " + Collection.length);
                Conferma_Inventario_Btn.SetEnabled(Collection.length == 0);
            });
        }
        function Conferma_Ordine() {
            ConfermaOperazioneWithClientFunction("Conferma Ordine", "Confermando verrà creato l'ordine e verrà inviata un email al responsabile con il riepilogo.", "Conferma", "Annulla", Conferma, null, null, null);
        }
        function Conferma() {
            Conferma_Callback.PerformCallback();
        }
        function AggiornaGiacenza(ID, Index) {
            var ValoreInput = document.getElementById(ID).value;
            var Incremento = "1";
            if (ValoreInput != "" && ValoreInput != "." && ValoreInput != 0) {
                if (ControllaMultiplo(ValoreInput, Incremento)) {
                    AggiornaGiacenza_Callback.PerformCallback(Index + ";" + ValoreInput);
                }
                else {
                    document.getElementById(ID).value = Incremento;
                    showNotificationErrorText("Caratteri non ammessi");
                }
            }
            else {
                showNotificationErrorText("Quantità deve essere > 0");
            }
        }
        function Visualizza_Ordine() {
            Ordine_Popup.Show();
        }
        function Ordina(ID, Index) {
            var ValoreInput = document.getElementById(ID).value;
            var Incremento = "1";
            if (ValoreInput != "" && ValoreInput != "." && ValoreInput != 0) {
                if (ControllaMultiplo(ValoreInput, Incremento)) {
                    Ordina_Callback.PerformCallback(Index + ";" + ValoreInput);
                }
                else {
                    document.getElementById(ID).value = Incremento;
                    showNotificationErrorText("Caratteri non ammessi");
                }
            }
            else {
                showNotificationErrorText("Quantità deve essere > 0");
            }
        }
        function Ordina_Callback_EndCallback() {
            if (Ordina_Callback.cpQtaOrd > 0) {
                QtaOrd_Lbl.SetText("Quantità Ordine: " + Ordina_Callback.cpQtaOrd);
            }
            Conferma_Ordine_Btn.SetEnabled(Ordina_Callback.cpQtaOrd > 0);
            Visualizza_Ordine_Btn.SetEnabled(Ordina_Callback.cpQtaOrd > 0);
            Cancella_Ordine_Btn.SetEnabled(Ordina_Callback.cpQtaOrd > 0);
            Articoli_Cv.Refresh();
            Ordine_Grw.Refresh();
        }
        function Conferma_Callback_EndCallback() {
            LoadingPanel.Hide();
            Conferma_Ordine_Btn.SetEnabled(false);
            Visualizza_Ordine_Btn.SetEnabled(false);
            Cancella_Ordine_Btn.SetEnabled(false);
            QtaOrd_Lbl.SetText("Quantità Ordine: 0");
            window.location.href = "/Magazzino/Ordini_Dett.aspx?OrdNum=" + Conferma_Callback.cpOrdNum;
        }
        function Ordine_Grw_EndCallback(s, e) {
            console.log(e.command);
            if (e.command === 'UPDATEEDIT' || e.command === 'DELETEROW') {
                Articoli_Cv.Refresh();
                showNotification();
                QtaOrd_Lbl.SetText("Quantità Ordine: " + Ordine_Grw.cpQtaOrd);
                Conferma_Ordine_Btn.SetEnabled(Ordine_Grw.cpQtaOrd > 0);
                Visualizza_Ordine_Btn.SetEnabled(Ordine_Grw.cpQtaOrd > 0);
                Cancella_Ordine_Btn.SetEnabled(Ordine_Grw.cpQtaOrd > 0);
            }
        }
        function Cancella_Ordine() {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Sei sicuro di voler cancellare l'ordine?", "Conferma", "Annulla", Cancella, null, null, null);
        }
        function Cancella() {
            Cancella_Ordine_Callback.PerformCallback();
        }
        function Cancella_Ordine_Callback_EndCallback() {
            Conferma_Ordine_Btn.SetEnabled(false);
            Visualizza_Ordine_Btn.SetEnabled(false);
            Cancella_Ordine_Btn.SetEnabled(false);
            QtaOrd_Lbl.SetText("Quantità Ordine: 0");
            showNotification();
        }
        document.addEventListener('DOMContentLoaded', function () {
            introJs().setOptions({
                showProgress: true,
                showBullets: false,
                dontShowAgain: true,
                nextLabel: 'Avanti',
                prevLabel: 'Indietro',
                doneLabel: 'Fine',
                dontShowAgainLabel: 'Non mostrare più',
                disableInteraction: true
            }).start();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxLoadingPanel runat="server" ID="LoadingPanel" ClientInstanceName="LoadingPanel" Modal="true" Text="Caricamento..."></dx:ASPxLoadingPanel>
    <div class="row">
        <div class="col-md-12">
            <div class="card" style="margin-bottom: 0px !important;">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <div style="float: right;">
                        <a href="javascript: introJs().setOptions({showProgress: true,showBullets: false, nextLabel: 'Avanti',prevLabel: 'Indietro',doneLabel: 'Fine', disableInteraction: true}).start();"><i class="fa fa-info-circle" style="font-size:xx-large !important;" data-step="1" data-title="Ti trovi nella pagina per gestire la giacenza degli articoli nei depositi. Segui il tour guidato per scoprire come utilizzarla al meglio." data-intro="In qualsiasi momento puoi avviare il tour premendo questa icona."></i></a>
                    </div>
                    <h4 class="card-title">Dettaglio Deposito</h4>
                    <dx:ASPxLabel runat="server" ID="Dep_lbl" ClientInstanceName="Dep_lbl" Font-Bold="true" Font-Size="Medium"></dx:ASPxLabel>
                    <br />
                    <dx:ASPxLabel runat="server" ID="Ind_lbl" ClientInstanceName="Ind_lbl" Font-Bold="true" Font-Size="Medium"></dx:ASPxLabel>
                    <br />
                    <dx:ASPxLabel runat="server" ID="Cliente_lbl" ClientInstanceName="Cliente_lbl" Font-Bold="true" Font-Size="Medium"></dx:ASPxLabel>
                    <br />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" data-step="2" data-title="Gestione Articoli." data-intro="In questa sezione puoi ordinare o rimuovere una quantità specifica di un articolo.">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="fas fa-boxes" aria-hidden="true"></i>
                </div>
                <div class="card-content">
                    <div style="float: right; margin-right: 15px;" data-step="5" data-title="Gestione Ordine." data-intro="Da qui puoi gestire l’ordine temporaneo creato aggiungendo articoli tramite il pulsante 'Ordina'. Cliccando su 'Visualizza' potrai consultare l’ordine temporaneo, modificare le quantità o rimuovere articoli. Con 'Cancella' invece, l’ordine temporaneo verrà completamente svuotato. Infine, premendo su 'Conferma', l’ordine verrà generato e verrai reindirizzato alla pagina di dettaglio dell’ordine appena creato.">
                        <dx:BootstrapButton runat="server" ID="Conferma_Ordine_Btn" ClientInstanceName="Conferma_Ordine_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-success btn-conferma" ClientEnabled="false">
                            <Badge IconCssClass="fa fa-save" Text="CONFERMA ORDINE" />
                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                            <ClientSideEvents Click="Conferma_Ordine" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton runat="server" ID="Cancella_Ordine_Btn" ClientInstanceName="Cancella_Ordine_Btn" rel="tooltip" data-placement="top" data-original-title="Cancella Ordine" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-danger btn-cancella" ClientEnabled="false">
                            <Badge IconCssClass="fa fa-trash" Text="" />
                            <SettingsBootstrap RenderOption="Danger" Sizing="Small" />
                            <ClientSideEvents Click="Cancella_Ordine" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton runat="server" ID="Visualizza_Ordine_Btn" ClientInstanceName="Visualizza_Ordine_Btn" rel="tooltip" data-placement="top" data-original-title="Visualizza Ordine" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-primary btn-visualizza" ClientEnabled="false">
                            <Badge IconCssClass="fa fa-search" Text="" />
                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                            <ClientSideEvents Click="Visualizza_Ordine" />
                        </dx:BootstrapButton>
                        <dx:ASPxLabel runat="server" ID="QtaOrd_Lbl" ClientInstanceName="QtaOrd_Lbl" Text="Quantità Ordine: 0" BackColor="#0055A6" Font-Bold="true" ForeColor="White" Border-BorderColor="Transparent" CssClass="qtaOrd_lbl"></dx:ASPxLabel>
                    </div>
                    <h4 class="card-title">Gestione Articoli</h4>
                    <dx:ASPxCardView ID="Articoli_Cv" ClientInstanceName="Articoli_Cv" runat="server" Width="100%" Paddings-Padding="0" DataSourceID="Inventario_Dts" AutoGenerateColumns="False" KeyFieldName="ID">
                        <Settings VerticalScrollableHeight="600" />
                        <SettingsPager EndlessPagingMode="OnScroll" Mode="EndlessPaging">
                            <SettingsTableLayout ColumnCount="1" RowsPerPage="8" />
                        </SettingsPager>
                        <Columns>
                            <dx:CardViewTextColumn FieldName="CodDep" VisibleIndex="0"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="CodArt" VisibleIndex="1"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="Qta_Min" VisibleIndex="2"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="Descrizione" VisibleIndex="3"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="Misura" VisibleIndex="4"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="DescrCatM" VisibleIndex="5"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="UltimoInventario" VisibleIndex="5"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="ID" ReadOnly="True" Visible="False"></dx:CardViewTextColumn>
                        </Columns>
                        <Templates>
                            <Card>
                                <div class="col-lg-12" id="<%# Eval("ID") + "_Art_Riga" %>" style="padding: 0px !important;">
                                    <div class="col-lg-7" style="padding: 0px !important;">
                                        <div class="inline">
                                            <dx:ASPxLabel ID="CodArt" Font-Size="Large" runat="server" Text='<%# Eval("CodArt") %>' Font-Bold="true"></dx:ASPxLabel>
                                            <p style="font-size: large; display: inline;">- <%# Eval("Descrizione") %> </p>
                                        </div>
                                        <div style="margin-bottom: 10px; color: black !important">
                                            <dx:ASPxLabel ID="Categoria" runat="server" Font-Size="Medium" Text='<%# string.Format("CATEGORIA: {0}",Eval("DescrCatM")) %>'></dx:ASPxLabel>
                                        </div>
                                    </div>
                                    <div class="col-lg-5" style="display: inline-flex;">
                                        <span class="input-group-addon gest-art">Scorta Min: <%#Eval("Qta_Min") %></span>
                                        <span class="input-group-addon gest-art" style='color: <%# Convert.ToInt32(Eval("Giacenza")) < Convert.ToInt32(Eval("Qta_Min")) ? "#d43f3a" : "DarkSlateGray" %>;'>Giacenza Effettiva: <%# Eval("Giacenza") %></span>
                                    </div>
                                    <div style="display: inline-flex; float: right; padding-right: 15px; padding-top: 5px;" data-step="4" data-title="Termina." data-intro="Inserendo una quantità e premendo il pulsante, l'articolo verrà scaricato della quantità inserita.">
                                        <input type="number" style="width: 70px !important;" oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" value='1' min="1" max="999999" id="<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_Art_QtaDef_Txt" %>">
                                        <a class="btn btn-sm btn-danger" style="color: #ffffff; margin: 0px !important; border-radius: 0px !important;" href='javascript: ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Sei sicuro di voler scaricare la quantità selezionata?", "Conferma", "Annulla", function() {AggiornaGiacenza("<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_Art_QtaDef_Txt" %>",<%# Container.VisibleIndex %>);}, null, null, null);'>
                                            <span id="addCart_DS4608SR7U2101" title="Rimuovi Quantità Selezionata">
                                                <i class="fa fa-trash" style="color: white !important;"></i>
                                                <dx:ASPxLabel runat="server" Text="TERMINA" ForeColor="White"></dx:ASPxLabel>
                                            </span>
                                        </a>
                                    </div>
                                    <div style="display: inline-flex; float: right; padding-right: 15px; padding-top: 5px;" data-step="3" data-title="Ordina." data-intro="Inserendo una quantità e premendo il pulsante, l'articolo verrà aggiunto all'ordine temporaneo.">
                                        <input type="number" style="width: 75px !important;" oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" value='1' min="1" max="999999" id="<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_ArtTer_QtaDef_Txt" %>">
                                        <a class="btn btn-sm btn-primary" style="color: #ffffff; margin: 0px !important; border-radius: 0px !important;" href='javascript: ConfermaOperazioneWithClientFunction("Conferma Aggiunta", "Sei sicuro di voler aggiungere la quantità selezionata al tuo ordine?", "Conferma", "Annulla", function() {Ordina("<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_ArtTer_QtaDef_Txt" %>",<%# Container.VisibleIndex %>,"<%# Eval("ID") + "_ArtTer_Riga" %>");}, null, null, null);'>
                                            <span id="addCart_DS4608SR7U2102" title="Aggiungi all'ordine">
                                                <i class="fa fa-shopping-cart" style="color: white !important;"></i>
                                                <dx:ASPxLabel runat="server" Text="ORDINA" ForeColor="White"></dx:ASPxLabel>
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </Card>
                        </Templates>
                        <Styles>
                            <Card Border-BorderWidth="0"></Card>
                            <Table Border-BorderWidth="0"></Table>
                        </Styles>
                        <CardLayoutProperties Styles-Disabled-Border-BorderWidth="0"></CardLayoutProperties>
                    </dx:ASPxCardView>
                </div>
            </div>
        </div>

        <div class="col-md-6" data-step="6" data-title="Controllo Inventario." data-intro="In questa sezione è possibile inserire la reale giacenza degli articoli presenti nel deposito. Salvando la quantità per ogni articolo e confermando l'invetario, verranno eseguiti i movimenti per aggiornare la giacenza degli articoli. Questa sezione serve per quando viene eseguito l'inventario del deposito e si vogliono aggiornare le giacenze di tutti gli articoli.">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="fas fa-tasks" aria-hidden="true"></i>
                </div>
                <div class="card-content">
                    <div style="float: right;">
                        <dx:BootstrapButton runat="server" ID="Conferma_Inventario_Btn" ClientInstanceName="Conferma_Inventario_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-success btn-conferma" ClientEnabled="false">
                            <Badge IconCssClass="fa fa-save" Text="CONFERMA INVENTARIO" />
                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                            <ClientSideEvents Click="Conferma_Inventario" />
                        </dx:BootstrapButton>
                        <dx:ASPxLabel runat="server" ID="Articoli_Lbl" ClientInstanceName="Articoli_Lbl" Text="Articoli da Controllare: 0" BackColor="IndianRed" Font-Bold="true" ForeColor="White" Border-BorderColor="Transparent" CssClass="articoli_lbl">
                            <ClientSideEvents Init="Articoli_Lbl_Init" />
                        </dx:ASPxLabel>
                    </div>
                    <h4 class="card-title">Controllo Inventario</h4>
                    <dx:ASPxLabel runat="server" ID="UltimoControllo_lbl" ClientInstanceName="UltimoControllo_lbl" Font-Bold="true" Font-Size="Medium"></dx:ASPxLabel>
                    <br />
                    <dx:ASPxCardView ID="Lista_Articoli_Cv" ClientInstanceName="Lista_Articoli_Cv" runat="server" Width="100%" Paddings-Padding="0" DataSourceID="Inventario_Dts" AutoGenerateColumns="False" KeyFieldName="ID">
                        <Settings VerticalScrollableHeight="600" />
                        <SettingsPager EndlessPagingMode="OnScroll" Mode="EndlessPaging">
                            <SettingsTableLayout ColumnCount="1" RowsPerPage="8" />
                        </SettingsPager>
                        <Columns>
                            <dx:CardViewTextColumn FieldName="CodDep" VisibleIndex="0"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="CodArt" VisibleIndex="1"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="Qta_Min" VisibleIndex="2"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="Descrizione" VisibleIndex="3"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="Misura" VisibleIndex="4"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="DescrCatM" VisibleIndex="5"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="UltimoInventario" VisibleIndex="5"></dx:CardViewTextColumn>
                            <dx:CardViewTextColumn FieldName="ID" ReadOnly="True" Visible="False"></dx:CardViewTextColumn>
                        </Columns>
                        <Templates>
                            <Card>
                                <div class="col-lg-12 non-controllato" id="<%# Eval("ID") + "_Riga" %>" style="padding-top: 10px !important; margin: 0px !important; padding-left: 10px !important; padding-right: 10px !important;" 
                                    data-step="7" data-title="Controlla Articolo." data-intro="Inserendo una quantità e salvando, l'articolo verrà contrassegnato come controllato e lo sfondo diventerà verde. Bisogna controllare tutti gli articoli per poter confermare l'inventario. Il numero di articoli ancora da controllare è segnato in alto a destra.">
                                    <div class="col-lg-8" style="padding-left: 10px !important;">
                                        <div class="inline">
                                            <dx:ASPxLabel ID="CodArt" Font-Size="Large" runat="server" Text='<%# Eval("CodArt") %>' Font-Bold="true"></dx:ASPxLabel>
                                            <p style="font-size: large; display: inline;">- <%# Eval("Descrizione") %> </p>
                                        </div>
                                        <div style="margin-bottom: 10px; color: black !important">
                                            <dx:ASPxLabel ID="Categoria" runat="server" Font-Size="Medium" Text='<%# string.Format("CATEGORIA: {0}",Eval("DescrCatM")) %>'></dx:ASPxLabel>
                                        </div>
                                    </div>
                                    <div class="col-lg-4" style="display: inline-flex;">
                                        <span class="input-group-addon">Min: <%#Eval("Qta_Min") %></span>
                                        <%--<dx:ASPxSpinEdit runat="server" ID="Qta_Spin" ClientInstanceName="Qta_Spin" MinValue="0" MaxValue="99999999" Width="100%"></dx:ASPxSpinEdit>--%>
                                        <input type="number" style="width: 100% !important;" oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" value='<%# Eval("UltimoInventario") %>' min="0" max="999999" id="<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>">
                                        <a class="btn btn-sm btn-success" style="color: #ffffff; margin: 0px !important; border-radius: 0px !important;" href='javascript: Add("<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>",<%# Container.VisibleIndex %>,"<%# Eval("ID") + "_Riga" %>");'>
                                            <span id="addCart_DS4608SR7U2100" title="Salva la quantità nell'inventario">
                                                <i class="fa fa-save" style="color: white !important;"></i>
                                                <dx:ASPxLabel runat="server" Text="SALVA" ForeColor="White"></dx:ASPxLabel>
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </Card>
                        </Templates>
                        <Styles>
                            <Card Border-BorderWidth="0"></Card>
                            <Table Border-BorderWidth="0"></Table>
                        </Styles>
                        <CardLayoutProperties Styles-Disabled-Border-BorderWidth="0"></CardLayoutProperties>
                    </dx:ASPxCardView>
                </div>
            </div>
        </div>
    </div>

    <dx:ASPxPopupControl ID="Ordine_Popup" ClientInstanceName="Ordine_Popup" Modal="true" runat="server" PopupHorizontalAlign="WindowCenter" HeaderText="Ordine" SettingsAdaptivity-Mode="OnWindowInnerWidth" ShowPageScrollbarWhenModal="true" CloseOnEscape="false" CloseAction="CloseButton" Width="700px">
        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowTop" MaxWidth="700px" HorizontalAlign="WindowCenter" />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <dx:ASPxGridView runat="server" ID="Ordine_Grw" ClientInstanceName="Ordine_Grw" Styles-AlternatingRow-Enabled="True" Width="100%" AutoGenerateColumns="False" DataSourceID="Ordine_Dts" KeyFieldName="ID" OnRowUpdated="Ordine_Grw_RowUpdated" OnRowDeleted="Ordine_Grw_RowDeleted">
                    <ClientSideEvents EndCallback="Ordine_Grw_EndCallback" />
                    <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                    <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                    <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
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
                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Ordine" />
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
                        <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowDeleteButton="True" Width="40px"></dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="2">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataSpinEditColumn FieldName="Qta" VisibleIndex="3">
                            <PropertiesSpinEdit MinValue="1" MaxValue="9999999"></PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataTextColumn FieldName="CodDep" VisibleIndex="4">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="5">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxCallback runat="server" ID="Aggiungi_Inventario_Callback" ClientInstanceName="Aggiungi_Inventario_Callback" OnCallback="Aggiungi_Inventario_Callback_Callback">
        <ClientSideEvents BeginCallback="function(s,e){LoadingPanel.Show(); }" EndCallback="function(s,e){LoadingPanel.Hide(); showNotification(); }" />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="Invio_Email_Callback" ClientInstanceName="Invio_Email_Callback" OnCallback="Invio_Email_Callback_Callback">
        <ClientSideEvents EndCallback='Invio_Email_Callback_EndCallback' BeginCallback="function(s,e){LoadingPanel.Show();}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="AggiornaGiacenza_Callback" ClientInstanceName="AggiornaGiacenza_Callback" OnCallback="AggiornaGiacenza_Callback_Callback">
        <ClientSideEvents EndCallback='function(s,e){var errore = AggiornaGiacenza_Callback.cpError; if(errore){showNotificationErrorText("La quantità da togliere deve essere minore alla giacenza effettiva.");} else {Articoli_Cv.Refresh(); showNotification(); }}' />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="Ordina_Callback" ClientInstanceName="Ordina_Callback" OnCallback="Ordina_Callback_Callback">
        <ClientSideEvents EndCallback="Ordina_Callback_EndCallback" />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="Conferma_Callback" ClientInstanceName="Conferma_Callback" OnCallback="Conferma_Callback_Callback">
        <ClientSideEvents BeginCallback="function(s,e){LoadingPanel.Show(); }" EndCallback="Conferma_Callback_EndCallback" />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="Cancella_Ordine_Callback" ClientInstanceName="Cancella_Ordine_Callback" OnCallback="Cancella_Ordine_Callback_Callback">
        <ClientSideEvents EndCallback="Cancella_Ordine_Callback_EndCallback" />
    </dx:ASPxCallback>

    <asp:SqlDataSource runat="server" ID="Inventario_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_Inventario_Deposito.CodDep, U_Inventario_Deposito.CodArt, U_Inventario_Deposito.Qta_Min, Articoli.Descrizione, Articoli.Misura, TabCatM.Descrizione AS DescrCatM, U_Inventario_Deposito.ID, ISNULL(U_ESK_Inventario.Quantity, 0) AS UltimoInventario, ISNULL(ISNULL(SaldiMag.Giacenza, 0) + SaldiMag.Carichi - SaldiMag.Scarichi,0) AS Giacenza FROM U_Inventario_Deposito INNER JOIN Articoli ON U_Inventario_Deposito.CodArt = Articoli.CodArt INNER JOIN TabCatM ON Articoli.CodCat = TabCatM.CodCat LEFT OUTER JOIN SaldiMag ON U_Inventario_Deposito.CodDep = SaldiMag.DsSaldo AND U_Inventario_Deposito.CodArt = SaldiMag.CodArt LEFT OUTER JOIN U_ESK_Inventario ON U_Inventario_Deposito.CodDep = U_ESK_Inventario.U_CodDep AND U_Inventario_Deposito.CodArt = U_ESK_Inventario.ProductID WHERE (U_Inventario_Deposito.CodDep = @CodDep)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="CodDep" Name="CodDep"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Ordine_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT ID, CodArt, Qta, CodDep, CodCli FROM U_Ordine_Temp WHERE (CodDep = @CodDep)" DeleteCommand="DELETE FROM U_Ordine_Temp WHERE (ID = @ID)" UpdateCommand="UPDATE U_Ordine_Temp SET Qta = @Qta WHERE (ID = ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="CodDep" Name="CodDep"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Qta"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
