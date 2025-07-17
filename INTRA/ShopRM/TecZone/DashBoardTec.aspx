<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="DashBoardTec.aspx.cs" Inherits="INTRA.ShopRM.TecZone.DashBoardTec" %>

<%@ Register Src="~/ShopRM/TecZone/Controls/LeftMenuTecnico.ascx" TagPrefix="uc1" TagName="LeftMenuTecnico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuTecnico runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">My Area</h2>
            </div>
            <div class="article-container">
                <p>In questa pagina potrai controllare in qualsiasi momento i rusultati raggiunti</p>
                <div class="block-title inline-product-column-title">Saldo Punti Prossimo obiettivo</div>
                <asp:Repeater runat="server" ID="ProssimoObiettivo_Rep" DataSourceID="ProssimoObiettivo_Dts">
                    <ItemTemplate>
                        <div class="sale-entry">
                            <div class="sale-price"><span><%# String.Format("{0:0.##}", Eval("ProssimoObiettivo")) %></span>Punti</div>
                            <div class="sale-description">
                                <h2 class="title">Prossimo Traguardo</h2>
                                </span>

                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="block-title inline-product-column-title" style="padding-top: 10px">Traguardi Raggiunti</div>
                <asp:Repeater runat="server" ID="TraguardiRaggiunti_Rep" DataSourceID="TraguardiRaggiunti_Dts">
                    <ItemTemplate>
                        <div class="sale-entry">

                            <div class="sale-price"><span><%# String.Format("{0:0.##}", Eval("PuntiAssegnati")) %></span>Punti</div>
                            <div class="sale-description" style="font-size: 18px; color: #000000">
                                <h2 style="color: #008acc">Raggiunto Il <%# String.Format("{0:dd/MM/yyyy}", Eval("DataConsuntivo")) %> </h2>

                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>


               

                <asp:SqlDataSource runat="server" ID="TraguardiRaggiunti_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT DataConsuntivo, CodTecnicoCat, PuntiAssegnati FROM MIL_Storico_Premi_Tec WHERE (CodTecnicoCat = @CodTecnicoCat) Order by MIL_Storico_Premi_Tec.IdConsuntivo DESC">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="CodTecnicoCat" Name="CodTecnicoCat"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource runat="server" ID="ProssimoObiettivo_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ISNULL(SUM(TotaleRiga), 0) AS ProssimoObiettivo FROM (SELECT ROUND((ESK_OrderDetails.QuantitaEvasa * ESK_OrderDetails.UnitCost) * (ESK_OrderDetails.PuntiInPercentuale / 100), 2) AS TotaleRiga FROM ESK_OrderDetails INNER JOIN ESK_Orders ON ESK_OrderDetails.OrderID = ESK_Orders.OrderID INNER JOIN VIO_Utenti ON ESK_Orders.CustomerID = VIO_Utenti.CodCli WHERE (VIO_Utenti.CodTecnicoCat = @CodTecnicoCat) AND (ESK_OrderDetails.FlagEvaso = 2) AND (ESK_OrderDetails.IdConsuntivo = 0)) AS TabTotali">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="CodTecnicoCat" Name="CodTecnicoCat"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
