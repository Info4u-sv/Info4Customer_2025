<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="WishListMiele.aspx.cs" Inherits="INTRA.ShopRM.WishListMiele" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <script src="/assets/js/jquery-3.2.1.min.js"></script>
    <link href="/content/toastr.css" rel="stylesheet" />
    <script src="/assets/js/toastr/toastr.js"></script>

    <script>
        //function showNotification() {
        //    toastr.options.positionClass = "toast-top-right";
        //    options = {
        //        tapToDismiss: true,
        //        toastClass: 'toast',
        //        containerId: 'toast-container',
        //        debug: false,
        //        fadeIn: 300,
        //        fadeOut: 1000,
        //        extendedTimeOut: 1000,
        //        iconClass: 'toast-info',
        //        positionClass: 'toast-top-right',
        //        timeOut: 5000, // Set timeOut to 0 to make it sticky
        //        titleClass: 'toast-title',
        //        messageClass: 'toast-message'
        //    }
        //    toastr.options.positionClass = "toast-top-right";
        //    toastr.options.timeOut = 1500;
        //    toastr.success("Operazione eseguita con successo!", "Operazione eseguita");

        //}

    </script>
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
    <div class="content-push">
        <div class=" shop-grid list-view" style="min-height: 600px;">
            <div class="list-buttons" style="display: block !important">
                <div class="col-lg-6">
                    <a href='VisualizzaPDF.aspx' class="button style-12" style="margin-right:0px; margin-bottom:10px" target="_blank" onclick="window.open(this.href, 'windowName', 'width=1000, height=700, left=24, top=24, scrollbars, resizable'); return false;">
                        <i class="fa fa-download" style="font-size: 23px;"></i>ANTEPRIMA REPORT
                    </a>
                </div>
                <div class="col-lg-6" style="text-align:right">
                    <a href='javascript:SvuotaWishList_CallB.PerformCallback();' class="button style-10" style="margin-right:0px; margin-bottom:10px" >
                        <i class="fa fa-trash" style="font-size: 23px;"></i>ELIMINA WISHLIST
                    </a>
                </div>
            </div>

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
                                <div class="product-image">
                                    <%-- <a href="<%# GetImgUrl((string)Eval("PictureUrl")) %>"
                                    class="preview">
                                    <img src="<%# GetImgUrl((string)Eval("PictureUrl")) %>"
                                        alt="Immagine prodotto" style="max-width: 152px; max-height: 152px" /></a>--%>
                                    <img src='<%# Page.ResolveUrl(Eval("PictureUrl").ToString()) %>' alt="" onerror="this.src='noimage.jpg'" />
                                    <div class="bottom-line left-attached">
                                        <%--                                    <a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>--%>
                                        <%--                                    <a class="bottom-line-a square"><i class="fa fa-expand"></i></a>--%>


                                        <%--  <a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
                                                <a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>--%>
                                    </div>
                                </div>
                                <%-- Local :<asp:Label ID="ProductIdLabel" runat="server" Text='<%# Eval("ProductId") %>' Visible="true"></asp:Label>
                            Remote :<asp:Label ID="Label2" runat="server" Text='<%# Eval("ProductIdLocal") %>' Visible="true"></asp:Label>--%>

                                <a class="title" href='prodotto.aspx?cod=<%# Eval("ProductCod") %>'>
                                    <asp:Label ID="DisplayNameLabel" runat="server" Text='<%# Eval("DisplayName") %>' />
                                    - <%# Eval("ShortDescription") %></a>
                                <a href='prodotto.aspx?cod=<%# Eval("ProductCod") %>' class="tag">
                                    <asp:Label ID="ProductCodLabel" runat="server" Text='<%# Eval("ProductCod") %>' /></a>
                                <div class="article-container style-1">
                                    <p>

                                        <%# Eval("FullDescription") %>
                                        <%-- <%# Eval("AttributesList") %>--%>
                                    </p>
                                </div>
                                <h4 class="cart-column-title" runat="server" visible='<%#String.IsNullOrEmpty(Eval("PromoPrice").ToString()) || Eval("PromoPrice").ToString() == "0" ? true : false %>'>
                                    <div class="price">
                                        <%-- <%# Eval("ProductIdLocal")%> <%# Eval("ProductId") %> <%# Eval("CategoryID") %> <%# Eval("NameRw") %>--%>
                                        <%-- LA confezione contiene
                                    <div class="current">
                                        <%# Eval("units") %>
                                        <%# Eval("quantity") %>
                                    </div>
                                    <br />--%>
                                        <%--PREZZO (IVA COMPRESA)     --%>
                                        <div class="current">
                                            €
                                        <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price", "{0:F2}") %>' />
                                            <div class="clear"></div>
                                            <div style="padding-top: 10px">
                                                <div class="descrprice" style="letter-spacing: normal">PREZZO UNITARIO (IVA COMPRESA)</div>
                                            </div>
                                        </div>
                                        <%--   <%# ControlloGiacenza((int)Eval("ProductId") ) %>--%>
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
                                                <span class="inline-label red">in offerta fino al <%# Eval("PromoStopDate", "{0:dd/M/yyyy}")%></span><br />
                                                <span class="inline-label red">Prezzo Promozionale ( Iva Compresa )</span>
                                            </div>
                                        </h3>
                                    </div>
                                </asp:Panel>
                                <div class="list-buttons" style="display: block !important">


                                    <a href='javascript:RimuoviDalCarrello_Callback.PerformCallback(<%# Container.VisibleIndex %>);'>
                                        <div class=" search-button" style="padding-bottom: 10px !important; margin-left: 5px;">
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </a>

                                    <asp:LinkButton ID="ScopriDiPiu_LinkBt" runat="server" CommandName="SelectProduct" Visible="false">
                                   
