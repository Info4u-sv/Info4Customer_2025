<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Carnet_Contratti_CRUD.aspx.cs" Inherits="INTRA.Gestionale.Carnet_Contratti_CRUD" %>

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

        .dxm-spacing {
            max-height: 20px !important;
            height: 20px !important;
        }

        textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"] {
            min-height: 20px !important;
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
                    <i class="material-icons">description</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Carnet Contratti CRUD</h4>
                    <br />
                    <div style="float: left">
                        <a href="javascript: NuovoCarnet_Popup.Show();">
                            <dx:ASPxImage runat="server" ID="apriPopup_Btn" ToolTip="Nuovo" ImageUrl="~/img/DevExButton/new.png" Width="30px"></dx:ASPxImage>
                        </a>
                    </div>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" gridheaderfiltermode="CheckedList" DataSourceID="Generic_Sql" KeyFieldName="ContM" AutoGenerateColumns="False" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="8" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="Bottom"></SettingsPager>
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
                                        <%--<Template>
                                            <div style="float: right">
                                                <a href="javascript: NuovoCarnet_Popup.Show();">
                                                    <dx:ASPxImage runat="server" ID="apriPopup_Btn" ToolTip="Nuovo" ImageUrl="~/img/DevExButton/new.png" Width="30px"></dx:ASPxImage>
                                                </a>
                                            </div>
                                        </Template>--%>
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
                        <SettingsContextMenu Enabled="true" RowMenuItemVisibility-ExportMenu-Visible="true">
                            <RowMenuItemVisibility>
                                <ExportMenu Visible="True"></ExportMenu>
                            </RowMenuItemVisibility>
                        </SettingsContextMenu>
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
                        <EditFormLayoutProperties>
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit"></SettingsAdaptivity>
                        </EditFormLayoutProperties>
                        <SettingsEditing Mode="Batch">
                            <BatchEditSettings EditMode="Cell" StartEditAction="Click" />
                        </SettingsEditing>
                        <Columns>
                            <dx:GridViewCommandColumn ShowNewButtonInHeader="false" Visible="false" VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ContM" VisibleIndex="1" Width="90px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="1" ReadOnly="True" Width="80px" SettingsHeaderFilter-Mode="CheckedList"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Denom" Caption="Cliente" VisibleIndex="2" ReadOnly="True" Width="350" SettingsHeaderFilter-Mode="CheckedList">
                                <Settings FilterMode="Value" AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IdProdotto" VisibleIndex="3" ReadOnly="True"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Descrizione" VisibleIndex="3" ReadOnly="True" Width="200"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DescrTipoAssistenza" Caption="tipo" VisibleIndex="3" ReadOnly="True" Width="100"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="U_TotOreContratto" VisibleIndex="3" Caption="Tot Ore Contratto" Width="50px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Totinterventi" VisibleIndex="4" ReadOnly="True" Caption="Tot Interventi" Width="50px">
                                <PropertiesTextEdit DisplayFormatString="N2"></PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ResiduoOre" Caption="Residuo Ore" ReadOnly="True" VisibleIndex="5" Width="50px">
                                <PropertiesTextEdit DisplayFormatString="N2"></PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DataCar" Caption="Data Car" VisibleIndex="6" ReadOnly="True" EditFormSettings-Visible="False" Width="100px">
                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataCheckColumn FieldName="U_CC" Caption="Chiuso" VisibleIndex="7" Width="120px">
                                <PropertiesCheckEdit DisplayTextChecked="Sì" DisplayTextUnchecked="No" />
                            </dx:GridViewDataCheckColumn>
                        </Columns>
                        <FormatConditions>
                            <dx:GridViewFormatConditionHighlight FieldName="ResiduoOre" Expression="[ResiduoOre] >= 4" Format="GreenFillWithDarkGreenText" />
                            <dx:GridViewFormatConditionHighlight FieldName="ResiduoOre" Expression="[ResiduoOre] <= 0" Format="LightRedFillWithDarkRedText" />
                            <dx:GridViewFormatConditionHighlight FieldName="ResiduoOre" Expression="[ResiduoOre] > 0 && [ResiduoOre] <4" Format="YellowFillWithDarkYellowText" />
                        </FormatConditions>
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
    <dx:ASPxPopupControl ID="NuovoCarnet_Popup" ClientInstanceName="NuovoCarnet_Popup" HeaderText="Aggiungi un nuovo servizio" runat="server" Width="700px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Modal="true">
        <ClientSideEvents CloseUp="
         function(s,e)
         {
         var today = new Date();
         Cliente_Combobox.SetSelectedIndex(-1);
        Tipologia_Combobox.SetSelectedIndex(-1);
         DataCoperturaCarnet_Date.SetDate(today);
         Ore_SpinEdit.SetNumber(0);
         Generic_Gridview.Refresh();
          }
         " />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-xs-12">
                        <div class="col-lg-12 col-md-12 col-xs-12">
                            <div class="col-lg-12 col-md-12 col-xs-12">
                                <dx:ASPxComboBox ID="Cliente_Combobox" ClientInstanceName="Cliente_Combobox" runat="server" ValueType="System.String" Width="100%" DataSourceID="Clienti_Dts" ValueField="CodCli" TextField="Denom">
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){if(Cliente_Combobox.GetSelectedIndex() > -1){Generic_Pnl.SetVisible(true)}else{Generic_Pnl.SetVisible(false)}}" />
                                    <ValidationSettings ValidationGroup="NuovoContrattoValid" ErrorDisplayMode="None">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                    <InvalidStyle BackColor="LightPink" />
                                </dx:ASPxComboBox>
                            </div>
                        </div>


                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding-top: 10px">
                            <dx:ASPxCallbackPanel ID="Generic_Pnl" ClientInstanceName="Generic_Pnl" runat="server" Width="100%" ClientVisible="false">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <div class="col-lg-4 col-md-4 col-xs-12">
                                            <label>Tipologia servizio:</label>
                                            <dx:ASPxComboBox runat="server" ID="Tipologia_Combobox" ClientInstanceName="Tipologia_Combobox" DataSourceID="TipoAssistenza_Sql" ValueField="ID" TextField="Descr">
                                                <ValidationSettings ValidationGroup="NuovoContrattoValid" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                                <InvalidStyle BackColor="LightPink" />
                                            </dx:ASPxComboBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-xs-12">
                                            <label>Data partenza servizio:</label>
                                            <dx:ASPxDateEdit ID="DataCoperturaCarnet_Date" ClientInstanceName="DataCoperturaCarnet_Date" runat="server" AllowNull="false" OnInit="DataCoperturaCarnet_Date_Init">
                                                <ValidationSettings ValidationGroup="NuovoContrattoValid" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                                <InvalidStyle BackColor="LightPink" />
                                            </dx:ASPxDateEdit>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-xs-12">
                                            <label>Ore:</label>
                                            <dx:ASPxSpinEdit runat="server" ID="Ore_SpinEdit" DecimalPlaces="0" ClientInstanceName="Ore_SpinEdit" AllowNull="false" MinValue="0" MaxValue="999999">
                                                <ValidationSettings ValidationGroup="NuovoContrattoValid" ErrorDisplayMode="None">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                                <InvalidStyle BackColor="LightPink" />
                                            </dx:ASPxSpinEdit>
                                        </div>
                                        <div class="col-lg-12 col-md-12" style="padding-top: 20px">
                                            <div style="float: right">
                                                <a href="javascript: if( ASPxClientEdit.ValidateGroup('NuovoContrattoValid')){AggiungiSerivizio_Callback.PerformCallback();}">
                                                    <dx:ASPxImage runat="server" ID="Salva_Btn" Width="30px" ImageUrl="~/img/DevExButton/save.png"></dx:ASPxImage>
                                                </a>
                                            </div>
                                        </div>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </div>
                    </div>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxCallback ID="AggiungiSerivizio_Callback" runat="server" ClientInstanceName="AggiungiSerivizio_Callback" OnCallback="AggiungiSerivizio_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){showNotification();NuovoCarnet_Popup.Hide();}" />
    </dx:ASPxCallback>


    <asp:SqlDataSource ID="Clienti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT CodCli, Denom FROM Clienti WHERE (FlagAnnullo = 0)"></asp:SqlDataSource>

    <asp:SqlDataSource ID="TipoAssistenza_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT [ID], [Descr] FROM [U_Tipo_Assistenza]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Denom, CodCli, IdProdotto, Totale, Totinterventi, ResiduoOre, U_CC, DataCar, U_Carnet, U_ContrattoHWSW, U_Print, U_TotOreContratto, U_Tipo_Assistenza, DescrTipoAssistenza, ContM, Descrizione FROM U_Carnet_Contratti_View_Intra ORDER BY ResiduoOre, Denom, DataCar" UpdateCommand="UPDATE U_AnaManutenzione SET U_CC = @U_CC, U_TotOreContratto = @U_TotOreContratto WHERE (ContM = @ContM)">
        <UpdateParameters>
            <asp:Parameter Name="U_CC"></asp:Parameter>
            <asp:Parameter Name="U_TotOreContratto" DbType="Int32"></asp:Parameter>
            <asp:Parameter Name="ContM"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="Servizi_Crud" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' InsertCommand="U_AnaManutenzione_Insert" InsertCommandType="StoredProcedure" SelectCommand="select 1 where 1= 2">
        <InsertParameters>
            <asp:Parameter Name="DataCar" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="CodCliente" Type="String"></asp:Parameter>
            <asp:Parameter Name="U_TotOreContratto" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="U_Tipo_Assistenza" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="IdProdotto" Type="String"></asp:Parameter>
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
