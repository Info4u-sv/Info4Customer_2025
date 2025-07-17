<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_Magazzino.aspx.cs" Inherits="INTRA.Magazzino.Dashboard_Magazzino" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Dashboard Magazzino</h4>
                    <div class="col-lg-12" style="padding-bottom: 10px;">
                        <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Dts" KeyFieldName="CodDep" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                            <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
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
                                        <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                    </Items>
                                </dx:GridViewToolbar>
                            </Toolbars>
                            <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Depositi_Sotto_Scorta" />
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
                                <dx:GridViewDataTextColumn FieldName="CodDep" ReadOnly="True" VisibleIndex="0" Width="80px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="U_I_Ind" VisibleIndex="2" Caption="Indirizzo"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="U_I_Prov" VisibleIndex="3" Width="80px" Caption="Provincia"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="U_I_Loc" VisibleIndex="4" Width="150px" Caption="Località"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="U_I_Cap" VisibleIndex="5" Width="80px" Caption="Cap"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="U_I_DsNaz" VisibleIndex="6" Width="100px" Caption="Nazione"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="U_I_NotePosizione" VisibleIndex="7" Caption="Posizione"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="U_UltimoControllo_Inventario" VisibleIndex="8" Width="80px" Caption="Ultimo Censimento"></dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="0"></dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsDetail IsDetailGrid="True" />
                            <SettingsDetail ShowDetailRow="true" />
                            <Templates>
                                <DetailRow>
                                    <dx:ASPxGridView ID="detail_Gridview" ClientInstanceName="detail_Gridview" runat="server" AutoGenerateColumns="False" DataSourceID="Detail_Dts" OnBeforePerformDataSelect="detail_Gridview_BeforePerformDataSelect" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" OnHtmlRowPrepared="detail_Gridview_HtmlRowPrepared">
                                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                                        <%--<Toolbars>
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
                                                </Items>
                                            </dx:GridViewToolbar>
                                        </Toolbars>--%>
                                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Articoli" />
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
                                            <dx:GridViewDataTextColumn FieldName="Qta_Min" VisibleIndex="2" Width="80px"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CodDep" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="0" Width="160px"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Giacenza" VisibleIndex="3" ReadOnly="True" Width="80px"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                </DetailRow>
                            </Templates>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Generic_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT TabDep.CodDep, TabDep.Descrizione, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_I_DsNaz, TabDep.U_I_NotePosizione, TabDep.U_UltimoControllo_Inventario, Clienti.Denom FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Detail_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_Inventario_Deposito.Qta_Min, U_Inventario_Deposito.CodDep, U_Inventario_Deposito.CodArt, ISNULL(Giacenza_Deposito.Giacenza, 0) AS Giacenza, Articoli.Descrizione FROM U_Inventario_Deposito LEFT OUTER JOIN Articoli ON U_Inventario_Deposito.CodArt = Articoli.CodArt LEFT OUTER JOIN (SELECT SaldiMag_1.DsSaldo, SaldiMag_1.Carichi - SaldiMag_1.Scarichi AS Giacenza, SaldiMag_1.CodArt FROM SaldiMag AS SaldiMag_1 INNER JOIN Esercizi ON SaldiMag_1.Esercizio = Esercizi.NumEser WHERE (Esercizi.DataFine >= GETDATE()) AND (Esercizi.DataIni <= GETDATE())) AS Giacenza_Deposito ON U_Inventario_Deposito.CodDep = Giacenza_Deposito.DsSaldo AND U_Inventario_Deposito.CodArt = Giacenza_Deposito.CodArt WHERE (U_Inventario_Deposito.CodDep = @CodDep)">
        <SelectParameters>
            <asp:SessionParameter SessionField="CodDep_Session" Name="CodDep"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
