<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="21MonoLeftMenuCatalogo.ascx.cs" Inherits="INTRA.ShopRM.Controls._21MonoLeftMenuCatalogo" %>
<%--<link href="<%= ResolveUrl("~/css/16_Custom_4u.css") %>" rel="stylesheet" type="text/css" />--%>

<asp:Label ID="BrandLabel" runat="server" Text="Label" Visible="false"></asp:Label>
<asp:Label ID="SubCategoLabel" runat="server" Text="Label" Visible="false"></asp:Label>
<asp:Label ID="MacroCategoLabel" runat="server" Text="Label" Visible="false"></asp:Label>
<asp:SqlDataSource ID="CategoSqlData" runat="server" ConnectionString="<%$ ConnectionStrings:gestionaleConnectionString %>"
    SelectCommand="SELECT DISTINCT DisplayName AS CategoName, CategoryID AS CategoId, NameRw AS NameRWCatego, DisplayOrder
FROM      U_SHP_Category
    WHERE (U_SHP_Category.LevelCategory = 0) AND   
               (U_SHP_Category.Published = 1) ORDER BY DisplayOrder">
</asp:SqlDataSource>
<div class="sidebar-navigation" style="border: 0">
    <div class="title" style="border: solid 1px;">Catalogo<i class="fa fa-angle-down"></i></div>
    <div class="list">
        <asp:Panel ID="MielePanel" runat="server" Visible="false">
         
            <asp:Repeater ID="MieleRepeater2" runat="server" DataSourceID="CategoSqlData">
                <ItemTemplate>
            
                    <div id="<%# Eval("CategoId")%>" class="accordeon-title <%# GetTags_Actived_Catego((int)Eval("CategoId")) %>"><%# Eval("CategoName")%></div>
                    <div class="accordeon-entry" style='<%# GetTags_DisplayBlock_Catego((int)Eval("CategoId")) %>'>
                        <div class="article-container style-1">
                            <ul class="Nav4u">
                                <asp:Repeater runat="server" ID="MieleSubRepeater" DataSource='<%# GetTagsMiele((int)Eval("CategoId")) %>'>
                                    <ItemTemplate>
                                    
                                        <li  class="<%# GetTags_Actived_SubCatego((int)Eval("CategoryID")) %>">
                                            <a href='prodotti.aspx?Cat=<%#Eval("CategoryID")%>' class="<%# GetTags_Actived_SubCatego((int)Eval("CategoryID")) %>">
                                                <%#Eval("DisplayName") %></a></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

    </div>
</div>
