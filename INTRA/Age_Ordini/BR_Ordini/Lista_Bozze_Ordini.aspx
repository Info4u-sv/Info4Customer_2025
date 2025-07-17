<%@ Page Title="Intranet" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Lista_Bozze_Ordini.aspx.cs" Inherits=" INTRA.Age_Ordini.BR_Ordini.Lista_Bozze_Ordini" %>
<%@ Register Assembly="DevExpress.Web.v22.1, Version=22.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">

       <div class="row">
        <div class="col-xs-12 col-md-12 col-lg-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
                    <i class="material-icons">list</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Lista Bozze Ordini
                                           
                        <div style="float:right">
                             <dx:BootstrapButton runat="server" ID="NuovoOrdine_Btn" ClientInstanceName="NuovoOrdine_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ClientVisible="true">
                                <Badge Text="nuovo ordine" IconCssClass="fa fa-plus" />
                                <ClientSideEvents Click="function(s,e){window.location.replace('Inserimento_Ordini_v4.aspx');}" />
                                <SettingsBootstrap RenderOption="Success" />
                            </dx:BootstrapButton>
                        </div></h4>

                    <dx:ASPxGridView ID="ListaOrdini_Grw" ButtonRenderMode="Image" runat="server" DataSourceID="ListaOrdini_LinqDts" Width="100%" AutoGenerateColumns="False">
                        <SettingsAdaptivity AdaptivityMode="HideDataCells">
                        </SettingsAdaptivity>
                        <Settings ShowFilterRow="True" GridLines="Both" ShowFilterRowMenu="True" ShowHeaderFilterButton="false" />
                        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                        <SettingsBehavior AllowSelectSingleRowOnly="true" AutoFilterRowInputDelay="999999999" />
                        <Settings AutoFilterCondition="Contains" />
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
                            <dx:GridViewCommandColumn ButtonRenderMode="Image" VisibleIndex="0" ShowClearFilterButton="True">
                            </dx:GridViewCommandColumn>
                            <%--                                    <dx:GridViewDataTextColumn FieldName="OrdNum" VisibleIndex="2" Caption="Numero Ordine" >
                                    </dx:GridViewDataTextColumn>--%>
                            <dx:GridViewDataDateColumn FieldName="OrdDat" VisibleIndex="3" Caption="Data Ordine">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="4" Caption="Codice Cliente">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="5" Caption="Cliente">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="6" Caption="Stato">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DescrAgente" VisibleIndex="7" Caption="Agente">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataHyperLinkColumn VisibleIndex="0">
                                <DataItemTemplate>
                                    <a href='Inserimento_Ordini_v4.aspx?IdOrd=<%# Eval("ID") %>'>
                                        <asp:Image ImageUrl="~/img/DevExButton/edit.png" runat="server" Width="30px" /></a>
                                </DataItemTemplate>
                            </dx:GridViewDataHyperLinkColumn>
                            <dx:GridViewDataSpinEditColumn Caption="ID Ordine" FieldName="ID" VisibleIndex="1">
                                <PropertiesSpinEdit DisplayFormatString="g">
                                </PropertiesSpinEdit>
                            </dx:GridViewDataSpinEditColumn>
                            <dx:GridViewDataTextColumn FieldName="FlagStampa" VisibleIndex="8">
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
    <dx:LinqServerModeDataSource ID="ListaOrdini_LinqDts" runat="server" ContextTypeName="U_ViewBozzeOrdini_ViewDataContext" TableName="U_ViewBozzeOrdini_View" OnSelecting="ListaOrdini_LinqDts_Selecting" />

</asp:Content>


