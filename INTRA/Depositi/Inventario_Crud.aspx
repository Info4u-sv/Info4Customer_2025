<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inventario_Crud.aspx.cs" Inherits="INTRA.Depositi.Inventario_Crud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
        .btn_insert {
            float: right;
        }

        .hide-column-header {
            display: none;
        }

        div#MainContent_Inventario_Gridview_DXPEForm_PW-1 {
            top: -75px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <div style="float: right; padding-right: 10px;">

                        <dx:BootstrapButton runat="server" Text="" ID="Torna_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
                            <Badge IconCssClass="fa fa-arrow-left" Text="" />
                            <SettingsBootstrap RenderOption="Warning" />
                            <ClientSideEvents Click="function(s,e){openwindow('Depositi/Depositi_CRUD.aspx');}" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton runat="server" Text="" ID="Stampa_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
                            <Badge IconCssClass="fa fa-print" Text="" />
                            <SettingsBootstrap RenderOption="Success" />
                            <ClientSideEvents Click="Stampa" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton runat="server" Text="" ID="NewSpecificaBtn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
                            <Badge IconCssClass="fa fa-plus" Text="Inserisci articolo" />
                            <SettingsBootstrap RenderOption="Info" />
                            <ClientSideEvents Click="function(s,e){InsertArticolo_Popup.Show();}" />
                        </dx:BootstrapButton>
                    </div>
                    <h4 class="card-title">Inventario Deposito</h4>
                    <dx:ASPxLabel runat="server" ID="Dep_lbl" ClientInstanceName="Dep_lbl" Font-Bold="true" Font-Size="Medium"></dx:ASPxLabel>
                    <br />
                    <dx:ASPxLabel runat="server" ID="Ind_lbl" ClientInstanceName="Ind_lbl" Font-Bold="true" Font-Size="Medium"></dx:ASPxLabel>
                    <br />
                    <dx:ASPxLabel runat="server" ID="Cliente_lbl" ClientInstanceName="Cliente_lbl" Font-Bold="true" Font-Size="Medium"></dx:ASPxLabel>

                    <dx:ASPxGridView runat="server" ID="Inventario_Gridview" ClientInstanceName="Inventario_Gridview" AutoGenerateColumns="False" DataSourceID="Inventario_Dts" KeyFieldName="ID" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter"
                        EditFormLayoutProperties-RequiredMarkDisplayMode="None">
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Inventario_Gridview.Refresh(); showNotification();}}"
                            CustomButtonClick="function(s,e){if(e.buttonID == 'Elimina'){OnGetRowValuesElimina(e.visibleIndex);}}" />
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
                                    <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                </Items>
                            </dx:GridViewToolbar>
                        </Toolbars>
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Inventario" />
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
                            <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowDeleteButton="False" Width="60px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Width="80px" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodDep" VisibleIndex="2" Width="80px" ReadOnly="true" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="3" ReadOnly="true" Width="160px" EditFormSettings-ColumnSpan="2" EditFormSettings-CaptionLocation="Top"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataSpinEditColumn FieldName="Qta_Min" Caption="Scorta Minima" VisibleIndex="6" Width="80px" EditFormSettings-CaptionLocation="Top"
                                PropertiesSpinEdit-ValidationSettings-RequiredField-IsRequired="true">
                                <PropertiesSpinEdit>
                                    <ValidationSettings ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink"></ValidationSettings>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                </PropertiesSpinEdit>

                            </dx:GridViewDataSpinEditColumn>

                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="4" ReadOnly="true" EditFormSettings-ColumnSpan="2" EditFormSettings-CaptionLocation="Top"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Misura" VisibleIndex="7" EditFormSettings-Visible="False" Width="80px" CellStyle-HorizontalAlign="Center"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Categoria" VisibleIndex="5" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>

                            <dx:GridViewDataCheckColumn FieldName="DaFatturare" VisibleIndex="10" Width="150px" EditFormSettings-Visible="False">
                                <PropertiesCheckEdit>
                                    <ValidationSettings Display="None"></ValidationSettings>
                                </PropertiesCheckEdit>

                                <EditFormSettings CaptionLocation="None"></EditFormSettings>
                                <EditItemTemplate>
                                    <dx:ASPxRadioButtonList ID="DaFatturare_Edit_rBList" runat="server" Caption="Tipo" RepeatDirection="Horizontal" Width="100%" CaptionSettings-Position="Top" Value='<%#Bind("DaFatturare") %>' ValueType="System.Boolean">
                                        <Items>
                                            <dx:ListEditItem Value="False" Text="Da Contratto" />
                                            <dx:ListEditItem Value="True" Text="Da Fatturare" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </EditItemTemplate>
                            </dx:GridViewDataCheckColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>

    <dx:ASPxPopupControl runat="server" ID="InsertArticolo_Popup" ClientInstanceName="InsertArticolo_Popup" Width="800px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" HeaderText="Inserimento articolo">
        <ContentCollection>
            <dx:PopupControlContentControl>
                <dx:ASPxCallbackPanel runat="server" ID="Insert_CallbackPanel" ClientInstanceName="Insert_CallbackPanel" OnCallback="Insert_CallbackPanel_Callback">
                    <ClientSideEvents EndCallback="Insert_CallbackPanel_EndCallback" />
                    <PanelCollection>
                        <dx:PanelContent>
                            <div id="CategoriaDiv" class="col-md-4" style="padding-bottom: 10px;">
                                <dx:ASPxComboBox runat="server" ID="Categoria_Cmb" ClientInstanceName="Categoria_Cmb" DataSourceID="Categorie_Dts" ValueField="CodCat" TextField="Descrizione" Width="100%" Caption="Categoria Merceologica" CaptionSettings-Position="Top" CaptionStyle-ForeColor="Black">
                                    <ClientSideEvents SelectedIndexChanged="Categoria_Cmb_Index_Changed" />
                                </dx:ASPxComboBox>
                            </div>
                            <div class="col-md-12">
                                <dx:ASPxGridView runat="server" ID="Articoli_Gridview" ClientInstanceName="Articoli_Gridview" Styles-AlternatingRow-Enabled="True" AutoGenerateColumns="False" DataSourceID="Articoli_Dts" KeyFieldName="CodArt" Width="100%">
                                    <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
                                    <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                    <Settings ShowFilterRow="True" ShowHeaderFilterButton="True" AutoFilterCondition="Contains"></Settings>
                                    <SettingsBehavior AllowEllipsisInText="true" />
                                    <SettingsResizing ColumnResizeMode="Disabled" />
                                    <SettingsPager Mode="ShowPager" EllipsisMode="InsideNumeric" PageSize="10" ShowNumericButtons="true">
                                        <PageSizeItemSettings Visible="false" ShowAllItem="false" />
                                    </SettingsPager>
                                    <ClientSideEvents EndCallback="function(s,e){
                                        if(e.command === 'APPLYFILTER'){ ASPxClientEdit.ClearEditorsInContainer(document.getElementById('CategoriaDiv'));}
                                        }" />
                                    <Settings ShowFilterRow="True"></Settings>
                                    <Toolbars>
                                        <dx:GridViewToolbar>
                                            <Items>
                                                <dx:GridViewToolbarItem Alignment="left">
                                                    <Template>
                                                        <dx:ASPxButtonEdit ID="tbToolbarSearch_1" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                                            <Buttons>
                                                                <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                            </Buttons>
                                                        </dx:ASPxButtonEdit>
                                                    </Template>
                                                </dx:GridViewToolbarItem>
                                                <dx:GridViewToolbarItem Command="ClearFilter"></dx:GridViewToolbarItem>
                                            </Items>
                                        </dx:GridViewToolbar>

                                    </Toolbars>
                                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch_1"></SettingsSearchPanel>
                                    <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                    <SettingsBehavior AllowFocusedRow="true" />
                                    <ClientSideEvents FocusedRowChanged="function(s,e){}" />
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="CodArt" ReadOnly="True" VisibleIndex="0" Width="100px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Categoria" VisibleIndex="2"></dx:GridViewDataTextColumn>

                                    </Columns>
                                </dx:ASPxGridView>
                            </div>
                            <div class="col-md-4" style="padding-top: 10px;">
                                <dx:ASPxSpinEdit runat="server" ID="Qta_Spin" ClientInstanceName="Qta_Spin" Width="100%" Caption="Quantità Minima" CaptionSettings-Position="Top" CaptionStyle-ForeColor="Black">
                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink" RequiredField-IsRequired="true" ValidationGroup="InsertValid"></ValidationSettings>
                                    <InvalidStyle BackColor="LightPink" />
                                </dx:ASPxSpinEdit>
                            </div>
                            <div class="col-md-6" style="padding-top: 10px;">
                                <dx:ASPxRadioButtonList ID="DaFatturare_rBList" runat="server" Caption="Tipo" RepeatDirection="Horizontal" Width="100%" CaptionSettings-Position="Top">
                                    <Items>
                                        <dx:ListEditItem Value="False" Text="Da Contratto" />
                                        <dx:ListEditItem Value="True" Text="Da Fatturare" />
                                    </Items>
                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink" RequiredField-IsRequired="true" ValidationGroup="InsertValid">
                                        <RequiredField IsRequired="true" />

                                    </ValidationSettings>
                                </dx:ASPxRadioButtonList>
                            </div>
                            <div class="col-md-2" style="float: right;">
                                <dx:BootstrapButton runat="server" Text="" ID="Insert_Articolo" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn_insert">
                                    <Badge IconCssClass="fa fa-save" />
                                    <SettingsBootstrap RenderOption="success" />
                                    <ClientSideEvents Click="Insert_Articolo_Click" />
                                </dx:BootstrapButton>
                            </div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxCallback runat="server" ID="Insert_Edit_Callback" ClientInstanceName="Insert_Edit_Callback" OnCallback="Insert_Edit_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Inventario_Gridview.Refresh(); showNotification(); var container = document.getElementsByClassName('InsertArticolo_Popup')[0]; ASPxClientEdit.ClearEditorsInContainer(container); InsertArticolo_Popup.Hide();}" />
    </dx:ASPxCallback>

    <asp:SqlDataSource runat="server" ID="Inventario_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_Inventario_Deposito.ID, U_Inventario_Deposito.CodDep, U_Inventario_Deposito.CodArt, U_Inventario_Deposito.Qta_Min, Articoli.Descrizione, Articoli.Misura, TabCatM.Descrizione AS Categoria, U_Inventario_Deposito.DaFatturare FROM U_Inventario_Deposito INNER JOIN Articoli ON U_Inventario_Deposito.CodArt = Articoli.CodArt INNER JOIN TabCatM ON Articoli.CodCat = TabCatM.CodCat WHERE (U_Inventario_Deposito.CodDep = @CodDep)" DeleteCommand="DELETE FROM U_Inventario_Deposito WHERE (ID = @ID)" UpdateCommand="UPDATE U_Inventario_Deposito SET Qta_Min = @Qta_Min, DaFatturare = @DaFatturare WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="CodDep" Name="CodDep"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Qta_Min"></asp:Parameter>
            <asp:Parameter Name="DaFatturare"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Settori_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT CodSet, Descrizione FROM TabSet"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Categorie_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodCat, Descrizione FROM TabCatM"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Articoli_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Articoli.CodArt, Articoli.Descrizione, TabCatM.Descrizione AS Categoria FROM Articoli INNER JOIN TabCatM ON Articoli.CodCat = TabCatM.CodCat WHERE FlagAnnullo <> 1"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function Stampa(s, e) {
            var getUrl = window.location;
            var baseUrl = getUrl.protocol + "//" + getUrl.host + "/";
            const queryString = window.location.search;

            // Crea un nuovo oggetto URLSearchParams con la query string
            const params = new URLSearchParams(queryString);

            // Ottieni il valore del parametro specificato
            const value = params.get("CodDep");
            window.open(baseUrl + "Depositi/ViewDoc_Empty.aspx?CodDep=" + value, "mywindow", "menubar=1,resizable=1,width=1000,height=1000");
        }
        function Insert_Articolo_Click(s, e) {
            if (ASPxClientEdit.ValidateGroup('InsertValid')) {
                var index = Articoli_Gridview.GetFocusedRowIndex();
                if (index < 0) {
                    showNotificationErrorWithText('Selezionare un articolo prima di salvare');
                } else {
                    Articoli_Gridview.GetRowValues(index, "CodArt", Insert_Art_Callback);
                }
            }
        }
        function Insert_Art_Callback(value) {
            Insert_Edit_Callback.PerformCallback(value)
        }
        function Categoria_Cmb_Index_Changed(s, e) {
            Insert_CallbackPanel.PerformCallback();
        }
        function Insert_CallbackPanel_EndCallback(s, e) {
            Articoli_Gridview.Refresh();
        }
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare l'articolo selezionato?", "Conferma", "Annulla", Elimina, null, index, null);
        }
        function Elimina(Valore) {
            Inventario_Gridview.DeleteRow(Valore);
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
