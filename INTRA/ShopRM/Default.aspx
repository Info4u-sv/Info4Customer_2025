<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="INTRA.ShopRM.Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <style>
        .BadgeBtn {
            background: transparent !important;
            color: #fff !important;
            font-size: medium !important;
            padding: 4px !important;
            margin: 0px !important;
            font-size: large !important;
            top: 0 !important;
        }

        .btn-default {
            background-color: #0055A6 !important;
            color: white !important;
        }

        .heading-article {
            margin-bottom: 0px !important;
        }

        .dxdvItem_Office365 {
            padding: 0px !important;
            padding-top: 10px !important;
        }

        .dxcvTable_Office365 {
            padding-left: 0px !important;
            padding-right: 0px !important;
        }

        .entry {
            height: 40px !important;
            line-height: 35px !important;
            width: 40px !important;
        }

            .entry.number {
                min-width: 52px !important;
            }

        .quantity-selector .entry {
            height: 40px;
            /* line-height: 37px;*/
            width: 40px;
            font-size: 30px !important;
        }

        .list-view {
            margin: 0px !important;
        }

        .quantity-selector {
            margin-bottom: 0px !important;
        }

        @media (max-width: 480px) {
            .col-xs-12 {
                width: auto !important;
            }

            .input-group.quantity-selector.detail-info-entry {
                margin-right: 40px !important;
            }

            .input-group-addon {
                padding: 3px 8px !important;
            }

            .list-view .product-slide-entry {
                max-width: 390px !important;
            }
        }
    </style>
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
            var cookie = getCookie('U_Token');
            if (cookie != null && cookie != '') {
                window.location.href = '/ShopRM/Deposito/Deposito_Dett.aspx?CodDep=' + cookie.replace('U_Token=', '');
            } else {
                showNotificationErrortoastr("Selezionare prima un deposito");
            }
        }
    </script>


    <%--<a href="#" id="test-link">Clicca qui</a>--%>
    <p id="result"></p>
    <script>
        // Variabile per contare i click
        let clickCount = 0;

        // Variabile per tracciare l'ultimo tempo del click
        let lastClickTime = 0;

        // Imposta il limite di tempo per considerare un doppio click (in millisecondi)
        const doubleClickThreshold = 500; // 500ms

        // Funzione per il controllo del clic
        function handleClick(event) {
            // Preveniamo l'azione di default per testare
            event.preventDefault();

            // Aggiorna il contatore
            clickCount += 1;

            // Ottieni il tempo corrente
            const currentTime = new Date().getTime();

            // Controlla se il clic è avvenuto entro la soglia di doppio clic
            if (currentTime - lastClickTime < doubleClickThreshold) {
                document.getElementById('result').innerText = "Doppio clic rilevato!";
            } else {
                document.getElementById('result').innerText = `Numero di click: ${clickCount}`;
            }

            // Aggiorna l'ultimo tempo del clic
            lastClickTime = currentTime;
        }

        // Aggiungi il listener al link
        document.getElementById('test-link').addEventListener('click', handleClick);
    </script>


    <div class="mozaic-banners-wrapper type-2 no-padding">
        <div class="row">
            <asp:ListView ID="ListViewBrandBox" runat="server" DataKeyNames="CategoryID"
                ItemPlaceholderID="ItemContainer" DataSourceID="GenericSqlDS1">
                <LayoutTemplate>
                    <asp:PlaceHolder ID="ItemContainer" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="banner-column col-md-3 col-sm-6">
                        <a class="mozaic-banner-entry type-3" style="background-image: Url(<%# Page.ResolveUrl(Eval("PictureUrl").ToString())%>);" href="Categorie_Merceologiche.aspx?Set=<%# Eval("Settore") %>">
                            <span class="mozaic-banner-content">
                                <span class="subtitle"><%# Eval("TitPiccoloBoxHomeP") %></span>
                                <span class="title"><%# Eval("TitGrandeBoxHomeP") %></span>
                                <%--                    <span class="description">Visita la Sezione</span>--%>
                            </span>
                        </a>
                    </div>
                    <%--   <%# GetDivView((int)Eval("BrandId"), (-2), (int)Container.DataItemIndex, (string)Eval("ImageUrl"), (string)Eval("DestinationUrl"))%>--%>
                </ItemTemplate>
                <EmptyDataTemplate>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
        <div class="row" style="margin-top: 20px;">
            <div class="col-lg-3 col-md-3 col-md-6 col-sm-12 col-xs-12" style="margin-bottom: 20px; padding-left: 0px !important; padding-right: 0px !important; width: 100% !important">
                <dx:BootstrapButton runat="server" ID="BootstrapButton2" Width="100%" Badge-CssClass="BadgeBtn" AutoPostBack="false" CssClasses-Control="btn btn-lg btn-custom-padding btn-default">
                    <Badge Text="Carrello" IconCssClass="fa fa-shopping-cart" />
                    <ClientSideEvents Click="GoToCart" />
                </dx:BootstrapButton>
            </div>
        </div>
    </div>
    <script>                                                   


        var postponedCallbackRequired = false;

        function OnEndCallbackCart(s, e) {
            if (postponedCallbackRequired) {
                AggiungiAlCarrello_Callback.PerformCallback();
                postponedCallbackRequired = false;
            }
            PopupCarrello_callbackPnl.PerformCallback();
            LoadingPanel.Hide();
            showNotificationtoastr();
        }


        function AddToCart(ID, Index) {
            if (AggiungiAlCarrello_Callback.InCallback())
                postponedCallbackRequired = true;
            else {
                var cookie = getCookie('CodDep');
                if (cookie != null && cookie != '') {
                    //LoadingPanel.Show();
                    var ValoreInput = document.getElementById(ID).value;
                    var InputEdit = document.getElementById(ID);
                    console.log('ValoreInput ' + ValoreInput + ' InputEdit ' + InputEdit);
                    var Incremento = "1";
                    if (ValoreInput != "" && ValoreInput != "." && ValoreInput != 0) {
                        if (ControllaMultiplo(ValoreInput, Incremento)) {

                            setTimeout(function () {
                                AggiungiAlCarrello_Callback.PerformCallback(Index + ";" + ValoreInput);
                            }, 100);  // Ritardo di 100ms
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
                    showNotificationErrortoastr("Selezionare prima un deposito");
                }
            }
        }

    </script>

    <%--    <dx:ASPxCallback runat="server" ID="AggiungiAlCarrello_Callback" ClientInstanceName="AggiungiAlCarrello_Callback" OnCallback="AggiungiAlCarrello_Callback_Callback">
        <ClientSideEvents EndCallback="OnEndCallbackCart" />
    </dx:ASPxCallback>--%>

    <asp:SqlDataSource ID="GenericSqlDS1" runat="server"
        ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>'
        SelectCommand="SELECT U_SHP_Category.TitPiccoloBoxHomeP, U_SHP_Category.TitGrandeBoxHomeP, ISNULL(U_SHP_Picture.PictureUrl, '/PUBLIC/CategoCatalogo/MieleGenericCategory.jpg') AS PictureUrl, U_SHP_Category.Published, U_SHP_Category.ParentCategoryID, U_SHP_Category.ShowOnHomePage, U_SHP_Category.CategoryID, U_SHP_Category.DisplayOrder, U_SHP_Category.Settore FROM U_SHP_Picture RIGHT OUTER JOIN U_SHP_Category ON U_SHP_Picture.PictureID = U_SHP_Category.PictureID WHERE (U_SHP_Category.ShowOnHomePage = 1) AND (U_SHP_Category.ParentCategoryID = 0) AND (U_SHP_Category.Published = 1) AND (U_SHP_Category.DisplayName IS NOT NULL) ORDER BY U_SHP_Category.DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Deposito_Test_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT TabDep.CodDep, TabDep.Descrizione, TabDep.CodCli, Clienti.Denom, TabDep.U_I_NotePosizione, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_Token, TabDep.U_UltimoControllo_Inventario FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE TabDep.U_Token = REPLACE(@U_Token,'U_Token=','')">
        <SelectParameters>
            <asp:CookieParameter CookieName="U_Token" Name="U_Token"></asp:CookieParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Inventario_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_Inventario_Deposito.CodArt, U_Inventario_Deposito.Qta_Min, Articoli.Descrizione, TabCatM.Descrizione AS Categoria, U_Inventario_Deposito.ID, ISNULL(SaldiMag.Carichi - SaldiMag.Scarichi, 0) AS Giacenza, Articoli.Misura FROM U_Inventario_Deposito INNER JOIN Articoli ON U_Inventario_Deposito.CodArt = Articoli.CodArt INNER JOIN TabCatM ON Articoli.CodCat = TabCatM.CodCat INNER JOIN TabDep ON U_Inventario_Deposito.CodDep = TabDep.CodDep LEFT OUTER JOIN SaldiMag ON U_Inventario_Deposito.CodDep = SaldiMag.DsSaldo AND U_Inventario_Deposito.CodArt = SaldiMag.CodArt WHERE (TabDep.U_Token = REPLACE(@U_Token, 'U_Token=', '')) AND (ISNULL(SaldiMag.Carichi - SaldiMag.Scarichi, 0) < U_Inventario_Deposito.Qta_Min)">
        <SelectParameters>
            <asp:CookieParameter CookieName="U_Token" Name="U_Token"></asp:CookieParameter>

        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
