<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Alert_Scadenze.ascx.cs" Inherits="INTRA.Controls.Alert_Scadenze" %>

<style>
    .dxflCaption_Office365 {
        font-weight: bold !important;
        font-size: large !important;
        color: #808080 !important;
    }

    .material-icons {
        font-size: 26px;
    }

    .badge.BadgeTopBtn {
        margin-left: 0em;
        border-radius: 5px !important;
        font-size: large !important;
    }

    .btn:not(.btn-just-icon):not(.btn-fab) .fa, .navbar .navbar-nav > li > a.btn:not(.btn-just-icon):not(.btn-fab) .fa {
        font-size: 32px !important;
    }

    .TopBtn {
        padding: 4px !important;
    }

    .card .card-header.card-header-text {
        display: inline-block;
        padding-top: 15px !important;
    }

    .EditCaption {
        display: none !important;
    }
</style>
<script>
    function GotoNewPage(value) {
        window.location = "/CRM4U/Prospect_Client_det.aspx?Scadenza=" + value[0] + "&Cli=" + value[1];
    }
</script>
<asp:SqlDataSource ID="StatusAttivita_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="select id as StatusAttivita , descrizione from CRM4U_StatusAttivita"></asp:SqlDataSource>
<asp:SqlDataSource ID="TipoAttivita_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT id, Descrizione FROM CRM4U_TipoAttivita ORDER BY DisplayOrder"></asp:SqlDataSource>

