<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Dettaglio_Macchinari_Cliente.aspx.cs" Inherits="INTRA.ShopRM.Dettaglio_Macchinari_Cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <dx:ASPxHint ID="ASPxHint1" runat="server" TargetSelector=".dx-vam">
        <%--  <ClientSideEvents Showing="ShowHint" />--%>
    </dx:ASPxHint>
    <dx:ASPxHint ID="ASPxHint2" runat="server" TargetSelector=".btn:hover" Content="ccc">
        <%--  <ClientSideEvents Showing="ShowHint" />--%>
    </dx:ASPxHint>
    <style>
        .dxcvControl_Office365 a {
            color: white !important;
            text-decoration: none;
        }

        .sticky {
            position: sticky;
            top: 20px;
            z-index: 5000 !important;
        }

        .dxflGroupBox_Office365 > .dxflGroup_Office365 {
            padding: 0 0px;
            padding-top: 0px;
        }

        .dxflGroupBox_Office365 {
            background-color: white;
            border: none;
            border-bottom-width: 0;
            border-collapse: separate !important;
            overflow: hidden;
        }

        .dxcvTable_Office365,
        .dxcvCard_Office365 {
            border: none;
        }

        /* Nascondi desktop per default, mostra mobile/tablet */
        .desktop-only {
            display: none;
        }

        .mobile-tablet-only {
            display: block;
        }

        /* Desktop styles e visibilità */
        @media (min-width: 993px) {
            .desktop-only {
                display: block;
            }

            .mobile-tablet-only {
                display: none;
            }

            .container-wrapper {
                display: flex;
                flex-direction: row;
                align-items: center;
                gap: 20px;
            }

            .row[style*="margin: 0;"] {
                display: flex !important;
                align-items: center !important;
                flex-wrap: nowrap;
            }

            .info-group {
                flex-direction: column !important;
                align-items: flex-start !important;
                white-space: normal !important;
                width: 130px;
                flex-shrink: 0;
            }

                .info-group > * {
                    white-space: normal !important;
                    width: 100%;
                    text-align: left;
                }

            .cart-group {
                display: flex !important;
                flex-direction: row !important;
                align-items: center !important;
                gap: 10px;
                flex-shrink: 0;
            }

            .qty-cart-container {
                display: flex !important;
                flex-direction: row !important;
                align-items: center !important;
                gap: 8px;
                width: auto;
            }

            .cart-group a.info4u-custom-cart {
                margin-left: 0 !important;
                white-space: nowrap;
                min-width: 45px;
            }

            .qty-cart-container input.info4u-custom-quantity {
                width: 70px;
                text-align: center;
            }
        }

        @media (max-width: 992px) {
            /* Wrapper testo + immagine */
            .text-img-row {
                display: flex !important;
                flex-direction: row !important;
                justify-content: space-between !important;
                align-items: center !important;
                width: 100% !important;
            }

            /* Info group in riga */
            .info-group {
                display: flex !important;
                flex-direction: row !important;
                align-items: center !important;
                gap: 12px; /* spazio tra CProdotto, Expr6 e colore */
                white-space: nowrap !important;
                width: auto; /* lascia che prenda spazio necessario */
            }

                .info-group > * {
                    white-space: nowrap !important;
                    text-align: left !important;
                    width: auto !important;
                }

            /* Immagine a destra */
            .image-group {
                width: 35%;
                display: flex !important;
                justify-content: flex-end !important;
                align-items: center !important;
            }

                .image-group img {
                    max-width: 100%;
                    height: auto;
                }

            /* Qty + carrello sotto */
            .cart-group {
                display: flex !important;
                flex-direction: column !important;
                width: 100% !important;
                align-items: center !important;
                gap: 12px;
                white-space: normal !important;
                margin-top: 12px; /* spazio sopra */
            }

            .dxflGroupCell_Office365 {
                padding: 0 0px;
            }
        }
    </style>
    <%-- inizio formLayout --%>
    <div class="row">
        <div class="col-md-12" style="padding-right: 4px; padding-left: 4px">
            <div class="card">
                <div class="card-content">
                    <div class="card-content">
                        <div class="col-md-6">
                            <dx:ASPxCallbackPanel runat="server" ID="Edit_CallbackPnl_Callback_Cli" ClientInstanceName="Edit_CallbackPnl">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxFormLayout ID="Printer_Edit_Form_Cli" ClientInstanceName="Printer_Edit_Form_Cli" runat="server" DataSourceID="Printer_Edit_Dts_Cli" Width="100%">
                                            <Items>
                                                <dx:LayoutGroup Caption="Gestione Printer" GroupBoxDecoration="None" ColumnCount="1">
                                                    <Items>
                                                        <dx:LayoutGroup ColumnCount="2" ShowCaption="False">
                                                            <Items>
                                                                <dx:LayoutItem FieldName="PhotoBytes" ShowCaption="False" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxBinaryImage ID="Printer_PhotoBytes_View" runat="server" Width="100%"
                                                                                ImageHeight="170px" ImageWidth="160px" EnableServerResize="True" />
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem FieldName="Expr1" ShowCaption="False" ColSpan="1">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxBinaryImage ID="Printer_CProdotto_View" runat="server" Width="100%"
                                                                                ImageHeight="170px" ImageWidth="160px" EnableServerResize="True" />
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                            </Items>
                                                        </dx:LayoutGroup>

                                                        <dx:LayoutGroup ShowCaption="False" ColumnCount="2">
                                                            <Items>
                                                                <dx:LayoutItem Caption="Modello Printer" CaptionSettings-Location="Top" ShowCaption="False" CaptionStyle-Font-Bold="true">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                                                                                <span style="font-weight: bold;">Modello Printer:</span>
                                                                                <asp:Label ID="ModelloLabel" runat="server" />
                                                                            </div>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem Caption="Codice Prodotto" CaptionSettings-Location="Top" ShowCaption="False" CaptionStyle-Font-Bold="true">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                                                                                <span style="font-weight: bold;">Codice Prodotto:</span>
                                                                                <asp:Label ID="Printer_CodiceProdotto_Edit" runat="server" />
                                                                            </div>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem Caption="Tipologia" CaptionSettings-Location="Top" ShowCaption="False" CaptionStyle-Font-Bold="true">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                                                                                <span style="font-weight: bold;">Tipologia:</span>
                                                                                <asp:Label ID="ID_Tipologia" runat="server" />
                                                                            </div>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>

                                                                <dx:LayoutItem Caption="Numero di Colori" CaptionSettings-Location="Top" ShowCaption="False" ColSpan="1" CaptionStyle-Font-Bold="true">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                                                                                <span style="font-weight: bold;">Numero di Colori:</span>
                                                                                <asp:Label ID="ASPxSpinEdit1" runat="server" />
                                                                            </div>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                            </Items>
                                                        </dx:LayoutGroup>
                                                    </Items>
                                                </dx:LayoutGroup>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </div>
                        <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Text="Caricamento in corso..." Modal="true"></dx:ASPxLoadingPanel>
                        <div class="mobile-tablet-only">
                            <div class="col-md-6">
                                <div class="row shop-grid list-view">
                                    <dx:ASPxCardView ID="ASPxCardView1" ClientInstanceName="shopListMobile" runat="server" Width="100%" KeyFieldName="ID" AutoGenerateColumns="False" DataSourceID="Printer_Elenco_Codici_Consumabili_Dts_Cli" Paddings-Padding="0">
                                        <Columns>
                                            <dx:CardViewColumn FieldName="CProdotto" />
                                        </Columns>
                                        <Settings VerticalScrollableHeight="600" />
                                        <SettingsPager Mode="ShowPager" EndlessPagingMode="OnScroll">
                                            <SettingsTableLayout ColumnCount="1" RowsPerPage="15" />
                                        </SettingsPager>
                                        <Templates>
                                            <Card>
                                                <div class="shop-grid-item" style="padding: 0; margin: 0;">
                                                    <div class="col-md-9 col-sm-12 col-xs-12" style="padding-left: 0; padding-right: 0;">
                                                        <div class="row" style="margin: 0;">
                                                            <div class="col-md-8 col-sm-12 col-xs-12" style="padding-left: 0; padding-right: 0;">
                                                                <div class="container-wrapper">

                                                                    <!-- Wrapper testo + immagine -->
                                                                    <div class="text-img-row">
                                                                        <div class="info-group">
                                                                            <dx:ASPxLabel ID="ASPxLabel2" Text='<%# Eval("CProdotto") %>' runat="server" CssClass="title title-b2b" Width="100%" Style="white-space: nowrap; font-weight: bold;" />
                                                                            <dx:ASPxLabel ID="ASPxLabel1" Text='<%# Eval("Expr6") %>' runat="server" CssClass="title title-b2b mb-0" Style="white-space: nowrap; font-weight: bold;" />
                                                                            <div runat="server" class="color-dot-name-container" style="white-space: nowrap;">
                                                                                <%# GetColorDotAndName((int)Eval("ColoreID")) %>
                                                                            </div>
                                                                        </div>

                                                                        <div class="image-group">
                                                                            <img style="width: 100px; max-width: 100%;" src='<%# GetBase64Image(Eval("Expr5")) %>' onerror="this.src='noimage.jpg'" />
                                                                        </div>
                                                                    </div>

                                                                    <!-- Qty e carrello sotto -->
                                                                    <div class="cart-group">
                                                                        <div class="qty-cart-container" style="border: 1px solid #ccc; border-radius: 4px; overflow: hidden; margin-bottom: 8px;">
                                                                            <button type="button" onclick="adjustQty(this, -1)" style="padding: 4px 6px; background-color: #f0f0f0; border: none;">−</button>
                                                                            <input type="text"
                                                                                class="info4u-custom-quantity"
                                                                                style="width: 35px; text-align: center; border: none;"
                                                                                oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                                                                                value="1"
                                                                                min="1"
                                                                                max="999999"
                                                                                qtaperconf="1"
                                                                                id='<%# "P" + Eval("CProdotto").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>' />
                                                                            <button type="button" onclick="adjustQty(this, 1)" style="padding: 4px 6px; background-color: #f0f0f0; border: none;">+</button>
                                                                        </div>

                                                                        <a class="btn btn-primary info4u-custom-cart"
                                                                            href='javascript: AddToCart("<%# "P" + Eval("CProdotto").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>", <%# Container.VisibleIndex %>, "mobile");'>
                                                                            <i class="fa fa-shopping-cart"></i>
                                                                        </a>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </Card>
                                        </Templates>
                                    </dx:ASPxCardView>
                                </div>
                            </div>
                        </div>

                        <div class="desktop-only">
                            <div class="col-md-6">
                                <div class="row shop-grid list-view">
                                    <dx:ASPxCardView ID="ShopList1" ClientInstanceName="shopList1" runat="server" Width="100%" KeyFieldName="ID" AutoGenerateColumns="False" DataSourceID="Printer_Elenco_Codici_Consumabili_Dts_Cli" Paddings-Padding="0">
                                        <Columns>
                                            <dx:CardViewColumn FieldName="CProdotto" />

                                        </Columns>
                                        <Settings VerticalScrollableHeight="600" />
                                        <SettingsPager Mode="ShowPager" EndlessPagingMode="OnScroll">

                                            <SettingsTableLayout ColumnCount="1" RowsPerPage="15" />
                                        </SettingsPager>
                                        <Templates>
                                            <Card>
                                                <div class="shop-grid-item" style="padding: 0; margin: 0;">
                                                    <div class="row product-slide-entry align-items-center" style="margin: 0; padding: 0;">

                                                        <div class="col-md-3 col-sm-12 col-xs-12 d-flex flex-column align-items-center" style="padding-left: 0; padding-right: 0;">
                                                            <img style="width: 100px; max-width: 100%;" src='<%# GetBase64Image(Eval("Expr5")) %>' onerror="this.src='noimage.jpg'" />
                                                        </div>

                                                        <div class="col-md-9 col-sm-12 col-xs-12" style="padding-left: 0; padding-right: 0;">
                                                            <div class="row" style="margin: 0;">

                                                                <div class="col-md-4 col-sm-12 col-xs-12" style="padding-left: 0; padding-right: 0;">
                                                                    <dx:ASPxLabel ID="ASPxLabel2" Text='<%# Eval("CProdotto") %>' runat="server" CssClass="title title-b2b" Width="100%" />
                                                                </div>


                                                                <div class="col-md-8 col-sm-12 col-xs-12" style="padding-left: 0; padding-right: 0;">
                                                                    <div class="container-wrapper">
                                                                        <div class="info-group">
                                                                            <dx:ASPxLabel ID="ASPxLabel1" Text='<%# Eval("Expr6") %>' runat="server" CssClass="title title-b2b mb-0" Style="white-space: nowrap;" />
                                                                            <div runat="server" class="color-dot-name-container" style="white-space: nowrap;">
                                                                                <%# GetColorDotAndName((int)Eval("ColoreID")) %>
                                                                            </div>
                                                                        </div>

                                                                        <div class="cart-group">
                                                                            <div class="qty-cart-container" style="border: 1px solid #ccc; border-radius: 4px; overflow: hidden;">
                                                                                <button type="button" onclick="adjustQty(this, -1)" style="padding: 4px 6px; background-color: #f0f0f0; border: none;">−</button>
                                                                                <input type="text"
                                                                                    class="info4u-custom-quantity"
                                                                                    style="width: 35px; text-align: center; border: none;"
                                                                                    oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                                                                                    value="1"
                                                                                    min="1"
                                                                                    max="999999"
                                                                                    qtaperconf="1"
                                                                                    id='<%# "P" + Eval("CProdotto").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>' />
                                                                                <button type="button" onclick="adjustQty(this, 1)" style="padding: 4px 6px; background-color: #f0f0f0; border: none;">+</button>
                                                                            </div>

                                                                            <a class="btn btn-primary info4u-custom-cart"
                                                                                href='javascript: AddToCart("<%# "P" + Eval("CProdotto").ToString().Replace("-","_").Replace("/","_").Replace(".","_").Replace(",","_") + "_QtaDef_Txt" %>", <%# Container.VisibleIndex %>, "desktop");'>
                                                                                <i class="fa fa-shopping-cart"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                            </Card>
                                        </Templates>
                                    </dx:ASPxCardView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxCallback runat="server" ID="AggiungiAlCarrello_Callback" ClientInstanceName="AggiungiAlCarrello_Callback" OnCallback="AggiungiAlCarrello_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){PopupCarrello_callbackPnl.PerformCallback();LoadingPanel.Hide();showNotificationtoastr();  }" />
    </dx:ASPxCallback>
    <%-- SqlDataSource per FormLayout --%>
    <asp:SqlDataSource ID="Printer_Edit_Dts_Cli" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Multifunzione_ANA.PhotoBytes, Multifunzione_ANA.Modello, Multifunzione_ANA.ID, Multifunzione_ANA.CodiceProdotto, Multifunzione_ANA.ID_Tipologia, Multifunzione_ANA.N_Colori, Multifunzione_ANA.BrandId, Brand.Nome, Tipologia_Printer_ANA.Tipologia, Brand.PhotoBytes AS Expr1, Printer_ANA.Token FROM Multifunzione_ANA INNER JOIN Printer_ANA ON Multifunzione_ANA.Modello = Printer_ANA.Modello INNER JOIN Brand ON Multifunzione_ANA.BrandId = Brand.ID INNER JOIN Tipologia_Printer_ANA ON Multifunzione_ANA.ID_Tipologia = Tipologia_Printer_ANA.ID WHERE (Printer_ANA.Token = @Token)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Token" Name="Token"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>


    <%-- SqlDataSource per ID_Tipologia --%>
    <asp:SqlDataSource ID="Printer_Id_Tipologia_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID, Tipologia FROM Tipologia_Printer_ANA"></asp:SqlDataSource>

    <%-- SqlDataSource per Codice cliente --%>
    <asp:SqlDataSource ID="Printer_Codice_Cliente_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT Clienti_King.* FROM Clienti_King"></asp:SqlDataSource>

    <%-- SqlDataSource per Status --%>
    <asp:SqlDataSource ID="Printer_Id_Status_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT ID, Status, ID_Semaforo FROM Status_Printer_ANA"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Printer_Elenco_Codici_Consumabili_Dts_Cli" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT 
    Printer_ANA.ID AS Expr1, 
    Printer_ANA.Modello AS Expr2, 
    Printer_ANA.ID_Tipologia AS Expr3, 
    Multifunzione_ANA.ID, 
    Multifunzione_ANA.Modello, 
    Multifunzione_ANA.ID_Tipologia, 
    Multifunzione_ANA.PhotoBytes, 
    Multifunzione_ANA.BrandId, 
    Multifunzione_ANA.CodiceProdotto, 
    Multifunzione_ANA.N_Colori, 
    Tipologia_Printer_ANA.Tipologia, 
    Brand.Nome, 
    Elenco_codici_consumabili_vs_printer.ID_Multifunzione, 
    Ricambi_Consumabili.CodiceProdotto AS CProdotto, 
    Ricambi_Consumabili.Descrizione, 
    Ricambi_Consumabili.PhotoBytes AS Expr5, 
    Ricambi_Consumabili.ColoreID, 
    Ricambi_Consumabili.TipoProdID, 
    Tipologia_Ricambi_Consumabili.Nome AS Expr6
