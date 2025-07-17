<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="OrdineDet.aspx.cs" Inherits="INTRA.ShopRM.Customer.OrdineDet" %>

<%@ Register Src="~/ShopRM/Customer/Controls/LeftMenuCustomer.ascx" TagPrefix="uc1" TagName="LeftMenuCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .formLayout {
            max-width: 1300px;
            margin: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuCustomer runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">Detteglio Ordine</h2>
            </div>
            <div class="article-container">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12 no-padding no-margin">
                            <dx:ASPxFormLayout runat="server" ID="TestataOrdine_FormView" Enabled="false" ClientInstanceName="TestataOrdine_FormView" ColumnCount="3" Width="100%" ColCount="3" DataSourceID="Testata_dts" CssClass="formLayout">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700" />
                                <Items>
                                    <dx:LayoutGroup Caption="Testata" AlignItemCaptions="true" ColumnCount="3" ColumnSpan="3" SettingsItemHelpTexts-Position="bottom" GroupBoxStyle-Caption-Font-Size="Larger" Paddings-Padding="0" SettingsItemCaptions-ChangeCaptionLocationInAdaptiveMode="True">
                                        <Items>
                                            <dx:LayoutItem FieldName="OrderID" Caption="N° Ordine" ColumnSpan="1" CaptionSettings-Location="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox runat="server" ID="OrderId_txt" ClientInstanceName="OrderId_txt">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem FieldName="OrderDate" Caption="Data Ordine" ColumnSpan="1" CaptionSettings-Location="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxDateEdit runat="server" ID="OrderDate_Date" ClientInstanceName="OrderDate_Date">
                                                        </dx:ASPxDateEdit>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem FieldName="trasporto" Caption="Costi Trasporto" ColumnSpan="1" CaptionSettings-Location="Left" Visible="false">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox runat="server" ID="trasporto_txt" ReadOnly="true" ClientInstanceName="trasporto_txt"></dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem FieldName="iva" Caption="Iva" ColumnSpan="1" CaptionSettings-Location="Left" Visible="false">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox runat="server" ID="Iva_txt" ReadOnly="true" ClientInstanceName="Iva_txt"></dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem FieldName="CustomerID" Caption="Codice cliente" ColumnSpan="1" CaptionSettings-Location="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox runat="server" ID="CodCli_txt" ClientInstanceName="CodCli_txt">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem FieldName="EsitoEsteso" Caption="Status Ordine" ColumnSpan="1" CaptionSettings-Location="Left">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxLabel runat="server" ID="EsitoEsteso_Lbl" ClientInstanceName="EsitoEsteso_Lbl" Width="100%"></dx:ASPxLabel>
                                                        <%--  <dx:ASPxTextBox runat="server" ID="EsitoEsteso_txt" ClientInstanceName="EsitoEsteso_txt" Width="100%">
                                                    </dx:ASPxTextBox>--%>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                        </Items>
                                    </dx:LayoutGroup>

                                </Items>
                            </dx:ASPxFormLayout>
                        </div>
                    </div>
                    <div class="col-md-12 no-margin no-padding" style="padding-top: 10px !important">

                        <dx:ASPxGridView runat="server" ID="DettaglioOrd_grw" ClientInstanceName="DettaglioOrd_grw" AutoGenerateColumns="False" DataSourceID="Dettaglio_dts" Width="100%">
                            <Settings ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                            <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"
                                AllowHideDataCellsByColumnMinWidth="true">
                            </SettingsAdaptivity>
                            <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="ProductID" Caption="Cod. Pord." AdaptivePriority="0" VisibleIndex="0" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ProductName" Caption="Descr. Prod." AdaptivePriority="1" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UnitCost" Caption="Costo Unit." AdaptivePriority="4" VisibleIndex="2" Width="50px" PropertiesTextEdit-DisplayFormatString="{0:c}"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="3" AdaptivePriority="3" Caption="Q.tà Ord." Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="QuantitaEvasa" VisibleIndex="4" AdaptivePriority="4" Caption="Q.tà Evasa" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Totale" ReadOnly="True" AdaptivePriority="2" VisibleIndex="5" Width="50px" PropertiesTextEdit-DisplayFormatString="{0:c}"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TipoStatus" Caption="Status" ReadOnly="True" AdaptivePriority="4" VisibleIndex="6" Width="100px"></dx:GridViewDataTextColumn>
                            </Columns>
                            <TotalSummary>
                                <dx:ASPxSummaryItem FieldName="Totale" SummaryType="Sum" />
                            </TotalSummary>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource runat="server" ID="Dettaglio_dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ESK_OrderDetails.ProductID, ESK_OrderDetails.ProductName, ESK_OrderDetails.UnitCost, ESK_OrderDetails.Quantity * ESK_OrderDetails.UnitCost AS Totale, ESK_OrderDetails.FlagEvaso, ESK_OrderDetails.QuantitaEvasa, ESK_OrderStatus.TipoStatus, ESK_OrderDetails.Quantity FROM ESK_OrderDetails INNER JOIN ESK_OrderStatus ON ESK_OrderDetails.FlagEvaso = ESK_OrderStatus.FlagEvaso WHERE (ESK_OrderDetails.OrderID = @OrderId)">
                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="OrderId" Name="OrderId"></asp:QueryStringParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>

                <div class="col-md-12">
                    <%--                    <asp:Repeater runat="server" ID="ClientInfo_rpt" DataSourceID="ClientInfo_dts">
                        <ItemTemplate>
                            <fieldset class="col-md-12 container">
                                <legend class="titolo-info-cli">Info Cliente</legend>
                                <span>
                                    <span class="etichetta">Cognome : </span><%#Eval("Cognome") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Nome : </span><%#Eval("Nome") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Codice Fiscale : </span><%#Eval("CF") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Indirizzo : </span><%#Eval("Ind") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Città : </span><%#Eval("Loc") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Provincia : </span><%#Eval("Prov") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Cap : </span><%#Eval("Cap") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Telefono : </span><%#Eval("Tel") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Fax : </span><%#Eval("Fax") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Email : </span><%#Eval("EMail") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Note : </span><%#Eval("note_customer") %>
                                </span>
                                <br />
                                <span>
                                    <span class="etichetta">Comunicazione al cliente: </span>
                                    <br />
                                    <dx:ASPxMemo runat="server" ID="NoteAdmin_memo" ClientInstanceName="NoteAdmin_memo" ReadOnly="true" Text='<%#Eval("note_admin") %>' Width="100%" Height="150px"></dx:ASPxMemo>
                                </span>
                            </fieldset>
                        </ItemTemplate>
                    </asp:Repeater>--%>
                    <asp:SqlDataSource runat="server" ID="Testata_dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        ESK_Orders.OrderID, ESK_Orders.CustomerID, ESK_Orders.OrderDate, ESK_Orders.esito, ESK_Orders.iva, ESK_Orders.trasporto, ESK_Orders.aff, ESK_Orders.aff_story, ESK_Orders.referer, ESK_Orders.DateInsert, 
                         ESK_Orders.DateUpdate, ESK_Orders.note_admin, ESK_Orders.note_customer, ESK_Orders.FlagEvaso, ESK_OrderStatus.DisplayName AS EsitoEsteso
FROM            ESK_Orders INNER JOIN
                         ESK_OrderStatus ON ESK_Orders.esito = ESK_OrderStatus.esito
WHERE        (ESK_Orders.OrderID = @OrderId)">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="OrderId" Name="OrderId"></asp:QueryStringParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource runat="server" ID="ClientInfo_dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Clienti.Nome, Clienti.Cognome, Clienti.Ind, Clienti.Loc, Clienti.Tel, Clienti.Fax, Clienti.CF, ESK_Orders.note_customer, ESK_Orders.note_admin, Clienti.Prov, Clienti.EMail, Clienti.Cap FROM ESK_Orders INNER JOIN Clienti ON ESK_Orders.CustomerID = Clienti.CodCli WHERE (ESK_Orders.OrderID = @OrderID)">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="OrderId" Name="OrderID"></asp:QueryStringParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
