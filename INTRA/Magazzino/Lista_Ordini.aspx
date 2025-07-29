<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lista_Ordini.aspx.cs" Inherits="INTRA.Magazziniere.Lista_Ordini" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function OnGetRowValues(value) {
            openwindow("Magazzino/Ordini_Dett.aspx?OrdNum=" + value);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--    <dx:ASPxCallback runat="server" ID="GeneraBolla_Callback" ClientInstanceName="GeneraBolla_Callback" OnCallback="GeneraBolla_Callback_Callback"></dx:ASPxCallback>--%>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Lista Ordini</h4>
                    <dx:ASPxGridView Width="100%" runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" OnHtmlRowPrepared="Generic_Gridview_HtmlRowPrepared" AutoGenerateColumns="False" DataSourceID="Generic_Sql">
                        <ClientSideEvents CustomButtonClick="function(s,e){if(e.buttonID == 'Vai'){s.GetRowValues(e.visibleIndex,'OrdNum',OnGetRowValues)}}" />
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
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
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Ordini" />
                        <SettingsCustomizationDialog Enabled="true" />

                        <Settings ShowFilterRow="True"></Settings>
                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
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
                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="false" Width="40px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Vai" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" Text="" />
                                </CustomButtons>

                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="OrdNum" VisibleIndex="1" Width="80px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="OrdDat" VisibleIndex="2" Width="80px"></dx:GridViewDataDateColumn>
                            <dx:GridViewBandColumn Caption="Deposito" VisibleIndex="3">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="Deposito" VisibleIndex="0" Width="60px" Caption="Codice"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_Ind" VisibleIndex="1" Caption="Indirizzo">
                                        <DataItemTemplate>
                                            <dx:ASPxLabel Text='<%# string.Format("{0} {1} {2} {3} {4}",Eval("U_I_Ind").ToString(),Eval("U_I_Loc").ToString(),Eval("U_I_Prov").ToString(),Eval("U_I_Cap").ToString(),Eval("U_I_NotePosizione").ToString()) %>' runat="server"></dx:ASPxLabel>
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Cliente" VisibleIndex="4">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="1" Caption="Codice" Width="80px"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="2" Caption="Ragione Sociale"></dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewDataDateColumn FieldName="U_Utente_Insert" VisibleIndex="5" Width="120px" Caption="Utente"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataComboBoxColumn FieldName="Descrizione" VisibleIndex="6" Caption="Stato" Width="150px">
                                <PropertiesComboBox DataSourceID="Stato_Dts" TextField="Descrizione" ValueField="Descrizione"></PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn FieldName="TotQta" VisibleIndex="9" Caption="Q.tà" Width="60px" CellStyle-HorizontalAlign="Center"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="10" Visible="false"></dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource runat="server" ID="Generic_Sql" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_I_OrdCliTest.OrdNum, U_I_OrdCliTest.OrdDat, Clienti.Denom, U_AnagraficaStatusOrdine.Descrizione, U_I_OrdCliTest.Deposito, U_I_OrdCliTest.PrevCons, U_I_OrdCliTest.TotQta, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_I_NotePosizione, U_I_OrdCliTest.ID, Clienti.CodCli, U_I_OrdCliTest.U_Utente_Insert FROM U_I_OrdCliTest INNER JOIN Clienti ON U_I_OrdCliTest.CodCli = Clienti.CodCli LEFT OUTER JOIN TabDep ON U_I_OrdCliTest.Deposito = TabDep.CodDep LEFT OUTER JOIN U_AnagraficaStatusOrdine ON U_I_OrdCliTest.FlagEvaso = U_AnagraficaStatusOrdine.IDStatus ORDER BY U_I_OrdCliTest.FlagEvaso, U_I_OrdCliTest.OrdNum DESC"></asp:SqlDataSource>
                    <asp:SqlDataSource runat="server" ID="Stato_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT IDStatus, Descrizione FROM U_AnagraficaStatusOrdine"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
