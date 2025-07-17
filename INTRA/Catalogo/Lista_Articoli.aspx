<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lista_Articoli.aspx.cs" Inherits="INTRA.Catalogo.Lista_Articoli" %>

<%@ Register Src="~/Controls/AssociaPromo.ascx" TagPrefix="uc1" TagName="AssociaPromo" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <uc1:AssociaPromo runat="server" ID="AssociaPromo_Popup" />
    <dx:ASPxGridView runat="server" ID="Generic_Grw" ClientInstanceName="Generic_Grw" DataSourceID="Generic_Sql" Width="100%" OnHtmlDataCellPrepared="Generic_Grw_HtmlDataCellPrepared" KeyFieldName="ProductID" AutoGenerateColumns="False">
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

        <%--        <SettingsExport EnableClientSideExportAPI="true" FileName="ListaArticoli" />--%>
        <Settings ShowFilterRow="True"></Settings>
        <Styles AlternatingRow-Enabled="True"></Styles>
        <SettingsCommandButton RenderMode="Image">
            <ClearFilterButton RenderMode="Image">
                <Image Url="/img/DevExButton/clear.png" Width="25px" ToolTip="Svuota ricerche" />
            </ClearFilterButton>
            <EditButton>
                <Image Url="/img/DevExButton/edit.png" Width="30px" ToolTip="Modifica" />
            </EditButton>
            <DeleteButton>
                <Image Url="/img/DevExButton/delete.png" Width="30px" ToolTip="Elimina" />
            </DeleteButton>
            <UpdateButton>
                <Image Url="/img/DevExButton/save.png" Width="30px" ToolTip="Salva" />
            </UpdateButton>
            <CancelButton>
                <Image Url="/img/DevExButton/cancel.png" Width="30px" ToolTip="Annulla" />
            </CancelButton>
            <NewButton>
                <Image Url="/img/DevExButton/new.png" Width="30px" ToolTip="Annulla" />
            </NewButton>
        </SettingsCommandButton>

        <Columns>
            <dx:GridViewDataColumn VisibleIndex="0" Width="170px">
                <DataItemTemplate>
                    <a href='Articoli_Crud.aspx' data-original-title="Nuovo Prodotto" rel="tooltip" data-placement="top"><i class="material-icons action new">add</i></a>
                    <a href='Articoli_Crud.aspx?Cod=<%# Eval("ProductCod") %>' data-original-title="Vai al dettaglio" rel="tooltip" data-placement="top"><i class="material-icons action go">open_in_browser</i></a>
                    <a href='javascript: Promo_CallbackPnl.PerformCallback("<%# Eval("ProductCod") %>")' data-original-title="Gestione Promo" rel="tooltip" data-placement="top"><i class="material-icons action edit">local_offer</i></a>
                    <a href='javascript: ConfermaOperazione("Confermi di voler eliminare questo articolo?", "Elimina_CallbackPnl",<%# Container.VisibleIndex %>)' data-original-title="Elimina articolo" rel="tooltip" data-placement="top"><i class="material-icons action delete">delete</i></a>
                </DataItemTemplate>
            </dx:GridViewDataColumn>
            <dx:GridViewDataTextColumn FieldName="ProductCod" Caption="CodArt" VisibleIndex="0">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DisplayName" Caption="Articolo" VisibleIndex="0">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ShortDescription" Caption="Desc. Breve" VisibleIndex="0">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FullDescription" Caption="Desc. Estesa" VisibleIndex="0">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="AttributesList" Caption="Attributi" VisibleIndex="0">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="BRandName" Caption="Marchio" VisibleIndex="0" Visible="false">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="units" VisibleIndex="0" Caption="Unità" Width="30">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="quantity" VisibleIndex="0" Caption="Q.tà" Width="30">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Confezione" Caption="Confezione" VisibleIndex="0">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn FieldName="Price" VisibleIndex="0" Caption="Prezzo" PropertiesSpinEdit-DisplayFormatString="c" Width="30">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn FieldName="PromoPrice" VisibleIndex="0" Caption="Prezzo promo" PropertiesSpinEdit-DisplayFormatString="c">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataDateColumn FieldName="StartDate" Caption="Inizio">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="StopDate" Caption="Fine">
                <Settings FilterMode="Value" AutoFilterCondition="Contains" AllowHeaderFilter="True" />
            </dx:GridViewDataDateColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT SHP_Product.ProductID, SHP_Product.ProductCod, SHP_Product.DisplayName, SHP_Product.ShortDescription, SHP_Product.FullDescription, SHP_Brand.DisplayName AS BRandName, SHP_Product.units, SHP_Product.quantity, SHP_Product.Price, SHP_Promo.PromoPrice, SHP_Promo.StartDate, CASE WHEN SHP_Promo.StopDate > DATEADD(MONTH , 1 , getdate()) THEN CONCAT('ATTIVO | ' , FORMAT(SHP_Promo.StopDate , 'dd/MM/yyyy')) WHEN SHP_Promo.StopDate <= DATEADD(MONTH , 1 , getdate()) AND SHP_Promo.StopDate >= getdate() THEN CONCAT('IN SCADENZA | ' , FORMAT(SHP_Promo.StopDate , 'dd/MM/yyyy')) WHEN SHP_Promo.StopDate < getdate() THEN CONCAT('SCADUTO | ' , FORMAT(SHP_Promo.StopDate , 'dd/MM/yyyy')) END AS Scadenza, SHP_Promo.StopDate, SHP_Product.AttributesList, SHP_Product.Confezione FROM SHP_Product LEFT OUTER JOIN SHP_Promo ON SHP_Product.PromoId = SHP_Promo.PromoID LEFT OUTER JOIN SHP_Brand ON SHP_Product.BrandId = SHP_Brand.BrandId"></asp:SqlDataSource>


    <dx:ASPxCallback ID="Elimina_CallbackPnl" ClientInstanceName="Elimina_CallbackPnl" runat="server" OnCallback="Elimina_CallbackPnl_Callback">
        <ClientSideEvents BeginCallback="function(s,e){ClientLoadingPanel.Show()}" EndCallback="function(s,e){ClientLoadingPanel.Hide(); showNotification();Generic_Grw.Refresh();}" />
    </dx:ASPxCallback>

    <asp:SqlDataSource runat="server" ID="AppoggioEliminazione_Sql" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' DeleteCommand="SHP_Articolo_CompleteDelete" DeleteCommandType="StoredProcedure" SelectCommand="select 1">
        <DeleteParameters>
            <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>
