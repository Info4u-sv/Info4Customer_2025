<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Carnet.aspx.cs" Inherits="INTRA.Stats.Carnet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">confirmation_number</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Statistiche Ticket</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" GridHeaderFilterMode="CheckedList" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Sql" KeyFieldName="Row" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSize="20" PageSizeItemSettings-Items="20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
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
                                    <dx:GridViewToolbarItem Name="CustomExportToXlsx" Text="Esporta Xlsx" Image-IconID="export_exporttoxls_16x16office2013" />

                                </Items>
                            </dx:GridViewToolbar>
                        </Toolbars>
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Statistiche_Ticket" />
                        <SettingsCustomizationDialog Enabled="true" />

                        <Settings ShowFooter="true" ShowGroupFooter="VisibleIfExpanded" ShowGroupPanel="true" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                        <SettingsContextMenu Enabled="true" RowMenuItemVisibility-ExportMenu-Visible="true">
                            <RowMenuItemVisibility>
                                <ExportMenu Visible="True"></ExportMenu>
                            </RowMenuItemVisibility>
                        </SettingsContextMenu>
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
                        <Columns>
                            <dx:GridViewCommandColumn ShowClearFilterButton="false" Visible="false" VisibleIndex="0"></dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="CodCliente" VisibleIndex="0">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Denom" Caption="Cliente" VisibleIndex="1"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IDProdotto" VisibleIndex="2" ReadOnly="True">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Totale" VisibleIndex="3" ReadOnly="True">
                                <propertiestextedit displayformatstring="N2"></propertiestextedit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Totinterventi" VisibleIndex="4" ReadOnly="True">
                                <PropertiesTextEdit DisplayFormatString="N2"></PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ResiduoOre" Caption="Residuo Ore" ReadOnly="True" VisibleIndex="4">
                                <PropertiesTextEdit DisplayFormatString="N2"></PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DataCar" Caption="Data Car" VisibleIndex="5">
                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <FormatConditions>
                            <dx:GridViewFormatConditionHighlight FieldName="ResiduoOre" Expression="[ResiduoOre] >= 4" Format="GreenFillWithDarkGreenText" />
                            <dx:GridViewFormatConditionHighlight FieldName="ResiduoOre" Expression="[ResiduoOre] <= 0" Format="LightRedFillWithDarkRedText" />
                            <dx:GridViewFormatConditionHighlight FieldName="ResiduoOre" Expression="[ResiduoOre] > 0 && [ResiduoOre] <4" Format="YellowFillWithDarkYellowText" />
                        </FormatConditions>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Totale" DisplayFormat="Totale ore: {0}" ShowInColumn="Totale" SummaryType="Sum" />
                        </TotalSummary>
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="Totale" DisplayFormat="Totale ore: {0}" SummaryType="Sum" />
                        </GroupSummary>

                        <Styles>
                            <GroupRow ForeColor="#003399">
                            </GroupRow>
                            <Header Font-Bold="true"></Header>
                            <AlternatingRow BackColor="#EDEDED"></AlternatingRow>
                            <GroupPanel ForeColor="White" Font-Bold="true" BackColor="#0055A6">
                            </GroupPanel>
                        </Styles>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT Denom, CodCliente, IDProdotto, Totale, Totinterventi, ResiduoOre, U_CC, DataCar FROM U_CarnetAttivi_KING_View ORDER BY ResiduoOre"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
