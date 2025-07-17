<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProfiloUtente.aspx.cs" Inherits="INTRA.Users.ProfiloUtente" %>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <%--    <link href="../Default.css" rel="stylesheet" />--%>
    <style>
        input[type="checkbox"], input[type="radio"] {
            margin: 3px 10px 0px !important;
            opacity: 1 !important;
            position: inherit !important;
            left: 0px !important;
            z-index: 12 !important;
            width: 0px !important;
            height: 0px !important;
            cursor: pointer !important;
        }


    </style>
    <script type="text/javascript">
        function ChangeType(s, type) {
            // Some desktop browsers throw an exception if a value of the type property is not supported.
            try {
                s.GetInputElement().type = type;
            }
            catch (err) {
                alert("\"" + type + "\"\n\r " + err.message);
            }
        }
    </script>

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
    <div class="row">
        <div runat="server" id="ragioneSociale_div" class="col-md-8">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
                    <i class="material-icons">perm_identity</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Modifica Profilo -
                                       
                                <small class="category">Completa il tuo profilo</small>
                    </h4>
                    <dx:ASPxCallbackPanel runat="server" ID="UpdateDetRiv_pnl" ClientInstanceName="UpdateDetRiv_pnl" OnCallback="UpdateDetRiv_pnl_Callback">
                        <ClientSideEvents EndCallback="function(s,e){showNotification();UpdateImgTecnico(s.cpImagineTecnico);}" />
                        <PanelCollection>
                            <dx:PanelContent>
                                <dx:ASPxFormLayout runat="server" ID="RagioneSociale_fl" ClientInstanceName="RagioneSociale_fl" Width="100%" Paddings-Padding="0" BackColor="White" ValidateRequestMode="Disabled">
                                    <SettingsAdaptivity AdaptivityMode="Off" SwitchToSingleColumnAtWindowInnerWidth="800"></SettingsAdaptivity>
                                    <Border BorderWidth="0px" />
                                    <Items>
                                        <dx:LayoutGroup ColumnCount="12" Caption="" ShowCaption="False" Paddings-Padding="0">
                                            <Border BorderStyle="None" BorderWidth="0px"></Border>

                                            <Paddings Padding="0px"></Paddings>
                                            <Items>
                                                <dx:LayoutItem Caption="" ColumnSpan="12" ShowCaption="False" RequiredMarkDisplayMode="Hidden" Border-BorderStyle="None">
                                                    <Border BorderWidth="0px" />
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <%-- Caricamento biglietto da visista --%>
                                                            <%--<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                                                <label class="control-label TitleCell">Biglietto da visita:</label>
                                                                <dx:ASPxBinaryImage ID="BigliettoDaVisita_ImageBinary" ClientInstanceName="BigliettoDaVisita_ImageBinary" runat="server" ImageSizeMode="FitProportional" EnableServerResize="false">
                                                                    <EditingSettings Enabled="true" UploadSettings-UploadValidationSettings-MaxFileSize="4194304">
                                                                        <UploadSettings>
                                                                            <UploadValidationSettings MaxFileSize="4194304"></UploadValidationSettings>
                                                                        </UploadSettings>
                                                                    </EditingSettings>
                                                                </dx:ASPxBinaryImage>
                                                            </div>--%>
                                                            <div runat="server" id="CodDoc_div" class="col-md-3" style="float: right; margin-right: -6px; display: none;">
                                                                <dx:ASPxLabel runat="server" ID="CodDoc_lbl" ClientInstanceName="CodDoc_lbl" CssClass="right" Width="100%" ClientEnabled="false" Font-Bold="true" Font-Size="Large">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                            <div class="col-md-12 no-padding" style="padding-top: 15px;">
                                                                <%-- Prima riga (Ragione sociale,Nazione,Agente)--%>
                                                                <div class="col-md-9">
                                                                    <dx:ASPxTextBox ID="Denom_text" ClientInstanceName="Denom_text" Caption="Ragione Sociale" CaptionCellStyle-CssClass="dx-caption" Width="100%" runat="server">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="UtenteValidator" ValidateOnLeave="false">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <dx:ASPxComboBox runat="server" ID="Nazione_Combox" ClientInstanceName="Nazione_Combox" Width="100%" Caption="Nazione" DataSourceID="Nazioni_Dts" ValueField="CodNaz" TextField="Descrizione" ValueType="System.String">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxComboBox>

                                                                </div>




                                                                <%-- Riga due (Ind,Prov,Cap,Loc) --%>
                                                                <div class="col-md-5">
                                                                    <dx:ASPxTextBox ID="Indirizzo_Txt" ClientInstanceName="Indirizzo_Txt" Caption="Indirizzo:" Width="100%" runat="server">
                                                                        <%--<CssClasses Caption="TitleCell"></CssClasses>--%>
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <dx:ASPxComboBox ID="Provincia_Combobox" ClientInstanceName="Provincia_Combobox" Caption="Provincia:" runat="server" Width="100%" Value='<%# Eval("Prov") %>'>
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ClearButton DisplayMode="Always"></ClearButton>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="AG" Value="AG" />
                                                                            <dx:ListEditItem Text="AL" Value="AL" />
                                                                            <dx:ListEditItem Text="AN" Value="AN" />
                                                                            <dx:ListEditItem Text="AO" Value="AO" />
                                                                            <dx:ListEditItem Text="AQ" Value="AQ" />
                                                                            <dx:ListEditItem Text="AR" Value="AR" />
                                                                            <dx:ListEditItem Text="AP" Value="AP" />
                                                                            <dx:ListEditItem Text="AT" Value="AT" />
                                                                            <dx:ListEditItem Text="AV" Value="AV" />
                                                                            <dx:ListEditItem Text="BA" Value="BA" />
                                                                            <dx:ListEditItem Text="BT" Value="BT" />
                                                                            <dx:ListEditItem Text="BL" Value="BL" />
                                                                            <dx:ListEditItem Text="BN" Value="BN" />
                                                                            <dx:ListEditItem Text="BG" Value="BG" />
                                                                            <dx:ListEditItem Text="BI" Value="BI" />
                                                                            <dx:ListEditItem Text="BO" Value="BO" />
                                                                            <dx:ListEditItem Text="BZ" Value="BZ" />
                                                                            <dx:ListEditItem Text="BS" Value="BS" />
                                                                            <dx:ListEditItem Text="BR" Value="BR" />
                                                                            <dx:ListEditItem Text="CA" Value="CA" />
                                                                            <dx:ListEditItem Text="CL" Value="CL" />
                                                                            <dx:ListEditItem Text="CB" Value="CB" />
                                                                            <dx:ListEditItem Text="CI" Value="CI" />
                                                                            <dx:ListEditItem Text="CE" Value="CE" />
                                                                            <dx:ListEditItem Text="CT" Value="CT" />
                                                                            <dx:ListEditItem Text="CZ" Value="CZ" />
                                                                            <dx:ListEditItem Text="CH" Value="CH" />
                                                                            <dx:ListEditItem Text="CO" Value="CO" />
                                                                            <dx:ListEditItem Text="CS" Value="CS" />
                                                                            <dx:ListEditItem Text="CR" Value="CR" />
                                                                            <dx:ListEditItem Text="KR" Value="KR" />
                                                                            <dx:ListEditItem Text="CN" Value="CN" />
                                                                            <dx:ListEditItem Text="EN" Value="EN" />
                                                                            <dx:ListEditItem Text="FM" Value="FM" />
                                                                            <dx:ListEditItem Text="FE" Value="FE" />
                                                                            <dx:ListEditItem Text="FI" Value="FI" />
                                                                            <dx:ListEditItem Text="FG" Value="FG" />
                                                                            <dx:ListEditItem Text="FC" Value="FC" />
                                                                            <dx:ListEditItem Text="FR" Value="FR" />
                                                                            <dx:ListEditItem Text="GE" Value="GE" />
                                                                            <dx:ListEditItem Text="GO" Value="GO" />
                                                                            <dx:ListEditItem Text="GR" Value="GR" />
                                                                            <dx:ListEditItem Text="IM" Value="IM" />
                                                                            <dx:ListEditItem Text="IS" Value="IS" />
                                                                            <dx:ListEditItem Text="SP" Value="SP" />
                                                                            <dx:ListEditItem Text="LT" Value="LT" />
                                                                            <dx:ListEditItem Text="LE" Value="LE" />
                                                                            <dx:ListEditItem Text="LC" Value="LC" />
                                                                            <dx:ListEditItem Text="LI" Value="LI" />
                                                                            <dx:ListEditItem Text="LO" Value="LO" />
                                                                            <dx:ListEditItem Text="LU" Value="LU" />
                                                                            <dx:ListEditItem Text="MC" Value="MC" />
                                                                            <dx:ListEditItem Text="MN" Value="MN" />
                                                                            <dx:ListEditItem Text="MS" Value="MS" />
                                                                            <dx:ListEditItem Text="MT" Value="MT" />
                                                                            <dx:ListEditItem Text="VS" Value="VS" />
                                                                            <dx:ListEditItem Text="ME" Value="ME" />
                                                                            <dx:ListEditItem Text="MI" Value="MI" />
                                                                            <dx:ListEditItem Text="MO" Value="MO" />
                                                                            <dx:ListEditItem Text="MB" Value="MB" />
                                                                            <dx:ListEditItem Text="NA" Value="NA" />
                                                                            <dx:ListEditItem Text="NO" Value="NO" />
                                                                            <dx:ListEditItem Text="NU" Value="NU" />
                                                                            <dx:ListEditItem Text="OG" Value="OG" />
                                                                            <dx:ListEditItem Text="OT" Value="OT" />
                                                                            <dx:ListEditItem Text="OR" Value="OR" />
                                                                            <dx:ListEditItem Text="PD" Value="PD" />
                                                                            <dx:ListEditItem Text="PA" Value="PA" />
                                                                            <dx:ListEditItem Text="PR" Value="PR" />
                                                                            <dx:ListEditItem Text="PV" Value="PV" />
                                                                            <dx:ListEditItem Text="PG" Value="PG" />
                                                                            <dx:ListEditItem Text="PU" Value="PU" />
                                                                            <dx:ListEditItem Text="PE" Value="PE" />
                                                                            <dx:ListEditItem Text="PC" Value="PC" />
                                                                            <dx:ListEditItem Text="PI" Value="PI" />
                                                                            <dx:ListEditItem Text="PT" Value="PT" />
                                                                            <dx:ListEditItem Text="PN" Value="PN" />
                                                                            <dx:ListEditItem Text="PZ" Value="PZ" />
                                                                            <dx:ListEditItem Text="PO" Value="PO" />
                                                                            <dx:ListEditItem Text="RG" Value="RG" />
                                                                            <dx:ListEditItem Text="RA" Value="RA" />
                                                                            <dx:ListEditItem Text="RC" Value="RC" />
                                                                            <dx:ListEditItem Text="RE" Value="RE" />
                                                                            <dx:ListEditItem Text="RI" Value="RI" />
                                                                            <dx:ListEditItem Text="RN" Value="RN" />
                                                                            <dx:ListEditItem Text="RM" Value="RM" />
                                                                            <dx:ListEditItem Text="RO" Value="RO" />
                                                                            <dx:ListEditItem Text="SA" Value="SA" />
                                                                            <dx:ListEditItem Text="SS" Value="SS" />
                                                                            <dx:ListEditItem Text="SV" Value="SV" />
                                                                            <dx:ListEditItem Text="SI" Value="SI" />
                                                                            <dx:ListEditItem Text="SR" Value="SR" />
                                                                            <dx:ListEditItem Text="SO" Value="SO" />
                                                                            <dx:ListEditItem Text="TA" Value="TA" />
                                                                            <dx:ListEditItem Text="TE" Value="TE" />
                                                                            <dx:ListEditItem Text="TR" Value="TR" />
                                                                            <dx:ListEditItem Text="TO" Value="TO" />
                                                                            <dx:ListEditItem Text="TP" Value="TP" />
                                                                            <dx:ListEditItem Text="TN" Value="TN" />
                                                                            <dx:ListEditItem Text="TV" Value="TV" />
                                                                            <dx:ListEditItem Text="TS" Value="TS" />
                                                                            <dx:ListEditItem Text="UD" Value="UD" />
                                                                            <dx:ListEditItem Text="VA" Value="VA" />
                                                                            <dx:ListEditItem Text="VE" Value="VE" />
                                                                            <dx:ListEditItem Text="VB" Value="VB" />
                                                                            <dx:ListEditItem Text="VC" Value="VC" />
                                                                            <dx:ListEditItem Text="VR" Value="VR" />
                                                                            <dx:ListEditItem Text="VV" Value="VV" />
                                                                            <dx:ListEditItem Text="VI" Value="VI" />
                                                                            <dx:ListEditItem Text="VT" Value="VT" />
                                                                            <dx:ListEditItem Text="EE" Value="EE" />
                                                                        </Items>
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="none" ValidationGroup="UtenteValidator"></ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxComboBox>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <dx:ASPxTextBox ID="Cap_text" ClientInstanceName="Cap_text" Caption="Cap:" CssClasses-Caption="TitleCell" Width="100%" runat="server" MaxLength="5">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="false" ValidateOnLeave="false" RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />

                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <dx:ASPxTextBox ID="Local_Txt" ClientInstanceName="Local_Txt" Caption="Località" Width="100%" runat="server">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>

                                                                <%-- Riga tre (Referente,Email,Telefono) --%>

                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox runat="server" ID="SitoWeb_txt" ClientInstanceName="SitoWeb_txt" Width="100%" Caption="Sito Web">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="false" ValidateOnLeave="false" RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="EMail_text" ClientInstanceName="EMail_text" Caption="EMail:" Width="100%" runat="server">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="UtenteValidator" RegularExpression-ValidationExpression="^\w+([-+.'%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorDisplayMode="None">
                                                                            <RegularExpression ValidationExpression="^\w+([-+.&#39;%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"></RegularExpression>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="Tel_text" ClientInstanceName="Tel_text" Caption="Tel:" Width="100%" runat="server">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>

                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="PIva_text" ClientInstanceName="PIva_text" Caption="P.Iva:" runat="server" MaxLength="11" Width="100%">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="false" ValidateOnLeave="false" RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <dx:ASPxSpinEdit runat="server" ID="Ricarico_spin" ClientInstanceName="Ricarico_spin" Caption="Percentuale ricarico" DisplayFormatString="{0}%" MinValue="0" MaxValue="100" ClearButton-DisplayMode="Always" Increment="0.50">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="false" ValidateOnLeave="false" RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="UtenteValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />

                                                                    </dx:ASPxSpinEdit>
                                                                </div>

                                                            </div>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                    <Paddings Padding="0px"></Paddings>

                                                </dx:LayoutItem>



                                                <%-- Non usato --%>
                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                    <Paddings Padding="0px"></Paddings>
                                </dx:ASPxFormLayout>
                                <dx:BootstrapButton ID="AggiornaInfoUtente" ClientInstanceName="AggiornaInfoUtente" runat="server" UseSubmitBehavior="false" AutoPostBack="false" ValidationGroup="Validator_Zona1"
                                    Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-lg btn-custom-padding ">
                                    <Badge Text="Aggiorna Info" IconCssClass="far fa-save" />
                                    <SettingsBootstrap RenderOption="Success" />
                                    <ClientSideEvents Click="function(s,e){if(ASPxClientEdit.ValidateGroup('UtenteValidator')){UpdateDetRiv_pnl.PerformCallback();}}" />
                                </dx:BootstrapButton>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </div>
        </div>

        <div runat="server" id="profilo_div" class="col-md-4">
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
                                <p class="description">
                                    <div class="controls">
                                        <img id="Img2" class="img-responsive" src="" runat="server" />
                                        <p><strong>Cambia immagine profilo:</strong></p>
                                        <div class="row">
                                            <div class="col-lg-12 col-md-12">
                                                <input id="inputFileToLoad" type="file" onchange="loadImageFileAsURL();" class="btn btn-orange btn-round" style="display: inline-block" />
                                                <textarea id="textAreaFileContents" runat="server" itemid="textAreaFileContents" style="display: none"></textarea>
                                                <script type="text/javascript">
                                                    function loadImageFileAsURL() {
                                                        var filesSelected = document.getElementById("inputFileToLoad").files;
                                                        if (filesSelected.length > 0) {
                                                            var fileToLoad = filesSelected[0];
                                                            var fileReader = new FileReader();
                                                            fileReader.onload = function (fileLoadedEvent) {
                                                                var textAreaFileContents = document.getElementById
                                                                    (
                                                                "<%=textAreaFileContents.ClientID%>"
                                                                    );
                                                                textAreaFileContents.innerHTML = fileLoadedEvent.target.result;
                                                            };
                                                            fileReader.readAsDataURL(fileToLoad);
                                                        }
                                                    }
                                                </script>
                                            </div>

                                            <div class="col-lg-12 col-md-12">
                                                <dx:BootstrapButton ID="AggiornaInfoTop_Btn" ClientInstanceName="AggiornaInfoTop_Btn" runat="server" UseSubmitBehavior="false" AutoPostBack="false" ValidationGroup="Validator_Zona1"
                                                    Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-lg btn-custom-padding ">
                                                    <Badge Text="Aggiorna Info" IconCssClass="far fa-save" />
                                                    <SettingsBootstrap RenderOption="Success" />
                                                    <ClientSideEvents Click="function(s,e){if(ASPxClientEdit.ValidateGroup('UtenteValidator')){UpdateDetRiv_pnl.PerformCallback();}}" />
                                                </dx:BootstrapButton>
                                            </div>


                                        </div>


                                        <%--                                    <h4 style="text-align: left !important">Firma profilo:</h4>

                                    <img id="firmaTecnico" class="img-responsive" src="" runat="server" style="height: 50%; width: 50%; display: initial;" />
                                    <asp:LinkButton ID="FirmaTecnico_LinkB" runat="server" CssClass="btn btn-labeled btn-azure"
                                        data-toggle="tooltip" title="Aggiorna i dati" OnClick="FirmaTecnico_LinkB_Click">
                                <i class="btn-label fa fa-upload"></i> Carica Firma</asp:LinkButton>--%>
                                    </div>
                                </p>
                                <div class="row">
                                    <div runat="server" id="cambiaPassword_div" class="col-md-12">
                                        <h4 style="text-align: left !important">Cambia la Password</h4>

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

                                                        <dx:LayoutItem Caption="Conferma password" Width="100%">
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
                                                                    <%-- <dx:ASPxButton runat="server" ID="signUp" Text="Conferma Password" Width="100%" CssClass="btn" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s,e){if(passwordTextBox.isValid && confirmPasswordTextBox.isValid){CambiaPassword_Callback.PerformCallback();}}" />
                                                </dx:ASPxButton>--%>
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


    <asp:SqlDataSource runat="server" ID="Nazioni_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodNaz, Descrizione FROM TabNaz"></asp:SqlDataSource>

</asp:Content>