FROM 
    Printer_ANA 
    INNER JOIN Multifunzione_ANA 
        ON Printer_ANA.Modello = Multifunzione_ANA.Modello 
    INNER JOIN Brand 
        ON Multifunzione_ANA.BrandId = Brand.ID 
    INNER JOIN Tipologia_Printer_ANA 
        ON Multifunzione_ANA.ID_Tipologia = Tipologia_Printer_ANA.ID 
    INNER JOIN Elenco_codici_consumabili_vs_printer 
        ON Multifunzione_ANA.ID = Elenco_codici_consumabili_vs_printer.ID_Multifunzione 
    INNER JOIN Ricambi_Consumabili 
        ON Elenco_codici_consumabili_vs_printer.ID_Consumabile = Ricambi_Consumabili.ID 
    INNER JOIN Tipologia_Ricambi_Consumabili 
        ON Ricambi_Consumabili.TipoProdID = Tipologia_Ricambi_Consumabili.ID 
WHERE 
    Printer_ANA.Token = @Token
ORDER BY 
    CASE WHEN Tipologia_Ricambi_Consumabili.Nome = 'Toner' THEN 0 ELSE 1 END,
    Tipologia_Ricambi_Consumabili.Nome ">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Token" Name="Token"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Rilevamento_Mesi_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="Printer_Mesi_Rilevazione" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Ricambi_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT        Ricambi_Consumabili.ID, Ricambi_Consumabili.CodiceProdotto, Ricambi_Consumabili.Descrizione, Ricambi_Consumabili.DettaglioProd, Ricambi_Consumabili.CopiePreviste, Ricambi_Consumabili.BrandId, 
                         Ricambi_Consumabili.PhotoBytes, Ricambi_Consumabili.TipoProdID, Ricambi_Consumabili.ColoreID, Tipologia_Ricambi_Consumabili.Nome, 
      CASE ColoreID
        WHEN 1 THEN 'Nero'
        WHEN 2 THEN 'Giallo'
        WHEN 3 THEN 'Magenta'
        WHEN 4 THEN 'Ciano'
        WHEN 5 THEN 'Waste'
        WHEN 7 THEN 'Nessuno'
        ELSE 'Sconosciuto'
      END AS ColoreNome
