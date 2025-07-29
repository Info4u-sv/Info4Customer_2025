<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="anagrafica_domini.aspx.cs" Inherits="INTRA.Domini.anagrafica_domini" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var command = "";
        function OnBeginCallback(s, e) {
            command = e.command;
        }

        function OnEndCallback(s, e) {
            if (command == 'DELETEROW') {
                showNotification();
            }
            if (command == "UPDATEEDIT") {
                showNotification();
            }
        }
    </script>

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">language</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Anagrafica Domini</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Linq" KeyFieldName="IdDominio" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" OnRowInserting="Generic_Gridview_RowInserting" OnRowUpdating="Generic_Gridview_RowUpdating" OnCellEditorInitialize="Generic_Gridview_CellEditorInitialize">
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showNotification();}}" />
                        <ClientSideEvents
                            CustomButtonClick="function(s,e){
        if (e.buttonID === 'EliminaDominio') {
            ConfermaOperazioneWithClientFunction(
                'Conferma Eliminazione',
                'Sei sicuro di voler eliminare il dominio selezionato?',
                'Conferma',
                'Annulla',
                EliminaDominio,
                null,
                e.visibleIndex,
                null
            );
        } else if (e.buttonID === 'Dettaglio') {
            VisualizzaDettaglio_Callback.PerformCallback(e.visibleIndex);
        }
    }" />
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
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
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Anagrafica_Domini" />
                        <SettingsCustomizationDialog Enabled="true" />

                        <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                        <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="780" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1"></SettingsAdaptivity>

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
                        <SettingsEditing Mode="PopupEditForm" />

                        <EditFormLayoutProperties ColCount="1" SettingsItemCaptions-Location="Top">
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="URL" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="DataAttivazione" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="DataScadenza" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="Provider" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                            </Items>
                        </EditFormLayoutProperties>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="True" ShowClearFilterButton="false" Width="60px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton
                                        ID="EliminaDominio"
                                        IconCssClass="icon4u icon-delete image"
                                        CssClass="btn btn-sm btn-custom-padding action-btn delete"
                                        Text="" />

                                    <dx:BootstrapGridViewCommandColumnCustomButton
                                        ID="Dettaglio"
                                        IconCssClass="fa fa-info-circle" CssClass="btn btn-sm btn-custom-padding action-btn detail"
                                        Text="" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                        </Columns>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdDominio" Visible="false" VisibleIndex="0" ReadOnly="true">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="URL" VisibleIndex="2">
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                                <DataItemTemplate>
                                    <a href="domini_gest.aspx?idDom=<%# Eval("IdDominio") %>&keyName=dominio"><%# Eval("URL")%></a>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="DataAttivazione" VisibleIndex="3" Width="5%">
                                <PropertiesDateEdit>
                                    <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="La Data di Attivazione è obbligatoria." />
                                </PropertiesDateEdit>
                                <DataItemTemplate>
                                    <a href='domini_gest.aspx?idDom=<%# Eval("IdDominio") %>&keyName=dominio'>
                                        <%# Eval("DataAttivazione", "{0:dd/MM/yyyy}") %>
                                    </a>
                                </DataItemTemplate>
                                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormatString="dd/MM/yyyy" EditFormat="Custom" />
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="DataScadenza" VisibleIndex="4" Width="5%">
                                <PropertiesDateEdit>
                                    <ValidationSettings RequiredField-IsRequired="true" RequiredField-ErrorText="La Data di Scadenza è obbligatoria." />
                                </PropertiesDateEdit>
                                <DataItemTemplate>
                                    <a href='domini_gest.aspx?idDom=<%# Eval("IdDominio") %>&keyName=dominio'>
                                        <%# Eval("DataScadenza", "{0:dd/MM/yyyy}") %>
                                    </a>
                                </DataItemTemplate>
                                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormatString="dd/MM/yyyy" EditFormat="Custom" />
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="Provider" VisibleIndex="5">
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                                <DataItemTemplate>
                                    <a href="domini_gest.aspx?idDom=<%# Eval("IdDominio") %>&keyName=dominio"><%# Eval("Provider")%></a>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <%--                        <dx:EditFormLayoutProperties ColCount="2" SettingsItemCaptions-Location="Top">
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="URL" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="DataAttivazione" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="DataScadenza" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="Provider" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                            </Items>
                        </dx:EditFormLayoutProperties>--%>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxCallback ID="VisualizzaDettaglio_Callback" ClientInstanceName="VisualizzaDettaglio_Callback" runat="server" OnCallback="VisualizzaDettaglio_Callback_Callback">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="EliminaDominio_Callback" ClientInstanceName="EliminaDominio_Callback" runat="server" OnCallback="EliminaDominio_Callback_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){Generic_Gridview.Refresh(); showNotification();}" />
    </dx:ASPxCallback>
    <asp:SqlDataSource ID="Generic_Linq" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' DeleteCommand="select 1 where 1=2" InsertCommand="select 1 where 1=2" SelectCommand="SELECT Provider, DataScadenza, DataAttivazione, URL, IdDominio FROM WEB_Domini" UpdateCommand="select 1 where 1=2"></asp:SqlDataSource>
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
        function EliminaDominio(index) {
            EliminaDominio_Callback.PerformCallback(index);
        }
    </script>
    <style>
        .btn-custom-padding.action-btn.detail {
            background-color: #0055A6;
            color: white;
            border-radius: 4px;
            font-size: 10px !important;
            padding: 2px 6px !important;
            width: 28px;
            height: 28px;
        }

            .btn-custom-padding.action-btn.detail .fa-info-circle {
                font-size: 5px;
            }
    </style>
</asp:Content>
