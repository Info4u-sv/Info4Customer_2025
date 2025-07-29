<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Depositi_CRUD.aspx.cs" Inherits="INTRA.Depositi.Depositi_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function OnGetRowValues(value) {
            var getUrl = window.location;

            var baseUrl = getUrl.protocol + "//" + getUrl.host + "/";

            window.open(baseUrl + "Depositi/ViewDoc_Empty.aspx?CodDep=" + value, "mywindow", "menubar=1,resizable=1,width=1000,height=1000");
        }

        function OnGetRowValuesInventario(value) {
            openwindow("Depositi/Inventario_Crud.aspx?CodDep=" + value);
        }

        function OnGetRowValuesConfermaInventario(value) {
            openwindow("Depositi/Inventario_Controllo_Articoli.aspx?CodDep=" + value);
        }
    </script>
    <style>
        /*div#MainContent_Generic_Gridview_DXPEForm_PW-1 {
            top: -75px !important;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxHint ID="ASPxHintToolTipsBottoni" runat="server" TargetSelector=".dx-vam"></dx:ASPxHint>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Lista Depositi</h4>
                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Dts" KeyFieldName="CodDep" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                        <ClientSideEvents CustomButtonClick="function(s,e){
                            if(e.buttonID == 'StampaRpt'){
                                s.GetRowValues(e.visibleIndex, 'CodDep', OnGetRowValues);
                            } 
                            else if(e.buttonID == 'Vai'){
                                s.GetRowValues(e.visibleIndex, 'CodDep', OnGetRowValuesInventario);
                            } 
                            else if(e.buttonID == 'Elimina'){
                                OnGetRowValuesElimina(e.visibleIndex);
                            }
                            else if(e.buttonID == 'Inventario'){
                                s.GetRowValues(e.visibleIndex, 'CodDep', OnGetRowValuesConfermaInventario);
                            }}"
                            EndCallback="function(s,e){console.log(e.command); ASPxClientHint.Update(); if (e.command == 'UPDATEEDIT') {Generic_Gridview.Refresh();showNotification();}}" />
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                        <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>
                        <SettingsPopup>
                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                        </SettingsPopup>
                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                        <%-- <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT' || e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showNotification();}}"
                            CustomButtonClick="function(s,e){if(e.buttonID == 'Elimina'){OnGetRowValuesElimina(e.visibleIndex);}}" />--%>
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
                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True" ShowClearFilterButton="false" Width="60px" ButtonRenderMode="Image">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="Elimina" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="StampaRpt" IconCssClass="icon4u icon-print image" CssClass="btn btn-sm btn-custom-padding action-btn print" Text="Stampa" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Vai" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" Text="Vai al Dettaglio" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Inventario" IconCssClass="icon4u icon-check-square image" CssClass="btn btn-sm btn-custom-padding action-btn evadi" Text="Controlla Giacenza" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewBandColumn Caption="Deposito">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="CodDep" VisibleIndex="1" EditFormSettings-Visible="False" Width="60px" Caption="Codice"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="3" EditFormSettings-ColumnSpan="2" EditFormSettings-CaptionLocation="Top">
                                        <PropertiesTextEdit>
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn FieldName="U_I_Ind" VisibleIndex="6" Caption="Indirizzo" EditFormSettings-ColumnSpan="2" EditFormSettings-CaptionLocation="Top">
                                        <PropertiesTextEdit>
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="U_I_Prov" VisibleIndex="8" Caption="Provincia" Width="30px" EditFormSettings-CaptionLocation="Top">
                                        <PropertiesComboBox DataSourceID="Province_Dts" ValueField="Provincia" TextField="Provincia">
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesComboBox>
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_Loc" VisibleIndex="7" Caption="Città" EditFormSettings-CaptionLocation="Top">
                                        <PropertiesTextEdit>
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_Cap" VisibleIndex="9" Caption="Cap" Width="60px" EditFormSettings-CaptionLocation="Top">
                                        <PropertiesTextEdit>
                                            <MaskSettings Mask="00000" />
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="U_I_CodNaz" VisibleIndex="10" Caption="Nazione" EditFormSettings-CaptionLocation="Top">
                                        <PropertiesComboBox DataSourceID="Nazioni_Dts" ValueField="CodNaz" TextField="Descrizione">
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesComboBox>
                                    </dx:GridViewDataComboBoxColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Società">
                                <Columns>
                                    <dx:GridViewDataComboBoxColumn FieldName="CodCli" VisibleIndex="2" Caption="Cliente" EditFormSettings-ColumnSpan="2" EditFormSettings-CaptionLocation="Top">
                                        <PropertiesComboBox DataSourceID="Clienti_Dts" ValueField="CodCli" TextField="Denom" TextFormatString="{0} - {1}">
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="CodCli" Width="60px"></dx:ListBoxColumn>
                                                <dx:ListBoxColumn FieldName="Denom"></dx:ListBoxColumn>
                                            </Columns>
                                            <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesComboBox>

                                    </dx:GridViewDataComboBoxColumn>

                                    <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="4" Visible="false" EditFormSettings-ColumnSpan="2"></dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewDataTextColumn FieldName="U_I_NotePosizione" VisibleIndex="12" Caption="Note Posizione" EditFormSettings-ColumnSpan="2" Visible="false" EditFormSettings-CaptionLocation="Top">
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn FieldName="U_I_DsNaz" VisibleIndex="11" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataCheckColumn FieldName="U_Intranet" VisibleIndex="12" Caption="Da Intranet" Width="30px" Visible="false">
                                <PropertiesCheckEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesCheckEdit>
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="ControlloInventarioValido" Caption="Inventario Da Controllare" VisibleIndex="13">
                                <PropertiesCheckEdit DisplayTextChecked="Da Controllare" DisplayTextUnchecked="Non Da Controllare"></PropertiesCheckEdit>
                            </dx:GridViewDataCheckColumn>
                        </Columns>
                        <dx:EditFormLayoutProperties ColCount="2" SettingsItemCaptions-Location="Top">
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="CodCli" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="Descrizione" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="U_I_Ind" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="U_I_Loc" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="U_I_Prov" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="U_I_Cap" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:GridViewColumnLayoutItem ColumnName="U_I_CodNaz" RequiredMarkDisplayMode="Hidden" VerticalAlign="Top" />
                                <dx:EditModeCommandLayoutItem ShowCancelButton="true" ShowUpdateButton="true" HorizontalAlign="Right" />
                            </Items>
                        </dx:EditFormLayoutProperties>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Generic_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT TabDep.CodDep, TabDep.Descrizione, TabDep.CodCli, Clienti.Denom, TabDep.U_I_NotePosizione, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_I_CodNaz, TabDep.U_I_DsNaz, TabDep.U_Intranet, CASE WHEN U_UltimoControllo_Inventario >= DATEADD(DAY , - @GiorniCens , CAST(GETDATE() AS DATE)) AND U_UltimoControllo_Inventario <= CAST(GETDATE() AS DATE) THEN 0 ELSE 1 END AS ControlloInventarioValido FROM TabDep LEFT OUTER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE (TabDep.U_Intranet = 1)" InsertCommand="U_Deposito_Insert" InsertCommandType="StoredProcedure" UpdateCommand="UPDATE TabDep SET Descrizione = LEFT(@Descrizione,40), U_I_NotePosizione = @U_I_NotePosizione, U_I_Ind = @U_I_Ind, U_I_Prov = @U_I_Prov, U_I_Loc = @U_I_Loc, U_I_Cap = @U_I_Cap, U_I_CodNaz = @U_I_CodNaz, U_Intranet = @U_Intranet, U_I_DsNaz = (SELECT Descrizione FROM TabNaz WHERE (CodNaz = @U_I_CodNaz)) WHERE CodDep = @CodDep" DeleteCommand="DELETE FROM TabDep WHERE (CodDep = @CodDep)">
        <DeleteParameters>
            <asp:Parameter Name="CodDep"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CodCli" Type="String"></asp:Parameter>
            <asp:Parameter Name="U_I_Ind" Type="String"></asp:Parameter>
            <asp:Parameter Name="U_I_Prov" Type="String"></asp:Parameter>
            <asp:Parameter Name="U_I_Loc" Type="String"></asp:Parameter>
            <asp:Parameter Name="U_I_Cap" Type="String"></asp:Parameter>
            <asp:Parameter Name="U_I_CodNaz" Type="String"></asp:Parameter>
            <asp:Parameter Name="Descrizione" Type="String"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="Giorni_Cens_Session" Name="GiorniCens"></asp:SessionParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="U_I_NotePosizione"></asp:Parameter>
            <asp:Parameter Name="U_I_Ind"></asp:Parameter>
            <asp:Parameter Name="U_I_Prov"></asp:Parameter>
            <asp:Parameter Name="U_I_Loc"></asp:Parameter>
            <asp:Parameter Name="U_I_Cap"></asp:Parameter>
            <asp:Parameter Name="U_I_CodNaz"></asp:Parameter>
            <asp:Parameter Name="U_Intranet"></asp:Parameter>
            <asp:Parameter Name="CodDep"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Clienti_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT CodCli, Denom FROM Clienti"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Nazioni_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT CodNaz, Descrizione FROM TabNaz"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Province_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT Provincia FROM PRT_Province"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare il deposito selezionato?", "Conferma", "Annulla", Elimina, null, index, null);
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
