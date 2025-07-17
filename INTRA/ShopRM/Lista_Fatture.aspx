<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Lista_Fatture.aspx.cs" Inherits="INTRA.ShopRM.Lista_Fatture" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            window.location.href = "/ShopRM/Fatture_View.aspx?IdTestata=" + values;
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
                        <dx:LayoutGroup Caption="Le mie fatture" ColumnCount="1" ColumnSpan="1">
                            <Items>
                                <dx:LayoutItem ShowCaption="False" ColumnSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxGridView ID="Lista_Fatture_grw" ClientInstanceName="Lista_Fatture_grw" ButtonRenderMode="Image" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="Fatture_dts" KeyFieldName="ID">
                                                <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                </SettingsAdaptivity>
                                                <Settings ShowFilterRow="True" GridLines="Both" ShowFilterRowMenu="True" ShowHeaderFilterButton="false" />
                                                <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                                <SettingsBehavior AllowSelectSingleRowOnly="true" AutoFilterRowInputDelay="999999999" />
                                                <Settings AutoFilterCondition="Contains" />
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
                                                    <dx:GridViewCommandColumn ButtonRenderMode="Image" VisibleIndex="0" ShowClearFilterButton="True">
                                                        <CustomButtons>
                                                            <dx:BootstrapGridViewCommandColumnCustomButton ID="Dettaglio" Text="Apri dettaglio" Image-Url="~/img/DevExButton/search.png" CssClass="btn btn-sm btn-custom-padding action-btn"></dx:BootstrapGridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dx:GridViewCommandColumn>
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


                <asp:SqlDataSource ID="Fatture_dts" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT ID, Tipo, Anno, NumDoc, DataDoc, IDMovCont, IDMovMag, Cliente, DivDest, CodVal, Cambio, CambioBil, AssIva, CondPag, Agente, Provvig, Sconto, TotMerce, TotSpese, TotSconti, TotIva, TotDocum, Anticipo, FlagStampa, Note, CodLis, Sconto1, CodSpe1, CodAsp, CodPor, Colli, Peso, DataTrasp, OraTrasp, CodSpe2, AntDaParFissa, CodDoc, FlagCont, Agente2, Provvig2, Agente3, Provvig3, Agente4, Provvig4, ScorpIVA, CodCliRB, PartitaFattura, TotMerce2Val, TotSpese2Val, TotSconti2Val, TotIva2Val, TotDocum2Val, TotAnticipo2Val, TotDocumValBil, TotLordo, TotLordo2Val, DataCompA, DataCompDa, TipoComp, ImportoRimDir, DataRimDir, TotMerceBil, TotSpeseBil, TotScontiBil, TotIvaBil, TotAnticipoBil, TotLordoBil, ASaldo, NumPrev, ImportoNetto, TotCompensi, TotSa, RivalsaContr, ImpIva, Iva, ImpRitenute, Ritenuta, TotDaVers, CodBan, BanCli, CodPra, Importo, TotImpRivalsa, TotImpRivalsaVal, NewPrezziConIVA, CentroCosto, Commessa, FlagRiten, CodiceRA, ImponRitCond, NonImponRitCond, ImportoRitCond, CodAmm, Contratto, DataCreaz, IdUteCreaz, DataUltMod, IdUteUltMod, InviatoEMail, IDMailStorico, NotePiede, CodDestDoc, CodAgenzia, CodCentroMedia, Cup, Cig, PubblicatoWEB, IDNotaCredMag, TipoArt62, PA_FileTrasf, flgSplitPaymentPA, TS_EscludiDoc, r_InsertID, r_InsertGroup, U_Porto, U_TotDocAnticipo, U_Spesebanc_OK, RivalsaINPSPerc, RivalsaINPSVal, RivalsaContVal, RivalsaContPerc, CassaTratDescr, CassaTratVal, FLGINVCEDENTE, FLGNOCONTAB, ScontoMaggiorazione, CassaTratPerc, FLAGXMLSEMPL, CausaleNc, TS_PagTrac, NumDocPers, DataDocPers FROM FattTest WHERE (Cliente = @CodCli) ORDER BY Anno DESC">
                    <SelectParameters>
                        <asp:Parameter Name="CodCli" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
