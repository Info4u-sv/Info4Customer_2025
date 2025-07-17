<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="WishListRptViewer.aspx.cs" Inherits="INTRA.ShopRM.WishListRptViewer" %>

<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/21COMM_ContentAreaProdotti.ascx" TagPrefix="Banner" TagName="COMM_ContentAreaProdotti" %>
<%@ Register Src="~/ShopRM/controls/21MonoLeftMenuCatalogo.ascx" TagPrefix="Banner" TagName="PlusLeftMenuCatalogo" %>
<%@ Register Src="~/ShopRM/Controls/16PlusDisplayBannerImgRdmCatalogo.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
   
    <div class="information-blocks">
        <div class="content-push">
            <dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" runat="server" MobileMode="true"></dx:ASPxWebDocumentViewer>
        </div>
    </div>
</asp:Content>
