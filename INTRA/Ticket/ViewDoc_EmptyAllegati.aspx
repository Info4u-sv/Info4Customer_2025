<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewDoc_EmptyAllegati.aspx.cs" Inherits="INTRA.Ticket.ViewDoc_EmptyAllegati" %>
<%@ Register TagPrefix="GleamTech" Namespace="GleamTech.DocumentUltimate" Assembly="GleamTech.DocumentUltimate" %>
<%@ Register TagPrefix="GleamTech" Namespace="GleamTech.DocumentUltimate.AspNet.WebForms" Assembly="GleamTech.DocumentUltimate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
       <style>
    .swal2-container {
        z-index: 999999 !important;
    }
</style>

            <GleamTech:DocumentViewerControl runat="server"
                Width="100%"
                Height="700" ID="DocViewer" DisableDownload="false" DisablePrint="false" Language="it-IT" LoadingMessage="Caricamento in corso..." DisableHeaderIncludes="False" FullViewport="false" />

                                <dx:ASPxGridView ID="AllegatiTck_Gridview" DataSourceID="AllegatiTck_Dts" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID" clientvisible="false">
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="PathFolder" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="AllegatiTck_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT PathFolder FROM PRT_DocumentiTCK WHERE (ID = @ID)">
                                    <SelectParameters>
                                        <asp:QueryStringParameter QueryStringField="Id" Name="ID"></asp:QueryStringParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
