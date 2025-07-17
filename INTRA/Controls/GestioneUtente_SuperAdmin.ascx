<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GestioneUtente_SuperAdmin.ascx.cs" Inherits="INTRA.Controls.GestioneUtente_SuperAdmin" %>

<div style="width: 100%; margin: 20px 0px; display: inline-flex;">
    <dx:BootstrapButton runat="server" Text="SBLOCCA UTENTE" ID="SbloccaUtente_btn" ClientInstanceName="SbloccaUtente_btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
        <Badge IconCssClass="fa fa-lock" />
        <SettingsBootstrap RenderOption="Default" />
    <ClientSideEvents Click="function(s,e){
        ConfermaOperazione(
            'Sei sicuro di voler sbloccare questo utente?', 
            'UtenteGest_callback', 
            'SBLOCCA'
        ); showNotification();
    }" /> 

    </dx:BootstrapButton>
    <dx:BootstrapButton runat="server" Text="ELIMINA UTENTE" ID="EliminaUtente_btn" ClientInstanceName="EliminaUtente_btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
        <Badge IconCssClass="fa fa-trash" />
        <SettingsBootstrap RenderOption="Danger" />
    <ClientSideEvents Click="function(s,e){
        ConfermaOperazione(
            'Sei sicuro di voler sbloccare questo utente?', 
            'UtenteGest_callback', 
            'ELIMINA'
        );
    }" />
    </dx:BootstrapButton>
    <dx:BootstrapButton runat="server" Text="GENERA UTENTE VIO" ID="GeneraUtenteVIO_btn" ClientInstanceName="GeneraUtenteVIO_btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
        <Badge IconCssClass="fa fa-plus" />
        <SettingsBootstrap RenderOption="Success" />
        <ClientSideEvents Click="function(s,e){UtenteGest('GENERAVIO');}" />
    </dx:BootstrapButton>
    <dx:BootstrapButton runat="server" Text="RESETTA TEMPLATE PERMESSI" ID="Reset_Btn" ClientInstanceName="Reset_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
        <Badge IconCssClass="fa fa-random" />
        <SettingsBootstrap RenderOption="Warning" />
        <ClientSideEvents Click="function(s,e){Reset_User_Popup.Show();}" />
    </dx:BootstrapButton>

    <dx:ASPxCallback runat="server" ID="UtenteGest_callback" ClientInstanceName="UtenteGest_callback" OnCallback="UtenteGest_callback_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){
                                                        var result = e.result;
                                                        if(result != 'NoResult'){
                                                            SetValues(result);
                                                        }else{
                                                            EmptyPopUp();
                                                            GeneraVio_popup.Hide();
                                                            GeneraUtenteVIO_btn.SetEnabled(false);
                                                        }

                                                        var refreshPnl = s.cpRefreshCallback;
                                                        if(refreshPnl != null){
                                                           var pnl = eval(refreshPnl);
                                                           pnl.PerformCallback();
                                                        }
                                                    }" />
    </dx:ASPxCallback>

</div>