<dx:ASPxPopupControl ID="AlertScadenze_Popup" ClientInstanceName="AlertScadenze_Popup" Modal="true" runat="server" PopupHorizontalAlign="WindowCenter" HeaderText="Scadenze" SettingsAdaptivity-Mode="OnWindowInnerWidth" ShowPageScrollbarWhenModal="true" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="CloseButton" Width="1200px">
    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowTop" MaxWidth="1600px" HorizontalAlign="WindowCenter" />
    <ContentCollection>
        <dx:PopupControlContentControl>

            <dx:ASPxGridView ID="Scadenze_Gridview" SettingsBehavior-AllowFocusedRow="true" Styles-AlternatingRow-Enabled="True" SettingsText-PopupEditFormCaption="Scadenza" ClientInstanceName="Scadenze_Gridview" DataSourceID="Scadenze_Sql" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID;IdProspect" OnDataBound="Scadenze_Gridview_DataBound">
                 <SettingsPager Position="TopAndBottom" PageSizeItemSettings-Visible="true" >
                                        <PageSizeItemSettings Items="10, 20, 50, 75, 100, 200, 500" />
                                    </SettingsPager>
                <ClientSideEvents CustomButtonClick="function(s,e){if(e.buttonID == 'ApriDettaglio')
                    { s.GetRowValues(e.visibleIndex, 'ID;IdProspect', GotoNewPage);}
                    }" />
                <Settings ShowColumnHeaders="true" ShowFilterRow="true" ShowFilterRowMenu="true" />
                <SettingsPager PageSize="5"></SettingsPager>
                <SettingsText PopupEditFormCaption="Gestione Attività" />
                <SettingsSearchPanel CustomEditorID="tbToolbarSearchScd" />
                <Toolbars>
                    <dx:GridViewToolbar>
                        <Items>
                            <dx:GridViewToolbarItem Alignment="left">
                                <Template>
                                    <dx:ASPxButtonEdit ID="tbToolbarSearchScd" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                        <Buttons>
                                            <dx:ClearButton DisplayMode="Always" Position="Right"></dx:ClearButton>
                                            <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                        </Buttons>
                                    </dx:ASPxButtonEdit>
                                </Template>
                            </dx:GridViewToolbarItem>
                            <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />

                        </Items>
                    </dx:GridViewToolbar>

                </Toolbars>
                <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="AttivitaList" />
                <SettingsCustomizationDialog Enabled="true" />
                <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="780" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1">
                    <AdaptiveDetailLayoutProperties>
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                    </AdaptiveDetailLayoutProperties>
                    <AdaptiveDetailLayoutProperties Paddings-Padding="0">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="300" />
                        <Items>
                            <dx:GridViewColumnLayoutItem ColumnName="Resp" HorizontalAlign="Left" Paddings-Padding="0" Width="100%" ShowCaption="False">
                            </dx:GridViewColumnLayoutItem>
                        </Items>
                    </AdaptiveDetailLayoutProperties>
                </SettingsAdaptivity>
                <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                <SettingsPopup>
                    <EditForm AllowResize="True" SettingsAdaptivity-Mode="Always" Modal="True" HorizontalAlign="Center" SettingsAdaptivity-HorizontalAlign="WindowCenter" VerticalAlign="Above" SettingsAdaptivity-VerticalAlign="WindowTop"></EditForm>
                </SettingsPopup>
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
                <SettingsSearchPanel Visible="True" />
                <Styles>
                    <AdaptiveHeaderPanel CssClass="adaptiveHiddenCaption"></AdaptiveHeaderPanel>
                </Styles>
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowEditButton="false" ShowNewButtonInHeader="false" ShowNewButton="false" VisibleIndex="0" ButtonRenderMode="Image" Width="5%">
                   <CustomButtons>
                        <dx:BootstrapGridViewCommandColumnCustomButton ID="ApriDettaglio" Text="Apri dettaglio" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" />
                   </CustomButtons>
                        </dx:GridViewCommandColumn>
                   
                    <dx:GridViewDataTextColumn FieldName="Denom" Caption="Cliente" VisibleIndex="2" HeaderStyle-Wrap="True">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="OggettoAttivita" VisibleIndex="3" HeaderStyle-Wrap="True">
                        <DataItemTemplate>
                            <dx:ASPxLabel runat="server" ID="OggettoLbl" CssClass="LabelClass" BackColor='<%# System.Drawing.Color.FromName(Eval("ColoreTipoAttivita").ToString()) %>' ForeColor="White" Text='<%# Eval("OggettoAttivita") %>'></dx:ASPxLabel>
                        </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="DescrAttivita" PropertiesTextEdit-EncodeHtml="false" VisibleIndex="4" HeaderStyle-Wrap="True" Settings-AllowEllipsisInText="True" MinWidth="300" CellRowSpan="2">
                        <DataItemTemplate>
                            <dx:ASPxLabel runat="server" EncodeHtml="false" ID="DescrAttivita_Lbl" Text='<%# Eval("DescrAttivita") %>' Wrap="True" AllowEllipsisInText="true" ToolTip='<%# Eval("DescrAttivita") %>' Height="100%" Width="100%"></dx:ASPxLabel>
                        </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="DataInizioAttivita" VisibleIndex="6" HeaderStyle-Wrap="True" PropertiesDateEdit-DisplayFormatString="G">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="DataFineAttivita" VisibleIndex="7" HeaderStyle-Wrap="True" PropertiesDateEdit-DisplayFormatString="G">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataComboBoxColumn FieldName="IdTipoAttivita" Caption="Attività" VisibleIndex="8" HeaderStyle-Wrap="True">
                        <PropertiesComboBox DataSourceID="TipoAttivita_Sql" ValueField="id" TextField="Descrizione"></PropertiesComboBox>
                    </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataComboBoxColumn FieldName="StatusAttivita" VisibleIndex="9" HeaderStyle-Wrap="True">
                        <PropertiesComboBox DataSourceID="StatusAttivita_Sql" ValueField="StatusAttivita" TextField="descrizione"></PropertiesComboBox>
                        <DataItemTemplate>
                            <dx:ASPxLabel runat="server" ID="StatusLbl" CssClass="LabelClass" BackColor='<%# System.Drawing.Color.FromName(Eval("ColoreStatus").ToString()) %>' ForeColor="White" Text='<%# Eval("Status") %>'></dx:ASPxLabel>
                        </DataItemTemplate>
                    </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataDateColumn FieldName="IdProspect" Caption="." Width="0" VisibleIndex="55">
                        <HeaderStyle CssClass="hidden" />
                        <CellStyle CssClass="hidden"></CellStyle>
                        <FilterCellStyle CssClass="hidden" />
                        <FooterCellStyle CssClass="hidden" />
                        <GroupFooterCellStyle CssClass="hidden" />
                    </dx:GridViewDataDateColumn>

                    <dx:GridViewDataDateColumn FieldName="ID" Caption="." Width="0" VisibleIndex="55">
                        <HeaderStyle CssClass="hidden" />
                        <CellStyle CssClass="hidden"></CellStyle>
                        <FilterCellStyle CssClass="hidden" />
                        <FooterCellStyle CssClass="hidden" />
                        <GroupFooterCellStyle CssClass="hidden" />
                    </dx:GridViewDataDateColumn>

                    <dx:GridViewDataDateColumn Name="Resp" Caption="." Width="0" VisibleIndex="40">
                        <HeaderStyle CssClass="hidden-large" />
                        <CellStyle CssClass="hidden-large"></CellStyle>
                        <FilterCellStyle CssClass="hidden-large" />
                        <FooterCellStyle CssClass="hidden-large" />
                        <GroupFooterCellStyle CssClass="hidden-large" />
                        <DataItemTemplate>
                            <div class="row">
                                <div class="col-lg-1 col-md-1 col-xs-1 col-sm-1">

                                    <a href='javascript: Scadenze_Gridview.StartEditRow(<%# Container.VisibleIndex %>)'>
                                        <dx:ASPxImage ID="edit_btn" ImageUrl="../assets/img/DevExButton/edit.png" Width="30px" runat="server">
                                        </dx:ASPxImage>
                                    </a>
                                    <br />
                                    <br />
                                    <a href='javascript:TastoNuovoResponsive(<%# Container.VisibleIndex %>)'>
                                        <dx:ASPxImage ID="ASPxImage1" ImageUrl="../assets/img/DevExButton/new.png" Width="30px" runat="server">
                                            <ClientSideEvents Click="function(s,e){Scadenze_Gridview.AddNewRow();}" />
                                        </dx:ASPxImage>
                                    </a>
                                </div>
                                <div class="col-lg-11 col-md-11 col-sm-10 col-xs-10">

                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <div style="display: inline-block">
                                            <strong style="color: darkorange"><%# Eval("DataInizioAttivita") %></strong>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <div style="display: inline-block"><strong><%#Eval("DescrTipoAttivita") %> </strong></div>
                                        <div style="display: inline-block; float: right">
                                            <strong><%#Eval("Status") %></strong>


                                        </div>
                                    </div>

                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px">
                                        <p><%# Eval("DescrAttivita") %></p>
                                    </div>

                                </div>
                            </div>


                        </DataItemTemplate>
                    </dx:GridViewDataDateColumn>
                </Columns>
                <SettingsPopup EditForm-SettingsAdaptivity-MaxWidth="1400px" EditForm-Width="1400px"></SettingsPopup>
            </dx:ASPxGridView>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