FROM            Ricambi_Consumabili INNER JOIN
                         Tipologia_Ricambi_Consumabili ON Ricambi_Consumabili.TipoProdID = Tipologia_Ricambi_Consumabili.ID, WHERE (BrandId = @BrandId)">
        <SelectParameters>
            <asp:SessionParameter SessionField="BrandId" Name="BrandId"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        let qtySelected = {};

        function adjustQty(btn, delta) {
            const input = btn.parentElement.querySelector('input');
            let val = parseInt(input.value || '1', 10);
            if (isNaN(val)) val = 1;

            val += delta;
            if (val < 1) val = 1;

            input.value = val;

            //Salvo il valore aggiornato per l'input specifico
            qtySelected[input.id] = val;

            console.log("adjustQty new val:", val, " input id:", input.id);
        }

        function AddToCart(ID, Index, TipoGriglia) {
            var cookie = getCookie('CodDep');
            if (cookie != null && cookie != '') {
                //Leggo dalla variabile e non dal DOM
                var ValoreInput = qtySelected[ID] !== undefined ? qtySelected[ID].toString() : document.getElementById(ID).value.toString();

                var InputEdit = document.getElementById(ID);

                console.log('ValoreInput ' + ValoreInput + ' InputEdit ' + ID);

                var Incremento = ValoreInput;

                if (ValoreInput != "" && ValoreInput != "." && ValoreInput != "0") {
                    if (ControllaMultiplo(ValoreInput, Incremento)) {
                        AggiungiAlCarrello_Callback.PerformCallback(Index + ";" + ValoreInput + ";" + TipoGriglia);
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



    </script>
</asp:Content>

