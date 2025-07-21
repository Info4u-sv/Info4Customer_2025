<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ticket_List.aspx.cs" Inherits="INTRA.Ticket.Ticket_List" %>

<%@ Register Assembly="DevExpress.Data.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>

<%--Test--%>
<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <style>
        /*dxtc-content {
            display: none !important;
        }*/

        .hideHeader {
            display: none !important;
        }

        @media screen and (max-width: 880px) {
            .hidden-small {
                display: none !important;
            }

            /*.dxgvADCC {
                display: none !important;
            }*/
        }

        @media screen and (max-width: 1200px) {
            .hidden-medium {
                display: none !important;
                width: 0px !important;
            }

            /*.dxgvADCC {
                display: none !important;
            }*/
        }

        .hidecolumn {
            display: none !important;
        }

        @media screen and (min-width: 880px) {
            .hidden-large {
                display: none !important;
                width: 3px !important;
            }
            /*.dxgvADCC {
                 display: none !important;
            }*/
        }

        .ImmaginiProfili {
            width: 4.25rem;
            height: 4.25rem;
            border-radius: 50%;
            border: 2px solid #F7F9FA;
            background: #F7F9FA;
            color: #fff;
            margin-left: -0.75rem;
        }
    </style>
    <div style="width: 100%; display: inline-flex; gap: 15px">
        <dx:ASPxTabControl ID="ASPxTabControl1" runat="server" DataSourceID="StatusTicket" EnableTabScrolling="True" Theme="Office365" Width="100%" OnTabDataBound="ASPxTabControl1_TabDataBound">
            <ClientSideEvents ActiveTabChanged="function(s,e){
                                    var index = s.GetActiveTabIndex();
                                    Generic_CallbackPnl.PerformCallback(index);
                                    }" />
            <ActiveTabStyle BackColor="#333333" Font-Bold="True">
            </ActiveTabStyle>

        </dx:ASPxTabControl>
        <%--        <dx:ASPxComboBox runat="server" ID="Anno_cb" ClientInstanceName="Anno_cb" DataSourceID="AnniTck_dts" ValueField="Anno" TextField="Anno" ValueType="System.Int32" SelectedIndex="0"></dx:ASPxComboBox>--%>
    </div>
    <%--    <asp:SqlDataSource runat="server" ID="AnniTck_dts" ConnectionString='<%$ ConnectionStrings:info4superadminConnectionString %>' SelectCommand="SELECT DISTINCT YEAR(DataIns) AS Anno FROM ListaTicket_View WHERE (DataIns IS NOT NULL) ORDER BY Anno DESC"></asp:SqlDataSource>--%>
    <asp:XmlDataSource ID="StatusTicket" runat="server" DataFile="~/TicketStatus.xml" XPath="//status"></asp:XmlDataSource>


    <dx:ASPxCallbackPanel ID="Generic_CallbackPnl" ClientInstanceName="Generic_CallbackPnl" runat="server" Width="100%" OnCallback="Generic_CallbackPnl_Callback">
        <%--<SettingsLoadingPanel Enabled="false" />--%>
        <PanelCollection>
            <dx:PanelContent>
                <div style="text-align: right; margin-bottom: 10px; display: flex; justify-content: flex-end; right: 13px; top: 43px">
                    <dx:ASPxTokenBox ID="tokenAnni" runat="server"
                        Width="250px"
                        Height="40px"
                        ClientInstanceName="tokenAnni"
                        AllowCustomTokens="false"
                        SelectionMode="Multiple"
                        TokenValueType="System.Int32">
                        <ClientSideEvents ValueChanged="function(s, e) {
        var selected = s.GetValue().toString();
        Generic_CallbackPnl.PerformCallback(selected);
    }" />
                    </dx:ASPxTokenBox>
                </div>
                <dx:ASPxHint ID="ASPxHint1" runat="server" TargetSelector=".dx-ellipsis"></dx:ASPxHint>

                <dx:ASPxGridView ID="Generic_Grw" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" KeyFieldName="CodRapportino" ClientInstanceName="Generic_Grw" DataSourceID="Generic_Linq" runat="server" Width="100%" AutoGenerateColumns="False" OnDataBound="Generic_Grw_DataBound">
                    <SettingsLoadingPanel Mode="ShowAsPopup" Text="Caricamento..." />
                    <ClientSideEvents EndCallback="function(s, e) {
                                            ASPxClientHint.Update();
                                        }" />
                    <%--Aggiungere alla griglia la selezione del numero di righe visualizzate:--%>

                    <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom" Mode="EndlessPaging"></SettingsPager>
                    <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>

                    <Styles AlternatingRow-Enabled="True"></Styles>
                    <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                    <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="780" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1">
                        <AdaptiveDetailLayoutProperties>
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                        </AdaptiveDetailLayoutProperties>
                        <AdaptiveDetailLayoutProperties Paddings-Padding="0">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="300" />
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="CodRapportino_Resp" Paddings-Padding="0" Paddings-PaddingBottom="10" Width="100%" ShowCaption="False">
                                </dx:GridViewColumnLayoutItem>
                                <dx:GridViewColumnLayoutItem ColumnName="Societa_Resp" Paddings-Padding="0" Width="100%" ShowCaption="False">
                                </dx:GridViewColumnLayoutItem>
                                <dx:GridViewColumnLayoutItem ColumnName="MotivoChiamata_Resp" HorizontalAlign="Left" Paddings-Padding="0" Width="100%" ShowCaption="False">
                                </dx:GridViewColumnLayoutItem>
                                <dx:GridViewColumnLayoutItem ColumnName="InfoFooter_Resp" Paddings-Padding="0" Width="100%" ShowCaption="False">
                                </dx:GridViewColumnLayoutItem>
                            </Items>
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <Styles>
                        <AdaptiveHeaderPanel CssClass="hideHeader"></AdaptiveHeaderPanel>
                    </Styles>
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
                                <dx:GridViewToolbarItem Alignment="left">
                                    <Template>
                                        <dx:ASPxButton ID="btnClearFilters" runat="server" Text="❌ Cancella Filtro" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s, e) {
                            Generic_Grw.ClearFilter(); 
                            tbToolbarSearch.SetText('');
                        }" />
                                        </dx:ASPxButton>
                                    </Template>
                                </dx:GridViewToolbarItem>
                            </Items>
                        </dx:GridViewToolbar>

                    </Toolbars>
                    <Settings ShowFilterRow="true" ShowFilterBar="Hidden" ShowFilterRowMenu="false" ShowFilterRowMenuLikeItem="true" />
                    <SettingsBehavior FilterRowMode="OnClick" />
                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                    <Settings VerticalScrollableHeight="500" />
                    <SettingsCustomizationDialog Enabled="true" ShowSortingPage="false" ShowColumnChooserPage="false" />

                    <SettingsCommandButton>
                        <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                        </ClearFilterButton>
                        <EditButton>
                            <Image Url="../img/DevExButton/edit.png" Width="30px" ToolTip="Modifica" />
                        </EditButton>
                        <DeleteButton>
                            <Image Url="../img/DevExButton/delete.png" Width="30px" ToolTip="Elimina" />
                        </DeleteButton>
                        <UpdateButton>
                            <Image Url="../img/DevExButton/save.png" Width="30px" ToolTip="Salva" />
                        </UpdateButton>
                        <CancelButton>
                            <Image Url="../img/DevExButton/cancel.png" Width="30px" ToolTip="Annulla" />
                        </CancelButton>
                        <NewButton>
                            <Image Url="../img/DevExButton/new.png" Width="30px" ToolTip="Annulla" />
                        </NewButton>
                    </SettingsCommandButton>
                    <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="true" Width="50px" VisibleIndex="0" Visible="false"></dx:GridViewCommandColumn>
                        <dx:GridViewDataColumn FieldName="CodRapportino" Settings-FilterMode="DisplayText" Caption="Cod" VisibleIndex="0" Width="100px" SortOrder="Descending" CellStyle-HorizontalAlign="Center">
                            <Settings FilterMode="DisplayText" AutoFilterCondition="Default" />
                            <DataItemTemplate>
                                <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>' style="background-color: #333333; padding: 5px">
                                    <strong><%# Eval("CodRapportino")%></strong></a>
                            </DataItemTemplate>
                            <HeaderStyle CssClass="hidden-small" />
                            <CellStyle CssClass="hidden-small"></CellStyle>
                        </dx:GridViewDataColumn>

                        <dx:GridViewDataDateColumn FieldName="DataIns" Caption="Data Ticket" HeaderStyle-Wrap="True" Width="150px" ShowInCustomizationForm="True" VisibleIndex="1" AllowTextTruncationInAdaptiveMode="false">
                            <DataItemTemplate>
                                <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'><%# Eval("DataIns")%>   </a>
                            </DataItemTemplate>
                            <HeaderStyle Wrap="True"></HeaderStyle>

                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="InsertUser" Caption="Ins. Da" HeaderStyle-Wrap="True" Width="100px" ShowInCustomizationForm="True" VisibleIndex="1" AllowTextTruncationInAdaptiveMode="false">
                            <%-- <HeaderStyle Wrap="True"></HeaderStyle>--%>
                            <Settings FilterMode="Value" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn FieldName="Società" Width="15%" CellStyle-Font-Bold="true" Caption="Cliente" VisibleIndex="2" Settings-AllowEllipsisInText="True">
                            <Settings FilterMode="Value" AutoFilterCondition="Contains" />
                            <%--  <DataItemTemplate>
                                                   <dx:ASPxLabel ID="label" runat="server" Text='<%# Eval("Società") %>' EncodeHtml="false" OnDataBound="label_DataBound" Font-Bold="true"></dx:ASPxLabel>
                                             </DataItemTemplate>--%>
                        </dx:GridViewDataTextColumn>
                        <%--  <dx:GridViewDataTextColumn FieldName="Indirizzo" ShowInCustomizationForm="True" VisibleIndex="3" AllowTextTruncationInAdaptiveMode="false" Width="10%">
                                            <DataItemTemplate>

                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text='<%# Eval("Indirizzo") +" - "+ Eval("Cap")+" - "+Eval("Località")+ " ("+ Eval("Provincia") +")" %>' AllowEllipsisInText="true" Width="100px"></dx:ASPxLabel>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>--%>
                        <dx:GridViewDataTextColumn FieldName="MotivoChiamata" Width="15%" HeaderStyle-Wrap="True" VisibleIndex="9">
                            <Settings FilterMode="Value" AutoFilterCondition="Contains" />
                            <%--  <DataItemTemplate>
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text='<%# Eval("MotivoChiamata") %>' AllowEllipsisInText="true" AllowTextTruncationInAdaptiveMode="true" Width="200px" ></dx:ASPxLabel>
                                            </DataItemTemplate>--%>
                            <HeaderStyle Wrap="True"></HeaderStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="TCK_PrioritaRichiesta" SettingsHeaderFilter-Mode="CheckedList" PropertiesComboBox-ValueType="System.Int32" PropertiesComboBox-DataSourceID="Priorita_Dts" PropertiesComboBox-ValueField="Id" PropertiesComboBox-TextField="Descrizione" Caption="Priorità" VisibleIndex="10" AllowTextTruncationInAdaptiveMode="false" CellStyle-HorizontalAlign="Center" Width="80px">
                            <DataItemTemplate>
                                <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                    <dx:ASPxImage ID="Priorita_Image" runat="server" ImageUrl='<%# "../img/DevExButton/" + Eval("PrioritaDescr").ToString()  + ".png" %>' Width="30px" ToolTip='<%# Eval("PrioritaDescr")%>'></dx:ASPxImage>

                                </a>
                                <%--<label class='label <%# Eval("PrioritaColore")%>'><%# Eval("PrioritaDescr") %></label>--%>
                            </DataItemTemplate>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="TCK_TipoRichiesta" SettingsHeaderFilter-Mode="CheckedList" PropertiesComboBox-ValueType="System.Int32" PropertiesComboBox-DataSourceID="TipoRichiesta_Dts" PropertiesComboBox-ValueField="Id" PropertiesComboBox-TextField="Descrizione" Caption="Tipo Richiesta" HeaderStyle-Wrap="True" VisibleIndex="11">
                            <DataItemTemplate>
                                <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                    <label class='label <%# Eval("TipoChiamata").ToString().Replace(" ", "") %>'><%# Eval("TipoChiamata") %></label>
                                </a>
                            </DataItemTemplate>

                            <HeaderStyle Wrap="True"></HeaderStyle>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="TCK_AreaCompetenza" Width="8%" SettingsHeaderFilter-Mode="CheckedList" PropertiesComboBox-ValueType="System.Int32" PropertiesComboBox-ValueField="IdAreaAss" PropertiesComboBox-TextField="Descrizione" PropertiesComboBox-DataSourceID="AreaAssegnata_Dts" Caption="Area" VisibleIndex="14" AllowTextTruncationInAdaptiveMode="false">
                            <DataItemTemplate>
                                <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                    <label class='label <%# Eval("AreaAss").ToString().Replace(" ", "") %>'><%# Eval("AreaAss") %></label>
                                </a>
                            </DataItemTemplate>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="idStatus" SettingsHeaderFilter-Mode="CheckedList" PropertiesComboBox-ValueType="System.Int32" Caption="Status" PropertiesComboBox-DataSourceID="Status_Dts" PropertiesComboBox-ValueField="Id" PropertiesComboBox-TextField="Descrizione" VisibleIndex="15" AllowTextTruncationInAdaptiveMode="false">
                            <DataItemTemplate>
                                <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                    <label class='label <%# Eval("Descrizione").ToString().Replace(" ", "") %>'><%# Eval("Descrizione")%></label>
                                </a>
                            </DataItemTemplate>
                        </dx:GridViewDataComboBoxColumn>
                        <%--  <dx:GridViewDataComboBoxColumn FieldName="Tecnico" SettingsHeaderFilter-Mode="CheckedList" PropertiesComboBox-ValueType="System.String" Caption="Tecnico" PropertiesComboBox-DataSourceID="Tecnici_Dts" PropertiesComboBox-ValueField="Tecnico" PropertiesComboBox-TextField="Tecnico" VisibleIndex="15" AllowTextTruncationInAdaptiveMode="false">
                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains"  />
                               <%-- <DataItemTemplate>
                                                <%# Eval("Tecnico") %>
                                            </DataItemTemplate>--%>
                        <%--   </dx:GridViewDataComboBoxColumn>--%>

                        <dx:GridViewDataTextColumn FieldName="Tecnico" VisibleIndex="19" AllowTextTruncationInAdaptiveMode="false" SettingsHeaderFilter-Mode="CheckedList">
                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                            <%--<DataItemTemplate>
                                                <%# GetImgUtente( Eval("Tecnico") )%>
                                            </DataItemTemplate>--%>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Note" Width="15%" HeaderStyle-Wrap="True" VisibleIndex="9">
                            <Settings FilterMode="Value" AutoFilterCondition="Contains" />
                            <%--  <DataItemTemplate>
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text='<%# Eval("MotivoChiamata") %>' AllowEllipsisInText="true" AllowTextTruncationInAdaptiveMode="true" Width="200px" ></dx:ASPxLabel>
                                            </DataItemTemplate>--%>
                            <HeaderStyle Wrap="True"></HeaderStyle>
                        </dx:GridViewDataTextColumn>


                        <%-- Colonne responsive --%>
                        <dx:GridViewDataTextColumn FieldName="MotivoChiamata_Resp" HeaderStyle-Wrap="True" VisibleIndex="58" Width="0" Caption=".">
                            <Settings AllowEllipsisInText="True" />
                            <DataItemTemplate>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 no-padding">
                                        <%# Eval("MotivoChiamata") %>
                                    </div>
                                </div>
                            </DataItemTemplate>
                            <HeaderStyle CssClass="hidden-large" />
                            <CellStyle CssClass="hidden-large"></CellStyle>
                            <FilterCellStyle CssClass="hidden-large" />
                            <FooterCellStyle CssClass="hidden-large" />
                            <GroupFooterCellStyle CssClass="hidden-large" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodRapportino_Resp" Caption="." VisibleIndex="55" Width="0" SortOrder="Descending">
                            <DataItemTemplate>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 no-padding">
                                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-7 no-padding">
                                            <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                                <strong style="background-color: #333333; padding: 5px"><%# Eval("CodRapportino")%></strong> <strong>del <%# Eval("DataIns", "{0:dd/M/yyyy}")%></strong></a>
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 ">
                                            <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                                <label class='label <%# Eval("PrioritaDescr").ToString().Replace(" ", "") %>'>
                                                    <img src="../img/DevExButton/Semaforo_Trasparent.png" style="width: 19px; padding: 0" />&nbsp;&nbsp;<%# Eval("PrioritaDescr") %></label>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </DataItemTemplate>
                            <HeaderStyle CssClass="hidden-large" />
                            <CellStyle CssClass="hidden-large"></CellStyle>
                            <FilterCellStyle CssClass="hidden-large" />
                            <FooterCellStyle CssClass="hidden-large" />
                            <GroupFooterCellStyle CssClass="hidden-large" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Societa_Resp" Caption="." VisibleIndex="56" Width="0" SortOrder="Descending">
                            <DataItemTemplate>
                                <dx:ASPxPanel ID="ASPxPanel1" runat="server" SupportsDisabledAttribute="True">
                                    <PanelCollection>
                                        <dx:PanelContent>
                                            <div class="row">
                                                <div class="col-lg-12 col-md-12 no-padding">
                                                    <strong><%# Eval("Società")%></strong>
                                                </div>
                                            </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxPanel>
                            </DataItemTemplate>
                            <HeaderStyle CssClass="hidden-large" />
                            <CellStyle CssClass="hidden-large"></CellStyle>
                            <FilterCellStyle CssClass="hidden-large" />
                            <FooterCellStyle CssClass="hidden-large" />
                            <GroupFooterCellStyle CssClass="hidden-large" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="InfoFooter_Resp" Caption="." VisibleIndex="57" Width="0" SortOrder="Descending">
                            <DataItemTemplate>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-lg-8 col-md-8 col-xs-12 col-sm-12 no-padding">
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6  no-padding">
                                            <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                                <label class='label <%# Eval("AreaAss").ToString().Replace(" ", "") %>'>
                                                    <img src="../img/DevExButton/Area_Trasparent.png" style="width: 19px; padding: 0" />&nbsp;&nbsp;<%# Eval("AreaAss") %></label>
                                            </a>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 ">
                                            <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>
                                                <label class='label <%# Eval("TipoEsecDescr").ToString().Replace(" ", "") %>'>
                                                    <img src="../img/DevExButton/Tipo-Richiesta_Trasparent.png" style="width: 19px; padding: 0" />&nbsp;&nbsp;<%# Eval("TipoEsecDescr") %></label>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-xs-12 col-sm-12">
                                        <a href='Ticket_view.aspx?IdTicket=<%# Eval("CodRapportino")%>'>

                                            <%#  Eval("Tecnico") %>

                                        </a>
                                    </div>
                                </div>
                            </DataItemTemplate>
                            <HeaderStyle CssClass="hidden-large" />
                            <CellStyle CssClass="hidden-large"></CellStyle>
                            <FilterCellStyle CssClass="hidden-large" />
                            <FooterCellStyle CssClass="hidden-large" />
                            <GroupFooterCellStyle CssClass="hidden-large" />
                        </dx:GridViewDataTextColumn>

                    </Columns>
                </dx:ASPxGridView>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <asp:SqlDataSource ID="Priorita_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT [Id],[Descrizione] FROM [TCK_PrioritaRichiesta] ORDER BY [DisplayOrder]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="TipoRichiesta_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT [Id], [Descrizione] FROM [TCK_TipoRichiesta] ORDER BY [DisplayOrder]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="AreaAssegnata_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT [IdAreaAss], [Descrizione] FROM [TCK_AreaCompetenza] ORDER BY [DisplayOrder]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Status_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT [Id], [Descrizione] FROM [TCK_StatusChiamata] ORDER BY [Id]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Tecnici_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT distinct [Utente] AS Tecnico FROM [TCK_DettTecniciTicket]"></asp:SqlDataSource>


    <%--    <asp:LinqDataSource ID="Generic_Linq" runat="server" ContextTypeName="ListaTicket_LINQDataContext" TableName="ListaTicket_View" OnSelecting="Generic_Linq_Selecting"></asp:LinqDataSource>--%>
    <%--<dx:LinqServerModeDataSource ID="Generic_Linq" runat="server" OnSelecting="Generic_Linq_Selecting"></dx:LinqServerModeDataSource>--%>
    <%--    <asp:SqlDataSource ID="DtsAssegnaTecnico" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT TCK_TestataTicket.Indirizzo, TCK_TipoRichiesta.Id, TCK_TestataTicket.TipoChiamata, TCK_TipoRichiesta.Descrizione AS DescrizioneChiamata, TCK_TestataTicket.CodRapportino, TCK_TestataTicket.Società FROM TCK_TestataTicket INNER JOIN TCK_TipoRichiesta ON TCK_TestataTicket.TCK_TipoRichiesta = TCK_TipoRichiesta.Id"></asp:SqlDataSource>--%>
    <dx:LinqServerModeDataSource ID="Generic_Linq" runat="server"
        ContextTypeName="ListaTicket_LINQDataContext"
        TableName="ListaTicket_View"
        OnSelecting="Generic_Linq_Selecting" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <style>
        .label {
            font-size: 12px;
            padding: 4px 6px;
            border-radius: 2px !important;
            background-clip: padding-box !important;
            font-weight: bold;
        }

            /* Colori per tipo/area/stato */
            .label.Sistemistica,
            .label.Chiuso,
            .label.Inviato,
            .label.Intervento,
            .label.On-Site,
            .label.Standard {
                background-color: #8cc474;
            }

            .label.Gestionale,
            .label.Assegnato,
            .label.Commerciale {
                background-color: #ffce55;
            }

            .label.Sviluppo,
            .label.Inlavorazione,
            .label.ControlloPeriodico,
            .label.Telefonicamente {
                background-color: #5db2ff;
            }

            .label.OfficeAutomation {
                background-color: #ffce55;
            }

            .label.Laboratorio,
            .label.Chiusoconriserva,
            .label.Altro {
                background-color: #808080;
            }

            .label.Aperto,
            .label.NonDefinito,
            .label.Bloccante {
                background-color: #df5138;
            }

            .label.Annullato,
            .label.Recall,
            .label.Teleassistenza,
            .label.Urgente {
                background-color: #fb6e52;
            }

        .dxgvControl_Office365 a {
            color: #FF8F32;
        }

        .dxtcLite_Office365 > .dxtc-stripContainer .dxtc-activeTab a {
            color: #FF8F32;
        }

        .dxtcLite_Office365.dxtc-top > .dxtc-stripContainer .dxtc-activeTab {
            border-bottom: 3px solid #FF8F32;
            font: 14px 'Segoe UI', Helvetica, 'Droid Sans', Tahoma, Geneva, sans-serif;
            font-size: 1em;
        }
    </style>
</asp:Content>
