<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DettaglioBolla.aspx.cs" Inherits="INTRA.Bolle.DettaglioBolla" %>

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
                    <div style="float: right; padding-right: 10px;">
                        <dx:BootstrapButton runat="server" Text="" ID="Torna_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
                            <Badge IconCssClass="fa fa-arrow-left" Text="" />
                            <SettingsBootstrap RenderOption="Warning" />
                            <ClientSideEvents Click="function(s,e){window.history.back();}" />
                        </dx:BootstrapButton>
                    </div>
                    <h4 class="card-title">
                        <asp:Label ID="TitoloPagina_Lbl" runat="server"></asp:Label>
                    </h4>
                    <dx:ASPxLabel runat="server" ID="Tipo_Lbl" Text="" Font-Bold="true" Style="font-size: 16px"></dx:ASPxLabel>
                    <dx:ASPxGridView runat="server" ID="Bolla_Gridview" ClientInstanceName="Bolla_Gridview" EnableRowsCache="False" AutoGenerateColumns="False" Enabled="false" DataSourceID="Bolla_Dts" Width="100%">
                        <Styles AlternatingRow-Enabled="True"></Styles>
                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                        <SettingsPager PageSize="9999999">
                        </SettingsPager>
                        <Settings ShowFooter="true" />
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="ValoreMov" ShowInColumn="ValoreMov" SummaryType="Sum" DisplayFormat="Totale: {0:c2}"></dx:ASPxSummaryItem>
                        </TotalSummary>
                        <SettingsDataSecurity AllowInsert="False" AllowEdit="False" AllowDelete="False" />
                        <SettingsPopup>
                            <EditForm Width="600" />
                        </SettingsPopup>
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="0" Width="200px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Um" VisibleIndex="2" Width="90px" Caption="UM"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Qta" VisibleIndex="3" Width="90px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ImpUni" VisibleIndex="4" Width="200px" Caption="Prezzo € c/u" PropertiesTextEdit-DisplayFormatString="{0:c2}"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ValoreMov" VisibleIndex="6" Width="200px" Caption="Tot. importo €" PropertiesTextEdit-DisplayFormatString="{0:c2}"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" ReadOnly="True" VisibleIndex="1">
                                <DataItemTemplate>
                                    <dx:ASPxLabel runat="server" Text='<%# Eval("Desc2")==DBNull.Value ? Eval("Descrizione").ToString() : Eval("Descrizione").ToString() + " " + Eval("Desc2").ToString() %>'></dx:ASPxLabel>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodIva" Width="80px" VisibleIndex="5" Caption="IVA"></dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <div style="float: right; padding-top: 5px; padding-bottom: 10px;">
                        <dx:ASPxLabel runat="server" ID="TotIva" Text="" Font-Bold="true" Style="font-size: 16px"></dx:ASPxLabel>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Bolla_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT MovMagDett.CodArt, MovMagDett.Um, MovMagDett.Qta, MovMagDett.ImpUni, MovMagDett.ValoreMov, BolleTest.NumDoc, BolleTest.Cliente, Articoli.Descrizione, BolFatDett.CodIva, Articoli.Desc2 FROM BolleTest INNER JOIN BolFatDett INNER JOIN MovMagDett ON BolFatDett.ID = MovMagDett.IDdettDoc ON BolleTest.ID = BolFatDett.IDTest LEFT OUTER JOIN Articoli ON MovMagDett.CodArt = Articoli.CodArt WHERE (BolFatDett.Tipo = 'B') AND (MovMagDett.Tipo = 'B') AND (BolFatDett.IDTest = @IdTest)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="IdTestata" Name="IdTest"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
