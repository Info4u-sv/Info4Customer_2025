<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="prodotti.aspx.cs" Inherits="INTRA.ShopRM.prodotti" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/16PlusLeftMenuPromoBrand.ascx" TagPrefix="Banner" TagName="PlusLeftMenuPromoBrand" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>



<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContenutoPaginaContentPH">

    <%--   <uc7:LeftMenuPannelloCustomer ID="LeftMenuPannelloCustomer1" runat="server" />--%>
    <Banner:PlusDisplayBannerImgRandom runat="server" ID="PlusDisplayBannerImgRandom" Visible="false" />
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column" style="padding-left:5px; padding-right:0px !important;">

            <Banner:PlusLeftMenuCatalogo runat="server" ID="PlusLeftMenuCatalogo" Visible="false" />
            <%--<MsgBox:PlusTopMenuAiuto runat="server" ID="PlusTopMenuAiuto" />--%>
        </div>
        <div class="col-md-12 col-sm-12 information-entry">
            <asp:SqlDataSource ID="breadcrumb_SqlDt" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT        U_SHP_Category.DisplayName AS SubCatego, U_SHP_Category_1.DisplayName AS Catego, U_SHP_Category.CategoryID AS SubCategoID, U_SHP_Category_1.CategoryID AS CategoID, U_SHP_Category.Settore
FROM            U_SHP_Category LEFT OUTER JOIN
                         U_SHP_Category AS U_SHP_Category_1 ON U_SHP_Category.ParentCategoryID = U_SHP_Category_1.CategoryID
WHERE        (U_SHP_Category.CategoryID = @Cat)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="Cat" DefaultValue="0" Name="Cat"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="breadcrumb-box" style="padding-left:20px !important; padding-right:15px !important;">
                <a href="/ShopRM/Default.aspx">Catalogo</a>
                <asp:ListView ID="breadcrumb_LView" runat="server" DataSourceID="breadcrumb_SqlDt">
                    <ItemTemplate>
                        <a href="/ShopRM/Categorie_Merceologiche.aspx?Set=<%# Eval("Settore") %>" style='display: <%#String.IsNullOrEmpty(Eval("CategoID").ToString())? "none" : "normal" %>'><%# Eval("Catego") %></a>
                        <a href="/ShopRM/prodotti.aspx?Cat=<%# Eval("SubCategoID") %>"><%# Eval("SubCatego") %></a>

                    </ItemTemplate>
                </asp:ListView>
            </div>
            <Banner:COMM_ContentAreaProdotti runat="server" ID="PlusContentAreaProdotti" />
        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<script>
           $(document).ready(function () {
               var cookie = getCookie('CodCli');
               alert(cookie);
               if (cookie != null && cookie != '') { showNotificationOrdineCliente('Ordine per il cliente Luigi Brambilla, ' + cookie); }
           });
       </script>--%>
</asp:Content>
