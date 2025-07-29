<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Articoli_DaFatt_Gest.aspx.cs" Inherits="INTRA.Magazzino.Articoli_DaFatt_Gest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
   /*     div#MainContent_Articoli_DaFatt_Grw_DXPEForm_PW-1 {
            top: -75px !important;
        }*/
    </style>
    <script>
        function Articoli_DaFatt_Grw_CustomButtonClick(s, e) {
            if (e.buttonID === "Elimina") {
                ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler cancellare l\'articolo selezionato?", "Conferma", "Annulla", function () {
                    s.DeleteRow(e.visibleIndex);
                    showNotification();
                }, null, 0, null);
            }
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
                    <h4 class="card-title">Lista Articoli Da Fatturare</h4>
                    <dx:ASPxGridView runat="server" ID="Articoli_DaFatt_Grw" ClientInstanceName="Articoli_DaFatt_Grw" Width="100%" AutoGenerateColumns="False" DataSourceID="Articoli_DaFatt_Dts" KeyFieldName="ID" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter">
                        <ClientSideEvents CustomButtonClick='Articoli_DaFatt_Grw_CustomButtonClick' />
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                        <SettingsPopup>
                            <EditForm Modal="true" AllowResize="True"
                                AutoUpdatePosition="True"
                                VerticalAlign="WindowCenter"
                                HorizontalAlign="WindowCenter" />
                        </SettingsPopup>
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
                        <SettingsEditing EditFormColumnCount="1" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowNewButtonInHeader="True" VisibleIndex="0" ShowDeleteButton="False" Width="40px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" CssClass="btn btn-sm btn-custom-padding action-btn delete" IconCssClass="icon4u icon-delete image" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" Visible="false" VisibleIndex="1" Width="60px">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataComboBoxColumn FieldName="Settore" VisibleIndex="2">
                                <PropertiesComboBox DataSourceID="Settore_Dts" ValueField="CodSet">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="CodSet" Width="30%"></dx:ListBoxColumn>
                                        <dx:ListBoxColumn FieldName="Descrizione"></dx:ListBoxColumn>
                                    </Columns>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="InsertValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataComboBoxColumn FieldName="CatMerc" VisibleIndex="3">
                                <PropertiesComboBox DataSourceID="CatMerc_Dts" ValueField="CodCat">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="CodCat" Width="30%"></dx:ListBoxColumn>
                                        <dx:ListBoxColumn FieldName="Descrizione"></dx:ListBoxColumn>
                                    </Columns>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="InsertValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource runat="server" ID="Settore_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodSet, Descrizione FROM TabSet"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="CatMerc_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodCat, Descrizione FROM TabCatM"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Articoli_DaFatt_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT ID, CatMerc, Settore FROM U_Articoli_DaFatt" DeleteCommand="DELETE FROM U_Articoli_DaFatt WHERE (ID = @ID)" InsertCommand="INSERT INTO U_Articoli_DaFatt(CatMerc, Settore) VALUES (@CatMerc, @Settore)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CatMerc"></asp:Parameter>
            <asp:Parameter Name="Settore"></asp:Parameter>
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
