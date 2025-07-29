<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VersioneIntranet_Tbl_CRUD.aspx.cs" Inherits="INTRA.SuperAdmin.VersioneIntranet_Tbl_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">people_alt</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">VersioneIntranet 2023 Tbl CRUD </h4>
                    <strong>questa pagina consente la modifica dei dati della versione.
                    non è più necessario modificare a mano il file xml e il web.config</strong>
                    <dx:ASPxGridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False"
                        KeyFieldName="Id" ClientInstanceName="GridView1" EnablePaging="True" PageSize="10"
                        OnRowUpdating="GridView1_RowUpdating" OnRowValidating="GridView1_RowValidating"
                        OnPageIndexChanged="GridView1_PageIndexChanged"
                        SettingsEditing-Mode="Inline"
                        SettingsEditing-AllowEdit="True"
                        SettingsEditing-AllowInsert="False"
                        SettingsEditing-AllowDelete="False"
                        CssClass="table table-striped table-hover">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT'){showNotification();}}" />
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
                        <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>
                        <SettingsPopup>
                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                        </SettingsPopup>
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
                        <SettingsEditing EditFormColumnCount="1" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="false" ShowClearFilterButton="false" Width="60px" />
                            <dx:GridViewDataTextColumn FieldName="Id" Caption="Id" VisibleIndex="0" Visible="false" ReadOnly="True" Width="50px" />
                            <dx:GridViewDataTextColumn FieldName="TitVers" Caption="TitVers" VisibleIndex="1" EditFormSettings-CaptionLocation="Top" />
                            <dx:GridViewDataTextColumn FieldName="NewFeatures" Caption="NewFeatures" VisibleIndex="2" EditFormSettings-CaptionLocation="Top" />
                            <dx:GridViewDataTextColumn FieldName="BugFix" Caption="BugFix" VisibleIndex="3" EditFormSettings-CaptionLocation="Top" />
                            <dx:GridViewDataTextColumn FieldName="NumeroLic" Caption="NumeroLic" VisibleIndex="4" EditFormSettings-CaptionLocation="Top" />
                            <dx:GridViewDataTextColumn FieldName="RagSoc" Caption="RagSoc" VisibleIndex="5" EditFormSettings-CaptionLocation="Top" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
