<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.Master" AutoEventWireup="true" CodeBehind="Invio_Email_RecuperoDati.aspx.cs" Inherits="INTRA.Users.Invio_Email_RecuperoDati" %>

<%--<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" tagprefix="dx" %>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .card-login .card-content {
            padding: 5px;
        }

        .card [data-background-color] {
            color: #ffffff;
        }

        .card [data-background-color] {
            box-shadow: none;
            padding: 15px;
            background-color: #ffff;
            position: relative;
            margin: 0px;
        }
    </style>
    <div class="row">
        <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">

            <div class="card card-login ">
                <div class="card-header text-center" data-background-color="#0055A6">
                    <h4 class="card-title">
                        <img src='<%= Page.ResolveUrl("~/ShopRM/static/img/info4u-logo.png")%>' /></h4>
                </div>
                <h3 style="text-align: center">Solo per clienti già registrati</h3>
                <div class="card-content">
                    <dx:ASPxPanel ID="PannelloRecupero_Panel" ClientInstanceName="PannelloRecupero_Panel" runat="server" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent>
                                <div class="col-lg-12 col-md-12">


                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="material-icons">perm_identity</i>
                                        </span>
                                        <div class="form-group label-floating">
                                            <dx:ASPxTextBox runat="server" ID="User_Txt" CaptionSettings-Position="Top" ClientInstanceName="User_Txt" Width="100%" CssClass="form-control maxWidth" NullText="Utente">
                                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12">
                                    <dx:ASPxButton ID="InviaEmail_Btn" ClientInstanceName="InviaEmail_Btn" runat="server" Text="INVIA" AutoPostBack="false" Width="100%" CssClass="btn">
                                        <ClientSideEvents Click="
                                    function(s,e){
                                    
                                    if(User_Txt.isValid){
                                    InviaMailRecupero_Callback.PerformCallback();
                                    
                                    }
                                    }" />
                                    </dx:ASPxButton>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxPanel>
                    <div class="col-lg-12 col-md-12" style="text-align: center;">
                        <dx:ASPxLabel runat="server" ID="InvioSuccesso_Lbl" ClientInstanceName="InvioSuccesso_Lbl" Font-Size="Large"></dx:ASPxLabel>
                        <br />
                        <a href="/login.aspx" style="text-align: center">Ritorna alla pagina di login</a>

                    </div>



                    <dx:ASPxCallback runat="server" ID="InviaMailRecupero_Callback" ClientInstanceName="InviaMailRecupero_Callback" OnCallback="InviaMailRecupero_Callback_Callback">
                        <ClientSideEvents EndCallback="function(s,e){showNotification();PannelloRecupero_Panel.SetVisible(false);InvioSuccesso_Lbl.SetText('Password inviata con successo, controlla la tua casella.')}" />
                    </dx:ASPxCallback>






                </div>

            </div>

        </div>
    </div>









</asp:Content>

