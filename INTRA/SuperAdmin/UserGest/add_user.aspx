<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="add_user.aspx.cs" Inherits="IntranetTemplate2017.SuperAdmin.UserGest.add_user" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .btn-utente {
            margin: 0px !important;
        }
    </style>
    <dx:ASPxCallbackPanel ID="UserCallbackPanel" runat="server" ClientInstanceName="UserCallbackPanel" OnCallback="UserCallbackPanel_Callback">
        <PanelCollection>
            <dx:PanelContent>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="version-text" style="position: absolute; top: 1px; right: 45px; font-size: 13px; color: #999; font-family: 'Helvetica Neue', Arial, sans-serif; font-style: italic; z-index: 999;">
                                Versione 7/2025
                            </div>
                            <div class="card-header card-header-icon" data-background-color="blue">
                                <i class="material-icons">assignment</i>
                            </div>
                            <div class="card-content">
                                <h4 class="card-title">Aggiungi Utente</h4>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <h3>Ruolo:</h3>
                                    <dx:ASPxCheckBoxList ID="UserRoles" ClientInstanceName="UserRoles" runat="server" ValueType="System.String" Theme="Office365"></dx:ASPxCheckBoxList>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <h3>Informazioni Generali:</h3>
                                    Utente Attivo:
                        <dx:ASPxCheckBox ID="ASPxCheckBox1" runat="server" Checked="true" Theme="Office365"></dx:ASPxCheckBox>
                                    <br />

                                    Username:
                        <dx:ASPxTextBox ID="username_Txt" ClientInstanceName="username_Txt" runat="server" Width="170px" Theme="Office365" AutoCompleteType="Disabled" ValidationGroup="UserForm" ClientVisible="true"
                            EnableClientSideAPI="true">
                            <ValidationSettings>
                                <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto" />
                            </ValidationSettings>
                        </dx:ASPxTextBox>
                                    <br />

                                    Password:
                        <dx:ASPxTextBox ID="password_Txt" ClientInstanceName="password_Txt" runat="server" Width="170px" Password="true" Theme="Office365" AutoCompleteType="Disabled" ValidationGroup="UserForm" ClientVisible="true"
                            EnableClientSideAPI="true">
                            <ValidationSettings>
                                <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto" />
                            </ValidationSettings>
                        </dx:ASPxTextBox>
                                    <br />
                                    Email:
                                    <dx:ASPxLabel ID="EmailError_Lbl" ClientInstanceName="EmailError_Lbl" runat="server" ForeColor="Red"></dx:ASPxLabel>
                                    <dx:ASPxTextBox ID="email" ClientInstanceName="email" runat="server" Width="170px" Theme="Office365" ValidationGroup="UserForm" ClientVisible="true"
                                        EnableClientSideAPI="true">
                                        <ValidationSettings>
                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto" />
                                            <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="L'email non è valida." />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                    <br />
                                    Comment:
                        <dx:ASPxTextBox ID="comment" ClientInstanceName="comment" runat="server" Width="170px" Theme="Office365"></dx:ASPxTextBox>
                                    <br />
                                    <dx:BootstrapButton ID="submit" runat="server"
                                        AutoPostBack="false"
                                        Badge-CssClass="BadgeBtn-just-icon"
                                        CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-utente"
                                        Text="">
                                        <Badge IconCssClass="fa fa-user-plus" Text="Aggiungi Utente" />
                                        <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                    </dx:BootstrapButton>

                                    <dx:BootstrapButton ID="reset" runat="server"
                                        AutoPostBack="true"
                                        CausesValidation="false"
                                        OnClick="reset_Click"
                                        Badge-CssClass="BadgeBtn-just-icon"
                                        CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-utente btn-warning"
                                        Text="">
                                        <Badge IconCssClass="fa fa-trash" Text="Annulla Operazione" />
                                        <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                    </dx:BootstrapButton>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            console.log("DOM PRONTO!");

            // Associa evento fine callback per resettare campi
            if (typeof UserCallbackPanel !== "undefined") {
                UserCallbackPanel.EndCallback.AddHandler(function (s, e) {
                    if (s.cpResetForm) {
                        username_Txt.SetText("");
                        password_Txt.SetText("");
                        email.SetText("");
                        comment.SetText("");
                        UserRoles.UnselectAll();
                        EmailError_Lbl.SetText("");
                    }

                });
            }

            // Prendo il bottone "submit"
            var submitBtn = document.getElementById('<%= submit.ClientID %>');

            if (submitBtn) {
                submitBtn.addEventListener("click", function (e) {
                    e.preventDefault();
                    UserCallbackPanel.PerformCallback();
                    showNotification();
                });
            } else {
                console.error("submitBtn non trovato");
            }
        });
    </script>


</asp:Content>
