<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ticket_Firma.aspx.cs" Inherits="INTRA.Ticket.Ticket_Firma" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #sidebar {
            display: none !important;
        }

        .page-header.position-relative {
            display: none !important;
        }

        .navbar.navbar-fixed-top {
            display: none !important;
        }
    </style>
    <asp:SqlDataSource ID="InfoFirmaTck" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT Società, CodRapportino, firmacliente FROM TCK_TestataTicket WHERE (CodRapportino = @IdTicket)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdTicket" QueryStringField="IdTicket" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-padding" style="margin-top: 5px;">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-bottom: 5px;">
            <div id="signature-pad" class="m-signature-pad" style="min-height: 250px!important; max-height: 300px!important; width: 80%!important">
                <asp:FormView ID="DatiFirmaTck_FW" runat="server" DataSourceID="InfoFirmaTck">
                    <ItemTemplate>
                        <asp:Label ID="DatiFirmaTck" runat="server" Font-Size="Large">&nbsp;&nbsp;Cliente: <span style="color: red"><%# Eval("società")%>   </span>
                            Ticket N°: <span style="color: red"><%# Eval("CodRapportino")%></span>
                            &nbsp;&nbsp; Responsabile: <span style="color: red">
                                <asp:Label ID="firmacliente_Lbl" runat="server" Text='<%# Eval("firmacliente")%>'></asp:Label></span>
                        </asp:Label>
                    </ItemTemplate>
                </asp:FormView>
                <div class="m-signature-pad--body">
                    <canvas></canvas>
                </div>
                <div class="m-signature-pad--footer">
                    <div class="description" style="color: black !important">
                        <asp:TextBox type="text" name="output" Style="display: none" class="output" ID="signatureOut" runat="server" ValidationGroup="ValidFirma" ClientIDMode="Static" Width="50px" />

                        <asp:LinkButton ID="SalvaFirma_Btn" Style="display: none" runat="server" ValidationGroup="ValidFirma" class="btn btn-large btn-info " OnClick="SalvaFirma_Btn_Click" ClientIDMode="Static">Conferma</asp:LinkButton>
                        <button type="button" class="btn btn-small btn-danger button clear" data-action="clear"><i class="fa fa-trash " style="font-size:15px !important;"></i>Cancella</button>
                        <button id="Button1" runat="server" type="button" validationgroup="ValidGrp" class="btn btn-small btn-success button save" data-action="save"><i class="fa fa-check" style="font-size:15px !important;"></i>Genera</button>

                    </div>
                    <div>
                    </div>

                </div>
            </div>
        </div>


    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script src="/assets/js/jquery.min.js"></script>
    <script src="/assets/js/signature_pad_master/signature_pad.js"></script>
    <link href="/assets/css/signature_pad_master/signature-pad.css" rel="stylesheet" />
    <script src="/assets/js/signature_pad_master/app.js"></script>
</asp:Content>
