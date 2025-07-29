<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tck_Tot_Ore_tecnici_Dett_View.aspx.cs" Inherits="INTRA.Stats.Tck_Tot_Ore_tecnici_Dett_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
        .ImmaginiProfili {
            width: 3rem !important;
            height: 3rem !important;
        }

        dxgvAdaptiveGroupPanel_Office365, .dxgvGroupPanel_Office365 {
            color: #fff !important;
            font-size: 1em !important;
            background-color: darkorange !important;
        }

        .options-top-container .options .options-item {
            display: inline-block;
            vertical-align: top;
            padding: 3px 36px 3px 0;
        }

        .dxgvGroupRow_Office365, .dxgvBatchEditChangesPreviewGroupRow_Office365 {
            background-color: #2dc3e8;
            color: white;
            font-weight: bold;
        }

        .dxgvGroupFooter_Office365 td.dxgv {
            color: red;
            font-weight: bold;
        }

        .dxgvFooter_Office365 td.dxgv {
            color: green;
            font-weight: bold;
        }

        .dxgvGroupPanel_Office365 {
            color: #fff !important;
            font-size: 1em !important;
            background-color: #0055A6 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">schedule</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Dettaglio Totale Ore Tecnici</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="DtsDatiTecniciOre" KeyFieldName="CodCli" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
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
                                    <dx:GridViewToolbarItem Command="FullExpand" Name="Expand" BeginGroup="true" Text="Espandi Tutto" />
                                    <dx:GridViewToolbarItem Command="FullCollapse" Name="Collapse" BeginGroup="false" Text="Collassa Tutto" />
                                    <dx:GridViewToolbarItem Command="ExportToXlsx" BeginGroup="true" Text="Esporta in Xlsx" />
                                    <dx:GridViewToolbarItem Command="ShowCustomizationDialog" BeginGroup="true" Text="Filtro Personalizzato" />
                                </Items>
                            </dx:GridViewToolbar>
                        </Toolbars>
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Dettaglio_Totale_Ore_Tecnici" />
                        <SettingsCustomizationDialog Enabled="true" />

                        <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
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
                            <dx:GridViewDataTextColumn FieldName="Utente" SettingsHeaderFilter-Mode="CheckedList" Caption="Tecnico" VisibleIndex="1" GroupIndex="0">
                                <DataItemTemplate>
                                    <span style="padding-left: 20px">
                                        <%# GetImgUtente( Eval("Utente") )%>    <%#  Eval("Utente") %></span>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="TotaleTempo" VisibleIndex="2" Caption="Tot Ore Lavorative"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="TipoChiusura" SettingsHeaderFilter-Mode="CheckedList" VisibleIndex="3" Caption="Tipo Chiusura"></dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn FieldName="Anno" SettingsHeaderFilter-Mode="CheckedList" VisibleIndex="4" Caption="Anno"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Mese" SettingsHeaderFilter-Mode="CheckedList" VisibleIndex="3" Caption="Mese"></dx:GridViewDataTextColumn>
                        </Columns>
                        <Settings ShowGroupPanel="true" ShowFooter="true" ShowGroupFooter="VisibleIfExpanded" />
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="TotaleTempo" SummaryType="Sum" />
                        </GroupSummary>
                        <Settings ShowFooter="true" ShowGroupFooter="VisibleIfExpanded" />
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="TotaleTempo" ShowInGroupFooterColumn="TotaleTempo" SummaryType="Sum" />
                        </GroupSummary>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="TotaleTempo" SummaryType="Sum" />
                        </TotalSummary>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="DtsDatiTecniciOre" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT Utente, CAST(ROUND(TotaleTempo, 2) AS numeric(36 , 2)) AS TotaleTempo, Anno, DATENAME(Month, DATEADD(Month, Mese, 0) - 1) AS Mese, TipoChiusura FROM Tck_Tot_Ore_tecnici_Dett_View GROUP BY Utente, TotaleTempo, Anno, Mese, TipoChiusura"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
