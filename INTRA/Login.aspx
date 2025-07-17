<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="INTRA.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">
            <div class="card card-login ">
                <h3 class="category text-center">
                    <img src="assets/img_customer/logo-esteso-login.png" style="padding: 10px" />
                </h3>
                <div class="card-content">
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">perm_identity</i>
                        </span>
                        <div class="form-group label-floating">
                            <dx:ASPxTextBox ID="tbUserName" runat="server" CssClass="form-control" Width="100%" NullText="Utente">

                                <ValidationSettings ValidationGroup="LoginUserValidationGroup" ErrorTextPosition="right" Display="Dynamic" ErrorDisplayMode="Text">
                                    <RequiredField ErrorText="*" IsRequired="true" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="material-icons">lock_outline</i>
                        </span>
                        <div class="form-group label-floating">
                            <dx:ASPxTextBox ID="tbPassword" runat="server" Password="true" Width="100%" CssClass="form-control" NullText="Password">
                                <ValidationSettings ValidationGroup="LoginUserValidationGroup" ErrorTextPosition="Right" Display="Dynamic" ErrorDisplayMode="Text">
                                    <RequiredField ErrorText="*" IsRequired="true" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="footer text-center" style="padding: 10px; margin: 0px">
                    <dx:ASPxButton ID="btnLogin" runat="server" Text="Log In" ValidationGroup="LoginUserValidationGroup" Width="100%"
                        OnClick="btnLogin_Click" CssClass="btn btn-info ">
                    </dx:ASPxButton>
                </div>
                <div>
                    <div style="text-align: center">
                        <a href="/users/Invio_Email_RecuperoDati.aspx">Password dimenticata?</a>
                    </div>
                </div>
                <%--<div>
                    <div style="text-align: center">
                        <a href="RichiestaRegistrazione.aspx">Richiesta registrazione per i già clienti</a>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
