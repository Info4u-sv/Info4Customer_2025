<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="16SHP_CartView.ascx.cs" Inherits="INTRA.ShopRM.Controls._16SHP_CartView" %>
<%@ Register Src="~/ShopRM/Controls/MyMessageBox.ascx" TagName="MyMessageBox" TagPrefix="MsgBox" %>
<%@ Register Src="~/ShopRM/Controls/21Plusheader.ascx" TagPrefix="MsgBox" TagName="Plusheader" %>

<MsgBox:MyMessageBox ID="MyMessageBox1" runat="server" Visible="false" />
<MsgBox:MyMessageBox ID="MyMessageBoxAnnullamento" runat="server" Visible="false" ShowStaticMsg="false" ShowStaticType="Warning" ShowStaticMessageTxt="L'ordine è stato annullato" ShowCloseButton="True" />


<asp:ObjectDataSource ID="StoredShoppingCartObjectDS" runat="server"
    OldValuesParameterFormatString="original_{0}" SelectMethod="ReadItems" TypeName="INTRA.ShopRM.AppCode.StoredShoppingCart">
    <SelectParameters>
        <asp:CookieParameter CookieName="CodDep" Name="CodDep" DbType="String"></asp:CookieParameter>
    </SelectParameters>
</asp:ObjectDataSource>

<style>
    .input-group-addon {
        display: inline;
        padding: 14px 12px;
    }

    .current {
        font-size: 13px !important;
    }

    body.style-3 .price .current span {
        font-size: 12px !important;
    }

    .sidebar-subtotal .price-data .main {
        font-size: 23px !important;
    }

    .traditional-cart-entry .inline-description {
        font-size: 16px;
        line-height: 15px;
        color: red;
        font-weight: 500;
        margin-bottom: 5px;
    }

    .visible_False {
        display: none !important;
    }

    .visible_True {
        display: block !important;
        padding-top: 5px;
        padding-bottom: 5px;
    }

    .span_visible_True {
        padding-top: 5px;
        padding-bottom: 5px;
    }

    .span_visible_False {
        display: none !important;
        padding-top: 5px;
        padding-bottom: 5px;
    }

    .Marginpanel {
        margin-bottom: 20px !important;
    }

</style>

<dx:ASPxCallbackPanel runat="server" ID="ItemGest_CallbackPnl" ClientInstanceName="ItemGest_CallbackPnl" OnCallback="ItemGest_Callback_Callback1">
    <ClientSideEvents EndCallback="function(s,e){showNotificationtoastr();PopupCarrello_callbackPnl.PerformCallback();}" />
    <PanelCollection>
        <dx:PanelContent>
            <div class="col-lg-9 col-md-9 col-sm-12" style="padding-left: 0px !important; padding-right: 0px !important;">
                <h3 class="cart-column-title size-1" style="padding-left: 15px !important; margin-bottom: 0px !important; padding-top:15px !important; padding-bottom:15px !important; ">Carrello</h3>
                <asp:ListView ID="StoredShoppingCartListView" runat="server" DataSourceID="StoredShoppingCartObjectDS"
                    EnableModelValidation="True" DataKeyNames="MenuItemID" OnItemCommand="StoredShoppingCartListView_ItemCommand"
                    OnItemCreated="StoredShoppingCartListView_ItemCreated">

                    <EmptyDataTemplate>
                        <MsgBox:MyMessageBox ID="MyMessageBoxCart" runat="server" Visible="true" ShowStaticMsg="true" ShowStaticType="Warning" ShowStaticMessageTxt="Non ci sono prodotti nel carrello" ShowCloseButton="True" />
                    </EmptyDataTemplate>
                    <ItemTemplate>

                        <div class="traditional-cart-entry style-1 info4u-cart-spacing" style="margin-bottom: 0px !important; padding-bottom: 5px !important;">
                            <div class="content" style="margin-left: 0">
                                <div class="col-lg-7">
                                    <p class="title">
                                        <asp:Label ID="ItemNameLabel" runat="server" Text='<%# Eval("MenuItemID") %>' />
                                    </p>
                                    <p class="inline-description" style="color: darkblue !important">
                                        <asp:Label ID="DescrLabel" runat="server" Text='<%# Eval("ItemName") %>' />
                                    </p>
                                </div>
                                <div class="col-lg-5">
                                    <div class="price">
                                        <div class="quantity-selector detail-info-entry" style="display: inline">
                                            <div class="detail-info-entry-title">Quantità</div>
                                            <asp:Label ID="LabelErrorQuantity_Lbl" runat="server" Style="color: red"></asp:Label>

                                            <div class="quantity-selector detail-info-entry">
                                                <span class="input-group-addon ng-binding info4u-pezzo no-margin" style="font-size:11px !important;"><%#Eval("UM") %></span>
                                                <div class="entry number-minus-custom info4u-equal no-margin">&nbsp;</div>
                                                <div class="entry number no-padding no-margin" style="border-left-width:0px; border-right-width:0px;">
                                                    <asp:TextBox oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" ID="QuantityTextBox" runat="server" CssClass="cart-qta-custom info4u-quantita" Text='<%# Eval("Quantity") %>' qtaperconf='<%# Eval("QtaXConf") %>' />
                                                </div>
                                                <div class="entry number-plus-custom info4u-equal no-margin">&nbsp;</div>
                                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Aggiorna" Text="Aggiorna" class="remove-button"><i class="fa fa-refresh"></i></asp:LinkButton>
                                                <a href="javascript:Delete('<%#Eval("MenuItemID")%>')" class="remove-button">
                                                    <i class="fa fa-trash"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div id="itemPlaceholder" runat="server">
                        </div>
                    </LayoutTemplate>
                </asp:ListView>


            </div>
            <div class="col-lg-3 col-md-3 col-sm-4" style="padding-left: 0px !important; padding-right: 0px !important;">
                <asp:Panel ID="TotalPanel" runat="server">
                    <asp:Repeater ID="TotalRepeater" runat="server" DataSourceID="Object_totali" OnItemDataBound="TotalRepeater_ItemDataBound" OnItemCommand="TotalRepeater_ItemCommand">

                        <ItemTemplate>
                            <h3 class="cart-column-title size-1" style="text-align: left; margin-bottom: 0px !important; padding-top:15px !important; padding-bottom:15px !important; padding-left:15px !important;">Conferma</h3>
                            <div class="sidebar-subtotal">
                                <div class="additional-data">
                                    <MsgBox:MyMessageBox ID="DatiAnagraficiError_Bx" runat="server" Visible="false" style="margin: 0px !important; padding: 0px !important;" />
                                    <dx:ASPxMemo runat="server" ID="NoteOrdine_Memo" ClientInstanceName="NoteOrdine_Memo" Width="100%" Caption="Note ordine" Visible="false">
                                        <CaptionSettings Position="Top" />
                                    </dx:ASPxMemo>
                                    <br />
                                    <asp:LinkButton ID="ConfermaButton" runat="server" CommandName="ConfermaCarrello" Text="" class="button style-10">
                                        <asp:Label ID="EtichettaButtonLabel" runat="server" Text="Conferma Carrello"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="CatReturn_Click" class="button style-12">Continua Shopping</asp:LinkButton>
                                    <%--<asp:Panel ID="Ecommerce_Pnl" runat="server" Visible="false">
                                        <asp:LinkButton ID="ConfermaButton_PagoInSede" runat="server" CommandName="ConfermaOrdine" Text="" class="button style-10" Style="background: #e31d1d; border-color: #e31d1d">
                                            <asp:Label ID="Label4" runat="server" Text="INVIA ORDINE"></asp:Label>
                                        </asp:LinkButton>
                                    </asp:Panel>--%>
                                    <asp:Label ID="ErrorLabel" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4 information-entry">
                                </div>
                                <div class="col-md-4 information-entry">
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>
                </asp:Panel>
            </div>
        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxCallbackPanel>



