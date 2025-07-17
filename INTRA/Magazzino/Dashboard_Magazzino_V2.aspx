<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard_Magazzino_V2.aspx.cs" Inherits="INTRA.Magazzino.Dashboard_Magazzino_V2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
        .DecorationLblGrid-new {
            border-radius: 0px;
            padding: 4px;
            color: white !important;
            text-transform: uppercase;
            font-size: small !important;
            font-weight: bolder !important;
            line-height: 20px;
            vertical-align: central;
        }

        .inline-spin-edit {
            display: inline-block;
            vertical-align: central;
        }
    </style>
    <script>
        function OnGetRowValues(value) {
            Cambia_Dep_Callback.PerformCallback(value);
            Articoli_Popup.Show();
        }
        function OnGetRowValuesConfermaInventario(value) {
            openwindow("Depositi/Inventario_Controllo_Articoli.aspx?CodDep=" + value);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxHint ID="ASPxHintToolTipsBottoni" runat="server" TargetSelector=".dx-vam"></dx:ASPxHint>
    <div class="row">
        <div class="col-md-9">
            <div class="card card-stats" style="text-align: left !important;">
                <div class="card-header" data-background-color="blue">
                    <i class="fas fa-boxes" aria-hidden="true"></i>
                </div>
                <div class="card-content" style="text-align: left !important;">
                    <h4 class="card-title">Lista Depositi Con Articoli Sotto Scorta</h4>

                    <dx:ASPxCallback runat="server" ID="ShopRedirect_CallBack" ClientInstanceName="ShopRedirect_CallBack" OnCallback="ShopRedirect_CallBack_Callback" ></dx:ASPxCallback>

                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Dts" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" KeyFieldName="CodDep">
                        <ClientSideEvents CustomButtonClick="function(s,e){if(e.buttonID == 'Approvvigiona'){s.GetRowValues(e.visibleIndex,'CodDep',OnGetRowValues)} else if(e.buttonID == 'Inventario'){ s.GetRowValues(e.visibleIndex, 'CodDep', OnGetRowValuesConfermaInventario); }}" EndCallback="function(s, e) { ASPxClientHint.Update(); }" />
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
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Depositi_SottoScorta" />
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
                            <dx:GridViewCommandColumn ShowEditButton="False" VisibleIndex="0" ShowDeleteButton="False" Width="60px" ButtonRenderMode="Image">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Approvvigiona" IconCssClass="icon4u icon-plus image" CssClass="btn btn-sm btn-custom-padding action-btn plus" Text="Aggiorna Giacenza" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Inventario" IconCssClass="icon4u icon-check-square image" CssClass="btn btn-sm btn-custom-padding action-btn evadi" Text="Controlla Inventario" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewBandColumn Caption="Deposito">
                                <Columns>
                                    <%--<dx:GridViewDataTextColumn FieldName="CodDep" VisibleIndex="1" ReadOnly="True" Width="80px">
                                        <DataItemTemplate>
                                            <span class="" style="width: 100%">
                                                <a href='javascript:ShopRedirect(<%# Container.VisibleIndex%>)' style="width: 100%;">
                                                    <div class="btn btn-sm btn-info no-margin btn-padding-right-txtbox btn-success dxbs-button" style="width: 100%;">
                                                        <span class="badge BadgeBtn" style="width: 100%">
                                                            <span class="fas fa-shopping-cart image" style="float: left"></span>
                                                            <span style="float: right"><%# Eval("CodDep") %></span>
                                                        </span>                                                       
                                                    </div>
                                                </a></span>
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>--%>
                                    <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_Ind" VisibleIndex="3" Caption="Indirizzo"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_Loc" VisibleIndex="4" Caption="Città"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_Prov" VisibleIndex="5" Width="80px" Caption="Provincia"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_Cap" VisibleIndex="6" Width="80px" Caption="Cap"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="U_I_DsNaz" VisibleIndex="7" Width="100px" Caption="Nazione"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="U_UltimoControllo_Inventario" VisibleIndex="9" Width="80px" Caption="Ultimo Censimento"></dx:GridViewDataDateColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Cliente">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="2" Caption="Società"></dx:GridViewDataTextColumn>

                                </Columns>
                            </dx:GridViewBandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>


            </div>
        </div>
        <div class="col-md-3">
            <asp:Repeater ID="RepeaterTestata"
                DataSourceID="Testata_Dts"
                runat="server">
                <ItemTemplate>
                    <div class="card card-stats">
                        <div class="card-header" data-background-color="blue">
                            <i class="fas fa-box" aria-hidden="true"></i>
                        </div>
                        <div class="card-content">
                            <h4>Depositi Sotto Scorta</h4>
                            <h2><%# Eval("NumDep") %></h2>
                        </div>
                    </div>
                    <a href='javascript:openwindow("Magazzino/Lista_Ordini.aspx");'>
                        <div class="card card-stats">
                            <div class="card-header" data-background-color="blue">
                                <i class="fas fa-tasks" aria-hidden="true"></i>
                            </div>
                            <div class="card-content">
                                <h4>Ordini da Evadere</h4>
                                <h2><%# Eval("NumOrdini") %></h2>

                            </div>
                        </div>
                    </a>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <dx:ASPxPopupControl runat="server" ID="Articoli_Popup" ClientInstanceName="Articoli_Popup" Width="800px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" HeaderText="Lista Articoli">
        <ContentCollection>
            <dx:PopupControlContentControl>
                <dx:ASPxLabel runat="server" Text="Nel campo specificato, la quantità inserita viene aggiunta agli elementi presenti, non rappresenta una nuova quantità. Gli articoli verranno aggiunti senza la creazione di alcun ordine."></dx:ASPxLabel>
                <dx:ASPxGridView runat="server" ID="Articoli_Gridview" ClientInstanceName="Articoli_Gridview" DataSourceID="Articoli_Dts" Width="100%" AutoGenerateColumns="False" Styles-AlternatingRow-Enabled="True" KeyFieldName="CodArt" OnRowUpdating="Articoli_Gridview_RowUpdating">
                    <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT'){Genera_Ordine_Callback.PerformCallback(); Articoli_Popup.Hide(); Generic_Gridview.Refresh();}}" />
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
                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="List" />
                    <SettingsCustomizationDialog Enabled="true" />

                    <Settings ShowFilterRow="True"></Settings>
                    <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                    <SettingsEditing Mode="Batch" BatchEditSettings-StartEditAction="Click" BatchEditSettings-KeepChangesOnCallbacks="False"></SettingsEditing>
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
                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                    <Columns>

                        <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="0" Width="150px" Settings-ShowEditorInBatchEditMode="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Qta_Min" VisibleIndex="3" Width="80px" Settings-ShowEditorInBatchEditMode="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Giacenza" ReadOnly="True" VisibleIndex="3" Width="80px" Settings-ShowEditorInBatchEditMode="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="1" Settings-ShowEditorInBatchEditMode="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Misura" VisibleIndex="2" Width="80px" Settings-ShowEditorInBatchEditMode="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataSpinEditColumn FieldName="Qta_Eff" VisibleIndex="5" Caption="Aggiungi" Width="100px" CellStyle-BackColor="LightGray" BatchEditModifiedCellStyle-BackColor="LightGreen">
                            <PropertiesSpinEdit MinValue="0" MaxValue="10000" />
                        </dx:GridViewDataSpinEditColumn>
                    </Columns>
                    <FormatConditions>
                        <dx:GridViewFormatConditionHighlight FieldName="Giacenza" Format="LightRedFillWithDarkRedText" Expression="[Giacenza] < [Qta_Min]"></dx:GridViewFormatConditionHighlight>
                        <dx:GridViewFormatConditionHighlight FieldName="Giacenza" Format="GreenFillWithDarkGreenText" Expression="[Giacenza] >= [Qta_Min]"></dx:GridViewFormatConditionHighlight>
                    </FormatConditions>
                </dx:ASPxGridView>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxCallback runat="server" ID="Cambia_Dep_Callback" ClientInstanceName="Cambia_Dep_Callback" OnCallback="Cambia_Dep_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Articoli_Gridview.Refresh();}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback runat="server" ID="Genera_Ordine_Callback" ClientInstanceName="Genera_Ordine_Callback" OnCallback="Genera_Ordine_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Articoli_Gridview.Refresh(); showNotification();}" />
    </dx:ASPxCallback>

    <asp:SqlDataSource runat="server" ID="Testata_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT ISNULL(Depositi.NumDep, 0) AS NumDep, ISNULL(Ordini.NumOrdini, 0) AS NumOrdini FROM (SELECT COUNT(DISTINCT TabDep.CodDep) AS NumDep FROM TabDep INNER JOIN U_Inventario_Deposito ON TabDep.CodDep = U_Inventario_Deposito.CodDep INNER JOIN SaldiMag ON U_Inventario_Deposito.CodDep = SaldiMag.DsSaldo AND U_Inventario_Deposito.CodArt = SaldiMag.CodArt AND U_Inventario_Deposito.Qta_Min > SaldiMag.Carichi - SaldiMag.Scarichi) AS Depositi CROSS JOIN (SELECT COUNT(ID) AS NumOrdini FROM U_I_OrdCliTest WHERE (FlagEvaso = 1) AND (TotQta > 0)) AS Ordini"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Generic_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_I_DsNaz, TabDep.U_UltimoControllo_Inventario, TabDep.Descrizione, Clienti.Denom, TabDep.CodDep FROM TabDep INNER JOIN U_Inventario_Deposito ON TabDep.CodDep = U_Inventario_Deposito.CodDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli LEFT OUTER JOIN SaldiMag ON U_Inventario_Deposito.CodArt = SaldiMag.CodArt AND U_Inventario_Deposito.CodDep = SaldiMag.DsSaldo WHERE (SaldiMag.Carichi - SaldiMag.Scarichi - U_Inventario_Deposito.Qta_Min < 0)"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Articoli_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT DISTINCT U_Inventario_Deposito.CodArt, U_Inventario_Deposito.Qta_Min, SaldiMag.Carichi - SaldiMag.Scarichi AS Giacenza, Articoli.Descrizione, Articoli.Misura, U_Inventario_Deposito.Qta_Eff FROM Articoli INNER JOIN SaldiMag ON Articoli.CodArt = SaldiMag.CodArt RIGHT OUTER JOIN U_Inventario_Deposito ON SaldiMag.CodArt = U_Inventario_Deposito.CodArt AND SaldiMag.DsSaldo = U_Inventario_Deposito.CodDep WHERE (U_Inventario_Deposito.CodDep = @CodDep)" UpdateCommand="UPDATE U_Inventario_Deposito SET Qta_Eff = @Qta_Eff WHERE (ID = @ID)">
        <SelectParameters>
            <asp:SessionParameter SessionField="CodDep_Session" Name="CodDep"></asp:SessionParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Qta_Eff"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">

    <script>
        function ShopRedirect(index) {
            //alert(index);
            console.log("ShopRedirect called with index:", index);
            ShopRedirect_CallBack.PerformCallback(index);
        }
    </script>
</asp:Content>
