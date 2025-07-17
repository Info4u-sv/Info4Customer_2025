<%@ Page Title="" Language="C#" MasterPageFile="~/SiteRBUtente.Master" AutoEventWireup="true" CodeBehind="Lista_Ordini_v2.aspx.cs" Inherits="INTRA.Age_Ordini.BR_Ordini.Lista_Ordini_v2" %>

<%@ Register Assembly="DevExpress.Web.v22.1, Version=22.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-xs-12 col-md-12 col-lg-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
                    <i class="material-icons">list</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Lista Ordini 
                        <div style="float: right">
                            <asp:LinkButton Visible="false" ID="NuovoOrdine_Btn" href="Inserimento_Ordini_v4.aspx" CssClass="btn btn-labeled btn-success" runat="server"><i class="btn-label fa fa-check"></i>Nuovo Ordine</asp:LinkButton>
                        </div>
                    </h4>


                    <dx:ASPxGridView ID="ListaOrdini_Grw" buttonrendermode="Image" runat="server" DataSourceID="ListaOrdini_Dts" Width="100%" AutoGenerateColumns="False" OnHtmlRowPrepared="ListaOrdini_Grw_HtmlRowPrepared">
                        <SettingsAdaptivity AdaptivityMode="HideDataCells">
                        </SettingsAdaptivity>
                        <Settings ShowFilterRow="True" GridLines="Both" ShowFilterRowMenu="True" ShowHeaderFilterButton="True" />
                        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                        <SettingsBehavior AllowSelectSingleRowOnly="true" AutoFilterRowInputDelay="999999999" />
                        <Settings AutoFilterCondition="Contains" />
                        <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsCommandButton>
                            <ClearFilterButton>
                                <Image ToolTip="Svuota Ricerche" Url="../img/DevExButton/clear.png" Width="30px"></Image>
                            </ClearFilterButton>
                            <NewButton>
                                <Image ToolTip="Nuovo" Url="../img/DevExButton/new.png" Width="30px"></Image>
                            </NewButton>

                            <UpdateButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Aggiorna" Height="30px" Url="../img/DevExButton/update.png"></Image>
                            </UpdateButton>

                            <CancelButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Annulla" Height="30px" Url="../img/DevExButton/cancel.png"></Image>
                            </CancelButton>

                            <EditButton>
                                <Image ToolTip="Modifica" Height="30px" Url="../img/DevExButton/edit.png"></Image>
                            </EditButton>

                            <DeleteButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Elimina" Height="30px" Url="../img/DevExButton/delete.png"></Image>
                            </DeleteButton>
                        </SettingsCommandButton>
                        <Styles AlternatingRow-Enabled="True"></Styles>
                        <Toolbars>
                            <dx:GridViewToolbar>
                                <Items>
                                    <dx:GridViewToolbarItem Alignment="left">
                                        <Template>
                                            <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%">
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
                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />

                        <Columns>
                            <dx:GridViewCommandColumn ButtonRenderMode="Image" VisibleIndex="0" ShowClearFilterButton="True" Visible="false">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataHyperLinkColumn VisibleIndex="1" Width="40px">
                                <DataItemTemplate>
                                    <a href='Inserimento_Ordini_view_v4.aspx?CodCLi=<%# Eval("CodCli") %>&NOrd=<%# Eval("ID") %>'>
                                        <asp:Image ImageUrl="~/img/DevExButton/edit.png" runat="server" Width="30px" /></a>
                                </DataItemTemplate>
                            </dx:GridViewDataHyperLinkColumn>
                            <dx:GridViewDataTextColumn FieldName="OrdNum" VisibleIndex="3" Caption="Numero Ordine" Width="100px">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="OrdDat" VisibleIndex="4" Caption="Data Ordine" Width="100px">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="5" Caption="Codice Cliente" Width="100px">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="6" Caption="Cliente">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="7" Caption="Stato">
                            </dx:GridViewDataTextColumn>
                            <%--                                    <dx:GridViewDataImageColumn FieldName="Url" Caption="Stato" PropertiesImage-ImageWidth="30px"></dx:GridViewDataImageColumn>--%>
                            <dx:GridViewDataTextColumn FieldName="DescrAgente" VisibleIndex="8" Caption="Agente">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="U_Portale" VisibleIndex="9" Caption="Provenienza" Width="80px">
                            </dx:GridViewDataTextColumn>
                              <dx:GridViewDataTextColumn FieldName="U_CreatedOn" VisibleIndex="9" Caption="Creato il" Width="150px">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataSpinEditColumn Caption="ID Ordine" FieldName="ID" VisibleIndex="2" Visible="false">
                                <PropertiesSpinEdit DisplayFormatString="g">
                                </PropertiesSpinEdit>
                            </dx:GridViewDataSpinEditColumn>
                            <dx:GridViewDataTextColumn FieldName="FlagStampa" VisibleIndex="10">
                                <HeaderStyle CssClass="HideColumn" />
                                <EditCellStyle CssClass="HideColumn" />
                                <CellStyle CssClass="HideColumn" />
                                <FilterCellStyle CssClass="HideColumn" />
                                <FooterCellStyle CssClass="HideColumn" />
                                <GroupFooterCellStyle CssClass="HideColumn" />
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="ListaOrdini_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Clienti.Denom, OrdCliTest.OrdNum, OrdCliTest.ID, OrdCliTest.OrdDat, OrdCliTest.CodCli, TabAge.U_User_Web, OrdCliTest.FlagEvaso, U_AnagraficaStatusOrdine.Descrizione, U_AnagraficaStatusOrdine.Url, ISNULL(OrdCliTest.U_Portale, 'K') AS U_Portale, TabAge.Descrizione AS DescrAgente, OrdCliTest.FlagStampa, OrdCliTest.U_CreatedOn FROM Clienti INNER JOIN OrdCliTest ON Clienti.CodCli = OrdCliTest.CodCli INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli LEFT OUTER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge LEFT OUTER JOIN U_AnagraficaStatusOrdine ON OrdCliTest.FlagEvaso = U_AnagraficaStatusOrdine.IDstatus ORDER BY OrdCliTest.OrdNum DESC"></asp:SqlDataSource>
    <%--    <dx:linqservermodedatasource id="ListaOrdini_LinqDts" runat="server" contexttypename="ListaOrdini_LINQDataContext" tablename="View_LINQDataSourceOrdini" onselecting="ListaOrdini_LinqDts_Selecting" />--%>
</asp:Content>


