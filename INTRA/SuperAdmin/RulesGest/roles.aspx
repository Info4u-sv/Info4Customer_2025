<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="roles.aspx.cs" Inherits="INTRA.SuperAdmin.RulesGest.Role" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function OnCallbackPanelEndCallback(s, e) {
            if (s.cp_showNotification) {
                document.getElementById('<%= NewRole.ClientID %>').value = '';
                showNotification();
            }
        }
    </script>
    <dx:ASPxCallbackPanel ID="cpRolePanel" runat="server" ClientInstanceName="cpRolePanel" OnCallback="cpRolePanel_Callback">
        <ClientSideEvents EndCallback="OnCallbackPanelEndCallback" />
        <PanelCollection>
            <dx:PanelContent>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header card-header-icon" data-background-color="blue">
                                <i class="material-icons">assignment</i>
                            </div>
                            <div class="card-content">
                                <h4 class="card-title">Roles</h4>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <h3>Nuovo Ruolo:</h3>
                                    <asp:TextBox runat="server" ID="NewRole" ClientInstanceName="NewRole"></asp:TextBox>
                                    <br />
                                    <br />
                                    <dx:BootstrapButton ID="AddRoleButton" runat="server"
                                        Text=""
                                        UseSubmitBehavior="false"
                                        CssClasses-Bootstrap="btn-success btn-labeled shiny"
                                        Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-ruolo">
                                        <Badge IconCssClass="fa fa-plus" Text="Aggiungi Ruolo" />
                                        <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                        <ClientSideEvents Click="function(s, e) { e.processOnServer = false; cpRolePanel.PerformCallback('add'); }" />
                                    </dx:BootstrapButton>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" DataSourceID="SqlDataSource_Roles" KeyFieldName="RoleId" AutoGenerateColumns="False" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" OnRowDeleting="Generic_Gridview_RowDeleting" OnCustomButtonInitialize="Generic_Gridview_CustomButtonInitialize">
                                        <Styles Header-Wrap="True" Cell-Paddings-Padding="7" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                        <SettingsPager PageSize="20" PageSizeItemSettings-Items="20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                                        <ClientSideEvents
                                            CustomButtonClick="OnCustomButtonClick"
                                            EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showNotification();}}" />
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
                                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Ruoli" />
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
                                            <dx:GridViewCommandColumn ShowEditButton="false" ShowDeleteButton="false"  VisibleIndex="0" ShowNewButtonInHeader="false" ShowClearFilterButton="false" Width="60px">
                                                <CustomButtons>
                                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="DeleteConfirmButton" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                                </CustomButtons>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="RoleId" Visible="false" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="RoleName" Caption="Role Name" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="NumeroUtenti" Caption="User Count" VisibleIndex="2" Width="10%"></dx:GridViewDataTextColumn>

                                        </Columns>
                                    </dx:ASPxGridView>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <asp:SqlDataSource ID="SqlDataSource_Roles" runat="server"
        ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="
        SELECT 
    R.RoleId,
    R.RoleName,
    COUNT(UR.UserId) AS NumeroUtenti
FROM 
    aspnet_Roles R
LEFT JOIN 
    aspnet_UsersInRoles UR ON R.RoleId = UR.RoleId
GROUP BY 
    R.RoleId, R.RoleName
ORDER BY 
    R.RoleName ASC"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
    <style>
        .btn-ruolo {
            margin: 0px !important;
        }
    </style>
    <script>
        function OnCustomButtonClick(s, e) {
            if (e.buttonID === "DeleteConfirmButton") {
                var visibleIndex = e.visibleIndex;
                OnGetRowValuesElimina(visibleIndex);
            }
        }
        $(function () {
            $(document).on('click', '#<%= Generic_Gridview.ClientID %> .dxgvDeleteRowButton', function (e) {
                e.preventDefault();
                var rowIndex = $(this).closest('tr').index();
                OnGetRowValuesElimina(rowIndex);
            });
        });
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction(
                "Conferma Cancellazione",
                "Confermi di voler eliminare il ruolo selezionato?",
                "Conferma",
                "Annulla",
                Elimina,
                OperazioneAnnullata,
                index,
                null
            );
        }

        function Elimina(visibleIndex) {
            Generic_Gridview.DeleteRow(visibleIndex);
        }

        function OperazioneAnnullata() {
            console.log("Eliminazione annullata dall'utente");
        }

        function ConfermaOperazioneWithClientFunction(Title, Testo, BtnConfirmTxt, BtnCancelTxt, Function, FunctionCancel = null, FunctionParam = null, FunctionCancelParam = null) {
            swal({
                title: Title,
                text: Testo,
                type: 'warning',
                showCancelButton: true,
                confirmButtonClass: 'btn btn-success',
                cancelButtonClass: 'btn btn-danger',
                confirmButtonText: BtnConfirmTxt,
                cancelButtonText: BtnCancelTxt,
                buttonsStyling: false,
            }, function (isConfirm) {
                if (isConfirm) {
                    if (FunctionParam != null) {
                        Function(FunctionParam);
                    } else {
                        Function();
                    }
                } else {
                    if (FunctionCancel != null) {
                        if (FunctionCancelParam != null) {
                            FunctionCancel(FunctionCancelParam);
                        } else {
                            FunctionCancel();
                        }
                    }
                }
            });
        }

    </script>
</asp:Content>
