<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="21COMM_ContentAreaProdotti.ascx.cs" Inherits="INTRA.ShopRM.Controls._21COMM_ContentAreaProdotti" %>
<asp:Label ID="BrandIdLbl" runat="server" Text="Label" Visible="false"></asp:Label>
<div class="heading-article" style="margin-bottom: 0px; line-height: 40px">
    <asp:Repeater ID="RepeaterTestata" runat="server">
        <ItemTemplate>
            <%--<div class="list-buttons" style="float: right">
                <a href='javascript:AggiungiAllaWishlistSubCatego_Callback.PerformCallback();' class="button style-12" style="float: right; margin-right: 5px !important; <%# ((int)Eval("LevelCategory") == 0 ) ?  "display:none;": "" %>">

                    <i class="fa fa-heart"></i>INSERISCI
              
                </a>
            </div>
            <h2 class="block-title inline-product-column-title" style="line-height: 40px"><%#Eval("DisplayName")%></h2>
             <%#Eval("Description")%>--%>
        </ItemTemplate>
    </asp:Repeater>
</div>

<style>
    .HideColumn {
        display: none !important;
    }

    .prev {
        font-size: 16px;
    }

    .descrprice {
        font-size: 16px;
    }

    .detail-info-entry {
        margin: 0 !important;
    }

    .quantity-selector .entry {
        height: 40px;
        /* line-height: 37px;*/
        width: 40px;
        font-size: 30px;
    }

        .quantity-selector .entry.number {
            padding: 0;
        }

    .cart-qta-custom {
        height: 38px;
    }
</style>
<script>
    function ValidationGiorni(s, e) {

        var SplitToken = s.GetText().split(',');
        var isValid = GiorniDaSelezionare_Lbl.GetText() == SplitToken.length;
        e.isValid = isValid;
        if (!isValid) {
            e.errorText = "Bisogna selezionare " + GiorniDaSelezionare_Lbl.GetText() + " giorni per continuare";
        }

        return true;

        return false
    }
    function ControlloNumeroTocken(s, e) {
        var tokens = s.GetTokenCollection();
        if (tokens.length > Number(GiorniDaSelezionare_Lbl.GetText())) {
            s.RemoveToken(1);
        }
    }
</script>


<%--<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true">
    <Scripts>
        <asp:ScriptReference Path="~/ShopRM/Scripts/AjaxControlToolkit/Bundle" />
    </Scripts>
</asp:ScriptManager>--%>

