<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="prodotto.aspx.cs" Inherits="INTRA.ShopRM.prodotto" %>

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

    <%--     <link href="/content/toastr.css" rel="stylesheet" />
    <script src="/assets/js/toastr/toastr.js"></script>--%>

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

            <asp:SqlDataSource ID="breadcrumb_SqlDt" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT SHP_Category.DisplayName AS SubCatego, SHP_Product_Category_Mapping.ProductID, SHP_Category_1.DisplayName AS Catego, SHP_Product.ProductCod, SHP_Product.DisplayName, SHP_Category.CategoryID AS SubCategoID, SHP_Category_1.CategoryID AS CategoID FROM SHP_Product_Category_Mapping INNER JOIN SHP_Category ON SHP_Product_Category_Mapping.CategoryID = SHP_Category.CategoryID INNER JOIN SHP_Product ON SHP_Product_Category_Mapping.ProductID = SHP_Product.ProductID LEFT OUTER JOIN SHP_Category AS SHP_Category_1 ON SHP_Category.ParentCategoryID = SHP_Category_1.CategoryID WHERE (SHP_Product.ProductCod = @Cod)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="cod" DefaultValue="0" Name="Cod"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="breadcrumb-box">
                <a href="/ShopRM/Default.aspx">Catalogo</a>
                <asp:ListView ID="breadcrumb_LView" runat="server" DataSourceID="breadcrumb_SqlDt">
                    <ItemTemplate>
                        <a href="/ShopRM/prodotti.aspx?Cat=<%# Eval("CategoID") %>"><%# Eval("Catego") %></a>
                        <a href="/ShopRM/prodotti.aspx?Cat=<%# Eval("SubCategoID") %>"><%# Eval("SubCatego") %></a>
                        <a href="#"><%# Eval("DisplayName") %></a>
                    </ItemTemplate>
                </asp:ListView>
            </div>

            <div class="content-push">

                <asp:ListView ID="ListViewProdotto" runat="server" DataSourceID="ProdottoDettSqlDt">

                    <ItemTemplate>
                        <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price", "{0:F2}") %>' Visible="false" />
                        <asp:Label ID="DisplayNameLabel" runat="server" Text='<%# Eval("DisplayName") %>' Visible="false" />

                        <div class="information-blocks">
                            <div class="row">
                                <div class="col-sm-6 information-entry">
                                    <div class="product-preview-box">
                                        <div class="swiper-container product-preview-swiper" data-autoplay="0" data-loop="1" data-speed="500" data-center="0" data-slides-per-view="1">
                                            <div class="swiper-wrapper">
                                                <div class="swiper-slide">
                                                    <div class="product-zoom-image">
                                                        <asp:ListView runat="server" ID="Repeater2" DataSourceID="SHP_Picture_Prodotti">
                                                            <ItemTemplate>
                                                                <a href="<%# Eval("PictureUrl") %>" class="swipebox" rel="top_gallery">
                                                                    <img src="<%# Eval("PictureUrl") %>" alt="" onerror="this.src='noimage.jpg'" />
                                                                </a>
                                                            </ItemTemplate>
                                                            <EmptyItemTemplate>
                                                                <img src="noimage.jpg" alt="" />
                                                            </EmptyItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <img src="noimage.jpg" alt="" />
                                                            </EmptyDataTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="pagination"></div>

                                        </div>
                                        <div class="swiper-hidden-edges">
                                            <div class="swiper-container product-thumbnails-swiper" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="3" data-int-slides="3" data-sm-slides="3" data-md-slides="4" data-lg-slides="4" data-add-slides="4">
                                                <div class="swiper-wrapper">
                                                    <asp:Repeater runat="server" ID="Repeater3" DataSourceID="SHP_Picture_Prodotti">
                                                        <ItemTemplate>
                                                            <div class="swiper-slide" runat="server" visible='<%#String.IsNullOrEmpty(Eval("NumImg").ToString()) || (Eval("NumImg").ToString() == "1") ? false : true %>'>
                                                                <div class="paddings-container">
                                                                    <img src="<%# Eval("PictureUrl") %>" alt="" />
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>

                                                    </asp:Repeater>

                                                </div>
                                                <div class="pagination"></div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-sm-6 information-entry">
                                    <div class="product-detail-box">
                                        <h1 class="product-title" style="margin-bottom: 0px;"><%# Eval("DisplayNameDet") %></h1>
                                        <h3 class="product-subtitle"><%# Eval("ProductCod") %></h3>

                                        <div class="product-description detail-info-entry article-container style-1" runat="server" style="font-size: 20px !important; font-weight: 400 !important;" visible='<%#String.IsNullOrEmpty(Eval("FullDescription").ToString()) ? true : true %>'><%# Eval("ShortDescription") %></div>
                                        <div class="product-description detail-info-entry article-container style-1" runat="server" visible='<%#!String.IsNullOrEmpty(Eval("FullDescription").ToString()) ? true : false %>'><%# Eval("FullDescription") %></div>
                                        <div class="price detail-info-entry" runat="server" visible='<%#String.IsNullOrEmpty(Eval("PromoPrice").ToString()) ? true : false %>'>
                                            <h3 class="cart-column-title" style="letter-spacing: normal">
                                                <div class="current">€<%# Eval("Price", "{0:0.00}") %></div>
                                                <div class="clear"></div>
                                                <div class="price" style="letter-spacing: normal">PREZZO UNITARIO (IVA COMPRESA)</div>
                                            </h3>
                                        </div>
                                        <div class="price detail-info-entry" runat="server" visible='<%#String.IsNullOrEmpty(Eval("PromoPrice").ToString()) ? false : true %>'>
                                            <%-- <div class="prev">€<%# Eval("Price", "{0:0.00}") %></div>
                                            <div class="current">€<%# Eval("PromoPrice", "{0:0.00}") %></div>
                                            <div class="clear"></div>
                                            <div class="price" style="letter-spacing: normal">PREZZO UNITARIO (IVA COMPRESA)</div>--%>
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
                                        <a href='javascript:AggiungiAllaWishlist_Callback.PerformCallback(0);'>
                                            <div class=" search-button" style="padding-bottom: 10px !important; margin-left: 5px; margin-right: 10px;">
                                                <i class="fa fa-heart"></i>
                                            </div>
                                        </a>
                                        <div class="detail-info-entry" runat="server" visible='<%#String.IsNullOrEmpty(Eval("Confezione").ToString()) ? false : true %>'>
                                            <div class="detail-info-entry-title">Confezione</div>
                                            <div class="article-container style-1">
                                                <%# Eval("Confezione") %>
                                            </div>
                                            <div class="clear"></div>
                                        </div>
                                        <div class="detail-info-entry" runat="server" visible='<%#String.IsNullOrEmpty(Eval("AttributesList").ToString()) ? false : true %>'>
                                            <div class="detail-info-entry-title">Lista attributi</div>
                                            <div class="article-container style-1">
                                                <%# Eval("AttributesList") %>
                                            </div>
                                            <div class="clear"></div>
                                        </div>
                                    </div>


                                    <%--   <dx:ASPxGridView runat="server" ID="SlideImg_Grw" Width="100%" Settings-ShowColumnHeaders="false" DataSourceID="SHP_Picture_Slide">
                                        <Templates>

                                            <DataRow>
                                                <dx:ASPxImage runat="server" ID="ImmaginiSlide_img" ImageUrl='<%# Eval("PictureUrl") %>' Width="100%">
                                                    <ClientSideEvents Click="function (s,e){
                                                                    OnImageClick('SHP_Picture_Slide');                         
                                                                    }   " />
                                                </dx:ASPxImage>
                                            </DataRow>
                                            <EmptyDataRow>
                                            </EmptyDataRow>
                                        </Templates>
                                    </dx:ASPxGridView>--%>


                                    <ul id="box-container1">
                                        <asp:Repeater runat="server" ID="Repeater1" DataSourceID="SHP_Picture_Slide">
                                            <ItemTemplate>
                                                <li class="box">
                                                    <a href="<%# Eval("PictureUrl") %>" class="swipebox" title="" rel="bottom_gallery">
                                                        <img src="<%# Eval("PictureUrl") %>" alt="image">
                                                    </a></li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>

                                    <%--                                    <div class="example gc3">
                                        <div class="html-code grid-of-images">
                                            <div class="zoom-gallery">
                                                <asp:Repeater runat="server" ID="Slider_Repeater" DataSourceID="SHP_Picture_Slide">
                                                    <ItemTemplate>
                                                        <a href="<%# Eval("PictureUrl") %>" title="" style="width: 193px; height: 125px;">
                                                            <img src="<%# Eval("PictureUrl") %>" width="193" height="125">
                                                        </a>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
                <asp:SqlDataSource ID="ProdottoDettSqlDt" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="
                    SELECT Distinct [ProductID]
      ,0 as CategoryID
      ,[ProductCod]
      ,[DisplayName]
      ,[NameRW]
      ,[ShortDescription]
      ,[FullDescription]
      ,[BrandId]
      ,[units]
      ,[quantity]
      ,[Price]
      ,[AttributesList]
      ,[PromoId]
      ,[Published]
     
      ,[PictureUrl]
      ,[Sezione]
      ,[Principale]
      ,[StartDate] as PromoStartDate
      ,[StopDate] as PromoStopDate
      ,[PromoPrice]
      ,[Deleted]
      ,[PathImmagine]
      , confezione, DisplayNameDet

  FROM [SHP_AllProductWithPromo] WHERE ([SHP_AllProductWithPromo].ProductCod = @Cod)">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="Cod" Name="Cod"></asp:QueryStringParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SHP_Picture_Prodotti" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT SHP_Picture.PictureID, SHP_Product.ProductCod, SHP_Picture.PictureUrl, SHP_Picture.Principale, SHP_Picture.Sezione, ContaImgTab.NumImg FROM SHP_Picture INNER JOIN SHP_Product ON SHP_Picture.IdContent = SHP_Product.ProductID INNER JOIN (SELECT COUNT(SHP_Picture_1.PictureID) AS NumImg, SHP_Product_1.ProductID FROM SHP_Picture AS SHP_Picture_1 INNER JOIN SHP_Product AS SHP_Product_1 ON SHP_Picture_1.IdContent = SHP_Product_1.ProductID WHERE (SHP_Product_1.ProductCod = @ProductCod) AND (SHP_Picture_1.Sezione = 'prodotti') GROUP BY SHP_Product_1.ProductID) AS ContaImgTab ON SHP_Product.ProductID = ContaImgTab.ProductID WHERE (SHP_Product.ProductCod = @ProductCod) AND (SHP_Picture.Sezione = 'prodotti') ORDER BY SHP_Picture.Principale DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="Cod" DefaultValue="0" Name="ProductCod"></asp:QueryStringParameter>
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="SHP_Picture_Slide" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT SHP_Picture.PictureID, SHP_Product.ProductCod, SHP_Picture.PictureUrl, SHP_Picture.Principale, SHP_Picture.Sezione FROM SHP_Picture INNER JOIN SHP_Product ON SHP_Picture.IdContent = SHP_Product.ProductID WHERE (SHP_Product.ProductCod = @ProductCod) AND (SHP_Picture.Sezione = 'slide') ORDER BY SHP_Picture.Principale DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="Cod" DefaultValue="0" Name="ProductCod"></asp:QueryStringParameter>
                    </SelectParameters>
                </asp:SqlDataSource>

                <dx:ASPxCallback runat="server" ID="AggiungiAllaWishlist_Callback" ClientInstanceName="AggiungiAllaWishlist_Callback" OnCallback="AggiungiAllaWishlist_Callback_Callback">
                    <ClientSideEvents EndCallback="function(s,e){Wishlist_Popup_callbackPnl.PerformCallback();LoadingPanel.Hide();showNotificationtoastr();  }" />
                </dx:ASPxCallback>
            </div>

        </div>
    </div>
    <dx:ASPxPopupControl ID="ASPxPopupControlZoom" runat="server" ClientInstanceName="popupzoom" Modal="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" BackColor="Transparent" AutoUpdatePosition="true"
        ShowShadow="false" Border-BorderStyle="None" ShowHeader="false" ShowPageScrollbarWhenModal="false" EnableTheming="false">
        <ContentStyle Paddings-Padding="0" Border-BorderWidth="0" />
        <ClientSideEvents CloseUp="OnPopupCloseUp" PopUp="OnPopupUp" />
        <ModalBackgroundStyle Opacity="100" BackColor="#1a1a1a" />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <table>
                    <tr>
                        <td style="padding-right: 11px; padding-bottom: 21px; text-align: right; color: white">
                            <a href="javascript:popupzoom.Hide();" style="padding: 20px; margin-right: -20px; background-color: white">Chiudi </a>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 36px;">
                            <dx:ASPxCallbackPanel ID="CaricaSliderZoom_CallbackPnl" runat="server" Width="100%" OnCallback="CaricaSliderZoom_CallbackPnl_Callback" ClientInstanceName="CaricaSliderZoom_CallbackPnl">
                                <ClientSideEvents EndCallback="EndCallback_PanelZoom" />
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxImageSlider ID="ASPxImageSliderZoom" runat="server" ClientInstanceName="imageSliderZoom"
                                            NameField="Id"
                                            EnableTheming="false" ImageUrlField="PictureUrl">
                                            <SettingsImageArea ItemTextVisibility="None" NavigationButtonVisibility="Always" ImageSizeMode="FitProportional" />

                                            <SettingsBehavior EnablePagingByClick="True" AllowMouseWheel="true" EnablePagingGestures="true" ImageLoadMode="DynamicLoadAndCache" />
                                            <Styles>
                                                <ImageArea Width="660" Height="660" />
                                            </Styles>
                                            <ClientSideEvents ActiveItemChanged="OnActiveItemChanged" />
                                        </dx:ASPxImageSlider>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 36px; text-align: center">
                            <span style="color: #ffffff; font-size: 9pt; font-family: 'Segoe UI', 'Helvetica Neue', Tahoma;" id="itemText">1/20</span>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <Border BorderStyle="None"></Border>
    </dx:ASPxPopupControl>

</asp:Content>
