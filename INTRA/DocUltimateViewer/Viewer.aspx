<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Viewer.aspx.cs" Inherits="INTRA4U.DocUltimateViewer.Viewer" %>
<%@ Register TagPrefix="GleamTech" Namespace="GleamTech.DocumentUltimate" Assembly="GleamTech.DocumentUltimate" %>
<%@ Register TagPrefix="GleamTech" Namespace="GleamTech.DocumentUltimate.AspNet.WebForms" Assembly="GleamTech.DocumentUltimate" %>


<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="float: right; padding-bottom:20px">
<dx:ASPxButton ID="RitornaAllaLista_Btn" runat="server" AutoPostBack="false" Text="Ritorna alla lista" OnClick="RitornaAllaLista_Btn_Click"></dx:ASPxButton>
    </div>
   <GleamTech:DocumentViewerControl ID="documentViewer1" runat="server" 
        Width="100%" 
        Height="700"
        Resizable="True" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
