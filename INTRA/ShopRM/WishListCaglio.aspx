<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="WishListCaglio.aspx.cs" Inherits="INTRA.ShopRM.WishListCaglio" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>


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
    <style>
        .list-view .product-slide-entry .product-image {
            max-width: 150px;
            margin-left: 0px;
            float: left;
            margin-bottom: 0;
        }

        .list-view .product-slide-entry {
            max-width: 100%;
            margin-left: 0px;
            padding-bottom: 45px;
            margin-bottom: 44px;
            text-align: left !important;
        }

        .btn-secondary {
            font-weight: 700 !important;
            color: #fff;
            background: #43b4e4;
            border-color: #43b4e4;
        }

        .list-view .product-slide-entry .title {
            font-size: 14px;
        }
    </style>
    <%-- <script type="text/javascript">
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
    </script>--%>
    <script>
        function DettaglioProd_PopupShow(ProductCod) {
            var _ProductCodLabel = eval(ProductCod + '_ProductCodLabel');
            POP_ProductCodLabel.SetText(_ProductCodLabel.GetText())
            var _DisplayNameLabel = eval(ProductCod + '_DisplayNameLabel');
            POP_DisplayNameLabel.SetText(_DisplayNameLabel.GetText())
            DettaglioProd_Popup.Show();
        }
    </script>
    <dx:ASPxPopupControl runat="server" ID="DettaglioProd_Popup" AutoUpdatePosition="true" Modal="true" Width="1100px" ClientInstanceName="DettaglioProd_Popup" CloseAction="CloseButton" CloseOnEscape="false" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" HeaderText="Dettaglio del prodotto">
        <ContentCollection>
            <dx:PopupControlContentControl>
                <dx:ASPxLabel runat="server" ID="POP_ProductCodLabel" ClientInstanceName="POP_ProductCodLabel" Font-Size="XX-Large"></dx:ASPxLabel>
                <dx:ASPxLabel runat="server" ID="POP_DisplayNameLabel" ClientInstanceName="POP_DisplayNameLabel" Font-Size="XX-Large"></dx:ASPxLabel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <div class="row">
        <div class="col-md-3 sidebar-column">
            <Banner:PlusLeftMenuCatalogo runat="server" ID="PlusLeftMenuCatalogo" />
        </div>
        <div class="col-sm-9 information-entry">


            <div class=" shop-grid list-view">
                <%-- <a href='ReportViewer.aspx'>
                    <div class="button style-10" style="padding-bottom: 10px !important" role="presentation">
                        ANTEPRIMA REPORT
                    </div>
                </a>--%>
                <dx:ASPxCardView ID="ShopList1" ClientInstanceName="shopList1" runat="server" Width="100%" KeyFieldName="ProductCod" AutoGenerateColumns="False" DataSourceID="ArticoliinWishlist_Sdt">
                    <Columns>
                        <dx:CardViewColumn FieldName="Price" />
                        <dx:CardViewColumn FieldName="ProductCod" />
                        <dx:CardViewColumn FieldName="PromoPrice" />
                    </Columns>
                    <Settings VerticalScrollableHeight="600" />
                    <SettingsPager EndlessPagingMode="OnScroll" Mode="EndlessPaging">

                        <SettingsTableLayout ColumnCount="1" RowsPerPage="8" />
                    </SettingsPager>
                    <Templates>
                        <Card>
                            <div class="col-md-3 col-sm-3 shop-grid-item">
                                <div class="product-slide-entry">
                                    <div class="col-lg-2 col-md-12 col-sm-12">
                                        <div class="product-image">
                                            <img src='<%# Page.ResolveUrl(Eval("PictureUrl").ToString()) %>' alt="" onerror="this.src='noimage.jpg'" />
                                        </div>
                                        <div class="clear"></div>
                                    </div>

                                    <div class="col-lg-7 col-sm-12">
                                        <a class="title" href='prodotto.aspx?cod=<%# Eval("ProductCod") %>'>
                                            <dx:ASPxLabel ID="DisplayNameLabel" ClientInstanceName='<%# Eval("ProductCod")+ "_DisplayNameLabel" %>' runat="server" Text='<%# Eval("DisplayName") %>' />
                                            - <%# Eval("ShortDescription") %></a>
                                        <a class="btn btn-xs btn-secondary pull-right" href="#"><i class="fa fa-question-circle"></i>INFO</a>
                                        <a href='prodotto.aspx?cod=<%# Eval("ProductCod") %>' class="tag">
                                            <dx:ASPxLabel ID="ProductCodLabel" ClientInstanceName='<%# Eval("ProductCod")+ "_ProductCodLabel" %>' runat="server" Text='<%# Eval("ProductCod") %>' />
                                        </a>
                                        <div class="article-container style-1">
                                            <p>

                                                <%# Eval("FullDescription") %>
                                                <%-- <%# Eval("AttributesList") %>--%>
                                                <a class="btn btn-xs btn-secondary pull-right" href="javascript: DettaglioProd_PopupShow('<%# Eval("ProductCod") %>'); "><i class="fa fa-question-circle"></i> INFO</a>
                                            </p>
                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="col-lg-3 col-sm-12">
                                        <div class="row">
                                            <div class="col-lg-12 col-sm-6">
                                                <h4 class="cart-column-title" runat="server" visible='<%#String.IsNullOrEmpty(Eval("PromoPrice").ToString()) || Eval("PromoPrice").ToString() == "0" ? true : false %>'>
                                                    <div class="price">

                                                        <div class="current">
                                                            €
                                        <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price", "{0:F2}") %>' />
                                                            <div class="clear"></div>
                                                            <%--                                                    <div style="padding-top: 10px">
                                                        <div class="descrprice" style="letter-spacing: normal">PREZZO UNITARIO (IVA COMPRESA)</div>
                                                    </div>--%>
                                                        </div>
                                                    </div>
                                                </h4>
                                                <asp:Panel ID="PromoPanel" runat="server" Visible='<%#String.IsNullOrEmpty(Eval("PromoPrice").ToString()) || Eval("PromoPrice").ToString() == "0" ? false : true %>'>
                                                    <div class="price">
                                                        <h3 class="cart-column-title" style="letter-spacing: normal">
                                                            <div class="current" style="color: #a00025 !important">
                                                                €
                                                    <asp:Label ID="PromoPriceLabel" runat="server" Text='<%# Eval("PromoPrice", "{0:F2}") %>' />
                                                            </div>
                                                            <div class="prev">
                                                                €
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Price", "{0:F2}") %>' />
                                                            </div>
                                                            <div class="clear"></div>
                                                            <div style="padding-top: 10px">
                                                                <%--                                                        <span class="inline-label red">in offerta fino al <%# Eval("PromoStopDate", "{0:dd/M/yyyy}")%></span><br />--%>
                                                                <span class="inline-label red">In Promo</span>
                                                            </div>
                                                        </h3>
                                                    </div>
                                                </asp:Panel>
                                                <div class="clear"></div>
                                            </div>
                                            <div class="col-lg-12 col-sm-6">
                                                <div class="list-buttons" style="display: block !important">
                                                    <div class="input-group pull-left mbottom-5">
                                                        <span class="input-group-addon ng-binding">PZ</span>
                                                        <input type="number" id="qta_DS4608SR7U2100" class="form-control ng-pristine ng-untouched ng-valid ng-not-empty" ng-model="Quantita">
                                                        <div class="input-group-btn">
                                                            <button class="btn btn-secondary" id="addCart_DS4608SR7U2100" ng-click="aggiungiAlCarrello((product.sku | fixBackSlash), product.getCartMinQty(userData.ccCode), product.getCartMaxQty(userData.ccCode), product.getCartMultiplier(), Quantita,'False', (product.completePrice.hasProgramSP() ? product.completePrice.tipoProgramma : ''),(product.completePrice.hasProgramSP() ? product.completePrice.idProgramma : ''), product.getDepositoCart(userData),'True', $event)" title="Aggiungi l'articolo DS4608-SR7U2100 al carrello DS4608-SR 2D KIT CON CAVO USB">
                                                                <i class="fa fa-shopping-cart"></i>
                                                                <!-- ngIf: ShowStar -->
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <%--  <a href='javascript:AggiungiAlCarrello_Callback.PerformCallback(<%# Container.VisibleIndex %>);'>
                                                    <div class=" search-button" style="padding-bottom: 10px !important; margin-left: 5px;">
                                                        <i class="fa fa-heart"></i>
                                                    </div>
                                                </a>--%>


                                                    <%--                                                <asp:LinkButton ID="ScopriDiPiu_LinkBt" runat="server" CommandName="SelectProduct" Visible="false">
                                   
                                    <div class="button style-10" style="padding-bottom: 10px !important" role="presentation">
                                    Scopri di più ></div>
                                                </asp:LinkButton>
                                                <a href='prodotto.aspx?cod=<%# Eval("ProductCod") %>'>
                                                    <div class="button style-10" style="padding-bottom: 10px !important" role="presentation">
                                                        Scopri di più >
                                                    </div>
                                                </a>--%>
                                                </div>
                                                <div class="clear"></div>
                                            </div>
                                            <div class="clear"></div>
                                        </div>
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
                <asp:SqlDataSource runat="server" ID="ArticoliinWishlist_Sdt" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ProductID, CategoryID, ProductCod, DisplayName, NameRW, ShortDescription, FullDescription, BrandId, units, quantity, Price, AttributesList, PromoId, Published, ParentCategoryID, PictureUrl, Sezione, Principale, StartDate AS PromoStartDate, StopDate AS PromoStopDate, PromoPrice, Deleted, PathImmagine, Tags FROM SHP_AllProductWithPromo WHERE 1 = 2"></asp:SqlDataSource>
            </div>


        </div>



    </div>


</asp:Content>
