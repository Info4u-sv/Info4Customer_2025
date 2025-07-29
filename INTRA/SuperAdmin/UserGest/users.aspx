<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="INTRA.SuperAdmin.UserGest.users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
        function OnCustomButtonClick(s, e) {
            if (e.buttonID == "GoTo") {
                s.GetRowValues(e.visibleIndex, 'UserName', function (value) {
                    EditCallback.PerformCallback(value);
                });
            }
            if (e.buttonID == "Reset") {
                s.GetRowValues(e.visibleIndex, 'UserName', function (value) {
                    User_txt.SetText(value);
                    Reset_User_Popup.Show();
                });
            }
            if (e.buttonID == 'Riattiva') {

                riattivaIndex = e.visibleIndex;
                e.processOnServer = false;

                ConfermaOperazioneWithClientFunction(
                    "Conferma Riattivazione",
                    "Confermi di voler riattivare l'utente selezionato?",
                    "Conferma",
                    "Annulla",
                    function () {
                        s.PerformCallback("Riattiva|" + riattivaIndex);
                    },
                    function () { },
                    0,
                    null
                );
            }
            if (e.buttonID == 'Sospendi') {
                sospendiIndex = e.visibleIndex;
                e.processOnServer = false;

                ConfermaOperazioneWithClientFunction(
                    "Conferma Sospensione",
                    "Confermi di voler sospendere l'utente selezionato?",
                    "Conferma",
                    "Annulla",
                    function () {
                        s.PerformCallback("Sospendi|" + sospendiIndex);
                    },
                    function () { },
                    0,
                    null
                );
            }
        }
        function OnEndCallback(s, e) {
            if (s.cpRefreshGrid) {
                delete s.cpRefreshGrid;
                s.PerformCallback();
            }
        }
    </script>
    <div class="row">

        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <div class="col-md-8">
                        <h4 class="card-title">Lista Utenti   
                        </h4>
                    </div>
                    <div style="float: right; padding-right: 5px;" class="col-md-1">
                        <div class="DecorationLblGrid-new" style="line-height: 10px; margin-top: 10px; padding: 10px; background-color: darkgreen;">
                            <a href="javascript:ApplyFilter(1)" style="color: #ffffff; font-size: small;" data-toggle="tooltip">online: <%= OnlineCount %></a>
                        </div>
                    </div>
                    <div style="float: right; padding-right: 5px;" class="col-md-1">
                        <div class="DecorationLblGrid-new" style="line-height: 10px; margin-top: 10px; padding: 10px; background-color: darkred;">
                            <a href="javascript:ApplyFilter(0)" style="color: #ffffff; font-size: small;" data-toggle="tooltip">bloccati: <%= LockedCount %></a>
                        </div>
                    </div>

                    <div style="float: right;">
                        <%--<dx:BootstrapButton ID="AddUtente" runat="server" AutoPostBack="false" Text="" OnClick="AddUtente_Click" CssClasses-Icon="fa fa-plus">
                            <SettingsBootstrap RenderOption="Info" Sizing="Small" />
                        </dx:BootstrapButton>--%>
                        <dx:BootstrapButton runat="server" ID="AddUtente" ClientInstanceName="AddUtente" OnClick="AddUtente_Click" ClientVisible="true" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-md position" rel="tooltip" data-placement="top" data-original-title="Aggiungi utente" UseSubmitBehavior="false">
                            <Badge IconCssClass="fa fa-plus" />
                            <SettingsBootstrap RenderOption="Info" Sizing="small" />
                        </dx:BootstrapButton>
                    </div>
                    <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="User_Grdw" ClientInstanceName="User_Grdw" runat="server" Theme="Office365" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID" OnCustomButtonInitialize="User_Grdw_CustomButtonInitialize" OnCustomButtonCallback="User_Grdw_CustomButtonCallback" OnCustomCallback="User_Grdw_CustomCallback">
  
                        <ClientSideEvents CustomButtonClick="OnCustomButtonClick" EndCallback="OnEndCallback" />
                        <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowHeaderFilterButton="True" />
                        <Settings ShowFilterRow="True" />
                        <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>
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

                        <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                        <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup>
                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Utenti" />
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
                        <Columns>
                            <dx:GridViewCommandColumn Caption="Azioni" ShowClearFilterButton="false" ShowEditButton="true">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Reset" IconCssClass="icon4u icon-reset image" CssClass="btn btn-sm btn-custom-padding action-btn reset" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Riattiva" IconCssClass="icon-riattiva" CssClass="btn btn-success btn-sm me-1" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Sospendi" IconCssClass="icon-sospendi" CssClass="btn btn-danger btn-sm" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <%--<dx:GridViewDataTextColumn Caption="Azioni" VisibleIndex="0">
                                <DataItemTemplate>
                                    <div style="padding: 0px; width: 110px;">
                                        <dx:BootstrapButton ID="EditButton" runat="server" CssClasses-Control="btn btn-sm" AutoPostBack="false" OnClick="EditButton_Click" CssClasses-Icon="fa fa-edit">
                                            <SettingsBootstrap RenderOption="Warning" />
                                        </dx:BootstrapButton>--%>
                            <%--  <dx:BootstrapHyperLink ID="Editlink_Boop" runat="server" ></dx:BootstrapHyperLink>
                                    <a class="btn btn-just-icon btn-info" runat="server" id="Editlink" onclick="Editlink_Click" style="display:inline" href="#"><i class="btn-label fa fa-search"></i></a>
                                    <a class="btn btn-just-icon btn-warning"  style="display:inline"  href="edit_user_tm.aspx?userId=<%# Eval("UserId") %>"><i class="btn-label fa fa-edit"></i></a>--%>
                            <%--</div>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>--%>
                            <dx:GridViewDataTextColumn FieldName="UserName" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
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
                            <dx:GridViewDataCheckColumn FieldName="IsOnline" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="9">
                                <PropertiesCheckEdit DisplayTextChecked="Online" DisplayTextUnchecked="Offline"></PropertiesCheckEdit>
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="IsLockedOut" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="10">
                                <PropertiesCheckEdit DisplayTextChecked="Bloccato" DisplayTextUnchecked="Sbloccato"></PropertiesCheckEdit>
                            </dx:GridViewDataCheckColumn>
                        </Columns>

                        <Styles AlternatingRow-Enabled="True" AlternatingRow-BackColor="#eaeaea">
                            <AlternatingRow Enabled="True" BackColor="#EAEAEA"></AlternatingRow>
                        </Styles>

                    </dx:ASPxGridView>
                    <dx:ASPxCallback ID="EditCallback" runat="server" ClientInstanceName="EditCallback" OnCallback="EditCallback_Callback"></dx:ASPxCallback>
                </div>
            </div>

        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Ruoli_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT DISTINCT RoleId, RoleName FROM aspnet_Roles"></asp:SqlDataSource>
    <dx:ASPxPopupControl runat="server" ID="Reset_User_Popup" ClientInstanceName="Reset_User_Popup" PopupHorizontalAlign="WindowCenter" HeaderText="Reset Utente" SettingsAdaptivity-Mode="OnWindowInnerWidth" ShowPageScrollbarWhenModal="true" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="CloseButton" Width="700px" Modal="true" PopupVerticalAlign="WindowCenter">
        <ContentCollection>
            <dx:PopupControlContentControl>
                <div class="col-lg-6">
                    <dx:ASPxTextBox runat="server" ID="User_txt" ClientInstanceName="User_txt" Width="100%" ClientEnabled="false" Caption="Utente" CaptionSettings-Position="Top"></dx:ASPxTextBox>
                </div>
                <div class="col-lg-6">
                    <dx:ASPxComboBox runat="server" ID="Ruolo_cb" ClientInstanceName="Ruolo_cb" Width="100%" Caption="Template Ruolo" CaptionSettings-Position="Top" DataSourceID="Ruoli_Dts" ValueField="RoleId" TextField="RoleName"></dx:ASPxComboBox>
                </div>
                <div class="col-lg-12">
                    <dx:BootstrapButton runat="server" ID="Reset_Btn" ClientInstanceName="Reset_Btn" ClientVisible="true" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-md position" rel="tooltip" data-placement="top" data-original-title="Esegui Reset" UseSubmitBehavior="false">
                        <Badge IconCssClass="fa fa-save" />
                        <SettingsBootstrap RenderOption="Success" Sizing="small" />
                        <ClientSideEvents Click="function(s,e){Reset_Callback.PerformCallback(User_txt.GetText());}" />
                    </dx:BootstrapButton>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxCallback runat="server" ID="Reset_Callback" ClientInstanceName="Reset_Callback" OnCallback="Reset_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Reset_User_Popup.Hide(); showNotification();}" />
    </dx:ASPxCallback>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">

    <script>
        function ApplyFilter(type) {
            switch (type) {
                case 1:
                    User_Grdw.ApplyFilter("[IsOnline] = true");
                    break;
                case 0:
                    User_Grdw.ApplyFilter("[IsLockedOut] = true");
                    break;
            }
        }

    </script>
    <style>
        .icon-riattiva::before {
            content: "";
            display: inline-block;
            background-image: url('/img/DevExButton/Start-on-go.png');
            background-size: contain;
            background-repeat: no-repeat;
            width: 20px;
            height: 20px;
            vertical-align: middle;
        }

        .icon-sospendi::before {
            content: "";
            display: inline-block;
            background-image: url('/img/DevExButton/stop.png');
            background-size: contain;
            background-repeat: no-repeat;
            width: 20px;
            height: 20px;
            vertical-align: middle;
        }
    </style>
</asp:Content>

