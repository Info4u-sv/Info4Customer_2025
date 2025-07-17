<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="21Plusheader.ascx.cs" Inherits="INTRA.ShopRM.Controls._21Plusheader" %>
<%--<%@ Register Src="~/ShopRM/controls/16ButtonSearch.ascx" TagPrefix="uc1" TagName="ButtonSearch" %>--%>
<%@ Register Src="~/ShopRM/controls/21Mono-Navigator.ascx" TagPrefix="PlusNavigator" TagName="PlusNavigator" %>
<%@ Register Src="~/ShopRM/controls/16SocialBox.ascx" TagPrefix="uc1" TagName="SocialBox" %>
<%@ Register Src="~/ShopRM/controls/21LoginArea.ascx" TagPrefix="uc1" TagName="LoginArea" %>

<%--<%@ Register Src="~/ShopRM/controls/21LoginArea.ascx" TagPrefix="uc1" TagName="LoginArea" %>--%>

<script>
    function GoToCart() {
        var cookie = getCookie('CodDep');
        if (cookie != null && cookie != '') {
            window.location.href = '/ShopRM/Carrello.aspx';

        } else {

            console.log("valore cookie " + cookie);
            showNotificationErrortoastr("Selezionare prima un deposito");
        }
    }
    function GoToDep() {
        var mioCookie = getCookie('U_Token');
        var cookie = getCookie('CodDep');
        if (cookie != null && cookie != '') {
            window.location.href = '/ShopRM/Deposito/Deposito_Dett.aspx?CodDep=' + mioCookie.replace('U_Token=', '');

        } else {

            console.log("valore cookie " + cookie);
            showNotificationErrortoastr("Selezionare prima un deposito");
        }
    }
    function GoToInv() {
        var cookie = getCookie('CodDep');
        if (cookie != null && cookie != '') {
            window.location.href = '/ShopRM/Inventario.aspx';

        } else {

            console.log("valore cookie " + cookie);
            showNotificationErrortoastr("Selezionare prima un deposito");
        }
    }
    function GoBack() {
        var mioCookie = getCookie('U_Token');
        var cookie = getCookie('CodDep');
        if (cookie != null && cookie != '') {
            window.location.href = '/Default.aspx';

        } else {
            showNotificationErrortoastr("Area non accessibile");
        }
    }
</script>
<style>
    .cart-icon-style {
    background-color: #0055A6;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    border-radius: 4px;
    text-decoration: none;
        float: right;
}

.cart-icon-style i {
    font-size: 18px;
}
.header-wrapper::after {
  content: "";
  display: block;
  height: 70px;
  width: 100%;
}
</style>

<div class="header-wrapper style-1">
    <header class="type-1">
        <div class="header-top">
            <div class="header-top-entry"></div>
            <uc1:LoginArea runat="server" ID="LoginArea" />

            <div class="menu-button responsive-menu-toggle-class"><i class="fa fa-reorder"></i></div>
            <div class="clear"></div>
        </div>

        <div class="header-middle">
            <div class="logo-wrapper">
                <a href="~/ShopRM/default.aspx" runat="server" id="logo">
                    <img src='<%= Page.ResolveUrl("~/ShopRM/static/img/info4u-logo.png")%>' alt="" style="width: 200px; float:left;" /></a>
            </div>

            <div class="right-entries responsive-desk">
                <a class="header-functionality-entry open-cart-popup search-button" style="float: right; margin-left: 5px" href="/ShopRm/carrello.aspx" runat="server" id="A2"><i class="fa fa-shopping-cart"></i></a>
            </div>
            <div class="right-entries responsive-mobile">
                <a class="cart-icon-style open-cart-popup" href="/ShopRm/carrello.aspx" runat="server" id="A1">
                    <i class="fa fa-shopping-cart"></i>
                </a>
            </div>
        </div>

        <div class="close-header-layer"></div>
        <div class="navigation">
            <div class="navigation-header responsive-menu-toggle-class">
                <div class="title" style="border-bottom: 1px solid #ffffff; padding-left:17px;">Naviga</div>
                <div class="close-menu"></div>
            </div>
            <div class="nav-overflow">
                <PlusNavigator:PlusNavigator runat="server" ID="PlusNavigator10" />
                <div class="navigation-footer responsive-menu-toggle-class">
                    <div class="navigation-copyright">
                        <asp:Label ID="LblCopyright" runat="server" Text="Label"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="clear"></div>
