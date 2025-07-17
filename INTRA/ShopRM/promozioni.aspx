<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="promozioni.aspx.cs" Inherits="INTRA.ShopRM.promozioni" %>
<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/16PlusLeftMenuPromoBrand.ascx" TagPrefix="Banner" TagName="PlusLeftMenuPromoBrand" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>



<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContenutoPaginaContentPH">
    <%--   <uc7:LeftMenuPannelloCustomer ID="LeftMenuPannelloCustomer1" runat="server" />--%>

    <div class="information-blocks">
        <Banner:PlusDisplayBannerImgRandom runat="server" ID="PlusDisplayBannerImgRandom" Visible="false" />
        <div class="row">
            <div class="col-md-3 col-sm-12 sidebar-column">

                <Banner:PlusLeftMenuCatalogo runat="server" ID="PlusLeftMenuCatalogo" />
                <%--<MsgBox:PlusTopMenuAiuto runat="server" ID="PlusTopMenuAiuto" />--%>
            </div>
            <div class="col-md-9 col-sm-12 information-entry">    
                <asp:SqlDataSource ID="breadcrumb_SqlDt" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT SHP_Category.DisplayName AS SubCatego, SHP_Category_1.DisplayName AS Catego, SHP_Category.CategoryID AS SubCategoID, SHP_Category_1.CategoryID AS CategoID FROM SHP_Category LEFT OUTER JOIN SHP_Category AS SHP_Category_1 ON SHP_Category.ParentCategoryID = SHP_Category_1.CategoryID WHERE (SHP_Category.CategoryID = @Cat)">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="Cat" DefaultValue="0" Name="Cat"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="breadcrumb-box">
                <a href="/ShopRM/Default.aspx">Catalogo</a>
                <asp:ListView ID="breadcrumb_LView" runat="server" DataSourceID="breadcrumb_SqlDt">
                    <ItemTemplate>
                        <a href="/ShopRM/prodotti.aspx?Cat=<%# Eval("CategoID") %>" style='display:<%#String.IsNullOrEmpty(Eval("CategoID").ToString())? "none" : "normal" %>'><%# Eval("Catego") %></a>
                        <a href="/ShopRM/prodotti.aspx?Cat=<%# Eval("SubCategoID") %>"><%# Eval("SubCatego") %></a>
                     
                    </ItemTemplate>
                </asp:ListView>
            </div>
                    <banner:COMM_ContentAreaProdotti runat="server" ID="PlusContentAreaProdotti" />                
            </div>
            
        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
