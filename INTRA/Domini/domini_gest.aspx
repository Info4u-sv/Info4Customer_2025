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
                                                                        'Sei sicuro di voler eliminare l'email selezionato?',
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
                                                                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Gestione_Dominio" />
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
                                                                        <dx:GridViewColumnLayoutItem ColumnName="IdEmail" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                                                    </Items>
                                                                </EditFormLayoutProperties>
                                                            </dx:ASPxGridView>
                                                        </dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
