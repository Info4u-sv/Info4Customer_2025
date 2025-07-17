<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dettaglio_Ordini_Cliente.aspx.cs" Inherits="INTRA.Ordini.Dettaglio_Ordini_Cliente" %>

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
            /*window.history.back();*/
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
                <dx:ASPxLabel ID="CategoriaDiVisualizzazione_Lbl" ClientInstanceName="CategoriaDiVisualizzazione_Lbl" runat="server" Font-Size="X-Large" Text="Dettaglio Ordine Cliente"></dx:ASPxLabel>
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
                                <dx:LayoutItem FieldName="CodCli" ColSpan="1" Caption="Cliente">
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
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>
                <dx:ASPxPageControl ID="DettaglioOrdine_Tabs" ClientInstanceName="DettaglioOrdine_Tabs" Width="100%" Height="100px" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True" ActiveTabStyle-Border-BorderColor="#076ab1" ActiveTabStyle-ForeColor="#076ab1">
                    <TabPages>
                        <dx:TabPage Text="Cliente">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <div class="row">
                                        <dx:ASPxFormLayout runat="server" Enabled="false" ID="Visual_Client_Info" Width="100%" ColumnCount="5" ClientInstanceName="Visual_Client_Info" ColCount="5" DataSourceID="CLientInfo_Dts">
                                            <Items>
                                                <dx:LayoutItem FieldName="Denom" ColSpan="4" Caption="Nome">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="1240px" ID="Visual_Client_Info_E1"></dx:ASPxTextBox>
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
                                                <dx:LayoutItem FieldName="Cap" ColSpan="1" Width="265px" Caption="Cap">
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
                                        <dx:ASPxFormLayout runat="server" Enabled="false" ColumnCount="7" ID="Testata_FormView" ClientInstanceName="Testata_FormView" Width="100%" DataSourceID="Testata_dts" ColCount="7" Paddings-Padding="0">
                                            <Items>
                                                <dx:LayoutItem FieldName="BanCli" ColSpan="1" Caption="Banca">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="BanCli_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Nome" ColSpan="3" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="600px" ID="Nome_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Sconto1" ColSpan="1" Caption="Sconto 1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="Sconto1_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Sconto2" ColSpan="2" Caption="Sconto 2">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="400px" ID="Sconto2_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodBan" ColSpan="1" Caption="Ns. Banca">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="CodBan_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_NsBan" ColSpan="3" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="600px" ID="Desc_NsBan_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodLis" ColSpan="1" Caption="Listino">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="CodLis_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_Listino" ColSpan="2" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="537px" ID="Desc_Listino_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodVal" ColSpan="1" Caption="Valuta">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="CodVal_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CambioEuro" ColSpan="1" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="200px" ID="CambioEuro_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_Val" ColSpan="2" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="375px" ID="Desc_Val_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="FlagListino" ColSpan="1" Caption="Listino personalizzato">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxCheckBox ID="Listino_Check" Width="150px" ClientInstanceName="Listino_Check" runat="server"></dx:ASPxCheckBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="NumOrdCli" ColSpan="2" Caption="Num. Ord. Cliente">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="400px" ID="NumOrdCli_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Agente" ColSpan="1" Caption="Agente">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="Agente_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_Age" ColSpan="3" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="600px" ID="Desc_Age_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="FlagConferma" ColSpan="1" Caption="Conferma">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxCheckBox ID="Conferma_Check" Width="150px" ClientInstanceName="Conferma_Check" runat="server"></dx:ASPxCheckBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="DataOrdCli" ColSpan="2" Caption="Data Ordine Cliente">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxDateEdit runat="server" Width="400px" ID="DataOrdCli_Date"></dx:ASPxDateEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Deposito" ColSpan="1" Caption="Deposito">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="Deposito_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_Dep" ColSpan="3" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="600px" ID="Desc_Dep_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="AssIva" ColSpan="1" Caption="Assoggettamento Iva">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="AssIva_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_Iva" ColSpan="2" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="537px" ID="Desc_Iva_Txt"></dx:ASPxTextBox>
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
                                        <dx:ASPxFormLayout runat="server" Enabled="false" ID="Note_layout" ClientInstanceName="Note_layout" DataSourceID="Note_dts" ColumnCount="1" Width="100%">
                                            <Items>
                                                <dx:LayoutItem ShowCaption="False" FieldName="Note" ColumnSpan="1" Width="100%">
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
                        <dx:TabPage Text="Dati Spedizione">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <div class="row">
                                        <dx:ASPxFormLayout runat="server" Enabled="false" ColumnCount="6" ID="DatiSpedizione_FormView" ClientInstanceName="DatiSpedizione_FormView" Width="100%" DataSourceID="Testata_dts" ColCount="6" Paddings-Padding="0">
                                            <Items>
                                                <dx:LayoutItem FieldName="CodDiv" ColSpan="1" Caption="Codice">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="CodDiv_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Descr_DivDest" ColSpan="5" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="1460px" ID="Descr_DivDest_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Ind" ColSpan="6" Caption="Indirizzo">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="1635px" ID="Ind_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Cap" ColSpan="1" Caption="Città">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="Cap_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Loc" ColSpan="4" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="1100px" ID="Loc_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Prov" ColSpan="1" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="335px" ID="Prov_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodNaz" ColSpan="1" Caption="Nazione">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="CodNaz_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="DsNAz" ColSpan="5" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="1460px" ID="DsNAz_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodSpe1" ColSpan="1" Caption="Spedizioniere">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="CodSpe1_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_Spe1" ColSpan="2" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="770px" ID="Desc_Spe1_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodPor" ColSpan="1" Caption="Porto">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="250px" ID="CodPor_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Descr_Por" ColSpan="2" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="335px" ID="Descr_Por_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="CodSpe2" ColSpan="1" Caption="Spedizioniere">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="150px" ID="CodSpe2_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem FieldName="Desc_Spe2" ColSpan="5" ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" Width="1460px" ID="Desc_Spe2_Txt"></dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="Sconti e spese">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <div class="col-md-12 no-margin no-padding" style="display: inline-flex; gap: 10px">
                                        <dx:ASPxGridView runat="server" ID="ScontiSpese_Grw" ClientInstanceName="ScontiSpese_Grw" Width="50%" DataSourceID="ScontiSpese_Dts" KeyFieldName="IdSconto" AutoGenerateColumns="False" Styles-AlternatingRow-Enabled="True">
                                            <Settings ShowFilterRow="True" ShowHeaderFilterButton="True" AutoFilterCondition="Contains"></Settings>
                                            <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                            <SettingsCommandButton>
                                                <PreviewChangesButton RenderMode="Button">
                                                    <Styles Style-CssClass="hide"></Styles>
                                                </PreviewChangesButton>
                                                <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                                </ClearFilterButton>
                                                <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn edit icon4u icon-edit image"></Styles>
                                                </EditButton>
                                                <DeleteButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn delete icon4u icon-delete image"></Styles>
                                                </DeleteButton>
                                                <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn update icon4u icon-update image hide"></Styles>
                                                </UpdateButton>
                                                <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn cancel icon4u icon-cancel image hide"></Styles>
                                                </CancelButton>
                                                <NewButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn new icon4u icon-new image"></Styles>
                                                </NewButton>
                                                <SelectButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                                                </SelectButton>
                                            </SettingsCommandButton>
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowEditButton="true" VisibleIndex="1" Width="20px" CellStyle-HorizontalAlign="Center" Visible="false"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" Visible="false">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Descrizione spese" VisibleIndex="1">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Tipo" VisibleIndex="2" Visible="false">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Nriga" VisibleIndex="3" CellStyle-HorizontalAlign="Center" Width="40px">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Percentuale" VisibleIndex="4" CellStyle-HorizontalAlign="Center" Width="40px">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn FieldName="Importo" VisibleIndex="5" CellStyle-HorizontalAlign="Center" Width="40px" PropertiesSpinEdit-DisplayFormatString="C">
                                                    <PropertiesSpinEdit MinValue="0" MaxValue="100000"></PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataTextColumn FieldName="CodIva" VisibleIndex="6" CellStyle-HorizontalAlign="Center" Width="100px">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                            </Columns>
                                        </dx:ASPxGridView>
                                        <dx:ASPxGridView runat="server" ID="Sconti_Grw" ClientInstanceName="Sconti_Grw" Width="50%" DataSourceID="Sconti_Dts" KeyFieldName="IdSconto" AutoGenerateColumns="False" Styles-AlternatingRow-Enabled="True">
                                            <Settings ShowFilterRow="True" ShowHeaderFilterButton="True" AutoFilterCondition="Contains"></Settings>
                                            <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                            <SettingsCommandButton>
                                                <PreviewChangesButton RenderMode="Button">
                                                    <Styles Style-CssClass="hide"></Styles>
                                                </PreviewChangesButton>
                                                <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                                </ClearFilterButton>
                                                <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn edit icon4u icon-edit image"></Styles>
                                                </EditButton>
                                                <DeleteButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn delete icon4u icon-delete image"></Styles>
                                                </DeleteButton>
                                                <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn update icon4u icon-update image hide"></Styles>
                                                </UpdateButton>
                                                <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn cancel icon4u icon-cancel image hide"></Styles>
                                                </CancelButton>
                                                <NewButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn new icon4u icon-new image"></Styles>
                                                </NewButton>
                                                <SelectButton RenderMode="Button" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                                    <Styles Style-CssClass="btn btn-sm  action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                                                </SelectButton>
                                            </SettingsCommandButton>
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowEditButton="true" VisibleIndex="1" Width="20px" CellStyle-HorizontalAlign="Center" Visible="false"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" Visible="false">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Descrizione sconti" VisibleIndex="1">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Tipo" VisibleIndex="2" Visible="false">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Nriga" VisibleIndex="3" CellStyle-HorizontalAlign="Center" Width="40px">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Percentuale" VisibleIndex="4" CellStyle-HorizontalAlign="Center" Width="40px">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn FieldName="Importo" VisibleIndex="5" CellStyle-HorizontalAlign="Center" Width="40px" PropertiesSpinEdit-DisplayFormatString="C">
                                                    <PropertiesSpinEdit MinValue="0" MaxValue="100000"></PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataTextColumn FieldName="CodIva" VisibleIndex="6" CellStyle-HorizontalAlign="Center" Width="100px">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                            </Columns>
                                        </dx:ASPxGridView>
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

    <asp:SqlDataSource runat="server" ID="TestataOrdine_dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdNum,OrdDat,CodCli,PrevCons,CodPag,OrdCliTest.CodDoc,TabCodDoc.Protocollo AS ProtocolloDoc,TabPag.Descrizione AS Descrizione_Pag FROM OrdCliTest LEFT OUTER JOIN TabCodDoc ON OrdCliTest.CodDoc = TabCodDoc.CodDoc LEFT OUTER JOIN TabPag ON OrdCliTest.CodPag = TabPag.CodCPag WHERE OrdNum = @OrdNum">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="CLientInfo_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Denom, Ind, Prov, Loc, Tel, PIva, CF, DsNaz, Cap FROM Clienti WHERE (CodCli = @CodCli)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TestataOrdine_FormView$TestataOrdine_FormView_E3" Name="CodCli"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Testata_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdCliTest.BanCli, OrdCliTest.CodBan, OrdCliTest.Agente, OrdCliTest.Deposito, OrdCliTest.Sconto1, OrdCliTest.Sconto2, OrdCliTest.CodLis, OrdCliTest.FlagConferma, OrdCliTest.AssIva, OrdCliTest.NumOrdCli, ISNULL(OrdCliTest.DataOrdCli, GETDATE()) AS DataOrdCli, OrdCliTest.CodDiv, OrdCliTest.CodSpe1, OrdCliTest.CodSpe2, OrdCliTest.CodPor, TabAge.Descrizione AS Desc_Age, TabSpe_1.Descrizione AS Desc_Spe1, TabSpe.Descrizione AS Desc_Spe2, DivDest.Ind, DivDest.Loc, DivDest.CodNaz, DivDest.DsNAz, TabPor.Descrizione AS Descr_Por, TabBan.Descrizione AS Desc_NsBan, DivDest.Denom AS Descr_DivDest, DivDest.Cap, DivDest.Prov, BancheCli.Nome, TabLis.Descrizione AS Desc_Listino, TabIva.Descrizione AS Desc_Iva, CliFatt1.FlagListino,  TabVal.CambioEuro, TabVal.Descrizione AS Desc_Val, TabDep.Descrizione AS Desc_Dep, OrdCliTest.CodVal FROM OrdCliTest LEFT OUTER JOIN TabDep ON OrdCliTest.Deposito = TabDep.CodDep LEFT OUTER JOIN TabVal ON OrdCliTest.CodVal = TabVal.CodVal LEFT OUTER JOIN DivDest ON OrdCliTest.CodCli = DivDest.CodCli AND OrdCliTest.CodDiv = DivDest.CodDiv LEFT OUTER JOIN BancheCli ON OrdCliTest.CodCli = BancheCli.CodCli AND OrdCliTest.BanCli = BancheCli.IDBan LEFT OUTER JOIN TabIva ON OrdCliTest.AssIva = TabIva.CodIva LEFT OUTER JOIN TabLis ON OrdCliTest.CodLis = TabLis.CodLis LEFT OUTER JOIN TabPor ON OrdCliTest.CodPor = TabPor.CodPor LEFT OUTER JOIN TabBan ON OrdCliTest.CodBan = TabBan.CodBan LEFT OUTER JOIN TabAge ON OrdCliTest.Agente = TabAge.CodAge LEFT OUTER JOIN TabSpe AS TabSpe_1 ON OrdCliTest.CodSpe1 = TabSpe_1.CodSpe LEFT OUTER JOIN TabSpe ON OrdCliTest.CodSpe2 = TabSpe.CodSpe LEFT OUTER JOIN CliFatt1 ON OrdCliTest.CodCli = CliFatt1.CodCli WHERE OrdNum = @OrdNum">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Note_dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Note FROM OrdCliTest WHERE  (OrdNum = @OrdNum)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="ScontiSpese_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdCSpese.ID, OrdCSpese.Tipo, OrdCSpese.Nriga, ISNULL(OrdCSpese.[Percent],0) AS Percentuale, OrdCSpese.Importo, OrdCSpese.CodIva, U_DefSpese_NoSconti.Descrizione, U_DefSpese_NoSconti.Gruppo FROM OrdCSpese INNER JOIN OrdCliTest ON OrdCSpese.IDTest = OrdCliTest.ID INNER JOIN U_DefSpese_NoSconti ON OrdCSpese.Nriga = U_DefSpese_NoSconti.IDSpesa WHERE (OrdCliTest.OrdNum = @OrdNum)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Sconti_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdCSpese.ID, OrdCSpese.Tipo, OrdCSpese.Nriga, ISNULL(OrdCSpese.[Percent],0) AS Percentuale, OrdCSpese.Importo, OrdCSpese.CodIva, U_DefSpese_Sconti.Descrizione, U_DefSpese_Sconti.Gruppo FROM OrdCSpese INNER JOIN OrdCliTest ON OrdCSpese.IDTest = OrdCliTest.ID INNER JOIN U_DefSpese_Sconti ON OrdCSpese.Nriga = U_DefSpese_Sconti.IDSpesa WHERE (OrdCliTest.OrdNum = @OrdNum)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Dettaglio_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT OrdCliDett.NRiga, OrdCliDett.CodArt, OrdCliDett.UM, OrdCliDett.QtaOrd, OrdCliDett.Prezzo, OrdCliDett.Note, OrdCliDett.Nota, OrdCliTest.OrdNum, Articoli.Descrizione + ISNULL(Articoli.Desc2, '') AS Descrizione, OrdCliDett.TipoNota FROM OrdCliTest INNER JOIN OrdCliDett ON OrdCliTest.ID = OrdCliDett.IDTestata LEFT OUTER JOIN Articoli ON OrdCliDett.CodArt = Articoli.CodArt WHERE (OrdCliTest.OrdNum = @OrdNum) ORDER BY OrdCliDett.NRiga">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="OrdNum" Name="OrdNum"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
