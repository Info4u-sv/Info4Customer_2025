<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Print_Gest_CRUD_Cli.aspx.cs" Inherits="INTRA.Print_Gest_Cli.Print_Gest_CRUD_Cli" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>

        function Generic_gridview_EndCallBack(s, e) {

            console.log("prova");

        }
        function OnCustomButtonClickGeneric(s, e) {
            var prelievo = "Modello;ID_Tipologia;ID";

            Articoli_Grw.GetRowValues(e.visibleIndex, prelievo, function (values) {
                Modello_Txt.SetText(values[0]);
                Tipologia_Txt.SetText(values[1]);
                ID_Printer_Txt.SetText(values[2]);
                ArticoloPopUp.Hide();
            });
        }
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
                    window.open(baseUrl + "Print_Gest_Cli/Print_Gest_Edit_Cli.aspx?ID=" + value);
                });
            }
            if (e.buttonID.includes("GoTo1")) {
                grid.GetRowValues(e.visibleIndex, 'id', GotoNewPage);
            }
            if (e.buttonID == "Edit") {
                Generic_gridview.StartEditRow(e.visibleIndex);
            }
            if (e.buttonID == "Delete") {
                ConfermaGridViewDeleteRowNoCallback('Cancella il dato!', 'Generic_gridview', e.visibleIndex);
            }
            if (e.buttonID == "Stampa") {
                s.GetRowValues(e.visibleIndex, 'ID', function (value) {
                    /*window.location.href = "/STAGEDUE/Print_Gest/ViewDoc_Empty.aspx?ID=" + value;*/
                    var getUrl = window.location;
                    var baseUrl = getUrl.protocol + "//" + getUrl.host + "/";
                    window.open(baseUrl + "Print_Gest/ViewDoc_Empty1.aspx?ID=" + value, "mywindow", "menubar=1,resizable=1,width=1000,height=1000");
                });
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
    <style>
        .dxeDisabled_Office365, .dxeDisabled_Office365 td.dxe
        {
            color: #0055A6 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">people_alt</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Printer Gestionale</h4>
                    <dx:ASPxHint ID="ASPxHint1" runat="server" TargetSelector=".dx-vam">
                        <%--  <ClientSideEvents Showing="ShowHint" />--%>
                    </dx:ASPxHint>
                    <dx:ASPxHint ID="ASPxHint2" runat="server" TargetSelector=".btn:hover" Content="">
                        <%--  <ClientSideEvents Showing="ShowHint" />--%>
                    </dx:ASPxHint>
                    <dx:ASPxGridView ID="Generic_gridview" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Generic_gridview" DataSourceID="Printer_Ordini_DTS" runat="server" Width="100%" AutoGenerateColumns="False" OnRowInserting="Generic_gridview_RowInserting" OnRowUpdating="Generic_gridview_RowUpdating" KeyFieldName="ID">

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
                        <ClientSideEvents EndCallback="function(s, e) { if(e.command == 'UPDATEEDIT') {ASPxClientHint.Update();} console.log(s)}" />
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

                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />

                        <SettingsPopup EditForm-VerticalAlign="Middle" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>

                        <SettingsPopup>

                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>

                        </SettingsPopup>


                        <%-- bottoni edit delete stampa--%>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowNewButtonInHeader="true" ShowEditButton="True" ShowDeleteButton="true" Width="80px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo" Text="Apri Dettaglio" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Stampa" Text="Stampa" IconCssClass="icon4u icon-print image" CssClass="btn btn-sm btn-custom-padding action-btn print" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Width="80px" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <%--  GVD Modello--%>
                            <dx:GridViewDataTextColumn FieldName="Modello" VisibleIndex="2" EditFormSettings-CaptionLocation="Top" ReadOnly="false">
                                <EditItemTemplate>
                                    <div style="width: 100%; display: inline-flex; gap: 10px">
                                        <dx:ASPxTextBox ID="Modello_Txt" runat="server" ClientInstanceName="Modello_Txt" Text='<%# Bind("Modello") %>' Width="90%" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>" ClientEnabled="false"></dx:ASPxTextBox>
                                        <dx:BootstrapButton runat="server" ID="CodArt_Btn" ClientInstanceName="CodArt_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-info no-margin btn-padding-right-txtbox">
                                            <Badge IconCssClass="fa fa-list" />
                                            <ClientSideEvents Click="function(s,e){ ArticoloPopUp.Show(); }" />
                                        </dx:BootstrapButton>
                                    </div>
                                </EditItemTemplate>
                                <FilterTemplate>
                                    <dx:ASPxComboBox runat="server" ID="Modello_Cb" DataSourceID="Multifunzione_ANA_DTS" ValueField="Modello" TextField="Modello" Width="100%"></dx:ASPxComboBox>
                                </FilterTemplate>
                            </dx:GridViewDataTextColumn>
                            <%--  ID_Tipologia comboBox--%>
                            <dx:GridViewDataTextColumn FieldName="Tipologia" Caption="Tipologia" VisibleIndex="3" ReadOnly="true" EditFormSettings-CaptionLocation="Top" Width="80px">
                                <EditItemTemplate>
                                    <dx:ASPxTextBox ID="Tipologia_Txt" runat="server" ClientInstanceName="Tipologia_Txt" Text='<%# Bind("ID_Tipologia") %>' Width="100%" ClientEnabled="false" />
                                </EditItemTemplate>
                                <FilterTemplate>
                                    <dx:ASPxComboBox ID="Tipologia_Cb" runat="server" DataSourceID="Tipologia_ComboB_DTS" ValueField="ID" TextField="Tipologia" Width="100%"></dx:ASPxComboBox>
                                </FilterTemplate>
                            </dx:GridViewDataTextColumn>
                            <%--  ID_Printer comboBox--%>
                            <dx:GridViewDataTextColumn FieldName="ID_Printer" Caption="ID Printer" VisibleIndex="3" Visible="true" ReadOnly="true" EditFormSettings-CaptionLocation="Top" Width="80px">
                                <EditFormSettings Visible="True" />
                                <EditItemTemplate>
                                    <dx:ASPxTextBox ID="ID_Printer_Txt" runat="server" ClientInstanceName="ID_Printer_Txt" Text='<%# Bind("ID_Printer") %>' Width="100%" ClientEnabled="false" />
                                </EditItemTemplate>
                                <FilterTemplate>
                                    <dx:ASPxComboBox runat="server" ID="Printer_Cb" DataSourceID="Multifunzione_ANA_DTS" ValueField="ID" TextField="ID" Width="100%"></dx:ASPxComboBox>
                                </FilterTemplate>
                            </dx:GridViewDataTextColumn>
                            <%-- Cod_Cliente comboBox--%>
                            <dx:GridViewDataComboBoxColumn FieldName="Cod_Cliente" Caption="Codice Cliente" VisibleIndex="4" EditFormSettings-CaptionLocation="Top">
                                <PropertiesComboBox DataSourceID="Clienti_King_DTS" ValueField="CodCli" TextField="Denom" TextFormatString="{0} | {1}">

                                    <Columns>
                                        <dx:ListBoxColumn FieldName="CodCli"></dx:ListBoxColumn>
                                        <dx:ListBoxColumn FieldName="Denom"></dx:ListBoxColumn>
                                    </Columns>
                                </PropertiesComboBox>
                                <EditItemTemplate>
                                    <dx:ASPxComboBox runat="server" ID="Clienti_King_CB" ClientInstanceName="Clienti_King_CB" DataSourceID="Clienti_King_DTS" ValueField="CodCli" TextField="Denom" Value='<%# Bind("Cod_Cliente") %>' ValueType="System.String" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>" InvalidStyle-BackColor="LightPink" TextFormatString="{0} | {1}" Width="100%">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="CodCli"></dx:ListBoxColumn>
                                            <dx:ListBoxColumn FieldName="Denom"></dx:ListBoxColumn>
                                        </Columns>
                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None"></ValidationSettings>
                                    </dx:ASPxComboBox>
                                </EditItemTemplate>
                            </dx:GridViewDataComboBoxColumn>

                            <%-- Matricola--%>
                            <dx:GridViewDataTextColumn FieldName="Matricola" VisibleIndex="5" EditFormSettings-CaptionLocation="Top" Width="80px">
                                <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" Width="100%"></PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>

                            <%-- GVD_Data_Verifica--%>
                            <dx:GridViewDataDateColumn FieldName="Data_Verifica" Caption="Data Verifica" VisibleIndex="6" EditFormSettings-CaptionLocation="Top" Width="10%">
                                <PropertiesDateEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" Width="100%"></PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>

                            <%-- Data_Prima_Installazione--%>
                            <dx:GridViewDataDateColumn FieldName="Data_Prima_Installazione" Caption="Data Prima Installazione" VisibleIndex="7" EditFormSettings-CaptionLocation="Top" Width="10%">
                                <PropertiesDateEdit ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink" Width="100%"></PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>

                            <%--  ID_Status comboBox--%>
                            <dx:GridViewDataComboBoxColumn FieldName="ID_Status" Caption="Stato" VisibleIndex="8" EditFormSettings-CaptionLocation="Top" Width="90px">
                                <PropertiesComboBox DataSourceID="Status_ComboB_DTS" ValueField="ID" TextField="Status" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ErrorDisplayMode="None" InvalidStyle-BackColor="LightPink"></PropertiesComboBox>
                                <EditItemTemplate>
                                    <dx:ASPxComboBox runat="server" ID="Status_CB" ClientInstanceName="Status_CB" DataSourceID="Status_ComboB_DTS" ValueField="ID" TextField="Status" Value='<%# Bind("ID_Status") %>' ValueType="System.Int32" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>" InvalidStyle-BackColor="LightPink" Width="100%">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="Status"></dx:ListBoxColumn>
                                        </Columns>
                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None"></ValidationSettings>
                                    </dx:ASPxComboBox>
                                </EditItemTemplate>
                            </dx:GridViewDataComboBoxColumn>
                            <%-- GVD_CreatedOn--%>
                            <dx:GridViewDataDateColumn FieldName="UpdatedOn" Caption="Data Modifica" VisibleIndex="9" EditFormSettings-CaptionLocation="Top" EditFormSettings-Visible="False" Width="7%">
                            </dx:GridViewDataDateColumn>
                            <%-- EditUser--%>
                            <dx:GridViewDataTextColumn FieldName="EditUser" Caption="Modificato Da" VisibleIndex="10" EditFormSettings-CaptionLocation="Top" EditFormSettings-Visible="False" Width="7%">
                            </dx:GridViewDataTextColumn>

                        </Columns>

                    </dx:ASPxGridView>

                    <dx:ASPxPopupControl runat="server" ID="ArticoloPopUp" ClientInstanceName="ArticoloPopUp" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" CloseAction="CloseButton" CloseOnEscape="true" Modal="True" Maximized="false" MinWidth="1400px"
                        HeaderText="Seleziona Modello" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="false">
                        <ClientSideEvents Shown="function(s,e){Articoli_Grw.ClearFilter();}" />
                        <ContentCollection>
                            <dx:PopupControlContentControl runat="server">
                                <dx:ASPxGridView runat="server" ID="Articoli_Grw" ClientInstanceName="Articoli_Grw" Width="100%" Styles-AlternatingRow-Enabled="True" AutoGenerateColumns="False" DataSourceID="Multifunzione_ANA_DTS" KeyFieldName="ID" OnRowUpdating="Articoli_Grw_RowUpdating">
                                    <Settings ShowGroupPanel="false" ShowHeaderFilterButton="false" ShowFilterRow="True" VerticalScrollBarMode="Auto" VerticalScrollableHeight="400"></Settings>
                                    <SettingsPager Mode="EndlessPaging" />
                                    <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                    <Toolbars>
                                        <dx:GridViewToolbar>
                                            <Items>
                                                <dx:GridViewToolbarItem Alignment="left">
                                                    <Template>
                                                        <dx:ASPxButtonEdit ID="tbToolbarSearchMatPrima" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
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
                                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearchMatPrima"></SettingsSearchPanel>
                                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                                    <ClientSideEvents CustomButtonClick="OnCustomButtonClickGeneric" />
                                    <SettingsCommandButton>
                                        <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                        </ClearFilterButton>
                                        <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                                        </UpdateButton>
                                        <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                                        </CancelButton>
                                        <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                                        </NewButton>
                                    </SettingsCommandButton>
                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                    <Columns>
                                        <dx:GridViewCommandColumn Caption=" " ShowClearFilterButton="true" ShowDeleteButton="false" ShowEditButton="false" ShowNewButtonInHeader="false" Width="40px">
                                            <CustomButtons>
                                                <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo1" IconCssClass="icon4u icon-check-square image" CssClass="btn btn-sm btn-custom-padding action-btn go" />
                                            </CustomButtons>
                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="Modello" Caption="Modello" VisibleIndex="1" ReadOnly="true" Visible="true" EditFormSettings-Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CodiceProdotto" Caption="Codice Prodotto" VisibleIndex="2" ReadOnly="true" Visible="true" EditFormSettings-Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Tipologia" Caption="Tipologia" VisibleIndex="3" ReadOnly="true" Visible="true" EditFormSettings-Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataSpinEditColumn FieldName="N_Colori" Caption="Numero di Colori" VisibleIndex="4" Width="80px" EditFormSettings-CaptionLocation="Top">
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataTextColumn FieldName="Nome" Caption="Brand" VisibleIndex="5" ReadOnly="true" Visible="true" EditFormSettings-Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataBinaryImageColumn FieldName="PhotoBytes" VisibleIndex="6" Caption="Immagine" EditFormSettings-Visible="False">
                                            <PropertiesBinaryImage ImageHeight="100" EnableServerResize="True">
                                            </PropertiesBinaryImage>
                                        </dx:GridViewDataBinaryImageColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                    </dx:ASPxPopupControl>

                    <%--DataSource TASK4U_INTRANET_STAGEDUE/Viste/Clienti_King_DTS--%>
                    <asp:SqlDataSource ID="Clienti_King_DTS" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Clienti_King.* FROM Clienti_King"></asp:SqlDataSource>


                    <%--DataSource TASK4U_INTRANET_STAGEDUE/Status_Printer_ANA--%>
                    <asp:SqlDataSource ID="Status_ComboB_DTS" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Status_Printer_ANA.* FROM Status_Printer_ANA"></asp:SqlDataSource>


                    <%--DataSource TASK4U_INTRANET_STAGEDUE/Tipologia_Printer_ANA--%>
                    <asp:SqlDataSource ID="Tipologia_ComboB_DTS" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT Tipologia_Printer_ANA.* FROM Tipologia_Printer_ANA"></asp:SqlDataSource>


                    <%--  DataSource TASK4U_INTRANET_STAGEDUE/Printer_ANA--%>
                    <asp:SqlDataSource ID="Printer_Ordini_DTS" runat="server"
                        ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
                        OnInserted="Printer_Ordini_DTS_Inserted"
                        SelectCommand="SELECT Printer_ANA.ID, Printer_ANA.Modello, Printer_ANA.ID_Tipologia, Printer_ANA.Cod_Cliente, Printer_ANA.Data_Verifica, Printer_ANA.ID_Status, Printer_ANA.Matricola, Printer_ANA.Data_Prima_Installazione, Printer_ANA.N_Colori, Printer_ANA.Rif_Contratto_King, Printer_ANA.N_Copie_Bn_Comprese, Printer_ANA.N_Copie_Col_Comprese, Printer_ANA.Status_Printer, Printer_ANA.Cod_Cli_Riassegno, Printer_ANA.Ubicazione_Printer, Printer_ANA.Lettura, Printer_ANA.Mese_Lettura, Printer_ANA.Vendita, Printer_ANA.Totale_Anni_Noleggio, Printer_ANA.ID_Printer, Printer_ANA.Token, Printer_ANA.CreatedUser, Printer_ANA.EditUser, Printer_ANA.CreatedOn, Printer_ANA.UpdatedOn, Tipologia_Printer_ANA.Tipologia FROM Printer_ANA INNER JOIN Tipologia_Printer_ANA ON Printer_ANA.ID_Tipologia = Tipologia_Printer_ANA.ID"
                        DeleteCommand="DELETE FROM Printer_ANA WHERE (ID = @ID)"
                        InsertCommand="INSERT INTO Printer_ANA
        (Modello, ID_Tipologia, Cod_Cliente, Data_Verifica, ID_Status, Matricola, Data_Prima_Installazione, ID_Printer, CreatedUser, EditUser, UpdatedOn)
        VALUES
        (@Modello, @ID_Tipologia, @Cod_Cliente, @Data_Verifica, @ID_Status, @Matricola, @Data_Prima_Installazione, @ID_Printer, @CreatedUser, @EditUser, GETDATE());
        SELECT CAST(SCOPE_IDENTITY() AS int);"
                        UpdateCommand="UPDATE Printer_ANA SET
        Modello = @Modello,
        ID_Tipologia = @ID_Tipologia,
        Cod_Cliente = @Cod_Cliente,
        Data_Verifica = @Data_Verifica,
        ID_Status = @ID_Status,
        Matricola = @Matricola,
        Data_Prima_Installazione = @Data_Prima_Installazione,
        EditUser = @EditUser,
        UpdatedOn = GETDATE()
        WHERE ID = @ID">

                        <DeleteParameters>
                            <asp:Parameter Name="ID" />
                        </DeleteParameters>

                        <InsertParameters>
                            <asp:Parameter Name="Modello" />
                            <asp:Parameter Name="ID_Tipologia" />
                            <asp:Parameter Name="Cod_Cliente" />
                            <asp:Parameter Name="Data_Verifica" />
                            <asp:Parameter Name="ID_Status" />
                            <asp:Parameter Name="Matricola" />
                            <asp:Parameter Name="Data_Prima_Installazione" />
                            <asp:Parameter Name="ID_Printer" />
                            <asp:Parameter Name="CreatedUser" />
                            <asp:Parameter Name="EditUser" />
                        </InsertParameters>

                        <UpdateParameters>
                            <asp:Parameter Name="Modello" />
                            <asp:Parameter Name="ID_Tipologia" />
                            <asp:Parameter Name="Cod_Cliente" />
                            <asp:Parameter Name="Data_Verifica" />
                            <asp:Parameter Name="ID_Status" />
                            <asp:Parameter Name="Matricola" />
                            <asp:Parameter Name="Data_Prima_Installazione" />
                            <asp:Parameter Name="EditUser" />
                            <asp:Parameter Name="ID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>


                    <%--  DataSource TEMPLATE_25_INTRA/Multifunzione_ANA--%>
                    <asp:SqlDataSource ID="Multifunzione_ANA_DTS" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        Multifunzione_ANA.ID, Multifunzione_ANA.Modello, Multifunzione_ANA.ID_Tipologia, Multifunzione_ANA.PhotoBytes, Multifunzione_ANA.BrandId, Multifunzione_ANA.CodiceProdotto, Multifunzione_ANA.N_Colori, 
                         Tipologia_Printer_ANA.Tipologia, Brand.Nome
FROM            Tipologia_Printer_ANA INNER JOIN
                         Multifunzione_ANA ON Tipologia_Printer_ANA.ID = Multifunzione_ANA.ID_Tipologia INNER JOIN
                         Brand ON Multifunzione_ANA.BrandId = Brand.ID"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