<dx:ASPxPopupControl runat="server" ID="GeneraVio_popup" ClientInstanceName="GeneraVio_popup" PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" HeaderText="CREA UTENTE VIO" Width="1300" AllowDragging="true" Modal="true" CloseOnEscape="false">
    <ClientSideEvents Shown="function(s,e){
                UtenteIntranet_txt.SetEnabled(false);
                Email_txt.SetEnabled(false);
                UtenteGest_callback.PerformCallback('OPENPOPUP');
            }" />
    <ClientSideEvents Closing="function(s,e){
                EmptyPopUp();
            }" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <div class="col-md-12 no-padding no-margin">
                <div class="col-md-3">
                    <dx:ASPxTextBox runat="server" ID="UtenteIntranet_txt" ClientInstanceName="UtenteIntranet_txt" Caption="Utente" CaptionSettings-Position="Top" Width="100%" Text='<%#Bind("UtenteIntranet")%>'>
                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink" RequiredField-IsRequired="true" ValidateOnLeave="false" ValidationGroup="UtenteValiation">
                            <RegularExpression ValidationExpression="^((?!(\b(ALTER|CREATE|DELETE|DROP|EXEC(UTE){0,1}|INSERT( +INTO){0,1}|MERGE|SELECT|UPDATE|UNION( +ALL){0,1})\b)).)*$" />
                        </ValidationSettings>
                        <InvalidStyle BackColor="LightPink" />
                    </dx:ASPxTextBox>
                </div>

                <div class="col-md-3">
                    <dx:ASPxTextBox runat="server" ID="Nome_txt" ClientInstanceName="Nome_txt" Caption="Nome" CaptionSettings-Position="Top" Width="100%" Text='<%#Bind("Nome")%>'>
                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink" RequiredField-IsRequired="true" ValidateOnLeave="false" ValidationGroup="UtenteValiation">
                            <RegularExpression ValidationExpression="^((?!(\b(ALTER|CREATE|DELETE|DROP|EXEC(UTE){0,1}|INSERT( +INTO){0,1}|MERGE|SELECT|UPDATE|UNION( +ALL){0,1})\b)).)*$" />
                        </ValidationSettings>
                        <InvalidStyle BackColor="LightPink" />
                    </dx:ASPxTextBox>
                </div>
                <div class="col-md-3">
                    <dx:ASPxTextBox runat="server" ID="Cognome_txt" ClientInstanceName="Cognome_txt" Caption="Cognome" CaptionSettings-Position="Top" Width="100%" Text='<%#Bind("Cognome")%>'>
                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink" RequiredField-IsRequired="true" ValidateOnLeave="false" ValidationGroup="UtenteValiation">
                            <RegularExpression ValidationExpression="^((?!(\b(ALTER|CREATE|DELETE|DROP|EXEC(UTE){0,1}|INSERT( +INTO){0,1}|MERGE|SELECT|UPDATE|UNION( +ALL){0,1})\b)).)*$" />
                        </ValidationSettings>
                        <InvalidStyle BackColor="LightPink" />
                    </dx:ASPxTextBox>
                </div>
                <div class="col-md-3">
                    <dx:ASPxComboBox runat="server" ID="TipologiaUtente_combox" ClientInstanceName="TipologiaUtente_combox" DataSourceID="TipoUtente_dts" ValueField="RoleName" TextField="RoleName" ValueType="System.String" Caption="Tipo Utente" CaptionSettings-Position="Top" Width="100%">
                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink" RequiredField-IsRequired="true" ValidateOnLeave="false" ValidationGroup="UtenteValiation">
                        </ValidationSettings>
                        <InvalidStyle BackColor="LightPink" />
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource runat="server" ID="TipoUtente_dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT RoleName, Description FROM aspnet_Roles WHERE (Description IS NOT NULL)"></asp:SqlDataSource>
                </div>
            </div>
            <div class="col-md-12 no-padding no-margin">
                <div class="col-md-4">
                    <dx:ASPxTextBox runat="server" ID="Email_txt" ClientInstanceName="Email_txt" Caption="Email" CaptionSettings-Position="Top" Width="100%" Text='<%#Bind("EmailContatto")%>' AutoCompleteType="None">
                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink" RequiredField-IsRequired="true" ValidateOnLeave="true" ValidationGroup="UtenteValiation">
                            <RegularExpression ValidationExpression="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" />
                        </ValidationSettings>
                        <ClientSideEvents LostFocus="function(s,e){CheckEmailValid_Callback.PerformCallback(s.GetText());}" />
                        <InvalidStyle BackColor="LightPink" />
                    </dx:ASPxTextBox>
                    <dx:ASPxCallback runat="server" ID="CheckEmailValid_Callback" ClientInstanceName="CheckEmailValid_Callback" OnCallback="CheckEmailValid_Callback_Callback">
                        <ClientSideEvents CallbackComplete="function(s,e){
                                                            var result = e.result;
                                                            var valid = result == '1';
                                                            Email_txt.SetIsValid(valid);
                                                            if(!valid){ 
                                                                showNotificationErrorWithText('Email già in uso');
                                                            }
                                                        }" />
                    </dx:ASPxCallback>
                </div>
                <div class="col-md-4">
                    <dx:ASPxTextBox runat="server" ID="UtenteSMTP_txt" ClientInstanceName="UtenteSMTP_txt" Caption="Utente SMTP" CaptionSettings-Position="Top" Width="100%" Text='<%#Bind("UtenteSMTP")%>'></dx:ASPxTextBox>
                </div>
                <%--<div class="col-md-4">
                    <dx:ASPxTextBox runat="server" ID="PasswordSMTP_txt" ClientInstanceName="PasswordSMTP_txt" Caption="Password SMTP" CaptionSettings-Position="Top" Width="100%" Text='<%# /*string.IsNullOrEmpty(Eval("PasswordSMTP") as string) ? " " : GetDecryptedPassword(Eval("PasswordSMTP") as string)*/%>'></dx:ASPxTextBox>
                </div>--%>
            </div>
            <div class="col-md-12" style="padding-top: 10px;">
                <span class="dxeCaption_Office365">Firma email:</span>
                <dx:ASPxHtmlEditor runat="server" ID="FirmaEmail_html" ClientInstanceName="FirmaEmail_html" Width="100%" Settings-AllowHtmlView="true" Html='<%# Bind("FirmaEmail") %>'></dx:ASPxHtmlEditor>
            </div>
            <div class="col-md-12 no-padding no-margin right">

                <dx:BootstrapButton runat="server" ID="Salva_btn" ClientInstanceName="Salva_btn" ClientVisible="true" AutoPostBack="false" Badge-CssClass="BadgeBtn"
                    CssClasses-Control="btn btn-md position" rel="tooltip" data-placement="top" data-original-title="Salva" UseSubmitBehavior="false">
                    <Badge IconCssClass="fa fa-save" />
                    <SettingsBootstrap RenderOption="Success" Sizing="Normal" />
                    <ClientSideEvents Click="function(s,e){
                                                            if( Email_txt.GetIsValid() && ASPxClientEdit.ValidateGroup('UtenteValiation')){
                                                                    UtenteGest_callback.PerformCallback('GENERAVIO');
                                                               }
                                                         }" />
                </dx:BootstrapButton>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

