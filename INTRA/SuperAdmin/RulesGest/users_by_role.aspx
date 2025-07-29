<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="users_by_role.aspx.cs" Inherits="INTRA.SuperAdmin.RulesGest.users_by_role" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
        .DecorationLblGrid-new {
            border-radius: 7px;
            padding: 4px;
            color: White !important;
            text-transform: uppercase;
            font-size: x-small !important;
            font-weight: bolder !important;
            line-height: 20px;
            padding-left: 10px;
        }
    </style>
    <script>


        //function OnCustomButtonClick(s, e) {

        //    if (e.buttonID == "GoTo") {
        //        s.GetRowValues(e.visibleIndex, 'UserName', GotoNewPage);
        //    }
        //}


        //function GotoNewPage(value) {
        //    EditCallback.PerformCallback(value);
        //}

        function OnCustomButtonClick(s, e) {
            if (e.buttonID === "GoTo") {
                s.GetRowValues(e.visibleIndex, 'UserId', function (userId) {
                    const url = '/SuperAdmin/UserGest/edit_user_tm.aspx?userId=' + userId;
                    window.open(url, '_blank');
                });
            }
        }
        //ddl.addEventListener("change", function () {
        //    GridCallbackPanel.PerformCallback(this.value);
        //});



        //document.getElementById("UserRoles").addEventListener("change", function () {
        //    GridCallbackPanel.PerformCallback(this.value);
        //});


        // solo quando tutta la pagina è statae caricata
        window.onload = function () {
            var ddl = document.getElementById("UserRoles");
            if (ddl) {
                ddl.addEventListener("change", function () {
                    GridCallbackPanel.PerformCallback(this.value);
                });
            }
        };
        function setupCustomSearch() {
            const searchEditor = ASPxClientControl.GetControlCollection().GetByName("tbToolbarSearch");
            const grid = ASPxClientControl.GetControlCollection().GetByName("User_Grdw");

            if (searchEditor && grid) {
                searchEditor.TextChanged.AddHandler(function (s, e) {
                    grid.ApplySearchPanelFilter(s.GetText());
                });
            }
        }

        window.onload = function () {
            setupCustomSearch();

            const ddl = document.getElementById("<%= UserRoles.ClientID %>");
            if (ddl) {
                ddl.addEventListener("change", function () {
                    const role = this.value;
                    GridCallbackPanel.PerformCallback(role);
                });
            }
        };

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">

        <div class="col-md-12">
            <div class="card">
                <div class="version-text" style="position: absolute; top: 1px; right: 25px; font-size: 13px; color: #999; font-family: 'Helvetica Neue', Arial, sans-serif; font-style: italic; z-index: 999;">
                    Versione 7/2025
                </div>
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">


                    <%--<div class="col-xs-12 col-md-12 col-lg-12" style="padding-top: 10px;">
                        Role filter:


                        <asp:DropDownList ID="UserRoles" runat="server" AppendDataBoundItems="true" AutoPostBack="false">
                            <asp:ListItem>Show All</asp:ListItem>
                        </asp:DropDownList>
                    </div>--%>

                    <div class="col-xs-12 col-md-12 col-lg-12" style="padding-top: 10px;">
                        Role filter:
    <asp:DropDownList
        ID="UserRoles"
        runat="server"
        AutoPostBack="false"
        OnSelectedIndexChanged="UserRoles_SelectedIndexChanged">
        <asp:ListItem Text="Show All" Value="Show All"></asp:ListItem>
    </asp:DropDownList>
                    </div>


                    <%--metto le colonne in un aspcallback panel--%>

                    <dx:ASPxCallbackPanel ID="GridCallbackPanel" runat="server" ClientInstanceName="GridCallbackPanel" OnCallback="GridCallbackPanel_Callback">

                        <ClientSideEvents EndCallback="function(s, e) { showNotification(); }" />
                        <PanelCollection>
                            <dx:PanelContent>
                                <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="User_Grdw" ClientInstanceName="User_Grdw" runat="server" Theme="Office365" Width="100%" AutoGenerateColumns="False" KeyFieldName="UserName" OnPageIndexChanged="User_Grdw_PageIndexChanged" OnDataBinding="User_Grdw_DataBinding">
                                    <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />

                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                    <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                    <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowHeaderFilterButton="True" />
                                    <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>
                                    <Toolbars>
                                        <dx:GridViewToolbar>
                                            <Items>
                                                <dx:GridViewToolbarItem Alignment="left">
                                                    <Template>
                                                        <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always" ClientInstanceName="tbToolbarSearch">
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
                                    <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                                    <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                                    <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup>
                                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Utenti_Per_Ruolo" />
                                    <SettingsCommandButton>
                                        <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                        </ClearFilterButton>

                                        <%-- PULSANTE EDIT  --%>
                                        <%--<EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
                                        </EditButton>--%>



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


                                    <Styles AlternatingRow-Enabled="True" AlternatingRow-BackColor="#eaeaea">
                                        <AlternatingRow Enabled="True" BackColor="#EAEAEA"></AlternatingRow>
                                    </Styles>

                                    <%--colonne dentro il call back panel--%>

                                    <Columns>

                                        <%--<dx:GridViewDataTextColumn Caption="Azioni" VisibleIndex="0">
                                         <DataItemTemplate>
                                             <div style="padding: 0px; width: 110px;">
                                                 <dx:BootstrapButton ID="EditButton" runat="server" AutoPostBack="false" Text="Edit" OnClick="EditButton_Click" CssClasses-Icon="fa fa-edit">
                                                     <SettingsBootstrap RenderOption="Warning" />
                                                 </dx:BootstrapButton>--%>
                                        <%--<dx:BootstrapHyperLink ID="Editlink_Boop" runat="server" ></dx:BootstrapHyperLink>
                                             <a class="btn btn-just-icon btn-info" runat="server" id="Editlink" onclick="Editlink_Click" style="display:inline" href="#"><i class="btn-label fa fa-search"></i></a>
                                             <a class="btn btn-just-icon btn-warning"  style="display:inline"  href="edit_user_tm.aspx?userId=<%# Eval("UserId") %>"><i class="btn-label fa fa-edit"></i></a>--%>
                                        <%-- </div>
                                         </DataItemTemplate>
                                     </dx:GridViewDataTextColumn>--%>

                                        <dx:GridViewCommandColumn Caption="Azioni" VisibleIndex="0" ShowClearFilterButton="false" Name="------">

                                            <CustomButtons>
                                                <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                            </CustomButtons>

                                            <%-- evento sideclient --%>
                                        </dx:GridViewCommandColumn>

                                        <dx:GridViewDataTextColumn FieldName="UserName" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                            <DataItemTemplate>
                                                <a href='/SuperAdmin/UserGest/edit_user_tm.aspx?userId=<%#Eval("UserId")  %>'>
                                                    <%#Eval("UserName")  %></a>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Email" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="3">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Comment" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="4">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CreationDate" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="5">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="LastLoginDate" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="6">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="LastActivityDate" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="7">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IsApproved" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="8">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IsOnline" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="9">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IsLockedOut" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="10">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="UserId" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="10" Visible="false">
                                        </dx:GridViewDataTextColumn>

                                    </Columns>

                                </dx:ASPxGridView>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                    <%--<dx:ASPxCallback ID="EditCallback" runat="server" ClientInstanceName="EditCallback" OnCallback="EditCallback_Callback"></dx:ASPxCallback>--%>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
