<%@ Page Title="" Language="C#" MasterPageFile="~/EmptyRegister.Master" AutoEventWireup="true" CodeBehind="RichiestaRegistrazione.aspx.cs" Inherits="INTRA.RichiestaRegistrazione" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        @media(max-width:840px) {
            .mobileGroupIndent {
                padding-top: 20px;
            }
        }

        .mobileAlign {
            text-align: center !important;
        }

        .maxWidth {
            max-width: 360px !important;
        }

        .fullHeight {
            height: 100% !important;
        }

        .fullWidth {
            width: 100% !important;
        }

        .register-page .container {
            padding-top: 5vh;
        }

        .card [data-background-color] {
            color: #ffffff;
        }

        .card [data-background-color] {
            box-shadow: none;
            padding: 15px;
            background-color: #ffff;
            position: relative;
        }
    </style>
    <script type="text/javascript">
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
        function OnPasswordTextBoxInit(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassChanged(s, e) {

            ApplyCurrentPasswordRating();
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
                    ratingLabel.SetValue("Sicurezzza Password");
                    break;
                case 1:
                    ratingLabel.SetValue("Troppo seplice");
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
                    ratingLabel.SetValue("Sicurezzza Password");
            }
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
        function OnPassValidation(s, e) {
            var errorText = GetErrorText(s);
            if (errorText) {
                e.isValid = false;
                e.errorText = errorText;
            }
        }
        function onControlsInitialized(s, e) {
            FormLayout.AdjustControl();
            var controls = ASPxClientControl.GetControlCollection().GetControlsByPredicate(function (c) {
                return c.GetParentControl() === FormLayout;
            });
            for (var i = 0; i < controls.length; i++) {
                var valEvt = controls[i].Validation;
                if (valEvt)
                    valEvt.AddHandler(onValidation);
            }
        }
        function onValidation(s, e) {
            setTimeout(function () { FormLayout.AdjustControl(); }, 0);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="card card-signup">
                <div class="card-header text-center" data-background-color="#fff !important">
                    <h4 class="card-title">
                        <img src='<%= Page.ResolveUrl("~/ShopRM/static/img/info4u-logo.png")%>' style="height: 80px; width: auto" /></h4>

                </div>
                <h2 class="card-title text-center">Richiesta registrazione</h2>
                <div class="card-title text-center"><strong style="color: red">NB. Verranno valutate le richieste per i soli clienti già iscritti all'anagrafica</strong></div>

                <div class="row">
                    <dx:ASPxCallbackPanel runat="server" Width="100%" ID="Registrazione_CallbackPnl" ClientInstanceName="Registrazione_CallbackPnl" OnCallback="Registrazione_CallbackPnl_Callback" OnCustomJSProperties="Registrazione_CallbackPnl_CustomJSProperties">
                        <ClientSideEvents EndCallback="function(s,e){ if(s.cpErrorPopup == 1){popuperror.Show();}}" />
                        <PanelCollection>
                            <dx:PanelContent>

                                <dx:ASPxFormLayout ID="FormLayout" OptionalMark=" " ClientInstanceName="FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%" ColumnCount="2">
                                    <Paddings PaddingBottom="30" PaddingTop="10" />
                                    <Styles>
                                        <LayoutGroupBox CssClass="fullWidth fullHeight"></LayoutGroupBox>
                                        <LayoutGroup Cell-CssClass="fullHeight"></LayoutGroup>
                                    </Styles>
                                    <SettingsAdaptivity>
                                        <GridSettings ChangeCaptionLocationAtWidth="400">
                                            <Breakpoints>
                                                <dx:LayoutBreakpoint ColumnCount="2" MaxWidth="790" Name="S" />
                                            </Breakpoints>
                                        </GridSettings>
                                    </SettingsAdaptivity>
                                    <Items>
                                        <dx:LayoutGroup Caption="Dati per la richiesta" ColumnSpan="2" ColumnCount="2" GroupBoxDecoration="Box">
                                            <GridSettings ChangeCaptionLocationAtWidth="400"></GridSettings>
                                            <SpanRules>
                                                <dx:SpanRule BreakpointName="S" ColumnSpan="2" RowSpan="1" />
                                            </SpanRules>
                                            <Items>
                                                <dx:LayoutItem Caption="Ragione sociale" ColumnSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxTextBox ID="RagioneSOciale_Txt" runat="server" NullText="Ragione sociale" Width="100%" CssClass="maxWidth">
                                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="None" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true" ValidationGroup="NewUserIns">
                                                                    <RequiredField IsRequired="true" />
                                                                </ValidationSettings>
                                                                <InvalidStyle BackColor="LightPink" />
                                                            </dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Partita IVA" ColumnSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxTextBox ID="PartitaIva_Txt" runat="server" NullText="Partita IVA" Width="100%" CssClass="maxWidth">
                                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="None" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true" ValidationGroup="NewUserIns">
                                                                    <RequiredField IsRequired="true" />
                                                                </ValidationSettings>
                                                                <InvalidStyle BackColor="LightPink" />
                                                            </dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                                <dx:LayoutItem Caption="Nome completo" ColumnSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxTextBox ID="NomeCognome_Txt" runat="server" NullText="Nome e cognome" Width="100%" CssClass="maxWidth">
                                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="None" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true" ValidationGroup="NewUserIns">
                                                                    <RequiredField IsRequired="true" />
                                                                </ValidationSettings>
                                                                <InvalidStyle BackColor="LightPink" />
                                                            </dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Codice Fiscale" ColumnSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxTextBox ID="CodiceFiscale_Txt" runat="server" NullText="Codice Fiscale" Width="100%" CssClass="maxWidth">
                                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="None" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true" ValidationGroup="NewUserIns">
                                                                    <RequiredField IsRequired="true" />
                                                                </ValidationSettings>
                                                                <InvalidStyle BackColor="LightPink" />
                                                            </dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                                <dx:LayoutItem Caption="E-mail" ColumnSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxTextBox ID="Email_Txt" runat="server" NullText="Email" Width="100%" CssClass="maxWidth">
                                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="None" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true" ValidationGroup="NewUserIns">
                                                                    <RequiredField IsRequired="true" />
                                                                    <RegularExpression ErrorText="E-mail non valida" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                                </ValidationSettings>
                                                                <InvalidStyle BackColor="LightPink" />
                                                            </dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutGroup ShowCaption="False" HorizontalAlign="Center" ColumnSpan="2">
                                            <ParentContainerStyle CssClass="mobileGroupIndent">
                                            </ParentContainerStyle>
                                            <SpanRules>
                                                <dx:SpanRule BreakpointName="S" ColumnSpan="1" RowSpan="1" />
                                            </SpanRules>
                                            <Items>
                                                <dx:LayoutItem ShowCaption="False" Caption=" " CssClass="mobileAlign" HorizontalAlign="Center" CaptionSettings-Location="Top" CaptionCellStyle-CssClass="hidden">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxCaptcha runat="server" ID="captcha" TextBox-Position="Bottom" TextBox-ShowLabel="false" TextBoxStyle-Width="100%" Width="200" ValidationSettings-RequiredField-IsRequired="true" RefreshButton-Text="Genera un nuovo codice">
                                                                <RefreshButtonStyle Font-Underline="true"></RefreshButtonStyle>

                                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="None" SetFocusOnError="true" ErrorFrameStyle-Wrap="true" ValidationGroup="NewUserIns" ErrorText="Valore Obbligatorio">
                                                                    <ErrorFrameStyle Wrap="True" />
                                                                    <RequiredField IsRequired="true" />
                                                                </ValidationSettings>
                                                            </dx:ASPxCaptcha>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem ShowCaption="False" CssClass="mobileAlign" HorizontalAlign="Center" CaptionSettings-Location="Top" CaptionCellStyle-CssClass="hidden">
                                                    <NestedControlCellStyle CssClass="maxWidth"></NestedControlCellStyle>
                                                    <Paddings PaddingTop="12" />
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            Iscrivendoti accetti i  <a href="RM_TerminiServizio.aspx" target="_blank">termini di servizio</a> e l' <a href="RM_Privacy.aspx" target="_blank">informativa sulla privacy</a>.
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False" Width="100%" CaptionSettings-Location="Top" CaptionCellStyle-CssClass="hidden">
                                                    <Paddings PaddingTop="20" />
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxButton runat="server" ID="signUp" Text="Invia" Width="200px" CssClass="btn" AutoPostBack="false">
                                                                <ClientSideEvents Click="function(s,e){ 
                                                                    if(ASPxClientEdit.ValidateGroup('NewUserIns')){
                                                                    Registrazione_CallbackPnl.PerformCallback();}}" />
                                                            </dx:ASPxButton>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                </dx:ASPxFormLayout>
                                <dx:ASPxFormLayout ID="RegistrazioneAvvenuta_FormLayout" ClientInstanceName="RegistrazioneAvvenuta_FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%" ColumnCount="2" ClientVisible="false">
                                    <Paddings PaddingBottom="30" PaddingTop="10" />
                                    <Styles>
                                        <LayoutGroupBox CssClass="fullWidth fullHeight"></LayoutGroupBox>
                                        <LayoutGroup Cell-CssClass="fullHeight"></LayoutGroup>
                                    </Styles>
                                    <SettingsAdaptivity>
                                        <GridSettings ChangeCaptionLocationAtWidth="400">
                                            <Breakpoints>
                                                <dx:LayoutBreakpoint ColumnCount="1" MaxWidth="790" Name="S" />
                                            </Breakpoints>
                                        </GridSettings>
                                    </SettingsAdaptivity>
                                    <Items>
                                        <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="Box" HorizontalAlign="Center" ColumnSpan="2">
                                            <ParentContainerStyle CssClass="mobileGroupIndent">
                                            </ParentContainerStyle>
                                            <SpanRules>
                                                <dx:SpanRule BreakpointName="S" ColumnSpan="1" RowSpan="1" />
                                            </SpanRules>
                                            <Items>
                                                <dx:LayoutItem ShowCaption="False" CssClass="mobileAlign" HorizontalAlign="Center">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxLabel ID="Registrazione_Lbl" ClientInstanceName="Registrazione_Lbl" runat="server" Text="Richiesta di registrazione avvenuta con successo! Se il tuo profilo è coerente verrai ricontattato da un amministratore." ForeColor="Green" Font-Size="X-Large"></dx:ASPxLabel>

                                                            <a href="Login.aspx">VAI ALLA PAGINA DI LOGIN</a>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                </dx:ASPxFormLayout>


                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" ClientInstanceName="popuperror" HeaderText="ATTENZIONE" PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" CloseOnEscape="false" CloseAction="CloseButton">
                        <ContentStyle Paddings-Padding="40" />
                        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" />
                        <ContentCollection>
                            <dx:PopupControlContentControl runat="server">
                                <h3 class="card-title text-center">la tua Email risulta già presente nel portale, <a href="/users/Invio_Email_RecuperoDati.aspx">clicca qui</a> per richiede il reset della password.
                                </h3>
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                    </dx:ASPxPopupControl>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Appoggio_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' InsertCommand="SHP_RichiestaRegistrazione_Insert" InsertCommandType="StoredProcedure" SelectCommand="select 1">
        <InsertParameters>
            <asp:Parameter Name="RagioneSociale" Type="String"></asp:Parameter>
            <asp:Parameter Name="CFiscale" Type="String"></asp:Parameter>
            <asp:Parameter Name="NomeCompleto" Type="String"></asp:Parameter>
            <asp:Parameter Name="PIva" Type="String"></asp:Parameter>
            <asp:Parameter Name="Email" Type="String"></asp:Parameter>
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
