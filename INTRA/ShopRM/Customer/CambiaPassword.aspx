<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="CambiaPassword.aspx.cs" Inherits="INTRA.ShopRM.Customer.CambiaPassword" %>

<%@ Register Src="~/ShopRM/Customer/Controls/LeftMenuCustomer.ascx" TagPrefix="uc1" TagName="LeftMenuCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

        function UpdateImgTecnico(src) {
            var img = document.getElementsByClassName("tecnico")[0];
            alert(img);
            img.src = src;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuCustomer runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">Modifica Password</h2>
            </div>
            <div class="article-container">
                <p>
                    Tramite questo pannello puoi modificare la tua password di accesso all'area riservata.
                </p>
                <div runat="server" id="profilo_div" class="col-md-12">
                    <div class="card card-profile">
                        <dx:ASPxCallbackPanel runat="server" ID="ChangePassword_pnl" ClientInstanceName="ChangePassword_pnl" OnCallback="ChangePassword_pnl_Callback">
                            <PanelCollection>
                                <dx:PanelContent>
                                    <div class="card-avatar">
                                        <a>
                                            <img id="ImgTecnico_B" class="img-responsive tecnico" src="" runat="server" />
                                        </a>
                                    </div>
                                    <div class="card-content">
                                        <h6 class="category text-gray">
                                            <asp:Label ID="UserTxt" runat="server"></asp:Label></h6>
                                        <h4 class="card-title">
                                            <asp:Label ID="RegMailTxt" runat="server"></asp:Label></h4>

                                        <div class="row">
                                            <div class="col-md-12">

                                                <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%" ColumnCount="2">
                                                    <SettingsItemCaptions Location="Top" />
                                                    <Paddings PaddingBottom="30" PaddingTop="10" />
                                                    <Styles>
                                                        <LayoutGroupBox CssClass="fullWidth fullHeight"></LayoutGroupBox>
                                                        <LayoutGroup Cell-CssClass="fullWidth fullHeight"></LayoutGroup>
                                                    </Styles>
                                                    <SettingsAdaptivity>
                                                        <GridSettings>
                                                            <Breakpoints>
                                                                <dx:LayoutBreakpoint ColumnCount="1" MaxWidth="790" Name="S" />
                                                            </Breakpoints>
                                                        </GridSettings>
                                                    </SettingsAdaptivity>
                                                    <Items>
                                                        <dx:LayoutGroup Caption="Cambio password" GroupBoxDecoration="Box" Width="100%">
                                                            <GridSettings></GridSettings>
                                                            <SpanRules>
                                                                <dx:SpanRule BreakpointName="S" ColumnSpan="1" RowSpan="1" />
                                                            </SpanRules>
                                                            <Items>
                                                                <dx:LayoutItem Caption="Password" Width="100%">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer>


                                                                            <div class="input-group">
                                                                                <span class="input-group-addon">
                                                                                    <i class="fa fa-loc"></i>
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

                                                                <dx:LayoutItem Caption="Conferma password" Width="100%">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer>

                                                                            <div class="input-group">
                                                                                <span class="input-group-addon">
                                                                                    <i class="fa fa-loc"></i>
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
                                                                                <%--<span class="input-group-addon">
                                                                                    <i class="fa fa-key"></i>
                                                                                </span>--%>
                                                                                <div class="form-group label-floating">
                                                                                    <dx:ASPxRatingControl ID="ratingControl" runat="server" ReadOnly="true" ItemCount="5" Value="0" ClientInstanceName="ratingControl"></dx:ASPxRatingControl>
                                                                                    <br />
                                                                                    <div style="padding-top: 10px; padding-bottom: 10px">
                                                                                        <dx:ASPxLabel ID="ratingLabel" runat="server" ClientInstanceName="ratingLabel" Text="Inserire Password" />
                                                                                    </div>
                                                                                </div>
                                                                            </div>

                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer>
                                                                            <dx:BootstrapButton ID="BootstrapButton1" runat="server" AutoPostBack="false" Text="Modifica Password" lass="btn btn-rose btn-round">
                                                                                <ClientSideEvents Click="function(s,e){if(!passwordTextBox.isValid && !confirmPasswordTextBox.isValid)
                                                                        {return false;}
                                                                        else
                                                                        {ChangePassword_pnl.PerformCallback();}
                                                                        }" />

                                                                            </dx:BootstrapButton>

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

                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
