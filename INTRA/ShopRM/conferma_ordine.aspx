<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="conferma_ordine.aspx.cs" Inherits="INTRA.ShopRM._conferma_ordine" %>

<%--<%@ Register Src="~/ShopRM/controls/LeftMenuPannelloCustomer.ascx" TagName="LeftMenuPannelloCustomer" TagPrefix="uc7" %>
<%@ Register Src="~/ShopRM/controls/DisplayAreaInterna.ascx" TagName="DisplayAreaInterna" TagPrefix="uc6" %>
<%@ Register Src="~/ShopRM/controls/16PlusTopMenuAiuto.ascx" TagPrefix="MsgBox" TagName="PlusTopMenuAiuto" %>
<%@ Register Src="~/ShopRM/controls/16PlusDisplayBannerImgRandom.ascx" TagPrefix="Banner" TagName="PlusDisplayBannerImgRandom" %>--%>
<%@ Register Src="~/ShopRM/controls/16SHP_CartView.ascx" TagPrefix="Banner" TagName="SHP_CartView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="information-blocks">
<%--        <Banner:PlusDisplayBannerImgRandom runat="server" ID="PlusDisplayBannerImgRandom" />--%>

        <div class="information-blocks">
            <div class="row">
                <Banner:SHP_CartView runat="server" ID="SHP_CartView" />

            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
