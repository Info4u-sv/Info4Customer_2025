<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Deposito_Dett.aspx.cs" Inherits="INTRA.ShopRM.Deposito.Deposito_Dett" %>

<%@ Register Src="~/ShopRM/TecZone/Controls/LeftMenuTecnico.ascx" TagPrefix="uc1" TagName="LeftMenuTecnico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .edit {
            background-color: #fd8204 !important;
            /* color: #fd8204;*/
        }

        .icon-edit::before {
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            content: "\f303";
            /* margin-left: 5px;
    margin-right: 5px;*/
        }

        .BadgeBtn-just-icon {
            background: transparent !important;
            color: #fff !important;
            font-size: medium !important;
            padding: 4px !important;
            margin: 0px !important;
            font-size: large !important;
            top: 0 !important;
        }

        .action-btn {
            font-size: large !important;
            color: white !important;
            text-align: center;
            cursor: pointer;
            padding: 2px 6px 2px 6px !important;
            /* max-width: 40px;*/
            margin: 0 3px 0 3px;
            box-shadow: none;
        }

        .icon4u::before {
            display: inline-block;
            font-style: normal;
            font-variant: normal;
            text-rendering: auto;
            -webkit-font-smoothing: antialiased;
        }

        .cancel {
            /* color: #f44336;*/
            background-color: #696e72 !important;
        }

        .icon-cancel::before {
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            content: "\f057";
            /* margin-left: 5px;
    margin-right: 5px;*/
        }

        .update {
            /* color: #f44336;*/
            background-color: #4caf50 !important;
        }

        .icon-update::before {
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            content: "\f0c7";
            /* margin-left: 5px;
    margin-right: 5px;*/
        }

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

        .car_css {
            padding-right: 8px;
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

        @media (min-width: 769px) {
            .list-view .product-slide-entry {
                margin-left: 0px !important;
            }
        }
    </style>
    <script>
        function test() { alert("Test"); }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column" style="padding-left: 5px; padding-right: 0px;">
            <uc1:LeftMenuTecnico runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article" style="padding-top: 10px;">
                <h2 class="title">Dettaglio Deposito</h2>
            </div>
            <div style="padding-left: 0px !important;">
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
                <div class="heading-article" style="padding-top: 10px;">
                    <h2 class="title">Articoli</h2>
                </div>
                <div class="row shop-grid list-view" style="padding-top: 5px !important;">

                    <dx:ASPxCardView ID="ShopList1" ClientInstanceName="shopList1" runat="server" Width="100%" Paddings-Padding="0" DataSourceID="Inventario_Dts" AutoGenerateColumns="False" KeyFieldName="ID">
                        <Settings VerticalScrollableHeight="400" />
                        <SettingsPager EndlessPagingMode="OnScroll" Mode="EndlessPaging">

                            <SettingsTableLayout ColumnCount="1" RowsPerPage="8" />
                        </SettingsPager>
                        <Templates>
                            <Card>
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="<%# Eval("ID") + "_Riga" %>" style="padding-left: 0px !important;">
                                    <div class="product-slide-entry">

                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 20px !important; padding-right: 20px !important;">
                                            <div class="inline">
                                                <asp:Label ID="DisplayNameLabel" Font-Size="Large" runat="server" Text='<%# Eval("CodArt") %>' Font-Bold="true" />
                                                <p style="font-size: large; display: inline;">- <%# Eval("Descrizione") %></p>
                                            </div>

                                            <div class="tag" style="margin-bottom: 10px; margin-top: 5px; color: black !important">
                                                <asp:Label ID="ProductCodLabel" runat="server" Font-Size="Medium" Text='<%# string.Format("CATEGORIA: {0}",Eval("Categoria")) %>' />
                                            </div>
                                        </div>

                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 20px !important; padding-right: 20px !important;">

                                            <div class="input-group" style="width: 100%;">
                                                <div class="input-group quantity-selector detail-info-entry">
                                                    <span class="input-group-addon"><%#Eval("Misura") %></span>
                                                    <span class="input-group-addon">Scorta Min: <%#Eval("Qta_Min") %></span>
                                                    <span class="input-group-addon" style='color: <%# Convert.ToInt32(Eval("Giacenza")) < Convert.ToInt32(Eval("Qta_Min")) ? "#d43f3a" : "DarkSlateGray" %>;'>Giacenza Effettiva: <%# Eval("Giacenza") %></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 10px; padding-left: 20px !important; padding-right: 20px !important;">

                                            <div class="input-group">
                                                <div class="input-group quantity-selector detail-info-entry">
                                                    <span class="input-group-addon"><%#Eval("Misura") %></span>
                                                    <div class="entry number-minus-custom">&nbsp;</div>
                                                    <div class="entry number" style="border: 0px; padding: 0px !important;">
                                                        <input style="height: 100% !important; border: 1px solid #d43f3a !important;" class="info4u-custom-quantity" oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" value="1" min="1" max="999999" qtaperconf='1' id="<%# "T" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>">
                                                    </div>
                                                    <div class="entry number-plus-custom">&nbsp;</div>

                                                </div>
                                                <span class="input-group-btn">
                                                    <a class="btn btn-danger info4u-custom-cart" style="color: #ffffff;" href='javascript: AggiornaGiacenza("<%# "T" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>",<%# Container.VisibleIndex %>);'>
                                                        <span id="addCart_DS4608SR7U2101" title="Aggiungi l'articolo al carrello">
                                                            <i class="fa fa-trash"></i>
                                                            <dx:ASPxLabel runat="server" Text="TERMINATO" ForeColor="White"></dx:ASPxLabel>
                                                        </span>
                                                    </a>
                                                    <script>
                                                        function AggiornaGiacenza(ID, Index) {
                                                            var ValoreInput = document.getElementById(ID).value;
                                                            var Incremento = "1";
                                                            if (ValoreInput != "" && ValoreInput != "." && ValoreInput != 0) {
                                                                if (ControllaMultiplo(ValoreInput, Incremento)) {
                                                                    AggiornaGiacenza_Callback.PerformCallback(Index + ";" + ValoreInput);
                                                                }
                                                                else {
                                                                    document.getElementById(ID).value = Incremento;
                                                                    showNotificationErrortoastr("Caratteri non ammessi");
                                                                }
                                                            }
                                                            else {
                                                                showNotificationErrortoastr("Quantità deve essere > 0");
                                                            }
                                                        }
                                                    </script>
                                                </span>

                                            </div>
                                        </div>
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 10px; padding-left: 20px !important; padding-right: 20px !important;">

                                            <div class="input-group">
                                                <%--  insert carrello--%>
                                                <div class="input-group quantity-selector detail-info-entry">
                                                    <span class="input-group-addon"><%#Eval("Misura") %></span>
                                                    <div class="entry number-minus-custom" style="width: 40px !important; height: 40px !important; padding: 0px !important;">&nbsp;</div>
                                                    <div class="entry number" style="border: 0px; padding: 0px !important;">
                                                        <input style="height: 100% !important;" class="info4u-custom-quantity" oninput="this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\..*)\./g, '');" value="1" min="1" max="999999" qtaperconf='1' id="<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>">
                                                    </div>
                                                    <div class="entry number-plus-custom" style="width: 40px !important; height: 40px !important; padding: 0px !important;">&nbsp;</div>
                                                </div>
                                                <span class="input-group-btn">
                                                    <a class="btn btn-primary info4u-custom-cart" style="color: #ffffff;" href='javascript: AddToCart("<%# "P" + Eval("CodArt").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>",<%# Container.VisibleIndex %>);'>
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
                                                </span>

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

                <div class="heading-article" style="padding-top: 10px;">
                    <h2 class="title">Ultime 10 Giornate</h2>
                </div>
                <h4 class="title" style="padding-top: 10px !important;">Utente: <%= string.IsNullOrEmpty(Session["UtenteLoggato"] as string) ? "ND" : Session["UtenteLoggato"] as string %></h4>
                <div class="row shop-grid list-view">

                    <dx:ASPxCardView ID="shopList2" ClientInstanceName="shopList2" runat="server" Width="100%" Paddings-Padding="0" DataSourceID="Giornate_Dts" AutoGenerateColumns="False" KeyFieldName="CodDep">
                        <Settings VerticalScrollableHeight="400" />
                        <SettingsPager EndlessPagingMode="OnScroll" Mode="EndlessPaging">

                            <SettingsTableLayout ColumnCount="1" RowsPerPage="10" />
                        </SettingsPager>
                        <Templates>
                            <Card>
                                <div class="col-md-3 col-sm-3 shop-grid-item" id="<%# Eval("CodDep") + "_Riga" %>" style="padding-top: 0px !important; margin: 0px !important; padding-left: 15px !important;">
                                    <div class="product-slide-entry" style="margin: 0px !important;">

                                        <%--<div class="col-lg-8 col-md-6 col-sm-12 col-xs-12">
                                            <div>
                                                <asp:Label ID="DisplayNameLabel" runat="server" Text='<%# Eval("UtenteApertura") %>' Font-Bold="true" />
                                            </div>
                                            <p><%# Eval("Nome") %> <%# Eval("Cognome") %></p>
                                        </div>--%>
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px !important;">
                                            <i class="fa fa-clock-o"></i>Avvio: <span style="color: #0055A6"><%# Convert.ToDateTime(Eval("DataAvvio")).ToString("g") %></span>
                                            <i class="fa fa-clock-o"></i>Fine: <span style="color: #0055A6"><%# Eval("DataFine") != DBNull.Value ? Convert.ToDateTime(Eval("DataFine")).ToString("g") : "ND"%></span>
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
    </div>
    <%--<dx:ASPxCallback runat="server" ID="Invio_Email_Callback" ClientInstanceName="Invio_Email_Callback" OnCallback="Invio_Email_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){showNotificationtoastr();}" />
    </dx:ASPxCallback>--%>
    <dx:ASPxCallback runat="server" ID="AggiungiAlCarrello_Callback" ClientInstanceName="AggiungiAlCarrello_Callback" OnCallback="AggiungiAlCarrello_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){PopupCarrello_callbackPnl.PerformCallback();LoadingPanel.Hide();showNotificationtoastr();  }" />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="AggiornaGiacenza_Callback" ClientInstanceName="AggiornaGiacenza_Callback" OnCallback="AggiornaGiacenza_Callback_Callback">
        <ClientSideEvents EndCallback='function(s,e){var errore = AggiornaGiacenza_Callback.cpError; if(errore){showNotificationErrortoastr("La quantità da togliere deve essere minore alla giacenza effettiva.");} else {sessionStorage.setItem("GiacenzaAggiornata", "1"); 
            var mioCookie = getCookie("U_Token"); 
            window.location.href = "/ShopRM/Deposito/Deposito_Dett.aspx?CodDep=" + mioCookie.replace("U_Token=", "");
            //shopList1.Refresh();
            }}' />
    </dx:ASPxCallback>

    <asp:SqlDataSource runat="server" ID="Inventario_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_Inventario_Deposito.CodArt, U_Inventario_Deposito.Qta_Min, Articoli.Descrizione, TabCatM.Descrizione AS Categoria, U_Inventario_Deposito.ID, ISNULL(SaldiMag.Carichi - SaldiMag.Scarichi, 0) AS Giacenza, Articoli.Misura FROM U_Inventario_Deposito INNER JOIN Articoli ON U_Inventario_Deposito.CodArt = Articoli.CodArt INNER JOIN TabCatM ON Articoli.CodCat = TabCatM.CodCat INNER JOIN TabDep ON U_Inventario_Deposito.CodDep = TabDep.CodDep LEFT OUTER JOIN SaldiMag ON U_Inventario_Deposito.CodDep = SaldiMag.DsSaldo AND U_Inventario_Deposito.CodArt = SaldiMag.CodArt WHERE (TabDep.U_Token = @U_Token)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="CodDep" Name="U_Token"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Giornate_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT TOP (10) U_Giornata_Testata.DataAvvio, U_Giornata_Testata.DataFine, U_Giornata_Testata.UtenteApertura, U_Giornata_Testata.CodDep, TabDep.U_Token, derivedtbl_1.Nome, derivedtbl_1.Cognome, U_Giornata_Status.Status FROM U_Giornata_Testata INNER JOIN TabDep ON U_Giornata_Testata.CodDep = TabDep.CodDep INNER JOIN (SELECT ID, UtenteIntranet, EmailContatto, DataBlocco, Tipologia, Azienda, Scaduto, Nome, Cognome, CodAge, TipoAge, CodCat FROM ADRIANA_SERVIZI_INTRANET.dbo.VIO_Utenti) AS derivedtbl_1 ON U_Giornata_Testata.UtenteApertura = derivedtbl_1.UtenteIntranet INNER JOIN U_Giornata_Status ON U_Giornata_Testata.Status = U_Giornata_Status.ID WHERE (TabDep.U_Token = @U_Token) AND (U_Giornata_Testata.UtenteApertura = @User ) ORDER BY U_Giornata_Testata.DataAvvio DESC">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="CodDep" Name="U_Token"></asp:QueryStringParameter>
            <asp:SessionParameter SessionField="UtenteLoggato" Name="User"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Deposito_Test_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT TabDep.CodDep, TabDep.Descrizione, TabDep.CodCli, Clienti.Denom, TabDep.U_I_NotePosizione, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_Token, TabDep.U_UltimoControllo_Inventario FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE (TabDep.U_Token = @CodDep)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="CodDep" Name="CodDep"></asp:QueryStringParameter>

        </SelectParameters>
    </asp:SqlDataSource>

    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        window.onload = function () {
            var giacenzaAgg = sessionStorage.getItem('GiacenzaAggiornata');
            if (giacenzaAgg == '1') {
                showNotificationtoastr();
                sessionStorage.setItem('GiacenzaAggiornata', '0');
            }
            //    var giornAgg = sessionStorage.getItem('AzioneEseguita');
            //    console.log(giornAgg);
            //    if (giornAgg == '1') {
            //        showNotificationtoastr();
            //        sessionStorage.setItem('AzioneEseguita', '0');
            //    }
        }
    </script>
</asp:Content>