<asp:SqlDataSource runat="server" ID="Ruoli_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT DISTINCT RoleId, RoleName FROM aspnet_Roles"></asp:SqlDataSource>
<dx:ASPxPopupControl runat="server" ID="Reset_User_Popup" ClientInstanceName="Reset_User_Popup" PopupHorizontalAlign="WindowCenter" HeaderText="Reset Utente" SettingsAdaptivity-Mode="OnWindowInnerWidth" ShowPageScrollbarWhenModal="true" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="CloseButton" Width="700px" Modal="true" PopupVerticalAlign="WindowCenter">
    <ContentCollection>
        <dx:PopupControlContentControl>
            <div class="col-lg-12">
                <dx:ASPxComboBox runat="server" ID="Ruolo_cb" ClientInstanceName="Ruolo_cb" Width="100%" Caption="Template Ruolo" CaptionSettings-Position="Top" DataSourceID="Ruoli_Dts" ValueField="RoleId" TextField="RoleName"></dx:ASPxComboBox>
            </div>
            <div class="col-lg-12">
                <dx:BootstrapButton runat="server" ID="BootstrapButton1" ClientInstanceName="Reset_Btn" ClientVisible="true" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-md position" rel="tooltip" data-placement="top" data-original-title="Esegui Reset" UseSubmitBehavior="false">
                    <Badge IconCssClass="fa fa-save" />
                    <SettingsBootstrap RenderOption="Success" Sizing="small" />
                    <ClientSideEvents Click="function(s,e){Reset_Callback.PerformCallback(); showNotification();}" />
                </dx:BootstrapButton>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
<dx:ASPxCallback runat="server" ID="Reset_Callback" ClientInstanceName="Reset_Callback" OnCallback="Reset_Callback_Callback">
    <ClientSideEvents EndCallback="function(s,e){Ruolo_cb.SetSelectedIndex(-1); Reset_User_Popup.Hide(); location.reload();}" />
</dx:ASPxCallback>

<script>
    function UtenteGest(TipoChiamata) {
        switch (TipoChiamata) {
            case "SBLOCCA":
            case "ELIMINA":
                UtenteGest_callback.PerformCallback(TipoChiamata);
                break;
            case "GENERAVIO":
                GeneraVio_popup.Show();
                break;
        }
    }

    function SetValues(values) {
        var val = values.split('|');
        UtenteIntranet_txt.SetText(val[0]);
        Email_txt.SetText(val[1]);
    }

    function EmptyPopUp() {
        TipologiaUtente_combox.SetSelectedIndex(-1);
        FirmaEmail_html.SetHtml("");

        for (i = 0; i < PopUpElements_txt.length; i++) {
            var element = eval(PopUpElements_txt[i]);
            element.SetText("");
        }
    }
</script>
