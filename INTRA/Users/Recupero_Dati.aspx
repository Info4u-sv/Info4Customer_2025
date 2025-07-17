<%@ Page Title="" Language="C#" MasterPageFile="~/empty.Master" AutoEventWireup="true" CodeBehind="Recupero_Dati.aspx.cs" Inherits="INTRA.Users.Recupero_Dati" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
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
    <div class="row">
        <div class="col-md-6 col-sm-6 col-md-offset-3 col-sm-offset-3">

            <div class="card card-login ">
                <div class="card-header text-center" data-background-color="#0055A6">
                    <h4 class="card-title">
                        <img src='<%= Page.ResolveUrl("~/ShopRM/static/img/info4u-logo.png")%>' /></h4>

                </div>

                <div class="card-content" style="padding: 10px !important;">

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
                                                            <ClientSideEvents Validation="OnPassValidation" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                       <dx:LayoutItem Caption=" ">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                 <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <i class="material-icons">vpn_key</i>
                                                    </span>
                                                    <div class="form-group label-floating">
                                                    <dx:ASPxRatingControl ID="ratingControl" runat="server" ReadOnly="true" ItemCount="5" Value="0" ClientInstanceName="ratingControl"></dx:ASPxRatingControl>
                                               <br />
                                                <div style="padding-top: 10px; padding-bottom: 10px">
                                                    <dx:ASPxLabel ID="ratingLabel" runat="server" ClientInstanceName="ratingLabel" Text="Inserire Password" />
                                                </div>
                                                        </div></div>

                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="">
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
                    <div class="col-lg-12 col-md-12" style="text-align: center;">
                        <dx:ASPxLabel runat="server" ID="InvioSuccesso_Lbl" ClientInstanceName="InvioSuccesso_Lbl" Font-Size="Large"></dx:ASPxLabel>
                        <br />
                        <a href="/login.aspx" style="text-align: center">Ritorna alla pagina di login</a>
                        <dx:ASPxCallback runat="server" ID="CambiaPassword_Callback" ClientInstanceName="CambiaPassword_Callback" OnCallback="CambiaPassword_Callback_Callback">
                            <ClientSideEvents EndCallback="function(s,e){showNotification();FormLayout.SetVisible(false);InvioSuccesso_Lbl.SetText('Email cambiata con successo.')}" />
                        </dx:ASPxCallback>
                    </div>

                </div>

            </div>

        </div>
    </div>









</asp:Content>

