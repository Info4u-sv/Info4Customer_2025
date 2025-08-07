<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GrigliaClientiNonAbilitati.aspx.cs" Inherits="INTRA.SuperAdmin.UserGest.GrigliaClientiNonAbilitati" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function OnCustomButtonClick(s, e) {
            switch (e.buttonID) {
                case "Attiva":
                    s.GetRowValues(e.visibleIndex, "CodCli", OnRowGetValues);
                    break;
            }
        }

        function OnRowGetValues(value) {
            CodCli_Value.SetValue(value);
            //alert(CodCli_Value.GetValue());
            AttivaCliente_PopUp.Show();
            NomeUtenteIntranet_Txt.SetValue(value + "-1");
            EditForm_CallbackPanel.PerformCallback();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header card-header-icon" data-background-color="blue">
            <i class="fa fa-list" style="font-size: 30px"></i>
        </div>
        <div class="card-content">
            <h4 class="card-title">Clienti non abilitati</h4>
            <dx:ASPxTextBox ID="CodCli_Value" ClientInstanceName="CodCli_Value" runat="server" ClientVisible="false"></dx:ASPxTextBox>
            <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="ClientiNonAbilitati_dts" KeyFieldName="CodCli">
                <SettingsPopup>
                    <EditForm Modal="true" Width="1000px" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter">
                    </EditForm>
                </SettingsPopup>
                <Styles>
                    <AlternatingRow Enabled="True"></AlternatingRow>
                </Styles>
                <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                <SettingsAdaptivity>
                    <AdaptiveDetailLayoutProperties ColCount="2">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                    </AdaptiveDetailLayoutProperties>
                </SettingsAdaptivity>
                <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                <Settings ShowFilterRow="True" ShowFilterRowMenu="true" ShowHeaderFilterButton="true"></Settings>

                <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter">
                    <EditForm HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" AllowResize="True" Modal="True"></EditForm>
                </SettingsPopup>
                <SettingsCommandButton>
                    <NewButton ButtonType="Image" RenderMode="Image">
                        <Image ToolTip="Nuovo" Url="~/img/DevExButton/new.png" Width="30px" Height="30px"></Image>
                    </NewButton>
                    <UpdateButton ButtonType="Image" RenderMode="Image">
                        <Image ToolTip="Aggiorna" Height="30px" Url="~/img/DevExButton/update.png" Width="30px"></Image>
                    </UpdateButton>
                    <CancelButton ButtonType="Image" RenderMode="Image">
                        <Image ToolTip="Annulla" Height="30px" Url="~/img/DevExButton/cancel.png" Width="30px"></Image>
                    </CancelButton>
                    <EditButton ButtonType="Image" RenderMode="Image">
                        <Image ToolTip="Modifica" Height="30px" Url="~/img/DevExButton/edit.png" Width="30px"></Image>
                    </EditButton>
                    <DeleteButton ButtonType="Image" RenderMode="Image">
                        <Image ToolTip="Elimina" Height="30px" Url="~/img/DevExButton/delete.png" Width="30px"></Image>
                    </DeleteButton>
                    <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                    </ClearFilterButton>
                </SettingsCommandButton>
                <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true"></SettingsDataSecurity>
                <SettingsSearchPanel Visible="True" />
                <EditFormLayoutProperties ColCount="2">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                </EditFormLayoutProperties>
                <Styles AlternatingRow-Enabled="True"></Styles>
                <Toolbars>
                    <dx:GridViewToolbar>
                        <Items>
                            <dx:GridViewToolbarItem Alignment="left">
                                <Template>
                                    <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                        <Buttons>
                                            <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                        </Buttons>
                                    </dx:ASPxButtonEdit>
                                </Template>
                            </dx:GridViewToolbarItem>
                            <dx:GridViewToolbarItem Command="ClearFilter" Text="Cancella Flitro" />
                            <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />

                        </Items>
                    </dx:GridViewToolbar>

                </Toolbars>
                <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                <Columns>
                    <dx:GridViewCommandColumn ShowNewButtonInHeader="false" ShowEditButton="false" ShowDeleteButton="false" VisibleIndex="0" Width="60px" ButtonRenderMode="Image" ShowClearFilterButton="false">
                        <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Attiva" IconCssClass="icon-attiva" CssClass="btn btn-success btn-sm me-1" />
                            <%--                            <dx:GridViewCommandColumnCustomButton ID="Sospendi">
                                <Image Url="~/img/DevExButton/stop.png" Width="30px">
                                </Image>
                            </dx:GridViewCommandColumnCustomButton>
                            <dx:GridViewCommandColumnCustomButton ID="Password" Image-ToolTip="Modifica password">
                                <Image Url="~/img/DevExButton/Password-change.png" Width="30px">
                                </Image>
                            </dx:GridViewCommandColumnCustomButton>--%>
                        </CustomButtons>
                    </dx:GridViewCommandColumn>

                    <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="1" Width="7%"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Denom" Caption="Azienda" VisibleIndex="2"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CodAge" VisibleIndex="3" Width="7%"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Agente" VisibleIndex="4"></dx:GridViewDataTextColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="ClientiNonAbilitati_dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        SHP_AgeForClient.CodCli, SHP_AgeForClient.Descrizione, SHP_AgeForClient.CodAge, Clienti.Denom
FROM            Clienti RIGHT OUTER JOIN
                         SHP_AgeForClient ON Clienti.CodCli = SHP_AgeForClient.CodCli LEFT OUTER JOIN
                         VIO_Utenti ON SHP_AgeForClient.CodCli = VIO_Utenti.CodCli
WHERE        (VIO_Utenti.UtenteIntranet IS NULL) AND (SHP_AgeForClient.CodAge IS NOT NULL)"></asp:SqlDataSource>
        </div>
    </div>


    <dx:ASPxPopupControl runat="server" ID="AttivaCliente_PopUp" ClientInstanceName="AttivaCliente_PopUp" AllowDragging="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1000px">
        <ContentCollection>
            <dx:PopupControlContentControl>
                <div class="row">
                    <div class="col-lg-12">
                        <dx:ASPxCallbackPanel runat="server" ID="EditForm_CallbackPanel" ClientInstanceName="EditForm_CallbackPanel" Width="100%" OnCallback="EditForm_CallbackPanel_Callback">
                            <ClientSideEvents EndCallback="function(s,e){
                                if(s.cpInserted == '1'){
                                AttivaCliente_PopUp.Hide();Generic_Gridview.Refresh();showNotification();
                                }
                                }" />
                            <PanelCollection>
                                <dx:PanelContent>
                                    <dx:ASPxFormLayout ID="Edit_FormLayout" ClientInstanceName="Edit_FormLayout" runat="server" Width="100%" DataSourceID="AttivaCliente_dts">
                                        <Items>

                                            <dx:LayoutGroup ColumnCount="12" Caption="Anagrafica azienda" Paddings-Padding="0">
                                                <Items>
                                                    <dx:LayoutItem ColumnSpan="6" Caption="Società" FieldName="Denom">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Societa_txt" ClientInstanceName="Societa_txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="2" Caption="C.F./P.Iva" FieldName="Piva_CF">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Codicefiscale_Txt" ClientInstanceName="Codicefiscale_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="2" Caption="Email Azienda" FieldName="EMail">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="EmailAzienda_Txt" ClientInstanceName="EmailAzienda_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="5" Caption="Indirizzo" FieldName="Ind">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Indirizzo_Txt" ClientInstanceName="Indirizzo_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="1" Caption="Cap" FieldName="Cap">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Cap_Txt" MaxLength="5" ClientInstanceName="Cap_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="2" Caption="Città" FieldName="Loc">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Citta_Txt" ClientInstanceName="Citta_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="1" Caption="Provincia" FieldName="Prov">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Provincia_Txt" ClientInstanceName="Provincia_Txt" Width="100%" ClientEnabled="false"></dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>
                                            <dx:LayoutGroup ColumnCount="12" Caption="Utente intranet" Paddings-Padding="0">
                                                <Items>
                                                    <dx:LayoutItem Caption="Nome utente" ColumnSpan="2">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="NomeUtenteIntranet_Txt" EnableClientSideAPI="True" ClientInstanceName="NomeUtenteIntranet_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid" ClientEnabled="false">
                                                                </dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem Caption="Email" ColumnSpan="10">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox AutoCompleteType="Email" EnableClientSideAPI="True" runat="server" ID="Email_Txt" ClientInstanceName="Email_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                    <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
                                                                </dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="2" Caption="Nome">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Nome_txt" ClientInstanceName="Nome_txt" Width="100%">
                                                                    <ValidationSettings ValidationGroup="NuovoUtenteValid">
                                                                        <RequiredField IsRequired="true" />
                                                                    </ValidationSettings>
                                                                </dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="2" Caption="Cognome">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Cognome_Txt" ClientInstanceName="Cognome_Txt" Width="100%">
                                                                    <ValidationSettings ValidationGroup="NuovoUtenteValid">
                                                                        <RequiredField IsRequired="true" />
                                                                    </ValidationSettings>
                                                                </dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColumnSpan="2" Caption="Telefono">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:BootstrapTextBox runat="server" ID="Telefono_txt" ClientInstanceName="Telefono_txt" Width="100%">
                                                                    <ValidationSettings ValidationGroup="NuovoUtenteValid">
                                                                        <RequiredField IsRequired="true" />
                                                                    </ValidationSettings>
                                                                </dx:BootstrapTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                    </dx:LayoutItem>

                                                </Items>

                                            </dx:LayoutGroup>
                                        </Items>
                                    </dx:ASPxFormLayout>

                                    <asp:SqlDataSource runat="server" ID="AttivaCliente_dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Denom,Ind, Cap, Prov, Loc, EMail, ISNULL(PIva, CF) AS Piva_CF FROM Clienti WHERE (CodCli = @CodCli)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="CodCli_Value" PropertyName="Text" Name="CodCli"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <dx:BootstrapButton runat="server" Text="" ClientInstanceName="Salva_Btn" ID="Salva_Btn" AutoPostBack="false" ValidationGroup="NuovoUtenteValid" Badge-CssClass="BadgeBtn"
                                        CssClasses-Control="btn btn-sm btn-custom-padding" Badge-IconCssClass="fa fa-save">
                                        <ClientSideEvents Click="function(s,e){ 
                                                            if(ASPxClientEdit.ValidateGroup('NuovoUtenteValid')){EditForm_CallbackPanel.PerformCallback('save');}}" />
                                        <Badge Text="SALVA" />
                                        <SettingsBootstrap RenderOption="Success" />
                                    </dx:BootstrapButton>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <style>
 .icon-attiva::before {
     content: "";
     display: inline-block;
     background-image: url('/img/DevExButton/Start-on-go.png');
     background-size: contain;
     background-repeat: no-repeat;
     width: 20px;
     height: 20px;
     vertical-align: middle;
 }

    </style>
</asp:Content>
