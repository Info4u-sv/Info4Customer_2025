<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InserimentoTicket.aspx.cs" Inherits="INTRA.Ticket.InserimentoTicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function ChangeType(s, type) {
            // Some desktop browsers throw an exception if a value of the type property is not supported.
            try {
                s.GetInputElement().type = type;
            }
            catch (err) {
                alert("\"" + type + "\"\n\r " + err.message);
            }
        }
    </script>

    <script type="text/javascript">

        function onAreaValidation(s, e) {
            var SelectedIndex = e.SelectedIndex;
            if (SelectedIndex == -1) {
                return;
            }
            if (SelectedIndex > -1) {
                e.isValid = true;
            }
        }
        function onNameValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            if (name.length < 2)
                e.isValid = false;
        }

        function TimeValidation(s, e) {
            var name = e.value;
            if (name == null)
                return;
            if (TxtOraFine_insertResponsive.GetText() > TxtOraInizio_insertResponsive.GetText()) { e.isValid = true; }
            else { e.isValid = false; }
        }

        function onAgeValidation(s, e) {
            var age = e.value;
            if (age == null || age == "")
                return;
            var digits = "0123456789";
            for (var i = 0; i < age.length; i++) {
                if (digits.indexOf(age.charAt(i)) == -1) {
                    e.isValid = false;
                    break;
                }
            }
            if (e.isValid && age.charAt(0) == '0') {
                age = age.replace(/^0+/, "");
                if (age.length == 0)
                    age = "0";
                e.value = age;
            }
            if (age < 18)
                e.isValid = false;
        }
        function onArrivalDateValidation(s, e) {
            var selectedDate = s.date;
            if (selectedDate == null || selectedDate == false)
                return;
            var currentDate = new Date();
            if (currentDate.getFullYear() != selectedDate.getFullYear() || currentDate.getMonth() != selectedDate.getMonth())
                e.isValid = false;
        }
        function clearEditors(s, e) {
            var container = document.getElementsByClassName("clientContainer")[0];
            ASPxClientEdit.ClearEditorsInContainer(container);
        }

        function ColorResiduo(Residuo, id) {
            alert('ColorResiduo');
            console.log(Residuo);
            var ResiduoNum = parseFloat(Residuo);
            var Colore = '#06cb00';
            if (ResiduoNum >= 4) {
                Colore = '#06cb00';
            } if (ResiduoNum <= 0) {
                Colore = '#ea0000';
            }
            if (ResiduoNum < 4 && ResiduoNum > 0) {
                Colore = '#fdb900';
            }

            document.getElementById(id).style.color = Colore;
            //return Colore;
        }
    </script>
    <script>
        function interventoPressoCalcola() {

            var ClientiCBox_selectedItem = ClientiComboBoxResponsive.GetSelectedItem();
            var Rbl_TCK_TipoEsecuzione_SelectedIndex = Rbl_TCK_TipoEsecuzioneResponsive.GetSelectedIndex();
            console.log(Rbl_TCK_TipoEsecuzione_SelectedIndex);

            var InterventoPresso = "Info4u Srl";
            if ((Rbl_TCK_TipoEsecuzione_SelectedIndex == 0) || (Rbl_TCK_TipoEsecuzione_SelectedIndex == 1) || (Rbl_TCK_TipoEsecuzione_SelectedIndex == 5)) {
                if (ClientiCBox_selectedItem) {
                    InterventoPresso = ClientiCBox_selectedItem.GetColumnText("Denom") + " - " + ClientiCBox_selectedItem.GetColumnText("Loc") + " - " + ClientiCBox_selectedItem.GetColumnText("Ind");
                } else {
                    InterventoPresso = "Info4u Srl";
                }
            }
            else {
                InterventoPresso = "Info4u Srl";
            }
            InterventoPreso_TxtResponsive.SetText(InterventoPresso);
            ServiziAttivi_Gridview.Refresh();
        }

        function GetTecniciSelectedResponsive() {
            var TecniciSel = checkBoxList_TecniciResponsive.GetSelectedValues();
            let length = TecniciSel.length;

            var TextTecniciSelezionati = "";
            if (length > 0) {
                TextTecniciSelezionati = "Tecnici Selezionati: <br />" + TecniciSel;
            } else {
                TextTecniciSelezionati = "";
            }

            TecniciSelezionati_TxtResponsive.SetText(TextTecniciSelezionati);
            if (cbInviaCalendartResponsive.GetChecked()) {
                GiornoEOra_TxtResponsive.SetText("Appuntamento fissato il: <br/>" + txtDataInterventoResponsive.GetText() + " Inizio: " + TxtOraInizio_insertResponsive.GetText() + " Fine: " + TxtOraFine_insertResponsive.GetText());
            } else {
                GiornoEOra_TxtResponsive.SetText("");
            }



            console.log(TextTecniciSelezionati);
        }
    </script>
    <style>
        .dxgvDataRow_Office365:last-child td.dxgv, .dxgvTable_Office365 {
            border-bottom: 0px solid rgba(0,0,0,0.1) !important;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">confirmation_number</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Inserimento Ticket</h4>
                    <dx:ASPxLoadingPanel ID="InserimentoTck_LoadingPnl" ClientInstanceName="InserimentoTck_LoadingPnlResponsive" Modal="true" runat="server" Text="Inserimento ticket in corso..." LoadingDivStyle-BackColor="#eeeef2" LoadingDivStyle-Opacity="70">
                    </dx:ASPxLoadingPanel>
                    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" ClientInstanceName="ASPxCallbackPanel1" runat="server" OnCallback="ASPxCallbackPanel1_Callback">
                        <%--<ClientSideEvents EndCallback="function(s,e){xx.Refresh();}" />--%>
                        <PanelCollection>
                            <dx:PanelContent>
                                <dx:ASPxLabel ID="eRrore_Lbl" runat="server"></dx:ASPxLabel>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                    <div id="datiprincipaliDivResponsive">
                        <dx:ASPxFormLayout runat="server" ID="formlayout" ClientInstanceName="TicketAddForm" Width="100%" Paddings-Padding="0" BackColor="#ffffff" ValidateRequestMode="Enabled">
                            <Items>

                                <dx:LayoutGroup ColumnCount="4" Caption="" Paddings-Padding="0">
                                    <GridSettings>
                                        <Breakpoints>
                                            <dx:LayoutBreakpoint MaxWidth="600" ColumnCount="1" Name="S" />
                                        </Breakpoints>
                                    </GridSettings>

                                    <Paddings Padding="0px"></Paddings>
                                    <Items>

                                        <dx:LayoutItem Caption="Cliente" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <script>
                                                        function onKeyDown(s, e) {
                                                            if (e.htmlEvent.keyCode == 13) {
                                                                ASPxClientUtils.PreventEventAndBubble(e.htmlEvent);
                                                                s.filterStrategy.Filtering();
                                                                s.ShowDropDown();
                                                            }
                                                        }
                                                    </script>

                                                    <dx:ASPxComboBox ID="ClientiComboBox" ClientInstanceName="ClientiComboBoxResponsive" runat="server" EnableCallbackMode="false" ForceDataBinding="true"
                                                        ValueField="CodCli" DropDownStyle="DropDownList" TextFormatString="{0}" TextField="Denom" IncrementalFilteringMode="Contains" DataSourceID="Clienti_Dts">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){interventoPressoCalcola();}" />
                                                        <ValidationSettings ValidationGroup="InserimentoTicket" SetFocusOnError="True" ErrorDisplayMode="None">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                        <ClientSideEvents Validation="onAreaValidation" />
                                                        <InvalidStyle BackColor="LightPink" />
                                                        <ClearButton DisplayMode="Always"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Denom" Width="100%" />
                                                            <dx:ListBoxColumn FieldName="CodCli" ClientVisible="false" Caption="." Width="0px" />
                                                            <dx:ListBoxColumn FieldName="Loc" ClientVisible="false" Caption="." Width="0px" />
                                                            <dx:ListBoxColumn FieldName="Ind" ClientVisible="false" Caption="." Width="0px" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:SqlDataSource ID="ServiziAttivi_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT IdProdotto , ResiduoOre, Descr FROM (SELECT U_Carnet_Contratti_View_Intra.ContM, U_Carnet_Contratti_View_Intra.CodCli, U_Carnet_Contratti_View_Intra.Denom, U_Carnet_Contratti_View_Intra.U_Carnet, U_Carnet_Contratti_View_Intra.U_ContrattoHWSW, U_Carnet_Contratti_View_Intra.U_Print, U_Carnet_Contratti_View_Intra.IdProdotto, U_Carnet_Contratti_View_Intra.U_TotOreContratto, U_Carnet_Contratti_View_Intra.U_CC, U_Carnet_Contratti_View_Intra.U_Tipo_Assistenza, U_Carnet_Contratti_View_Intra.Totale, U_Carnet_Contratti_View_Intra.Totinterventi, U_Carnet_Contratti_View_Intra.ResiduoOre, U_Carnet_Contratti_View_Intra.DataCar, U_Carnet_Contratti_View_Intra.DescrTipoAssistenza, U_Carnet_Contratti_View_Intra.Descrizione, U_Tipo_Assistenza.Descr FROM U_Carnet_Contratti_View_Intra LEFT OUTER JOIN U_Tipo_Assistenza ON U_Carnet_Contratti_View_Intra.U_Tipo_Assistenza = U_Tipo_Assistenza.ID WHERE (U_Carnet_Contratti_View_Intra.CodCli = @CodCli) AND (U_Carnet_Contratti_View_Intra.U_CC = 0)) AS derivedtbl_1">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="ClientiComboBox" PropertyName="Value" Name="CodCli"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="Clienti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT CodCli, Denom, Ind, Loc, tel FROM Clienti where flagannullo = 0"></asp:SqlDataSource>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Area">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCallbackPanel ID="AreaAss_CallbackPnl" ClientInstanceName="AreaAss_CallbackPnlResponsive" runat="server" Width="100%">
                                                        <SettingsLoadingPanel Enabled="false" />
                                                        <PanelCollection>
                                                            <dx:PanelContent>
                                                                <dx:ASPxComboBox runat="server" SelectedIndex="0" ID="rbtAreaAss" ClientInstanceName="rbtAreaAssResponsive" ShowImageInEditBox="True" ImageUrlField="ImageUrl" TextField="Descrizione" ValueField="IdAreaAss" DropDownStyle="DropDownList" DataSourceID="DtsTCK_AreaCompetenza" IncrementalFilteringMode="None" Width="100%">
                                                                    <ValidationSettings SetFocusOnError="false" ErrorDisplayMode="None" ValidationGroup="InserimentoTicket">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                    <ClientSideEvents Validation="onAreaValidation" />
                                                                    <InvalidStyle BackColor="LightPink" />
                                                                    <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                                    <ItemImage Height="30px" Width="30px" />
                                                                </dx:ASPxComboBox>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>

                                        <dx:LayoutItem Caption="Priorità*:">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox runat="server" ID="Rbl_TCK_PrioritaRichiesta" ClientInstanceName="Rbl_TCK_PrioritaRichiestaResponsive" TextField="Descrizione" ValueField="Id" DropDownStyle="DropDownList" DataSourceID="DtsTCK_PrioritaRichiesta" IncrementalFilteringMode="None" ShowImageInEditBox="True" ImageUrlField="ImageUrl" SelectedIndex="0">
                                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                        <ItemImage Height="30px" Width="30px" />
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ShowCaption="False" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>

                                                    <dx:ASPxGridView ID="ServiziAttivi_Gridview" ClientInstanceName="ServiziAttivi_Gridview" runat="server" DataSourceID="ServiziAttivi_Dts" Width="100%" Settings-ShowColumnHeaders="false" Border-BorderWidth="0" Border-BorderColor="White" Styles-Cell-Border-BorderWidth="0" Styles-Cell-Border-BorderColor="White" Styles-Table-Border-BorderColor="White" BorderBottom-BorderColor="White" Styles-Footer-BorderBottom-BorderColor="White" Styles-Cell-BorderBottom-BorderColor="White" Styles-Table-BorderBottom-BorderColor="White" AutoGenerateColumns="False">
                                                        <Templates>
                                                            <DataRow>

                                                                <%--<div class="row">
                                                                    <img src="https://info4u.it/wp-content/uploads/2019/07/info4us.png" onload="ColorResiduo(<%# Eval("ResiduoOre").ToString() %>, '<%# Eval("IdProdotto") %>')" style="display: none;">
                                                                    <div class="col-lg-12 col-md-12" onload="ColorResiduo(<%# Eval("ResiduoOre").ToString() %>, '<%# Eval("IdProdotto") %>')" id="<%# Eval("IdProdotto") %>">
                                                                        <%#Eval("Descr") %>:
                                                       <strong><%# Eval("IdProdotto") %></strong>
                                                                        Residuo:
                                                       <strong><%# Eval("ResiduoOre") %></strong>
                                                                    </div>
                                                                </div>--%>
                                                                <div class="col-lg-12 col-md-12" id="<%# Eval("IdProdotto") %>">
                                                                    <%#Eval("Descr") %>:
                                                                    <strong><%# Eval("IdProdotto") %></strong>
                                                                    Residuo:
                                                                    <strong><%# Eval("ResiduoOre") %></strong>
                                                                </div>
                                                            </DataRow>
                                                        </Templates>

                                                        <Settings ShowColumnHeaders="False"></Settings>

                                                        <SettingsPopup>
                                                            <HeaderFilter MinHeight="140px"></HeaderFilter>
                                                        </SettingsPopup>
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="IDCarnet" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="OreResidueCarnet" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="IDContratto" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="OreResidueContratto" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                        </Columns>

                                                        <Styles>
                                                            <Table Border-BorderColor="White">
                                                                <BorderBottom BorderColor="White"></BorderBottom>
                                                            </Table>

                                                            <Cell Border-BorderColor="White" Border-BorderWidth="0px">
                                                                <BorderBottom BorderColor="White"></BorderBottom>
                                                            </Cell>

                                                            <Footer>
                                                                <BorderBottom BorderColor="White"></BorderBottom>
                                                            </Footer>
                                                        </Styles>

                                                        <Border BorderColor="White" BorderWidth="0px"></Border>

                                                        <BorderBottom BorderColor="White"></BorderBottom>

                                                    </dx:ASPxGridView>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Tipo Richiesta*:">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox runat="server" SelectedIndex="0" ID="rbtTipoChiamata" ClientInstanceName="rbtTipoChiamataResponsive" TextField="Descrizione" ValueField="Id" ShowImageInEditBox="True" ImageUrlField="ImageUrl" DropDownStyle="DropDownList" DataSourceID="DtsTCK_TipoRichiesta" IncrementalFilteringMode="None">
                                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                        <ItemImage Height="30px" Width="30px" />
                                                    </dx:ASPxComboBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Da Eseguire*:">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox runat="server" SelectedIndex="0" ID="Rbl_TCK_TipoEsecuzione" ClientInstanceName="Rbl_TCK_TipoEsecuzioneResponsive" TextField="Descrizione" ValueField="Id" DropDownStyle="DropDownList" ShowImageInEditBox="True" ImageUrlField="ImageUrl" DataSourceID="DtsTCK_TipoEsecuzione" IncrementalFilteringMode="None">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){interventoPressoCalcola();}" />
                                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" />
                                                        <ItemImage Height="30px" Width="30px" />
                                                    </dx:ASPxComboBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Intervento Presso:" ColumnSpan="4">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>

                                                    <dx:ASPxCallbackPanel ID="InterventoPResso_CallbackPnl" ClientInstanceName="InterventoPResso_CallbackPnl" runat="server" Width="100%" OnCallback="MotivoChiamata_CallbackPnl_Callback">
                                                        <SettingsLoadingPanel Enabled="false" />
                                                        <PanelCollection>
                                                            <dx:PanelContent>
                                                                <dx:ASPxTextBox ID="InterventoPreso_Txt" ClientInstanceName="InterventoPreso_TxtResponsive" runat="server" NullText="Intervento Presso?" Width="100%"></dx:ASPxTextBox>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Contatto:">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox ID="Contatto_Txt_DX" runat="server" NullText="Contatto?"></dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Telefono:">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox ID="Telefono_Txt_DX" runat="server" NullText="Telefono?"></dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Email:" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxTextBox ID="Email_Txt_DX" runat="server" NullText="Email?"></dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="" Height="100px" ColumnSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxButton ID="BootstrapButton1" runat="server" AutoPostBack="false" RenderMode="Button" Text="Associa Tecnici" Width="100" UseSubmitBehavior="false">
                                                        <ClientSideEvents Click="function (s,e){TecniciModalResponsive.Show();}" />
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="" Height="100px" ColumnSpan="3">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxLabel ID="TecniciSelezionati_Txt" ClientInstanceName="TecniciSelezionati_TxtResponsive" runat="server" EncodeHtml="false" Border-BorderColor="White" Font-Bold="true">
                                                        <Border BorderColor="White"></Border>
                                                    </dx:ASPxLabel>
                                                    <dx:ASPxLabel ID="GiornoEOra_Txt" ClientInstanceName="GiornoEOra_TxtResponsive" runat="server" EncodeHtml="false" Border-BorderColor="White" ForeColor="Green" Font-Bold="true">
                                                        <Border BorderColor="White"></Border>
                                                    </dx:ASPxLabel>

                                                    <dx:ASPxCallbackPanel ID="Tecnici_CallbackPnl" ClientInstanceName="Tecnici_CallbackPnl" Width="100%" runat="server" OnCallback="Tecnici_CallbackPnl_Callback">
                                                        <%--<ClientSideEvents EndCallback="function(s,e){Tecnici_Gridview.Refresh();}" />--%>
                                                        <PanelCollection>
                                                            <dx:PanelContent>
                                                                <div class="row">
                                                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                                                    </div>

                                                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

                                                                        <%--<dx:ASPxGridView ID="Tecnici_Gridview" ClientInstanceName="Tecnici_Gridview" runat="server" DataSourceID="Tecnici_Dts" AutoGenerateColumns="False" Settings-ShowColumnHeaders="false" Border-BorderWidth="0" Border-BorderColor="White" Styles-Cell-Border-BorderWidth="0" Styles-Cell-Border-BorderColor="White" Styles-Table-Border-BorderColor="White" BorderBottom-BorderColor="White" Styles-Footer-BorderBottom-BorderColor="White" Styles-Cell-BorderBottom-BorderColor="White" Styles-Table-BorderBottom-BorderColor="White">
                                                           <Columns>
                                                               <dx:GridViewDataTextColumn CellStyle-Border-BorderWidth="0">
                                                                   <DataItemTemplate>
                                                                       <%# GetImgUtente()%>
                                                                   </DataItemTemplate>
                                                               </dx:GridViewDataTextColumn>
                                                           </Columns>
                                                       </dx:ASPxGridView>--%>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                    <asp:SqlDataSource ID="Tecnici_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT TOP 1 IdDominio FROM WEB_Domini"></asp:SqlDataSource>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Oggetto della chiamata:" ColumnSpan="4">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxMemo ID="OggettoTck_Memo" Rows="2" runat="server" NullText="Oggetto della chiamata?">
                                                    </dx:ASPxMemo>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Motivo della chiamata:" ColumnSpan="4">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>

                                                    <dx:ASPxMemo ID="Motivo_Chiamata_Txt_DX" Rows="5" runat="server" NullText="Motivo della chiamata?">
                                                        <ValidationSettings SetFocusOnError="True" ErrorDisplayMode="None" ValidationGroup="InserimentoTicket">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                        <ClientSideEvents Validation="onNameValidation" />
                                                        <InvalidStyle BackColor="LightPink" />
                                                    </dx:ASPxMemo>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Documenti:" ColumnSpan="4" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <script>
                                                        var uploadInProgress = false,
                                                            submitInitiated = false,
                                                            uploadErrorOccurred = false;
                                                        uploadedFiles = [];
                                                        function onFileUploadComplete(s, e) {
                                                            var callbackData = e.callbackData.split("|"),
                                                                uploadedFileName = callbackData[0],
                                                                isSubmissionExpired = callbackData[1] === "True";
                                                            uploadedFiles.push(uploadedFileName);
                                                            if (e.errorText.length > 0 || !e.isValid)
                                                                uploadErrorOccurred = true;
                                                            if (isSubmissionExpired && UploadedFilesTokenBox.GetText().length > 0) {
                                                                var removedAfterTimeoutFiles = UploadedFilesTokenBox.GetTokenCollection().join("\n");
                                                                alert("The following files have been removed from the server due to the defined 5 minute timeout: \n\n" + removedAfterTimeoutFiles);
                                                                UploadedFilesTokenBox.ClearTokenCollection();
                                                            }
                                                        }
                                                        function onFileUploadStart(s, e) {
                                                            uploadInProgress = true;
                                                            uploadErrorOccurred = false;
                                                            UploadedFilesTokenBox.SetIsValid(true);
                                                        }
                                                        function onFilesUploadComplete(s, e) {
                                                            uploadInProgress = false;
                                                            for (var i = 0; i < uploadedFiles.length; i++)
                                                                UploadedFilesTokenBox.AddToken(uploadedFiles[i]);
                                                            updateTokenBoxVisibility();
                                                            uploadedFiles = [];
                                                            if (submitInitiated) {
                                                                SubmitButton.SetEnabled(true);
                                                                SubmitButton.DoClick();
                                                            }
                                                        }
                                                        function onTokenBoxValidation(s, e) {
                                                            var isValid = DocumentsUploadControl.GetText().length > 0 || UploadedFilesTokenBox.GetText().length > 0;
                                                            e.isValid = isValid;

                                                            if (!isValid) {
                                                                e.errorText = "Non sono stati caricati file, riprovare.";
                                                            }
                                                            return true;

                                                            return false
                                                        }
                                                        function onTokenBoxValueChanged(s, e) {
                                                            updateTokenBoxVisibility();
                                                        }
                                                        function updateTokenBoxVisibility() {
                                                            var isTokenBoxVisible = UploadedFilesTokenBox.GetTokenCollection().length > 0;
                                                            UploadedFilesTokenBox.SetVisible(isTokenBoxVisible);
                                                        }
                                                        function formIsValid() {
                                                            return !ValidationSummary.IsVisible() && UploadedFilesTokenBox.GetIsValid() && !uploadErrorOccurred;
                                                        }
                                                    </script>

                                                    <dx:ASPxHiddenField runat="server" ID="HfFile" ClientInstanceName="HfFile"></dx:ASPxHiddenField>
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="1" UseDefaultPaddings="false">
                                                        <Items>
                                                            <dx:LayoutGroup Caption="Seleziona i documenti da caricare" GroupBoxStyle-Caption-Font-Bold="true">
                                                                <GroupBoxStyle>
                                                                    <Caption Font-Bold="True"></Caption>
                                                                </GroupBoxStyle>
                                                                <Items>

                                                                    <dx:LayoutItem ShowCaption="False">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer>
                                                                                <div id="dropZone">
                                                                                    <dx:ASPxUploadControl EnableTheming="true" runat="server" ID="DocumentsUploadControl" ClientInstanceName="DocumentsUploadControl"
                                                                                        AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Aggiungi Documenti" FileUploadMode="OnPageLoad"
                                                                                        OnFileUploadComplete="DocumentsUploadControl_FileUploadComplete" Theme="SoftOrange" AdvancedModeSettings-EnableFileList="true">
                                                                                        <BrowseButton Text="Aggiungi Documenti">
                                                                                        </BrowseButton>
                                                                                        <AdvancedModeSettings
                                                                                            EnableMultiSelect="true" EnableDragAndDrop="true" ExternalDropZoneID="dropZone">
                                                                                        </AdvancedModeSettings>
                                                                                        <ValidationSettings
                                                                                            MaxFileSize="2000000" MaxFileCount="3" AllowedFileExtensions=".pdf, .xps, .oxps, .xpz, .docx, .docm, .dotx, .dotm, .doc, .dot, .rtf, .odt, .ott, .xlsx, .xlsm, .xltx, .xltm, .xlam, .xlsb, .xls, .xlt, .xml, .csv, .tsv, .dif, .ods, .ots, .pptx, .pptm, .potx, .potm, .ppsx, .ppsm, .ppt, .pps, .odp, .otp, .vsdx, .vsdm, .vstx, .vstm, .vssx, .vssm, .vdx, .vsx, .vtx, .vsd, .vss, .vst, .vdw, .mpp, .mpt, .mpx, .msg, .eml, .emlx, .epub, .mobi, .html, .htm, .mht, .mhtml, .web, .txt, .dwg, .dxf, .tif, .tiff, .djvu, .dcm, .ps, .svg, .emf, .xaml, .psd, .jpg, .jpeg, .jpe, .jfif, .jp2, .jpf, .jpx, .j2k, .j2c, .jpc, .jxr, .wdp, .hdp, .png, .gif, .webp, .bmp, .wmf, .dib">
                                                                                        </ValidationSettings>
                                                                                        <ClientSideEvents
                                                                                            FileUploadComplete="onFileUploadComplete"
                                                                                            FilesUploadComplete="onFilesUploadComplete"
                                                                                            FilesUploadStart="onFileUploadStart" />
                                                                                        <DropZoneStyle Border-BorderColor="LightGray" Border-BorderStyle="None">
                                                                                        </DropZoneStyle>
                                                                                    </dx:ASPxUploadControl>
                                                                                    <br />
                                                                                    <dx:ASPxTokenBox runat="server" Width="100%" ID="UploadedFilesTokenBox" ClientInstanceName="UploadedFilesTokenBox"
                                                                                        NullText="Select the documents to submit" AllowCustomTokens="false" ClientVisible="false">

                                                                                        <ClientSideEvents Init="updateTokenBoxVisibility" ValueChanged="onTokenBoxValueChanged" Validation="onTokenBoxValidation" />
                                                                                        <ValidationSettings EnableCustomValidation="true"></ValidationSettings>
                                                                                    </dx:ASPxTokenBox>
                                                                                    <br />

                                                                                    <dx:ASPxValidationSummary runat="server" ID="ValidationSummary" ClientInstanceName="ValidationSummary"
                                                                                        RenderMode="Table" Width="50%" ShowErrorAsLink="false">
                                                                                    </dx:ASPxValidationSummary>
                                                                                </div>
                                                                                <div class="contentFooter">
                                                                                    <p class="Note">
                                                                                        <b>Nota</b>: Tutti i file caricati con questo metodo verrano eliminati entro 5 minuti se non si conclude l'inserimento del ticket.
                                                                                    </p>
                                                                                </div>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                    </dx:LayoutItem>
                                                                </Items>
                                                            </dx:LayoutGroup>
                                                        </Items>
                                                    </dx:ASPxFormLayout>



                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ShowCaption="False" ColumnSpan="4">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>


                                                    <dx:ASPxButton ID="InserisciTicket_Btn" runat="server" AutoPostBack="false" BackColor="Green" RenderMode="Button" Text="Inserisci Ticket" Width="100" UseSubmitBehavior="false">
                                                        <ClientSideEvents Click="function(s, e) 
                        {
                        if(ASPxClientEdit.ValidateGroup('InserimentoTicket'))
                        {
                        InserimentoTicket_CallbackResponsive.PerformCallback();
                        ASPxCallbackPanel1.PerformCallback();
                        };
                    }" />
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionSettings VerticalAlign="Top" Location="Top" />
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                            </Items>
                            <Paddings Padding="0px"></Paddings>
                        </dx:ASPxFormLayout>
                    </div>
                    <dx:ASPxPopupControl ID="PopupControl" runat="server" ShowOnPageLoad="false" ClientInstanceName="TecniciModalResponsive" HeaderText="Associa Tecnico" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="CloseButton" ShowFooter="true">
                        <SettingsLoadingPanel Enabled="true" />
                        <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="12">
                            <Paddings Padding="0px" PaddingTop="12px"></Paddings>
                        </ContentStyle>
                        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="1200px" HorizontalAlign="WindowCenter" />
                        <ContentCollection>
                            <dx:PopupControlContentControl>
                                <div id="popupDivResponsive">
                                    <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Paddings-Padding="0">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="576" />
                                        <Items>
                                            <dx:LayoutGroup ColCount="3" Caption="">
                                                <SettingsItemCaptions Location="NoSet" />
                                                <Paddings Padding="0px" PaddingTop="0px"></Paddings>
                                                <GroupBoxStyle>
                                                    <Caption Font-Bold="true" Font-Size="16" CssClass="groupCaption" />
                                                </GroupBoxStyle>
                                                <Items>

                                                    <dx:LayoutItem Caption="tecnico:" ColumnSpan="3" Paddings-Padding="0">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:ASPxCheckBoxList ID="Tecnici_checkBoxList" ClientInstanceName="checkBoxList_TecniciResponsive" runat="server"
                                                                    RepeatColumns="3" RepeatLayout="table">

                                                                    <CaptionSettings Position="Top" />
                                                                    <ValidationSettings ValidationGroup="InserimentoTecnico" SetFocusOnError="True" ErrorDisplayMode="None">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                    <ClientSideEvents Validation="onNameValidation" />
                                                                    <InvalidStyle BackColor="LightPink" />
                                                                    <%-- <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />--%>
                                                                </dx:ASPxCheckBoxList>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings Location="Top" />

                                                        <Paddings Padding="0px"></Paddings>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem Caption="Note Tecnico" Width="100%" ColumnSpan="3">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:ASPxMemo runat="server" ID="txtNoteTecnico" Rows="6" ClientInstanceName="txtNoteTecnico">
                                                                    <%--<ValidationSettings ValidationGroup="InserimentoTecnico" SetFocusOnError="True" ErrorDisplayMode="None">
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                    <ClientSideEvents Validation="onNameValidation" />
                                                    <InvalidStyle BackColor="LightPink" />--%>
                                                                </dx:ASPxMemo>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings Location="Top" />
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem Caption="Pannello " Width="100%" ColumnSpan="3" ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer>
                                                                <dx:ASPxCheckBox ID="cbInviaCalendart" runat="server" ClientInstanceName="cbInviaCalendartResponsive" Text="Invia Calendar">
                                                                    <ClientSideEvents CheckedChanged="function(s, e) { PanelInviaCalendarResponsive.SetVisible(s.GetChecked()); }" />
                                                                </dx:ASPxCheckBox>

                                                                <dx:ASPxCallbackPanel ID="PanelInviaCalendar" runat="server" ClientInstanceName="PanelInviaCalendarResponsive" Width="100%"
                                                                    ClientVisible="false">
                                                                    <PanelCollection>
                                                                        <dx:PanelContent>
                                                                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" Width="100%" Paddings-Padding="0">
                                                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="576" />
                                                                                <Items>
                                                                                    <dx:LayoutGroup ColCount="3" Caption="" ColumnSpan="1">
                                                                                        <SettingsItemCaptions Location="NoSet" />
                                                                                        <Paddings Padding="0px" PaddingTop="0px"></Paddings>
                                                                                        <GroupBoxStyle>
                                                                                            <Caption Font-Bold="true" Font-Size="16" CssClass="groupCaption" />
                                                                                        </GroupBoxStyle>
                                                                                        <Items>
                                                                                            <dx:LayoutItem Caption="Data Intervento:" ColumnSpan="1">
                                                                                                <LayoutItemNestedControlCollection>
                                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                                        <dx:ASPxDateEdit runat="server" ID="txtDataIntervento" ClientInstanceName="txtDataInterventoResponsive">
                                                                                                            <ValidationSettings ValidationGroup="InserimentoTecnico" SetFocusOnError="True" ErrorDisplayMode="None">
                                                                                                                <RequiredField IsRequired="True" />
                                                                                                            </ValidationSettings>
                                                                                                            <ClientSideEvents Validation="onNameValidation" />
                                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                                            <%-- <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>--%>
                                                                                                            <%--  <ClientSideEvents Init="function (s, e) { ChangeType(s, 'date'); }" />--%>
                                                                                                        </dx:ASPxDateEdit>
                                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                                </LayoutItemNestedControlCollection>
                                                                                                <CaptionSettings Location="Top" />
                                                                                            </dx:LayoutItem>
                                                                                            <dx:LayoutItem Caption="Inzio Intervento:" ColumnSpan="1">
                                                                                                <LayoutItemNestedControlCollection>
                                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                                        <dx:ASPxTextBox ID="TxtOraInizio_insert" ClientInstanceName="TxtOraInizio_insertResponsive" runat="server" Native="true" CssClass="auto-style1" Width="100%">
                                                                                                            <%--                                                  <MaskSettings Mask="<00..23>:<00..59>" ErrorText="Please input missing digits" />--%>
                                                                                                            <ClientSideEvents Init="function (s, e) { ChangeType(s, 'time'); }" />
                                                                                                            <ValidationSettings ValidationGroup="InserimentoTecnico" SetFocusOnError="True" ErrorDisplayMode="None">
                                                                                                                <RequiredField IsRequired="True" />
                                                                                                            </ValidationSettings>
                                                                                                            <ClientSideEvents Validation="onNameValidation" />
                                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                                        </dx:ASPxTextBox>
                                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                                </LayoutItemNestedControlCollection>
                                                                                                <CaptionSettings Location="Top" />
                                                                                            </dx:LayoutItem>
                                                                                            <dx:LayoutItem Caption="Fine Intervento:" ColumnSpan="1">
                                                                                                <LayoutItemNestedControlCollection>
                                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                                        <dx:ASPxTextBox ID="TxtOraFine_insert" ClientInstanceName="TxtOraFine_insertResponsive" runat="server" Native="true" Width="100%">
                                                                                                            <ClientSideEvents Init="function (s, e) { ChangeType(s, 'time'); }" />
                                                                                                            <ValidationSettings ValidationGroup="InserimentoTecnico" SetFocusOnError="True" ErrorDisplayMode="None">
                                                                                                                <RequiredField IsRequired="True" />
                                                                                                            </ValidationSettings>
                                                                                                            <ClientSideEvents Validation="TimeValidation" />
                                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                                        </dx:ASPxTextBox>
                                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                                </LayoutItemNestedControlCollection>
                                                                                                <CaptionSettings Location="Top" />
                                                                                            </dx:LayoutItem>
                                                                                        </Items>
                                                                                    </dx:LayoutGroup>
                                                                                </Items>

                                                                                <Paddings Padding="0px"></Paddings>
                                                                            </dx:ASPxFormLayout>
                                                                        </dx:PanelContent>
                                                                    </PanelCollection>
                                                                </dx:ASPxCallbackPanel>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionSettings Location="Top" />
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>
                                        </Items>

                                        <Paddings Padding="0px"></Paddings>
                                    </dx:ASPxFormLayout>
                                </div>
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                        <FooterTemplate>
                            <dx:ASPxFormLayout runat="server" ID="footerFormLayout" Width="100%" CssClass="clearPaddings">
                                <Styles LayoutItem-CssClass="clearPaddings" LayoutGroup-CssClass="clearPaddings" />
                                <Items>
                                    <dx:LayoutGroup GroupBoxDecoration="None">
                                        <Paddings Padding="0" PaddingBottom="10" />
                                        <Items>
                                            <dx:LayoutItem ShowCaption="False">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <div class="buttonsContainer">
                                                            <dx:ASPxButton ID="btnSubmit" runat="server" CssClass="submitButton" Text="Conferma" Width="100" AutoPostBack="false" UseSubmitBehavior="false">
                                                                <ClientSideEvents Click="function(s, e) 
                                        {
                                        if(ASPxClientEdit.ValidateGroup('InserimentoTecnico')){ GetTecniciSelectedResponsive();
                                                TecniciModalResponsive.Hide();
                                                console.log(cbInviaCalendartResponsive.GetChecked());
                                               
                                                 if (typeof Dashboard_CallbackPnl !== 'undefined' && ASPxClientUtils.IsExists(Dashboard_CallbackPnl)) {
      Dashboard_CallbackPnl.PerformCallback();} }

                                               
                                    }" />
                                                            </dx:ASPxButton>
                                                            <dx:ASPxButton ID="btnCancel" runat="server" CssClass="cancelButton" Text="Annulla" AutoPostBack="false" Width="100" UseSubmitBehavior="false">
                                                                <%--    <ClientSideEvents Click="onBtnCancelClick" />--%>
                                                                <ClientSideEvents Click="function(s, e) {GetTecniciSelectedResponsive();
	                                                ASPxClientEdit.ClearEditorsInContainer(document.getElementById('popupDiv')); 
                                                    PanelInviaCalendarResponsive.SetVisible(false);                                                  
                                                    TecniciModalResponsive.Hide();
                                                
                                                 if (typeof Dashboard_CallbackPnl !== 'undefined' && ASPxClientUtils.IsExists(Dashboard_CallbackPnl)) {
      Dashboard_CallbackPnl.PerformCallback();}
                                                    }" />
                                                            </dx:ASPxButton>
                                                        </div>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>
                        </FooterTemplate>
                    </dx:ASPxPopupControl>



                    <dx:ASPxPopupControl ID="UltimoTicket_Popup" ContentStyle-Paddings-Padding="0" ContentStyle-HorizontalAlign="Center" runat="server" Width="100%" ShowOnPageLoad="false" ClientInstanceName="UltimoTicket_PopupResponsive" HeaderText="Ultimo Ticket Inserito" AutoUpdatePosition="true" CloseOnEscape="false" CloseAction="OuterMouseClick" ShowFooter="false">
                        <ContentStyle Paddings-Padding="0" Paddings-PaddingTop="0">
                            <Paddings Padding="0px" PaddingTop="0"></Paddings>
                        </ContentStyle>
                        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="700px" HorizontalAlign="WindowCenter" />
                        <ContentCollection>
                            <dx:PopupControlContentControl>
                                <dx:ASPxLabel ID="NuovoTicketInfo_Lbl" runat="server" ClientInstanceName="NuovoTicketInfo_LblResponsive" Font-Size="XX-Large"></dx:ASPxLabel>
                                <br />
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="VAI AL TICKET" AutoPostBack="false" UseSubmitBehavior="false">
                                    <ClientSideEvents Click="function(s,e)
                    {
                    location.href = InserimentoTicket_CallbackResponsive.cpUrlTicketJS;
                    }" />
                                </dx:ASPxButton>
                            </dx:PopupControlContentControl>
                        </ContentCollection>
                    </dx:ASPxPopupControl>
                    <%--<asp:SqlDataSource ID="UltimoTicket_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4superadminConnectionString %>' SelectCommand="SELECT TOP (1) CodRapportino, Società, InsertUser, OggettoTCK FROM TCK_TestataTicket ORDER BY CodRapportino DESC"></asp:SqlDataSource>--%>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxCallback ID="InserimentoTicket_Callback" runat="server" ClientInstanceName="InserimentoTicket_CallbackResponsive" OnCallback="InserimentoTicket_Callback_Callback">
        <ClientSideEvents BeginCallback="function(s,e){InserimentoTck_LoadingPnlResponsive.Show();}"
            CallbackComplete="function(s,e){
        checkBoxList_TecniciResponsive.UnselectAll();
        CancellazioneFile_CallbackResponsive.PerformCallback();
         InserimentoTck_LoadingPnlResponsive.Hide(); 
        
         showNotification();
         UltimoTicket_PopupResponsive.Show();
       NuovoTicketInfo_LblResponsive.SetText(InserimentoTicket_CallbackResponsive.cpComposizioneTicket);
        }" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="CancellazioneFile_Callback" ClientInstanceName="CancellazioneFile_CallbackResponsive" runat="server" OnCallback="CancellazioneFile_Callback_Callback"></dx:ASPxCallback>
    <%--<asp:SqlDataSource ID="DtsTestataRapp" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
    SelectCommand="SELECT Societa, Denom, Ind, Cap, Prov, Loc, Tel, Fax, Riferim, PIva, EMail FROM Clienti WHERE (CodCli = @CodCli)">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="CodCli" QueryStringField="codCli"
            Type="String" />
    </SelectParameters>
</asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="DtsTCK_TipoRichiesta" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Id, Descrizione, DisplayOrder, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl FROM TCK_TipoRichiesta order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_TipoEsecuzione" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Id, Descrizione, DisplayOrder, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl FROM TCK_TipoEsecuzione order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_AreaCompetenza" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT [Descrizione], [DisplayOrder], [LabelClass], [IdAreaAss], '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl  FROM [TCK_AreaCompetenza] order by DisplayOrder"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DtsTCK_PrioritaRichiesta" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT Descrizione, DisplayOrder, LabelClass, Id, '~/img/DevExButton/'+Descrizione+'.png' as ImageUrl  FROM TCK_PrioritaRichiesta ORDER BY DisplayOrder"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
