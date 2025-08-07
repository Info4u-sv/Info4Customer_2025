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
            if (window.innerWidth >= 992) {
                // Desktop
                collapse1.classList.add('in');  // apre il pannello
            } else {
                // Mobile/tablet
                collapse1.classList.remove('in'); // chiude il pannello
            }
        });
        </script>
    <style>
        .dxgvDataRow_Office365:last-child td.dxgv, .dxgvTable_Office365 {
            border-bottom: 0px solid rgba(0,0,0,0.1) !important;
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
                    <div style="float: right; padding-right: 10px; padding-top: 4px;">
                        <dx:BootstrapButton
                            runat="server"
                            ID="AvviaTicket_Btn"
                            ClientInstanceName="AvviaTicket_Btn"
                            AutoPostBack="false"
                            CssClasses-Control="btn btn-just-icon btn-just-icon-padding"
                            Style="min-width: 150px; z-index: 9999 !important;"
                            ToolTip="Avvia il ticket"
                            Badge-CssClass="BadgeBtn-just-icon">

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
                            Badge-CssClass="BadgeBtn-just-icon">

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
                            Badge-CssClass="BadgeBtn-just-icon">

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
                            Badge-CssClass="BadgeBtn-just-icon">

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
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" href="#collapse1">CLIENTE</a>
                                        </h4>
                                    </div>
                                    <div id="collapse1" class="panel-collapse collapse">
                                        <div class="panel-body" style="padding: 0!important">
                                            <dx:ASPxCallbackPanel ID="CallbackPnlFormView" runat="server" ClientInstanceName="CallbackPnlFormView" OnCallback="Edit_CallbackPnl_Callback">
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
                                            <h4 class="card-title">Dettagli Intervento</h4>
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


    <dx:ASPxCallback ID="Update_FormLayout_Callback" ClientInstanceName="Update_FormLayout_Callback" runat="server" OnCallback="Update_FormLayout_Callback_Callback" Style="float: right">
        <ClientSideEvents
            EndCallback="function(s,e){
    CallbackPnlFormView.PerformCallback();
             CallbackPnlFormViewEseguito.PerformCallback();
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

    <!-- Datasource per combo tecnici -->
    <asp:SqlDataSource ID="Tecnici_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT aspnet_Users.UserName FROM aspnet_Users INNER JOIN aspnet_UsersInRoles ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId INNER JOIN aspnet_Roles ON aspnet_UsersInRoles.RoleId = aspnet_Roles.RoleId WHERE aspnet_Roles.RoleName = 'tecnico'"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
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
    </script>
    <script>
        ASPxClientUtils.AttachEventToElement(window, "load", function () {
            setTimeout(function () {
                if (typeof ForzaChiusura_popup !== "undefined" && ForzaChiusura_popup.IsVisible()) {
                    resizeForzaChiusuraPopup();
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
