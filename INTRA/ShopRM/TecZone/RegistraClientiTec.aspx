<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="RegistraClientiTec.aspx.cs" Inherits="INTRA.ShopRM.TecZone.RegistraClientiTec" %>

<%@ Register Src="~/ShopRM/TecZone/Controls/LeftMenuTecnico.ascx" TagPrefix="uc1" TagName="LeftMenuTecnico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuTecnico runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">Registra nuovo Cliente</h2>
            </div>
            <div class="article-container">
                <p>Tramite questa pagina puoi registrare un nuovo cliente a te associato</p>

                <dx:ASPxCallbackPanel ID="InserimentoArt_CallbackPnl" ClientInstanceName="InserimentoArt_CallbackPnl" runat="server" Width="100%">
                    <%--  <ClientSideEvents EndCallback="function(s,e){InserimentoArticolo_Popup.Show()}" />--%>
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxTextBox runat="server" ID="isPropect_txt" ClientInstanceName="isPropect_txt" ClientVisible="false"></dx:ASPxTextBox>

                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-margin no-padding editcontainer">
                                <dx:ASPxFormLayout runat="server" ID="InserimentoArticolo_FormLy" ClientInstanceName="InserimentoArticolo_FormLy" Width="100%" Paddings-Padding="0" BackColor="White" ValidateRequestMode="Disabled">
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

                                                            <div runat="server" id="CodDoc_div" class="col-md-3" style="float: right; margin-right: -6px; display: none;">
                                                                <dx:ASPxLabel runat="server" ID="CodDoc_lbl" ClientInstanceName="CodDoc_lbl" CssClass="right" Width="100%" ClientEnabled="false" Font-Bold="true" Font-Size="Large">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                            <div class="col-md-12 no-padding" style="padding-top: 15px;">
                                                                <%-- Prima riga (Ragione sociale,Nazione,Agente)--%>
                                                                <div class="col-md-6">
                                                                    <dx:ASPxTextBox ID="Cognome_text" ClientInstanceName="Cognome_text" Caption="Cognome" CaptionCellStyle-CssClass="dx-caption" Width="100%" runat="server">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator" ValidateOnLeave="false">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <dx:ASPxTextBox ID="Nome_text" ClientInstanceName="Nome_text" Caption="Nome" CaptionCellStyle-CssClass="dx-caption" Width="100%" runat="server">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator" ValidateOnLeave="false">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>




                                                                <%-- Riga due (Ind,Prov,Cap,Loc) --%>
                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="Indirizzo_Txt" ClientInstanceName="Indirizzo_Txt" Caption="Indirizzo:" Width="100%" runat="server">
                                                                        <%--<CssClasses Caption="TitleCell"></CssClasses>--%>
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="Local_Txt" ClientInstanceName="Local_Txt" Caption="Località" Width="100%" runat="server">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
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
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator"></ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxComboBox>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <dx:ASPxTextBox ID="Cap_text" ClientInstanceName="Cap_text" Caption="Cap:" CssClasses-Caption="TitleCell" Width="100%" runat="server" MaxLength="5">
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <CaptionSettings Position="Top" />
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>


                                                                <%-- Riga tre (Referente,Email,Telefono) --%>
                                                                <script>
                                                                    function EndCheckCallback(s, e) {
                                                                        var result = s.cpResult;
                                                                        var isValid = result != '1';
                                                                        var goupValidation = ASPxClientEdit.ValidateGroup('NuovoProspectValidator');
                                                                        EMail_text.SetIsValid(isValid)
                                                                        console.log(EMail_text.GetText());
                                                                        if (!isValid && (EMail_text.GetText() != '' && EMail_text.GetText() != null)) {
                                                                            showNotificationErrortoastr('Email già in uso da un altro utente');
                                                                        } else {
                                                                            if (goupValidation) Salvataggio_Callback.PerformCallback();

                                                                        }
                                                                    }
                                                                </script>

                                                                <div class="col-md-4">
                                                                    <dx:ASPxCallbackPanel runat="server" ID="EmailCheck_pnl" ClientInstanceName="EmailCheck_pnl" OnCallback="EmailCheck_pnl_Callback" Width="100%">
                                                                        <ClientSideEvents EndCallback="EndCheckCallback" />
                                                                        <PanelCollection>
                                                                            <dx:PanelContent>
                                                                                <dx:ASPxTextBox ID="EMail_text" ClientInstanceName="EMail_text" Caption="EMail:" Width="100%" runat="server">
                                                                                    <CaptionSettings Position="Top" />
                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                    <ValidationSettings ValidationGroup="NuovoProspectValidator" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink">
                                                                                        <RegularExpression ValidationExpression="^\w+([-+.&#39;%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"></RegularExpression>
                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                    </ValidationSettings>
                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                </dx:ASPxTextBox>
                                                                            </dx:PanelContent>
                                                                        </PanelCollection>
                                                                    </dx:ASPxCallbackPanel>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="Tel_text" ClientInstanceName="Tel_text" Caption="Tel:" Width="100%" runat="server">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoProspectValidator">
                                                                            <RequiredField IsRequired="True"></RequiredField>
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>


                                                                <div class="col-md-4">
                                                                    <dx:ASPxTextBox ID="CF_Txt" ClientInstanceName="CF_Txt" Caption="Codice fiscale:" Width="100%" runat="server">
                                                                        <CaptionSettings Position="Top" />
                                                                        <CaptionCellStyle CssClass="dx-caption adapt-caption not-RequiredField"></CaptionCellStyle>
                                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="false" ValidationGroup="NuovoProspectValidator" ErrorDisplayMode="None">
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxTextBox>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" style="display: none;">
                                                                <dx:ASPxComboBox runat="server" ID="CanaleAcquisizione_Combobox" Visible="false" Caption="Canale acquisizione prospect" CaptionSettings-Position="Top" ClientInstanceName="CanaleAcquisizione_Combobox" DataSourceID="CanaliAcquisizione_Sql" ValueField="id" TextField="Descrizione" Width="100%">
                                                                    <CaptionSettings Position="Top" />
                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                    <%--                                                                        <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoProspectValidator" ErrorDisplayMode="None">
                                                                        </ValidationSettings>
                                                                        <InvalidStyle BackColor="LightPink" />--%>
                                                                </dx:ASPxComboBox>
                                                                <asp:SqlDataSource runat="server" ID="CanaliAcquisizione_Sql" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT id, Descrizione FROM U_CRM4U_CanaliAcquisizione"></asp:SqlDataSource>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                    <Paddings Padding="0px"></Paddings>

                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                    <Paddings Padding="0px"></Paddings>
                                </dx:ASPxFormLayout>
                                <div class="col-md-12 hide">
                                    <dx:ASPxTextBox runat="server" ID="newCodCLi_txt" ClientInstanceName="newCodCLi_txt"></dx:ASPxTextBox>
                                </div>
                                <div class="col-md-12">
                                    <dx:BootstrapButton ID="Salva_Btn" ClientInstanceName="Salva_Btn" runat="server" AutoPostBack="false" ValidationGroup="NuovoProspectValidator"
                                        rel="tooltip" data-placement="top" data-original-title="Salva" Text="Salva" UseSubmitBehavior="false" CssClasses-Control="button style-12">


                                        <ClientSideEvents
                                            Click="function(s,e){
                                                EmailCheck_pnl.PerformCallback();
                                            } " />
                                    </dx:BootstrapButton>
                                    <dx:BootstrapButton ID="Ordina_btn" ClientInstanceName="Ordina_btn" runat="server" AutoPostBack="false" ClientVisible="false" ValidationGroup="NuovoProspectValidator"
                                        rel="tooltip" data-placement="top" data-original-title="Salva" Text="Ordina" UseSubmitBehavior="false" CssClasses-Control="button style-12">
                                        <ClientSideEvents
                                            Click="function(s,e){
                                                var newCodCli = newCodCLi_txt.GetText();
                                                ImpostaCliPerOrdine_Callback.PerformCallback(newCodCli);
                                            } " />
                                    </dx:BootstrapButton>
                                    <dx:ASPxCallback ID="Salvataggio_Callback" ClientInstanceName="Salvataggio_Callback" runat="server" OnCallback="Salvataggio_Callback_Callback">
                                        <ClientSideEvents CallbackComplete="function(s,e){
                                            showNotificationtoastrWithText('Il cliente è stato inserito correttamente');
                                            var result = e.result;
                                            console.log(result);
                                            newCodCLi_txt.SetText(result);
                                              Ordina_btn.SetVisible(true);
                                            }" />
                                    </dx:ASPxCallback>

                                    <dx:ASPxCallback runat="server" ID="ImpostaCliPerOrdine_Callback" ClientInstanceName="ImpostaCliPerOrdine_Callback" OnCallback="ImpostaCliPerOrdine_Callback_Callback">
                                        <ClientSideEvents CallbackComplete="function(s,e){
                                            var container = document.getElementsByClassName('editcontainer')[0];
                                              ASPxClientEdit.ClearEditorsInContainer(container);
                                            window.location.href = '/ShopRM/Default.aspx';}" />
                                    </dx:ASPxCallback>
                                </div>
                            </div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
