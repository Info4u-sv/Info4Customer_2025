<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clienti.aspx.cs" Inherits="INTRA.Stats.Clienti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script type="text/javascript">
        function onToolbarItemClick(s, e) {
            if (e.item.name == 'CustomExportToXlsx') {
                e.processOnServer = true;
                e.usePostBack = true;
            }
        }
    </script>
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
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" OnToolbarItemClick="Generic_Gridview_ToolbarItemClick" GridHeaderFilterMode="CheckedList" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Sql" KeyFieldName="Row" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" OnHtmlRowPrepared="GridView_HtmlRowPrepared">
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
                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
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
                            <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="0" SortOrder="Ascending" Width="6%">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Denom" Caption="Cliente" VisibleIndex="1"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Anno" VisibleIndex="2" ReadOnly="True" SortOrder="Descending" Width="50">
                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="DataIntervento" VisibleIndex="3" ReadOnly="True" SortOrder="Descending" Width="8%">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="TotOre" VisibleIndex="4" ReadOnly="True">
                                <PropertiesTextEdit DisplayFormatString="N2"></PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodRapportino" Caption="Rapportino" ReadOnly="True" VisibleIndex="5" Width="5%">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Utente" Caption="Tecnico" VisibleIndex="6">
                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Status" VisibleIndex="7">
                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
                                <DataItemTemplate>
                                    <label class='label <%# Eval("Descrizione").ToString().Replace(" ", "") %>'><%# Eval("Descrizione")%></label>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="TipoEsecuzione" VisibleIndex="8">
                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
                                <DataItemTemplate>
                                    <label class='label <%# Eval("TipoEsecuzione").ToString().Replace(" ", "") %>'><%# Eval("TipoEsecuzione") %></label>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Area" VisibleIndex="9">
                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
                                <DataItemTemplate>
                                    <label class='label <%# Eval("Area").ToString().Replace(" ", "") %>'><%# Eval("Area") %></label>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Fatturazione" VisibleIndex="10">
                                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="MotivoChiamata" Width="15%" HeaderStyle-Wrap="True" Settings-AutoFilterCondition="Contains" VisibleIndex="11" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="LavoroEseguito" Width="15%" HeaderStyle-Wrap="True" Settings-AutoFilterCondition="Contains" VisibleIndex="12" Visible="false"></dx:GridViewDataTextColumn>
                        </Columns>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="TotOre" DisplayFormat="Totale ore: {0}" ShowInColumn="TotOre" SummaryType="Sum" />
                        </TotalSummary>
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="TotOre" DisplayFormat="Totale ore: {0}" SummaryType="Sum" />
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
    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT Clienti.CodCli, Clienti.Denom, YEAR(TCK_TestataTicket.DataIntervento) AS Anno, CASE WHEN TCK_DettTecniciTicket.UM = 'Ore' THEN tempo ELSE tempo / 60 END AS TotOre, TCK_TestataTicket.CodRapportino, TCK_DettTecniciTicket.Utente, TCK_StatusChiamata.Descrizione, TCK_TipoEsecuzione.Descrizione AS TipoEsecuzione, CASE WHEN TCK_TestataTicket.[IDContrattoAssistenza] <> '' THEN TCK_TestataTicket.[IDContrattoAssistenza] ELSE TCK_StatusCotrolloFatt.Descrizione END AS Fatturazione, TCK_AreaCompetenza.Descrizione AS Area, TCK_TestataTicket.DataIntervento, TCK_TestataTicket.LavoroEseguito, TCK_TestataTicket.MotivoChiamata FROM TCK_TipoEsecuzione INNER JOIN TCK_TestataTicket INNER JOIN TCK_DettTecniciTicket ON TCK_TestataTicket.CodRapportino = TCK_DettTecniciTicket.CodRapportino INNER JOIN TCK_StatusChiamata ON TCK_TestataTicket.TCK_StatusChiamataChiusura = TCK_StatusChiamata.Id ON TCK_TipoEsecuzione.Id = TCK_TestataTicket.TCK_TipoEsecuzione LEFT OUTER JOIN TCK_AreaCompetenza ON TCK_TestataTicket.TCK_AreaCompetenza = TCK_AreaCompetenza.IdAreaAss LEFT OUTER JOIN TCK_StatusCotrolloFatt ON TCK_TestataTicket.StatusCotrolloFatt = TCK_StatusCotrolloFatt.Id RIGHT OUTER JOIN Clienti ON TCK_TestataTicket.CodCli = Clienti.CodCli WHERE (TCK_TestataTicket.InterventoChiuso = 1) AND (TCK_DettTecniciTicket.Tempo > 0) ORDER BY Clienti.CodCli, Anno DESC"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <style>
        .label {
            font-size: 12px;
            padding: 4px 6px;
            border-radius: 2px !important;
            background-clip: padding-box !important;
            font-weight: bold;
        }

            /* Colori per tipo/area/stato */
            .label.Sistemistica,
            .label.Chiuso,
            .label.Inviato,
            .label.Intervento,
            .label.On-Site,
            .label.Standard,
            .label.DaContratto {
                background-color: #8cc474;
            }

            .label.Gestionale,
            .label.Assegnato,
            .label.Commerciale {
                background-color: #ffce55;
            }

            .label.Sviluppo,
            .label.Inlavorazione,
            .label.ControlloPeriodico,
            .label.Telefonicamente,
            .label.DaFatturareParzialmente {
                background-color: #5db2ff;
            }

            .label.OfficeAutomation {
                background-color: #ffce55;
            }

            .label.Laboratorio,
            .label.Chiusoconriserva,
            .label.Altro,
            .label.DaDefinire,
            .label.DaCommessa,
            .label.InGaranzia {
                background-color: #808080;
            }

            .label.Aperto,
            .label.NonDefinito,
            .label.Bloccante,
            .label.DaFatturare {
                background-color: #df5138;
            }

            .label.Annullato,
            .label.Recall,
            .label.Teleassistenza,
            .label.Urgente,
            .label.DaCarnet {
                background-color: #fb6e52;
            }

            .label.NonDefinito {
                background-color: #2dc3e8;
            }
    </style>
</asp:Content>
