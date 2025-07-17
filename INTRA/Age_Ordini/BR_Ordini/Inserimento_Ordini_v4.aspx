<%@ Page Title="" Language="C#" MasterPageFile="~/SiteRBUtente.Master" AutoEventWireup="true" CodeBehind="Inserimento_Ordini_v4.aspx.cs" Inherits="INTRA.Age_Ordini.BR_Ordini.Inserimento_Ordini_v4" %>

<%@ Register Assembly="DevExpress.Web.v22.1, Version=22.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxLoadingPanel ID="ASPxLoadingPanel1" ClientInstanceName="LoadingPanelDx" runat="server" Modal="true"></dx:ASPxLoadingPanel>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script src="../assets/js/jquery.min.js"></script>
    <script type="text/javascript">
        function SessionExpireAlert(timeout) {

            var seconds = timeout / 1000;


            document.getElementsByName("seconds").innerHTML = seconds;
            setInterval(function () {
                if (seconds > 0) {
                    seconds--;
                    document.getElementById("seconds").innerHTML = seconds;
                }
            }, 1000);

            setTimeout(function () {
                //Show Popup before 20 seconds of timeout.

                $find("mpeTimeout").show();
            }, timeout - 20 * 1000);

            setTimeout(function () {

                ResetSession_Callback.PerformCallback();
            }, timeout);
        }
        function ResetSession() {
            //Redirect to refresh Session.

            ResetSession_Callback.PerformCallback();
        }
    </script>

    <style>
        .btn-success {
            border: 1px solid white !important;
        }

        .btn-danger {
            border: 1px solid white !important;
        }

        .btn-grey, .btn-grey:focus {
            background-color: lightgrey !important;
            border-color: lightgrey !important;
            color: #000;
            border: 1px solid white !important;
        }

            .btn-grey:hover {
                background-color: lightgrey !important;
                border-color: lightgrey !important;
                color: #000;
                opacity: .8;
                border: 1px solid white !important;
            }

        .VisibleColumn {
            display: none !important;
        }

        .InPromoClass {
            background-color: palegreen;
        }

        .modalBackground {
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
        }

        .modalPopup {
            background-color: #FFFFFF;
            width: 300px;
            border: 3px solid #0DA9D0;
            border-radius: 12px;
            padding: 0;
        }

            .modalPopup .header {
                background-color: #2FBDF1;
                height: 30px;
                color: White;
                line-height: 30px;
                text-align: center;
                font-weight: bold;
                border-top-left-radius: 6px;
                border-top-right-radius: 6px;
            }

            .modalPopup .body {
                width: 500px;
                padding: 10px;
                min-height: 50px;
                text-align: center;
                font-weight: bold;
            }

            .modalPopup .footer {
                padding: 6px;
            }

            .modalPopup .yes, .modalPopup .no {
                height: 23px;
                color: White;
                line-height: 23px;
                text-align: center;
                font-weight: bold;
                cursor: pointer;
                border-radius: 4px;
            }

            .modalPopup .yes {
                background-color: #2FBDF1;
                border: 1px solid #0DA9D0;
            }

            .modalPopup .no {
                background-color: #9F9F9F;
                border: 1px solid #5C5C5C;
            }
    </style>

    <script type="text/javascript">
        function Scomparsa() {
            if (Flag_CkbxL.GetSelectedItem().value == 1) { PanelCostotrasporto_Pnl.SetVisible(true) }
            else { PanelCostotrasporto_Pnl.SetVisible(false) }
        }
        function FlagTrasportFunc(s, e) {
            if (Flag_CkbxL.GetSelectedItem().value == 1) { PanelCostotrasporto_Pnl.SetVisible(true) }
            else { PanelCostotrasporto_Pnl.SetVisible(false) }
        }

        function ValidateEditors(s, e) {
            var container = PageControl.GetMainElement();
            ASPxClientEdit.ValidateEditorsInContainer(container);
        }
        function InsArticoloBtn() {

            ViewArticoliInseriti_DxCPan.PerformCallback();
        }
        function InsArticoloBtnEND() {
            ViewArticoliInseriti_DxCPan.ca();
        }
        function TabClick(e) {
        }
        function InitPageControl() {
            var tab = PageControl.GetActiveTab();
        }
        function InserimentoTestataOrdine_Btn_Click(s, e) {
        }
        function OnListinoValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
        }
        var ID = "";
        function OnListinoValidationCodeBehind(ID) {

            ID.isValid = true;
        }
        function OnConsegnaValidation(s, e) {
            var selectedDate = s.date;
            if (selectedDate == null || selectedDate == false)
                return;
            var currentDate = DataOrdine_Txt.GetDate();

            if (currentDate > selectedDate || currentDate > selectedDate)
                e.isValid = false;
        }

        function OnScontiValidation(s, e) {
            var Sconto = e.value;
            if (Sconto == null || Sconto == false) {
                e.isValid = true;
            }
            if (Sconto < 0 || Sconto > 100) {
                e.isValid = false;
            }
            else {
                Gestione_ASPxCallBkPnl.PerformCallback();
            }
        }
        function OnScontiTestataValidation(s, e) {
            var Sconto = e.value;
            if (Sconto == null || Sconto == false) {
                e.isValid = true;
            }
            if (Sconto < 0 || Sconto > 100) {
                e.isValid = false;
            }
        }
        function OnSaveClick(s, e) {

            Notify("Operazione Eseguita!", "Conferma", "success", false, "toast-top-right", false);
        }
        function ErrorMessageGenerazioneOrdine() {
            Notify("Generazione ordine non eseguita, l\'ordine è già stato generato. Contattare gli amministratori del sistema.", "Errore", "Error", false, "toast-top-right", false);
        }
        function OnError(s, e) {

            Notify("Operazione non eseguita!", "Errore", "error", false, "toast-top-right", false);
        }

    </script>
    <style>
        .profile-container .profile-header .profile-info {
            min-height: 0px !important;
        }

        .dxtcSys.dxtc-flex > .dxtc-stripContainer {
            display: block !important;
        }

        .devexpressButton-Style {
            /*padding: 0 !important;*/
        }

        .Devexpress-Textbox {
            max-width: 30% !important;
        }
    </style>
    <asp:LinkButton ID="lnkFake" runat="server" UseSubmitBehavior="false" />

    <dx:ASPxCallback ID="ResetSession_Callback" ClientInstanceName="ResetSession_Callback" runat="server" OnCallback="ResetSession_Callback_Callback">
    </dx:ASPxCallback>
    <%--   <asp:ModalPopupExtender ID="mpeTimeout" BehaviorID="mpeTimeout" runat="server" PopupControlID="pnlPopup" TargetControlID="lnkFake"
        OkControlID="btnYes" BackgroundCssClass="modalBackground" OnOkScript="ResetSession()">
    </asp:ModalPopupExtender>--%>
    <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none" Width="500px">
        <div class="header">
            La sessione si sta per svuotare!
        </div>
        <div class="body">
            La sessione verrà resettata tra&nbsp;<span id="seconds"></span>&nbsp;secondi, questo per evitare possibili errori data la sua prolungata permanenza su questa pagina.<br />
            Vuoi resettarle subito?<br />
            <br />
            N.B. Tutti i dati verranno salvati al momento del reset.
        </div>
        <div class="footer" align="right">
            <asp:Button ID="btnYes" runat="server" Text="SI" CssClass="yes" UseSubmitBehavior="false" />
        </div>
    </asp:Panel>


    <asp:TextBox ID="CodiceArticolo_Txt" runat="server" Visible="false"></asp:TextBox>
    <dx:ASPxLabel ID="CodLisHidden_lbl" ClientVisible="false" runat="server" Text="ASPxLabel"></dx:ASPxLabel>



    <div class="row">
        <div class="col-xs-12 col-md-12 col-lg-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <h4 class="card-title">
                                <asp:Label ID="TitoloPagina_Lbl" runat="server"></asp:Label>


                                <asp:Image ID="StatusOrdine_Img" runat="server" Width="30px" />


                            </h4>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="row">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="col-md-12" style="padding-top: 10px;">

                                    <asp:Panel ID="SelezionaCliente_Pnl" runat="server">
                                        <div class="col-lg-4 col-md-4 col-sm-12  " style="padding-left: 10px; padding-bottom: 5px">
                                            <script type="text/javascript">
                                                var oldEditValue = null;
                                            </script>
                                            <div class="col-lg-12 col-md-12 col-sm-12">
                                                Cliente:
                                                        <br />

                                                <dx:ASPxComboBox ID="Cliente_Ddl" runat="server" ClientInstanceName="Cliente_Ddl" ValueType="System.String" TextField="Denom" ValueField="CodCli" DropDownStyle="DropDown" AutoPostBack="false" TextFormatString="{0} {1}" EnableCallbackMode="true" CallbackPageSize="10" Width="100%" OnItemsRequestedByFilterCondition="Cliente_Ddl_ItemsRequestedByFilterCondition" OnItemRequestedByValue="Cliente_Ddl_ItemRequestedByValue">
                                                    <Columns>
                                                    </Columns>
                                                    <ClearButton DisplayMode="Always">
                                                    </ClearButton>
                                                </dx:ASPxComboBox>
                                                <asp:SqlDataSource ID="Cliente_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>">
                                                    <SelectParameters>
                                                        <asp:ProfileParameter DefaultValue="&quot;&quot;" Name="U_User_Web" PropertyName="UserName" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                    <div class="col-lg-6 col-md-8 col-sm-12 " style="padding-left: 20px;">
                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                            Data Ordine:
                                                        <br />
                                            <dx:ASPxDateEdit ID="DataOrdine_Txt" runat="server" ClientIDMode="Static"></dx:ASPxDateEdit>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                            Data Consegna:
                                                        <br />
                                            <dx:ASPxDateEdit ID="DataConsegna_Txt" runat="server">
                                                <ValidationSettings SetFocusOnError="True" ErrorText="La data di consegna non può essere precedente alla data dell'ordine." ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom" ValidationGroup="OrdiniIns_Vdgrp">
                                                    <RequiredField IsRequired="false" ErrorText="La data di consegna non può essere precedente alla data dell'ordine." />
                                                </ValidationSettings>
                                                <ClientSideEvents Validation="OnConsegnaValidation" />
                                            </dx:ASPxDateEdit>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 NascondiElemento">
                                            Condizioni di pagamento:
                                                        <br />
                                            <style>
                                                .NascondiElemento {
                                                    display: none;
                                                }
                                            </style>
                                            <asp:DropDownList ID="CondizioniPagamento_Ddl" runat="server" DataSourceID="CondizioniPagamento_Dts" DataTextField="Descrizione" DataValueField="CodCPag" Width="130px" CssClass="NascondiElemento">
                                            </asp:DropDownList>
                                        </div>

                                        <dx:ASPxCallback ID="Callback" ClientInstanceName="Callback_Aspx" runat="server" OnCallback="Callback_Callback">
                                            <%--                                                        <ClientSideEvents CallbackComplete="function(s,e){ PageControl.SetVisible(true); grid.SetVisible(true);}" />--%>
                                        </dx:ASPxCallback>
                                    </div>
                                    <div class="col-lg-6 col-md-4 col-sm-12">
                                        <div class="col-lg-12">


                                            <dx:BootstrapButton runat="server" ID="CreaBozza_Btn" ClientInstanceName="NuovoOrdine_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ClientVisible="true"  UseSubmitBehavior="false" >
                                                <Badge Text="crea bozza" IconCssClass="fa fa-save" />
                                                <ClientSideEvents Click="function(s,e){Callback_Aspx.PerformCallback();}" />
                                                <SettingsBootstrap RenderOption="Success" />
                                            </dx:BootstrapButton>

                                            <dx:BootstrapButton runat="server" ID="ConfermaOrdine_Btn" ClientInstanceName="ConfermaOrdine_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ClientVisible="false"  UseSubmitBehavior="false" >
                                                <Badge Text="genera ordine" IconCssClass="fa fa-check" />
                                                <ClientSideEvents Click="function(s,e){ if(confirm('Sei sicuro di voler trasformare questa bozza in un ordine?')){  LoadingPanelDx.Show();ConfermaOrdine_Clbk.PerformCallback();}}" />
                                                <SettingsBootstrap RenderOption="Success" />
                                            </dx:BootstrapButton>


                                            <dx:BootstrapButton runat="server" ID="ModificaOrdine_Btn" ClientInstanceName="ModificaOrdine_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding"  UseSubmitBehavior="false" >
                                                <Badge Text="Salva bozza" IconCssClass="fa fa-save" />
                                                <ClientSideEvents Click="function(s,e){SalvaBozza_CLBK.PerformCallback();}" />
                                                <SettingsBootstrap RenderOption="Warning" />
                                            </dx:BootstrapButton>


                                            <dx:BootstrapButton runat="server" ID="Indietro_Btn" ClientInstanceName="Indietro_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding"  UseSubmitBehavior="false" >
                                                <Badge Text="lista ordini" IconCssClass="fa fa-arrow-left" />
                                                <ClientSideEvents Click="function(s,e){window.location.replace('lista_ordini_v2.aspx')}" />
                                                <SettingsBootstrap RenderOption="Info" />
                                            </dx:BootstrapButton>

                                            <dx:BootstrapButton runat="server" ID="AnnullaOrdine" ClientInstanceName="AnnullaOrdine" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding"  UseSubmitBehavior="false" >
                                                <Badge Text="" IconCssClass="fa fa-trash" />
                                                <ClientSideEvents Click="function(s,e){  e.processOnServer = confirm('Sei sicuro di voler eliminare questa bozza?');}" />
                                                <SettingsBootstrap RenderOption="Danger" />
                                            </dx:BootstrapButton>

                                            <dx:BootstrapButton runat="server" ID="InviaEmailAlCliente_Btn" ClientInstanceName="InviaEmailAlCliente_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding"  UseSubmitBehavior="false" > 
                                                <Badge Text="Invia email al cliente" IconCssClass="fa fa-send" />
                                                <ClientSideEvents Click="function(s,e){InviaMailPopup.Show(); EmailCliente_Txt.SetText(EmailCli_Txt.GetText()); EtichettaPopupEmail_Lbl.SetText('Email Cliente:'); }" />
                                                <SettingsBootstrap RenderOption="Info" />
                                            </dx:BootstrapButton>



                                            <dx:ASPxCallback ID="ConfermaOrdine_Clbk" ClientInstanceName="ConfermaOrdine_Clbk" runat="server" OnCallback="ConfermaOrdine_Clbk_Callback">
                                                <ClientSideEvents CallbackError="function(s,e){LoadingPanelDx.Hide();OnError();}" CallbackComplete="function(s,e){LoadingPanelDx.Hide(); ErrorMessageGenerazioneOrdine();}" />
                                                <%--Si verificherà solo se l'ordine è già inserito perchè rimarrà sempre sulla stessa pagina--%>
                                            </dx:ASPxCallback>

                                            <dx:ASPxCallback ID="SalvaBozza_CLBK" runat="server" ClientInstanceName="SalvaBozza_CLBK" OnCallback="SalvaBozza_CLBK_Callback">
                                                <ClientSideEvents BeginCallback="function(s,e){LoadingPanelDx.Show();}" EndCallback="function(s,e){LoadingPanelDx.Hide();OnSaveClick();}" />
                                            </dx:ASPxCallback>

                                            <asp:Image ID="Image1" runat="server" CssClass="IconaTooltip" ImageUrl="~/img/DevExButton/Info.png" Width="42px" />
                                            <dx:ASPxHint ID="DatiDelCliente_Info" runat="server" TargetSelector=".IconaTooltip" Position="Top" EncodeHtml="false" Content="Per effettuare una ricerca per un codice articolo o/e una descrizione di cui si conosce solo una parte bisognerà inserire la descrizione tra 2 percentuali. Es:</br></br>  Descrizione: %Cavo Acciaio% </br> Codice articolo: %6/04% </br></br>  Le 2 percentuali servono per far capire al portale che si sta cercando un codice simile a quello scritto nel campo testo, quindi è consigliabile usarle sempre, a meno chè non si conosca perfettamente il codice articolo.</br></br>Possono essere usate anche più di due %, se ad esempio si conosce solo la parte iniziale e la parte finale di un codice articolo. Es:</br></br> Codice articolo: %00%14g% ">
                                            </dx:ASPxHint>
                                        </div>

                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12" style="position: initial;">

                            <dx:ASPxPageControl ClientInstanceName="PageControl" Width="100%" Height="200px" ID="PageControl"
                                runat="server" ActiveTabIndex="2" EnableViewState="False" EnableHierarchyRecreation="True">
                                <ClientSideEvents Init="function(s, e) { InitPageControl(); }"
                                    TabClick="function(s, e) { TabClick(e); }"></ClientSideEvents>

                                <TabPages>
                                    <dx:TabPage Name="page1" Text="CLIENTE">

                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                    <ContentTemplate>
                                                        <asp:FormView ID="DetCli_Fw" runat="server" DataSourceID="DetCli_Dts" Width="100%">
                                                            <EmptyDataTemplate>
                                                                <%--                                                                    <asp:HiddenField ID="CodAgeCliente_Hf" runat="server" Value="<%# Eval("CodAge") %>" />--%>
                                                                <div class="col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 15px; padding-bottom: 10px;">
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Nome Cliente:</strong>
                                                                            <br />

                                                                        </div>

                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Num. Tel: </strong>
                                                                            <br />

                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Indirizzo:</strong>
                                                                            <br />

                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Città:</strong>
                                                                            <br />
                                                                            / 
                                                                        / 
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 15px; padding-bottom: 10px;">
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Nazione:</strong>
                                                                            <br />
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>P. Iva:</strong>
                                                                            <br />
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>C.F.:</strong>
                                                                            <br />
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Email Cliente:</strong>
                                                                            <br />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </EmptyDataTemplate>
                                                            <ItemTemplate>
                                                                <dx:ASPxLabel ID="CondizioniDiPagamentoFw_Label" runat="server" Text='<%# Eval("CodCPag") %>' ClientVisible="false"></dx:ASPxLabel>
                                                                <dx:ASPxLabel ID="CodCli_Label" runat="server" Text='<%# Eval("CodCli") %>' ClientVisible="false"></dx:ASPxLabel>

                                                                <div class="col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 15px; padding-bottom: 10px;">
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Nome Cliente:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="NomeCLi_Lbl" runat="server" Text='<%#Eval("denom")  %>'></dx:ASPxLabel>
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12" style="color: red; font-weight: bold">
                                                                            <strong>Sconto Incondizionato:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel Font-Bold="true" ID="ScontoIncondizionato_Lbl" runat="server" Text='<%# string.Format("{0:0.00} %", Eval("ScontoIncondizionato"))  %>' ForeColor="Red" DisabledStyle-Font-Bold="true">
                                                                            </dx:ASPxLabel>
                                                                            <asp:HiddenField ID="ScontoIncondizionato_HFld" runat="server" Value='<%# Eval("ScontoIncondizionato")%>' />

                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Num. Tel: </strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="NumeroTelCli_Lbl" runat="server" Text='<%# Eval("Tel") %>'></dx:ASPxLabel>
                                                                        </div>


                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Indirizzo:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="IndirizzoCli_Lbl" runat="server" Text='<%# Eval("Ind") %>'></dx:ASPxLabel>
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Località:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="CapCli_Lbl" runat="server" Text='<%# Eval("Cap") %>'></dx:ASPxLabel>
                                                                            / 
                                                                <dx:ASPxLabel ID="CittaCli_Lbl" runat="server" Text='<%# Eval("Loc") %>'></dx:ASPxLabel>
                                                                            / 
                                                                <dx:ASPxLabel ID="ProvinciaCli_Lbl" runat="server" Text='<%# Eval("Prov") %>'></dx:ASPxLabel>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 15px; padding-bottom: 10px;">
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Nazione:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="NazioneCli_Lbl" runat="server" Text='<%# Eval("DsNaz") %>'></dx:ASPxLabel>
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>P. Iva:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="PIvaCli_Lbl" runat="server" Text='<%# Eval("PIva") %>'></dx:ASPxLabel>
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>C.F.:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="CFiscaleCli_Lbl" runat="server" Text='<%# Eval("CF") %>'></dx:ASPxLabel>
                                                                        </div>
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Email Cliente:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="EmailCli_Txt" ClientInstanceName="EmailCli_Txt" runat="server" Text='<%# Eval("EMail") %>'></dx:ASPxLabel>
                                                                        </div>
                                                                    </div>
                                                                    <dx:ASPxLabel ID="CodAgeCliente_Txt" runat="server" Text='<%# Eval("codage") %>' ClientVisible="false"></dx:ASPxLabel>

                                                                    <dx:ASPxLabel ID="CodLisCliente_Txt" runat="server" Text='<%# Eval("CodLis") %>' ClientVisible="false"></dx:ASPxLabel>
                                                                    <dx:ASPxLabel ID="TrasportoCliente_Txt" runat="server" Text='<%# Eval("U_Trasporto") %>' ClientVisible="false"></dx:ASPxLabel>
                                                                    <dx:ASPxLabel ID="SpeBan_Lbl" runat="server" Text='<%# Eval("SpeBan") %>' ClientVisible="false"></dx:ASPxLabel>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:FormView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>

                                    <dx:TabPage Name="page3" Text="NOTE">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">

                                                <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 20px; padding-bottom: 20px;">
                                                    Note:
                                                        <br />
                                                    <asp:TextBox ID="NOte_Txt" runat="server" AutoResizeWithContainer="False" TextMode="Multiline" Width="80%" Height="150px"></asp:TextBox>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>

                                    <dx:TabPage Name="page6" Text="DETTAGLIO TRASPORTO">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                    <ContentTemplate>
                                                        <div class="row">
                                                            <div class="col-lg-12 col-md-12 col-sm-12 no-padding" style="padding-top: 20px; padding-bottom: 20px; position: initial;">

                                                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                    <b>Prezzo Trasporto:</b>
                                                                    <dx:ASPxTextBox ID="PrezzoTrasporto_Txt" runat="server" Border-BorderStyle="None" Font-Size="Large" BackColor="Transparent" Enabled="false" ForeColor="Black">
                                                                        <MaskSettings Mask="€<0..99999999999g>.<00..99>" IncludeLiterals="DecimalSymbol" AllowMouseWheel="false" />
                                                                        <Border BorderStyle="None" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                    <b>Varia spese di trasporto?</b>
                                                                    <dx:ASPxRadioButtonList ID="FlagTrasporto_CkbxL" ClientInstanceName="Flag_CkbxL" runat="server" ValueType="System.String" RepeatColumns="2" Width="100px" AutoPostBack="false" SelectedIndex="-1">
                                                                        <ClientSideEvents SelectedIndexChanged="FlagTrasportFunc" />
                                                                        <Items>
                                                                            <dx:ListEditItem Text="SI" Value="1" />
                                                                            <dx:ListEditItem Text="NO" Value="0" Selected="true" />
                                                                        </Items>
                                                                    </dx:ASPxRadioButtonList>

                                                                    <b style="color: red">Selezionare "sì" se vuoi modificare le spese
                                                                         <br />
                                                                        di trasporto attuali.</b>
                                                                </div>
                                                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                    <dx:ASPxPanel ID="PanelCostotrasporto_Pnl" runat="server" ClientInstanceName="PanelCostotrasporto_Pnl" ClientVisible="false">
                                                                        <PanelCollection>
                                                                            <dx:PanelContent>
                                                                                <b>Costo Trasporto:</b>
                                                                                <dx:ASPxTextBox ID="CostoTrasportoForzato_Txt" runat="server" ClientInstanceName="CostoTrasportoForzato_Txt">
                                                                                    <MaskSettings Mask="€<0..99999999999g>.<00..99>" IncludeLiterals="DecimalSymbol" AllowMouseWheel="false" />
                                                                                </dx:ASPxTextBox>
                                                                                <b style="color: red">inserire spese di trasporto concordate con il cliente.<br></br>
                                                                                    In caso di spese di trasporto a ZERO inserire 0
                                                                                </b>
                                                                            </dx:PanelContent>
                                                                        </PanelCollection>
                                                                    </dx:ASPxPanel>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Name="page5" Text="DETTAGLIO ORDINE">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <asp:Panel ID="ListaArticoliERicercaArticoli_Pnl" runat="server">
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-sm-12 no-padding" style="padding-top: 20px; padding-bottom: 20px; position: initial;">
                                                            <div class="col-lg-12 col-md-12 col-sm-12 no-padding" style="padding-left: 27px !important">

                                                                <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                                                    <ContentTemplate>
                                                                        <div class="col-lg-12 col-md-12 col-sm-12" style="padding-bottom: 10px !important">
                                                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                                <b>Codice Articolo:</b>
                                                                                <br />
                                                                                <dx:ASPxTextBox ID="ArticoliCodArtSrch_Txt" runat="server" Width="150px" ClientInstanceName="ArticoliCodArtSrch_Txt">
                                                                                    <%-- <ClientSideEvents TextChanged="function (s,e) {GridviewArticoli_CallBkPnl.PerformCallback(ArticoliSrch_Txt.GetText());}" />--%>
                                                                                </dx:ASPxTextBox>
                                                                            </div>

                                                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                                <b>Descrizione Articolo:</b>
                                                                                <dx:ASPxTextBox ID="ArticoliDescrSrch_Txt" runat="server" Width="150px" ClientInstanceName="ArticoliDescrSrch_Txt">
                                                                                    <%-- <ClientSideEvents TextChanged="function (s,e) {GridviewArticoli_CallBkPnl.PerformCallback(ArticoliSrch_Txt.GetText());}" />--%>
                                                                                </dx:ASPxTextBox>
                                                                            </div>

                                                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                                <dx:BootstrapButton runat="server" ID="Ricerca_Btn" ClientInstanceName="Ricerca_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn"  UseSubmitBehavior="true"  CssClasses-Control="btn btn-sm btn-custom-padding">
                                                                                    <Badge Text="ricerca" IconCssClass="fa fa-search" />
                                                                                    <ClientSideEvents Click="function (s,e) {GridviewArticoli_CallBkPnl.PerformCallback();}" />
                                                                                    <SettingsBootstrap RenderOption="Success" />
                                                                                </dx:BootstrapButton>
                                                                               
                                                                            </div>

                                                                        </div>
                                                                        <%--    <dx:ASPxCallback ID="GrigliaArticoli_Clbk" ClientInstanceName="GrigliaArticoli_Clbk" runat="server" OnCallback="GrigliaArticoli_Clbk_Callback">
                                                                                <ClientSideEvents BeginCallback="function(s,e){LoadingPanelDx.Show();}" />
                                                                                <ClientSideEvents EndCallback="function(s,e){
                                                                                LoadingPanelDx.Hide();
                                                                                //alert('Riga 535 GrigliaArticoli_Clbk - gridArticoliInseriti.Refresh');
                                                                                gridArticoliInseriti.Refresh();
                                                                                ArticoliCodArtSrch_Txt.SetText('');
                                                                                ArticoliDescrSrch_Txt.SetText('');
                                                                                }" />
                                                                            </dx:ASPxCallback>--%>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                                <asp:SqlDataSource ID="Articoli_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT DecPrz, CodLis, Descrizione, CodArt, DescrizioneArticolo, FotoCatalogo, Misura, U_Confez, PrezzoPromo, InPromo, DataInizio, DataFine, Prezzo, RifIva, DecQta, U_Pz_Lordo, U_Sconto1, U_Sconto2 FROM U_ListaArticoliConPromoPerOrdini_View_V2 WHERE (CodLis = @CodLis) AND (CodArt LIKE @CodArt) AND (DescrizioneArticolo LIKE @DescrizioneArticolo) order by CodArt asc">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter DefaultValue="0" Name="CodLis" SessionField="CodLisSession" />
                                                                        <asp:SessionParameter DefaultValue=" " Name="CodArt" SessionField="CodArtSession" />
                                                                        <asp:SessionParameter DefaultValue=" " Name="DescrizioneArticolo" SessionField="DescrArtSession" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>

                                                                <div class="col-lg-3 col-md-3 col-sm-12" style="color: red; font-weight: bold">
                                                                    <strong>Sconto Incondizionato:</strong>
                                                                    <br />
                                                                    <dx:ASPxTextBox ID="ScontoIncondizionato_lbl" runat="server" DisplayFormatString="p2" Border-BorderWidth="0" BackColor="Transparent" Enabled="false" ForeColor="Red" Font-Size="Medium" Font-Bold="true">
                                                                        <Border BorderWidth="0px"></Border>
                                                                    </dx:ASPxTextBox>

                                                                </div>
                                                                <dx:ASPxCallbackPanel ID="GridviewArticoli_CallBkPnl" ClientInstanceName="GridviewArticoli_CallBkPnl" runat="server" Width="100%" OnCallback="GridviewArticoli_CallBkPnl_Callback">
                                                                    <PanelCollection>
                                                                        <dx:PanelContent>
                                                                            <dx:ASPxGridView ID="Articoli_DxGW" ButtonRenderMode="Image" ClientInstanceName="Articoli_DxGW" runat="server" KeyFieldName="CodArt" Width="98%" AutoResizeWithContainer="true"
                                                                                AutoGenerateColumns="False" SettingsBehavior-AllowFocusedRow="true" EnableRowsCache="False" DataSourceID="Articoli_Dts" SettingsAdaptivity-HideDataCellsAtWindowInnerWidth="0" SettingsBehavior-AllowAutoFilter="True" SettingsPager-EnableAdaptivity="True">
                                                                                <%--OnHtmlRowPrepared="Articoli_DxGW_HtmlRowPrepared"--%>
                                                                                <Settings VerticalScrollBarStyle="VirtualSmooth" VerticalScrollBarMode="Hidden" />
                                                                                <%-- <ClientSideEvents EndCallback="function(s,e){ 
                                                                                        //alert('Riga 580 gridArticoliInseriti.Refresh()');
                                                                                        gridArticoliInseriti.Refresh();}" />--%>
                                                                                <Settings ShowFilterRow="false" ShowFilterRowMenu="true" ShowFooter="True" />

                                                                                <SettingsPager PageSize="30" Visible="true">
                                                                                    <PageSizeItemSettings Visible="false"></PageSizeItemSettings>
                                                                                </SettingsPager>
                                                                                <ClientSideEvents CustomButtonClick="function(s,e){ 
                                                                                            if(e.buttonID == 'InserisciArticolo')
                                                                                            {
                                                                                            //GrigliaArticoli_Clbk.PerformCallback(s.GetFocusedRowIndex());
                                                                                        LoadingPanelDx.Show();
                                                                                            GrigliaArticoliInseriti_CallbackPanel.PerformCallback(s.GetFocusedRowIndex());
                                                                                             ArticoliCodArtSrch_Txt.SetText('');
                                                                                            ArticoliDescrSrch_Txt.SetText('');
                                                                                            ArticoliCodArtSrch_Txt.Focus();  
                                                                                            }
                                                                                           }" />
                                                                                <SettingsPager EnableAdaptivity="false">
                                                                                    <PageSizeItemSettings Visible="true" />
                                                                                </SettingsPager>
                                                                                <SettingsEditing Mode="EditForm"></SettingsEditing>
                                                                                <Settings ShowFilterRow="True" GridLines="Both" ShowFilterRowMenu="True" ShowHeaderFilterButton="True" />
                                                                                <SettingsCommandButton>
                                                                                    <NewButton>
                                                                                        <Image ToolTip="Nuovo" Url="~/img/DevExButton/new.png" Width="30px"></Image>
                                                                                    </NewButton>

                                                                                    <UpdateButton ButtonType="Image" RenderMode="Image">
                                                                                        <Image ToolTip="Aggiorna" Height="30px" Url="~/img/DevExButton/update.png"></Image>
                                                                                    </UpdateButton>

                                                                                    <CancelButton ButtonType="Image" RenderMode="Image">
                                                                                        <Image ToolTip="Annulla" Height="30px" Url="~/img/DevExButton/cancel.png"></Image>
                                                                                    </CancelButton>

                                                                                    <EditButton>
                                                                                        <Image ToolTip="Modifica" Height="30px" Url="~/img/DevExButton/edit.png"></Image>
                                                                                    </EditButton>

                                                                                    <DeleteButton ButtonType="Image" RenderMode="Image">
                                                                                        <Image ToolTip="Elimina" Height="30px" Url="~/img/DevExButton/delete.png"></Image>
                                                                                    </DeleteButton>
                                                                                </SettingsCommandButton>
                                                                                <SettingsDataSecurity AllowInsert="false" AllowDelete="false" />
                                                                                <SettingsSearchPanel ShowApplyButton="true" Visible="false" />
                                                                                <Columns>
                                                                                    <dx:GridViewDataTextColumn Caption="Qta" VisibleIndex="0" Settings-AllowFilterBySearchPanel="False" Width="150px">
                                                                                        <Settings AllowFilterBySearchPanel="False" />
                                                                                        <DataItemTemplate>
                                                                                            <dx:ASPxSpinEdit ID="QtaArticolo_Txt" runat="server" Number='<%# (float)Convert.ToDouble(Eval("U_Confez")) %>' MinValue="0.1" NumberType="Float" Increment='1' MaxValue="999999999" Width="100px" ClearButton-DisplayMode="Never">
                                                                                                <ValidationSettings SetFocusOnError="True" ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" ErrorTextPosition="Bottom" ErrorText="Inserire una quantità valida" />

                                                                                                <%-- <RequiredField IsRequired="True" />--%>
                                                                                                <InvalidStyle BackColor="LightPink" />
                                                                                            </dx:ASPxSpinEdit>
                                                                                        </DataItemTemplate>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="2" ReadOnly="True" Width="15%" />
                                                                                    <dx:GridViewDataTextColumn FieldName="DescrizioneArticolo" VisibleIndex="3" ReadOnly="True" Caption="Descrizione" Width="30%" />
                                                                                    <dx:GridViewDataTextColumn FieldName="Misura" VisibleIndex="4" ReadOnly="True" Caption="UM" Settings-AllowFilterBySearchPanel="False">
                                                                                        <Settings AllowFilterBySearchPanel="False" />
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="U_Confez" VisibleIndex="5" ReadOnly="True" Caption="Qta Conf" Settings-AllowFilterBySearchPanel="False">
                                                                                        <Settings AllowFilterBySearchPanel="False" />
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <%--  <dx:GridViewDataSpinEditColumn>
                                                                                   
                                                                               </dx:GridViewDataSpinEditColumn>--%>

                                                                                    <dx:GridViewDataTextColumn FieldName="Prezzo" VisibleIndex="6" ReadOnly="True" Settings-AllowFilterBySearchPanel="False">
                                                                                        <Settings AllowFilterBySearchPanel="False" />
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="InPromo" VisibleIndex="6" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                                                        <Settings AllowFilterBySearchPanel="False" />

                                                                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <%--  <dx:GridViewDataImageColumn FieldName="FotoCatalogo" VisibleIndex="7" ReadOnly="True" PropertiesImage-ImageWidth="30px" Caption="Foto Cat">
                                                                                            <PropertiesImage ImageWidth="30px">
                                                                                            </PropertiesImage>
                                                                                                <HeaderStyle CssClass="VisibleColumn" />
                                                                                            <EditCellStyle CssClass="VisibleColumn" />
                                                                                            <CellStyle CssClass="VisibleColumn" />
                                                                                            <FilterCellStyle CssClass="VisibleColumn" />
                                                                                            <FooterCellStyle CssClass="VisibleColumn" />
                                                                                            <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                                                        </dx:GridViewDataImageColumn>--%>
                                                                                    <dx:GridViewDataTextColumn Caption="Note" VisibleIndex="8" Settings-AllowFilterBySearchPanel="False">
                                                                                        <Settings AllowFilterBySearchPanel="False" />
                                                                                        <DataItemTemplate>
                                                                                            <dx:ASPxTextBox ID="NoteArticolo_Txt" runat="server" Width="100%"></dx:ASPxTextBox>
                                                                                        </DataItemTemplate>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn FieldName="RifIva" Width="5px" VisibleIndex="9" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                                                        <Settings AllowFilterBySearchPanel="False"></Settings>

                                                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                                                        <CellStyle CssClass="VisibleColumn" />
                                                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="DecQta" Width="5px" VisibleIndex="10" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                                                        <Settings AllowFilterBySearchPanel="False"></Settings>

                                                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                                                        <CellStyle CssClass="VisibleColumn" />
                                                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="DecPrz" Width="5px" VisibleIndex="10" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                                                        <Settings AllowFilterBySearchPanel="False"></Settings>

                                                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                                                        <CellStyle CssClass="VisibleColumn" />
                                                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                                                    </dx:GridViewDataTextColumn>






                                                                                    

                                                                                    <dx:GridViewDataTextColumn FieldName="U_Pz_Lordo" Width="5px" VisibleIndex="11" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                                                        <Settings AllowFilterBySearchPanel="False"></Settings>

                                                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                                                        <CellStyle CssClass="VisibleColumn" />
                                                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="U_Sconto1" Width="5px" VisibleIndex="12" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                                                        <Settings AllowFilterBySearchPanel="False"></Settings>

                                                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                                                        <CellStyle CssClass="VisibleColumn" />
                                                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn FieldName="U_Sconto2" Width="0" VisibleIndex="13" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                                                        <Settings AllowFilterBySearchPanel="False"></Settings>

                                                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                                                        <CellStyle CssClass="VisibleColumn" />
                                                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                                                    </dx:GridViewDataTextColumn>


                                                                                    <dx:GridViewCommandColumn ButtonRenderMode="Image" Caption="Inserisci" VisibleIndex="1">
                                                                                        <CustomButtons>
                                                                                            <dx:GridViewCommandColumnCustomButton ID="InserisciArticolo">
                                                                                                <Image Url="~/img/DevExButton/new.png" Height="30px" />
                                                                                            </dx:GridViewCommandColumnCustomButton>
                                                                                        </CustomButtons>
                                                                                    </dx:GridViewCommandColumn>
                                                                                </Columns>
                                                                            </dx:ASPxGridView>
                                                                        </dx:PanelContent>
                                                                    </PanelCollection>
                                                                </dx:ASPxCallbackPanel>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                </TabPages>
                            </dx:ASPxPageControl>

                            <div class="col-lg-12 col-md-12 col-sm-12" style="padding-bottom: 10px;">
                                <br />
                                <%-- <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <div style="padding-left: 40px;">
                                                <asp:UpdateProgress runat="server" ID="UpdateProgress" AssociatedUpdatePanelID="UpdatePanel4" DisplayAfter="0" DynamicLayout="false">
                                                    <ProgressTemplate>
                                                        <img alt="Caricamento in corso..." src="../assets/img/progress.gif" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </div>--%>

                                <dx:ASPxCallbackPanel ID="GrigliaArticoliInseriti_CallbackPanel" ClientInstanceName="GrigliaArticoliInseriti_CallbackPanel" runat="server" Width="100%" OnCallback="GrigliaArticoliInseriti_CallbackPanel_Callback" OnCustomJSProperties="GrigliaArticoliInseriti_CallbackPanel_CustomJSProperties">
                                    <SettingsLoadingPanel Enabled="false" />
                                    <%--                                                <ClientSideEvents BeginCallback="function(s,e){LoadingPanelDx.Show();}" />--%>
                                    <ClientSideEvents EndCallback="function(s,e){
                                                                                LoadingPanelDx.Hide();
                                                                                //alert('Riga 535 GrigliaArticoli_Clbk - gridArticoliInseriti.Refresh');
                                                                                //gridArticoliInseriti.Refresh();
                                                                                ArticoliCodArtSrch_Txt.SetText('');
                                                                                ArticoliDescrSrch_Txt.SetText('');
                                                                                if(s.cpGeneraOrdineVisible != null && s.cpGeneraOrdineVisible != false)
                                                                                    {
                                                                                    ConfermaOrdine_Btn.SetVisible(true);
                                                                                    }
                                                                                    else{
                                                                                    ConfermaOrdine_Btn.SetVisible(false);
                                                                                    }
                                                                                    
                                                                                    }" />
                                    <PanelCollection>
                                        <dx:PanelContent>
                                            <dx:ASPxGridView ID="gridArticoliInseriti" buttonrendermode="Image" ClientInstanceName="gridArticoliInseriti" runat="server" Width="100%" DataSourceID="ArticoliOrdine_Dts" EnableRowsCache="False" AutoGenerateColumns="False" KeyFieldName="CodArt" SettingsEditing-BatchEditSettings-EditMode="Cell" OnRowUpdating="grid_RowUpdating" OnRowDeleting="grid_RowDeleting" OnCustomJSProperties="gridArticoliInseriti_CustomJSProperties">
                                                <ClientSideEvents Init="function(s,e){
                                                               if(s.cpGeneraOrdineVisible != null && s.cpGeneraOrdineVisible != false)
                                                                                    {
                                                                                    ConfermaOrdine_Btn.SetVisible(true);
                                                                                    }
                                                                                    else{
                                                                                    ConfermaOrdine_Btn.SetVisible(false);
                                                                                    }
                                                               }"
                                                    EndCallback="function(s,e){
                                                               if(s.cpGeneraOrdineVisible != null && s.cpGeneraOrdineVisible != false)
                                                                                    {
                                                                                    ConfermaOrdine_Btn.SetVisible(true);
                                                                                    }
                                                                                    else{
                                                                                    ConfermaOrdine_Btn.SetVisible(false);
                                                                                    }
                                                               }" />
                                                <%--<Settings  VerticalScrollBarStyle="VirtualSmooth" />--%>
                                                <SettingsPager PageSize="10" />
                                                <%-- <TotalSummary>
                                                    <dx:ASPxSummaryItem FieldName="TotImp" ShowInColumn="TotImp" SummaryType="Sum" DisplayFormat="Totale: {0:c2}"></dx:ASPxSummaryItem>
                                                </TotalSummary>--%>
                                                <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>
                                                <SettingsEditing Mode="Batch">
                                                </SettingsEditing>
                                                <Settings ShowFooter="true" />
                                                <SettingsCommandButton>
                                                    <NewButton>

                                                        <Image ToolTip="Nuovo" Url="~/img/DevExButton/new.png" Width="30px"></Image>
                                                    </NewButton>
                                                    <UpdateButton ButtonType="Image" RenderMode="Image">
                                                        <Image ToolTip="Aggiorna" Height="30px" Url="~/img/DevExButton/update.png"></Image>
                                                    </UpdateButton>
                                                    <CancelButton ButtonType="Image" RenderMode="Image">
                                                        <Image ToolTip="Annulla" Height="30px" Url="~/img/DevExButton/cancel.png"></Image>
                                                    </CancelButton>
                                                    <EditButton>
                                                        <Image ToolTip="Modifica" Height="30px" Url="~/img/DevExButton/edit.png"></Image>
                                                    </EditButton>
                                                    <DeleteButton ButtonType="Image" RenderMode="Image">
                                                        <Image ToolTip="Elimina" Height="30px" Url="~/img/DevExButton/delete.png"></Image>
                                                    </DeleteButton>
                                                </SettingsCommandButton>
                                                <SettingsDataSecurity AllowInsert="False" />
                                                <%--  <SettingsPopup>
                                                                <EditForm Width="600" />
                                                            </SettingsPopup>--%>
                                                <%--<SettingsLoadingPanel Mode="ShowOnStatusBar" />--%>
                                                <Columns>
                                                    <dx:GridViewCommandColumn ButtonRenderMode="Image" Caption="Rimuovi" VisibleIndex="0" ShowEditButton="false" ShowDeleteButton="True">
                                                    </dx:GridViewCommandColumn>

                                                    <dx:GridViewDataColumn FieldName="CodArt" Caption="Codice Articolo" ReadOnly="true" VisibleIndex="1" Settings-AllowSort="False">
                                                        <%--<EditFormSettings Visible="False" />--%>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataColumn FieldName="Descrizione" Caption="Descrizione Articolo" ReadOnly="true" VisibleIndex="2" Settings-AllowSort="False">
                                                        <%--<EditFormSettings Visible="False" />--%>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataColumn FieldName="UM" ReadOnly="true" Caption="UM" VisibleIndex="3" Settings-AllowSort="False">
                                                        <%--<EditFormSettings Visible="False" />--%>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataColumn FieldName="U_Confez" ReadOnly="true" Caption="Qta Conf." VisibleIndex="3" Settings-AllowSort="False">
                                                        <%-- <EditFormSettings Visible="False" />--%>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataColumn FieldName="Sconto" Caption="Sconto" VisibleIndex="5" ReadOnly="true" Settings-AllowSort="False">
                                                        <%-- <EditFormSettings Visible="False" />--%>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataColumn FieldName="Prezzo" Caption="Prezzo € c/u" VisibleIndex="5" ReadOnly="true" Settings-AllowSort="False">
                                                        <%-- <EditFormSettings Visible="False" />--%>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataSpinEditColumn FieldName="TotQta" Caption="Tot. Quantità" VisibleIndex="4" Settings-AllowSort="False" Width="150px">
                                                        <PropertiesSpinEdit AllowNull="false" MaxValue="999999999" MinValue="0.1" NumberType="Float" Increment="1">
                                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                                <RequiredField IsRequired="true" ErrorText="Campo Obbligatorio" />
                                                            </ValidationSettings>
                                                        </PropertiesSpinEdit>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataSpinEditColumn>
                                                    <dx:GridViewDataColumn FieldName="TotImp" Caption="Tot. Importo  €" VisibleIndex="6" ReadOnly="true" Settings-AllowSort="False">
                                                        <%--<EditFormSettings Visible="False" />--%>
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Note" Caption="Note" VisibleIndex="7" Settings-AllowSort="False" Width="150px">
                                                        <Settings AllowSort="False" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataColumn Caption="Storico" ReadOnly="true" VisibleIndex="0" Settings-AllowSort="False">
                                                        <Settings AllowSort="False" />
                                                        <EditFormSettings Visible="False" />
                                                        <DataItemTemplate>
                                                            <a href="<%#  (Request.QueryString["NOrd"] == null) ? String.Format("javascript:OpenPop('{0}')", Container.VisibleIndex) : null %>" class="btn btn-sm btn-custom-padding" style="color: white;"><i class="fa fa-search"></i></a>
                                                            <%--                                                        <a href="<%# String.Format("javascript:OpenPop('{0}')", Container.VisibleIndex)%>" class="btn btn-large icon-only btn-sky" style="color: white;"><i class="fa fa-search"></i></a>--%>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataTextColumn FieldName="NRiga" Caption="NRiga" VisibleIndex="8" SortOrder="Descending">
                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                        <CellStyle CssClass="VisibleColumn" />
                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CodIva" VisibleIndex="9" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                        <CellStyle CssClass="VisibleColumn" />
                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="NumDec" VisibleIndex="10" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                        <CellStyle CssClass="VisibleColumn" />
                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="U_Pz_Lordo" Width="0" VisibleIndex="11" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                        <CellStyle CssClass="VisibleColumn" />
                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="U_Sc1" Width="0" VisibleIndex="12" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                        <CellStyle CssClass="VisibleColumn" />
                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="U_Sc2" Width="0" VisibleIndex="13" ReadOnly="True" Settings-AllowFilterBySearchPanel="False" CellStyle-HorizontalAlign="Center">
                                                        <HeaderStyle CssClass="VisibleColumn" />
                                                        <EditCellStyle CssClass="VisibleColumn" />
                                                        <CellStyle CssClass="VisibleColumn" />
                                                        <FilterCellStyle CssClass="VisibleColumn" />
                                                        <FooterCellStyle CssClass="VisibleColumn" />
                                                        <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                                <Settings ShowFooter="true" />
                                                <TotalSummary>
                                                    <dx:ASPxSummaryItem FieldName="TotImp" ShowInColumn="TotImp" SummaryType="Sum" DisplayFormat="Totale: {0:c2}"></dx:ASPxSummaryItem>
                                                </TotalSummary>
                                                <SettingsDataSecurity AllowInsert="False" />

                                            </dx:ASPxGridView>

                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>

                                <%--     </ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <dx:ASPxCallback ID="CallbackPerPopup_Clbk" ClientInstanceName="CallbackPerPopup_Clbk" runat="server" OnCallback="CallbackPerPopup_Clbk_Callback">
                                            <ClientSideEvents EndCallback="function(s,e){
                                                     //alert('Riga 798 StoricoInst_Grw.Refresh()');
                                                    ClientPopupControl.Show(); StoricoInst_Grw.Refresh();}" />
                                        </dx:ASPxCallback>
                                        <script>
                                            var VisibleIndex;
                                            function OpenPop(VisibleIndex) {
                                                gridArticoliInseriti.GetRowValues(VisibleIndex, 'CodArt', OnGetRowValues);
                                                CallbackPerPopup_Clbk.PerformCallback(VisibleIndex);
                                            };
                                            function OnGetRowValues(values) {
                                                var fName1 = values;
                                                ClientPopupControl.SetHeaderText('STORICO VENDITE ARTICOLO: ' + fName1);
                                            }
                                        </script>
                                        <dx:ASPxPopupControl ID="PopupControl" runat="server" CloseAction="OuterMouseClick"
                                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True"
                                            ShowFooter="True" HeaderText="" ClientInstanceName="ClientPopupControl" Width="900px">
                                            <%--<ClientSideEvents  Shown="function(s,e){StoricoInst_Grw.Refresh();}" />--%>
                                            <ContentCollection>
                                                <dx:PopupControlContentControl>
                                                    <div style="vertical-align: middle">
                                                        <dx:ASPxGridView ID="Storico_Grw" ClientInstanceName="StoricoInst_Grw" runat="server" KeyFieldName="IdRow" DataSourceID="StoricoOrdiniPerAgeCli_LINQ" AutoGenerateColumns="False" Width="100%">
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn FieldName="Prezzo" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Sconto" Caption="Sc1" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Sconto2" Caption="Sc2" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataDateColumn FieldName="DataOrdCli" Caption="Data" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataTextColumn FieldName="QtaOrd" Caption="Qta" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                </dx:GridViewDataTextColumn>
                                                                <%--<dx:GridViewDataTextColumn FieldName="CodArt" Caption="Codice Articolo" ShowInCustomizationForm="True" VisibleIndex="5">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Descrizione" ShowInCustomizationForm="True" VisibleIndex="6">
                                                                    </dx:GridViewDataTextColumn>--%>
                                                            </Columns>
                                                        </dx:ASPxGridView>
                                                    </div>
                                                </dx:PopupControlContentControl>
                                            </ContentCollection>
                                            <FooterTemplate>
                                                <div style="display: table; margin: 6px 6px 6px auto;">
                                                    <%--  <dx:ASPxButton ID="UpdateButton" runat="server" Text="Update Content" AutoPostBack="False"
                                                            ClientSideEvents-Click="function(s, e) { ClientPopupControl.PerformCallback(); }" />--%>
                                                </div>
                                            </FooterTemplate>
                                        </dx:ASPxPopupControl>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                    <ContentTemplate>
                                        <dx:ASPxPopupControl ID="InviaMailPopup" runat="server"
                                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                                            ShowFooter="True" HeaderText="" ClientInstanceName="InviaMailPopup" Width="900px">
                                            <%--<ClientSideEvents  Shown="function(s,e){StoricoInst_Grw.Refresh();}" />--%>
                                            <ContentCollection>
                                                <dx:PopupControlContentControl>
                                                    <div style="vertical-align: middle">
                                                        <dx:ASPxLabel ID="EtichettaPopupEmail_Lbl" ClientInstanceName="EtichettaPopupEmail_Lbl" runat="server" Text=" Email cliente:"></dx:ASPxLabel>
                                                        <dx:ASPxTextBox ID="EmailCliente_Txt" runat="server" Width="100%" ClientInstanceName="EmailCliente_Txt">
                                                            <ValidationSettings ErrorDisplayMode="Text" ErrorTextPosition="Bottom" ValidationGroup="EmailClienteValid">
                                                                <RegularExpression ValidationExpression="(\w|[\.\-])+@(\w|[\-]+\.)*(\w|[\-]){2,63}\.[a-zA-Z]{2,4}" ErrorText="Inserisci una mail valida" />
                                                                <RequiredField IsRequired="true" ErrorText="Campo Obbligatorio" />

                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </dx:PopupControlContentControl>
                                            </ContentCollection>
                                            <FooterTemplate>
                                                <div style="display: table; margin: 6px 6px 6px auto;">

                                                    <dx:ASPxButton ID="InviaMail_Btn" runat="server" Text="Invia" ValidationGroup="EmailClienteValid" AutoPostBack="false" UseSubmitBehavior="false">
                                                        <ClientSideEvents Click="function(s,e){
                                                                if(EmailCliente_Txt.GetIsValid()){
                                                                ASPxCallback1.PerformCallback();
                                                                OnSaveClick();InviaMailPopup.Hide();}
                                                                }" />
                                                    </dx:ASPxButton>
                                                </div>
                                            </FooterTemplate>
                                        </dx:ASPxPopupControl>
                                        <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="ASPxCallback1" OnCallback="ASPxCallback1_Callback">
                                            <ClientSideEvents EndCallback="function(s,e){EmailCliente_Txt.SetText('');}" />
                                        </dx:ASPxCallback>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <dx:LinqServerModeDataSource ID="StoricoOrdiniPerAgeCli_LINQ" runat="server" OnSelecting="StoricoOrdiniPerAgeCli_LINQ_Selecting" TableName="U_StoricoVenditeArticoloPerAgentePerCliente_VIew" ContextTypeName="U_StoricoVenditeArticoloPerAgentePerCliente_LINQDataContext" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="ArticoliOrdine_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT U_OrdCliDettBozze.CodArt, U_OrdCliDettBozze.U_Confez_Intra AS U_Confez, Articoli.Descrizione, U_OrdCliDettBozze.Prezzo, U_OrdCliDettBozze.QtaOrd AS TotQta, U_OrdCliDettBozze.NRiga, U_OrdCliDettBozze.Importo AS TotImp, U_OrdCliDettBozze.UM, U_OrdCliDettBozze.Note, U_OrdCliDettBozze.Sconto, U_OrdCliDettBozze.NumDec, U_OrdCliDettBozze.CodIva, U_OrdCliDettBozze.U_Pz_Lordo, U_OrdCliDettBozze.U_Sc1, U_OrdCliDettBozze.U_Sc2 FROM Articoli RIGHT OUTER JOIN U_OrdCliDettBozze ON Articoli.CodArt = U_OrdCliDettBozze.CodArt WHERE (U_OrdCliDettBozze.IDTestata = @ID)" UpdateCommand="UPDATE OrdCliDett SET U_Posizione = U_Posizione WHERE (1 = 2)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="ID" QueryStringField="IdOrd" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="CondizioniPagamento_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT TabPag.CodCPag, TabPag.Descrizione, TabPag.Tipo, U_OrdCliTestBozze.ID FROM TabPag INNER JOIN U_OrdCliTestBozze ON TabPag.CodCPag = U_OrdCliTestBozze.CodPag WHERE (U_OrdCliTestBozze.ID = @IdOrd)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="IdOrd" Name="IdOrd"></asp:QueryStringParameter>

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DetCli_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT Clienti.Denom, Clienti.U_Trasporto, Clienti.Ind, Clienti.Cap, Clienti.Prov, Clienti.Loc, Clienti.Tel, Clienti.PIva, Clienti.CF, Clienti.DsNaz, Clienti.EMail, CliFatt3.CodLis, CliFatt3.CodAge, CASE WHEN CliFatt1.Sconto1 IS NULL THEN 0 ELSE CliFatt1.Sconto1 END AS ScontoIncondizionatoOLD, TabPag.PercScPag AS ScontoIncondizionato, TabPag.SpeBan, TabPag.CodCPag, Clienti.CodCli FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN U_OrdCliTestBozze ON Clienti.CodCli = U_OrdCliTestBozze.CodCli INNER JOIN CliFatt1 ON Clienti.CodCli = CliFatt1.CodCli LEFT OUTER JOIN TabPag ON CliFatt1.CodPag = TabPag.CodCPag WHERE (U_OrdCliTestBozze.ID = @IdOrd)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdOrd" QueryStringField="IdOrd" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
