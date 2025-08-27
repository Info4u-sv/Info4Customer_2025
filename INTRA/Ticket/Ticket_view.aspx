<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ticket_view.aspx.cs" Inherits="INTRA.Ticket.Ticket_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        // Funzione che prova a cambiare il tipo dell'input (es: "text" -> "time")
        function ChangeType(s, type) {
            // Some desktop browsers throw an exception if a value of the type property is not supported.
            try {
                s.GetInputElement().type = type;
            }
            catch (err) {
                alert("\"" + type + "\"\n\r " + err.message);
            }
        }
    </script>
    <script>
        var Tempo;
        //Inizializzazione editor orario
        function OnInitTimeEdit(s, e) {
            Tempo = s.GetText();
            var editorInput = s.GetInputElement();
            editorInput.type = "time";
        }
    </script>
    <script>
        // Valida che l’orario di fine sia dopo l’inizio – usato in fase di insert
        function TimeValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            // Se l'ora fine è maggiore dell'ora inizio, tutto ok
            if (TxtOraFine_insert.GetText() > TxtOraInizio_insert.GetText()) { e.isValid = true; }
            else { e.isValid = false; }
        }
        // Stessa logica ma usata per la GridView
        function TimeValidationGridview(s, e) {
            var name = e.value;
            if (name == null)
                return;
            if (Fine_Txt.GetText() > Inizio_Txt.GetText()) { e.isValid = true; }
            else { e.isValid = false; }
        }
        // Valida un nome: deve avere almeno 2 caratteri
        function onNameValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            if (name.length < 2)
                e.isValid = false;
        }
    </script>

    <script type="text/javascript">
        // Validazione dell'area selezionata
        function onAreaValidation(s, e) {
            var SelectedIndex = e.SelectedIndex;
            if (SelectedIndex == -1) {
                return;
            }
            if (SelectedIndex > -1) {
                e.isValid = true;
            }
        }
        //Validazione nome (minimo 2 caratteri)
        function onNameValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            if (name.length < 2)
                e.isValid = false;
        }
        //Validazione tempo: fine deve essere dopo inizio
        function TimeValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            // Confronta valori tra orario fine e inizio (in formato testo tipo "08:00")
            if (TxtOraFine_insertResponsive.GetText() > TxtOraInizio_insertResponsive.GetText()) { e.isValid = true; }
            else { e.isValid = false; }
        }
        //Validazione età: solo numeri, niente zeri iniziali, minimo 18
        function onAgeValidation(s, e) {
            var age = e.value;
            if (age == null || age == "")
                return;
            var digits = "0123456789";
            // Controlla che ogni carattere sia una cifra
            for (var i = 0; i < age.length; i++) {
                if (digits.indexOf(age.charAt(i)) == -1) {
                    e.isValid = false;
                    break;
                }
            }
            // Rimuove eventuali zeri iniziali
            if (e.isValid && age.charAt(0) == '0') {
                age = age.replace(/^0+/, "");
                if (age.length == 0)
                    age = "0";
                e.value = age;
            }
            // Età deve essere almeno 18
            if (age < 18)
                e.isValid = false;
        }
        //Validazione data di arrivo: solo mese e anno corrente
        function onArrivalDateValidation(s, e) {
            var selectedDate = s.date;
            if (selectedDate == null || selectedDate == false)
                return;
            var currentDate = new Date();
            // Confronta solo mese e anno
            if (currentDate.getFullYear() != selectedDate.getFullYear() || currentDate.getMonth() != selectedDate.getMonth())
                e.isValid = false;
        }
        //Reset di tutti gli editor in un contenitore specifico
        function clearEditors(s, e) {
            var container = document.getElementsByClassName("clientContainer")[0];
            ASPxClientEdit.ClearEditorsInContainer(container);
        }
        //Colora il testo in base al valore del "Residuo"
        function ColorResiduo(Residuo, id) {
            alert('ColorResiduo');
            console.log(Residuo);
            var ResiduoNum = parseFloat(Residuo); // Converte da stringa a numero
            var Colore = '#06cb00';
            if (ResiduoNum >= 4) {
                Colore = '#06cb00';
            } if (ResiduoNum <= 0) {
                Colore = '#ea0000';
            }
            if (ResiduoNum < 4 && ResiduoNum > 0) {
                Colore = '#fdb900';
            }

            document.getElementById(id).style.color = Colore;
            //return Colore;
        }
    </script>
    <script>
        //Calcola la descrizione dell'intervento in base al tipo di esecuzione e al cliente selezionato
        function interventoPressoCalcola() {
            var selectedItem = ClientiComboBoxResponsive.GetSelectedItem();
            var selectedValue = ClientiComboBoxResponsive.GetValue();
            var selectedText = ClientiComboBoxResponsive.GetText(); // Denom

            var Rbl_TCK_TipoEsecuzione_SelectedIndex = Rbl_TCK_TipoEsecuzioneResponsive.GetSelectedIndex();
            console.log(Rbl_TCK_TipoEsecuzione_SelectedIndex);

            var InterventoPresso = "Info4u Srl";

            if ([0, 1, 5].includes(Rbl_TCK_TipoEsecuzione_SelectedIndex)) {
                if (selectedItem) {
                    InterventoPresso = selectedItem.GetColumnText("Denom") + " - " +
                        selectedItem.GetColumnText("Loc") + " - " +
                        selectedItem.GetColumnText("Ind");
                } else {
                    var loc = ClientiComboBoxResponsive.GetColumnText && ClientiComboBoxResponsive.GetColumnText("Loc");
                    var ind = ClientiComboBoxResponsive.GetColumnText && ClientiComboBoxResponsive.GetColumnText("Ind");

                    InterventoPresso = selectedText;
                    if (loc) InterventoPresso += " - " + loc;
                    if (ind) InterventoPresso += " - " + ind;
                }
            }

            InterventoPreso_TxtResponsive.SetText(InterventoPresso);
        }

        //Mostra i tecnici selezionati + eventuale data appuntamento
        function GetTecniciSelectedResponsive() {
            var TecniciSel = checkBoxList_TecniciResponsive.GetSelectedValues();
            let length = TecniciSel.length;

            var TextTecniciSelezionati = "";
            if (length > 0) {
                TextTecniciSelezionati = "Tecnici Selezionati: <br />" + TecniciSel;
            } else {
                TextTecniciSelezionati = "";
            }

            TecniciSelezionati_TxtResponsive.SetText(TextTecniciSelezionati);
            // Se è spuntata l’opzione "Invia calendar", mostra anche giorno e ora
            if (cbInviaCalendartResponsive.GetChecked()) {
                GiornoEOra_TxtResponsive.SetText("Appuntamento fissato il: <br/>" + txtDataInterventoResponsive.GetText() + " Inizio: " + TxtOraInizio_insertResponsive.GetText() + " Fine: " + TxtOraFine_insertResponsive.GetText());
            } else {
                GiornoEOra_TxtResponsive.SetText("");
            }



            console.log(TextTecniciSelezionati);
        }
        //Gestione del click sul bottone "Elimina" nella griglia dei tecnici
        function OnCustomButtonClick(s, e) {
            if (e.buttonID === "Elimina") {
                e.processOnServer = false;
                OnGetRowValuesElimina(e.visibleIndex);
            }
        }

        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction(
                "Conferma Cancellazione",
                "Confermi di voler eliminare il tecnico selezionato?",
                "Conferma",
                "Annulla",
                function () {
                    Elimina(index);
                },
                function () { },
                index,
                null
            );
        }
        //Elimina una riga dalla griglia dei tecnici
        function Elimina(valore) {
            console.log("Elimino indice: ", valore);
            Tecnici_Gridview.DeleteRow(valore);
        }
        //Gestione del click sul bottone "Elimina" nella griglia dei tecnici
        function OnCustomButtonMateriali(s, e) {
            if (e.buttonID === "EliminaMateriali") {
                e.processOnServer = false;
                OnGetRowValuesEliminaMateriali(e.visibleIndex);
            }
        }

        function OnGetRowValuesEliminaMateriali(index) {
            ConfermaOperazioneWithClientFunction(
                "Conferma Cancellazione",
                "Confermi di voler eliminare il materiale impiegato selezionato?",
                "Conferma",
                "Annulla",
                function () {
                    EliminaMateriale(index);
                },
                function () { },
                index,
                null
            );
        }
        //Elimina una riga dalla griglia dei tecnici
        function EliminaMateriale(valore) {
            console.log("Elimino indice: ", valore);
            Generic_Gridview.DeleteRow(valore);
        }
        //Conta i tecnici visibili e calcola il totale delle ore (fine-inizio)
        function aggiornaRiepilogo() {
            var grid = Tecnici_Gridview;
            var totalTecnici = grid.GetVisibleRowsOnPage();
            var totalOre = 0;
            // Loop su tutte le righe visibili
            for (var i = 0; i < grid.GetVisibleRowsOnPage(); i++) {
                var oraInizioStr = grid.GetRow(i).cells[3].innerText;
                var oraFineStr = grid.GetRow(i).cells[4].innerText;

                if (oraInizioStr && oraFineStr) {
                    var start = oraInizioStr.split(':');
                    var end = oraFineStr.split(':');
                    if (start.length === 2 && end.length === 2) {
                        var startMinutes = parseInt(start[0]) * 60 + parseInt(start[1]);
                        var endMinutes = parseInt(end[0]) * 60 + parseInt(end[1]);
                        if (endMinutes > startMinutes)
                            totalOre += (endMinutes - startMinutes) / 60;
                    }
                }
            }
            document.getElementById('totalTecnici').innerText = grid.GetVisibleRowsOnPage();
            document.getElementById('tempoTicket').innerText = totalOre.toFixed(2);
        }
    </script>
    <script>
        //Gestisce il click sul bottone "Salva" dell'edit form tecnico
        function onSaveClick(s, e) {
            e.cancel = true;

            // 1. Validazione campi con validation group
            if (!ASPxClientEdit.ValidateGroup('ValidTestataTecnico')) {
                showNotificationErrorText("Compila correttamente tutti i campi obbligatori.");
                return;
            }

            // 2. Validazione ora
            const start = Inizio_Txt.GetText();
            const end = Fine_Txt.GetText();

            if (start && end && start >= end) {
                showNotificationErrorText("L'orario di fine deve essere maggiore di quello di inizio.");
                return;
            }

            Tecnici_Gridview.UpdateEdit();
        }
        //Gestisce il click sul bottone "Annulla" nell'edit form
        function onCancelClick(s, e) {
            var grid = ASPxClientControl.GetControlCollection().GetByName("Tecnici_Gridview");
            if (grid) {
                grid.CancelEdit();
            }
        }
    </script>
    <script>
        // Quando la pagina carica, controlla larghezza finestra
        document.addEventListener('DOMContentLoaded', () => {
            const collapse1 = document.getElementById('collapse1');
            const collapse2 = document.getElementById('collapse2');
            const collapse3 = document.getElementById('collapse3');
            const collapse4 = document.getElementById('collapse4');
            if (window.innerWidth >= 992) {
                // Desktop
                collapse1.classList.add('in');  // apre il pannello
                collapse2.classList.add('in');  // apre il pannello
                collapse3.classList.add('in');  // apre il pannello
                collapse4.classList.add('in');  // apre il pannello
            } else {
                // Mobile/tablet
                collapse1.classList.remove('in'); // chiude il pannello
                collapse2.classList.remove('in'); // chiude il pannello
                collapse3.classList.remove('in'); // chiude il pannello
                collapse4.classList.remove('in'); // chiude il pannello
            }
        });
    </script>
    <script type="text/javascript">
        function ApriPDF() {
            const params = new URLSearchParams(window.location.search);
            const idTicket = params.get("IdTicket");

            if (idTicket) {
                const url = '/Ticket/ViewDoc_Empty.aspx?IdTicket=' + idTicket;
                window.open(url, '_blank');
            } else {
                alert("Impossibile generare il PDF: IdTicket non presente nella querystring.");
            }
        }
    </script>

    <script type="text/javascript">
        function getQueryStringValue(key) {
            var params = new URLSearchParams(window.location.search);
            return params.get(key);
        }
    </script>
    <style>
        .dxgvDataRow_Office365:last-child td.dxgv, .dxgvTable_Office365 {
            border-bottom: 0px solid rgba(0,0,0,0.1) !important;
        }

        .progress {
            height: 20px;
            border-radius: 8px;
        }

        .progress-bar {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .progress-bar-magenta {
            background-color: #bc5679 !important;
        }

        .progress-bar-orange {
            background-color: #ff9800 !important;
        }

        .progress-bar-azure {
            background-color: #2dc3e8 !important;
        }

        .progress-bar-darkorange {
            background-color: #ed4e2a !important;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">confirmation_number</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Gestione Ticket</h4>
                    <div class="no-padding">
                        <dx:ASPxCallbackPanel ID="StatusTicket_CallbackPnl" runat="server" ClientInstanceName="StatusTicket_CallbackPnl" OnCallback="StatusTicket_CallbackPnl_Callback">
                            <PanelCollection>
                                <dx:PanelContent>
                                    <asp:Panel ID="ApertoStatusTCK_Pnl" runat="server" Visible="false" Style="padding-right: 13px;">
                                        <div class="progress progress-striped active">
                                            <div class="progress-bar progress-bar-magenta" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                                <span>Aperto</span>
                                            </div>
                                        </div>

                                    </asp:Panel>
                                    <asp:Panel ID="AssegnatoStatusTCK_Pnl" runat="server" Visible="false">
                                        <div class="progress progress-striped active">
                                            <div class="progress-bar progress-bar-orange" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 50%">
                                                <span><strong>Assegnato</strong></span>
                                            </div>
                                        </div>

                                    </asp:Panel>
                                    <asp:Panel ID="LavorazioneStatusTCK_Pnl" runat="server" Visible="false">
                                        <div class="progress progress-striped active">
                                            <div class="progress-bar progress-bar-azure" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 75%">
                                                <span>In Lavorazione</span>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                    <asp:Panel ID="ChiusoStatusTCK_Pnl" runat="server" Visible="false">
                                        <div class="progress progress-striped active">
                                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                                <span>Chiuso</span>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                    <asp:Panel ID="Annullato_Pnl" runat="server" Visible="false">
                                        <div class="progress progress-striped active">
                                            <div class="progress-bar progress-bar-darkorange" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                                <span>Annullato</span>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                    <div style="float: right; padding-right: 10px; padding-top: 4px;">
                        <dx:BootstrapButton
                            runat="server"
                            ID="FirmaT_Btn"
                            ClientInstanceName="FirmaT_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Firma il ticket"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">

                            <Badge IconCssClass="fa fa-edit" Text="Firma Ticket" />
                            <SettingsBootstrap RenderOption="Primary" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { 
                            var idTicket = getQueryStringValue('IdTicket'); 
                            if(idTicket) window.open('Ticket_Firma.aspx?IdTicket=' + idTicket, '_blank'); 
                            else alert('IdTicket non trovato!');
    }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="GeneraPDF_Btn"
                            ClientInstanceName="GeneraPDF_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Genera il PDF del ticket"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="true">

                            <Badge IconCssClass="fa fa-search" Text="Genera PDF" />
                            <SettingsBootstrap RenderOption="Danger" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { ApriPDF(); }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="AssociaTecnico_Btn"
                            ClientInstanceName="AssociaTecnico_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Associa un tecnico al ticket"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">

                            <Badge IconCssClass="fa fa-user-plus" Text="Associa Tecnico" />
                            <SettingsBootstrap RenderOption="Info" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { AssociaTecnico_popup.Show(); }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="ModificaNoteTecnico_Btn"
                            ClientInstanceName="ModificaNoteTecnico_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Modifica le note tecnico"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">

                            <Badge IconCssClass="fa fa-edit" Text="Modifica Note Tecnico" />
                            <SettingsBootstrap RenderOption="Primary" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { ModificaNoteTecnico_popup.Show(); }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="ChiudiTicket_Btn"
                            ClientInstanceName="ChiudiTicket_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Chiudi il ticket"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">
                            <Badge IconCssClass="fa fa-check" Text="Chiudi ticket" />
                            <SettingsBootstrap RenderOption="Danger" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) {
                              e.processOnServer = false;
                              ConfermaOperazioneWithClientFunction(
                                'Conferma Chiudi Ticket',
                                'Sei sicuro di voler chiudere il ticket?',
                                'Avvia',
                                'Annulla',
                                function () {
                                  CallbackPnlFormView.PerformCallback('ChiudiTicket');
                                },
                                function () {}
                              );
                            }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="AvviaTicket_Btn"
                            ClientInstanceName="AvviaTicket_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Avvia il ticket"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">

                            <Badge IconCssClass="fa fa-play" Text="Avvia ticket" />
                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) {
                            e.processOnServer = false;

                            ConfermaOperazioneWithClientFunction(
                                'Conferma Avvio Ticket',
                                'Sei sicuro di voler avviare il ticket?',
                                'Avvia',
                                'Annulla',
                                function () { AvviaTicket_Callback.PerformCallback();  },
                                function () { }
                            );
                        }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="ForzaRiapertura_Btn"
                            ClientInstanceName="ForzaRiapertura_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Forza la riapertura ticket"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">

                            <Badge IconCssClass="fa fa-unlock" Text="Forza riapertura" />
                            <SettingsBootstrap RenderOption="Warning" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) {
                                e.processOnServer = false;

                                ConfermaOperazioneWithClientFunction(
                                    'Conferma Riapertura Forzata',
                                    'Sei sicuro di voler forzare l\'apertura del ticket?',
                                    'Conferma',
                                    'Annulla',
                                    function () { ForzaRiapertura_Callback.PerformCallback(); },
                                    function () { }
                                );
                            }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="ForzaChiusura_Btn"
                            ClientInstanceName="ForzaChiusura_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Forza la chiusura ticket"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">

                            <Badge IconCssClass="fa fa-lock" Text="Forza chiusura" />
                            <SettingsBootstrap RenderOption="Danger" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { ForzaChiusura_popup.Show(); }" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton
                            runat="server"
                            ID="TornaAllaLista_Btn"
                            ClientInstanceName="TornaAllaLista_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Torna indietro"
                            Badge-CssClass="BadgeBtn-just-icon"
                            Visible="false">

                            <Badge IconCssClass="fa fa-history" Text="Torna Alla Lista" />
                            <SettingsBootstrap RenderOption="Info" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { window.location.href = '/Ticket/Ticket_List.aspx'; }" />
                        </dx:BootstrapButton>
                    </div>
                    <div class="row">
                        <!-- Colonna 1/3 -->
                        <div class="col-md-4">
                            <div class="panel-group">
                                <div class="panel panel-default">
                                    <div class="panel-heading" style="border-bottom: 3px solid blue;">
                                        <asp:Repeater ID="RepeaterTicket" runat="server" DataSourceID="DtsTestataRapp">
                                            <ItemTemplate>
                                                <h4 class="panel-title">Ticket N°: <span style="color: red;"><%# Eval("CodRapportino") %></span>
                                                    Data: <span style="color: red;"><%# Eval("DataIns", "{0:dd/MM/yyyy}") %></span>
                                                    Stato Registrazione King: <span style="color: red;"><%# Eval("RegistrazioneRapp") %></span>
                                                    Creato da: <span style="color: red;"><%# Eval("InsertUser") %></span>
                                                </h4>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>

                            <div class="panel-group">
                                <div class="panel panel-default">
                                    <div class="panel-heading" style="border-bottom: 3px solid #ffce55;">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" href="#collapse1">Cliente</a>
                                        </h4>
                                    </div>
                                    <div id="collapse1" class="panel-collapse collapse">
                                        <div class="panel-body" style="padding: 0!important">
                                            <dx:ASPxCallbackPanel ID="CallbackPnlFormView" runat="server" ClientInstanceName="CallbackPnlFormView" OnCallback="Edit_CallbackPnl_Callback">
                                                <ClientSideEvents EndCallback="function(s, e) {
                                                var res = s.cpResult;

                                                if (res === 'OK') {
                                                    location.reload();
                                                } else if (res && res.startsWith('ERROR|')) {
                                                    var parts = res.split('|');
                                                    var errorType = parts[1];
                                                    var message = parts[2];

                                                    showNotificationErrorText(message);

                                                    if(errorType === 'TotaleOre') {
                                                        var panel = document.getElementById('summaryPanel');
                                                        if(panel) {
                                                            panel.style.borderColor = 'red';
                                                            panel.style.backgroundColor = '#f8d7da';
                                                            setTimeout(function(){
                                                                panel.style.borderColor = '#f0e1a0';
                                                                panel.style.backgroundColor = '#fff4c8';
                                                            }, 10000);
                                                        }
                                                    } else if(errorType === 'ValidationDettagliIntervento') {
                                                        var el = Rbl_TCK_StatusChiamata_chiusura.GetMainElement();
                                                        if(el) {
                                                            el.style.border = '2px solid red';
                                                            el.style.backgroundColor = '#f8d7da';

                                                            Rbl_TCK_StatusChiamata_chiusura.ValueChanged.AddHandler(function(s,e){
                                                                var el = s.GetMainElement();
                                                                if(el) {
                                                                    el.style.border = '';
                                                                    el.style.backgroundColor = '';
                                                                }
                                                            });
                                                        }
                                                    } else if(errorType === 'ValidationEseguito') {
                                                        var el = Rbl_TCK_TipoEsecuzioneResponsive.GetMainElement();
                                                        if(el) {
                                                            el.style.border = '2px solid red';
                                                            el.style.backgroundColor = '#f8d7da';

                                                            Rbl_TCK_TipoEsecuzioneResponsive.ValueChanged.AddHandler(function(s,e){
                                                                var el = s.GetMainElement();
                                                                if(el) {
                                                                    el.style.border = '';
                                                                    el.style.backgroundColor = '';
                                                                }
                                                            });
                                                        }
                                                    } else {
                                                        ASPxClientEdit.ValidateGroup('testValidation');
                                                    }
                                                } else if (res && res.startsWith('ERROR:')) {
                                                    var msg = res.substring(6);
                                                    showNotificationErrorText(msg);
                                                }
                                            }" />



                                                <PanelCollection>
                                                    <dx:PanelContent>
                                                        <asp:FormView ID="FormViewTicket" ClientInstanceName="FormViewTicket" runat="server" DataSourceID="DtsTestataRapp" Width="100%">
                                                            <EditItemTemplate>
                                                                <dx:ASPxFormLayout runat="server" ID="formlayout" ClientInstanceName="TicketAddForm" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
                                                                    <Items>
                                                                        <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0">
                                                                            <GridSettings>
                                                                                <Breakpoints>
                                                                                    <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                                                                                </Breakpoints>
                                                                            </GridSettings>

                                                                            <Paddings Padding="0px"></Paddings>
                                                                            <Items>

                                                                                <dx:LayoutItem Caption="Cliente" ColumnSpan="2">
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
                                                                                            <script>
                                                                                                function onClientiComboBoxInit(s, e) {
                                                                                                    if (s.GetValue()) {
                                                                                                        interventoPressoCalcola();
                                                                                                    }
                                                                                                };
                                                                                            </script>

                                                                                            <dx:ASPxComboBox ID="ClientiComboBox" ClientInstanceName="ClientiComboBoxResponsive" runat="server" EnableCallbackMode="false" ForceDataBinding="true"
                                                                                                ValueField="CodCli" DropDownStyle="DropDownList" TextFormatString="{0}" TextField="Denom" Value='<%# Bind("CodCli") %>' IncrementalFilteringMode="Contains" DataSourceID="Clienti_Dts">
                                                                                                <ClientSideEvents SelectedIndexChanged="function(s,e){interventoPressoCalcola();}" ValueChanged="function(s,e){interventoPressoCalcola();}" Init="onClientiComboBoxInit" />
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                                <ClearButton DisplayMode="Always"></ClearButton>
                                                                                                <Columns>
                                                                                                    <dx:ListBoxColumn FieldName="Denom" Width="100%" />
                                                                                                    <dx:ListBoxColumn FieldName="CodCli" ClientVisible="false" Caption="." Width="0px" />
                                                                                                    <dx:ListBoxColumn FieldName="Loc" ClientVisible="false" Caption="." Width="0px" />
                                                                                                    <dx:ListBoxColumn FieldName="Ind" ClientVisible="false" Caption="." Width="0px" />
                                                                                                </Columns>
                                                                                            </dx:ASPxComboBox>
                                                                                            <asp:SqlDataSource ID="Clienti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT CodCli, Denom, Ind, Loc, tel FROM Clienti where flagannullo = 0"></asp:SqlDataSource>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Area" FieldName="TCK_AreaCompetenza">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxComboBox runat="server" ID="rbtAreaAss" ClientInstanceName="rbtAreaAssResponsive" ShowImageInEditBox="True" EnableCallbackMode="false"
                                                                                                ValueType="System.Int32" Value='<%# Bind("TCK_AreaCompetenza") %>'
                                                                                                ImageUrlField="ImageUrl" TextField="Descrizione" ValueField="IdAreaAss" DropDownStyle="DropDownList"
                                                                                                DataSourceID="DtsTCK_AreaCompetenza" IncrementalFilteringMode="None" Width="100%">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                                                                <ItemImage Height="30px" Width="30px" />
                                                                                            </dx:ASPxComboBox>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>

                                                                                <dx:LayoutItem Caption="Priorità*:" FieldName="TCK_PrioritaRichiesta">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxComboBox runat="server" ID="Rbl_TCK_PrioritaRichiesta" ValueType="System.Int32" Value='<%# Bind("TCK_PrioritaRichiesta") %>' ClientInstanceName="Rbl_TCK_PrioritaRichiestaResponsive" TextField="Descrizione" ValueField="Id" DropDownStyle="DropDownList" DataSourceID="DtsTCK_PrioritaRichiesta" IncrementalFilteringMode="None" ShowImageInEditBox="True" ImageUrlField="ImageUrl">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                                                                <ItemImage Height="30px" Width="30px" />
                                                                                            </dx:ASPxComboBox>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Tipo Richiesta*:" FieldName="TCK_TipoRichiesta">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxComboBox runat="server" ID="rbtTipoChiamata" ClientInstanceName="rbtTipoChiamataResponsive" ValueType="System.Int32" Value='<%# Bind("TCK_TipoRichiesta") %>' TextField="Descrizione" ValueField="Id" ShowImageInEditBox="True" ImageUrlField="ImageUrl" DropDownStyle="DropDownList" DataSourceID="DtsTCK_TipoRichiesta" IncrementalFilteringMode="None">
                                                                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                                                                <ItemImage Height="30px" Width="30px" />
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxComboBox>

                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Da Eseguire*:" FieldName="TCK_TipoEsecuzione">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxComboBox runat="server" ID="Rbl_TCK_TipoEsecuzione" ClientInstanceName="Rbl_TCK_TipoEsecuzioneResponsive" ValueType="System.Int32" Value='<%# Bind("TCK_TipoEsecuzione") %>' TextField="Descrizione" ValueField="Id" DropDownStyle="DropDownList" ShowImageInEditBox="True" ImageUrlField="ImageUrl" DataSourceID="DtsTCK_TipoEsecuzione" IncrementalFilteringMode="None">
                                                                                                <ClientSideEvents SelectedIndexChanged="function(s,e){interventoPressoCalcola();}" />
                                                                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                                                                <ItemImage Height="30px" Width="30px" />
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxComboBox>

                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Intervento Presso:" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>

                                                                                            <dx:ASPxCallbackPanel ID="InterventoPResso_CallbackPnl" ClientInstanceName="InterventoPResso_CallbackPnl" runat="server" Width="100%" OnCallback="MotivoChiamata_CallbackPnl_Callback">
                                                                                                <SettingsLoadingPanel Enabled="false" />
                                                                                                <PanelCollection>
                                                                                                    <dx:PanelContent>
                                                                                                        <dx:ASPxTextBox ID="InterventoPreso_Txt" ClientInstanceName="InterventoPreso_TxtResponsive" runat="server" NullText="Intervento Presso?" Width="100%">
                                                                                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                                <RequiredField IsRequired="True"></RequiredField>
                                                                                                            </ValidationSettings>
                                                                                                        </dx:ASPxTextBox>
                                                                                                    </dx:PanelContent>
                                                                                                </PanelCollection>
                                                                                            </dx:ASPxCallbackPanel>

                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutGroup ShowCaption="False" ColumnCount="2">
                                                                                    <Items>
                                                                                        <dx:LayoutItem Caption="Contatto:">
                                                                                            <LayoutItemNestedControlCollection>
                                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                                    <dx:ASPxTextBox ID="Contatto_Txt_DX" runat="server" Text='<%# Bind("PersonaDaContattare") %>' NullText="Contatto?">
                                                                                                    </dx:ASPxTextBox>
                                                                                                </dx:LayoutItemNestedControlContainer>
                                                                                            </LayoutItemNestedControlCollection>
                                                                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                        </dx:LayoutItem>
                                                                                        <dx:LayoutItem Caption="Telefono:">
                                                                                            <LayoutItemNestedControlCollection>
                                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                                    <dx:ASPxTextBox ID="Telefono_Txt_DX" runat="server" Text='<%# Bind("Telefono") %>' NullText="Telefono?">
                                                                                                    </dx:ASPxTextBox>
                                                                                                </dx:LayoutItemNestedControlContainer>
                                                                                            </LayoutItemNestedControlCollection>
                                                                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                        </dx:LayoutItem>
                                                                                    </Items>
                                                                                </dx:LayoutGroup>
                                                                                <dx:LayoutItem Caption="Email:" ColumnSpan="2">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxTextBox ID="Email_Txt_DX" runat="server" Text='<%# Bind("Email") %>' NullText="Email?">
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink" />
                                                                                                    <RegularExpression ValidationExpression="^$|^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$" ErrorText="Inserisci una email valida" />
                                                                                                </ValidationSettings>
                                                                                                <InvalidStyle BackColor="LightPink" />
                                                                                            </dx:ASPxTextBox>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Oggetto della chiamata:" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxMemo ID="OggettoTck_Memo" Rows="2" runat="server" Text='<%# Bind("OggettoTCK") %>' NullText="Oggetto della chiamata?">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxMemo>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Motivo della chiamata:" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>

                                                                                            <dx:ASPxMemo ID="Motivo_Chiamata_Txt_DX" Rows="5" runat="server" Text='<%# Bind("MotivoChiamata") %>' NullText="Motivo della chiamata?">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxMemo>

                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                            </Items>
                                                                        </dx:LayoutGroup>
                                                                    </Items>
                                                                    <Paddings Padding="0px"></Paddings>
                                                                </dx:ASPxFormLayout>
                                                                </div>                </div>
            </div>
        </div>
    </div>                                                         
                                                            </EditItemTemplate>
                                                        </asp:FormView>
                                                        <dx:BootstrapButton runat="server" ID="UpdateTicketBtn" ClientInstanceName="UpdateTicketBtn" AutoPostBack="false"
                                                            Badge-CssClass="BadgeBtn-just-icon"
                                                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-success">

                                                            <Badge IconCssClass="fa fa-sync" Text="AGGIORNA" />
                                                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />

                                                            <ClientSideEvents Click="function(s,e){
    var valid = ASPxClientEdit.ValidateGroup('testValidation');
    if(valid){                                
        ConfermaOperazione('Confermi di voler aggiornare il ticket con i dati inseriti?','Update_FormLayout_Callback');
    } else {
        showNotificationErrorWithText('Alcuni dati non sono stati compilati, controllare e riprovare.');
    }
}" />
                                                        </dx:BootstrapButton>
                                                    </dx:PanelContent>
                                                </PanelCollection>
                                            </dx:ASPxCallbackPanel>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="panel panel-default">
                                <div class="panel-heading" style="border-bottom: 3px solid #6a5acd;">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse2">Spese</a>
                                    </h4>
                                </div>
                                <div id="collapse2" class="panel-collapse collapse">
                                    <div class="panel-body" style="padding: 0!important">
                                        <dx:ASPxCallbackPanel ID="CallbackPnlFormViewSpese" runat="server" ClientInstanceName="CallbackPnlFormViewSpese" OnCallback="Edit_CallbackPnl_Callback">
                                            <PanelCollection>
                                                <dx:PanelContent>
                                                    <asp:FormView ID="FormViewTicketSpese" ClientInstanceName="FormViewTicketSpese" runat="server" DataSourceID="DtsTestataRapp" Width="100%">
                                                        <EditItemTemplate>
                                                            <dx:ASPxFormLayout runat="server" ID="TicketAddFormSpese" ClientInstanceName="TicketAddFormSpese" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
                                                                <Items>
                                                                    <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0">
                                                                        <GridSettings>
                                                                            <Breakpoints>
                                                                                <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                                                                            </Breakpoints>
                                                                        </GridSettings>

                                                                        <Paddings Padding="0px" />
                                                                        <Items>

                                                                            <dx:LayoutGroup GroupBoxDecoration="None" ColCount="2">
                                                                                <SettingsItemCaptions Location="Top" />
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="Diritto Fisso:" FieldName="DirittoFisso">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtDirittoFisso" runat="server" Text='<%# Bind("DirittoFisso") %>' NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationSpese">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>

                                                                                    <dx:LayoutItem Caption="Spese di Viaggio Km:" FieldName="SpeseViaggioKm">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtSpeseViaggioKm" runat="server" Text='<%# Bind("SpeseViaggioKm") %>' NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationSpese">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>
                                                                                </Items>
                                                                            </dx:LayoutGroup>

                                                                            <dx:LayoutGroup GroupBoxDecoration="None" ColCount="2">
                                                                                <SettingsItemCaptions Location="Top" />
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="Tariffa Oraria:" FieldName="TariffaOraria">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtTariffaOraria" runat="server" Text='<%# Bind("TariffaOraria") %>' NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationSpese">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>

                                                                                    <dx:LayoutItem Caption="Spese di Viaggio €:" FieldName="SpeseViaggioEuro">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtSpeseViaggioEuro" runat="server" Text='<%# Bind("SpeseViaggioEuro") %>' NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationSpese">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>
                                                                                </Items>
                                                                            </dx:LayoutGroup>

                                                                            <dx:LayoutGroup GroupBoxDecoration="None" ColCount="1">
                                                                                <SettingsItemCaptions Location="Top" />
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="Totale a Forfait €:" FieldName="TotaleEuroForfait">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtTotaleEuroForfait" runat="server" Text='<%# Bind("TotaleEuroForfait") %>' NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationSpese">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
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
                                                        </EditItemTemplate>
                                                    </asp:FormView>
                                                    <dx:BootstrapButton runat="server" ID="BootstrapButton3" ClientInstanceName="UpdateTicketBtn" AutoPostBack="false"
                                                        Badge-CssClass="BadgeBtn-just-icon"
                                                        CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-success">

                                                        <Badge IconCssClass="fa fa-sync" Text="AGGIORNA" />
                                                        <SettingsBootstrap RenderOption="Success" Sizing="Small" />

                                                        <ClientSideEvents Click="function(s,e){
    var valid = ASPxClientEdit.ValidateGroup('ValidationSpese');
    if(valid){                                
        ConfermaOperazione('Confermi di voler aggiornare il ticket con i dati inseriti?','Update_FormViewTicketSpese_Callback');
    } else {
        showNotificationErrorWithText('Alcuni dati non sono stati compilati, controllare e riprovare.');
    }
}" />
                                                    </dx:BootstrapButton>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </div>
                                </div>
                            </div>


                            <div class="panel panel-default">
                                <div class="panel-heading" style="border-bottom: 3px solid #fb6e52;">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse3">Materiali Impiegati </a>
                                    </h4>
                                </div>
                                <div id="collapse3" class="panel-collapse collapse">
                                    <div class="panel-body" style="padding: 0!important">
                                        <dx:ASPxCallbackPanel ID="CallbackPnlFormViewMateriali" runat="server" ClientInstanceName="CallbackPnlFormViewMateriali" OnCallback="Edit_CallbackPnl_Callback">
                                            <PanelCollection>
                                                <dx:PanelContent>
                                                    <asp:FormView ID="FormViewTicketMateriali" ClientInstanceName="FormViewTicketMateriali" runat="server" Width="100%">
                                                        <InsertItemTemplate>
                                                            <dx:ASPxFormLayout runat="server" ID="TicketAddFormMateriali" ClientInstanceName="TicketAddFormMateriali" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
                                                                <Items>
                                                                    <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0">
                                                                        <GridSettings>
                                                                            <Breakpoints>
                                                                                <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                                                                            </Breakpoints>
                                                                        </GridSettings>

                                                                        <Paddings Padding="0px" />
                                                                        <Items>

                                                                            <dx:LayoutGroup GroupBoxDecoration="None" ColCount="2">
                                                                                <SettingsItemCaptions Location="Top" />
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="Codice: " FieldName="CodMateriale">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtCodMateriale" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>

                                                                                    <dx:LayoutItem Caption="Descrizione: " FieldName="Descrizione">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtDescrizione" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>
                                                                                </Items>
                                                                            </dx:LayoutGroup>

                                                                            <dx:LayoutGroup GroupBoxDecoration="None" ColCount="2">
                                                                                <SettingsItemCaptions Location="Top" />
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="UM: " FieldName="Um">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtUm" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>

                                                                                    <dx:LayoutItem Caption="Qta*: " FieldName="Qta">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxSpinEdit ID="TxtQta" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxSpinEdit>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>
                                                                                </Items>
                                                                            </dx:LayoutGroup>

                                                                        </Items>
                                                                    </dx:LayoutGroup>
                                                                </Items>
                                                            </dx:ASPxFormLayout>
                                                        </InsertItemTemplate>
                                                        <EditItemTemplate>
                                                            <dx:ASPxFormLayout runat="server" ID="TicketAddFormMateriali" ClientInstanceName="TicketAddFormMateriali" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
                                                                <Items>
                                                                    <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0">
                                                                        <GridSettings>
                                                                            <Breakpoints>
                                                                                <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                                                                            </Breakpoints>
                                                                        </GridSettings>

                                                                        <Paddings Padding="0px" />
                                                                        <Items>

                                                                            <dx:LayoutGroup GroupBoxDecoration="None" ColCount="2">
                                                                                <SettingsItemCaptions Location="Top" />
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="Codice: " FieldName="CodMateriale">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtCodMateriale" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>

                                                                                    <dx:LayoutItem Caption="Descrizione: " FieldName="Descrizione">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtDescrizione" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>
                                                                                </Items>
                                                                            </dx:LayoutGroup>

                                                                            <dx:LayoutGroup GroupBoxDecoration="None" ColCount="2">
                                                                                <SettingsItemCaptions Location="Top" />
                                                                                <Items>
                                                                                    <dx:LayoutItem Caption="UM: " FieldName="Um">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxTextBox ID="TxtUm" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxTextBox>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>

                                                                                    <dx:LayoutItem Caption="Qta*: " FieldName="Qta">
                                                                                        <LayoutItemNestedControlCollection>
                                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                                <dx:ASPxSpinEdit ID="TxtQta" runat="server" NullText="">
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationMateriali">
                                                                                                        <ErrorFrameStyle BackColor="LightPink" />
                                                                                                        <RequiredField IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                </dx:ASPxSpinEdit>
                                                                                            </dx:LayoutItemNestedControlContainer>
                                                                                        </LayoutItemNestedControlCollection>
                                                                                    </dx:LayoutItem>
                                                                                </Items>
                                                                            </dx:LayoutGroup>
                                                                        </Items>
                                                                    </dx:LayoutGroup>
                                                                </Items>
                                                            </dx:ASPxFormLayout>
                                                        </EditItemTemplate>
                                                    </asp:FormView>
                                                    <dx:BootstrapButton runat="server" ID="BootstrapButton5" ClientInstanceName="UpdateTicketBtn" AutoPostBack="false"
                                                        Badge-CssClass="BadgeBtn-just-icon"
                                                        CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-success">

                                                        <Badge IconCssClass="fa fa-sync" Text="INSERISCI MATERIALE" />
                                                        <SettingsBootstrap RenderOption="Success" Sizing="Small" />

                                                        <ClientSideEvents Click="function(s,e){
    var valid = ASPxClientEdit.ValidateGroup('ValidationMateriali');
    if(valid){                                
        ConfermaOperazione('Confermi di voler aggiornare il ticket con i dati inseriti?','Update_FormViewTicketMateriali_Callback');
    } else {
        showNotificationErrorWithText('Alcuni dati non sono stati compilati, controllare e riprovare.');
    }
}" />
                                                    </dx:BootstrapButton>

                                                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="DtsMateriali" KeyFieldName="id" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" OnRowUpdating="Generic_Gridview_RowUpdating" OnRowDeleting="Generic_Gridview_RowDeleting">
                                                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                                                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                                                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showNotification();}}" CustomButtonClick="OnCustomButtonMateriali" />
                                                        <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>
                                                        <SettingsPopup>
                                                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                                                        </SettingsPopup>
                                                        <SettingsCustomizationDialog Enabled="true" />

                                                        <Settings ShowFilterRow="false"></Settings>
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
                                                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm"></SettingsEditing>
                                                        <Columns>
                                                            <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="false" ShowClearFilterButton="false" Width="60px">
                                                                <CustomButtons>
                                                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="EliminaMateriali" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                                                </CustomButtons>
                                                            </dx:GridViewCommandColumn>
                                                        </Columns>
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="CodRapportino" VisibleIndex="1" EditFormSettings-Visible="False" Width="80px" Visible="false"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="CodMateriale" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                                                <PropertiesTextEdit>
                                                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                    </ValidationSettings>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                                                <PropertiesTextEdit>
                                                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                    </ValidationSettings>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Um" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                                                <PropertiesTextEdit>
                                                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                    </ValidationSettings>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataSpinEditColumn FieldName="Qta" VisibleIndex="2" Width="80px" EditFormSettings-CaptionLocation="Top">
                                                                <PropertiesSpinEdit MinValue="1" MaxValue="10000">
                                                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                        <RequiredField IsRequired="False"></RequiredField>
                                                                    </ValidationSettings>
                                                                </PropertiesSpinEdit>
                                                            </dx:GridViewDataSpinEditColumn>
                                                        </Columns>
                                                        <dx:EditFormLayoutProperties ColCount="2" SettingsItemCaptions-Location="Top">
                                                            <Items>
                                                                <dx:GridViewColumnLayoutItem ColumnName="CodMateriale" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                <dx:GridViewColumnLayoutItem ColumnName="Descrizione" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                <dx:GridViewColumnLayoutItem ColumnName="HexCUmolor" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                <dx:GridViewColumnLayoutItem ColumnName="Qta" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                                                            </Items>
                                                        </dx:EditFormLayoutProperties>
                                                    </dx:ASPxGridView>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </div>
                                </div>
                            </div>

                            <div class="panel panel-default">
                                <div class="panel-heading" style="border-bottom: 3px solid #ffa500;">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapse4">Allegati Ticket </a>
                                    </h4>
                                </div>
                                <div id="collapse4" class="panel-collapse collapse">
                                    <div class="panel-body" style="padding: 0!important">
                                        <dx:ASPxCallbackPanel ID="CallbackPnlAllegatiTicket" runat="server" ClientInstanceName="CallbackPnlAllegatiTicket" OnCallback="Edit_CallbackPnl_Callback">
                                            <PanelCollection>
                                                <dx:PanelContent>
                                                    <dx:ASPxGridView ID="AllegatiTck_Gridview" DataSourceID="AllegatiTck_Dts" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID">
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="ID" Caption="" Width="0" ReadOnly="True" Visible="false" VisibleIndex="3">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="DisplayName" Caption="Nome" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Description" Caption="Descrizione" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Visualizza" VisibleIndex="2">
                                                                <DataItemTemplate>
                                                                    <a href='<%# ResolveUrl("~/" + Eval("PathFolder")) %>' target="_blank">
                                                                        <dx:ASPxImage ID="File_Img" runat="server" ImageUrl="../img/pdf.png" Width="30px" ToolTip="Apri File"></dx:ASPxImage>
                                                                    </a>
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                    </dx:ASPxGridView>
                                                    <asp:SqlDataSource ID="AllegatiTck_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, PathFolder, DisplayName, Description FROM PRT_DocumentiTCK WHERE (IDTicket = @IdTicket)">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="IdTicket" Name="IdTicket"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Colonna 2/3 -->
                        <div class="col-md-8">
                            <dx:ASPxGridView ID="Tecnici_Gridview" runat="server" Width="100%"
                                ClientInstanceName="Tecnici_Gridview"
                                DataSourceID="DtsTecnici"
                                KeyFieldName="Id"
                                AutoGenerateColumns="False"
                                SettingsBehavior-EnableCallback="true"
                                Settings-ShowFooter="false"
                                Styles-AlternatingRow-Enabled="True"
                                OnInitNewRow="Tecnici_Gridview_InitNewRow"
                                OnRowInserted="Tecnici_Gridview_RowInserted"
                                OnRowInserting="Tecnici_Gridview_RowInserting"
                                OnRowUpdating="Tecnici_Gridview_RowUpdating" OnRowDeleted="Tecnici_Gridview_RowDeleted" OnCustomUnboundColumnData="Tecnici_Gridview_CustomUnboundColumnData" OnDataBound="Tecnici_Gridview_DataBound">
                                <ClientSideEvents EndCallback="function(s,e){

    if(e.command === 'UPDATEEDIT' || e.command === 'DELETEROW' || e.command === 'NEWROW') {
        aggiornaRiepilogo();
        showNotification();
    }
}"
                                    CustomButtonClick="OnCustomButtonClick" />
                                <SettingsCommandButton RenderMode="Image">
                                    <DeleteButton>
                                        <Image Url="../img/DevExButton/delete.png" Width="30px" ToolTip="Elimina" />
                                    </DeleteButton>
                                    <NewButton>
                                        <Image Url="../img/DevExButton/new.png" Width="30px" ToolTip="Nuovo Tecnico" />
                                    </NewButton>
                                    <EditButton>
                                        <Image Url="../img/DevExButton/edit.png" Width="30px" ToolTip="Modifica" />
                                    </EditButton>
                                    <CancelButton>
                                        <Image Url="../img/DevExButton/cancel.png" Width="30px" ToolTip="Annulla Modifiche" />
                                    </CancelButton>
                                    <UpdateButton>
                                        <Image Url="../img/DevExButton/save.png" Width="30px" ToolTip="Salva" />
                                    </UpdateButton>
                                </SettingsCommandButton>
                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                <SettingsEditing Mode="EditForm" EditFormColumnCount="1" />
                                <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />
                                <Columns>
                                    <dx:GridViewCommandColumn VisibleIndex="0" ShowEditButton="true" ShowDeleteButton="false" ShowNewButtonInHeader="true" Width="60px">
                                        <CustomButtons>
                                            <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                        </CustomButtons>
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="Utente" Caption="Tecnico" VisibleIndex="1" PropertiesComboBox-ValidationSettings-RequiredField-IsRequired="true">
                                        <PropertiesComboBox DataSourceID="Tecnici_Dts" TextField="UserName" ValueType="System.String" Width="100%">
                                            <ValidationSettings SetFocusOnError="True" ErrorDisplayMode="None">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                            <ClientSideEvents Validation="onNameValidation" />
                                            <InvalidStyle BackColor="LightPink" />
                                        </PropertiesComboBox>
                                        <DataItemTemplate>
                                            <%# Eval("Utente")%>
                                        </DataItemTemplate>
                                        <EditFormSettings ColumnSpan="2" />
                                    </dx:GridViewDataComboBoxColumn>

                                    <dx:GridViewDataDateColumn FieldName="DataIntervento" VisibleIndex="2" Caption="Data Intervento" ReadOnly="false" EditFormSettings-Visible="true">
                                        <EditItemTemplate>
                                            <dx:ASPxDateEdit ID="DataInterventoEdit" runat="server" Width="100%"
                                                Value='<%# Bind("DataIntervento") %>' />
                                        </EditItemTemplate>
                                    </dx:GridViewDataDateColumn>

                                    <dx:GridViewDataTimeEditColumn UnboundType="DateTime" HeaderStyle-Wrap="True" FieldName="OraInizioVuota" Caption="Ora Inizio" VisibleIndex="2" PropertiesTimeEdit-DisplayFormatString="g" PropertiesTimeEdit-ValidationSettings-RequiredField-IsRequired="true">

                                        <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">
                                            <ClientSideEvents Init="function (s, e) { ChangeType(s, 'time'); }" />
                                            <ValidationSettings SetFocusOnError="True" ErrorDisplayMode="None">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                            <ClientSideEvents Validation="onNameValidation" />
                                        </PropertiesTimeEdit>
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                    </dx:GridViewDataTimeEditColumn>
                                    <dx:GridViewDataTimeEditColumn UnboundType="DateTime" HeaderStyle-Wrap="True" FieldName="OraFineVuota" Caption="Ora Fine" VisibleIndex="3" PropertiesTimeEdit-DisplayFormatString="g" PropertiesTimeEdit-ValidationSettings-RequiredField-IsRequired="true">

                                        <PropertiesTimeEdit DisplayFormatString="HH:mm" EditFormat="Custom" EditFormatString="HH:mm">
                                            <ClientSideEvents Init="function (s, e) { ChangeType(s, 'time'); }" />
                                            <ValidationSettings SetFocusOnError="True" ErrorDisplayMode="None">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                            <ClientSideEvents Validation="TimeValidationGridview" />
                                        </PropertiesTimeEdit>
                                    </dx:GridViewDataTimeEditColumn>
                                </Columns>
                                <Templates>
                                    <EditForm>
                                        <div class="row">
                                            <div class="col-lg-12 col-md-12 col-xs-12">
                                                <label>Tecnico</label>
                                                <dx:ASPxComboBox ID="Tecnici_Combobox" runat="server"
                                                    DataSourceID="Tecnici_Dts" TextField="UserName" ValueField="UserName"
                                                    Value='<%# Bind("Utente") %>' Width="100%">
                                                    <ValidationSettings SetFocusOnError="True" ValidationGroup="ValidTestataTecnico" ErrorDisplayMode="None">
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents Validation="onNameValidation" />
                                                    <InvalidStyle BackColor="LightPink" />
                                                </dx:ASPxComboBox>
                                            </div>
                                            <div class="col-lg-12 col-md-12 col-xs-12">
                                                Data Intervento:
                                            <dx:ASPxDateEdit ID="DataInterventoEdit" runat="server" Width="100%"
                                                Value='<%# Eval("DataIntervento") != null ? Eval("DataIntervento") : DateTime.Now %>'>
                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidTestataTecnico">
                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-xs-6">
                                                Inizio:<dx:ASPxTextBox ID="Inizio_Txt" DisplayFormatString="HH:mm" Text='<%# (Eval("OraInizioVuota") != null) ? Convert.ToDateTime(Eval("OraInizioVuota")).ToShortTimeString() : "" %>' ClientInstanceName="Inizio_Txt" runat="server" Native="true" Width="100%">
                                                    <ClientSideEvents Init='OnInitTimeEdit' />
                                                    <ValidationSettings SetFocusOnError="True" ValidationGroup="ValidTestataTecnico" ErrorDisplayMode="None">
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents Validation="onNameValidation" />
                                                    <InvalidStyle BackColor="LightPink" />
                                                </dx:ASPxTextBox>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-xs-6">
                                                Fine:<dx:ASPxTextBox ID="Fine_Txt" DisplayFormatString="HH:mm" ClientInstanceName="Fine_Txt" Text='<%# (Eval("OraFineVuota") != null) ?  Convert.ToDateTime(Eval("OraFineVuota")).ToShortTimeString() : "" %>' runat="server" Native="true" Width="100%">
                                                    <ClientSideEvents Init="OnInitTimeEdit" />
                                                    <ValidationSettings SetFocusOnError="True" ValidationGroup="ValidTestataTecnico" ErrorDisplayMode="None" ErrorText="Hai impostato un orario di fine inferiore all'orario di inizio">
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents Validation="TimeValidationGridview" />
                                                    <InvalidStyle BackColor="LightPink" />
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4  col-xs-4">
                                            <dx:ASPxLabel ID="IdTecnico_Lbl" runat="server" Text='<%# Bind("Id") %>' ClientVisible="false"></dx:ASPxLabel>
                                        </div>
                                        <dx:BootstrapButton runat="server" ClientInstanceName="btnUpdateCustom" ID="btnUpdateCustom" CommandName="Update"
                                            AutoPostBack="false" ValidationGroup="ValidTestataTecnico" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                                            <Badge IconCssClass="fa fa-save" />
                                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                            <ClientSideEvents Click="onSaveClick" />
                                        </dx:BootstrapButton>
                                        <dx:BootstrapButton runat="server" ID="btnCancelCustom" CommandName="Cancel"
                                            AutoPostBack="false" ClientInstanceName="btnCancelCustom"
                                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding" Badge-CssClass="BadgeBtn-just-icon">
                                            <Badge IconCssClass="fa fa-times" />
                                            <SettingsBootstrap RenderOption="Danger" Sizing="Small" />
                                            <ClientSideEvents Click="onCancelClick" />
                                        </dx:BootstrapButton>
                                        </div>
                                    </EditForm>
                                </Templates>
                            </dx:ASPxGridView>
                            <div id="summaryPanel" style="background-color: #fff4c8; padding: 10px; border: 1px solid #f0e1a0; margin-top: 10px; font-weight: bold; color: #4a4a00;">
                                <i class="fa fa-info-circle"></i>&nbsp; Totale Tecnici: <span id="totalTecnici">0</span> &nbsp;&nbsp; 
    Tempo Ticket: <span id="tempoTicket">0</span> Ore
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-content">
                                            <dx:ASPxCallbackPanel ID="CallbackPnlFormViewEseguito" runat="server" ClientInstanceName="CallbackPnlFormViewEseguito" OnCallback="Eseguito_CallbackPnl_Callback">
                                                <PanelCollection>
                                                    <dx:PanelContent>
                                                        <asp:FormView ID="FormViewEseguito" ClientInstanceName="FormViewEseguito" runat="server" DataSourceID="DtsTestataRapp" Width="100%" DefaultMode="Edit">
                                                            <EditItemTemplate>
                                                                <dx:ASPxFormLayout runat="server" ID="FormViewEseguito" ClientInstanceName="FormViewEseguito" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
                                                                    <Items>
                                                                        <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0">
                                                                            <GridSettings>
                                                                                <Breakpoints>
                                                                                    <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                                                                                </Breakpoints>
                                                                            </GridSettings>

                                                                            <Paddings Padding="0px"></Paddings>
                                                                            <Items>
                                                                                <dx:LayoutItem Caption="Da Eseguire:" FieldName="TCK_TipoEsecuzione" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxRadioButtonList ID="Rbl_TCK_TipoEsecuzione" runat="server" ClientInstanceName="Rbl_TCK_TipoEsecuzioneResponsive"
                                                                                                ValueType="System.Int32"
                                                                                                Value='<%# Bind("TCK_TipoEsecuzione") %>'
                                                                                                TextField="Descrizione"
                                                                                                ValueField="Id"
                                                                                                DataSourceID="DtsTCK_TipoEsecuzione"
                                                                                                RepeatDirection="Horizontal"
                                                                                                RepeatColumns="5"
                                                                                                RepeatLayout="Flow">
                                                                                                <ClientSideEvents
                                                                                                    Init="function(s, e) { safeInitPanel(); }"
                                                                                                    ValueChanged="function(s, e) { updateEseguitoPanel(s.GetValue()); }" />
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                                                    <ErrorFrameStyle BackColor="LightPink" />
                                                                                                    <RequiredField IsRequired="True" />
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxRadioButtonList>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutGroup ShowCaption="False" ColumnCount="2">
                                                                                    <Items>
                                                                                    </Items>
                                                                                </dx:LayoutGroup>
                                                                            </Items>
                                                                        </dx:LayoutGroup>
                                                                    </Items>
                                                                    <Paddings Padding="0px"></Paddings>
                                                                </dx:ASPxFormLayout>
                                                                </div>                </div>
        </div>
    </div>