<asp:HiddenField ID="IDContatto_HField" runat="server" />
<div class="article-container">
    <%--<asp:Panel ID="SearchPanel" runat="server" Visible="false">
        <div class="information-blocks">
            <h3 class="block-title inline-product-column-title">Affina la Ricerca</h3>
            Per descrizione
          <asp:TextBox ID="SearchTxtBox" runat="server" class="simple-field size-1"></asp:TextBox>
            Per Modello
            <div class="simple-drop-down simple-field size-1">

                <asp:DropDownList ID="SearchDDL" runat="server" OnPreRender="SearchDDL_PreRender">
                    <asp:ListItem Value="-1">-- Seleziona --</asp:ListItem>
                    <asp:ListItem Value="S_1%">S 1xx</asp:ListItem>
                    <asp:ListItem Value="S_2%">S 2xx</asp:ListItem>
                    <asp:ListItem Value="S_3%">S 3xx</asp:ListItem>
                    <asp:ListItem Value="S_4%">S 4xx</asp:ListItem>
                    <asp:ListItem Value="S_5%">S 5xx</asp:ListItem>
                    <asp:ListItem Value="S_6%">S 6xx</asp:ListItem>
                    <asp:ListItem Value="S_7%">S 7xx</asp:ListItem>
                    <asp:ListItem Value="S_8%">S 8xx</asp:ListItem>
                    <asp:ListItem Value="S_9%">S 9xx</asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:LinkButton ID="SearchBtn" runat="server" Text="Trova" ValidationGroup=""
                OnClick="SearchBtn_Click" class="remove-button" Style="width: 40px !important"><i class="fa fa-refresh"></i></asp:LinkButton>
        </div>
        <div style="float: left; display: inline; padding-left: 20px;">
        </div>
    </asp:Panel>--%>


    <asp:ListView ID="ListViewCatego" runat="server" DataSourceID="CategoDescrSqlDt" Visible="false">
        <ItemTemplate>

            <div class="article-container style-1">
                <%# Eval("Description") %>
            </div>
        </ItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="CategoDescrSqlDt" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Description FROM SHP_Category WHERE (CategoryID = @Cat) AND (ParentCategoryID = 0)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Cat" Name="Cat"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <%-- <div class="shop-grid-controls">

        <div class="entry" style="float: left">
            <div class="view-button  grid"><i class="fa fa-th"></i></div>
            <div class="view-button active list"><i class="fa fa-list"></i></div>
        </div>

    </div>--%>

    <div class="row shop-grid list-view">
        <dx:ASPxCardView ID="ShopList1" ClientInstanceName="shopList1" runat="server" Width="100%" KeyFieldName="ProductCod" Paddings-Padding="0">
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
                    <div class="col-md-3 col-sm-3 shop-grid-item no-margin">
                        <div class="product-slide-entry" style="margin: 0px !important;">
                            <%--<div class="product-image">

                                <img src='<%# Page.ResolveUrl(Eval("PictureUrl").ToString()) %>' alt="" onerror="this.src='noimage.jpg'" />
                                <div class="bottom-line left-attached">
                                </div>
                            </div>--%>
                            <%--  <%# Eval("Price") %>
                            <%# Eval("PromoPrice") %>--%>
                            <div class="col-lg-8 col-md-6 col-sm-12 col-xs-12">
                                <div>
                                    <asp:Label ID="Label1" runat="server" Font-Size="Large" Text='<%# Eval("DisplayName") %>' Font-Bold="true" />
                                    <p style="font-size: large; display: inline;">- <%# Eval("FullDescription") %> </p>
                                </div>

                                <div class="tag" style="margin-bottom: 10px; color: black !important">
                                    <asp:Label ID="Label2" runat="server" Font-Size="Medium" Text='<%# string.Format("CATEGORIA: {0}",Eval("ShortDescription")) %>' />
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">

                                <div class="input-group" style="float: right">
                                    <%--  insert carrello--%>
                                    <div class="input-group quantity-selector detail-info-entry">
                                        <span class="input-group-addon"><%#Eval("units") %></span>
                                        <div class="entry number-minus-custom">&nbsp;</div>
                                        <div class="entry number" style="border: 0px">
                                            <input class="info4u-custom-quantity" oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" value="1" min="1" max="999999" qtaperconf='1' id="<%# "P" + Eval("ProductCod").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>">
                                        </div>
                                        <div class="entry number-plus-custom">&nbsp;</div>
                                    </div>
                                    <span class="input-group-btn">
                                        <a class="btn btn-primary info4u-custom-cart" style="color: #ffffff;" href='javascript: AddToCart("<%# "P" + Eval("ProductCod").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>",<%# Container.VisibleIndex %>);'>
                                            <span id="addCart_DS4608SR7U2100" title="Aggiungi l'articolo al carrello">
                                                <i class="fa fa-shopping-cart"></i>
                                                <dx:ASPxLabel runat="server" Text="CARRELLO" ForeColor="White" CssClass="car_css"></dx:ASPxLabel>
                                            </span>
                                        </a>

                                        <script>
                                            function AddToCart(ID, Index) {
                                                var cookie = getCookie('CodDep');
                                                if (cookie != null && cookie != '') {
                                                    //LoadingPanel.Show();
                                                    var ValoreInput = document.getElementById(ID).value;
                                                    var InputEdit = document.getElementById(ID);
                                                    console.log('ValoreInput ' + ValoreInput + ' InputEdit ' + InputEdit);
                                                    var Incremento = "1";
                                                    if (ValoreInput != "" && ValoreInput != "." && ValoreInput != 0) {
                                                        if (ControllaMultiplo(ValoreInput, Incremento)) {
                                                            AggiungiAlCarrello_Callback.PerformCallback(Index + ";" + ValoreInput);
                                                        }
                                                        else {
                                                            document.getElementById(ID).value = Incremento;
                                                            showNotificationErrortoastr("Caratteri non ammessi");
                                                        }
                                                    }
                                                    else {
                                                        showNotificationErrortoastr("Quantità deve essere > 0");
                                                    }
                                                } else {
                                                    console.log("valore cookie " + cookie);
                                                    showNotificationErrortoastr("Selezionare prima un deposito");
                                                }
                                            }

                                        </script>
                                </div>
                            </div>

                            <%--                             
                                <asp:LinkButton ID="ScopriDiPiu_LinkBt" runat="server" CommandName="SelectProduct" Visible="false">
                                   
                                    <div class="button style-10" style="padding-bottom: 10px !important" role="presentation">
                                    Scopri di più ></div>
                                </asp:LinkButton>--%>
                            <%-- <asp:LoginView ID="LoginViewEdit" runat="server">
                                <AnonymousTemplate>
                                </AnonymousTemplate>
                                <LoggedInTemplate>
                                </LoggedInTemplate>
                                <RoleGroups>
                                    <asp:RoleGroup Roles="Administrator">
                                        <ContentTemplate>

                                            <asp:LinkButton ID="LinkButton2" runat="server" Visible="false" Text="" CommandName="AddToCart" class="button style-50" href='<%# GetUrlAddPromo((string)Eval("ProductCod"), (int)Eval("Fittizio"))%>'>Associa Promo ></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton1" runat="server" Visible="false" Text="" CommandName="AddToCart" class="button style-51" href='<%# GetUrlEditProd((string)Eval("ProductCod"), (int)Eval("Fittizio"))%>'>Modifica Prodotto ></asp:LinkButton>
                                            <asp:Panel ID="PromoPanel2" runat="server" Visible='<%# Eval("PromoStatus")%>'>
                                            </asp:Panel>
                                        </ContentTemplate>
                                    </asp:RoleGroup>
                                </RoleGroups>
                            </asp:LoginView>--%>
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
    </div>

    <style>
        @media screen and (max-width: 440px) {
            .dxpcLite_Office365 .dxpc-header .dxpc-closeBtn, .dxpcLite_Office365 .dxpc-header .dxpc-maximizeBtn, .dxpcLite_Office365 .dxpc-header .dxpc-collapseBtn, .dxpcLite_Office365 .dxpc-header .dxpc-refreshBtn, .dxpcLite_Office365 .dxpc-header .dxpc-pinBtn {
                margin-right: 330px !important
            }
        }
    </style>

    <%--   <asp:SqlDataSource runat="server" ID="InsAtleta_Sql" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' InsertCommand="Atleta_Insert" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="IDContatto" Type="Int32" />
            <asp:Parameter Name="CategoryID" Type="Int32" />
            <asp:Parameter Name="InsertAtleta" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>


    <dx:ASPxCallback runat="server" ID="Vaialprofilo_Callback" ClientInstanceName="Vaialprofilo_Callback" OnCallback="Vaialprofilo_Callback_Callback">
        <ClientSideEvents BeginCallback="function(s,e){LoadingPanel.Show();}" />
    </dx:ASPxCallback>--%>



    <%-- <asp:SqlDataSource runat="server" ID="Giorni_Sql" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="GiorniArticolo_Get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="ProductIdSession" Name="ProductID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Text="Caricamento in corso..." Modal="true"></dx:ASPxLoadingPanel>
    <dx:ASPxCallback runat="server" ID="AggiungiAllaWishlistSubCatego_Callback" ClientInstanceName="AggiungiAllaWishlistSubCatego_Callback" OnCallback="AggiungiAllaWishlistSubCatego_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Wishlist_Popup_callbackPnl.PerformCallback();showNotificationtoastr();}" />
    </dx:ASPxCallback>

    <dx:ASPxCallback runat="server" ID="AggiungiAllaWishlist_Callback" ClientInstanceName="AggiungiAllaWishlist_Callback" OnCallback="AggiungiAllaWishlist_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Wishlist_Popup_callbackPnl.PerformCallback();LoadingPanel.Hide();showNotificationtoastr();  }" />
    </dx:ASPxCallback>

    <dx:ASPxCallback runat="server" ID="AggiungiAlCarrello_Callback" ClientInstanceName="AggiungiAlCarrello_Callback" OnCallback="AggiungiAlCarrello_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){PopupCarrello_callbackPnl.PerformCallback();LoadingPanel.Hide();showNotificationtoastr();  }" />
    </dx:ASPxCallback>

    <%--  <asp:SqlDataSource ID="AtletiAssociati_SqlDt" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Contatti.IDContatto, Contatti.Nome, Contatti.Cognome, Contatti.Data_Nascita, Contatti.Email, Contatti.Telefono, Contatti.UserId, Contatti_ruolo.Cod_Ruolo, Contatti_ruolo.ID, Categorie.Desc_Categoria, derivedtbl_1.GiorniRichiesti, derivedtbl_1.GiorniRichiestiFlag, CASE WHEN Contatti.Contatto_Status <> 2 THEN 0 ELSE 1 END AS Contatto_Status, CASE WHEN Contatti.Contatto_Status <> 2 THEN 1 ELSE 0 END AS AnagraficaShow FROM Contatti_ruolo RIGHT OUTER JOIN Categorie RIGHT OUTER JOIN Contatti INNER JOIN Atleti ON Contatti.IDContatto = Atleti.IDContatto ON Categorie.IDCategoria = Atleti.Categoria ON Contatti_ruolo.IDParente = Contatti.IDContatto CROSS JOIN (SELECT GiorniRichiesti, GiorniRichiestiFlag FROM SHP_Product WHERE (ProductID = @ProductID)) AS derivedtbl_1 WHERE (Contatti_ruolo.IDContatto = @IDContatto)">
        <SelectParameters>
            <asp:SessionParameter SessionField="ProductIdSession" Name="ProductID" Type="Int32"></asp:SessionParameter>
            <asp:ControlParameter ControlID="IDContatto_HField" PropertyName="Value" Name="IDContatto"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>--%>

    <asp:ObjectDataSource ID="COMM_ProductsByCategoryID_Get_ObjectDS" runat="server" SelectMethod="ProductsByCategoryID_COMM_Get_DTB"
        TypeName="INTRA.ShopRM.AppCode.SHP_Product_Responsive" OnSelecting="ProductsByCategoryID_COMM_Get_Selecting">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Cat" Name="CategoryId" Type="Int32"></asp:QueryStringParameter>

        </SelectParameters>
    </asp:ObjectDataSource>

