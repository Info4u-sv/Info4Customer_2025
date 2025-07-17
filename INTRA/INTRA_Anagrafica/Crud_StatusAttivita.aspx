<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Crud_StatusAttivita.aspx.cs" Inherits="INTRA.INTRA_Anagrafica.Crud_StatusAttivita" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">people_alt</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Status Attività</h4>

                    <dx:ASPxGridView ID="Generic_gridview" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Generic_gridview" DataSourceID="Generic_Dts" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="id" OnRowUpdating="Generic_gridview_RowUpdating">
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
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="ProspectList" />
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
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowEditButton="true" ShowNewButtonInHeader="true"></dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="1" EditFormCaptionStyle-CssClass="TitleCell" EditFormSettings-CaptionLocation="top"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="2" EditFormCaptionStyle-CssClass="TitleCell" EditFormSettings-CaptionLocation="top"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="LabelClass" VisibleIndex="3" EditFormCaptionStyle-CssClass="TitleCell" EditFormSettings-CaptionLocation="top">
                                <EditItemTemplate>
                                    <dx:ASPxColorEdit runat="server" EnableCustomColors="true" ID="ColorEditHeaderBackColor" Color='<%# GetColor(Eval("LabelClass")) %>' Width="150px" ClearButton-DisplayMode="Never">
                                    </dx:ASPxColorEdit>
                                </EditItemTemplate>
                                <DataItemTemplate>
                                    <dx:ASPxColorEdit runat="server" EnableCustomColors="true" ID="ColorEditHeaderBackColor" Color='<%# GetColor(Eval("LabelClass")) %>' Width="150px" ClearButton-DisplayMode="Never" Enabled="false">
                                    </dx:ASPxColorEdit>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="780" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1">
                            <AdaptiveDetailLayoutProperties>
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                            </AdaptiveDetailLayoutProperties>
                            <AdaptiveDetailLayoutProperties Paddings-Padding="0">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="300" />
                                <Items>
                                    <dx:GridViewColumnLayoutItem ColumnName="Resp" HorizontalAlign="Left" Paddings-Padding="0" Width="100%" ShowCaption="False">
                                    </dx:GridViewColumnLayoutItem>
                                </Items>
                            </AdaptiveDetailLayoutProperties>
                        </SettingsAdaptivity>

                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' InsertCommand="INSERT INTO CRM4U_StatusAttivita(Descrizione, DisplayOrder, LabelClass) VALUES (@Descrizione, @DisplayOrder, @LabelClass)" SelectCommand="SELECT CRM4U_StatusAttivita.* FROM CRM4U_StatusAttivita" UpdateCommand="UPDATE CRM4U_StatusAttivita SET Descrizione = @Descrizione, DisplayOrder = @DisplayOrder, LabelClass = @LabelClass WHERE (id = @id)">
        <InsertParameters>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="DisplayOrder"></asp:Parameter>
            <asp:Parameter Name="LabelClass"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="DisplayOrder"></asp:Parameter>
            <asp:Parameter Name="LabelClass"></asp:Parameter>
            <asp:Parameter Name="id"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
