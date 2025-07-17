<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Status_Printer_CRUD.aspx.cs" Inherits="INTRA.Print_Gest.Status_Printer_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function OnCustomButtonClick(s, e) {
            var index = Generic_gridview.GetFocusedRowIndex();
            if (e.buttonID == "Avvio") {
                s.GetRowValues(e.visibleIndex, 'id', GotoNewPage);
            }

            if (e.buttonID == "GoTo") {
                /* s.GetRowValues(e.visibleIndex, 'id', GotoNewPage);*/
                s.GetRowValues(e.visibleIndex, 'ID', function (value) {
                    var getUrl = window.location;
                    var baseUrl = getUrl.protocol + "//" + getUrl.host + "/";
                    window.open(baseUrl + "Print_Gest/Status_Print_Edit.aspx?ID=" + value);
                });
            }
            if (e.buttonID == "Edit") {
                Generic_gridview.StartEditRow(e.visibleIndex);
            }
            if (e.buttonID == "Delete") {
                ConfermaGridViewDeleteRowNoCallback('Cancella il dato!', 'Generic_gridview', e.visibleIndex);
            }
        }
        function GotoNewPage(value) {
            window.location = "Prospect_Client_det.aspx?Cli=" + value;
        }


        function ConfermaGridViewDeleteRowNoCallback(Testo, ClientInstanceName, visibleIndex) {

            var retvar = false;

            swal({

                title: 'Confermi l\'operazione?',

                text: Testo,

                type: 'warning',

                showCancelButton: true,

                confirmButtonClass: 'btn btn-success',

                cancelButtonClass: 'btn btn-danger',

                confirmButtonText: 'INVIA',

                buttonsStyling: false,

                cancelButtonText: 'ANNULLA',

            }).then(function (isConfirm) {

                if (isConfirm) {

                    var ClientInstanceNameVar = eval(ClientInstanceName);

                    ClientInstanceNameVar.DeleteRow(visibleIndex);



                }

            });

        }
        function ShowHint(s, e) {
            var clientObject = Object.getOwnPropertyNames(s.options);

            /*alert(clientObject);*/
            e.contentElement.innerHTML = '<div class="hintContent">' +
                '<div>Click this button to add a new record.' + '' + '</div>' +
                '</div>';
            ASPxClientHint.UpdatePosition(e.hintElement);
        }




    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">people_alt</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Status Printer</h4>
                    <dx:ASPxHint ID="ASPxHint1" runat="server" TargetSelector=".dx-vam">
                        <%--  <ClientSideEvents Showing="ShowHint" />--%>
                    </dx:ASPxHint>
                    <dx:ASPxHint ID="ASPxHint2" runat="server" TargetSelector=".btn:hover" Content="ccc">
                        <%--  <ClientSideEvents Showing="ShowHint" />--%>
                    </dx:ASPxHint>
                    <dx:ASPxGridView ID="Generic_gridview" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Generic_gridview" DataSourceID="Status_Printer_Dts" runat="server" Width="100%" AutoGenerateColumns="False" OnRowInserting="Generic_gridview_RowInserting" OnRowUpdating="Generic_gridview_RowUpdating" KeyFieldName="ID">
                        <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                        <Styles AlternatingRow-Enabled="True"></Styles>
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>

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

                        <%-- Serve per farlo funzionare --%>
                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <%-- export button --%>

                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                        <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                        <ClientSideEvents EndCallback="function(s, e) { ASPxClientHint.Update(); }" />
                        <SettingsCommandButton>
                            <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                            </ClearFilterButton>
                            <%--  <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica"  Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
                            </EditButton>--%>
                            <%--  <DeleteButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn delete icon4u icon-delete image"></Styles>
                            </DeleteButton>--%>
                            <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                            </UpdateButton>
                            <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                            </CancelButton>
                            <NewButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                            </NewButton>
                            <SelectButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                            </SelectButton>

                        </SettingsCommandButton>


                        <%--Aggiungere alla griglia la selezione del numero di righe visualizzate:--%>

                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                        <%-- Aggiungere alla griglia la ricerca sulle colonne con --%>

                        <Settings ShowFilterRow="True" ShowHeaderFilterButton="True" AutoFilterCondition="Contains"></Settings>

                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>


                        <%-- pop-up--%>

                        <SettingsEditing EditFormColumnCount="1" Mode="PopupEditForm" />

                        <SettingsPopup EditForm-VerticalAlign="Middle" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>

                        <SettingsPopup>

                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>

                        </SettingsPopup>
                        <%--fine pop-up--%>


                        <%--bottoni--%>

                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>


                        <Columns>
                            <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="true" ShowEditButton="True" ShowDeleteButton="true" Width="80px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo" Text="Apri Dettaglio" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>

                            <%--colonna ID--%>
                            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" ReadOnly="True" Width="80px" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>

                            <%--colonna status--%>
                            <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>

                            <%--  colonna ID_semaforo--%>
                            <%--<dx:GridViewDataComboBoxColumn FieldName="ID_Semaforo" VisibleIndex="3">
                                <PropertiesComboBox InvalidStyle-BackColor="LightPink">
                                    <Items>
                                        <dx:ListEditItem Text="Green" Value="green" />
                                        <dx:ListEditItem Text="Yellow" Value="yellow" />
                                        <dx:ListEditItem Text="Red" Value="red" />
                                        <dx:ListEditItem Text="ND" Value="ND" />
                                    </Items>
                                    <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" />
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>--%>

                            <%--  colonna ID_semaforo comboBox --%>

                            <dx:GridViewDataComboBoxColumn FieldName="ID_Semaforo" VisibleIndex="3" EditFormSettings-CaptionLocation="Top">
                                <PropertiesComboBox DataSourceID="Semaforo_Status_Dts" ValueField="semaforo_desc" TextField="semaforo_desc">
                                </PropertiesComboBox>
                                <EditItemTemplate>
                                    <dx:ASPxComboBox runat="server" ID="Semaforo_CB" ClientInstanceName="Semaforo_CB" DataSourceID="Semaforo_Status_Dts" ValueField="semaforo_desc" TextField="semaforo_desc" Value='<%# Bind("ID_Semaforo") %>' ValueType="System.String" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>" InvalidStyle-BackColor="LightPink" Width="100%">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="semaforo_desc"></dx:ListBoxColumn>
                                        </Columns>
                                    </dx:ASPxComboBox>
                                </EditItemTemplate>
                            </dx:GridViewDataComboBoxColumn>
                            <%-- GVD_CreatedOn--%>
                            <dx:GridViewDataDateColumn FieldName="UpdatedOn" Caption="Data Modifica" VisibleIndex="4" EditFormSettings-CaptionLocation="Top" EditFormSettings-Visible="False" Width="7%">
                            </dx:GridViewDataDateColumn>
                            <%-- EditUser--%>
                            <dx:GridViewDataTextColumn FieldName="EditUser" Caption="Modificato Da" VisibleIndex="5" EditFormSettings-CaptionLocation="Top" EditFormSettings-Visible="False" Width="7%">
                            </dx:GridViewDataTextColumn>

                        </Columns>
                        <dx:EditFormLayoutProperties ColCount="2" SettingsItemCaptions-Location="Top">
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="Status" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="ID_Semaforo" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                            </Items>
                        </dx:EditFormLayoutProperties>
                    </dx:ASPxGridView>

                    <%--DataSource TASK4U_INTRANET_STAGEDUE/Semaforo_Status_Printer_ANA--%>
                    <asp:SqlDataSource ID="Semaforo_Status_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
                        SelectCommand="SELECT Semaforo_Status_ANA.* FROM Semaforo_Status_ANA"></asp:SqlDataSource>

                    <%--DataSource TASK4U_INTRANET_STAGEDUE/Status_Printer_ANA--%>
                    <asp:SqlDataSource ID="Status_Printer_Dts" runat="server"
                        ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
                        SelectCommand="SELECT Status_Printer_ANA.* FROM Status_Printer_ANA"
                        InsertCommand="INSERT INTO Status_Printer_ANA(Status, ID_Semaforo, CreatedUser) VALUES (@Status, @ID_Semaforo, @CreatedUser)"
                        UpdateCommand="UPDATE Status_Printer_ANA SET Status = @Status, ID_Semaforo = @ID_Semaforo, UpdatedOn = GETDATE(), EditUser = @EditUser WHERE (ID = @ID)"
                        DeleteCommand="DELETE FROM Status_Printer_ANA WHERE (ID = @ID)">

                        <DeleteParameters>
                            <asp:Parameter Name="ID" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Status" />
                            <asp:Parameter Name="ID_Semaforo" />
                            <asp:Parameter Name="CreatedUser" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Status" />
                            <asp:Parameter Name="ID_Semaforo" />
                            <asp:Parameter Name="EditUser" />
                            <asp:Parameter Name="ID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
