<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="domini_gest.aspx.cs" Inherits="INTRA.Domini.domini_gest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var command = "";
        function OnBeginCallback(s, e) {
            command = e.command;
        }

        function OnEndCallback(s, e) {
            if (command == 'DELETEROW') {
                showNotification();
            }
            if (command == "UPDATEEDIT") {
                showNotification();
            }
        }
    </script>

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">language</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Gestione Dominio</h4>
                    <div class="widget ">
                        <div class="widget " style="margin-bottom: 10px !important">
                            <div class="widget-body">
                                <div class="form-horizontal">
                                    <fieldset>
                                        <div class="col-xs-12 col-md-10 col-sm-12 col-LG-10">
                                            <dx:ASPxPageControl ID="Generic_PageControl" ClientInstanceName="Generic_PageControl" Width="100%" Height="30px" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True">
                                                <ClientSideEvents ActiveTabChanged="function(s,e){
                        var index = s.GetActiveTabIndex();
                        Generic_CallbackPnl.PerformCallback(index);
                        }" />
                                                <TabPages>
                                                    <dx:TabPage Text="EMAIL ASSOCIATE">
                                                    </dx:TabPage>
                                                    <dx:TabPage Text="SERVIZI ASSOCIATI">
                                                    </dx:TabPage>
                                                </TabPages>
                                            </dx:ASPxPageControl>
                                            <div class="tabbable">
                                                <dx:ASPxCallbackPanel ID="Generic_CallbackPnl" ClientInstanceName="Generic_CallbackPnl" runat="server" Width="100%" OnCallback="Generic_CallbackPnl_Callback">
                                                    <PanelCollection>
                                                        <dx:PanelContent>
                                                            <dx:ASPxGridView runat="server" ID="EmailAssociate_Gridview" ClientInstanceName="EmailAssociate_Gridview" AutoGenerateColumns="False" DataSourceID="DtsReferenti" KeyFieldName="IdEmail" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" OnRowUpdating="EmailAssociate_Gridview_RowUpdating" OnRowInserting="EmailAssociate_Gridview_RowInserting">
                                                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                                <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){EmailAssociate_Gridview.Refresh(); showNotification();}}" />
                                                                <ClientSideEvents
                                                                    CustomButtonClick="function(s,e){
                                                                if (e.buttonID === 'EliminaEmail') {
                                                                    ConfermaOperazioneWithClientFunction(
                                                                        'Conferma Eliminazione',
                                                                        'Sei sicuro di voler eliminare l\'email selezionato?',
                                                                        'Conferma',
                                                                        'Annulla',
                                                                        EliminaEmail,
                                                                        null,
                                                                        e.visibleIndex,
                                                                        null
                                                                    );
                                                                }
                                                            }" />
                                                                <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
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
                                                                            <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                                                            <dx:GridViewToolbarItem Alignment="left">
                                                                                <Template>
                                                                                    <dx:ASPxButton ID="btnClearFilters" runat="server" Text="❌ Cancella Filtro" AutoPostBack="false">
                                                                                        <ClientSideEvents Click="function(s, e) {
                                                                                        EmailAssociate_Gridview.ClearFilter(); 
                                                                                        tbToolbarSearch.SetText('');
                                                                                    }" />
                                                                                    </dx:ASPxButton>
                                                                                </Template>
                                                                            </dx:GridViewToolbarItem>
                                                                        </Items>
                                                                    </dx:GridViewToolbar>
                                                                </Toolbars>
                                                                <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                                                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Email_Associate" />
                                                                <SettingsCustomizationDialog Enabled="true" />

                                                                <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                                                                <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="780" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1"></SettingsAdaptivity>

                                                                <SettingsCommandButton>
                                                                    <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                                                    </ClearFilterButton>
                                                                    <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
                                                                    </EditButton>
                                                                    <DeleteButton RenderMode="Button" Image-ToolTip="Elimina" Text="Elimina" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn delete icon4u icon-delete image"></Styles>
                                                                    </DeleteButton>
                                                                    <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                                                                    </UpdateButton>
                                                                    <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                                                                    </CancelButton>
                                                                    <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                                                                    </NewButton>
                                                                    <SelectButton RenderMode="Button" Image-ToolTip="Seleziona" Text="Seleziona" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                                                                    </SelectButton>
                                                                </SettingsCommandButton>
                                                                <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                                <SettingsEditing Mode="PopupEditForm" />

                                                                <EditFormLayoutProperties ColCount="1" SettingsItemCaptions-Location="Top">
                                                                    <Items>
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Email" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Telefono" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Password" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Nome" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Cognome" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Ruolo" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="NomeUtente" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                                                                    </Items>
                                                                </EditFormLayoutProperties>
                                                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                                                <Columns>
                                                                    <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="True" ShowClearFilterButton="false" Width="60px">
                                                                        <CustomButtons>
                                                                            <dx:BootstrapGridViewCommandColumnCustomButton
                                                                                ID="EliminaEmail"
                                                                                IconCssClass="icon4u icon-delete image"
                                                                                CssClass="btn btn-sm btn-custom-padding action-btn delete"
                                                                                Text="" />
                                                                        </CustomButtons>
                                                                    </dx:GridViewCommandColumn>
                                                                </Columns>
                                                                <Columns>
                                                                    <dx:GridViewDataTextColumn FieldName="IdEmail" Visible="false" VisibleIndex="0" ReadOnly="true">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="2">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings
                                                                                RequiredField-IsRequired="true"
                                                                                RequiredField-ErrorText="Il campo Email è obbligatorio."
                                                                                RegularExpression-ValidationExpression="^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,7}$"
                                                                                RegularExpression-ErrorText="Inserisci un indirizzo email valido." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Telefono" VisibleIndex="3">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings
                                                                                RequiredField-IsRequired="true"
                                                                                RequiredField-ErrorText="Il campo Telefono è obbligatorio."
                                                                                RegularExpression-ValidationExpression="^\+?[0-9\s\-]{6,20}$"
                                                                                RegularExpression-ErrorText="Inserisci un numero di telefono valido." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Password" VisibleIndex="4">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Password è obbligatorio." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Nome" VisibleIndex="5">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Nome è obbligatorio." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Cognome" VisibleIndex="6">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Cognome è obbligatorio." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Ruolo" VisibleIndex="7">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Ruolo è obbligatorio." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="NomeUtente" VisibleIndex="8">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Nome Utente è obbligatorio." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                </Columns>
                                                            </dx:ASPxGridView>
                                                            <dx:ASPxCallback ID="EliminaMail_Callback" ClientInstanceName="EliminaMail_Callback" runat="server" OnCallback="EliminaMail_Callback_Callback">
                                                                <ClientSideEvents CallbackComplete="function(s,e){EmailAssociate_Gridview.Refresh();showNotification();}" />
                                                            </dx:ASPxCallback>
                                                            <asp:SqlDataSource ID="DtsReferenti" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
                                                                SelectCommand="SELECT STD_Email.IdEmail, STD_Email.Nome, STD_Email.Cognome,STD_Email.NomeUtente,STD_Email.Ruolo, STD_Email.Email, STD_Email.Telefono, STD_Email.KeyId, STD_Email.KeyName, WEB_Domini.IdDominio, STD_Email.Password FROM STD_Email INNER JOIN WEB_Domini ON STD_Email.KeyId = WEB_Domini.IdDominio WHERE (STD_Email.KeyName = 'dominio') AND (STD_Email.KeyId = @KeyId)" UpdateCommand="select GetDate() where 1 = 2" InsertCommand="select GetDate() where 1 = 2">
                                                                <SelectParameters>
                                                                    <asp:QueryStringParameter DefaultValue="0" Name="KeyId" QueryStringField="idDom" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>

                                                            <dx:ASPxGridView runat="server" ID="ServiziAssociati_Gridview" ClientInstanceName="ServiziAssociati_Gridview" AutoGenerateColumns="False" DataSourceID="DtsServiziAss" KeyFieldName="IdServizio" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" ClientVisible="false" OnRowUpdating="ServiziAssociati_Gridview_RowUpdating" OnRowInserting="ServiziAssociati_Gridview_RowInserting" OnCellEditorInitialize="ServiziAssociati_Gridview_CellEditorInitialize">
                                                                <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){ServiziAssociati_Gridview.Refresh(); showNotification();}}" />
                                                                <ClientSideEvents
                                                                    CustomButtonClick="function(s,e){
    if (e.buttonID === 'EliminaServizi') {
        ConfermaOperazioneWithClientFunction(
            'Conferma Eliminazione',
            'Sei sicuro di voler eliminare il servizio selezionato?',
            'Conferma',
            'Annulla',
            EliminaServizi,
            null,
            e.visibleIndex,
            null
        );
    }}" />
                                                                <SettingsCommandButton>
                                                                    <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                                                    </ClearFilterButton>
                                                                    <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
                                                                    </EditButton>
                                                                    <DeleteButton RenderMode="Button" Image-ToolTip="Elimina" Text="Elimina" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn delete icon4u icon-delete image"></Styles>
                                                                    </DeleteButton>
                                                                    <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                                                                    </UpdateButton>
                                                                    <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                                                                    </CancelButton>
                                                                    <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                                                                    </NewButton>
                                                                    <SelectButton RenderMode="Button" Image-ToolTip="Seleziona" Text="Seleziona" Styles-CssPostfix="hidebtn">
                                                                        <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                                                                    </SelectButton>
                                                                </SettingsCommandButton>
                                                                <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                                                                <Toolbars>
                                                                    <dx:GridViewToolbar>
                                                                        <Items>
                                                                            <dx:GridViewToolbarItem Alignment="left">
                                                                                <Template>
                                                                                    <dx:ASPxButtonEdit ID="tbToolbarSearchServizi" ClientInstanceName="tbToolbarSearchServizi" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                                                                        <Buttons>
                                                                                            <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                                                        </Buttons>
                                                                                    </dx:ASPxButtonEdit>
                                                                                </Template>
                                                                            </dx:GridViewToolbarItem>
                                                                            <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                                                            <dx:GridViewToolbarItem Alignment="left">
                                                                                <Template>
                                                                                    <dx:ASPxButton ID="btnClearFilters" runat="server" Text="❌ Cancella Filtro" AutoPostBack="false">
                                                                                        <ClientSideEvents Click="function(s, e) {
                                                                                         ServiziAssociati_Gridview.ClearFilter(); 
                                                                                         tbToolbarSearchServizi.SetText('');
                                                                                     }" />
                                                                                    </dx:ASPxButton>
                                                                                </Template>
                                                                            </dx:GridViewToolbarItem>
                                                                        </Items>
                                                                    </dx:GridViewToolbar>
                                                                </Toolbars>
                                                                <SettingsSearchPanel CustomEditorID="tbToolbarSearchServizi" />
                                                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Servizi_Associati" />
                                                                <SettingsCustomizationDialog Enabled="true" />
                                                                <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="780" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1"></SettingsAdaptivity>

                                                                <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                                                                <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                                                                <SettingsEditing Mode="PopupEditForm" />

                                                                <EditFormLayoutProperties ColCount="1" SettingsItemCaptions-Location="Top">
                                                                    <Items>
                                                                        <dx:GridViewColumnLayoutItem ColumnName="NomeServizio" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="DataAtt" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="DataScad" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Descrizione" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:GridViewColumnLayoutItem ColumnName="Prezzo" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                        <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                                                                    </Items>
                                                                </EditFormLayoutProperties>
                                                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                                                <Columns>
                                                                    <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="True" ShowClearFilterButton="false" Width="60px">
                                                                        <CustomButtons>
                                                                            <dx:BootstrapGridViewCommandColumnCustomButton
                                                                                ID="EliminaServizi"
                                                                                IconCssClass="icon4u icon-delete image"
                                                                                CssClass="btn btn-sm btn-custom-padding action-btn delete"
                                                                                Text="" />
                                                                        </CustomButtons>
                                                                    </dx:GridViewCommandColumn>
                                                                </Columns>
                                                                <Columns>
                                                                    <dx:GridViewDataTextColumn FieldName="IdDominio" Visible="false" VisibleIndex="0" ReadOnly="true"></dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="NomeServizio" VisibleIndex="2">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Nome Servizio è obbligatorio." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataDateColumn FieldName="DataAtt" VisibleIndex="3">
                                                                        <PropertiesDateEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="La Data di Attivazione è obbligatoria." />
                                                                        </PropertiesDateEdit>
                                                                    </dx:GridViewDataDateColumn>
                                                                    <dx:GridViewDataDateColumn FieldName="DataScad" VisibleIndex="4">
                                                                        <PropertiesDateEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="La Data di Scadenza è obbligatoria." />
                                                                        </PropertiesDateEdit>
                                                                    </dx:GridViewDataDateColumn>
                                                                    <dx:GridViewDataMemoColumn FieldName="Descrizione" VisibleIndex="5">
                                                                        <PropertiesMemoEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Descrizione è obbligatorio." />
                                                                        </PropertiesMemoEdit>
                                                                        <DataItemTemplate>
                                                                            <%# GetPreviewText(Container.Text) %>
                                                                        </DataItemTemplate>
                                                                    </dx:GridViewDataMemoColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="Prezzo" VisibleIndex="6">
                                                                        <PropertiesTextEdit>
                                                                            <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="Il campo Prezzo è obbligatorio." />
                                                                        </PropertiesTextEdit>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="KeyId" Visible="false" VisibleIndex="7" ReadOnly="true" />
                                                                </Columns>
                                                            </dx:ASPxGridView>
                                                        </dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                            <div class="card">
                                                <div class="card-header card-header-icon" data-background-color="blue">
                                                    <i class="material-icons">language</i>
                                                </div>
                                                <div class="card-content">
                                                    <h4 class="card-title">Dominio</h4>
                                                    <div class="form-horizontal">
                                                        <fieldset>

                                                            <asp:FormView ID="FormViewDomini" runat="server" DataKeyNames="IdDominio" DataSourceID="DtsDomini">
                                                                <ItemTemplate>
                                                                    <div class="col-xs-12 col-md-12 col-lg-12">
                                                                        <div class="control-group">
                                                                            <h4>URL:</h4>
                                                                            <h5><strong><%# Eval("URL").ToString().ToUpper() %></strong> </h5>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 col-md-12 col-lg-12">
                                                                        <div class="control-group">
                                                                            <h4>Data attivazione:</h4>
                                                                            <h5><strong><%# Eval("DataAttivazione") %></strong> </h5>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 col-md-12 col-lg-12">
                                                                        <div class="control-group">
                                                                            <h4>Data scadenza:</h4>
                                                                            <h5><strong><%# Eval("DataScadenza") %></strong> </h5>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 col-md-12 col-lg-12">
                                                                        <div class="control-group">
                                                                            <h4>Provider:</h4>
                                                                            <h5><strong><%# Eval("Provider") %></strong> </h5>
                                                                        </div>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:FormView>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <dx:ASPxCallback ID="EliminaServizi_Callback" ClientInstanceName="EliminaServizi_Callback" runat="server" OnCallback="EliminaServizi_Callback_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ServiziAssociati_Gridview.Refresh(); showNotification();}" />
    </dx:ASPxCallback>
    <asp:SqlDataSource ID="DtsDomini" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT [IdDominio], [URL], [DataAttivazione], [DataScadenza], [Provider], [KeyId] FROM [WEB_Domini] WHERE ([IdDominio] = @IdDominio)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdDominio" QueryStringField="IdDom"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DtsDelete" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT IdEmail FROM STD_Email WHERE (IdEmail = @IdEmail)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdEmail" QueryStringField="IdEmail" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DtsServiziAss" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" UpdateCommand="select GetDate() where 1 = 2" InsertCommand="select GetDate() where 1 = 2"
        SelectCommand="SELECT [IdServizio], [NomeServizio], [DataAtt], [DataScad], [Descrizione], [Prezzo], [KeyId] FROM [STD_Servizi] WHERE (([KeyId] = @KeyId) AND ([KeyName] = @KeyName))">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="KeyId" QueryStringField="idDom"
                Type="Int32" />
            <asp:QueryStringParameter DefaultValue="" Name="KeyName" QueryStringField="keyName"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare il dato selezionato?", "Conferma", "Annulla", Elimina, null, index, null);
        }
        function Elimina(Valore) {
            Generic_Gridview.DeleteRow(Valore);
        }
        function ConfermaOperazioneWithClientFunction(Title, Testo, BtnConfirmTxt, BtnCancelTxt, Function, FunctionCancel = null, FunctionParam = null, FunctionCancelParam = null) {

            swal({

                title: Title,

                text: Testo,

                type: 'warning',

                showCancelButton: true,

                confirmButtonClass: 'btn btn-success',

                cancelButtonClass: 'btn btn-danger',

                confirmButtonText: BtnConfirmTxt,

                buttonsStyling: false,

                cancelButtonText: BtnCancelTxt,

            }).then(function (isConfirm) {

                if (isConfirm) {

                    if (FunctionParam != null) {

                        Function(FunctionParam);

                    } else {

                        Function();

                    }

                }



            }).catch(function () {

                console.log("Test");

                if (FunctionCancelParam != null) {

                    FunctionCancel(FunctionCancelParam);

                } else {

                    FunctionCancel();

                }

            });

        }
        function EliminaEmail(index) {
            EliminaMail_Callback.PerformCallback(index);
        }
        function EliminaServizi(index) {
            EliminaServizi_Callback.PerformCallback(index);
        }
        function attachLiveSearch(inputClientName, gridClientName, delayMs = 300) {
            let timer = null;

            const input = window[inputClientName];
            const grid = window[gridClientName];
            if (!input || !grid) {
                console.warn(`LiveSearch: elementi non trovati → ${inputClientName}, ${gridClientName}`);
                return;
            }

            input.SetKeyUpHandler(function (s, e) {
                clearTimeout(timer);
                timer = setTimeout(function () {
                    const searchText = s.GetText();
                    grid.SearchByText(searchText);
                }, delayMs);
            });

            input.SetButtonClickHandler(function (s, e) {
                if (e.buttonIndex === 0) {
                    grid.SearchByText('');
                }
            });
        }
    </script>
</asp:Content>
