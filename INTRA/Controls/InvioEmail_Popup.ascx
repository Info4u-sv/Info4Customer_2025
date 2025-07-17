<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InvioEmail_Popup.ascx.cs" Inherits="INTRA.Controls.InvioEmail_PopupAscx" %>




<script>
    function OnTokensChangedEmail(s, e) {
        var collect = s.GetTokenCollection();
        var last = collect[collect.length - 1];
        if (s.IsCustomToken(last)) {

            if (last == 'incorrect')
                s.RemoveTokenByText(last);
        }
    }
    function ProceduraCompletata(s, e) {
        NotificaEmail('success-message');
        LoadingPanelInvioMail.Hide();
        InvioEmail_popup.Hide();
    }
    function OnErrorMail(s, e) {
        NotificaEmail('error-message');
        LoadingPanelInvioMail.Hide();
    }
    function OnSaveClick(s, e) {
        tokenBoxTo.ClearTokenCollection();
        //DocumentiDaAllegare_TokenBox.ClearTokenCollection();
        InvioEmail_popup.Hide();
        LoadingPanelInvioMail.Hide();
        InviaMail_Btn.SetVisible(true);
        //showNotification();
    }
    function NotificaEmail(type) {

        if (type == 'success-message') {
            swal({
                title: "INVIATA!",
                text: "L'email è stata inviata con successo!",
                buttonsStyling: false,
                confirmButtonClass: "btn btn-success",
                type: "success"
            });
        }
        if (type == 'error-message') {
            swal({
                title: "ERRORE!",
                text: "L'email non è stata inviata, riprovare!",
                buttonsStyling: false,
                confirmButtonClass: "btn btn-error",
                type: "error"
            });
        }
    }
</script>