<asp:SqlDataSource ID="Scadenze_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
    SelectCommand="SELECT CRM4U_Attivita.IdProspect, CRM4U_Attivita.IdAttivita AS ID, CRM4U_Attivita.OggettoAttivita, CRM4U_Attivita.DescrAttivita, CRM4U_Attivita.LuogoAttivita, CRM4U_Attivita.RemindChkBox, CRM4U_Attivita.OraInizioAttivita, CRM4U_Attivita.OraFineAttivita, DATEDIFF(dd, 0, CRM4U_Attivita.DataInizioAttivita) + CONVERT (DATETIME, CRM4U_Attivita.OraInizioAttivita) AS DataInizioAttivita, DATEDIFF(dd, 0, CRM4U_Attivita.DataFineAttivita) + CONVERT (DATETIME, CRM4U_Attivita.OraFineAttivita) AS DataFineAttivita, CRM4U_Attivita.CRM4U_TipoAttivita, CRM4U_StatusAttivita.Descrizione AS Status, CRM4U_StatusAttivita.id AS StatusAttivita, CRM4U_TipoAttivita.id AS IdTipoAttivita, CRM4U_Prospect_Clienti.ID AS Expr1, CRM4U_Prospect_Clienti.Denom, CRM4U_Attivita.Visita, CRM4U_Prospect_Clienti.U_CodAge AS CodAge, CRM4U_Agenti.UsernameIntra AS UtenteIntranet, CRM4U_Prospect_Clienti.U_Tags, CRM4U_TipoAttivita.Descrizione AS DescrTipoAttivita, CRM4U_TipoAttivita.LabelClass AS ColoreTipoAttivita, CRM4U_StatusAttivita.LabelClass AS ColoreStatus FROM CRM4U_Prospect_Clienti INNER JOIN CRM4U_Agenti ON CRM4U_Prospect_Clienti.U_CodAge = CRM4U_Agenti.CodAge RIGHT OUTER JOIN CRM4U_Attivita ON CRM4U_Prospect_Clienti.ID = CRM4U_Attivita.IdProspect LEFT OUTER JOIN CRM4U_TipoAttivita ON CRM4U_Attivita.CRM4U_TipoAttivita = CRM4U_TipoAttivita.id LEFT OUTER JOIN CRM4U_StatusAttivita ON CRM4U_Attivita.CRM4U_StatusAttivita = CRM4U_StatusAttivita.id WHERE (CRM4U_Agenti.UsernameIntra LIKE @UtenteConnesso)  and CRM4U_TipoAttivita = 21 and CRM4U_StatusAttivita = 1 ORDER BY StatusAttivita, DataInizioAttivita">
    <SelectParameters>
        <asp:CookieParameter CookieName="FiltroUtente" DbType="String" Name="UtenteConnesso"></asp:CookieParameter>
    </SelectParameters>
</asp:SqlDataSource>
