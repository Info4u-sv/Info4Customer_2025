<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clienti_CRUD.aspx.cs" Inherits="INTRA.Gestionale.Clienti_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .dxgvDataRow_Office365 .dxICheckBox_Office365, .dxgvInlineEditRow_Office365 .dxICheckBox_Office365, .dxgvDataRow_Office365 .dxeIRadioButton_Office365, .dxgvInlineEditRow_Office365 .dxeIRadioButton_Office365 {
            transform: scale(2, 2);
        }

        .dx-fab-container.dx-fab-text-visible-on-hover {
            display: none;
        }

        .dx-vam {
            color: gray;
        }
    </style>
    <script>
        function onBatchEditStartEditing(s, e) {
            var editor = s.GetEditor(e.focusedColumn);
            if (editor.isASPxClientCheckEdit != undefined) {
                e.rowValues[e.focusedColumn.index].value = !e.rowValues[e.focusedColumn.index].value;
            }
        }
        function OnChangeSaving(s, e) {
            showNotification();
        }

        var Comando;
        function OnBeginCallback(s, e) {

            Comando = e.command;
        }
        function EndCallback(s, e) {
            if (Comando == 'REFRESH') {
                Generic_Gridview.StartEditRow();
            }
        }
    </script>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">groups</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Clienti CRUD</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" DataSourceID="GenericSqlDS" KeyFieldName="CodCli" AutoGenerateColumns="False" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="8" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
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
                                    <dx:GridViewToolbarItem Command="ClearFilter" Text="Cancella Flitro" />
                                    <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                </Items>
                            </dx:GridViewToolbar>
                        </Toolbars>
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Anagrafica_Clienti" />
                        <SettingsCustomizationDialog Enabled="true" />

                        <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                        <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="780" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1"></SettingsAdaptivity>
                        <SettingsText CommandBatchEditCancel="Annulla" CommandBatchEditUpdate="Salva" CommandBatchEditPreviewChanges="Preview Modifiche" CommandBatchEditHidePreview="Nascondi Preview" />
                        <ClientSideEvents BatchEditChangesSaving="OnChangeSaving" />
                        <SettingsEditing Mode="Batch">
                            <BatchEditSettings EditMode="Cell" StartEditAction="Click" />
                        </SettingsEditing>
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
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <%--            <dx:GridViewCommandColumn ShowClearFilterButton="true" Width="2%" VisibleIndex="0" ShowEditButton="True"></dx:GridViewCommandColumn>--%>
                            <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="0"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Denom" Caption="Cliente" VisibleIndex="1" ReadOnly="True"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Ind" Caption="Indirizzo" VisibleIndex="2" ReadOnly="True"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Tel" Caption="Telefono" VisibleIndex="3" ReadOnly="True" Width="8%"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="EMail" Caption="Email" VisibleIndex="4" ReadOnly="True"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataCheckColumn FieldName="U_Carnet" Caption="Carnet" VisibleIndex="5" Width="5%">
                                <PropertiesCheckEdit DisplayTextChecked="Sì" DisplayTextUnchecked="No" />
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="U_ContrattoHWSW" Caption="Contratto" VisibleIndex="6" Width="5%">
                                <PropertiesCheckEdit DisplayTextChecked="Sì" DisplayTextUnchecked="No" />
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="U_Print" Caption="Full Service" VisibleIndex="7" Width="5%">
                                <PropertiesCheckEdit DisplayTextChecked="Sì" DisplayTextUnchecked="No" />
                            </dx:GridViewDataCheckColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="GenericSqlDS" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>'
        SelectCommand="SELECT CodCli, Denom, Ind + ' ' + Cap + ' ' + Loc + ' (' + Prov + ')' AS Ind, Tel, EMail, U_Carnet, U_ContrattoHWSW, U_Print FROM Clienti WHERE (FlagAnnullo = 0) ORDER BY CodCli" UpdateCommand="UPDATE Clienti SET U_Carnet = @U_Carnet, U_ContrattoHWSW = @U_ContrattoHWSW, U_Print = @U_Print WHERE (CodCli = @CodCli)">
        <UpdateParameters>
            <asp:Parameter Name="U_Carnet"></asp:Parameter>
            <asp:Parameter Name="U_ContrattoHWSW"></asp:Parameter>
            <asp:Parameter Name="U_Print"></asp:Parameter>
            <asp:Parameter Name="CodCli"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