</div>
<%--<asp:ObjectDataSource ID="ALLPromoObjectDS" runat="server"
    SelectMethod="GetSHPAllProductInPromoLocalDT_CAT" TypeName="SHP_Product"></asp:ObjectDataSource>--%>

<asp:ObjectDataSource ID="COMM_ProdottiInPromo_ObjectDS" runat="server" SelectMethod="ProdottiInPromo_DTS"
    TypeName="INTRA.ShopRM.AppCode.SHP_Product_Responsive"></asp:ObjectDataSource>
<asp:ObjectDataSource ID="COMM_ProductObjectDS" runat="server" SelectMethod="ProdottoDettGetdDT"
    TypeName="INTRA.ShopRM.AppCode.SHP_Product_Responsive">
    <SelectParameters>
        <asp:QueryStringParameter Name="ProductId" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<%--<asp:ObjectDataSource ID="AllProducts_COMM_Get_DTB_FilterTags_ObjectDS" runat="server" SelectMethod="AllProducts_COMM_Get_DTB_FilterTags"
    TypeName="INTRA.ShopRM.AppCode.SHP_Product_Responsive">
    <SelectParameters>
        <asp:QueryStringParameter Name="Filter" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>--%>

<%--<asp:ObjectDataSource ID="AdvancedSearch" runat="server" SelectMethod="GetSHPProductInPromoDT"
    TypeName="PLS_SHP_Product" OnSelecting="ProductObjectDS_Selecting"></asp:ObjectDataSource>
