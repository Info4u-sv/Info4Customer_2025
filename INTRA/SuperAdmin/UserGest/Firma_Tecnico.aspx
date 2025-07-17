<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Firma_Tecnico.aspx.cs" Inherits="IntranetTemplate2017.SuperAdmin.UserGest.Firma_Tecnico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-bottom: 5px;">
            <button id="SalvaFirma_Btn" runat="server" type="button" validationgroup="ValidGrp" class="btn btn-large btn-success button save" onserverclick="SalvaFirma_Btn_ServerClick" data-action="save">Conferma</button>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="signature-pad" class="m-signature-pad" style="height: 500px!important">
                <div class="m-signature-pad--body">
                    <canvas></canvas>
                </div>
                <div class="m-signature-pad--footer">
                    <div class="description">Sign above
                        <asp:TextBox type="text" name="output" class="output" ID="signatureOut" runat="server" ClientIDMode="Static" /></div>
                    <button type="button" class="btn btn-large btn-success button clear" data-action="clear">Cancella</button>
                    <button id="Button1" runat="server" type="button" validationgroup="ValidGrp" class="btn btn-large btn-success button save" data-action="save">Genera</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script src="/assets/js/validation/formValidation.min.js"></script>
    <script src="/assets/js/validation/framework/bootstrap.min.js"></script>
    <script src="/assets/js/signature_pad_master/signature_pad.js"></script>
    <link href="/assets/css/signature_pad_master/signature-pad.css" rel="stylesheet" />
    <script src="/assets/js/signature_pad_master/app.js"></script>
</asp:Content>
