<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.Master" AutoEventWireup="true" CodeBehind="QrCode_Giornata.aspx.cs" Inherits="INTRA.QrCode_Giornata" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="src/styles.css" />
    <%--<link rel="stylesheet" href="IconPicker-master/dist/fontawesome-5.11.2/css/all.min.css" />--%>
    <script src="/src/qr_packed.js"></script>

    <div class="row">
        <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">
            <style>
                a:visited {
                    color: blue !important;
                }

                a:hover {
                    color: blue !important;
                }

                .tastoqrcode {
                    background: gray;
                    color: white;
                    padding: 20px 60px;
                    border-radius: 6px;
                    font-size: large;
                }

                .myLbl {
                    font-size: 22px;
                }

                .enableMultiLine {
                    white-space: pre-wrap;
                    font-size: 20px;
                    width: 100%;
                    padding: 0;
                    margin: 0;
                }


                /*.card-login .card-content {
                padding: 0px 10px 0px 10px;
            }*/
                .btn.btn-lg, .btn-group-lg .btn, .navbar .navbar-nav > li > a.btn.btn-lg, .btn-group-lg .navbar .navbar-nav > li > a.btn {
                    font-size: 33px;
                }
            </style>


<%--            <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>--%>
            <div class="card card-login ">
                <h3 class="category text-center">
                    <img src="assets/img_customer/favicon.png" style="padding-left: 130px; padding-right: 130px;" />
                </h3>

                <h3 class="category text-center">GESTIONE GIORNATA</h3>
                <div class="category text-center" style="margin: auto; width: 100%; padding: 20px; padding-top:2px !important; padding-bottom:2px !important;">
                    <canvas hidden="" id="qr-canvas"></canvas>
                    <%-- <button type="button" class="btn btn-primary btn-lg" id="TastoQrCode_Btn">LEGGI QRCODE</button>--%>
                    <a id="TastoQrCode_Btn" class="" style="cursor: pointer; width: 100%;">
                        <%-- <img src="img/leggi-qrcode.png" style="max-width: 360px" />--%>
                        <div class="btn btn-info btn-lg btn-block">Leggi QrCode</div>

                    </a>
                    <a class="" style="cursor: pointer; width: 100%; display: none !important;" href="javascript:click()">
                        <%-- <img src="img/leggi-qrcode.png" style="max-width: 360px" />--%>
                        <div class="btn btn-info btn-lg btn-block">Leggi QrCode</div>
                        <script>
                            function click() {
                                Accesso_Callbackpnl.PerformCallback('A001-apri');
                            }
                        </script>
                    </a>


                </div>
                <div class="card-content">
                    <div class="input-group">

                        <div class="form-group text-center">
                        </div>

                    </div>

                    <div class="input-group">
                        <div class="form-group label-floating">
                            <dx:ASPxCallbackPanel ID="Accesso_Callbackpnl" ClientInstanceName="Accesso_Callbackpnl" runat="server" Width="100%" OnCallback="Accesso_Callbackpnl_Callback">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <%--  <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                    <span class="input-group-addon"  style="float:left !important;">
                                        <i class="far fa-play-circle" style="color: green; font-size: 24px; display: inline !important; padding-right:5px"></i>
                                        <dx:ASPxLabel runat="server" ID="Giornata_Lbl" ClientInstanceName="Giornata_Lbl" ForeColor="Green"  CssClass="myLbl" ></dx:ASPxLabel>
                                    </span>
                                  </div>--%>

                                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                            <span class="input-group-addon" style="float: left !important; width: 100%; vertical-align: top">
                                                <i class="fas fa-bullhorn " style="float: left !important; color: orange; font-size: 24px; display: inline !important; padding-right: 5px" runat="server" id="Errore_Icon" visible="false"></i>
                                                <dx:ASPxLabel runat="server" ID="Errore_Lbl" ClientInstanceName="Errore_Lbl" ForeColor="Orange" CssClass="enableMultiLine" EncodeHtml="false" Width="100%"></dx:ASPxLabel>

                                            </span>

                                        </div>
                                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="padding-bottom:10px !important;">
                                            <span class="input-group-addon" style="float: left !important; width: 100%; vertical-align: top">
                                                <i class="fas fa-bullhorn " style="float: left !important; color: green; font-size: 24px; display: inline !important; padding-right: 5px" runat="server" id="Messaggio_Icon" visible="false"></i>
                                                <dx:ASPxLabel runat="server" ID="Messaggio_Lbl" ClientInstanceName="Messaggio_Lbl" ForeColor="Green" CssClass="enableMultiLine" EncodeHtml="false" Width="100%"></dx:ASPxLabel>
                                            </span>
                                        </div>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>

                        </div>
                    </div>
                </div>
                <div class="footer text-center" style="padding: 20px; padding-top:2px !important; padding-bottom:2px !important;">
                    <%--   <dx:ASPxButton ID="btnLogin" runat="server" Text="Ritorna alla dashboard" AutoPostBack="false" CssClass="btn btn-danger ">
                    <ClientSideEvents Click="function(s,e){window.location.href = 'default.aspx'}" />
                </dx:ASPxButton>--%>
                    <dx:BootstrapButton runat="server" ClientVisible="false" AutoPostBack="false" ID="Errore_Btn" ClientInstanceName="Errore_Btn" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-warning btn-lg btn-block ">
                        <Badge Text="Chiudi Giornata" />
                        <SettingsBootstrap RenderOption="Warning" />
                        <ClientSideEvents Click="function(s,e){Chiudi_Giornata_Callback.PerformCallback();}" />
                    </dx:BootstrapButton>
                    <a id="UrlHome" runat="server" href="~/ShopRM/Default.aspx">
                        <div class="btn btn-danger btn-lg btn-block" style="margin: auto; width: 100%; padding: 20px;">Dashboard</div>
                    </a>
                </div>
            </div>

        </div>
    </div>
    <script src="/src/qrCodeScanner.js"></script>
    <dx:ASPxCallback runat="server" ID="Chiudi_Giornata_Callback" ClientInstanceName="Chiudi_Giornata_Callback" OnCallback="Chiudi_Giornata_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){sessionStorage.setItem('ActionChiudi','true'); window.location = '/QrCode_Giornata.aspx';}" />
    </dx:ASPxCallback>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        window.onload = function () {
            if (sessionStorage.getItem('ActionChiudi') == 'true') {
                sessionStorage.setItem('ActionChiudi', 'false');
                showNotification();
            }
        }
    </script>
</asp:Content>
