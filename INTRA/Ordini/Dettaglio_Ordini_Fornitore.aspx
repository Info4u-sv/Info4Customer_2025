<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dettaglio_Ordini_Fornitore.aspx.cs" Inherits="INTRA.Ordini.Dettaglio_Ordini_Fornitore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
        .dxflGroupBox_Office365 {
            border-width: 1px !important;
        }

        .dxeEditArea_Office365.dxeDisabled_Office365 {
            color: #0055A6 !important;
        }

        .dxFirefox .dxeMemo_Office365 .dxeMemoEditArea_Office365.dxeDisabled_Office365, .dxeMemo_Office365 .dxeMemoEditArea_Office365.dxeDisabled_Office365 {
            color: #0055A6 !important;
        }
    </style>
    <script>
        function ReturnClick(s, e) {
            window.location.href = "/Default.aspx";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header card-header-icon" data-background-color="blue">
                <i class="fa fa-list"></i>
            </div>
            <div style="float: right; margin-right: 30px;">
                <%--<dx:BootstrapButton runat="server" ID="Stampa_btn" ClientInstanceName="Stampa_btn" ClientVisible="true" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-md position" rel="tooltip" data-placement="top" data-original-title="Stampa Documento" UseSubmitBehavior="false">
                    <Badge IconCssClass="fa fa-file-pdf" />
                    <SettingsBootstrap RenderOption="Default" Sizing="Normal" />
                    <ClientSideEvents Click="function(s,e){var OrdNum = (new URL(location.href)).searchParams.get('OrdNum'); openwindow('/Ordini/Dettaglio_Ordini_Fornitore.aspx?Tipo=B&OrdNum='+OrdNum);}" />
                </dx:BootstrapButton>--%>
                <dx:BootstrapButton runat="server" ID="Return_btn" ClientInstanceName="Return_btn" ClientVisible="true" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-md position" UseSubmitBehavior="false">
                    <Badge IconCssClass="fa fa-backward" />
                    <SettingsBootstrap RenderOption="Info" Sizing="Normal" />
                    <ClientSideEvents Click="ReturnClick" />
                </dx:BootstrapButton>
            </div>
            <div style="padding-top: 10px!important">
                <dx:ASPxLabel ID="CategoriaDiVisualizzazione_Lbl" ClientInstanceName="CategoriaDiVisualizzazione_Lbl" runat="server" Font-Size="X-Large" Text="Dettaglio Ordine A Fornitore"></dx:ASPxLabel>
            </div>
            <div class="card-content">
                <dx:ASPxFormLayout runat="server" ID="TestataOrdine_FormView" ClientInstanceName="TestataOrdine_FormView" Enabled="false" ColumnCount="4" Width="100%" ColCount="4" DataSourceID="TestataOrdine_dts">
                    <Items>
                        <dx:LayoutGroup Caption="Testata" AlignItemCaptions="true" ColumnCount="4" ColumnSpan="1" SettingsItemHelpTexts-Position="bottom" GroupBoxStyle-Caption-Font-Size="Larger" Paddings-Padding="0" SettingsItemCaptions-ChangeCaptionLocationInAdaptiveMode="True">
                            <Items>
                                <dx:LayoutItem FieldName="CodDoc" ColSpan="1" Caption="Codice">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="TestataOrdine_FormView_E4"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="ProtocolloDoc" ColSpan="1" Caption="Protocollo">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="TestataOrdine_FormView_E5"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="OrdNum" ColSpan="1" Caption="Numero Ordine">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="TestataOrdine_FormView_E1"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="OrdDat" ColSpan="1" Caption="Data">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit runat="server" Width="100%" ID="TestataOrdine_FormView_E2"></dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="CodFor" ColSpan="1" Caption="Fornitore">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="TestataOrdine_FormView_E3"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="PrevCons" ColSpan="1" Caption="Prevista Consegna">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit runat="server" ID="TestataOrdine_FormView_E6" Width="100%"></dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="CodPag" ColSpan="1" Caption="Cod. Pagamento">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="TestataOrdine_FormView_E7"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="Descrizione_Pag" ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="TestataOrdine_FormView_E8"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="CodNaz" ColSpan="1" ClientVisible="false">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="TestataOrdine_FormView_E9"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>

                <dx:ASPxPageControl ID="DettaglioOrdine_Tabs" ClientInstanceName="DettaglioOrdine_Tabs" Width="100%" Height="100px" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True" ActiveTabStyle-Border-BorderColor="#076ab1" ActiveTabStyle-ForeColor="#076ab1">
                    <TabPages>
                        <dx:TabPage Text="Fornitore">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <div class="row">
                                        <dx:ASPxFormLayout runat="server" Enabled="false" ID="Visual_Client_Info" Width="100%" ColumnCount="5" ClientInstanceName="Visual_Client_Info" ColCount="5" DataSourceID="CLientInfo_Dts">
                                            <Items>
                                                <dx:LayoutItem FieldName="Denom" ColSpan="4" Caption="Nome">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="1220px" ID="Visual_Client_Info_E1"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Tel" ColSpan="1" Caption="Telefono">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="300px" ID="Visual_Client_Info_E5"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Ind" ColSpan="5" Width="100%" Caption="Indirizzo">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Visual_Client_Info_E2"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Cap" ColSpan="1" Width="250px" Caption="Cap">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Visual_Client_Info_E9"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Loc" ColSpan="3" Width="1020px" Caption="Città">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Visual_Client_Info_E4"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Prov" ColSpan="1" Width="100%" Caption="Provincia">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Visual_Client_Info_E3"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="DsNaz" ColSpan="3" Width="100%" Caption="Nazione">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Visual_Client_Info_E8"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="PIva" ColSpan="1" Width="100%" Caption="Partita IVA">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Visual_Client_Info_E6"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CF" ColSpan="1" Width="100%" Caption="Codice Fiscale">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Visual_Client_Info_E7"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Testata">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <div class="row">
                                        <dx:ASPxFormLayout Enabled="false" runat="server" ColumnCount="6" ID="Testata_FormView" ClientInstanceName="Testata_FormView" Width="100%" DataSourceID="Testata_dts" ColCount="6" Paddings-Padding="0">
                                            <Items>
                                                <dx:LayoutItem FieldName="Sconto1" ColSpan="3">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxSpinEdit runat="server" Width="775px" Number="0" ID="Testata_FormView_E1"></dx:ASPxSpinEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Sconto2" ColSpan="3">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxSpinEdit runat="server" Width="775px" Number="0" ID="Testata_FormView_E2"></dx:ASPxSpinEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodBan" ColSpan="3" Caption="Banca">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="775px" ID="Testata_FormView_E3"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Banca" ColSpan="3" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="840px" ID="Testata_FormView_E5"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                                <dx:LayoutItem FieldName="CodVal" ColSpan="2" Caption="Valuta">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="500px" ID="Testata_FormView_E4"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Cambio" ColSpan="2" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxSpinEdit runat="server" Width="500px" Number="0" ID="Testata_FormView_E6"></dx:ASPxSpinEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Valuta" ColSpan="2" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="575px" ID="Testata_FormView_E7"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Note">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <div class="row">
                                        <dx:ASPxFormLayout runat="server" Enabled="false" ID="Note_layout" ClientInstanceName="Note_layout" DataSourceID="Note_dts" Width="100%">
                                            <Items>
                                                <dx:LayoutItem ShowCaption="False" FieldName="Note" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxMemo runat="server" ID="Note_txt" ClientInstanceName="Note_txt" Rows="10" Width="100%"></dx:ASPxMemo>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                </dx:ASPxPageControl>

                <div class="col-md-12" style="overflow-x: visible scroll; margin-bottom: 10px;">
                    <dx:ASPxGridView runat="server" ID="Dettaglio_Grw" ClientInstanceName="Dettaglio_Grw" Width="100%" AutoGenerateColumns="False" DataSourceID="Dettaglio_Dts" OnHtmlRowPrepared="Dettaglio_Grw_HtmlRowPrepared">
                        <Settings ShowGroupPanel="false" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                        <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
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
                                </Items>
                            </dx:GridViewToolbar>

                        </Toolbars>
                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="NRiga" VisibleIndex="0" Width="60px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodArt" VisibleIndex="1" Width="200px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="UM" VisibleIndex="3" Width="60px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="QtaOrd" VisibleIndex="3" Width="80px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Prezzo" VisibleIndex="4" Width="80px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="5"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Nota" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="OrdNum" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" ReadOnly="True" VisibleIndex="2"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="TipoNota" VisibleIndex="9" Visible="false"></dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource runat="server" ID="TestataOrdine_dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdForTest.OrdNum, OrdForTest.OrdDat, OrdForTest.CodFor, OrdForTest.CodDoc, TabCodDoc.Protocollo AS ProtocolloDoc, OrdForTest.PrevCons, OrdForTest.CodPag, TabPag.Descrizione AS Descrizione_Pag, Fornito.CodNaz FROM OrdForTest INNER JOIN Fornito ON OrdForTest.CodFor = Fornito.CodFor LEFT OUTER JOIN TabCodDoc ON OrdForTest.CodDoc = TabCodDoc.CodDoc LEFT OUTER JOIN TabPag ON OrdForTest.CodPag = TabPag.CodCPag WHERE (OrdForTest.OrdNum = @OrdNum)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="CLientInfo_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Denom, Ind, Prov, Loc, Tel, PIva, CF, DsNaz, Cap FROM Fornito WHERE (CodFor = @CodFor)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TestataOrdine_FormView$TestataOrdine_FormView_E3" Name="CodFor"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Testata_dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdForTest.Sconto1, OrdForTest.Sconto2, OrdForTest.CodBan, OrdForTest.CodVal, TabBan.Descrizione AS Banca, OrdForTest.Cambio, TabVal.Descrizione AS Valuta FROM TabBan RIGHT OUTER JOIN OrdForTest ON TabBan.CodBan = OrdForTest.CodBan LEFT OUTER JOIN TabVal ON OrdForTest.CodVal = TabVal.CodVal WHERE (OrdForTest.OrdNum = @OrdNum)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Note_dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Note FROM OrdForTest WHERE (CodFor = @CodFor) AND (OrdNum = @OrdNum)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TestataOrdine_FormView$TestataOrdine_FormView_E3" Name="CodFor"></asp:ControlParameter>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Dettaglio_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdForDett.NRiga, OrdForDett.CodArt, OrdForDett.UM, OrdForDett.QtaOrd, OrdForDett.Prezzo, OrdForDett.Note, OrdForDett.Nota, OrdForTest.OrdNum, Articoli.Descrizione + ISNULL(Articoli.Desc2, '') AS Descrizione, OrdForDett.TipoNota FROM OrdForTest INNER JOIN OrdForDett ON OrdForTest.ID = OrdForDett.IDTestata LEFT OUTER JOIN Articoli ON OrdForDett.CodArt = Articoli.CodArt WHERE (OrdForTest.OrdNum = @OrdNum) ORDER BY OrdForDett.NRiga">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