</div>

<asp:ObjectDataSource ID="StoredShoppingCartObjectDS" runat="server" DeleteMethod="DeleteItem"
    OldValuesParameterFormatString="original_{0}" SelectMethod="ReadItems" TypeName="INTRA.ShopRM.AppCode.StoredShoppingCart"
    UpdateMethod="UpdateItem">
    <DeleteParameters>
        <asp:Parameter Name="MenuItemID" Type="String" />
        <asp:Parameter Name="qtasel" Type="Int32" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="original_MenuItemID" Type="String" />
        <asp:Parameter Name="original_ItemName" Type="String" />
        <asp:Parameter Name="original_qtasel" Type="Int32" />
        <asp:Parameter Name="Quantity" Type="Int32" />
        <asp:Parameter Name="original_prezzo" Type="Decimal" />
    </UpdateParameters>
    <SelectParameters>
        <%--  <asp:SessionParameter SessionField="CodCli" Name="CodCli" Type="String"></asp:SessionParameter>--%>
        <asp:CookieParameter CookieName="CodDep" Name="CodDep" DbType="String"></asp:CookieParameter>
    </SelectParameters>
</asp:ObjectDataSource>



<asp:ObjectDataSource ID="Object_totali" runat="server" SelectMethod="Read"
    TypeName="INTRA.ShopRM.AppCode.StoredShoppingCart" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
<div class="cart-box popup ">
    <div class="popup-container">
        <dx:ASPxCallbackPanel runat="server" ID="PopupCarrello_callbackPnl" Height="250px" ClientInstanceName="PopupCarrello_callbackPnl" RenderMode="Table" Width="100%" OnCallback="PopupCarrello_callbackPnl_Callback">

            <PanelCollection>
                <dx:PanelContent ID="PanelContent3" runat="server">
                    <asp:ListView ID="StoredShoppingCartListView" runat="server" DataSourceID="StoredShoppingCartObjectDS"
                        EnableModelValidation="True" DataKeyNames="MenuItemID">
                        <EmptyDataTemplate>
                            <div class="subtotal">Vuoto</div>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div class="cart-entry">
                                <div class="content" style="margin: 0;">
                                    <div class="title"><%# Eval("MenuItemID")%> - <%# Eval("ItemName") %></div>
                                    <div class="quantity" style="display: inline; float: left;">Q.tà: <%# Eval("Quantity") %></div>
                                    <%--<div class="price" style="display: inline; float: right;">€ <%# String.Format("{0:C}",Eval("ItemPrice")) %></div>--%>

                                    <%--                                  
                                    <div class="clear"></div>
                                    <div class="summary" style="display:none">
                                        <div class="grandtotal" style="float: right">Sub-Totale <span>€ <%# String.Format("{0:C}",Eval("LineValue")) %></span></div>
                                    </div>--%>
                                </div>
                            </div>


                        </ItemTemplate>
                        <LayoutTemplate>
                            <div class="cart-buttons" style="width: 100%">
                                <div class="lg-12">
                                    <a class="button style-9 " href="/ShopRM/Carrello.aspx" style="width: 100%; background-color: dimgrey; color: #fff; margin-bottom: 5px">Vai Al Carrello</a>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="cart-entry" id="itemPlaceholder" runat="server"></div>
                        </LayoutTemplate>
                    </asp:ListView>

                    <asp:Repeater ID="TotalRepeater" runat="server" DataSourceID="Object_totali" Visible="false">
                        <HeaderTemplate></HeaderTemplate>
                        <ItemTemplate>
                            <div class="summary">
                                <div class="grandtotal">Totale <span><%# String.Format("{0:C}",Eval("Total")) %></span></div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>

                    <%-- <div class="cart-buttons">
                        <div class="column">
                            <a class="button style-12" href="WishListMiele.aspx" style="width: 100%">Crea PDF</a>
                        </div>
                    </div>
                    <br />
                    <br />--%>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
