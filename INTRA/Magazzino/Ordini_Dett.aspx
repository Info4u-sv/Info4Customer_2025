<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ordini_Dett.aspx.cs" Inherits="INTRA.Magazziniere.Ordini_Dett" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
        .DecorationLblGrid-new {
            border-radius: 7px;
            padding: 4px;
            color: White !important;
            text-transform: uppercase;
            font-size: small !important;
            font-weight: bolder !important;
            line-height: 20px;
        }

        div#MainContent_Contratto_Layout_Ord_Dett_Contratto_DXPEForm_PW-1 {
            top: -75px !important;
        }

        div#MainContent_DaFatturare_Layout_Ord_Dett_Gridview_DXPEForm_PW-1 {
            top: -75px !important;
        }

        .dxtcLite_Office365 > .dxtc-content {
            padding: 0px !important;
        }

        /*.dxdvItem_Office365, .dxdvBreakpointsItem_Office365, .dxdvFlowItem_Office365 {
            padding-left: 0px !important;
            padding-right: 0px !important;
        }*/

        .dxflGroupBoxSys {
            border-width: 1px !important;
        }

        .btn-genera {
            margin: 0px !important;
        }
    </style>
    <script>
        function InitPageControl() {
            var tab = PageControl.GetActiveTab();
        }

        function Genera(Valore) {
            GeneraBolla_Callback.PerformCallback(Valore);
        }
        function Genera_EndCallback(s, e) {
            if (GeneraBolla_Callback.cpDaEvadere != 0) {
                if (GeneraBolla_Callback.cpIdTest != null) {
                    window.location.href = "/Bolle/DettaglioBolla.aspx?IdTestata=" + GeneraBolla_Callback.cpIdTest;
                }
            }
            else {
                showNotificationErrorText("Selezionare una quantità da evadere per almeno un articolo.");
            }
        }
        var keyValueFatt;
        var daFatt;
        function Ord_Dett_Gridview_CustomButtonClick(s, e) {
            sessionStorage.setItem('griglia', s.globalName);
            sessionStorage.setItem('index', e.visibleIndex);
            s.GetRowValues(e.visibleIndex, "ID", function (value) {
                keyValueFatt = value;
            });
            daFatt = 1;
            Evadi_Popup.Show();
        }
        var keyValueContr;
        function Ord_Dett_Contratto_CustomButtonClick(s, e) {
            sessionStorage.setItem('griglia', s.globalName);
            sessionStorage.setItem('index', e.visibleIndex);
            s.GetRowValues(e.visibleIndex, "ID", function (value) {
                keyValueContr = value;
            });
            daFatt = 0;
            Evadi_Popup.Show();
        }
        function Evadi_Popup_Shown() {
            QtaDaEvadere_CallbackPnl.PerformCallback(daFatt + "|" + keyValueFatt + "|" + keyValueContr);
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
                    <div style="float: right; padding-right: 10px;">
                        <dx:BootstrapButton runat="server" Text="" ID="Torna_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
                            <Badge IconCssClass="fa fa-arrow-left" Text="" />
                            <SettingsBootstrap RenderOption="Warning" />
                            <ClientSideEvents Click="function(s,e){window.history.back();}" />
                        </dx:BootstrapButton>
                    </div>
                    <h4 class="card-title">Dettaglio Ordine</h4>
                    <dx:ASPxLoadingPanel ID="ASPxLoadingPanel1" ClientInstanceName="LoadingPanelDx" runat="server" Modal="true"></dx:ASPxLoadingPanel>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12" style="position: initial;">
                            <dx:ASPxCallback runat="server" ID="GeneraBolla_Callback" ClientInstanceName="GeneraBolla_Callback" OnCallback="GeneraBolla_Callback_Callback">
                                <ClientSideEvents EndCallback="Genera_EndCallback" />
                            </dx:ASPxCallback>
                            <dx:ASPxPageControl ClientInstanceName="PageControl" Width="100%" Height="100px" ID="PageControl"
                                runat="server" ActiveTabIndex="1" EnableViewState="False" EnableHierarchyRecreation="True" ForeColor="Black" Paddings-Padding="0px">
                                <ClientSideEvents Init="function(s, e) { InitPageControl(); }"></ClientSideEvents>

                                <TabPages>
                                    <dx:TabPage Name="page1" Text="CLIENTE">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <dx:ASPxDataView runat="server" DataSourceID="Cliente_Dts" ID="Cliente_View" ClientInstanceName="Cliente_View" Width="100%" ForeColor="Black" Paddings-PaddingLeft="0px">
                                                    <SettingsTableLayout RowsPerPage="1" />
                                                    <SettingsTableLayout ColumnCount="1" />
                                                    <ItemStyle Height="10px" />
                                                    <ItemTemplate>
                                                        <div class="col-lg-3" style="padding-left: 0px;">
                                                            <strong>Cliente:</strong>
                                                            <span style="font-size: 16px"><%# Eval("Denom") %></span>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <strong>Telefono:</strong>
                                                            <span style="font-size: 16px"><%# Eval("Tel") %></span>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <strong>CF:</strong>
                                                            <span style="font-size: 16px"><%# Eval("CF") %></span>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <strong>Email:</strong>
                                                            <span style="font-size: 16px"><%# Eval("Email") %></span>
                                                        </div>
                                                        <div class="col-lg-3" style="padding-left: 0px;">
                                                            <strong>Indirizzo:</strong>
                                                            <span style="font-size: 16px"><%# Eval("Ind") %></span>
                                                        </div>
                                                        <div class="col-lg-9">
                                                            <strong>Località:</strong>
                                                            <span style="font-size: 16px"><%# Eval("Loc") %> <%# Eval("Prov") %> <%# Eval("Cap") %> <%# Eval("DsNaz") %></span>
                                                        </div>
                                                    </ItemTemplate>
                                                </dx:ASPxDataView>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Name="page2" Text="RIEPILOGO ORDINE">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <dx:ASPxDataView runat="server" DataSourceID="Ord_Test_Dts" ID="Ord_Test_View" ClientInstanceName="Ord_Test_View" Width="100%" ForeColor="Black" Paddings-PaddingLeft="0px">
                                                    <SettingsTableLayout RowsPerPage="1" />
                                                    <SettingsTableLayout ColumnCount="1" />
                                                    <ItemStyle Height="10px" />
                                                    <ItemTemplate>
                                                        <div class="col-lg-3" style="padding-left: 0px;">
                                                            <strong>Numero Ordine:</strong>
                                                            <span style="font-size: 16px"><%# Eval("OrdNum") %></span>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <strong>Data Ordine:</strong>
                                                            <span style="font-size: 16px"><%# Convert.ToDateTime(Eval("OrdDat")).ToString("d/M/yyyy") %></span>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <strong>Stato:</strong>
                                                            <dx:ASPxLabel runat="server" CssClass="DecorationLblGrid-new" BackColor='<%# Convert.ToInt32(Eval("FlagEvaso")) == 1 ? System.Drawing.Color.DarkRed : Convert.ToInt32(Eval("FlagEvaso")) == 2 ? System.Drawing.Color.Orange : System.Drawing.Color.Green%>' Text='<%# Eval("Descrizione") %>' Font-Size="20px"></dx:ASPxLabel>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <strong>Quantità:</strong>
                                                            <span style="font-size: 16px"><%# Eval("TotQta") %></span>
                                                        </div>
                                                        <div class="col-lg-3" style="padding-left: 0px;">
                                                            <strong>Deposito:</strong>
                                                            <span style="font-size: 16px"><%# Eval("Deposito") %></span>
                                                        </div>
                                                        <div class="col-lg-9">
                                                            <strong>Indirizzo Deposito:</strong>
                                                            <span style="font-size: 16px"><%# Eval("U_I_Ind") %> <%# Eval("U_I_Loc") %> <%# Eval("U_I_Prov") %> <%# Eval("U_I_Cap") %> <%# Eval("U_I_NotePosizione") %></span>
                                                        </div>
                                                    </ItemTemplate>
                                                </dx:ASPxDataView>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                </TabPages>
                            </dx:ASPxPageControl>
                            <dx:ASPxFormLayout runat="server" ID="Contratto_Layout" ClientInstanceName="Contratto_Layout" Width="100%">
                                <Items>
                                    <dx:LayoutGroup Width="100%" Caption="Articoli Da Contratto" ColumnCount="1" GroupBoxStyle-Caption-Font-Size="Large">
                                        <Items>
                                            <dx:LayoutItem ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxGridView runat="server" ID="Ord_Dett_Contratto" ClientInstanceName="Ord_Dett_Contratto" Width="100%" AutoGenerateColumns="False" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" DataSourceID="Ord_Dett_Contratto_Dts" KeyFieldName="ID" OnRowUpdated="Ord_Dett_Contratto_RowUpdated" OnRowUpdating="Ord_Dett_Contratto_RowUpdating" OnCustomButtonInitialize="Ord_Dett_Contratto_CustomButtonInitialize">
                                                            <ClientSideEvents EndCallback="function(s,e){if(e.command=='UPDATEEDIT'){Ord_Dett_Gridview.Refresh(); Ord_Test_View.PerformCallback(); showNotification();}}" CustomButtonClick="Ord_Dett_Contratto_CustomButtonClick" />
                                                            <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                            <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
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
                                                                        <dx:GridViewToolbarItem Alignment="right">
                                                                            <Template>
                                                                                <dx:BootstrapButton runat="server" ID="Genera_DaContratto_Btn" ClientInstanceName="Genera_DaContratto_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-genera ">
                                                                                    <Badge IconCssClass="fa fa-save" Text="Genera Bolla" />
                                                                                    <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                                                                    <ClientSideEvents Click='function(s,e){ConfermaOperazioneWithClientFunction("Conferma Generazione", "Confermi di voler generare la bolla?", "Conferma", "Annulla", Genera, null, 0, null);}' />
                                                                                </dx:BootstrapButton>
                                                                            </Template>
                                                                        </dx:GridViewToolbarItem>
                                                                    </Items>
                                                                </dx:GridViewToolbar>
                                                            </Toolbars>
                                                            <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                                                            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Articoli" />
                                                            <SettingsCustomizationDialog Enabled="true" />

                                                            <Settings ShowFilterRow="True"></Settings>
                                                            <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                                                            <SettingsCommandButton>
                                                                <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                                    <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                                                </ClearFilterButton>
                                                                <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                                    <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image Edit_Contr"></Styles>
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
                                                                <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" Width="40px" ShowClearFilterButton="true">
                                                                    <CustomButtons>
                                                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="EvadiParziale" IconCssClass="icon4u icon-evadi image" CssClass="btn btn-sm btn-custom-padding action-btn evadi" />
                                                                    </CustomButtons>
                                                                </dx:GridViewCommandColumn>
                                                                <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="1" Width="150px" ReadOnly="true" EditFormSettings-ColumnSpan="2"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="UM" VisibleIndex="3" Width="50px" CellStyle-HorizontalAlign="Center" ReadOnly="true"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="QtaOrd" VisibleIndex="3" Caption="Qta" Width="60px" CellStyle-HorizontalAlign="Center">
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxSpinEdit runat="server" ID="QtaOrd_Contr" ClientInstanceName="QtaOrd_Contr" Width="100%" Value='<%# Bind("QtaOrd") %>' MinValue='<%# Convert.ToInt32(Eval("QtaEva")) %>' MaxValue="10000">
                                                                            <ValidationSettings ValidateOnLeave="false" ErrorDisplayMode="None" ValidationGroup="InsertValid">
                                                                                <RequiredField IsRequired="true" />
                                                                            </ValidationSettings>
                                                                            <InvalidStyle BackColor="LightPink" />
                                                                        </dx:ASPxSpinEdit>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="QtaEva" VisibleIndex="4" EditFormSettings-Visible="False" Width="60px" CellStyle-HorizontalAlign="Center" Caption="Evaso"></dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="QtaDaEvadere" VisibleIndex="4" EditFormSettings-Visible="False" Width="60px" CellStyle-HorizontalAlign="Center" Caption="Da Evadere" Visible="false"></dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="U_DaEvadere" VisibleIndex="4" EditFormSettings-Visible="False" Width="60px" CellStyle-HorizontalAlign="Center" Caption="Da Evadere"></dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="5" EditFormSettings-ColumnSpan="2"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2" ReadOnly="true" EditFormSettings-ColumnSpan="2"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataCheckColumn FieldName="U_DaFatturare" VisibleIndex="6" Caption="Da Fatturare" Width="100px" ReadOnly="true"></dx:GridViewDataCheckColumn>
                                                                <dx:GridViewDataCheckColumn FieldName="NRiga" VisibleIndex="6" Visible="false"></dx:GridViewDataCheckColumn>
                                                            </Columns>
                                                            <FormatConditions>
                                                                <dx:GridViewFormatConditionHighlight FieldName="QtaEva" Format="LightRedFillWithDarkRedText" Expression="[QtaEva] = 0"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="QtaEva" Format="YellowFillWithDarkYellowText" Expression="[QtaEva] > 0 AND [QtaEva] < [QtaOrd]"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="QtaEva" Format="GreenFillWithDarkGreenText" Expression="[QtaEva] >= [QtaOrd]"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="U_DaEvadere" Format="YellowFillWithDarkYellowText" Expression="[U_DaEvadere] > 0"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="U_DaEvadere" Format="Custom" Expression="[U_DaEvadere] = 0">
                                                                    <CellStyle BackColor="LightGray" ForeColor="Black" />
                                                                </dx:GridViewFormatConditionHighlight>
                                                            </FormatConditions>
                                                        </dx:ASPxGridView>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>
                            <dx:ASPxFormLayout ID="DaFatturare_Layout" runat="server" ClientInstanceName="DaFatturare_Layout" Width="100%">
                                <Items>
                                    <dx:LayoutGroup Caption="Articoli Da Fatturare" Width="100%" ColumnCount="1" GroupBoxStyle-Caption-Font-Size="Large">
                                        <Items>
                                            <dx:LayoutItem ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxGridView runat="server" ID="Ord_Dett_Gridview" ClientInstanceName="Ord_Dett_Gridview" Width="100%" AutoGenerateColumns="False" DataSourceID="Ord_Dett_Dts" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" KeyFieldName="ID" OnRowUpdated="Ord_Dett_Contratto_RowUpdated" OnRowUpdating="Ord_Dett_Gridview_RowUpdating" OnCustomButtonInitialize="Ord_Dett_Gridview_CustomButtonInitialize">
                                                            <ClientSideEvents EndCallback="function(s,e){if(e.command=='UPDATEEDIT'){Ord_Dett_Contratto.Refresh(); Ord_Test_View.PerformCallback(); showNotification();}}" CustomButtonClick="Ord_Dett_Gridview_CustomButtonClick" />
                                                            <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                            <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                                                            <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                                                            <Toolbars>
                                                                <dx:GridViewToolbar>
                                                                    <Items>
                                                                        <dx:GridViewToolbarItem Alignment="left">
                                                                            <Template>
                                                                                <dx:ASPxButtonEdit ID="tbToolbarSearch2" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                                                                    <Buttons>
                                                                                        <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                                                    </Buttons>
                                                                                </dx:ASPxButtonEdit>
                                                                            </Template>
                                                                        </dx:GridViewToolbarItem>
                                                                        <dx:GridViewToolbarItem Alignment="Right">
                                                                            <Template>
                                                                                <dx:BootstrapButton runat="server" Text="" ID="Genera_Btn" ClientInstanceName="Genera_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding btn-genera ">
                                                                                    <Badge IconCssClass="fa fa-save" Text="Genera Bolla" />
                                                                                    <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                                                                    <ClientSideEvents Click='function(s,e){ConfermaOperazioneWithClientFunction("Conferma Generazione", "Confermi di voler generare la bolla?", "Conferma", "Annulla", Genera, null, 1, null);}' />
                                                                                </dx:BootstrapButton>
                                                                            </Template>
                                                                        </dx:GridViewToolbarItem>
                                                                    </Items>
                                                                </dx:GridViewToolbar>
                                                            </Toolbars>
                                                            <SettingsSearchPanel CustomEditorID="tbToolbarSearch2" />
                                                            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Articoli" />
                                                            <SettingsCustomizationDialog Enabled="true" />

                                                            <Settings ShowFilterRow="True"></Settings>
                                                            <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                                                            <SettingsCommandButton>
                                                                <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                                    <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                                                </ClearFilterButton>
                                                                <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                                    <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image Edit_Fatt"></Styles>
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
                                                                <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" Width="40px" ShowClearFilterButton="true">
                                                                    <CustomButtons>
                                                                        <dx:BootstrapGridViewCommandColumnCustomButton ID="EvadiParzialeFatt" IconCssClass="icon4u icon-evadi image" CssClass="btn btn-sm btn-custom-padding action-btn evadi" />
                                                                    </CustomButtons>
                                                                </dx:GridViewCommandColumn>
                                                                <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="1" Width="150px" ReadOnly="true" EditFormSettings-ColumnSpan="2"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="UM" VisibleIndex="3" Width="50px" CellStyle-HorizontalAlign="Center" ReadOnly="true"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="QtaOrd" VisibleIndex="3" Caption="Qta" Width="60px" CellStyle-HorizontalAlign="Center">
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxSpinEdit runat="server" ID="QtaOrd_Fatt" ClientInstanceName="QtaOrd_Fatt" Value='<%# Bind("QtaOrd") %>' MinValue='<%# Convert.ToInt32(Eval("QtaEva")) %>'>
                                                                            <ValidationSettings ValidateOnLeave="false" ErrorDisplayMode="None" ValidationGroup="InsertValid">
                                                                                <RequiredField IsRequired="true" />
                                                                            </ValidationSettings>
                                                                            <InvalidStyle BackColor="LightPink" />
                                                                        </dx:ASPxSpinEdit>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="QtaEva" VisibleIndex="4" EditFormSettings-Visible="False" Width="60px" CellStyle-HorizontalAlign="Center" Caption="Evaso"></dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="QtaDaEvadere" VisibleIndex="4" EditFormSettings-Visible="False" Width="60px" CellStyle-HorizontalAlign="Center" Caption="Da Evadere" Visible="false"></dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="U_DaEvadere" VisibleIndex="4" EditFormSettings-Visible="False" Width="60px" CellStyle-HorizontalAlign="Center" Caption="Da Evadere"></dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="5" EditFormSettings-ColumnSpan="2"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2" ReadOnly="true" EditFormSettings-ColumnSpan="2"></dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataCheckColumn FieldName="U_DaFatturare" VisibleIndex="6" Caption="Da Fatturare" Width="100px" ReadOnly="true"></dx:GridViewDataCheckColumn>
                                                                <dx:GridViewDataCheckColumn FieldName="NRiga" VisibleIndex="6" Visible="false"></dx:GridViewDataCheckColumn>
                                                            </Columns>
                                                            <FormatConditions>
                                                                <dx:GridViewFormatConditionHighlight FieldName="QtaEva" Format="LightRedFillWithDarkRedText" Expression="[QtaEva] = 0"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="QtaEva" Format="YellowFillWithDarkYellowText" Expression="[QtaEva] > 0 AND [QtaEva] < [QtaOrd]"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="QtaEva" Format="GreenFillWithDarkGreenText" Expression="[QtaEva] >= [QtaOrd]"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="U_DaEvadere" Format="YellowFillWithDarkYellowText" Expression="[U_DaEvadere] > 0"></dx:GridViewFormatConditionHighlight>
                                                                <dx:GridViewFormatConditionHighlight FieldName="U_DaEvadere" Format="Custom" Expression="[U_DaEvadere] = 0">
                                                                    <CellStyle BackColor="LightGray" ForeColor="Black" />
                                                                </dx:GridViewFormatConditionHighlight>
                                                            </FormatConditions>
                                                        </dx:ASPxGridView>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <dx:ASPxPopupControl runat="server" ID="Evadi_Popup" ClientInstanceName="Evadi_Popup" Width="800px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" HeaderText="Evadi Parzialmente">
        <ClientSideEvents Shown="Evadi_Popup_Shown" />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <dx:ASPxCallbackPanel runat="server" ID="QtaDaEvadere_CallbackPnl" ClientInstanceName="QtaDaEvadere_CallbackPnl" OnCallback="QtaDaEvadere_CallbackPnl_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxSpinEdit runat="server" ID="QtaDaEvadere_Spin" ClientInstanceName="QtaDaEvadere_Spin" MinValue="1" MaxValue="10000" Width="100%" Caption="Quantità Da Evadere" CaptionSettings-Position="Top" CaptionStyle-ForeColor="Black">
                                <ValidationSettings ValidateOnLeave="false" ErrorDisplayMode="None" ValidationGroup="InsertQtaValid">
                                    <RequiredField IsRequired="true" />
                                </ValidationSettings>
                                <InvalidStyle BackColor="LightPink" />
                            </dx:ASPxSpinEdit>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
                <div style="float: right">
                    <dx:BootstrapButton runat="server" Text="" ID="Evadi_Btn" ClientInstanceName="Evadi_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
                        <Badge IconCssClass="fa fa-save" />
                        <SettingsBootstrap RenderOption="Success" />
                        <ClientSideEvents Click='function(s,e){if(ASPxClientEdit.ValidateGroup("InsertQtaValid")){Evadi_Callback.PerformCallback(sessionStorage.getItem("griglia")+"|"+sessionStorage.getItem("index")+"|"+QtaDaEvadere_Spin.GetText());}}' />
                    </dx:BootstrapButton>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxCallback runat="server" ID="Evadi_Callback" ClientInstanceName="Evadi_Callback" OnCallback="Evadi_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){QtaDaEvadere_Spin.SetText(''); if(!Evadi_Callback.cpError){showNotification(); Ord_Dett_Gridview.Refresh(); Ord_Dett_Contratto.Refresh(); Evadi_Popup.Hide();} else {showNotificationErrorText('La quantità da evadere deve essere minore alla quantità rimasta.');}}" />
    </dx:ASPxCallback>
    <asp:SqlDataSource runat="server" ID="Cliente_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Clienti.Denom, Clienti.Ind, Clienti.Prov, Clienti.Loc, Clienti.Tel, Clienti.PIva, Clienti.CF, Clienti.DsNaz, Clienti.Cap, Clienti.EMail FROM Clienti INNER JOIN U_I_OrdCliTest ON Clienti.CodCli = U_I_OrdCliTest.CodCli WHERE OrdNum = @OrdNum">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Ord_Test_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_I_OrdCliTest.OrdDat, U_I_OrdCliTest.FlagEvaso, U_I_OrdCliTest.CodVal, U_I_OrdCliTest.TotQta, U_I_OrdCliTest.Deposito, U_I_OrdCliTest.PrevCons, U_AnagraficaStatusOrdine.Descrizione, TabDep.U_I_NotePosizione, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, U_I_OrdCliTest.OrdNum FROM U_I_OrdCliTest LEFT OUTER JOIN TabDep ON U_I_OrdCliTest.Deposito = TabDep.CodDep LEFT OUTER JOIN U_AnagraficaStatusOrdine ON U_I_OrdCliTest.FlagEvaso = U_AnagraficaStatusOrdine.IDStatus WHERE (U_I_OrdCliTest.OrdNum = @OrdNum)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Ord_Dett_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_I_OrdCliDett.CodArt, U_I_OrdCliDett.UM, U_I_OrdCliDett.QtaOrd, U_I_OrdCliDett.QtaEva, U_I_OrdCliDett.Note, Articoli.Descrizione, U_I_OrdCliDett.ID, U_I_OrdCliDett.U_DaFatturare, CASE WHEN U_I_OrdCliDett.QtaOrd - U_I_OrdCliDett.QtaEva < 0 THEN 0 ELSE U_I_OrdCliDett.QtaOrd - U_I_OrdCliDett.QtaEva END AS QtaDaEvadere, U_I_OrdCliDett.NRiga, U_I_OrdCliDett.U_DaEvadere FROM U_I_OrdCliDett LEFT OUTER JOIN U_I_OrdCliTest ON U_I_OrdCliDett.IDTestata = U_I_OrdCliTest.ID LEFT OUTER JOIN Articoli ON U_I_OrdCliDett.CodArt = Articoli.CodArt WHERE (U_I_OrdCliTest.OrdNum = @OrdNum) AND (U_I_OrdCliDett.U_DaFatturare = 1)" UpdateCommand="UPDATE U_I_OrdCliDett SET QtaOrd = @QtaOrd, Importo = @QtaOrd * Prezzo, Note = @Note, U_DaFatturare = @U_DaFatturare WHERE (ID = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="QtaOrd"></asp:Parameter>
            <asp:Parameter Name="Note"></asp:Parameter>
            <asp:Parameter Name="U_DaFatturare"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Ord_Dett_Contratto_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT U_I_OrdCliDett.CodArt, U_I_OrdCliDett.UM, U_I_OrdCliDett.QtaOrd, U_I_OrdCliDett.QtaEva, U_I_OrdCliDett.Note, Articoli.Descrizione, U_I_OrdCliDett.ID, U_I_OrdCliDett.U_DaFatturare, CASE WHEN U_I_OrdCliDett.QtaOrd - U_I_OrdCliDett.QtaEva < 0 THEN 0 ELSE U_I_OrdCliDett.QtaOrd - U_I_OrdCliDett.QtaEva END AS QtaDaEvadere, U_I_OrdCliDett.NRiga, U_I_OrdCliDett.U_DaEvadere FROM U_I_OrdCliDett LEFT OUTER JOIN U_I_OrdCliTest ON U_I_OrdCliDett.IDTestata = U_I_OrdCliTest.ID LEFT OUTER JOIN Articoli ON U_I_OrdCliDett.CodArt = Articoli.CodArt WHERE (U_I_OrdCliTest.OrdNum = @OrdNum) AND (U_I_OrdCliDett.U_DaFatturare = 0)" UpdateCommand="UPDATE U_I_OrdCliDett SET QtaOrd = @QtaOrd, Importo = @QtaOrd * Prezzo, Note = @Note, U_DaFatturare = @U_DaFatturare WHERE (ID = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="QtaOrd"></asp:Parameter>
            <asp:Parameter Name="Note"></asp:Parameter>
            <asp:Parameter Name="U_DaFatturare"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