<%--                            <a href='<% = Request.ApplicationPath.TrimEnd ( '/' )%>/prodotto/<%# GetGerarchiaMiele_17Mono(1,(-2), "MIELE",(int)Eval("CategoryID"), (string)Eval("NameRw") ) %>/prodotti.aspx'>--%>
                                    <div class="button style-10"  role="presentation">
                                    Scopri di più</div>
                                    </asp:LinkButton>
                                    <a href='prodotto.aspx?cod=<%# Eval("ProductCod") %>'>
                                        <div class="button style-10" role="presentation">
                                            Scopri di più
                                        </div>
                                    </a>
                                </div>
                                <asp:LoginView ID="LoginViewEdit" runat="server">
                                    <AnonymousTemplate>
                                    </AnonymousTemplate>
                                    <LoggedInTemplate>
                                    </LoggedInTemplate>
                                    <RoleGroups>
                                        <asp:RoleGroup Roles="Administrator">
                                            <ContentTemplate>
                                                <asp:Panel ID="PromoPanel2" runat="server" Visible='<%# Eval("PromoStatus")%>'>
                                                </asp:Panel>
                                                <%-- <asp:LinkButton ID="EditLinkBt" runat="server" CommandName="Edit">Modifica</asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="lnkCustDetails" Text='<%# Eval("ProductId") %>' OnClick="lnkCustDetails_Click" />--%>
                                            </ContentTemplate>
                                        </asp:RoleGroup>
                                    </RoleGroups>
                                </asp:LoginView>
                                <div class="clear"></div>

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
            <dx:ASPxCallback runat="server" ID="SvuotaWishList_CallB" ClientInstanceName="SvuotaWishList_CallB" OnCallback="SvuotaWishList_CallB_Callback">
                <ClientSideEvents EndCallback="function(s,e){Wishlist_Popup_callbackPnl.PerformCallback();showNotificationtoastr();shopList1.Refresh()}" />
            </dx:ASPxCallback>
            <dx:ASPxCallback runat="server" ID="RimuoviDalCarrello_Callback" ClientInstanceName="RimuoviDalCarrello_Callback" OnCallback="RimuoviDalCarrello_Callback_Callback">
                <ClientSideEvents EndCallback="function(s,e){Wishlist_Popup_callbackPnl.PerformCallback();showNotificationtoastr();shopList1.Refresh()}" />
            </dx:ASPxCallback>
            <asp:SqlDataSource runat="server" ID="ArticoliinWishlist_Sdt" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT distinct ProductID,  ProductCod, DisplayName, NameRW, ShortDescription, FullDescription, BrandId, units, quantity, Price, AttributesList, PromoId, Published,  PictureUrl, Sezione, Principale, StartDate AS PromoStartDate, StopDate AS PromoStopDate, PromoPrice, Deleted, PathImmagine FROM SHP_AllProductWithPromo WHERE 1 = 2"></asp:SqlDataSource>
        </div>






    </div>
</asp:Content>
