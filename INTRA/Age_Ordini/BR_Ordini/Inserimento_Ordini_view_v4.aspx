<%@ Page Title="" Language="C#" MasterPageFile="~/SiteRBUtente.Master" AutoEventWireup="true" CodeBehind="Inserimento_Ordini_view_v4.aspx.cs" Inherits="INTRA.Age_Ordini.BR_Ordini.Inserimento_Ordini_view_v4" %>

<%@ Register Assembly="DevExpress.Web.v22.1, Version=22.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>


<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxLoadingPanel ID="ASPxLoadingPanel1" ClientInstanceName="LoadingPanelDx" runat="server" Modal="true"></dx:ASPxLoadingPanel>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

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



            </script>

            <asp:TextBox ID="CodiceArticolo_Txt" runat="server" Visible="false"></asp:TextBox>
            <div class="row">
                <div class="col-xs-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="card-header card-header-icon" data-background-color="orange">
                            <i class="material-icons">assignment</i>
                        </div>
                        <div class="card-content">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <h4 class="card-title">
                                        <asp:Label ID="TitoloPagina_Lbl" runat="server"></asp:Label>


                                        <asp:Image ID="StatusOrdine_Img" runat="server" Width="30px" />


                                    </h4>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <div class="row">
                                <div class="col-md-12" style="padding-top: 10px;">

                                    <asp:Panel ID="SelezionaCliente_Pnl" runat="server">
                                        <div class="col-lg-4 col-md-4 col-sm-12  " style="padding-left: 10px; padding-bottom: 5px">

                                            <div class="col-lg-12 col-md-12 col-sm-12">
                                                Cliente:
                                                        <br />
                                                <dx:ASPxCallback ID="Callback" ClientInstanceName="Callback_Aspx" runat="server" OnCallback="Callback_Callback">
                                                    <ClientSideEvents CallbackComplete="function(s,e){ PageControl.SetVisible(true); grid.SetVisible(true)}" />
                                                </dx:ASPxCallback>
                                                <dx:ASPxComboBox ID="Cliente_Ddl" runat="server" ClientInstanceName="Cliente_Ddl" ValueType="System.String" TextField="Denom" ValueField="CodCli" DropDownStyle="DropDown" AutoPostBack="true" TextFormatString="{0} {1}" EnableCallbackMode="true" CallbackPageSize="10" Width="100%" OnItemsRequestedByFilterCondition="Cliente_Ddl_ItemsRequestedByFilterCondition" OnItemRequestedByValue="Cliente_Ddl_ItemRequestedByValue">
                                                    <ClientSideEvents SelectedIndexChanged="function(s,e){Callback_Aspx.PerformCallback();}" />
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
                                    <style>
                                        .tastidate {
                                            display: none !important;
                                        }
                                    </style>

                                </div>

                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <div class="col-lg-12">
                                      

                                        <dx:BootstrapButton runat="server" ID="InviaMail_Btn" ClientInstanceName="InviaMail_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" UseSubmitBehavior="false">
                                            <Badge Text="Invia per email" IconCssClass="fa fa-send" />
                                             <ClientSideEvents Click="function(s,e){InviaMailPopup.Show(); EtichettaPopupEmail_Lbl.SetText('Email:');EmailCliente_Txt.SetText('');}" />
                                            <SettingsBootstrap RenderOption="Warning" />
                                        </dx:BootstrapButton>

                                         <dx:BootstrapButton runat="server" ID="InviaEmailAlCliente_Btn" ClientInstanceName="InviaEmailAlCliente_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding"  UseSubmitBehavior="false" > 
                                                <Badge Text="Invia email al cliente" IconCssClass="fa fa-send" />
                                                <ClientSideEvents Click="function(s,e){InviaMailPopup.Show(); EmailCliente_Txt.SetText(EmailCli_Txt.GetText()); EtichettaPopupEmail_Lbl.SetText('Email Cliente:'); }" />
                                                <SettingsBootstrap RenderOption="Info" />
                                            </dx:BootstrapButton>


                                            <dx:BootstrapButton runat="server" ID="ConfermaOrdine_Btn" ClientInstanceName="ConfermaOrdine_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ClientVisible="false"  UseSubmitBehavior="false" >
                                                <Badge Text="conferma ordine" IconCssClass="fa fa-check" />
                                                 <ClientSideEvents Click="function(s,e){LoadingPanelDx.Show();ConfermaOrdine_Clbk.PerformCallback();}" />
                                                <SettingsBootstrap RenderOption="Success" />
                                            </dx:BootstrapButton>


                                      
                                        <dx:ASPxCallback ID="ConfermaOrdine_Clbk" ClientInstanceName="ConfermaOrdine_Clbk" runat="server" OnCallback="ConfermaOrdine_Clbk_Callback"></dx:ASPxCallback>
                                              <dx:BootstrapButton runat="server" ID="Indietro_Btn" ClientInstanceName="Indietro_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding"  UseSubmitBehavior="false" >
                                                <Badge Text="lista ordini" IconCssClass="fa fa-arrow-left" />
                                                <ClientSideEvents Click="function(s,e){window.location.replace('lista_ordini_v2.aspx')}" />
                                                <SettingsBootstrap RenderOption="Info" />
                                            </dx:BootstrapButton>


                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12" style="position: initial;">
                                    <dx:ASPxPageControl ClientInstanceName="PageControl" Width="100%" Height="200px" ID="PageControl"
                                        runat="server" ActiveTabIndex="1" EnableViewState="False" EnableHierarchyRecreation="True">
                                        <ClientSideEvents Init="function(s, e) { InitPageControl(); }"
                                            TabClick="function(s, e) { TabClick(e); }"></ClientSideEvents>

                                        <TabPages>
                                            <dx:TabPage Name="page1" Text="CLIENTE">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">

                                                        <asp:FormView ID="DetCli_Fw" runat="server" DataSourceID="DetCli_Dts" Width="100%" OnDataBound="DetCli_Fw_DataBound">
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
                                                                <div class="col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 15px; padding-bottom: 10px;">
                                                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                                                            <strong>Nome Cliente:</strong>
                                                                            <br />
                                                                            <dx:ASPxLabel ID="NomeCLi_Lbl" runat="server" Text='<%# Eval("denom") %>'></dx:ASPxLabel>
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
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:FormView>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>

                                            <dx:TabPage Name="page3" Text="RIEPILOGO ORDINE">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 20px; padding-bottom: 20px;">
                                                            <div class="col-lg-2 col-md-3 col-sm-6 col-xs-6">
                                                                <strong>Data Ordine:</strong>
                                                                <br />

                                                                <dx:ASPxDateEdit ID="DataOrdine_Txt" runat="server" ClientIDMode="Static" BackColor="Transparent">
                                                                    <Border BorderStyle="None" />
                                                                    <ButtonStyle CssClass="tastidate"></ButtonStyle>
                                                                </dx:ASPxDateEdit>
                                                            </div>
                                                            <div class="col-lg-2 col-md-3 col-sm-6 col-xs-6">
                                                                <strong>Data Consegna:</strong>
                                                                <br />
                                                                <dx:ASPxDateEdit ID="DataConsegna_Txt" runat="server" BackColor="Transparent">
                                                                    <ValidationSettings SetFocusOnError="True" ErrorText="La data di consegna non può essere precedente alla data dell'ordine." ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom" ValidationGroup="OrdiniIns_Vdgrp">
                                                                        <RequiredField IsRequired="false" ErrorText="La data di consegna non può essere precedente alla data dell'ordine." />
                                                                    </ValidationSettings>
                                                                    <ClientSideEvents Validation="OnConsegnaValidation" />
                                                                    <Border BorderStyle="None" />
                                                                    <ButtonStyle CssClass="tastidate"></ButtonStyle>
                                                                </dx:ASPxDateEdit>
                                                            </div>
                                                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                                <strong>Condizioni di pagamento:</strong>
                                                                <br />
                                                                <dx:ASPxLabel ID="CondizioniPagamento_lbl" runat="server"></dx:ASPxLabel>
                                                                <%--   <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="CondizioniPagamento_Dts" DataTextField="Descrizione" DataValueField="CodCPag" Width="130px">
                                                                </asp:DropDownList>--%>
                                                            </div>





                                                            <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12">
                                                                <strong>Prezzo Trasporto: </strong>
                                                                <dx:ASPxTextBox ID="PrezzoTrasporto_Txt" runat="server" Border-BorderStyle="None" Font-Size="Large" BackColor="Transparent" Enabled="false" ForeColor="Black">
                                                                    <MaskSettings Mask="€<0..99999999999g>.<00..99>" IncludeLiterals="DecimalSymbol" AllowMouseWheel="false" />
                                                                    <Border BorderStyle="None" />
                                                                </dx:ASPxTextBox>
                                                            </div>

                                                            <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12">
                                                                <dx:ASPxPanel ID="PanelCostotrasporto_Pnl" runat="server" ClientInstanceName="PanelCostotrasporto_Pnl" ClientVisible="true">
                                                                    <PanelCollection>
                                                                        <dx:PanelContent>
                                                                            <strong>Costo Trasporto scelto:  </strong>

                                                                            <dx:ASPxTextBox ID="CostoTrasportoForzato_Txt" runat="server" ClientInstanceName="CostoTrasportoForzato_Txt" Border-BorderStyle="None" Font-Size="Large" BackColor="Transparent" Enabled="false" ForeColor="Black">
                                                                                <MaskSettings Mask="€<0..99999999999g>.<00..99>" IncludeLiterals="DecimalSymbol" AllowMouseWheel="false" />
                                                                                <Border BorderStyle="None" />
                                                                            </dx:ASPxTextBox>
                                                                        </dx:PanelContent>
                                                                    </PanelCollection>
                                                                </dx:ASPxPanel>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">

                                                            <dx:ASPxRadioButtonList ID="FlagTrasporto_CkbxL" ClientVisible="false" ClientInstanceName="Flag_CkbxL" runat="server" ValueType="System.String" RepeatColumns="2" Width="100px" AutoPostBack="false" SelectedIndex="-1">
                                                                <ClientSideEvents SelectedIndexChanged="FlagTrasportFunc" />
                                                                <Items>
                                                                    <dx:ListEditItem Text="SI" Value="1" />
                                                                    <dx:ListEditItem Text="NO" Value="0" />
                                                                </Items>
                                                            </dx:ASPxRadioButtonList>

                                                        </div>

                                                        <div class="col-lg-12 col-md-12 col-sm-12" style="padding-top: 20px; padding-bottom: 20px;">
                                                            <strong>Note: </strong>
                                                            <br />
                                                            <asp:Label ID="NOte_Txt" runat="server" AutoResizeWithContainer="False" TextMode="Multiline" Width="80%" Height="20px"></asp:Label>
                                                        </div>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>


                                            <dx:TabPage Name="page5" Text="DETTAGLIO ORDINE">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <asp:Panel ID="ListaArticoliERicercaArticoli_Pnl" runat="server">
                                                            <div class="row">
                                                                <div class="col-lg-12 col-md-12 col-sm-12 " style="padding-top: 20px; padding-bottom: 0px; position: initial;">
                                                                    <div class="col-lg-12 col-md-12 col-sm-12 no-padding" style="padding-left: 0px !important">
                                                                        <div class="col-lg-12 col-md-12 col-sm-12" style="padding-bottom: 0px !important">
                                                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                                <b>Codice Articolo:</b>
                                                                                <br />
                                                                                <dx:ASPxTextBox ID="ArticoliCodArtSrch_Txt" runat="server" Width="300px" ClientInstanceName="ArticoliCodArtSrch_Txt">
                                                                                    <%-- <ClientSideEvents TextChanged="function (s,e) {GridviewArticoli_CallBkPnl.PerformCallback(ArticoliSrch_Txt.GetText());}" />--%>
                                                                                </dx:ASPxTextBox>
                                                                            </div>

                                                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                                <b>Descrizione Articolo:</b>
                                                                                <dx:ASPxTextBox ID="ArticoliDescrSrch_Txt" runat="server" Width="300px" ClientInstanceName="ArticoliDescrSrch_Txt">
                                                                                    <%-- <ClientSideEvents TextChanged="function (s,e) {GridviewArticoli_CallBkPnl.PerformCallback(ArticoliSrch_Txt.GetText());}" />--%>
                                                                                </dx:ASPxTextBox>
                                                                            </div>
                                                                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                                                <br />
                                                                                <dx:ASPxButton ID="Ricerca_Btn" ClientInstanceName="Ricerca_Btn" runat="server" Text="Ricerca" UseSubmitBehavior="true" CausesValidation="false" AutoPostBack="false">
                                                                                    <ClientSideEvents Click="function (s,e) {GridviewArticoli_CallBkPnl.PerformCallback();}" />
                                                                                </dx:ASPxButton>
                                                                            </div>
                                                                        </div>


                                                                        <dx:ASPxCallbackPanel ID="GridviewArticoli_CallBkPnl" ClientInstanceName="GridviewArticoli_CallBkPnl" runat="server" Width="100%" OnCallback="GridviewArticoli_CallBkPnl_Callback">
                                                                            <%--  <ClientSideEvents EndCallback="function (s,e){Articoli_DxGW.Refresh();}" />--%>
                                                                            <PanelCollection>
                                                                                <dx:PanelContent>
                                                                                    <dx:ASPxGridView ID="Articoli_DxGW" ButtonRenderMode="Image" ClientInstanceName="Articoli_DxGW" runat="server" KeyFieldName="CodArt" Width="98%" AutoResizeWithContainer="true"
                                                                                        AutoGenerateColumns="False" DataSourceID="Articoli_Dts" EnableRowsCache="False" SettingsAdaptivity-HideDataCellsAtWindowInnerWidth="0" SettingsBehavior-AllowAutoFilter="True" SettingsPager-EnableAdaptivity="True" OnHtmlRowPrepared="Articoli_DxGW_HtmlRowPrepared">
                                                                                        <Settings ShowFilterRow="True" GridLines="Both" ShowFilterRowMenu="True" ShowHeaderFilterButton="True" />
                                                                                        <ClientSideEvents CustomButtonClick="function(s,e){ 
                                                                                            if(e.buttonID == 'InserisciArticolo')
                                                                                            {
                                                                                            GrigliaArticoli_Clbk.PerformCallback(e.visibleIndex);
                                                                                             ArticoliCodArtSrch_Txt.SetText('');
                                                                                ArticoliDescrSrch_Txt.SetText('');
                                                                                            }
                                                                                           }" />
                                                                                        <Settings VerticalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" />
                                                                                        <SettingsSearchPanel ShowApplyButton="true" Visible="false" />
                                                                                        <SettingsPager EnableAdaptivity="false">
                                                                                            <PageSizeItemSettings Visible="true" />
                                                                                        </SettingsPager>
                                                                                        <ClientSideEvents EndCallback="function(s,e){grid.Refresh();}" />
                                                                                        <SettingsEditing Mode="EditForm"></SettingsEditing>
                                                                                        <SettingsCommandButton>
                                                                                            <NewButton>
                                                                                                <Image ToolTip="Nuovo" Url="../img/DevExButton/new.png" Width="30px"></Image>
                                                                                            </NewButton>

                                                                                            <UpdateButton ButtonType="Image" RenderMode="Image">
                                                                                                <Image ToolTip="Aggiorna" Height="30px" Url="../img/DevExButton/update.png"></Image>
                                                                                            </UpdateButton>

                                                                                            <CancelButton ButtonType="Image" RenderMode="Image">
                                                                                                <Image ToolTip="Annulla" Height="30px" Url="../img/DevExButton/cancel.png"></Image>
                                                                                            </CancelButton>

                                                                                            <EditButton>
                                                                                                <Image ToolTip="Modifica" Height="30px" Url="../img/DevExButton/edit.png"></Image>
                                                                                            </EditButton>

                                                                                            <DeleteButton ButtonType="Image" RenderMode="Image">
                                                                                                <Image ToolTip="Elimina" Height="30px" Url="../img/DevExButton/delete.png"></Image>
                                                                                            </DeleteButton>
                                                                                        </SettingsCommandButton>
                                                                                        <Columns>
                                                                                            <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="1" ReadOnly="True" />
                                                                                            <dx:GridViewDataTextColumn FieldName="DescrizioneArticolo" VisibleIndex="2" ReadOnly="True" Caption="Descrizione" Width="15%" />
                                                                                            <dx:GridViewDataTextColumn FieldName="Misura" VisibleIndex="3" ReadOnly="True" Caption="UM" Settings-AllowFilterBySearchPanel="False">
                                                                                                <Settings AllowFilterBySearchPanel="False" />
                                                                                            </dx:GridViewDataTextColumn>
                                                                                            <dx:GridViewDataTextColumn FieldName="U_Confez" VisibleIndex="4" ReadOnly="True" Caption="Qta Conf" Settings-AllowFilterBySearchPanel="False">
                                                                                                <Settings AllowFilterBySearchPanel="False" />
                                                                                            </dx:GridViewDataTextColumn>
                                                                                            <%--  <dx:GridViewDataSpinEditColumn>
                                                                                   
                                                                               </dx:GridViewDataSpinEditColumn>--%>
                                                                                            <dx:GridViewDataTextColumn Caption="Qta" VisibleIndex="5" Settings-AllowFilterBySearchPanel="False">
                                                                                                <Settings AllowFilterBySearchPanel="False" />
                                                                                                <DataItemTemplate>
                                                                                                    <dx:ASPxSpinEdit ID="QtaArticolo_Txt" runat="server" Number='<%# (float)Convert.ToDouble(Eval("U_Confez")) %>' MinValue="0.1" NumberType="Float" Increment='1' MaxValue="999999999" Width="100px" ClearButton-DisplayMode="Never">
                                                                                                        <ValidationSettings SetFocusOnError="True" ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" ErrorTextPosition="Bottom" ErrorText="Inserire una quantità valida" />

                                                                                                        <%-- <RequiredField IsRequired="True" />--%>
                                                                                                        <InvalidStyle BackColor="LightPink" />
                                                                                                    </dx:ASPxSpinEdit>
                                                                                                </DataItemTemplate>
                                                                                            </dx:GridViewDataTextColumn>
                                                                                            <dx:GridViewDataTextColumn FieldName="Prezzo" VisibleIndex="6" ReadOnly="True" Settings-AllowFilterBySearchPanel="False">
                                                                                                <Settings AllowFilterBySearchPanel="False" />
                                                                                            </dx:GridViewDataTextColumn>
                                                                                            <%--<dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="6" ReadOnly="True" Caption="Listino" />--%>
                                                                                            <dx:GridViewDataImageColumn FieldName="FotoCatalogo" VisibleIndex="7" ReadOnly="True" PropertiesImage-ImageWidth="30px" Caption="Foto Cat">
                                                                                                <PropertiesImage ImageWidth="30px">
                                                                                                </PropertiesImage>
                                                                                            </dx:GridViewDataImageColumn>
                                                                                            <%--    <dx:GridViewDataTextColumn FieldName="FotoCatalogo" VisibleIndex="7" ReadOnly="True" />--%>
                                                                                            <dx:GridViewDataTextColumn Caption="Note" VisibleIndex="8" Settings-AllowFilterBySearchPanel="False">
                                                                                                <Settings AllowFilterBySearchPanel="False" />
                                                                                                <DataItemTemplate>
                                                                                                    <dx:ASPxTextBox ID="NoteArticolo_Txt" runat="server" Width="100%"></dx:ASPxTextBox>
                                                                                                </DataItemTemplate>
                                                                                            </dx:GridViewDataTextColumn>
                                                                                            <%--   <dx:GridViewDataColumn VisibleIndex="0">
                                                                                                <DataItemTemplate>
                                                                                                    <dx:ASPxButton ID="AggiungiArticolo_Btn" runat="server"><Image Url="../img/DevExButton/new.png" Height="30px" />
                                                                                                        <ClientSideEvents Click="function(s,e){GrigliaArticoli_Clbk.PerformCallback(e.visibleIndex);}" />
                                                                                                    </dx:ASPxButton>
                                                                                                </DataItemTemplate>
                                                                                            </dx:GridViewDataColumn>--%>
                                                                                            <dx:GridViewCommandColumn ButtonRenderMode="Image" Caption="Inserisci" VisibleIndex="0">
                                                                                                <CustomButtons>
                                                                                                    <dx:GridViewCommandColumnCustomButton ID="InserisciArticolo">
                                                                                                        <Image Url="../img/DevExButton/new.png" Height="30px" />
                                                                                                    </dx:GridViewCommandColumnCustomButton>
                                                                                                </CustomButtons>
                                                                                            </dx:GridViewCommandColumn>
                                                                                        </Columns>
                                                                                        <Settings ShowFilterRow="false" ShowFilterRowMenu="true" ShowFooter="True" />

                                                                                        <SettingsPager PageSize="100" Visible="true">
                                                                                            <PageSizeItemSettings Visible="false"></PageSizeItemSettings>
                                                                                        </SettingsPager>
                                                                                        <SettingsDataSecurity AllowInsert="false" AllowDelete="false" />
                                                                                    </dx:ASPxGridView>
                                                                                </dx:PanelContent>
                                                                            </PanelCollection>
                                                                        </dx:ASPxCallbackPanel>
                                                                        <dx:ASPxCallback ID="GrigliaArticoli_Clbk" ClientInstanceName="GrigliaArticoli_Clbk" runat="server" OnCallback="GrigliaArticoli_Clbk_Callback">
                                                                            <ClientSideEvents EndCallback="function(s,e){
                                                                                
                                                                                grid.Refresh();
                                                                                ArticoliCodArtSrch_Txt.SetText('');
                                                                                ArticoliDescrSrch_Txt.SetText('');
                                                                                }" />
                                                                        </dx:ASPxCallback>

                                                                        <asp:SqlDataSource ID="Articoli_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT * FROM U_ListaArticoliPerOrdini_View WHERE (CodLis = @CodLis) AND (CodArt LIKE @CodArt OR DescrizioneArticolo LIKE @DescrizioneArticolo)">
                                                                            <SelectParameters>
                                                                                <asp:SessionParameter DefaultValue="0" Name="CodLis" SessionField="CodLisSession" />
                                                                                <asp:SessionParameter DefaultValue=" " Name="CodArt" SessionField="CodArtSession" />
                                                                                <asp:SessionParameter DefaultValue=" " Name="DescrizioneArticolo" SessionField="DescrArtSession" />
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </asp:Panel>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        </TabPages>
                                    </dx:ASPxPageControl>

                                    <div class="col-lg-12 col-md-12 col-sm-12 " style="padding-top: 0px; padding-bottom: 0px;">
                                        <br />

                                        <dx:ASPxGridView ID="grid" buttonrendermode="Image" ClientInstanceName="grid" runat="server" Width="100%" DataSourceID="ArticoliOrdine_Dts" EnableRowsCache="False" AutoGenerateColumns="False" KeyFieldName="CodArt" SettingsEditing-BatchEditSettings-EditMode="Cell" OnRowUpdating="grid_RowUpdating" OnRowDeleting="grid_RowDeleting" EnableCallBacks="false" OnHtmlRowCreated="grid_HtmlRowCreated">
                                            <SettingsLoadingPanel Mode="ShowOnStatusBar" />

                                            <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                                            <Columns>
                                                <dx:GridViewDataColumn FieldName="CodArt" Caption="Codice Articolo" ReadOnly="true" VisibleIndex="1">
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn FieldName="Descrizione" Caption="Descrizione Articolo" ReadOnly="true" VisibleIndex="2">
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn FieldName="UM" ReadOnly="true" Caption="UM" VisibleIndex="3">
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn FieldName="U_Confez" ReadOnly="true" Caption="Qta Conf." VisibleIndex="3">
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn FieldName="Sconto" Caption="Sconto" VisibleIndex="5" ReadOnly="true" Settings-AllowSort="False">
                                                    <Settings AllowSort="False" />
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn FieldName="Prezzo" Caption="Prezzo € c/u" VisibleIndex="5" ReadOnly="true">
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataSpinEditColumn FieldName="TotQta" Caption="Tot. Quantità" VisibleIndex="4">
                                                    <PropertiesSpinEdit AllowNull="false" MaxValue="999999999" MinValue="0.1" NumberType="Float" Increment="1">
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                            <RequiredField IsRequired="true" ErrorText="Campo Obbligatorio" />
                                                        </ValidationSettings>
                                                    </PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataColumn FieldName="TotImp" Caption="Tot. Importo  €" VisibleIndex="6" ReadOnly="true">
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataTextColumn FieldName="Note" Caption="Note" VisibleIndex="7" />

                                                <dx:GridViewDataTextColumn FieldName="NRiga" Caption="NRiga" VisibleIndex="8">
                                                    <HeaderStyle CssClass="VisibleColumn" />
                                                    <EditCellStyle CssClass="VisibleColumn" />
                                                    <CellStyle CssClass="VisibleColumn" />
                                                    <FilterCellStyle CssClass="VisibleColumn" />
                                                    <FooterCellStyle CssClass="VisibleColumn" />
                                                    <GroupFooterCellStyle CssClass="VisibleColumn" />
                                                </dx:GridViewDataTextColumn>
                                            </Columns>
                                            <SettingsPager PageSize="9999999">
                                            </SettingsPager>
                                            <Settings ShowFooter="true" />
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem FieldName="TotImp" ShowInColumn="TotImp" SummaryType="Sum" DisplayFormat="Totale: {0:c2}"></dx:ASPxSummaryItem>
                                            </TotalSummary>
                                            <SettingsDataSecurity AllowInsert="False" />
                                            <SettingsPopup>
                                                <EditForm Width="600" />
                                            </SettingsPopup>
                                        </dx:ASPxGridView>



                                        <dx:ASPxCallback ID="CallbackPerPopup_Clbk" ClientInstanceName="CallbackPerPopup_Clbk" runat="server" OnCallback="CallbackPerPopup_Clbk_Callback">
                                            <ClientSideEvents EndCallback="function(s,e){ClientPopupControl.Show(); StoricoInst_Grw.Refresh();}" />
                                        </dx:ASPxCallback>
                                        <script>
                                            var VisibleIndex;
                                            function OpenPop(VisibleIndex) {
                                                grid.GetRowValues(VisibleIndex, 'CodArt', OnGetRowValues);
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

                                                            </Columns>
                                                        </dx:ASPxGridView>
                                                    </div>
                                                </dx:PopupControlContentControl>
                                            </ContentCollection>
                                            <FooterTemplate>
                                                <div style="display: table; margin: 6px 6px 6px auto;">
                                                </div>
                                            </FooterTemplate>
                                        </dx:ASPxPopupControl>

                                        <dx:ASPxPopupControl ID="InviaMailPopup" runat="server"
                                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                                            ShowFooter="True" HeaderText="" ClientInstanceName="InviaMailPopup" Width="900px">
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

                                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Invia" ValidationGroup="EmailClienteValid" AutoPostBack="false" UseSubmitBehavior="false">
                                                        <ClientSideEvents Click="function(s,e){
                                                                if(EmailCliente_Txt.GetIsValid()){
                                                                ASPxCallback1.PerformCallback();
                                                                OnSaveClick();InviaMailPopup.Hide();}
                                                                }" />
                                                    </dx:ASPxButton>
                                                </div>
                                            </FooterTemplate>
                                        </dx:ASPxPopupControl>
                                        <dx:LinqServerModeDataSource ID="StoricoOrdiniPerAgeCli_LINQ" runat="server" OnSelecting="StoricoOrdiniPerAgeCli_LINQ_Selecting" TableName="U_StoricoVenditeArticoloPerAgentePerCliente_VIew" ContextTypeName="U_StoricoVenditeArticoloPerAgentePerCliente_LINQDataContext" />
                                    </div>

                                </div>
                            </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
            <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="ASPxCallback1" OnCallback="ASPxCallback1_Callback">
                <ClientSideEvents EndCallback="function(s,e){EmailCliente_Txt.SetText('');}" />
            </dx:ASPxCallback>
            <asp:SqlDataSource ID="ArticoliOrdine_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT OrdCliDett.CodArt, OrdCliDett.U_Confez_Intra AS U_Confez, Articoli.Descrizione, OrdCliDett.Prezzo, OrdCliDett.Sconto, OrdCliDett.QtaOrd AS TotQta, OrdCliDett.NRiga, OrdCliDett.Importo AS TotImp, OrdCliDett.UM, OrdCliDett.Note FROM Articoli RIGHT OUTER JOIN OrdCliDett ON Articoli.CodArt = OrdCliDett.CodArt LEFT OUTER JOIN OrdCliTest ON OrdCliDett.ID = OrdCliTest.ID WHERE (OrdCliDett.IDTestata = @ID) ORDER BY OrdCliDett.NRiga" UpdateCommand="UPDATE OrdCliDett SET U_Posizione = U_Posizione WHERE (1 = 2)">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="0" Name="ID" QueryStringField="NOrd" />
                </SelectParameters>
            </asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="CondizioniPagamento_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand=" SELECT  TabPag.CodCPag As CodCPag, TabPag.Descrizione As Descrizione FROM TabPag INNER JOIN CliFatt1 ON TabPag.CodCPag = CliFatt1.CodPag WHERE(CliFatt1.CodCli = @CodCli)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="CodCli" SessionField="CodCliDataSource" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DetCli_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT Clienti.Denom, Clienti.U_Trasporto, Clienti.Ind, Clienti.Cap, Clienti.Prov, Clienti.Loc, Clienti.Tel, Clienti.PIva, Clienti.CF, Clienti.DsNaz, Clienti.EMail, CliFatt3.CodLis, CliFatt3.CodAge, CASE WHEN CliFatt1.Sconto1 IS NULL THEN 0 ELSE CliFatt1.Sconto1 END AS ScontoIncondizionatoOLD, TabPag.PercScPag AS ScontoIncondizionato, TabPag.SpeBan FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN OrdCliTest ON Clienti.CodCli = OrdCliTest.CodCli INNER JOIN CliFatt1 ON Clienti.CodCli = CliFatt1.CodCli LEFT OUTER JOIN TabPag ON CliFatt1.CodPag = TabPag.CodCPag WHERE (OrdCliTest.ID = @IdOrd)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdOrd" QueryStringField="NOrd" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
