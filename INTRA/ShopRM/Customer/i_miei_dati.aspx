<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="i_miei_dati.aspx.cs" Inherits="INTRA.ShopRM.Customer.i_miei_dati" %>

<%@ Register Src="~/ShopRM/controls/DisplayAreaInterna.ascx" TagName="DisplayAreaInterna" TagPrefix="uc6" %>
<%--<%@ Register Src="~/ShopRM/controls/16SHP_CartView.ascx" TagPrefix="Banner" TagName="SHP_CartView" %>--%>
<%@ Register Src="~/ShopRM/Controls/MyMessageBox.ascx" TagPrefix="uc10" TagName="MyMessageBox" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <link href="../../assets/css/material-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

    <script>
        var passwordMinLength = 6;
        function GetPasswordRating(password) {
            var result = 0;
            if (password) {
                result++;
                if (password.length >= passwordMinLength) {
                    if (/[a-z]/.test(password))
                        result++;
                    if (/[A-Z]/.test(password))
                        result++;
                    if (/\d/.test(password))
                        result++;
                    if (!(/^[a-z0-9]+$/i.test(password)))
                        result++;
                }
            }
            return result;
        }
        function GetErrorText(editor) {
            if (editor === passwordTextBox) {
                if (ratingControl.GetValue() === 1)
                    return "La password è troppo semplice";
            } else if (editor === confirmPasswordTextBox) {
                if (passwordTextBox.GetText() !== confirmPasswordTextBox.GetText())
                    return "Le password inserite non corrispondono";
            }
            return "";
        }
        function OnPasswordTextBoxInit(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassChanged(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassValidation(s, e) {
            var errorText = GetErrorText(s);
            if (errorText) {
                e.isValid = false;
                e.errorText = errorText;
            }
        }

        function ApplyCurrentPasswordRating() {
            var password = passwordTextBox.GetText();
            var passwordRating = GetPasswordRating(password);
            ApplyPasswordRating(passwordRating);
        }
        function ApplyPasswordRating(value) {
            ratingControl.SetValue(value);
            switch (value) {
                case 0:
                    ratingLabel.SetValue("Inserisci password");
                    break;
                case 1:
                    ratingLabel.SetValue("Troppo semplice");
                    break;
                case 2:
                    ratingLabel.SetValue("Non sicura");
                    break;
                case 3:
                    ratingLabel.SetValue("Normale");
                    break;
                case 4:
                    ratingLabel.SetValue("Sicura");
                    break;
                case 5:
                    ratingLabel.SetValue("Molto sicura");
                    break;
                default:
                    ratingLabel.SetValue("Inserisci password");
            }
        }
    </script>
    <style>
        .input-group-addon {
            background-color: transparent;
            border: transparent;
        }
                .dxflRequired_Office365 {
  display: none !important;
}
    </style>
    <%--   <uc7:LeftMenuPannelloCustomer ID="LeftMenuPannelloCustomer1" runat="server" />--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="information-blocks">
        <div class="row">
            <div class="col-sm-12 information-entry">
                <div class="heading-article">
                    <h2 class="title">I miei dati anagrafici</h2>
                </div>
                <div class="article-container">

                    <p>
                        Aggiorna i tuoi dati anagrafici tramite questa pagina.
                    </p>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="PanelPrivato" runat="server" Style="margin-top: 0px">

                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-xs-12">
                                        <strong>Utente:
                                            <asp:Label ID="UserTxt" runat="server" Text=""></asp:Label></strong>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 20px">
                                            <div class="dxflVATSys dxflGroupCell_Office365 fullHeight">
                                                <div class="dxflGroupBox_Office365 fullWidth fullHeight dxflGroupBoxSys">
                                                    <span class="dxflGroupBoxCaption_Office365" style="font-size: small;">Cambio E-mail</span>
                                                    <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 20px">
                                                        <dx:ASPxTextBox class="simple-field" ID="Email_Txt" ValidationGroup="Email" ClientInstanceName="Email_Txt" runat="server" Width="100%">
                                                            <ValidationSettings ErrorDisplayMode="None">
                                                                <RequiredField IsRequired="true" />
                                                            </ValidationSettings>
                                                            <InvalidStyle BackColor="LightPink" />
                                                        </dx:ASPxTextBox>
                                                        <div style="padding-top: 40px">
                                                            <dx:ASPxButton runat="server" ID="SalvaEmail_Btn" ValidationGroup="Email" Text="Conferma Variazione" ClientInstanceName="SalvaEmail_Btn" Width="100%" CssClass="btn" AutoPostBack="false">
                                                                <ClientSideEvents Click="function(s,e){if(Email_Txt.isValid){CambiaPassword_Callback.PerformCallback(2);}}" />
                                                            </dx:ASPxButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>



                                            <%--  <dx:ASPxButton runat="server" ID="SalvaEmail_Btn" ClientInstanceName="SalvaEmail_Btn" Text="Conferma Variazione" Width="100%" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s,e){if(Email_Txt.isValid){CambiaPassword_Callback.PerformCallback(2);}}" />
                                            </dx:ASPxButton>--%>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 20px">
                                            <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%" ColumnCount="2">
                                                <SettingsItemCaptions Location="Top" />
                                                <Paddings PaddingBottom="30" PaddingTop="10" />
                                                <Styles>
                                                    <LayoutGroupBox CssClass="fullWidth fullHeight"></LayoutGroupBox>
                                                    <LayoutGroup Cell-CssClass="fullHeight"></LayoutGroup>
                                                </Styles>
                                                <SettingsAdaptivity>
                                                    <GridSettings>
                                                        <Breakpoints>
                                                            <dx:LayoutBreakpoint ColumnCount="1" MaxWidth="790" Name="S" />
                                                        </Breakpoints>
                                                    </GridSettings>
                                                </SettingsAdaptivity>
                                                <Items>
                                                    <dx:LayoutGroup Caption="Cambio password" GroupBoxDecoration="Box">
                                                        <GridSettings></GridSettings>
                                                        <SpanRules>
                                                            <dx:SpanRule BreakpointName="S" ColumnSpan="1" RowSpan="1" />
                                                        </SpanRules>
                                                        <Items>
                                                            <dx:LayoutItem Caption="Password">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>


                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">
                                                                                <i class="material-icons">lock_outline</i>
                                                                            </span>
                                                                            <div class="form-group label-floating">
                                                                                <dx:ASPxTextBox ID="passwordTextBox" runat="server" ClientInstanceName="passwordTextBox" CssClass="form-control maxWidth" NullText="Password" Password="true">
                                                                                    <ValidationSettings ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText" Display="Dynamic" SetFocusOnError="true">
                                                                                        <RequiredField IsRequired="True" ErrorText="Richiesto" />
                                                                                        <ErrorFrameStyle Wrap="True" />
                                                                                    </ValidationSettings>
                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                    <ClientSideEvents Init="OnPasswordTextBoxInit" KeyUp="OnPassChanged" Validation="OnPassValidation" />
                                                                                </dx:ASPxTextBox>
                                                                            </div>
                                                                        </div>



                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                            <dx:LayoutItem Caption="Conferma password">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>

                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">
                                                                                <i class="material-icons">lock_outline</i>
                                                                            </span>
                                                                            <div class="form-group label-floating">
                                                                                <dx:ASPxTextBox ID="confirmPasswordTextBox" runat="server" ClientInstanceName="confirmPasswordTextBox" Password="true" Width="100%" CssClass="form-control maxWidth" NullText="Conferma Password">
                                                                                    <ValidationSettings ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText" Display="Dynamic" SetFocusOnError="true">
                                                                                        <RequiredField IsRequired="True" ErrorText="Richiesto" />
                                                                                        <ErrorFrameStyle Wrap="True" />
                                                                                    </ValidationSettings>
                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                    <ClientSideEvents Validation="OnPassValidation" />
                                                                                </dx:ASPxTextBox>
                                                                            </div>
                                                                        </div>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption=" " ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <div class="input-group" style="display: flex; align-items: flex-start; gap: 10px;">
                                                                            <span style="margin-top: 4px;">
                                                                                <i class="material-icons" style="font-size: 24px;">vpn_key</i>
                                                                            </span>

                                                                            <div style="display: flex; flex-direction: column;">
                                                                                <dx:ASPxRatingControl ID="ratingControl" runat="server" ReadOnly="true" ItemCount="5" Value="0" ClientInstanceName="ratingControl" />

                                                                                <div style="padding-top: 5px;">
                                                                                    <dx:ASPxLabel ID="ratingLabel" runat="server" ClientInstanceName="ratingLabel" Text="Inserisci password" />
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer>
                                                                        <dx:ASPxButton runat="server" ID="signUp" Text="Conferma Password" Width="100%" CssClass="btn" AutoPostBack="false">
                                                                            <ClientSideEvents Click="function(s,e){if(passwordTextBox.isValid && confirmPasswordTextBox.isValid){CambiaPassword_Callback.PerformCallback();}}" />
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                        </Items>
                                                    </dx:LayoutGroup>
                                                </Items>
                                            </dx:ASPxFormLayout>
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxCallback runat="server" ID="CambiaPassword_Callback" ClientInstanceName="CambiaPassword_Callback" OnCallback="CambiaPassword_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){showNotification();}" />
    </dx:ASPxCallback>
    <asp:SqlDataSource runat="server" ID="AppoggioUpd_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT EmailContatto FROM VIO_Utenti WHERE (UtenteIntranet = @UtenteIntranet)" UpdateCommand="UPDATE VIO_Utenti SET EmailContatto = @EmailContatto WHERE (UtenteIntranet = @UtenteIntranet)">
        <SelectParameters>
            <asp:ProfileParameter PropertyName="Name" Name="UtenteIntranet" Type="String"></asp:ProfileParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="EmailContatto"></asp:Parameter>
            <asp:Parameter Name="UtenteIntranet"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <script src="../../assets/js/jquery-3.2.1.min.js"></script>
    <link href="../../content/toastr.css" rel="stylesheet" />
    <script src="../../assets/js/toastr/toastr.js"></script>
    <script>
        function showNotification() {
            toastr.options.positionClass = "toast-top-right";
            options = {
                tapToDismiss: true,
                toastClass: 'toast',
                containerId: 'toast-container',
                debug: false,
                fadeIn: 300,
                fadeOut: 1000,
                extendedTimeOut: 1000,
                iconClass: 'toast-info',
                positionClass: 'toast-top-right',
                timeOut: 5000, // Set timeOut to 0 to make it sticky
                titleClass: 'toast-title',
                messageClass: 'toast-message'
            }
            toastr.options.positionClass = "toast-top-right";
            toastr.options.timeOut = 1500;
            toastr.success("Operazione eseguita con successo!", "Operazione eseguita");

        }
        function Notify(msg, title, type, clear, pos, sticky) {
            toastr.options.positionClass = "toast-bottom-right";
            toastr.options.positionClass = "toast-bottom-left";
            toastr.options.positionClass = "toast-top-right";
            toastr.options.positionClass = "toast-top-left";
            toastr.options.positionClass = "toast-bottom-full-width";
            toastr.options.positionClass = "toast-top-full-width";
            options = {
                tapToDismiss: true,
                toastClass: 'toast',
                containerId: 'toast-container',
                debug: false,
                fadeIn: 300,
                fadeOut: 1000,
                extendedTimeOut: 1000,
                iconClass: 'toast-info',
                positionClass: 'toast-top-right',
                timeOut: 5000, // Set timeOut to 0 to make it sticky
                titleClass: 'toast-title',
                messageClass: 'toast-message'
            }


            if (clear == true) {
                toastr.clear();
            }
            if (sticky == true) {
                toastr.tapToDismiss = true;
                toastr.timeOut = 5000;
            }

            toastr.options.onclick = function () {
                //alert('You can perform some custom action after a toast goes away');
            }
            //"toast-top-left";
            toastr.options.positionClass = pos;
            if (type.toLowerCase() == 'info') {
                toastr.options.timeOut = 1000;
                toastr.tapToDismiss = true;
                toastr.info(msg, title);
            }
            if (type.toLowerCase() == 'success') {
                toastr.options.timeOut = 1500;
                toastr.success(msg, title);
            }
            if (type.toLowerCase() == 'warning') {
                toastr.options.timeOut = 3000;
                toastr.warning(msg, title);
            }
            if (type.toLowerCase() == 'error') {
                toastr.options.timeOut = 10000;
                toastr.error(msg, title);
            }
        }
        window.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".dxflCaption_Office365").forEach(caption => {
                const alreadyHasCustomStar = caption.querySelector(".custom-required-star");

                if (!alreadyHasCustomStar && !caption.innerHTML.includes("*")) {
                    caption.insertAdjacentHTML("beforeend", `<span class="custom-required-star" style="color: green; font-style: normal; margin-left: 4px; font-size: 0.8em;">*</span>`);
                }
            });
        });

    </script>

</asp:Content>
