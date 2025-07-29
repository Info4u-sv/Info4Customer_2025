<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lista_Bolle.aspx.cs" Inherits="INTRA.Bolle.Lista_Bolle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function OnGetRowValues(value) {
            openwindow("Bolle/DettaglioBolla.aspx?IdTestata=" + value);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Lista Bolle</h4>
                    <dx:ASPxGridView runat="server" ID="Bolle_Gridview" ClientInstanceName="Bolle_Gridview" Width="100%" AutoGenerateColumns="False" DataSourceID="Bolle_Dts" KeyFieldName="ID" Styles-AlternatingRow-Enabled="True">
                        <ClientSideEvents CustomButtonClick="function(s,e){if(e.buttonID == 'Vai'){s.GetRowValues(e.visibleIndex,'ID',OnGetRowValues)}}" />
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
                                    <dx:GridViewToolbarItem Command="ClearFilter" Text="Cancella Flitro" />
                                    <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                </Items>
                            </dx:GridViewToolbar>
                        </Toolbars>
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Depositi" />
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
                            <dx:GridViewCommandColumn ShowEditButton="False" VisibleIndex="0" ShowNewButtonInHeader="False" ShowClearFilterButton="false" Width="40px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Vai" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" Text="" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="NumDoc" VisibleIndex="0" Width="100px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="DataDoc" VisibleIndex="1" Width="80px"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="TotMerce" VisibleIndex="3" PropertiesTextEdit-DisplayFormatString="{0:c2}" Caption="Totale"></dx:GridViewDataTextColumn>
                            <dx:GridViewBandColumn Caption="Cliente" VisibleIndex="2">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="Cliente" VisibleIndex="0" Caption="Codice" Width="120"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="1" Caption="Società"></dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="5" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource runat="server" ID="Bolle_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT BolleTest.NumDoc, BolleTest.DataDoc, Clienti.Denom, BolleTest.TotMerce, BolleTest.Cliente, BolleTest.ID FROM BolleTest INNER JOIN Clienti ON BolleTest.Cliente = Clienti.CodCli WHERE (BolleTest.Tipo = 'B') AND (BolleTest.Anno = YEAR(GETDATE())) ORDER BY BolleTest.ID DESC"></asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