</div>                                                         
                                                            </EditItemTemplate>
                                                        </asp:FormView>
                                                        <div id="EseguitoWarning" style="color: red; font-weight: bold; margin-bottom: 5px;"></div>
                                                        <div id="EseguitoPanel" style="background-color: #57b5e3; padding: 10px; border: 1px solid #11a9cc; margin-top: 10px; font-weight: bold; color: #ffffff;"></div>


                                                        <asp:FormView ID="FormViewDettagliIntervento" ClientInstanceName="FormViewDettagliIntervento" runat="server" DataSourceID="DtsTestataRapp" Width="100%" OnDataBound="FormViewDettagliIntervento_DataBound">
                                                            <EditItemTemplate>
                                                                <dx:ASPxFormLayout runat="server" ID="formlayoutDettagliIntervento" ClientInstanceName="formlayoutDettagliIntervento" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
                                                                    <Items>
                                                                        <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0">
                                                                            <GridSettings>
                                                                                <Breakpoints>
                                                                                    <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                                                                                </Breakpoints>
                                                                            </GridSettings>

                                                                            <Paddings Padding="0px"></Paddings>
                                                                            <Items>
                                                                                <dx:LayoutItem Caption="Oggetto della chiamata:" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxMemo ID="OggettoTck_Memo" Rows="2" runat="server" Text='<%# Bind("OggettoTCK") %>' NullText="Oggetto della chiamata?">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationDettagliIntervento">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxMemo>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Motivo della chiamata:" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>

                                                                                            <dx:ASPxMemo ID="Motivo_Chiamata_Txt_DX" Rows="5" runat="server" Text='<%# Bind("MotivoChiamata") %>' NullText="Motivo della chiamata?">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationDettagliIntervento">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxMemo>

                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Descrizione Prestazione:" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>

                                                                                            <dx:ASPxMemo ID="DescrPrest_Txt_DX" Rows="5" runat="server" Text='<%# Bind("LavoroEseguito") %>' NullText="Descrizione Prestazione?">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationDettagliIntervento">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxMemo>
                                                                                            <a href="#" class="btn btn-info" style="font-size: 1rem; padding: 2px 6px;" data-clipboard-text='<%# Eval("LavoroEseguito") %>'>
                                                                                                <i class="fa fa-copy right"></i>Copia Negli Appunti
                                                                                            </a>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Note:" ColumnSpan="4">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>

                                                                                            <dx:ASPxMemo ID="Note_Txt_DX" Rows="5" runat="server" Text='<%# Bind("Note") %>' NullText="Note?">
                                                                                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationDettagliIntervento">
                                                                                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                                                                    <RequiredField IsRequired="False"></RequiredField>
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxMemo>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>
                                                                                <dx:LayoutItem Caption="Fatturazione" FieldName="TCK_TipoChiusuraChiamataFattura" ColumnSpan="2">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxComboBox ID="TCK_TipoChiusuraChiamataFattura_Combobox" ClientInstanceName="TCK_TipoChiusuraChiamataFattura_Combobox" Value='<%# Bind("TCK_TipoChiusuraChiamataFattura") %>' TextField="IdDescrizione" ValueField="Id" DisplayFormatString="{0} - {1}" TextFormatString="{0}" DataSourceID="DtsTCK_TipoChiusuraChiamataFattura" runat="server" ValueType="System.Int32" Width="100%">
                                                                                                <Columns>
                                                                                                    <dx:ListBoxColumn FieldName="Id" Width="30%" ClientVisible="false"></dx:ListBoxColumn>
                                                                                                    <dx:ListBoxColumn FieldName="Descrizione" Width="30%"></dx:ListBoxColumn>
                                                                                                    <dx:ListBoxColumn FieldName="CodiceAssistenza" Width="55%"></dx:ListBoxColumn>
                                                                                                    <dx:ListBoxColumn FieldName="TotOre" Caption="Ore" Width="15%"></dx:ListBoxColumn>
                                                                                                </Columns>
                                                                                            </dx:ASPxComboBox>
                                                                                            <asp:SqlDataSource ID="DtsTCK_TipoChiusuraChiamataFattura" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT TCK_TipoChiusuraChiamata.Id, TCK_TipoChiusuraChiamata.Descrizione, CAST(TCK_TipoChiusuraChiamata.Id AS nvarchar) + ' - ' + TCK_TipoChiusuraChiamata.Descrizione AS IdDescrizione, TCK_TipoChiusuraChiamata.LabelClass, TCK_TipoChiusuraChiamata.DisplayOrder, TCK_TipoChiusuraChiamata.TipoAssistenzaKING, derivedtbl_1.IdProdotto AS CodiceAssistenza, derivedtbl_1.ResiduoOre AS TotOre, CAST(TCK_TipoChiusuraChiamata.Id AS nvarchar) + CASE WHEN derivedtbl_1.IdProdotto IS NOT NULL THEN '-' + derivedtbl_1.IdProdotto ELSE '' END AS IdTipologia FROM TCK_TipoChiusuraChiamata LEFT OUTER JOIN (SELECT Denom, CodCliente, IdProdotto, Totale, Totinterventi, ResiduoOre, U_CC, DataCar, U_Tipo_Assistenza FROM U_CarnetAttivi_KING_View WHERE CodCliente = (SELECT CodCli FROM TCK_TestataTicket WHERE CodRapportino = @IdTicket) AND U_CC = 0) AS derivedtbl_1 ON TCK_TipoChiusuraChiamata.TipoAssistenzaKING = derivedtbl_1.U_Tipo_Assistenza WHERE TCK_TipoChiusuraChiamata.Id <> 0 ORDER BY TCK_TipoChiusuraChiamata.DisplayOrder">
                                                                                                <SelectParameters>
                                                                                                    <asp:QueryStringParameter QueryStringField="IdTicket" Name="IdTicket"></asp:QueryStringParameter>
                                                                                                </SelectParameters>
                                                                                            </asp:SqlDataSource>
                                                                                        </dx:LayoutItemNestedControlContainer>
                                                                                    </LayoutItemNestedControlCollection>
                                                                                    <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                                </dx:LayoutItem>

                                                                                <dx:LayoutItem Caption="Chiusura:" FieldName="TCK_StatusChiamataChiusura" ColumnSpan="2">
                                                                                    <LayoutItemNestedControlCollection>
                                                                                        <dx:LayoutItemNestedControlContainer>
                                                                                            <dx:ASPxRadioButtonList ID="Rbl_TCK_StatusChiamata_chiusura" runat="server" ClientInstanceName="Rbl_TCK_StatusChiamata_chiusura"
                                                                                                ValueType="System.Int32"
                                                                                                Value='<%# Bind("TCK_StatusChiamataChiusura") %>'
                                                                                                TextField="Descrizione"
                                                                                                ValueField="Id"
                                                                                                DataSourceID="DtsTCK_StatusChiamata"
                                                                                                RepeatDirection="Horizontal"
                                                                                                RepeatColumns="3"
                                                                                                RepeatLayout="Flow">

                                                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidationDettagliIntervento">
                                                                                                    <ErrorFrameStyle BackColor="LightPink" />
                                                                                                    <RequiredField IsRequired="True" />
                                                                                                </ValidationSettings>
                                                                                            </dx:ASPxRadioButtonList>
                                                                                            <asp:SqlDataSource ID="DtsTCK_StatusChiamata" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT Id, Descrizione, LabelClass FROM TCK_StatusChiamata WHERE (LastStep  = 1) ORDER BY Id"></asp:SqlDataSource>
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
                                                          </div>
                                                    </div>
                                                </div>
                                            </div>                                                         
                                                            </EditItemTemplate>
                                                        </asp:FormView>
                                                        <dx:BootstrapButton runat="server" ID="BootstrapButton1" ClientInstanceName="UpdateTicketBtn" AutoPostBack="false"
                                                            Badge-CssClass="BadgeBtn-just-icon"
                                                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-success">

                                                            <Badge IconCssClass="fa fa-sync" Text="AGGIORNA" />
                                                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />

                                                            <ClientSideEvents Click="function(s,e){
    var valid = ASPxClientEdit.ValidateGroup('ValidationDettagliIntervento');
    if(valid){                                
        ConfermaOperazione('Confermi di voler aggiornare il ticket con i dati inseriti?','Update_FormLayoutDettagli_Intervento_Callback');
    } else {
        showNotificationErrorWithText('Alcuni dati non sono stati compilati, controllare e riprovare.');
    }
}" />
                                                        </dx:BootstrapButton>
                                                    </dx:PanelContent>
                                                </PanelCollection>
                                            </dx:ASPxCallbackPanel>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxPopupControl ID="ForzaChiusura_popup"
        runat="server"
        CssClass="responsive-popup"
        AllowResize="true" ResizingMode="Live"
        ClientInstanceName="ForzaChiusura_popup"
        CloseAction="CloseButton" CloseOnEscape="true"
        Modal="true"
        PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter"
        HeaderText="Chiudi Forzatamente">

        <ContentCollection>
            <dx:PopupControlContentControl>
                <div style="display: flex; flex-direction: column; gap: 10px;">

                    <dx:ASPxLabel ID="lblNoteAnnullamento" runat="server" Text="Note Annullamento Ticket*:" ForeColor="Red" AssociatedControlID="AnnullamentoTck_Txt" />

                    <dx:ASPxMemo ID="AnnullamentoTck_Txt" ClientInstanceName="AnnullamentoTck_Txt" Rows="5" runat="server" NullText="Note Annullamento Ticket" Width="100%">
                        <InvalidStyle BackColor="LightPink" />
                        <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                            <ErrorFrameStyle BackColor="LightPink" />
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </dx:ASPxMemo>

                    <div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: flex-end;">
                        <dx:BootstrapButton
                            runat="server"
                            ID="BootstrapButton2"
                            ClientInstanceName="ForzaChiusura_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 140px; flex: 1 1 auto; max-width: 200px;"
                            ToolTip="Forza la chiusura ticket"
                            Badge-CssClass="BadgeBtn-just-icon">

                            <Badge IconCssClass="fa fa-lock" Text="Forza chiusura" />
                            <SettingsBootstrap RenderOption="Danger" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) {
                                e.processOnServer = false;

                                ConfermaOperazioneWithClientFunction(
                                    'Conferma Chiusura Forzata',
                                    'Sei sicuro di voler forzare la chiusura del ticket?',
                                    'Conferma',
                                    'Annulla',
                                    function () { salvaForzaChiusura(); },
                                    function () { }
                                );
                            }" />

                        </dx:BootstrapButton>

                        <dx:BootstrapButton
                            runat="server"
                            ID="btnAnnullaChiusura"
                            AutoPostBack="false"
                            ClientInstanceName="btnAnnullaChiusura"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 140px; flex: 1 1 auto; max-width: 200px;"
                            ToolTip="Annulla"
                            Badge-CssClass="BadgeBtn-just-icon">

                            <Badge IconCssClass="fa fa-times" Text="Annulla" />
                            <SettingsBootstrap RenderOption="Secondary" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { ForzaChiusura_popup.Hide(); }" />
                        </dx:BootstrapButton>
                    </div>

                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents Shown="function(s, e) { resizeForzaChiusuraPopup(); }" />
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="ModificaNoteTecnico_popup"
        runat="server"
        CssClass="responsive-popup"
        AllowResize="true" ResizingMode="Live"
        ClientInstanceName="ModificaNoteTecnico_popup"
        CloseAction="CloseButton" CloseOnEscape="true"
        Modal="true"
        PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter"
        HeaderText="Modifica Note Tecnico">

        <ContentCollection>
            <dx:PopupControlContentControl>
                <div style="display: flex; flex-direction: column; gap: 10px;">

                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Note Annullamento Ticket*:" ForeColor="Red" AssociatedControlID="AnnullamentoTck_Txt" />

                    <dx:ASPxCallbackPanel ID="CallbackPanelModificaNoteTecnico" runat="server"
                        ClientInstanceName="CallbackPanelModificaNoteTecnico"
                        OnCallback="CallbackPanelModificaNoteTecnico_Callback"
                        Width="100%">
                        <ClientSideEvents
                            EndCallback="function(s, e) {
                            if(s.cpSaved === 'OK'){
                                ModificaNoteTecnico_popup.Hide();
                                Tecnici_Gridview.Refresh();
                                showNotification();

                                // aggiorna summaryPanel
                                if(s.cpTotalTecnici !== undefined && s.cpTotalOre !== undefined){
                                    document.getElementById('totalTecnici').innerText = s.cpTotalTecnici;
                                    document.getElementById('tempoTicket').innerText = s.cpTotalOre;
                                }

                                s.cpSaved = null;
                                s.cpTotalTecnici = null;
                                s.cpTotalOre = null;
                            }
                        }" />
                        <PanelCollection>
                            <dx:PanelContent>
                                <asp:FormView ID="FormView2" runat="server" DataKeyNames="Id" DataSourceID="DtsAssegnaTecnico"
                                    RenderOuterTable="False">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblNomeCli" runat="server" Text="Società: " /><%# Eval("Società") %>
                                        </div>
                                        <div>
                                            <asp:Label ID="lblIndirizzoCli" runat="server" Text="Indirizzo: " /><%# Eval("Indirizzo") %>
                                        </div>
                                        <div>
                                            <asp:Label ID="lblTipoChiamataCli" runat="server" Text="Tipo chiamata: " /><%# Eval("DescrizioneChiamata") %>
                                        </div>
                                        <div>
                                            <asp:Label ID="lblTecnicoCli" runat="server" Text="Tecnico*: " Style="color: Red;" />
                                        </div>
                                        <asp:CheckBoxList ID="NoteTecnico_Ckbl" runat="server" RepeatLayout="Table"
                                            DataSourceID="Tecnici_Dts"
                                            DataTextField="UserName"
                                            DataValueField="UserName"
                                            OnDataBound="NoteTecnico_Ckbl_DataBound"
                                            ValidationGroup="ValidPopTecnicoGrp2"
                                            RepeatDirection="Horizontal" RepeatColumns="3" Width="100%" />
                                        <asp:Label ID="lblNoteTecnico" runat="server" Text="Note tecnico: "></asp:Label>
                                        <dx:ASPxMemo ID="NoteTecnico_Txt" Text='<%# Eval("NoteTecnico") %>' runat="server" Width="100%" Rows="6">
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink" />
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </dx:ASPxMemo>
                                        <asp:Label ID="lblInvioEmailApertura" runat="server" Text="Invia mail apertura ticket: "></asp:Label>
                                        <label class="toggle-switch">
                                            <asp:CheckBox ID="ToggleSwitch" runat="server" Checked="true" />
                                            <span class="slider"></span>
                                        </label>
                                    </ItemTemplate>
                                </asp:FormView>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                    <div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: flex-end;">
                        <dx:BootstrapButton
                            runat="server"
                            ID="Aggiorna_Btn"
                            ClientInstanceName="Aggiorna_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 140px; flex: 1 1 auto; max-width: 200px;"
                            ToolTip="Aggiorna i dati"
                            Badge-CssClass="BadgeBtn-just-icon">

                            <Badge IconCssClass="fa fa-sync" Text="Aggiorna" />
                            <SettingsBootstrap RenderOption="Info" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) {
        if(!ASPxClientEdit.ValidateEditorsInContainer(ASPxClientControl.GetControlCollection().GetByName('FormView2'), 'testValidation')) {
            e.processOnServer = false;
            return;
        }

        e.processOnServer = false;

        ConfermaOperazioneWithClientFunction(
            'Conferma Aggiornamento',
            'Sei sicuro di voler aggiornare i dati?',
            'Conferma',
            'Annulla',
            function () { salvaAggiorna(); },
            function () { }
        );
    }" />
                        </dx:BootstrapButton>

                        <dx:BootstrapButton
                            runat="server"
                            ID="BootstrapButton4"
                            AutoPostBack="false"
                            ClientInstanceName="btnAnnullaChiusura"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 140px; flex: 1 1 auto; max-width: 200px;"
                            ToolTip="Annulla"
                            Badge-CssClass="BadgeBtn-just-icon">

                            <Badge IconCssClass="fa fa-times" Text="Annulla" />
                            <SettingsBootstrap RenderOption="Secondary" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { ModificaNoteTecnico_popup.Hide(); }" />
                        </dx:BootstrapButton>
                    </div>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents Shown="function(s, e) { resizeModificaNoteTecnicoPopup(); }" />
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="AssociaTecnico_popup"
        runat="server"
        CssClass="responsive-popup"
        AllowResize="true" ResizingMode="Live"
        ClientInstanceName="AssociaTecnico_popup"
        CloseAction="CloseButton" CloseOnEscape="true"
        Modal="true"
        PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter"
        HeaderText="Associa Tecnico">

        <ContentCollection>
            <dx:PopupControlContentControl>
                <div style="display: flex; flex-direction: column; gap: 10px;">

                    <dx:ASPxCallbackPanel ID="CallbackPanelAssociaTecnico" runat="server"
                        ClientInstanceName="CallbackPanelAssociaTecnico"
                        OnCallback="CallbackPanelAssociaTecnico_Callback"
                        Width="100%">
                        <ClientSideEvents EndCallback="onEndCallbackAssociaTecnico" />
                        <PanelCollection>
                            <dx:PanelContent>
                                <div>
                                    <asp:Label ID="lblTecnicoAssocia" runat="server" Text="Tecnico*: " Style="color: Red;" />
                                </div>
                                <asp:CheckBoxList ID="AssociaTecnico_Ckbl" runat="server" RepeatLayout="Table"
                                    DataSourceID="Tecnici_Dts"
                                    DataTextField="UserName"
                                    DataValueField="UserName"
                                    ValidationGroup="ValidPopTecnicoGrp_Associa"
                                    RepeatDirection="Horizontal" RepeatColumns="3" Width="100%">
                                </asp:CheckBoxList>

                                <asp:Label ID="lblNoteAssocia" runat="server" Text="Note tecnico: "></asp:Label>
                                <dx:ASPxMemo ID="NoteTecnicoAssocia_Txt" runat="server" Width="100%" Rows="6">
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidPopTecnicoGrp_Associa">
                                        <ErrorFrameStyle BackColor="LightPink" />
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxMemo>

                                <div style="margin-top: 10px;">
                                    <asp:CheckBox ID="InviaCalendarChk" runat="server" Text="Invia Calendar" onclick="toggleCalendarFields(this);" />
                                </div>
                                <div id="calendarFields" class="row" style="display: none; margin-top: 10px;">
                                    <div class="col-lg-12 col-md-12 col-xs-12">
                                        Data Intervento:
                                        <dx:ASPxDateEdit ID="DataInterventoEdit" runat="server" Width="100%">
                                            <InvalidStyle BackColor="LightPink" />
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="ValidTestataTecnico">
                                                <ErrorFrameStyle BackColor="LightPink" />
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </dx:ASPxDateEdit>
                                    </div>

                                    <div class="col-lg-6 col-md-6 col-xs-6">
                                        Inzio Intervento:
    <dx:ASPxTextBox ID="Inizio_Txt" ClientInstanceName="Inizio_Txt" runat="server" Native="true" Width="100%" Text="">
        <ClientSideEvents Init="OnInitTimeEdit" Validation="onNameValidation" />
        <ValidationSettings SetFocusOnError="True" ValidationGroup="ValidPopTecnicoGrp_Associa" ErrorDisplayMode="None">
            <RequiredField IsRequired="True" />
        </ValidationSettings>
        <InvalidStyle BackColor="LightPink" />
    </dx:ASPxTextBox>
                                    </div>

                                    <div class="col-lg-6 col-md-6 col-xs-6">
                                        Fine Intervento:
    <dx:ASPxTextBox ID="Fine_Txt" ClientInstanceName="Fine_Txt" runat="server" Native="true" Width="100%" Text="">
        <ClientSideEvents Init="OnInitTimeEdit" Validation="TimeValidationGridview" />
        <ValidationSettings SetFocusOnError="True" ValidationGroup="ValidPopTecnicoGrp_Associa" ErrorDisplayMode="None" ErrorText="Hai impostato un orario di fine inferiore all'orario di inizio">
            <RequiredField IsRequired="True" />
        </ValidationSettings>
        <InvalidStyle BackColor="LightPink" />
    </dx:ASPxTextBox>
                                    </div>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                    <div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: flex-end;">
                        <dx:BootstrapButton
                            runat="server"
                            ID="AssociaTecnico_ConfirmBtn"
                            ClientInstanceName="AssociaTecnico_ConfirmBtn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 140px; flex: 1 1 auto; max-width: 200px;"
                            ToolTip="Associa tecnico"
                            Badge-CssClass="BadgeBtn-just-icon">

                            <Badge IconCssClass="fa fa-save" Text="CONFERMA" />
                            <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) {
    if (!validateAll()) {
        e.processOnServer = false;
        return;
    }
                            e.processOnServer = false;
                            ConfermaOperazioneWithClientFunction(
                                'Conferma Associazione',
                                'Vuoi associare il tecnico selezionato?',
                                'Conferma',
                                'Annulla',
                                function () { salvaAssociazioneTecnico(); },
                                function () { }
                            );
                        }" />
                        </dx:BootstrapButton>

                        <dx:BootstrapButton
                            runat="server"
                            ID="AssociaTecnico_AnnullaBtn"
                            AutoPostBack="false"
                            ClientInstanceName="AssociaTecnico_AnnullaBtn"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 140px; flex: 1 1 auto; max-width: 200px;"
                            ToolTip="Annulla"
                            Badge-CssClass="BadgeBtn-just-icon">

                            <Badge IconCssClass="fa fa-times" Text="Annulla" />
                            <SettingsBootstrap RenderOption="Secondary" Sizing="Small" />
                            <ClientSideEvents Click="function(s, e) { AssociaTecnico_popup.Hide(); }" />
                        </dx:BootstrapButton>
                    </div>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents Shown="function(s, e) { resizeAssociaTecnicoPopup(); }" />
    </dx:ASPxPopupControl>


    <dx:ASPxCallback ID="Update_FormLayout_Callback" ClientInstanceName="Update_FormLayout_Callback" runat="server" OnCallback="Update_FormLayout_Callback_Callback" Style="float: right">
        <ClientSideEvents
            EndCallback="function(s,e){
    CallbackPnlFormView.PerformCallback();
             CallbackPnlFormViewEseguito.PerformCallback();
            showNotification();
}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="Update_FormViewTicketSpese_Callback" ClientInstanceName="Update_FormViewTicketSpese_Callback" runat="server" OnCallback="Update_FormViewTicketSpe_Callback" Style="float: right">
        <ClientSideEvents
            EndCallback="function(s,e){
    CallbackPnlFormViewSpese.PerformCallback();
            showNotification();
}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="Update_FormViewTicketMateriali_Callback" ClientInstanceName="Update_FormViewTicketMateriali_Callback" runat="server" OnCallback="Update_FormViewTicketMat_Callback" Style="float: right">
        <ClientSideEvents
            EndCallback="function(s,e){
    CallbackPnlFormViewMateriali.PerformCallback();
            Generic_Gridview.Refresh();
            showNotification();
}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback
        ID="Update_FormLayoutDettagli_Intervento_Callback_Control"
        ClientInstanceName="Update_FormLayoutDettagli_Intervento_Callback"
        runat="server"
        OnCallback="Update_FormLayoutDettagli_Intervento_Callback"
        Style="float: right">
        <ClientSideEvents
            EndCallback="function(s,e){
    CallbackPnlFormView.PerformCallback();
             CallbackPnlFormViewEseguito.PerformCallback();
            showNotification();
}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ForzaChiusura_Callback" runat="server" ClientInstanceName="ForzaChiusura_Callback" OnCallback="ForzaChiusura_Callback_Callback">
        <ClientSideEvents CallbackComplete="function(s, e) { location.reload(); }" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ForzaRiapertura_Callback" runat="server" ClientInstanceName="ForzaRiapertura_Callback" OnCallback="ForzaRiapertura_Callback_Callback">
        <ClientSideEvents CallbackComplete="function(s, e) { location.reload();}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="AvviaTicket_Callback" runat="server"
        ClientInstanceName="AvviaTicket_Callback"
        OnCallback="AvviaTicket_Callback_Callback">
        <ClientSideEvents CallbackComplete="function(s, e) { location.reload();}" />
    </dx:ASPxCallback>
    <asp:SqlDataSource ID="DtsTestataRapp" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT CASE WHEN TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura = 0 OR TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura = 9 THEN NULL ELSE CAST(TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura AS nvarchar) + CASE WHEN ISNULL(TCK_TestataTicket.IDContrattoAssistenza, '') = '' THEN '' ELSE '-' + TCK_TestataTicket.IDContrattoAssistenza END END AS IDContrattoAssistenza, TCK_StatusChiamata.Id AS idStatus, TCK_TestataTicket.OggettoTCK, TCK_TestataTicket.InsertUser, TCK_TestataTicket.PersonaDaContattare, TCK_TipoRichiesta.Id, TCK_TipoRichiesta.Descrizione AS TipoChiamata, TCK_TipoRichiesta.LabelClass AS Colore, TCK_TestataTicket.CodRapportino, TCK_TestataTicket.Società, TCK_AreaCompetenza.Descrizione AS AreaAss, TCK_AreaCompetenza.LabelClass AS ColoreArea, TCK_TestataTicket.CreatedOn AS DataIns, TCK_PrioritaRichiesta.Descrizione AS PrioritaDescr, TCK_PrioritaRichiesta.LabelClass AS PrioritaColore, TCK_TipoEsecuzione.Descrizione AS TipoEsecDescr, TCK_TipoEsecuzione.LabelClass AS TipoEsecColore, TCK_TestataTicket.MotivoChiamata, TCK_TestataTicket.TCK_TipoRichiesta, TCK_TestataTicket.TCK_TipoEsecuzionePresunta, TCK_TestataTicket.TCK_AreaCompetenza, TCK_TestataTicket.TCK_TipoEsecuzione, TCK_TestataTicket.TCK_StatusChiamataChiusura, TCK_TestataTicket.TCK_StatusChiamata, TCK_TestataTicket.TCK_PrioritaRichiesta, TCK_TestataTicket.CodCli, TCK_TestataTicket.NoteTecnico, TCK_TestataTicket.Note, TCK_TestataTicket.GuastoRilevato, TCK_TestataTicket.LavoroEseguito, TCK_TestataTicket.InterventoChiuso, TCK_TestataTicket.Osservazioni, TCK_TestataTicket.DataIntervento, TCK_TestataTicket.DataIns AS Expr1, TCK_TestataTicket.NomePersonaRiferimento, TCK_TestataTicket.TelPersonaRiferimento, TCK_TestataTicket.MailPersonaRiferimento, Clienti.Denom + ' - ' + Clienti.Loc + ' - ' + Clienti.Ind AS InterventoPresso, TCK_TestataTicket.OraInzioIntervento, TCK_TestataTicket.OraFineIntervento, TCK_TestataTicket.DirittoFisso, TCK_TestataTicket.TariffaOraria, TCK_TestataTicket.SpeseViaggioKm, TCK_TestataTicket.SpeseViaggioEuro, TCK_TestataTicket.TotaleEuroForfait, CASE WHEN TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura = 0 OR TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura = 9 THEN NULL ELSE TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura END AS TCK_TipoChiusuraChiamataFattura, TCK_TestataTicket.ImgFirmaCliente, TCK_TestataTicket.FirmaCliente, TCK_TestataTicket.ImgFirmaTecnico, TCK_TestataTicket.FirmaTecnico, TCK_TestataTicket.TicketFirmato, TCK_TestataTicket.NoteAnnullamentoTck, TCK_TestataTicket.LinkTckPdf, TCK_TestataTicket.TckInviatoA, TCK_TestataTicket.TotTecnici, TCK_TestataTicket.TempoInterventoTotale, TCK_TestataTicket.UM, Tck_StatusControlloRegistrazione.Descrizione AS RegistrazioneRapp, Tck_StatusControlloRegistrazione.StatusControlloRegistrazione, TCK_TestataTicket.NumeroRegistrazione, TCK_TestataTicket.StatusControlloFatturazioneFinale, TCK_TestataTicket.NoteFatturazioneFinale, TCK_TestataTicket.StatusCotrolloFatt, TCK_StatusCotrolloFatt.Descrizione AS StatusFinaleFatt, TCK_TestataTicket.ApprovatoDa, Clienti.Cap, Clienti.Prov AS Provincia, Clienti.Loc AS Località, Clienti.Tel AS Telefono, Clienti.EMail AS Email, Clienti.Ind AS Indirizzo, Clienti.PIva, Clienti.Fax, Clienti.Denom, Clienti.Riferim AS PersonaDaContattare FROM TCK_AreaCompetenza INNER JOIN TCK_TestataTicket ON TCK_AreaCompetenza.IdAreaAss = TCK_TestataTicket.TCK_AreaCompetenza INNER JOIN TCK_StatusChiamata ON TCK_TestataTicket.TCK_StatusChiamata = TCK_StatusChiamata.Id INNER JOIN TCK_TipoRichiesta ON TCK_TestataTicket.TCK_TipoRichiesta = TCK_TipoRichiesta.Id INNER JOIN TCK_PrioritaRichiesta ON TCK_TestataTicket.TCK_PrioritaRichiesta = TCK_PrioritaRichiesta.Id INNER JOIN TCK_TipoEsecuzione ON TCK_TestataTicket.TCK_TipoEsecuzionePresunta = TCK_TipoEsecuzione.Id INNER JOIN Clienti ON TCK_TestataTicket.CodCli = Clienti.CodCli INNER JOIN Tck_StatusControlloRegistrazione ON TCK_TestataTicket.StatusControlloRegistrazione = Tck_StatusControlloRegistrazione.StatusControlloRegistrazione INNER JOIN TCK_StatusCotrolloFatt ON TCK_TestataTicket.StatusCotrolloFatt = TCK_StatusCotrolloFatt.Id WHERE (TCK_TestataTicket.CodRapportino = @IdTicket)" UpdateCommand="UPDATE TCK_TestataTicket SET CodCli = @CodCli, TCK_AreaCompetenza = @TCK_AreaCompetenza, TCK_PrioritaRichiesta = @TCK_PrioritaRichiesta, TCK_TipoRichiesta = @TCK_TipoRichiesta, TCK_TipoEsecuzione = @TCK_TipoEsecuzione, PersonaDaContattare = @PersonaDaContattare, Telefono = @Telefono, Email = @Email, OggettoTCK = @OggettoTCK, MotivoChiamata = @MotivoChiamata WHERE CodRapportino = @IdTicket">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdTicket" QueryStringField="IdTicket" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CodCli" Type="String" />
            <asp:Parameter Name="TCK_AreaCompetenza" Type="Int32" />
            <asp:Parameter Name="TCK_PrioritaRichiesta" Type="Int32" />
            <asp:Parameter Name="TCK_TipoRichiesta" Type="Int32" />
            <asp:Parameter Name="TCK_TipoEsecuzione" Type="Int32" />
            <asp:Parameter Name="PersonaDaContattare" Type="String" />
            <asp:Parameter Name="Telefono" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="OggettoTCK" Type="String" />
            <asp:Parameter Name="MotivoChiamata" Type="String" />
            <asp:Parameter Name="IdTicket" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_TipoRichiesta" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT [Id], [Descrizione], [DisplayOrder], '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl FROM TCK_TipoRichiesta order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_TipoEsecuzione" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Id, Descrizione, DisplayOrder, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl FROM TCK_TipoEsecuzione order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_AreaCompetenza" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT [Descrizione], [DisplayOrder], [LabelClass], [IdAreaAss] , '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl  FROM [TCK_AreaCompetenza] order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_PrioritaRichiesta" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Descrizione, DisplayOrder, LabelClass, Id, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl  FROM TCK_PrioritaRichiesta ORDER BY DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTecnici" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Id, CodRapportino, Utente, DataIntervento, OraInizio, OraFine FROM TCK_DettTecniciTicket WHERE CodRapportino = @CodRapportino ORDER BY Id"
        InsertCommand="INSERT INTO TCK_DettTecniciTicket (CodRapportino, Utente, DataIntervento, OraInizio, OraFine) VALUES (@CodRapportino, @Utente, @DataIntervento, @OraInizio, @OraFine)"
        UpdateCommand="UPDATE TCK_DettTecniciTicket SET Utente=@Utente, DataIntervento=@DataIntervento, OraInizio=@OraInizio, OraFine=@OraFine WHERE Id=@Id"
        DeleteCommand="DELETE FROM TCK_DettTecniciTicket WHERE Id=@Id">

        <SelectParameters>
            <asp:QueryStringParameter Name="CodRapportino" QueryStringField="IdTicket" Type="Int32" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="CodRapportino" Type="Int32" />
            <asp:Parameter Name="Utente" Type="String" />
            <asp:Parameter Name="DataIntervento" Type="DateTime" />
            <asp:Parameter Name="OraInizio" />
            <asp:Parameter Name="OraFine" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="Utente" Type="String" />
            <asp:Parameter Name="DataIntervento" Type="DateTime" />
            <asp:Parameter Name="OraInizio" />
            <asp:Parameter Name="OraFine" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="FirmaTecnicoDTS" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT DISTINCT TCK_TestataTicket.CodRapportino, TCK_DettTecniciTicket.Utente FROM TCK_TestataTicket INNER JOIN TCK_DettTecniciTicket ON TCK_TestataTicket.CodRapportino = TCK_DettTecniciTicket.CodRapportino WHERE (TCK_TestataTicket.CodRapportino = @IdTicket)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdTicket" QueryStringField="IdTicket" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsMateriali" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT CodRapportino, CodMateriale, Descrizione, Um, Qta, id FROM TCK_DettRicambiTicket WHERE (CodRapportino = @CodRapportino)"
        UpdateCommand="SELECT *    FROM TCK_DettRicambiTicket  where 1 = 2" DeleteCommand="SELECT *    FROM TCK_DettRicambiTicket  where 1 = 2">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="CodRapportino" QueryStringField="IdTicket"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <!-- Datasource per combo tecnici -->
    <asp:SqlDataSource ID="Tecnici_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT aspnet_Users.UserName FROM aspnet_Users INNER JOIN aspnet_UsersInRoles ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId INNER JOIN aspnet_Roles ON aspnet_UsersInRoles.RoleId = aspnet_Roles.RoleId WHERE aspnet_Roles.RoleName = 'tecnico'"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsAssegnaTecnico" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT TCK_TestataTicket.Indirizzo, TCK_TipoRichiesta.Id, TCK_TestataTicket.TipoChiamata, TCK_TipoRichiesta.Descrizione AS DescrizioneChiamata, TCK_TestataTicket.CodRapportino, TCK_TestataTicket.Società, TCK_TestataTicket.NoteTecnico FROM TCK_TestataTicket INNER JOIN TCK_TipoRichiesta ON TCK_TestataTicket.TCK_TipoRichiesta = TCK_TipoRichiesta.Id WHERE (TCK_TestataTicket.CodRapportino = @Param1)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="Param1" QueryStringField="IdTicket" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function validateCheckBoxList() {
            const list = document.getElementById('<%= AssociaTecnico_Ckbl.ClientID %>');
            if (!list) return false;

            const inputs = list.querySelectorAll("input[type='checkbox']");
            const selected = Array.from(inputs).some(cb => cb.checked);

            // Se nessuno selezionato, evidenzia errore
            if (!selected) {
                list.style.backgroundColor = "LightPink";
                showNotificationErrorText("Seleziona almeno un tecnico.");
                return false;
            } else {
                list.style.backgroundColor = ""; // Reset colore
            }

            return true;
        }
        function validateAll() {
            if (!ASPxClientEdit.ValidateEditorsInContainer(null, 'ValidPopTecnicoGrp_Associa')) {
                showNotificationErrorText("Compila correttamente tutti i campi obbligatori.");
                return false;
            }
            if (!validateCheckBoxList()) {
                return false;
            }
            return true;
        }
        function salvaForzaChiusura() {
            var memo = AnnullamentoTck_Txt;

            if (!memo) {
                showNotificationErrorText("Errore: controllo non trovato.");
                return;
            }

            var testo = memo.GetText().trim();
            if (testo === "") {
                // Imposta validazione fallita
                memo.SetIsValid(false);
                // Cambia background per evidenziare
                memo.GetMainElement().style.backgroundColor = "LightPink";

                showNotificationErrorText("Compila correttamente tutti i campi obbligatori.");
                return;
            } else {
                // Resetta validazione e stile se compilato
                memo.SetIsValid(true);
                memo.GetMainElement().style.backgroundColor = "";
            }

            ForzaChiusura_Callback.PerformCallback(testo);
            showNotification();
        }
        function validateCheckBoxList() {
            var ckbl = document.getElementById('<%= AssociaTecnico_Ckbl.ClientID %>');
            var inputs = ckbl.getElementsByTagName("input");
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].checked) return true;
            }
            alert("Seleziona almeno un tecnico");
            return false;
        }

        function salvaAggiorna() {
            CallbackPanelModificaNoteTecnico.PerformCallback("SalvaNoteTecnico");
        }
        function salvaAssociazioneTecnico() {
            CallbackPanelAssociaTecnico.PerformCallback("SalvaAssociazioneTecnico");
        }
        function toggleCalendarFields(checkbox) {
            var fields = document.getElementById('calendarFields');
            fields.style.display = checkbox.checked ? 'flex' : 'none';

            if (checkbox.checked) {
                var dataIntervento = document.getElementById('<%= DataInterventoEdit.ClientID %>_I');
                if (dataIntervento) {
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();

                    dataIntervento.value = dd + '-' + mm + '-' + yyyy;
                }
            }
        }

    </script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('a.btn.btn-info').forEach(btn => {
                btn.addEventListener('click', e => {
                    e.preventDefault();
                    // Blocca il comportamento default del link

                    const textToCopy = btn.getAttribute('data-clipboard-text');
                    // Prendo il testo da copiare dal custom attribute

                    if (navigator.clipboard) {
                        // Se il browser supporta la Clipboard API moderna
                        navigator.clipboard.writeText(textToCopy).then(() => {
                            // Copia fatta con successo
                            showNotification();
                        }).catch(err => {
                            // Se c'è un errore, mostro notifica di errore
                            showNotificationErrorText("Errore copia");
                        });
                    } else {
                        // Fallback per browser vecchi senza Clipboard API
                        const textArea = document.createElement('textarea');
                        textArea.value = textToCopy;
                        document.body.appendChild(textArea);
                        textArea.select();
                        try {
                            // Provo a copiare usando document.execCommand
                            document.execCommand('copy');
                            showNotification();
                        } catch (err) {
                            showNotificationErrorText("Errore copia");
                        }
                        // Rimuovo la textarea temporanea
                        document.body.removeChild(textArea);
                    }
                });
            });
        });
        function onEndCallbackAssociaTecnico(s, e) {
            if (s.cpSaved === "OK") {
                AssociaTecnico_popup.Hide();
                Tecnici_Gridview.Refresh();
                showNotification();

                console.log('cpTotalTecnici:', s.cpTotalTecnici);
                console.log('cpTotalOre:', s.cpTotalOre);
                console.log('totalTecnici element:', document.getElementById('totalTecnici'));
                console.log('tempoTicket element:', document.getElementById('tempoTicket'));

                if (typeof s.cpTotalTecnici !== 'undefined' && document.getElementById('totalTecnici')) {
                    document.getElementById('totalTecnici').innerText = s.cpTotalTecnici;
                }
                if (typeof s.cpTotalOre !== 'undefined' && document.getElementById('tempoTicket')) {
                    document.getElementById('tempoTicket').innerText = s.cpTotalOre;
                }
            }

            s.cpSaved = null;
            s.cpTotalTecnici = null;
            s.cpTotalOre = null;
        }
    </script>
    <style>
        .edit-time-wrapper {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .edit-time-group label {
            font-weight: 600;
            margin-bottom: 4px;
        }

        .dxgvEditFormTable,
        .dxgvEditFormTable td {
            width: 100% !important;
        }

        @media (min-width: 768px) {
            .edit-time-wrapper {
                flex-direction: row;
                gap: 12px;
                align-items: flex-end;
            }

            .edit-time-group {
                flex: 1;
            }
        }

        /* Tablet */
        @media (max-width: 992px) {
            .responsive-popup {
                width: 700px !important;
            }
        }

        /* Mobile */
        @media (max-width: 576px) {
            .responsive-popup {
                width: 90% !important;
                max-width: 90% !important;
            }
        }

        #EseguitoPanel, #EseguitoWarning {
            transition: opacity 0.3s ease;
            opacity: 1;
        }

        .hidden {
            opacity: 0;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 35px;
        }

            .toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

        .slider {
            position: absolute;
            cursor: pointer;
            background-color: #c6c6c6;
            border-radius: 24px;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            transition: 0.3s;
        }

            .slider::before {
                position: absolute;
                content: "";
                height: 22px;
                width: 22px;
                left: 1px;
                bottom: 1px;
                background-color: white;
                border-radius: 50%;
                transition: 0.3s;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }

        .toggle-switch input:checked + .slider {
            background-color: #4caf50;
        }

            .toggle-switch input:checked + .slider::before {
                transform: translateX(26px);
            }
    </style>
    <script>
        //Adatta il popup alla larghezza dello schermo
        function resizeForzaChiusuraPopup() {
            var popup = ForzaChiusura_popup;
            if (!popup) {
                console.warn("popup non disponibile");
                return;
            }

            var winWidth = window.innerWidth;
            var height = 400;

            console.log("📏 width finestra:", winWidth);

            if (winWidth < 576) {
                popup.SetWidth(Math.floor(winWidth * 0.85));
            } else if (winWidth < 992) {
                popup.SetWidth(700);
            } else {
                popup.SetWidth(900);
            }

            popup.SetHeight(height);
        }

        //Ricalcola dimensioni se il popup è visibile
        window.addEventListener('resize', function () {
            if (ForzaChiusura_popup && ForzaChiusura_popup.IsVisible()) {
                resizeForzaChiusuraPopup();
            }
        });
        function resizeModificaNoteTecnicoPopup() {
            var popup = ModificaNoteTecnico_popup;
            if (!popup) {
                console.warn("popup non disponibile");
                return;
            }

            var winWidth = window.innerWidth;
            var height = 400;

            console.log("📏 width finestra:", winWidth);

            if (winWidth < 576) {
                popup.SetWidth(Math.floor(winWidth * 0.85));
            } else if (winWidth < 992) {
                popup.SetWidth(700);
            } else {
                popup.SetWidth(900);
            }

            popup.SetHeight(height);
        }

        //Ricalcola dimensioni se il popup è visibile
        window.addEventListener('resize', function () {
            if (ModificaNoteTecnico_popup && ModificaNoteTecnico_popup.IsVisible()) {
                resizeModificaNoteTecnicoPopup();
            }
        });
        function resizeAssociaTecnicoPopup() {
            var popup = AssociaTecnico_popup;
            if (!popup) {
                console.warn("popup non disponibile");
                return;
            }

            var winWidth = window.innerWidth;
            var height = 400;

            console.log("📏 width finestra:", winWidth);

            if (winWidth < 576) {
                popup.SetWidth(Math.floor(winWidth * 0.85));
            } else if (winWidth < 992) {
                popup.SetWidth(700);
            } else {
                popup.SetWidth(900);
            }

            popup.SetHeight(height);
        }

        //Ricalcola dimensioni se il popup è visibile
        window.addEventListener('resize', function () {
            if (AssociaTecnico_popup && AssociaTecnico_popup.IsVisible()) {
                resizeAssociaTecnicoPopup();
            }
        });
        ASPxClientUtils.AttachEventToElement(window, "load", function () {
            setTimeout(function () {
                if (typeof ForzaChiusura_popup !== "undefined" && ForzaChiusura_popup.IsVisible()) {
                    resizeForzaChiusuraPopup();
                }
                if (typeof ModificaNoteTecnico_popup !== "undefined" && ModificaNoteTecnico_popup.IsVisible()) {
                    resizeModificaNoteTecnicoPopup();
                }
            }, 100);
        });
    </script>
    <script type="text/javascript">
        const eseguitoInfoMap = {
            "5": {
                warning: "!ATTENZIONE: ALLA CHIUSURA DEL TICKET IL TIPO DI ESECUZIONE NON PUÒ ESSERE SU 'NON DEFINITO'",
                msg: "<i class='fa fa-info-circle'></i>&nbsp; Minimo fatturabile: 1 Ora, Arrotondamento: 15 Min"
            },
            "1": { warning: "", msg: "<i class='fa fa-info-circle'></i>&nbsp; Minimo fatturabile: 1 Ora, Arrotondamento: 15 Min" },
            "2": { warning: "", msg: "<i class='fa fa-info-circle'></i>&nbsp; Minimo fatturabile: 1 Ora, Arrotondamento: 15 Min" },
            "3": { warning: "", msg: "<i class='fa fa-info-circle'></i>&nbsp; Minimo fatturabile: 15 Min, Arrotondamento: 0 Min" },
            "4": { warning: "", msg: "<i class='fa fa-info-circle'></i>&nbsp; Minimo fatturabile: 15 Min, Arrotondamento: 0 Min" }
        };

        function updateEseguitoPanel(value) {
            const warningDiv = document.getElementById("EseguitoWarning");
            const panelDiv = document.getElementById("EseguitoPanel");

            const stringValue = (value != null) ? value.toString() : null;
            const info = eseguitoInfoMap[stringValue];

            if (info) {
                warningDiv.innerHTML = info.warning || "";
                panelDiv.innerHTML = info.msg || "";
            } else {
                warningDiv.innerHTML = "";
                panelDiv.innerHTML = "";
            }
        }

        function safeInitPanel() {
            try {
                if (typeof Rbl_TCK_TipoEsecuzioneResponsive !== "undefined" && Rbl_TCK_TipoEsecuzioneResponsive != null) {
                    const currentValue = Rbl_TCK_TipoEsecuzioneResponsive.GetValue();
                    console.log("Init value:", currentValue);
                    updateEseguitoPanel(currentValue);
                } else {
                    console.warn("RadioButtonList non inizializzato");
                }
            } catch (ex) {
                console.error("Errore init panel:", ex);
            }
        }
    </script>
</asp:Content>