<dx:ASPxCallbackPanel runat="server" ID="InvioEmail_Callbackpnl" ClientInstanceName="InvioEmail_Callbackpnl" Width="100%" OnCallback="InvioEmail_Callbackpnl_Callback">
    <ClientSideEvents EndCallback="function(s,e){InvioEmail_popup.Show();}" />
    <PanelCollection>
        <dx:PanelContent>
            <dx:ASPxPopupControl ID="InvioEmail_popup" ResizingMode="Live" AllowResize="true" ClientInstanceName="InvioEmail_popup" HeaderText="" CloseAction="CloseButton" runat="server" CloseOnEscape="True" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="Middle">
                <ClientSideEvents Shown="" />
                <SettingsAdaptivity Mode="Always" HorizontalAlign="WindowCenter" MaxWidth="100%" />
                <ContentCollection>
                    <dx:PopupControlContentControl>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="card">
                                    <div class="card-header card-header-success card-header-icon" data-background-color="red">
                                        <i class="material-icons">mail</i>
                                    </div>
                                    <div class="card-content">
                                        <h4 class="card-title">Invio Email</h4>
                                        <div class="table-responsive">
                                            <div class="col-lg-4 col-md-4 col-xs-12">
                                                <div class="col-lg-12 col-md-12 col-xs-12">
                                                    Mittente:
                                    <dx:BootstrapTextBox ID="Mittente_Txt" runat="server" Width="100%" Text="" OnInit="Mittente_Txt_Init" Enabled="false">
                                        <ValidationSettings ValidateOnLeave="TRUE" ErrorDisplayMode="Text" RequiredField-IsRequired="true" ValidationGroup="mail">
                                            <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="Una delle email inserite non è valida" />
                                        </ValidationSettings>
                                    </dx:BootstrapTextBox>
                                                </div>
                                                <div class="col-lg-12 col-md-12 col-xs-12">
                                                    Destinatario/i:
                                                         <dx:ASPxTokenBox runat="server" ID="TokenBoxTo" ClientInstanceName="tokenBoxTo" ValueField="CodDiv" TextField="EMail" TextSeparator=";" Width="100%"
                                                             CssClass="mail-editor"
                                                             RootStyle-CssClass="mail-editor"
                                                             CaptionCellStyle-CssClass="caption token-box-caption"
                                                             TokenStyle-CssClass="token"
                                                             TokenTextStyle-CssClass="text"
                                                             TokenRemoveButtonStyle-CssClass="remove-button">
                                                             <TokenBoxInputStyle CssClass="token-input" />
                                                             <ClientSideEvents TokensChanged="OnTokensChangedEmail" />

                                                             <ValidationSettings ValidateOnLeave="TRUE" ErrorDisplayMode="Text" ErrorTextPosition="Top" RequiredField-IsRequired="true" ValidationGroup="mail" ErrorFrameStyle-CssClass="error-frame">
                                                                 <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="Una delle email inserite non è valida" />
                                                             </ValidationSettings>
                                                             <ItemStyle CssClass="contact-item" />
                                                             <InvalidStyle BackColor="LightPink" />
                                                         </dx:ASPxTokenBox>
                                                    <%--                                            <asp:SqlDataSource ID="Destinatario_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT LFT_Clienti_Contatti.Email FROM TCK_TestataTicket INNER JOIN LFT_Clienti_Contatti ON TCK_TestataTicket.CodCli = LFT_Clienti_Contatti.CodCli"></asp:SqlDataSource>--%>
                                                </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12">
                                        CC:
                                                                <dx:ASPxTokenBox runat="server" ID="CopiaConoscenza_Tokenbox" ClientInstanceName="CopiaConoscenza_Tokenbox" Width="100%" ValueField="CodDiv" TextField="EMail" TextSeparator=";"
                                                                    CssClass="mail-editor"
                                                                    RootStyle-CssClass="mail-editor"
                                                                    CaptionCellStyle-CssClass="caption token-box-caption"
                                                                    TokenStyle-CssClass="token"
                                                                    TokenTextStyle-CssClass="text"
                                                                    TokenRemoveButtonStyle-CssClass="remove-button">
                                                                    <TokenBoxInputStyle CssClass="token-input" />
                                                                    <ItemStyle CssClass="contact-item" />
                                                                    <ClientSideEvents TokensChanged="OnTokensChangedEmail" />
                                                                    <ValidationSettings ErrorDisplayMode="Text" ErrorTextPosition="Top" ValidationGroup="mail" ErrorFrameStyle-CssClass="error-frame">
                                                                        <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="Una delle email inserite non è valida" />
                                                                    </ValidationSettings>
                                                                    <InvalidStyle BackColor="LightPink" />
                                                                </dx:ASPxTokenBox>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-xs-12">
                                        CCN:
                                                        <dx:ASPxTokenBox runat="server" ID="CopiaConoscenzaNascosta_Tokenbox" ClientInstanceName="CopiaConoscenzaNascosta_Tokenbox" Width="100%" ValueField="CodDiv" TextField="EMail" TextSeparator=";"
                                                            CssClass="mail-editor"
                                                            RootStyle-CssClass="mail-editor"
                                                            CaptionCellStyle-CssClass="caption token-box-caption"
                                                            TokenStyle-CssClass="token"
                                                            TokenTextStyle-CssClass="text"
                                                            TokenRemoveButtonStyle-CssClass="remove-button">
                                                            <ValidationSettings ErrorDisplayMode="Text" ErrorTextPosition="Top" ValidationGroup="mail" ErrorFrameStyle-CssClass="error-frame">
                                                                <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="Una delle email inserite non è valida" />
                                                            </ValidationSettings>
                                                            <TokenBoxInputStyle CssClass="token-input" />
                                                            <ItemStyle CssClass="contact-item" />
                                                            <InvalidStyle BackColor="LightPink" />
                                                            <ClientSideEvents TokensChanged="OnTokensChangedEmail" />
                                                        </dx:ASPxTokenBox>
                                    </div>
                                                <div class="col-lg-12 col-md-12 col-xs-12 " style="padding-top: 20px!important; padding-bottom: 30px!important;">
                                                    <div style="float: right">
                                                        <dx:ASPxButton ID="InviaMail_Btn" ClientInstanceName="InviaMail_Btn" runat="server" Text="Invia Email" AutoPostBack="false" ClientVisible="true" ValidationGroup="mail" UseSubmitBehavior="false">
                                                            <ClientSideEvents Click="function(s,e){if(tokenBoxTo.isValid && Oggetto_Txt.isValid){
                                                        ConfermaOperazione('Confermi di voler inviare la mail?', 'UltimoCallbackPerInvioMail_Callback', 0)}}" />
                                                        </dx:ASPxButton>
                                                    </div>
                                                    <dx:ASPxCallback ID="UltimoCallbackPerInvioMail_Callback" ClientInstanceName="UltimoCallbackPerInvioMail_Callback" runat="server">
                                                        <ClientSideEvents CallbackComplete="function(s,e){CallbackPerInvioMailSenzaFile_Callback.PerformCallback(); }" />
                                                    </dx:ASPxCallback>
                                                </div>
                                            </div>
                                            <div class="col-lg-8 col-md-8 col-xs-12 " style="padding-bottom: 15px">
                                                Oggetto:
                            <dx:BootstrapTextBox ID="Oggetto_Txt" ClientInstanceName="Oggetto_Txt" runat="server" Width="100%">
                                <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="mail">
                                </ValidationSettings>
                            </dx:BootstrapTextBox>
                                            </div>
                                            <dx:ASPxCallback ID="CallbackPerInvioMailSenzaFile_Callback" ClientInstanceName="CallbackPerInvioMailSenzaFile_Callback" runat="server">
                                                <ClientSideEvents BeginCallback="function(s,e){LoadingPanelInvioMail.Show();}" CallbackComplete="function(s,e){InvioEmail_Callback.PerformCallback();}" />
                                            </dx:ASPxCallback>
                                            <dx:ASPxCallback ID="InvioEmail_Callback" ClientInstanceName="InvioEmail_Callback" runat="server" OnCallback="InvioEmail_Callback_Callback">
                                                <ClientSideEvents EndCallback="OnSaveClick" CallbackComplete="ProceduraCompletata" CallbackError="OnErrorMail" />
                                            </dx:ASPxCallback>
                                            <div class="col-lg-8 col-md-8 col-xs-12">
                                                Messaggio:
                                            <dx:ASPxHtmlEditor ID="Messaggio_HtmlEdit" ClientInstanceName="Messaggio_HtmlEdit" runat="server" Width="100%" Settings-AllowHtmlView="false" Settings-AllowPreview="false">
                                            </dx:ASPxHtmlEditor>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxCallbackPanel>



<asp:SqlDataSource runat="server" ID="OggEmail_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT  [ID] ,[Oggetto] ,[TestoMail] ,[TIpoDoc] ,[Lingua] FROM [U_MailOggettoTesto]  where ID = 1"></asp:SqlDataSource>


<dx:ASPxLoadingPanel runat="server" ID="LoadingPanelInvioMail" ClientInstanceName="LoadingPanelInvioMail" Modal="true" Text="Invio mail in corso..."></dx:ASPxLoadingPanel>
