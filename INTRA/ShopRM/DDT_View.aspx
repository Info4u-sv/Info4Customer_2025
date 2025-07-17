<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="DDT_View.aspx.cs" Inherits="INTRA.ShopRM.DDT_View" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
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

                @media (max-width: 768px) {
                    .dxgv {
                        font-size: 12px;
                    }

                    .dxgvTable td, .dxgvTable th {
                        padding: 4px !important;
                    }

                    .card {
                        margin: 0 5px;
                    }
                }

                @media (max-width: 768px) {
                    .dxgvTable {
                        font-size: 12px;
                    }
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

            <div class="row">
                <div class="col-xs-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="card-content">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <h4 class="card-title">
                                        <asp:Label ID="TitoloPagina_Lbl" runat="server"></asp:Label>
                                    </h4>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <br />
                            <%--<div style="overflow-x:auto; -webkit-overflow-scrolling: touch;">--%>
                            <dx:ASPxGridView ID="grid" buttonrendermode="Image" EnableAdaptivity="true" ClientInstanceName="grid" runat="server" Width="100%" DataSourceID="ArticoliOrdine_Dts" EnableRowsCache="False" AutoGenerateColumns="False" KeyFieldName="ID">
                                <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                                <Styles AlternatingRow-Enabled="True"></Styles>
                                <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true">
                                    <AdaptiveDetailLayoutProperties ColCount="1" />
                                </SettingsAdaptivity>
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="CodArt" Caption="Codice" VisibleIndex="0" Width="150px" />
                                    <dx:GridViewDataTextColumn FieldName="NomeArticolo" Caption="Descrizione Articolo" VisibleIndex="1" />
                                    <dx:GridViewDataTextColumn FieldName="Um" Caption="UM" VisibleIndex="2" />
                                    <dx:GridViewDataTextColumn FieldName="Qta" Caption="Quantità" VisibleIndex="3" Width="80px" />
                                    <dx:GridViewDataTextColumn FieldName="ImpUni" Caption="Prezzo € c/u" VisibleIndex="4" Width="100px" />
                                    <dx:GridViewDataTextColumn FieldName="Sconto1" Caption="Sconto 1" VisibleIndex="5" />
                                    <dx:GridViewDataTextColumn FieldName="Sconto2" Caption="Sconto 2" VisibleIndex="6" />
                                    <dx:GridViewDataTextColumn FieldName="IVA" Caption="IVA" VisibleIndex="7" />
                                    <dx:GridViewDataTextColumn FieldName="ValoreMov" Caption="Tot. importo €" VisibleIndex="8" />
                                </Columns>
                                <SettingsPager PageSize="9999999">
                                </SettingsPager>
                                <Settings ShowFooter="true" />
                                <TotalSummary>
                                    <dx:ASPxSummaryItem FieldName="ValoreMov" ShowInColumn="ValoreMov" SummaryType="Sum" DisplayFormat="Totale: {0:c2}"></dx:ASPxSummaryItem>
                                </TotalSummary>
                                <SettingsDataSecurity AllowInsert="False" AllowEdit="False" AllowDelete="False" />
                                <SettingsPopup>
                                    <EditForm Width="600" />
                                </SettingsPopup>
                                <SettingsSearchPanel CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>

                            </dx:ASPxGridView>
                            <%--</div>--%>
                        </div>

                    </div>
                </div>

            </div>
            <asp:SqlDataSource ID="ArticoliOrdine_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:GestionaleConnectionString %>" SelectCommand="SELECT CodArt, Um, Qta, ImpUni, ValoreMov, Sconto1, Sconto2,NomeArticolo,IVA FROM U_DettaglioBolla WHERE (IDTest = @IdTest)" UpdateCommand="UPDATE OrdCliDett SET U_Posizione = U_Posizione WHERE (1 = 2)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="IdTest" QueryStringField="IdTestata" />
                </SelectParameters>
            </asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