<asp:ObjectDataSource ID="COMM_AdvancedSearchV2ObjectDS" runat="server" SelectMethod="AllProducts_COMM_Get_DTB"
    TypeName="INTRA.ShopRM.AppCode.SHP_Product_Responsive" OnSelecting="COMM_AdvancedSearchV2ObjectDS_Selecting"></asp:ObjectDataSource>
--%>

<%--<script src="../assets/js/jquery-3.2.1.min.js"></script>
<link href="../content/toastr.css" rel="stylesheet" />
<script src="../assets/js/toastr/toastr.js"></script>--%>

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
    function Notify(msg, title, type, clear, pos, sticky) {
        toastr.options.positionClass = "toast-bottom-right";
        toastr.options.positionClass = "toast-bottom-left";
        toastr.options.positionClass = "toast-top-right";
        toastr.options.positionClass = "toast-top-left";
        toastr.options.positionClass = "toast-bottom-full-width";
        toastr.options.positionClass = "toast-top-full-width";
        options = {
            tapToDismiss: true,
            toastClass: 'toast',
            containerId: 'toast-container',
            debug: false,
            fadeIn: 300,
            fadeOut: 1000,
            extendedTimeOut: 1000,
            iconClass: 'toast-info',
            positionClass: 'toast-top-right',
            timeOut: 5000, // Set timeOut to 0 to make it sticky
            titleClass: 'toast-title',
            messageClass: 'toast-message'
        }


        if (clear == true) {
            toastr.clear();
        }
        if (sticky == true) {
            toastr.tapToDismiss = true;
            toastr.timeOut = 5000;
        }

        toastr.options.onclick = function () {
            //alert('You can perform some custom action after a toast goes away');
        }
        //"toast-top-left";
        toastr.options.positionClass = pos;
        if (type.toLowerCase() == 'info') {
            toastr.options.timeOut = 1000;
            toastr.tapToDismiss = true;
            toastr.info(msg, title);
        }
        if (type.toLowerCase() == 'success') {
            toastr.options.timeOut = 1500;
            toastr.success(msg, title);
        }
        if (type.toLowerCase() == 'warning') {
            toastr.options.timeOut = 3000;
            toastr.warning(msg, title);
        }
        if (type.toLowerCase() == 'error') {
            toastr.options.timeOut = 10000;
            toastr.error(msg, title);
        }
    }

    function HightLightKeywords() {
        var container = document.getElementById("result");
        var keywords = new Array();
            <%  
    // This is C# code runs in server side.
    for (int i = 0; i < keywords.Count; i++)
    {
        Response.Write(string.Format("keywords['{0}'] = '{1}';", i, keywords[i]));
    }
            %>
        for (var i = 0; i < keywords.length; i++) {
            var a = new RegExp(keywords[i], "igm");
            //container.innerHTML = container.innerHTML.replace(a, "<span style='background:#FF0;'>" + keywords[i] + "</span>");
        }
    }
    HightLightKeywords();
</script>

