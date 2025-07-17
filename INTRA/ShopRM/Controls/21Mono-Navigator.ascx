<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="21Mono-Navigator.ascx.cs" Inherits="INTRA.ShopRM.Controls._21Mono_Navigator" %>
<style>
    a.colorePrimario {
        color: white !important;
    }

    a.colorePrimario {
        color: white !important;
    }

    b.colorePrimario {
        color: white !important;
    }

    .logo-piccola {
        width: 100px;
        height: auto;
        max-width: 100%;
        transition: width 0.3s ease;
    }

    @media (max-width: 600px) {
        .logo-piccola {
            width: 100px;
        }
    }

    @media (max-width: 400px) {
        .logo-piccola {
            width: 80px;
        }
    }
    .link-hover-effect {
        color: white !important;
        background-color: transparent !important;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .link-hover-effect:hover {
        background-color: transparent !important;
        text-decoration: underline;
    }
    @media (max-width: 991px) {
        .submenu .col-lg-12 {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding-left: 20px; 
}
  .submenu a {
    display: block !important;
    width: 100% !important;
    padding: 10px 0;
    padding-left: 20px;
  }
}
    @media (max-width: 1199px) {
  nav > ul > li {
    float: none;
    border-bottom: 1px white solid;
    padding: 0;
    position: relative;
  }
}
    @media screen and (min-width: 992px) {
  .submenu .col-lg-12 {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding-left: 20px; 
  }

  .submenu a {
    display: block;
    padding: 8px 0;
    width: 100%;
    padding-left: 20px; 
  }
}
    @media (max-width: 767px) {
  li.liborder {
    border-top: 1px solid white;
  }
}
</style>
<script>
    function logoutNow() {
        window.location.href = '/login.aspx';
    }
</script>
<nav>
    <ul class="Nav4u">
        <li class="full-width liborder">
            <a href="/ShopRM/Default.aspx" class="link-hover-effect">Catalogo</a><i class="fa fa-chevron-down"></i>
            <div class="submenu">
                <div class="row">
                    <div class="col-lg-12">
                        <asp:Panel ID="PanelcategoMenuMeno2" runat="server" Visible="true">
                            <asp:ObjectDataSource ID="CategoPadreObjectDS" runat="server" SelectMethod="GetAllSHPCategoryPrincipali"
                                TypeName="SHPCategory"></asp:ObjectDataSource>
                            <asp:SqlDataSource ID="CategoPadre_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="U_SHP_GetAllSHPCategory" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            <asp:ListView ID="GrandiEletrMieleListView" runat="server" DataSourceID="CategoPadre_Dts" DataKeyNames="CategoryID" ItemPlaceholderID="ItemContainer">
                                <LayoutTemplate>
                                    <asp:PlaceHolder ID="ItemContainer" runat="server" />
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <a href='/ShopRM/Categorie_Merceologiche.aspx?Set=<%# Eval("Settore") %>' style="color: #2e2e2e !important; background-color: transparent !important" class="link-hover-effect">
                                        <%#Eval("DisplayName") %></a>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </li>
        <li class="full-width">
            <a href="#" class="link-hover-effect">CONTABILE</a><i class="fa fa-chevron-down"></i>
            <div class="submenu">
                <div class="row">
                    <div class="col-lg-12">
                        <a runat="server" href="~/ShopRM/i_miei_ordini.aspx" style="color: #2e2e2e !important; background-color: transparent !important;" class="link-hover-effect">I miei ordini</a>
                        <a runat="server" href="~/ShopRM/Lista_DDT.aspx" style="color: #2e2e2e !important; background-color: transparent !important" class="link-hover-effect">Le mie bolle</a>
                        <a runat="server" href="~/ShopRM/Lista_Fatture.aspx" style="color: #2e2e2e !important; background-color: transparent !important" class="link-hover-effect">Le mie fatture</a>
                    </div>
                </div>
            </div>
        </li>
        <li class="full-width">
            <a href="#" class="link-hover-effect">ASSISTENZA</a><i class="fa fa-chevron-down"></i>
            <div class="submenu">
                <div class="row">
                    <div class="col-lg-12">
                        <a runat="server" href="~/Ticket/TCK_Insert.aspx" style="color: #2e2e2e !important; background-color: transparent !important" class="link-hover-effect">Inserisci Nuovo Ticket</a>
                        <a runat="server" href="~/Ticket/TCK_List.aspx" style="color: #2e2e2e !important; background-color: transparent !important" class="link-hover-effect">I Miei Ticket</a>
                    </div>
                </div>
            </div>
        </li>
        <li class="full-width">
            <a runat="server" href="~/ShopRM/Macchinari_Cliente.aspx" class="link-hover-effect">Le mie macchine</a>
        </li>
    </ul>




    <div class="clear"></div>
    <div class="clear"></div>
    <%--    <a class="fixed-header-visible additional-header-logo" href="~/ShopRM/default.aspx" id="logoResp" runat="server">
        <img src='<%= Page.ResolveUrl("~/ShopRM/static/img/logo-3.png")%>' alt="" /></a>--%>
</nav>

