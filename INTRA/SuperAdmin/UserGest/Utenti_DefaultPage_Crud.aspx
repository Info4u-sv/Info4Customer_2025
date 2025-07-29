<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Utenti_DefaultPage_Crud.aspx.cs" Inherits="INTRA.SuperAdmin.UserGest.Utenti_DefaultPage_Crud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">security</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Utenti abilita Pagina di Default
                    </h4>
                    <div class="col-lg-12" style="color: red">
                        Questa pagina di default utente sovrascrive la pagina di default impostata per il ruolo
                        <br />
                        Se non gestito inserire ND
                    </div>

                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Sql" KeyFieldName="UserId" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">

                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT'){Generic_Gridview.Refresh(); showNotification();}}" />
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
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Utenti_Abilita_Pagina_Di_Default" />
                        <SettingsCustomizationDialog Enabled="true" />
                        <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>
                        <SettingsPopup>
                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                        </SettingsPopup>
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
                            <dx:GridViewCommandColumn ShowNewButtonInHeader="false" ShowEditButton="true" VisibleIndex="0" Width="60px"></dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="UserId" VisibleIndex="1" Visible="false" ReadOnly="true"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="UserName" Caption="Username" VisibleIndex="2" ReadOnly="true" EditFormSettings-CaptionLocation="Top"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="PageDefault" VisibleIndex="3" EditFormSettings-CaptionLocation="Top"></dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        ApplicationId, [UserId], [UserName], PageDefault
FROM  [aspnet_Users] "
        UpdateCommand="UPDATE [aspnet_Users] SET PageDefault = @PageDefault WHERE ([UserId] = @UserId)">
        <UpdateParameters>
            <asp:Parameter Name="PageDefault"></asp:Parameter>
            <asp:Parameter Name="UserId"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