<asp:SqlDataSource runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' ID="AppoggioCli_Sql" SelectCommand="select DeliveryCharge from Clienti where CodCli = @CodCli">
    <SelectParameters>
        <asp:CookieParameter CookieName="CodCli" Name="CodCli" Type="String"></asp:CookieParameter>
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource runat="server" ID="Appoggio_Sql" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SHP_GetVincoloCategoria" InsertCommand="RM_VincoliContattoRegistrazione_CheckInsert" InsertCommandType="StoredProcedure" SelectCommandType="StoredProcedure">
    <InsertParameters>
        <asp:Parameter Name="IDContatto" Type="Int32"></asp:Parameter>
        <asp:Parameter Name="CodVincolo" Type="String"></asp:Parameter>
    </InsertParameters>
    <SelectParameters>
        <asp:CookieParameter CookieName="CodCli" Name="CodCli" Type="String"></asp:CookieParameter>
    </SelectParameters>
</asp:SqlDataSource>

<%--<asp:SqlDataSource runat="server" ID="AppoggioCart_Sql" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Clienti.Denom, ISNULL(Clienti.U_Trasporto, 0) AS U_Trasporto, Clienti.Ind, Clienti.Cap, Clienti.Prov, Clienti.Loc, Clienti.Tel, Clienti.PIva, Clienti.CF, Clienti.DsNaz, Clienti.EMail, CliFatt3.CodLis, CliFatt3.CodAge, CASE WHEN CliFatt1.Sconto1 IS NULL THEN 0 ELSE CliFatt1.Sconto1 END AS ScontoIncondizionatoOLD, ISNULL(TabPag.PercScPag, 0) AS ScontoIncondizionato, ISNULL(TabPag.SpeBan, 0) AS SpeBan, TabPag.CodCPag, Clienti.CodCli FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN CliFatt1 ON Clienti.CodCli = CliFatt1.CodCli LEFT OUTER JOIN TabPag ON CliFatt1.CodPag = TabPag.CodCPag WHERE (Clienti.CodCli = @CodCli)">
    <SelectParameters>
        <asp:ProfileParameter PropertyName="CodCli" Name="CodCli"></asp:ProfileParameter>
    </SelectParameters>
</asp:SqlDataSource>--%>

<asp:SqlDataSource runat="server" ID="AppoggioCart_Sql" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT        Denom, Ind, Cap, Prov, Loc, Tel, PIva, CF, DsNaz, EMail, CodCli FROM  Clienti WHERE  (CodCli = @CodCli)">
    <SelectParameters>
        <asp:CookieParameter CookieName="CodCli" Name="CodCli" Type="String"></asp:CookieParameter>
    </SelectParameters>
</asp:SqlDataSource>

<asp:ObjectDataSource ID="Object_totali" runat="server" SelectMethod="ReadTotaliLocal"
    TypeName="INTRA.ShopRM.AppCode.ESK_ShoppingCart" OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:CookieParameter CookieName="CodDep" Name="CodDep" DbType="String"></asp:CookieParameter>
    </SelectParameters>
</asp:ObjectDataSource>
<asp:Panel ID="ErrorPanel" runat="server">
</asp:Panel>
<script>
    //$(function () { PopupCarrello_callbackPnl.PerformCallback(); });
    function Delete(productID) {
        if (confirm("Conferma rimozione articolo da carrello")) {
            ItemGest_CallbackPnl.PerformCallback("Delete|" + productID);
        }
    }

</script>


