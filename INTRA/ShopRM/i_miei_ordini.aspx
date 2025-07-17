<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="i_miei_ordini.aspx.cs" Inherits="INTRA.ShopRM.i_miei_ordini" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>
<%--<%@ Register Assembly="DevExpress.Web.v22.1, Version=22.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>--%>

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

        .DecorationLblGrid-new {
            border-radius: 7px;
            padding: 4px;
            color: White !important;
            text-transform: uppercase;
            font-size: small !important;
            font-weight: bolder !important;
            line-height: 20px;
        }

        @media (max-width: 768px) {
            .dxeBase_Office365 {
                display: contents !important;
            }
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
    </style>


    <script type="text/javascript">
        function OnControlsInitialized() {
            if (window.location.hash)
                OnImageClick(window.location.hash.substring(1));

            ASPxClientUtils.AttachEventToElement(window, "keydown", KeyHandler);
            ASPxClientUtils.AttachEventToElement(window, "resize", UpdatePopupPosition);
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

                <dx:ASPxFormLayout runat="server" ID="Grid_container" ColumnCount="1" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="I miei Ordini" ColumnCount="1" ColumnSpan="1">
                            <Items>
                                <dx:LayoutItem ShowCaption="False" ColumnSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxGridView ID="ListaOrdini_Grw" ClientInstanceName="ListaOrdini_Grw" ButtonRenderMode="Image" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="Ordini_Dts" KeyFieldName="ID">
                                                <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>
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

                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="OrdNum" VisibleIndex="0">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataDateColumn FieldName="OrdDat" VisibleIndex="1" Width="100px">
                                                    </dx:GridViewDataDateColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2" Caption="Status">
                                                        <DataItemTemplate>
                                                            <span class="DecorationLblGrid-new" style='background-color: <%# Convert.ToInt32(Eval("FlagEvaso")) == 1 ? "darkred" : Convert.ToInt32(Eval("FlagEvaso")) == 2 ? "orangered" : "forestgreen" %>'>
                                                                <dx:ASPxLabel runat="server" Width="95%" ForeColor="White" Text='<%# Eval("Descrizione") %>'></dx:ASPxLabel>
                                                            </span>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                    <%--                                    <dx:GridViewDataImageColumn FieldName="Url" Caption="Stato" PropertiesImage-ImageWidth="30px"></dx:GridViewDataImageColumn>--%>
                                                    <dx:GridViewDataTextColumn FieldName="TotQta" VisibleIndex="3" Width="100px">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="TotImp" VisibleIndex="4" Width="100px">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Agente" VisibleIndex="5"></dx:GridViewDataTextColumn>

                                                    <%--<dx:GridViewDataSpinEditColumn Caption="ID Ordine" FieldName="ID" VisibleIndex="1" Visible="false">
                                                        <PropertiesSpinEdit DisplayFormatString="g">
                                                        </PropertiesSpinEdit>
                                                    </dx:GridViewDataSpinEditColumn>--%>
                                                </Columns>
                                                <Templates>
                                                    <DetailRow>
                                                        <dx:ASPxGridView runat="server" ID="Dettaglio_Ordine_Grw" ClientInstanceName="Dettaglio_Ordine_Grw" Width="100%" OnBeforePerformDataSelect="Dettaglio_Ordine_Grw_BeforePerformDataSelect" AutoGenerateColumns="False" DataSourceID="Dettaglio_Dts">
                                                            <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                            <Styles AlternatingRow-Enabled="True"></Styles>
                                                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                            </SettingsAdaptivity>
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="QtaOrd" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="QtaEva" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Importo" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="IDTestata" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn>
                                                            </Columns>
                                                        </dx:ASPxGridView>
                                                    </DetailRow>
                                                </Templates>
                                                <SettingsDetail ShowDetailRow="true" />
                                            </dx:ASPxGridView>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>

            </div>

        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Ordini_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_I_OrdCliTest.OrdNum, U_I_OrdCliTest.OrdDat, U_I_OrdCliTest.FlagEvaso, U_I_OrdCliTest.TotQta, U_I_OrdCliTest.TotImp, U_I_OrdCliTest.Agente, U_AnagraficaStatusOrdine.Descrizione, U_I_OrdCliTest.ID FROM U_I_OrdCliTest INNER JOIN U_AnagraficaStatusOrdine ON U_I_OrdCliTest.FlagEvaso = U_AnagraficaStatusOrdine.IDStatus WHERE (U_I_OrdCliTest.U_Utente_Insert = @User ) ORDER BY U_I_OrdCliTest.OrdNum DESC">
        <SelectParameters>
            <asp:SessionParameter SessionField="User_Session" Name="User"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Dettaglio_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodArt, QtaOrd, QtaEva, Importo, IDTestata FROM U_I_OrdCliDett WHERE (IDTestata = @IdTestata)">
        <SelectParameters>
            <asp:SessionParameter SessionField="IdOrdine_Session" Name="IdTestata"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <%--    <dx:LinqServerModeDataSource ID="ListaOrdini_LinqDts" runat="server" ContextTypeName="ListaOrdini_LINQDataContext" TableName="View_LINQDataSourceOrdini" OnSelecting="ListaOrdini_LinqDts_Selecting" />--%>
</asp:Content>
