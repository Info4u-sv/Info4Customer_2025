<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Lista_DDT.aspx.cs" Inherits="INTRA.ShopRM.Lista_DDT" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <style>
        .article-container {
            margin-bottom: 5px;
        }

        .detail-info-entry-title {
            font-size: 16px;
            color: #a00025;
        }

        .product-detail-box .product-title {
            color: #a00025;
        }

        .detail-info-entry {
            margin-bottom: 5px !important;
        }

        .dxflGroupBoxCaption_Office365 {
            font-size: 30px;
            top: -20px;
            padding: 0;
        }
    </style>


    <script src="swipebox-master/lib/jquery-3.5.1.min.js"></script>
    <script src="swipebox-master/src/js/jquery.swipebox.js"></script>
    <link href="swipebox-master/src/css/swipebox.css" rel="stylesheet" />
    <script type="text/javascript">
            ; (function ($) {

                $('.swipebox').swipebox();

            })(jQuery);
    </script>
    <style>
        .box a img {
            -webkit-back-visibility: hidden;
            display: block;
            width: 100%;
            height: auto;
            vertical-align: bottom;
        }

        .box:nth-child(2n + 1) {
            clear: both;
            margin-left: 0;
        }

        .box {
            list-style-type: none;
            float: left;
            margin-bottom: 1rem;
            margin-left: 1%;
            margin-right: 1%;
            width: 48%;
        }

        .box_top {
            width: 90%;
        }

        .btn > img {
            width: 35px;
        }
    </style>


    <script type="text/javascript">
        function OnControlsInitialized() {
            if (window.location.hash)
                OnImageClick(window.location.hash.substring(1));

            ASPxClientUtils.AttachEventToElement(window, "keydown", KeyHandler);
            ASPxClientUtils.AttachEventToElement(window, "resize", UpdatePopupPosition);
        }

        function OnCustomButtonClick(s, e) {
            switch (e.buttonID) {
                case "Dettaglio":
                    s.GetRowValues(e.visibleIndex, 'ID', GotoNewPage);
                    break;
            }
        }

        function GotoNewPage(values) {
            window.location.href = "/ShopRM/DDT_View.aspx?IdTestata=" + values;
        }

        function OnImageClick(DataSource) {

            // window.location.hash = name;
            CaricaSliderZoom_CallbackPnl.PerformCallback(DataSource);
            popupzoom.Show();

        }
        function EndCallback_PanelZoom(s, e) {
            window.setTimeout(function () { UpdatePopupPosition(); }, 0);
            imageSliderZoom.SetActiveItem(imageSliderItem, true);
            UpdateText();
        }

        function OnActiveItemChanged(s, e) {
            //alert('sono qui');
            //window.location.hash = e.item.name;
            UpdateText();
        }
        function OnPopupCloseUp() {
            if (history.pushState)
                history.pushState("", "", location.pathname + location.search);
            else
                location.hash = "";
        }
        function OnPopupUp() {
            imageSlider.Focus();
        }
        function KeyHandler(e) {
            if (e.keyCode == ASPxClientUtils.StringToShortcutCode("ESC"))
                popupzoom.Hide();
            if (e.keyCode == ASPxClientUtils.StringToShortcutCode("SPACE"))
                imageSlider.SetActiveItemIndex(imageSlider.GetActiveItemIndex() + 1);
            return true;
        }
        function UpdateText() {
            document.getElementById("itemText").innerHTML = (imageSliderZoom.GetActiveItemIndex() + 1) + " / " + imageSlider.GetItemCount();
        }
        function UpdatePopupPosition() {
            if (popupzoom.IsVisible())
                popupzoom.UpdatePosition();
        }
        function onSliderInit(s, e) {
            var id = s.GetMainElement().id;
            var slidePanel = $("#" + id + " .dxis-nbSlidePanel");
            var panelWrapper = $("#" + id + " .dxis-nbSlidePanelWrapper");
            if (slidePanel.width() <= panelWrapper.width())
                slidePanel.addClass("slidePanelLeftAlign");
        }
    </script>




    <div class="information-blocks">

        <div class="content-push">

            <div class="content-push">
                <dx:ASPxFormLayout runat="server" ID="Grid_Container" ColumnCount="1" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="Le mie bolle" ColumnCount="1" ColumnSpan="1">
                            <Items>
                                <dx:LayoutItem ShowCaption="False" ColumnSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxGridView ID="Lista_DDT_grw" ClientInstanceName="Lista_DDT_grw" ButtonRenderMode="Image" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="DDT_dts" KeyFieldName="ID">
                                                <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                </SettingsAdaptivity>
                                                <Settings ShowFilterRow="True" GridLines="Both" ShowFilterRowMenu="True" ShowHeaderFilterButton="false" />
                                                <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                                <SettingsBehavior AllowSelectSingleRowOnly="true" AutoFilterRowInputDelay="999999999" />
                                                <Settings AutoFilterCondition="Contains" />
                                                <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                <SettingsCommandButton>
                                                    <ClearFilterButton>
                                                        <Image ToolTip="Svuota Ricerche" Url="../img/DevExButton/clear.png" Width="30px"></Image>
                                                    </ClearFilterButton>
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
                                                        <Image ToolTip="Modifica" Height="30px" Url="../img/DevExButton/search.png"></Image>
                                                    </EditButton>

                                                    <DeleteButton ButtonType="Image" RenderMode="Image">
                                                        <Image ToolTip="Elimina" Height="30px" Url="../img/DevExButton/delete.png"></Image>
                                                    </DeleteButton>
                                                </SettingsCommandButton>
                                                <Styles AlternatingRow-Enabled="True"></Styles>
                                                <Toolbars>
                                                    <dx:GridViewToolbar>
                                                        <Items>
                                                            <dx:GridViewToolbarItem Alignment="left">
                                                                <Template>
                                                                    <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%">
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
                                                <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                                                <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                                                <Columns>
                                                    <%--<dx:GridViewCommandColumn ButtonRenderMode="Image" VisibleIndex="0" ShowClearFilterButton="True">
                                                        <CustomButtons>
                                                            <dx:BootstrapGridViewCommandColumnCustomButton ID="Dettaglio" Text="Apri dettaglio" Image-Url="~/img/DevExButton/search.png" CssClass="btn btn-sm btn-custom-padding action-btn"></dx:BootstrapGridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dx:GridViewCommandColumn>--%>
                                                    <dx:GridViewDataColumn VisibleIndex="0" HeaderStyle-Wrap="True" AdaptivePriority="1" Width="40px" SettingsHeaderFilter-DateRangeCalendarSettings-ShowClearButton="true">
                                                        <DataItemTemplate>
                                                            <div>
                                                                <a href='/ShopRM/DDT_View.aspx?IdTestata=<%# Eval("ID") %>' class="btn btn-primary btn-sm" role="button" style="padding: 5px 8px;">
                                                                    <i class="bi bi-arrow-right" style="color: white!important"></i>
                                                                </a>
                                                            </div>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataTextColumn FieldName="NumDoc" VisibleIndex="2" Caption="Numero Doc">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataDateColumn FieldName="DataDoc" VisibleIndex="3" Caption="Data Doc">
                                                    </dx:GridViewDataDateColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Agente" VisibleIndex="6" Visible="false" Caption="Agente">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="TotMerce" VisibleIndex="7" Caption="Totale merce">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="TotSpese" VisibleIndex="7" Visible="false" Caption="Totale spese">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="ID Ordine" FieldName="ID" VisibleIndex="1" Visible="false">
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridView>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>


                <asp:SqlDataSource ID="DDT_dts" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT BolleTest.ID, BolleTest.Tipo, BolleTest.Anno, BolleTest.NumDoc, BolleTest.DataDoc, BolleTest.IDMovMag, BolleTest.Cliente, BolleTest.DivDest, BolleTest.CodVal, BolleTest.Cambio, BolleTest.CambioBil, BolleTest.AssIva, BolleTest.CondPag, BolleTest.Agente, BolleTest.Provvig, BolleTest.Sconto, BolleTest.TotMerce, BolleTest.TotSpese, BolleTest.TotSconti, BolleTest.TotIva, BolleTest.TotDocum, BolleTest.Anticipo, BolleTest.FlagStampa, BolleTest.FlagCont, BolleTest.Note, BolleTest.CodLis, BolleTest.Sconto1, BolleTest.CodSpe1, BolleTest.CodAsp, BolleTest.CodPor, BolleTest.Colli, BolleTest.Peso, BolleTest.DataTrasp, BolleTest.OraTrasp, BolleTest.CodSpe2, BolleTest.CodDoc, BolleTest.StCC, BolleTest.Agente2, BolleTest.Provvig2, BolleTest.Agente3, BolleTest.Provvig3, BolleTest.Agente4, BolleTest.Provvig4, BolleTest.BollaOrig, BolleTest.ScorpIVA, BolleTest.CodCliRB, BolleTest.TotMerce2Val, BolleTest.TotSpese2Val, BolleTest.TotSconti2Val, BolleTest.TotIva2Val, BolleTest.TotDocum2Val, BolleTest.TotAnticipo2Val, BolleTest.TotDocumValBil, BolleTest.TotLordo, BolleTest.TotLordo2Val, BolleTest.Sospeso, BolleTest.TotMerceBil, BolleTest.TotSpeseBil, BolleTest.TotScontiBil, BolleTest.TotIvaBil, BolleTest.TotAnticipoBil, BolleTest.TotLordoBil, BolleTest.ASaldo, BolleTest.TotCompensi, BolleTest.TotSa, BolleTest.RivalsaContr, BolleTest.ImpIva, BolleTest.Iva, BolleTest.ImpRitenute, BolleTest.Ritenuta, BolleTest.TotDaVers, BolleTest.ImportoNetto, BolleTest.StPL, BolleTest.Importo, BolleTest.CodBan, BolleTest.BanCli, BolleTest.CodPra, BolleTest.Commessa, BolleTest.ProgCommessa, BolleTest.CentroCosto, BolleTest.Ricarico, BolleTest.TotImpRivalsa, BolleTest.TotImpRivalsaVal, BolleTest.NewPrezziConIVA, BolleTest.FlagRiten, BolleTest.CodiceRA, BolleTest.ImponRitCond, BolleTest.NonImponRitCond, BolleTest.ImportoRitCond, BolleTest.DataCreaz, BolleTest.IdUteCreaz, BolleTest.DataUltMod, BolleTest.IdUteUltMod, BolleTest.Codamm, BolleTest.InviatoEMail, BolleTest.IDMailStorico, BolleTest.NotePiede, BolleTest.DataBollaOrig, BolleTest.DataIncContr, BolleTest.RifIncContr, BolleTest.TipoArt62, BolleTest.CUP, BolleTest.CIG, BolleTest.CodMez, BolleTest.flgCtrlTerm, BolleTest.r_InsertID, BolleTest.r_InsertGroup, BolleTest.U_DescPAg, BolleTest.U_NoTrasporto, BolleTest.U_TrasportoAgente, BolleTest.U_TipoPag, BolleTest.U_AggTrasp, BolleTest.U_PA_Ordine, BolleTest.U_PA_CIG, BolleTest.U_PA_CUP, BolleTest.U_PA_Ord_data, U_I_OrdCliTest.U_Utente_Insert FROM BolleTest LEFT OUTER JOIN U_I_OrdCliTest ON BolleTest.NumDoc = U_I_OrdCliTest.U_NumBollaCliente OR BolleTest.NumDoc = U_I_OrdCliTest.U_NumBolla WHERE (BolleTest.Cliente = @CodCli) AND (U_I_OrdCliTest.U_Utente_Insert = @UtenteInsert) ORDER BY BolleTest.Anno DESC, BolleTest.ID DESC">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="CodCli_Session" Name="CodCli" Type="String"></asp:SessionParameter>
                        <asp:SessionParameter SessionField="UtenteInsert_Session" Name="UtenteInsert"></asp:SessionParameter>

                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
