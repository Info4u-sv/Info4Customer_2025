<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="DashBoardCustomer.aspx.cs" Inherits="INTRA.ShopRM.Customer.DashBoardCustomer" %>
<%@ Register Src="~/ShopRM/Customer/Controls/LeftMenuCustomer.ascx" TagPrefix="uc1" TagName="LeftMenuCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuCustomer runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">My Area</h2>
            </div>
            <div class="article-container">
                <p>In questa pagina potrai controllare in qualsiasi momento i rusultati raggiunti</p>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
