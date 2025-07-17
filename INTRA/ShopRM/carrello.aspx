<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="carrello.aspx.cs" Inherits="INTRA.ShopRM.carrello" %>

<%@ Register Src="~/ShopRM/Controls/16SHP_CartView.ascx" TagPrefix="Banner" TagName="SHP_CartView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
        <%-- <Banner:PlusDisplayBannerImgRandom runat="server" ID="PlusDisplayBannerImgRandom" Visible="false" />--%>
        <div class="row">
            <%--<uc1:LeftMenuTecnico runat="server" ID="LeftMenuCustomer" />--%>
            <%--<div class="col-md-3 col-sm-12 sidebar-column">
                <Banner:PlusLeftMenuCatalogo runat="server" ID="PlusLeftMenuCatalogo" />
            </div>--%>

            <div class="col-md-12 col-sm-12 information-entry" style="padding-left:10px !important; padding-right:10px !important;">
                
                    <Banner:SHP_CartView runat="server" ID="SHP_CartView" />
                
            </div>
        </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
