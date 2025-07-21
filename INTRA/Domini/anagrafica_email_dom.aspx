<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="anagrafica_email_dom.aspx.cs" Inherits="INTRA.Domini.anagrafica_email_dom" %>

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
                    <h4 class="card-title">Gestione</h4>
                    <div class="widget-body">
                        <a href="email_dom_gest.aspx?Type=1"
                            class="btn btn-success d-flex align-items-center gap-2"
                            data-bs-toggle="tooltip"
                            data-bs-placement="top"
                            title="Clicca per inserire una nuova mail">
                            <i class="fas fa-plus"></i>
                            <span>Email</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">contact_mail</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Anagrafica Email</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="GenericSqlDS" KeyFieldName="IdEmail" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                        <ClientSideEvents CustomButtonClick="function(s, e) { OnCustomButtonClick(s, e); }" />
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showNotification();}}" />
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
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
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Anagrafica_Domini_Email" />
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
                        <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowEditButton="false" ShowDeleteButton="false" VisibleIndex="0" ShowNewButtonInHeader="False" ShowClearFilterButton="true" Width="60px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="VisualizzaEmail"
                                        Text=""
                                        IconCssClass="fa fa-search"
                                        CssClass="dxbButton_VisualizzaEmail"/>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="ModificaEmail"
                                        Text=""
                                        IconCssClass="fa fa-edit"
                                        CssClass="dxbButton_ModificaEmail"/>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="EliminaEmail" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="EMail" VisibleIndex="1">
                                <DataItemTemplate>
                                    <a href="email_dom_gest.aspx?idEmail=<%# Eval("IdEmail") %>&idDom=<%# Eval("IdDominio") %>&Type=0"><%# Eval("EMail") %></a>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Telefono" VisibleIndex="2" Width="30%">
                                <DataItemTemplate>
                                    <a href="email_dom_gest.aspx?idEmail=<%# Eval("IdEmail") %>&idDom=<%# Eval("IdDominio") %>&Type=0"><%# Eval("Telefono") %></a>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="GenericSqlDS" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT STD_Email.IdEmail, STD_Email.NomeUtente, STD_Email.Nome, STD_Email.Password, STD_Email.Cognome, STD_Email.Ruolo, STD_Email.KeyId, STD_Email.KeyName, STD_Email.Telefono, STD_Email.Email, WEB_Domini.IdDominio FROM STD_Email INNER JOIN WEB_Domini ON STD_Email.KeyId = WEB_Domini.IdDominio WHERE (STD_Email.KeyName = @KeyName) ORDER BY STD_Email.IdEmail">
        <SelectParameters>
            <asp:Parameter DefaultValue="dominio" Name="KeyName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsDelete" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT IdEmail FROM STD_Email WHERE (IdEmail = @IdEmail)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IdEmail" QueryStringField="IdEmail" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script type="text/javascript">
        function OnCustomButtonClick(grid, e) {
            var index = e.visibleIndex;
            var key = grid.GetRowKey(index);

            if (e.buttonID === "EliminaEmail") {
                OnGetRowValuesElimina(index);
            }
            else if (e.buttonID === "VisualizzaEmail" || e.buttonID === "ModificaEmail") {
                grid.GetRowValues(index, 'IdDominio', function (idDom) {
                    let type = e.buttonID === "VisualizzaEmail" ? 0 : 2;
                    window.location.href = `email_dom_gest.aspx?idEmail=${key}&idDom=${idDom}&Type=${type}`;
                });
            }
        }
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction(
                "Conferma Cancellazione",
                "Confermi di voler eliminare la mail selezionata?",
                "Conferma",
                "Annulla",
                Elimina,
                null,
                index,
                null
            );
        }

        function Elimina(index) {
            Generic_Gridview.DeleteRow(index);
        }
        function ConfermaOperazioneWithClientFunction(Title, Testo, BtnConfirmTxt, BtnCancelTxt, Function, FunctionCancel = null, FunctionParam = null, FunctionCancelParam = null) {
            Swal.fire({
                title: Title,
                text: Testo,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: BtnConfirmTxt,
                cancelButtonText: BtnCancelTxt,
                customClass: {
                    confirmButton: 'btn btn-success',
                    cancelButton: 'btn btn-danger'
                },
                buttonsStyling: false
            }).then((result) => {
                if (result.isConfirmed) {
                    if (FunctionParam != null) Function(FunctionParam);
                    else Function();
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    if (FunctionCancel) {
                        if (FunctionCancelParam != null) FunctionCancel(FunctionCancelParam);
                        else FunctionCancel();
                    }
                }
            });
        }
    </script>
    <style>
        .dxbButton_VisualizzaEmail {
        background-color: #0055A6 !important; /* Azzurro */
        color: white !important;
        border-radius: 6px;
        padding: 6px 10px;
    }

    .dxbButton_ModificaEmail {
        background-color: #FB8C00 !important; /* Arancione */
        color: white !important;
        border-radius: 6px;
        padding: 6px 10px;
    }
    </style>
</asp:Content>
