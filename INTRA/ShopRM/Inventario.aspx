<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Inventario.aspx.cs" Inherits="INTRA.ShopRM.Inventario" %>

<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>
<%@ Register Src="~/ShopRM/TecZone/Controls/LeftMenuTecnico.ascx" TagPrefix="uc1" TagName="LeftMenuTecnico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function Add(ID, Index, IDRiga) {
            var cookie = getCookie('CodDep');
            if (cookie != null && cookie != '') {
                //LoadingPanel.Show();
                var ValoreInput = document.getElementById(ID).value;
                var InputEdit = document.getElementById(ID);
                var RigaEdit = document.getElementById(IDRiga);
                console.log('ValoreInput ' + ValoreInput + ' InputEdit ' + InputEdit);
                var Incremento = "";
                if (ValoreInput != "" && ValoreInput != "." && (ValoreInput / 1) == ValoreInput) {

                    Aggiungi_Invetario_Callback.PerformCallback(Index + ";" + ValoreInput);
                    RigaEdit.classList.remove("non-controllato");
                    RigaEdit.classList.add("controllato");
                    var Collection = document.getElementsByClassName("non-controllato");
                    Articoli_Lbl.SetText("Articoli da Controllare: " + Collection.length);
                    if (Collection.length == 0) {
                        Conferma_Inventario_Btn.SetEnabled(true);
                        document.getElementsByClassName("articoli_lbl")[0].style.background = "#5cb85c";

                    }
                }
                else {
                    document.getElementById(ID).value = Incremento;
                    showNotificationErrortoastr("Caratteri non ammessi");
                }

            } else {
                console.log("valore cookie " + cookie);
                showNotificationErrortoastr("Selezionare prima un deposito");
            }
        }
        function Articoli_Lbl_Init() {
            var Collection = document.getElementsByClassName("non-controllato");
            Articoli_Lbl.SetText("Articoli da Controllare: " + Collection.length);
        }
        function Conferma_Inventario() {
            if (confirm("Conferma Inventario. Se confermi verrà inviata un email al responsabile con il riepilogo.")) {
                Invio_Email_Callback.PerformCallback();
            }
        }
        function Invio_Email_Callback_EndCallback() {
            LoadingPanel.Hide();
            showNotificationtoastr();
            var mioCookie = getCookie('U_Token');

            if (mioCookie) {
                openwindow("ShopRM/Deposito/Deposito_Dett.aspx?CodDep=" + mioCookie.replace('U_Token=', ''));
            }

        }
        function openwindow(path) {
            var getUrl = window.location;
            var baseUrl = getUrl.protocol + "//" + getUrl.host + "/";
            window.location = baseUrl + path;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
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
            font-size: 30px !important;
        }

            .quantity-selector .entry.number {
                padding: 0;
            }

        .cart-qta-custom {
            height: 38px;
        }

        .BadgeBtn-just-icon {
            background: transparent !important;
            color: #fff !important;
            font-size: small !important;
            padding: 0px !important;
            margin: 0px !important;
            font-size: medium !important;
            top: 0 !important;
        }

        .non-controllato {
            background-color: lightcoral;
            color: black;
        }

        .controllato {
            background-color: lightgreen;
            color: black;
        }

        .entry.number-minus-custom:hover {
            background: var(--main-primary-color) !important;
        }

        .entry.number-plus-custom:hover {
            background: var(--main-primary-color) !important;
        }

        .entry {
            height: 40px !important;
            line-height: 35px !important;
            width: 40px !important;
        }

            .entry.number {
                min-width: 52px !important;
            }

        .dxcvTable_Office365 {
            padding-left: 0px !important;
            padding-right: 0px !important;
        }

        .dxdvItem_Office365 {
            padding: 0px !important;
            padding-top: 10px !important;
        }

        .heading-article {
            margin-bottom: 0px !important;
        }

        .dxcvControl_Office365 .dxcvSeparator_Office365, .dxcvControl_Office365 .dxcvSeparator_Office365 div {
            height: 0px !important;
        }

        .articoli_lbl {
            cursor: auto;
        }
    </style>
    <Banner:PlusDisplayBannerImgRandom runat="server" ID="PlusDisplayBannerImgRandom" Visible="false" />
    <dx:ASPxLoadingPanel ID="LoadingPanel2" ClientInstanceName="LoadingPanel2" runat="server" Modal="true" Text="Salvataggio Dati in Corso..."></dx:ASPxLoadingPanel>

    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column" style="padding-left: 5px; padding-right: 0px !important;">
            <uc1:LeftMenuTecnico runat="server" ID="LeftMenuCustomer" />
        </div>
        <div class="col-md-9 col-sm-12 information-entry">

            <div class="heading-article" style="padding-top: 10px;">
                <h2 class="title">Inventario Deposito</h2>
            </div>
            <dx:ASPxDataView runat="server" ID="Deposito_Test" ClientInstanceName="Deposito_Test" DataSourceID="Deposito_Test_Dts" Width="100%" ContentStyle-Paddings-PaddingLeft="0px" Paddings-PaddingLeft="0px">
                <SettingsTableLayout RowsPerPage="1" />
                <SettingsTableLayout ColumnCount="1" />
                <ItemStyle Height="10px" />
                <ItemTemplate>
                    <span style='display: <%# string.IsNullOrEmpty(Eval("CodDep") as string) ? "none" : "block" %>; color: black;'>
                        <div class="col-lg-12" style="padding-left: 0px !important;">
                            <span style="font-size: 18px">Deposito: <b><%# Eval("CodDep") %> <%# Eval("Denom") %></b></span>
                        </div>
                        <div class="col-lg-12" style="padding-left: 0px !important;">
                            <span style="font-size: 18px">Indirizzo: <b><%# Eval("U_I_Ind") %> <%# Eval("U_I_Loc") %> <%# Eval("U_I_Cap") %>, <%# Eval("Descrizione") %></b></span>
                        </div>
                        <div class="col-lg-12" style="padding-left: 0px !important;">
                            <span style="font-size: 18px">Ultimo Censimento Deposito: <b><%# Eval("U_UltimoControllo_Inventario") != DBNull.Value ? Convert.ToDateTime(Eval("U_UltimoControllo_Inventario")).ToString("g") : "Non Controllato"%></b></span>
                        </div>
                    </span>
                </ItemTemplate>
            </dx:ASPxDataView>
            <%--<div class="col-md-3 col-lg-3 col-sm-12" style="float: right; padding-top: 10px; padding-bottom: 10px;">
                    <dx:BootstrapButton runat="server" ID="Conferma_Inventario_Btn" ClientInstanceName="Conferma_Inventario_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                        <Badge IconCssClass="fa fa-save" Text="Conferma Inventario" />
                        <SettingsBootstrap RenderOption="Success" />

                    </dx:BootstrapButton>
                </div>--%>
            <div class="col-md-6 col-lg-6 col-sm-12" style=" text-align: end; float:right;">
                <div class="col-md-6 col-lg-6 col-sm-12" style="padding-top:10px">
                    <dx:BootstrapButton runat="server" ID="Conferma_Inventario_Btn" ClientInstanceName="Conferma_Inventario_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-primary" ClientEnabled="false">
                        <Badge IconCssClass="fa fa-save" Text="INVIA" />
                        <SettingsBootstrap RenderOption="Success" Sizing="Large" />
                        <ClientSideEvents Click="Conferma_Inventario" />
                    </dx:BootstrapButton>
                </div>
                <div class="col-md-6 col-lg-6 col-sm-12" style="padding-top:10px; padding-right: 10px">
                    <dx:ASPxLabel runat="server" Text="Articoli da Controllare: 0" BackColor="IndianRed" Font-Bold="true" ForeColor="White" CssClass="btn btn-primary btn-lg articoli_lbl" Border-BorderColor="Transparent" ID="Articoli_Lbl" ClientInstanceName="Articoli_Lbl">
                        <ClientSideEvents Init="Articoli_Lbl_Init" />
                    </dx:ASPxLabel>
                </div>

            </div>
            <div class="row shop-grid list-view">

                <dx:ASPxCardView ID="ShopList1" ClientInstanceName="shopList1" runat="server" Width="100%" Paddings-Padding="0" DataSourceID="Inventario_Dts" AutoGenerateColumns="False" KeyFieldName="ID">
                    <Settings VerticalScrollableHeight="600" />
                    <SettingsPager EndlessPagingMode="OnScroll" Mode="EndlessPaging">

                        <SettingsTableLayout ColumnCount="1" RowsPerPage="8" />
                    </SettingsPager>
                    <Templates>
                        <Card>
                            <div class="col-md-3 col-sm-3 shop-grid-item non-controllato" id="<%# Eval("ID") + "_Riga" %>" style="padding-top: 10px !important; margin: 0px !important; padding-left: 10px !important; padding-right: 10px !important;">
                                <div class="product-slide-entry" style="margin: 0px !important;">

                                    <div class="col-lg-7 col-md-6 col-sm-12 col-xs-12" style="padding-left: 10px !important;">
                                        <div class="inline">
                                            <asp:Label ID="DisplayNameLabel" Font-Size="Large" runat="server" Text='<%# Eval("CodArt") %>' Font-Bold="true" />
                                            <p style="font-size: large; display: inline;">- <%# Eval("Descrizione") %> </p>
                                        </div>

                                        <div class="tag" style="margin-bottom: 10px; color: black !important">
                                            <asp:Label ID="ProductCodLabel" runat="server" Font-Size="Medium" Text='<%# string.Format("CATEGORIA: {0}",Eval("DescrCatM")) %>' />
                                        </div>
                                    </div>

                                    <div class="col-lg-5 col-md-6 col-sm-12 col-xs-12">

                                        <div class="input-group" style="float: right">
                                            <%--  insert carrello--%>
                                            <div class="input-group quantity-selector detail-info-entry">
                                                <span class="input-group-addon">Min: <%#Eval("Qta_Min") %></span>
                                                <span class="input-group-addon"><%#Eval("Misura") %></span>
                                                <div class="entry number-minus-custom" style="background-color: white;">&nbsp;</div>
                                                <div class="entry number" style="border: 0px">
                                                    <input style="height: 100% !important;" class="info4u-custom-quantity" oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" value="" min="0" max="999999" id="<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>">
                                                </div>
                                                <div class="entry number-plus-custom" style="background-color: white;">&nbsp;</div>
                                            </div>
                                            <span class="input-group-btn">
                                                <a class="btn btn-primary info4u-custom-cart" style="color: #ffffff;" href='javascript: Add("<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>",<%# Container.VisibleIndex %>,"<%# Eval("ID") + "_Riga" %>");'>
                                                    <span id="addCart_DS4608SR7U2100" title="Salva la quantità nell'inventario">
                                                        <i class="fa fa-save"></i>
                                                        <dx:ASPxLabel runat="server" Text="SALVA" ForeColor="White"></dx:ASPxLabel>
                                                    </span>
                                                </a>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </Card>
                    </Templates>
                    <Columns>
                        <dx:CardViewTextColumn FieldName="CodDep" VisibleIndex="0"></dx:CardViewTextColumn>
                        <dx:CardViewTextColumn FieldName="CodArt" VisibleIndex="1"></dx:CardViewTextColumn>
                        <dx:CardViewTextColumn FieldName="Qta_Min" VisibleIndex="2"></dx:CardViewTextColumn>
                        <dx:CardViewTextColumn FieldName="Descrizione" VisibleIndex="3"></dx:CardViewTextColumn>
                        <dx:CardViewTextColumn FieldName="Misura" VisibleIndex="4"></dx:CardViewTextColumn>
                        <dx:CardViewTextColumn FieldName="DescrCatM" VisibleIndex="5"></dx:CardViewTextColumn>
                        <dx:CardViewTextColumn FieldName="ID" ReadOnly="True" Visible="False"></dx:CardViewTextColumn>
                    </Columns>

                    <Styles>
                        <Card Border-BorderWidth="0"></Card>
                        <Table Border-BorderWidth="0"></Table>
                    </Styles>
                    <CardLayoutProperties Styles-Disabled-Border-BorderWidth="0"></CardLayoutProperties>
                </dx:ASPxCardView>
            </div>
        </div>
    </div>
    <dx:ASPxCallback runat="server" ID="Invio_Email_Callback" ClientInstanceName="Invio_Email_Callback" OnCallback="Invio_Email_Callback_Callback">
        <ClientSideEvents EndCallback='Invio_Email_Callback_EndCallback' BeginCallback="function(s,e){LoadingPanel.Show();}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="Aggiungi_Invetario_Callback" ClientInstanceName="Aggiungi_Invetario_Callback" OnCallback="Aggiungi_Invetario_Callback_Callback">
        <ClientSideEvents BeginCallback="function(s,e){LoadingPanel2.Show();}" EndCallback="function(s,e){LoadingPanel2.Hide();showNotificationtoastr();  }" />
    </dx:ASPxCallback>
    <asp:SqlDataSource runat="server" ID="Inventario_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_Inventario_Deposito.CodDep, U_Inventario_Deposito.CodArt, U_Inventario_Deposito.Qta_Min, Articoli.Descrizione, Articoli.Misura, TabCatM.Descrizione AS DescrCatM, U_Inventario_Deposito.ID FROM U_Inventario_Deposito INNER JOIN Articoli ON U_Inventario_Deposito.CodArt = Articoli.CodArt INNER JOIN TabCatM ON Articoli.CodCat = TabCatM.CodCat WHERE (U_Inventario_Deposito.CodDep = REPLACE(@CodDep, 'CodDep=', ''))">
        <SelectParameters>
            <asp:CookieParameter CookieName="CodDep" Name="CodDep"></asp:CookieParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Deposito_Test_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT TabDep.CodDep, TabDep.Descrizione, TabDep.CodCli, Clienti.Denom, TabDep.U_I_NotePosizione, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_Token, TabDep.U_UltimoControllo_Inventario FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE (TabDep.CodDep = REPLACE(@CodDep, 'CodDep=', ''))">
        <SelectParameters>
            <asp:CookieParameter CookieName="CodDep" Name="CodDep"></asp:CookieParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
