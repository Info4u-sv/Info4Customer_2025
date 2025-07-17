<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Categorie_Merceologiche.aspx.cs" Inherits="INTRA.ShopRM.Categorie_Merceologiche" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="mozaic-banners-wrapper type-2">
        <div class="row">
            <asp:ListView ID="ListViewBrandBox" runat="server" DataKeyNames="CategoryID"
                ItemPlaceholderID="ItemContainer" DataSourceID="GenericSqlDS1">
                <LayoutTemplate>
                    <asp:PlaceHolder ID="ItemContainer" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="banner-column col-md-3 col-sm-6">
                        <a class="mozaic-banner-entry type-3" style="background-image: Url(<%# Page.ResolveUrl(Eval("PictureUrl").ToString())%>);" href="prodotti.aspx?Cat=<%# Eval("CategoryID") %>">
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
    </div>
    <br />
    <br />
    <br />
    <br />

    <%--    <dx:ASPxPopupControl runat="server" ID="AlertAtleti_Popup" ClientInstanceName="AlertAtleti_Popup" Modal="true" CloseAction="None" Width="800px">
        <ContentCollection>
            <dx:PanelContent>

            </dx:PanelContent>
        </ContentCollection>
    </dx:ASPxPopupControl>--%>


    <%--<asp:SqlDataSource ID="GenericSqlDS1" runat="server"
        ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT        SHP_Category.TitPiccoloBoxHomeP, SHP_Category.TitGrandeBoxHomeP, ISNULL(SHP_Picture.PictureUrl, '/PUBLIC/CategoCatalogo/MieleGenericCategory.jpg') AS PictureUrl, SHP_Category.Published, 
                         SHP_Category.ParentCategoryID, SHP_Category.ShowOnHomePage, SHP_Category.CategoryID, SHP_Category.DisplayOrder
FROM            SHP_Picture RIGHT OUTER JOIN
                         SHP_Category ON SHP_Picture.PictureID = SHP_Category.PictureID
WHERE        (SHP_Category.ShowOnHomePage = 1) AND (SHP_Category.Published = 1) AND (SHP_Category.DisplayName IS NOT NULL) AND (SHP_Category.Settore = @Settore) AND (SHP_Category.CatM <> '000')
ORDER BY SHP_Category.DisplayOrder">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Set" Name="Settore"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource runat="server" ID="GenericSqlDS1" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_SHP_Category.CategoryID, U_SHP_Category.DisplayName, U_SHP_Category.NameRw, U_SHP_Category.Description, U_SHP_Category.ShortDescription, U_SHP_Category.ParentCategoryID, U_SHP_Category.LevelCategory, U_SHP_Category.PictureByte, U_SHP_Category.TitPiccoloBoxHomeP, U_SHP_Category.TitGrandeBoxHomeP, U_SHP_Category.ShowOnHomePage, U_SHP_Category.Published, U_SHP_Category.Deleted, U_SHP_Category.DisplayOrder, U_SHP_Category.PictureID, U_SHP_Category.Settore, U_SHP_Category.CatM, U_SHP_Picture.PictureUrl FROM U_SHP_Category LEFT OUTER JOIN U_SHP_Picture ON U_SHP_Category.PictureID = U_SHP_Picture.PictureID WHERE (U_SHP_Category.CatM <> N'000') AND (U_SHP_Category.Settore = @Settore)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Set" Name="Settore"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
