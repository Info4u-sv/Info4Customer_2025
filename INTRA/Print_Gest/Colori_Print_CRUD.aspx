<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Colori_Print_CRUD.aspx.cs" Inherits="INTRA.Print_Gest.Colori_Print_CRUD" %>

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
                    <h4 class="card-title">Lista Colori Print</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Colori_Dts" KeyFieldName="ID" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" OnRowInserting="Generic_Gridview_RowInserting" OnRowUpdating="Generic_Gridview_RowUpdating">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>

                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showNotification();}}"
                            CustomButtonClick="function(s,e){if(e.buttonID == 'Elimina'){OnGetRowValuesElimina(e.visibleIndex);}}" />
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
                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="True" ShowClearFilterButton="false" Width="60px">
                                <%--                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="StampaRpt" IconCssClass="icon4u icon-print image" CssClass="btn btn-sm btn-custom-padding action-btn print" Text="" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Vai" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" Text="" />
                                </CustomButtons>--%>
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                        </Columns>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" EditFormSettings-Visible="False" Width="80px" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataSpinEditColumn FieldName="DisplayOrder" VisibleIndex="2" Width="80px" EditFormSettings-CaptionLocation="Top">
                                <PropertiesSpinEdit MinValue="1" MaxValue="10000">
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="False"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesSpinEdit>
                            </dx:GridViewDataSpinEditColumn>
                            <dx:GridViewDataColumn FieldName="HexColor" Caption="Colore" VisibleIndex="2" EditFormSettings-CaptionLocation="Top">
                                <DataItemTemplate>
                                    <%# GetColorBox(Eval("HexColor")) %>
                                </DataItemTemplate>
                                <EditItemTemplate>
                                    <dx:ASPxColorEdit ID="ColorIconBackColorEdit" runat="server"
                                        Width="100%" EnableCustomColors="true"
                                        ClearButton-DisplayMode="Always"
                                        Color='<%# ConvertHexToColor(Eval("HexColor")) %>' />
                                </EditItemTemplate>
                            </dx:GridViewDataColumn>
                        </Columns>
                        <dx:EditFormLayoutProperties ColCount="2" SettingsItemCaptions-Location="Top">
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="Descrizione" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="DisplayOrder" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="HexColor" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                            </Items>
                        </dx:EditFormLayoutProperties>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Colori_Dts"
        ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
        SelectCommand="SELECT Colori_Print.* FROM Colori_Print"
        InsertCommand="INSERT INTO Colori_Print(Descrizione, DisplayOrder, HexColor, CreatedUser) VALUES (@Descrizione, @DisplayOrder, @HexColor, @CreatedUser)"
        UpdateCommand="UPDATE Colori_Print SET Descrizione = @Descrizione, DisplayOrder = @DisplayOrder, HexColor = @HexColor, UpdatedOn = GETDATE(), EditUser = @EditUser  WHERE (ID = @ID)"
        DeleteCommand="DELETE FROM Colori_Print WHERE (ID = @ID)">

        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>

        <InsertParameters>
            <asp:Parameter Name="Descrizione" />
            <asp:Parameter Name="DisplayOrder" />
            <asp:Parameter Name="HexColor" />
            <asp:Parameter Name="CreatedUser" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="Descrizione" />
            <asp:Parameter Name="DisplayOrder" />
            <asp:Parameter Name="HexColor" />
            <asp:Parameter Name="EditUser" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare il colore selezionato?", "Conferma", "Annulla", Elimina, null, index, null);
        }
        function Elimina(Valore) {
            Generic_Gridview.DeleteRow(Valore);
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

                buttonsStyling: false,

                cancelButtonText: BtnCancelTxt,

            }).then(function (isConfirm) {

                if (isConfirm) {

                    if (FunctionParam != null) {

                        Function(FunctionParam);

                    } else {

                        Function();

                    }

                }



            }).catch(function () {

                console.log("Test");

                if (FunctionCancelParam != null) {

                    FunctionCancel(FunctionCancelParam);

                } else {

                    FunctionCancel();

                }

            });

        }
    </script>
</asp:Content>
