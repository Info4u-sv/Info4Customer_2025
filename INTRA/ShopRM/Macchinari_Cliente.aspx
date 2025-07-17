<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Macchinari_Cliente.aspx.cs" Inherits="INTRA.ShopRM.Macchinari_Cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="mozaic-banners-wrapper type-2">
        <div class="row">
            <div class="col-12" style="margin-bottom: 40px;">                
                 <div class="alert alert-info" role="alert" style="font-size: 1.1rem;">
                    In questa pagina puoi ordinare i <strong>consumabili</strong> relativi a una determinata <strong>macchina installata</strong> presso la tua sede. Seleziona il modello desiderato qui sotto per accedere ai dettagli.
                </div>
            </div>

            <asp:ListView ID="ListViewBrandBox" runat="server" DataKeyNames="ID"
                ItemPlaceholderID="ItemContainer" DataSourceID="Macchinari_Dts">
                <LayoutTemplate>
                    <asp:PlaceHolder ID="ItemContainer" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="banner-column col-md-3 col-sm-6">
                        <a class="mozaic-banner-entry type-3" style='<%# "background-image: url(" + INTRA.ShopRM.Macchinari_Cliente.GetBase64Image(Eval("PhotoBytes")) + ");" %>' href='<%# "/ShopRM/Dettaglio_Macchinari_Cliente.aspx?Token=" + Eval("Token") %>'">
                            <span class="mozaic-banner-content">
                                <span class="subtitle"><%# Eval("Modello") %></span>
                                <span class="title"><%# Eval("Ubicazione_Printer") %></span>
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
    </div>
    <br />
    <br />
    <br />
    <br />
    <asp:SqlDataSource runat="server" ID="Macchinari_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT PhotoBytes, Modello, ID, Token, Ubicazione_Printer FROM (SELECT Multifunzione_ANA.PhotoBytes, Multifunzione_ANA.Modello, Multifunzione_ANA.ID, Printer_ANA.Token, Printer_ANA.Ubicazione_Printer, ROW_NUMBER() OVER (PARTITION BY Multifunzione_ANA.Modello, Printer_ANA.Ubicazione_Printer ORDER BY Multifunzione_ANA.ID) AS rn FROM Multifunzione_ANA INNER JOIN Printer_ANA ON Multifunzione_ANA.ID = Printer_ANA.ID_Printer WHERE Printer_ANA.Cod_Cliente = LEFT(@CodCli, CHARINDEX('-', @CodCli + '-') - 1)) AS RankedPrinters WHERE rn = 1">
        <SelectParameters>
            <asp:SessionParameter SessionField="CodCli" Name="CodCli"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