</div>






<!-- #region Wishlist_Popup_callbackPnl -->

<asp:ObjectDataSource ID="WishList_StoredShoppingCartObjectDS" runat="server" DeleteMethod="DeleteItem"
    OldValuesParameterFormatString="original_{0}" SelectMethod="ReadItems" TypeName="INTRA.ShopRM.AppCode.StoredShoppingCart_wish"
    UpdateMethod="UpdateItem">
    <DeleteParameters>
        <asp:Parameter Name="MenuItemID" Type="String" />
        <asp:Parameter Name="qtasel" Type="Int32" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="original_MenuItemID" Type="String" />
        <asp:Parameter Name="original_ItemName" Type="String" />
        <asp:Parameter Name="original_qtasel" Type="Int32" />
        <asp:Parameter Name="Quantity" Type="Int32" />
        <asp:Parameter Name="original_prezzo" Type="Decimal" />
    </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="Wishlist_Object_totali" runat="server" SelectMethod="Read" TypeName="INTRA.ShopRM.AppCode.StoredShoppingCart_wish" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
<div class="wish-box popup ">
    <div class="popup-container">
        <dx:ASPxCallbackPanel runat="server" ID="Wishlist_Popup_callbackPnl" Height="250px" ClientInstanceName="Wishlist_Popup_callbackPnl" RenderMode="Table" Width="100%" OnCallback="Wishlist_Popup_callbackPnl_Callback">

            <PanelCollection>
                <dx:PanelContent ID="PanelContent1" runat="server">
                    <asp:ListView ID="WishList_StoredShoppingCartListView" runat="server" DataSourceID="WishList_StoredShoppingCartObjectDS"
                        EnableModelValidation="True" DataKeyNames="MenuItemID">
                        <EmptyDataTemplate>
                            <div class="subtotal">Vuoto</div>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div class="wish-entry">
                                <div class="content" style="margin: 0;">
                                    <a class="title" href="#"><%# Eval("ItemName") %></a>
                                    <div class="quantity" style="display: inline; float: left;">Q.tà: <%# Eval("Quantity") %></div>
                                    <div class="price" style="display: inline; float: right;">€ <%# String.Format("{0:C}",Eval("ItemPrice")) %></div>

                                    <%--                                  
                                    <div class="clear"></div>
                                    <div class="summary" style="display:none">
                                        <div class="grandtotal" style="float: right">Sub-Totale <span>€ <%# String.Format("{0:C}",Eval("LineValue")) %></span></div>
                                    </div>--%>
                                </div>
                            </div>


                        </ItemTemplate>
                        <LayoutTemplate>
                            <div class="wish-buttons" style="width: 100%">
                                <div class="lg-12">
                                    <a class="button style-9 " href="WishListMiele.aspx" style="width: 100%; background-color: dimgrey; color: #fff; margin-bottom: 5px">Crea PDF</a>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="wish-entry" id="itemPlaceholder" runat="server"></div>
                        </LayoutTemplate>
                    </asp:ListView>

                    <asp:Repeater ID="Wishlist_TotalRepeater" runat="server" DataSourceID="Wishlist_Object_totali" Visible="false">
                        <HeaderTemplate></HeaderTemplate>
                        <ItemTemplate>
                            <div class="summary">
                                <div class="grandtotal">Totale <span><%# String.Format("{0:C}",Eval("Total")) %></span></div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>

                    <%-- <div class="cart-buttons">
                        <div class="column">
                            <a class="button style-12" href="WishListMiele.aspx" style="width: 100%">Crea PDF</a>
                        </div>
                    </div>
                    <br />
                    <br />--%>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
</div>




<!-- #endregion -->
<script>
    window.addEventListener("DOMContentLoaded", () => {
        const header = document.querySelector(".header-wrapper");
        if (header) {
            const spacer = document.createElement("div");
            spacer.style.height = header.offsetHeight + "px";
            header.after(spacer);
        }
    });
</script>