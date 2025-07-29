<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contratto_Report.aspx.cs" Inherits="INTRA.Stats.Contratto_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">description</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Genera Report</h4>
                    <dx:ASPxCallbackPanel runat="server" ID="FiltroContratto_CallbackPnl" ClientInstanceName="FiltroContratto_CallbackPnl" Width="100%" OnCallback="FiltroContratto_CallbackPnl_Callback">
                        <SettingsLoadingPanel Enabled="false" />
                        <ClientSideEvents EndCallback="function(s,e){ }" />
                        <PanelCollection>
                            <dx:PanelContent>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">
                                        <div class="col-lg-12">
                                            <div class="col-lg-6 col-md-6">
                                                <label class="label-control">
                                                    <asp:Literal runat="server" Text="Cliente" />*:</label>
                                                <dx:ASPxComboBox ID="Cliente_Combobox" ClientInstanceName="Cliente_Combobox" runat="server" TextField="Denom" ValueField="CodCli" ValueType="System.String" DataSourceID="Clienti_Dts" DisplayFormatString="{0}" Width="100%">
                                                    <ClientSideEvents SelectedIndexChanged="function(s,e){Contratti_CallbackPnl.PerformCallback();Label_Callbackpnl.PerformCallback();}" />
                                                    <Columns>
                                                        <dx:ListBoxColumn FieldName="Denom"></dx:ListBoxColumn>
                                                        <dx:ListBoxColumn FieldName="CodCli" Width="50px"></dx:ListBoxColumn>

                                                    </Columns>

                                                    <ValidationSettings ValidationGroup="InsertValidation" ErrorDisplayMode="ImageWithTooltip">
                                                        <RequiredField IsRequired="true" />
                                                    </ValidationSettings>
                                                    <SettingsLoadingPanel Enabled="false" />
                                                </dx:ASPxComboBox>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <label class="label-control">
                                                    <asp:Literal runat="server" Text="Contratti"></asp:Literal>*:</label>
                                                <dx:ASPxCallbackPanel runat="server" ID="Contratti_CallbackPnl" ClientInstanceName="Contratti_CallbackPnl" OnCallback="Contratti_CallbackPnl_Callback" Width="100%">
                                                    <PanelCollection>
                                                        <dx:PanelContent>
                                                            <dx:ASPxComboBox runat="server" ID="Contratti_Combobox" ClientInstanceName="Contratti_Combobox" DataSourceID="Contratti_Sql" TextField="Descrizione" ValueField="IdProdotto" DisplayFormatString="{0}" Width="100%">
                                                                <ClientSideEvents SelectedIndexChanged="function(s,e){Label_Callbackpnl.PerformCallback();}" />
                                                                <Columns>
                                                                    <dx:ListBoxColumn FieldName="IdProdotto" Width="150"></dx:ListBoxColumn>

                                                                    <dx:ListBoxColumn FieldName="Totale" Width="50"></dx:ListBoxColumn>
                                                                    <dx:ListBoxColumn FieldName="Totinterventi" Caption="Tot Interventi" Width="50"></dx:ListBoxColumn>
                                                                    <dx:ListBoxColumn FieldName="ResiduoOre" Width="50"></dx:ListBoxColumn>
                                                                    <dx:ListBoxColumn FieldName="Descrizione"></dx:ListBoxColumn>
                                                                </Columns>
                                                                <ValidationSettings ValidationGroup="InsertValidation" ErrorDisplayMode="ImageWithTooltip">
                                                                    <RequiredField IsRequired="true" />
                                                                </ValidationSettings>
                                                                <SettingsLoadingPanel Enabled="false" />
                                                            </dx:ASPxComboBox>

                                                        </dx:PanelContent>
                                                    </PanelCollection>
                                                    <SettingsLoadingPanel Enabled="false" />
                                                </dx:ASPxCallbackPanel>
                                            </div>
                                        </div>




                                        <dx:ASPxCallbackPanel runat="server" ID="Label_Callbackpnl" ClientInstanceName="Label_Callbackpnl" OnCallback="Label_Callbackpnl_Callback" Width="100%">
                                            <SettingsLoadingPanel Enabled="false" />
                                            <ClientSideEvents EndCallback="function(s,e){ }" />
                                            <PanelCollection>
                                                <dx:PanelContent>
                                                    <div class="col-lg-12">
                                                        <div class="col-lg-3 col-md-3 col-xs-6">
                                                            <h5>
                                                                <asp:Literal runat="server" Text="Tipo Contratto" />:                                                                   
                                     <dx:ASPxLabel runat="server" ID="TipoContr_Lbl" ClientInstanceName="TipoContr_Lbl" Font-Size="Large" ForeColor="Red" Text="?"></dx:ASPxLabel>
                                                            </h5>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-xs-6">
                                                            <h5>
                                                                <asp:Literal runat="server" Text="Totale Contratto" />:                                                                   
                                     <dx:ASPxLabel runat="server" ID="TotaleContr_Lbl" ClientInstanceName="TotaleContr_Lbl" Font-Size="Large" ForeColor="Red" Text="?"></dx:ASPxLabel>
                                                            </h5>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-xs-6">
                                                            <h5>Totale Interventi                                                                  
                                     <dx:ASPxLabel runat="server" ID="Totinterventi_Lbl" ClientInstanceName="Totinterventi_Lbl" Font-Size="Large" ForeColor="Green" Text="?"></dx:ASPxLabel>
                                                            </h5>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-xs-6">
                                                            <h5>Residuo Ore                                                                   
                                     <dx:ASPxLabel runat="server" ID="ResiduoOre_Lbl" ClientInstanceName="ResiduoOre_Lbl" Font-Size="Large" ForeColor="Green" Text="?"></dx:ASPxLabel>
                                                            </h5>
                                                        </div>
                                                    </div>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                        <div class="col-lg-12">
                                            <div class="col-lg-3 col-md-3">
                                                <%-- <label class="label-control">
                                 <asp:Literal runat="server" Text="Periodo Da" />*:</label>
                             <dx:BootstrapDateEdit ID="Scadenza_Date_Da" ClientInstanceName="Scadenza_Date" runat="server" Width="100%" >
                                 <ValidationSettings ValidationGroup="InsertValidation">
                                     <RequiredField IsRequired="true" />
                                 </ValidationSettings>
                             </dx:BootstrapDateEdit>--%>
                                            </div>
                                            <div class="col-lg-3 col-md-3">
                                                <%--<label class="label-control">
                                 <asp:Literal runat="server" Text="Periodo A" />*:</label>
                             <dx:BootstrapDateEdit ID="Scadenza_Date_A" ClientInstanceName="Scadenza_Date_A" runat="server" Width="100%" DateRangeSettings-StartDateEditID="Scadenza_Date_Da">
                                 <ValidationSettings ValidationGroup="InsertValidation">
                                     <RequiredField IsRequired="true" />
                                 </ValidationSettings>
                             </dx:BootstrapDateEdit>--%>
                                            </div>

                                            <div class="col-lg-3 col-md-3" style="line-height: 60px">

                                                <asp:LinkButton ID="StampaReport" runat="server" OnClientClick="return false;" UseSubmitBehavior="false">
                                                    <dx:ASPxImage ID="StampaRpt_Img" runat="server" ImageUrl="~/img/DevExButton/print.png" Width="30px" ToolTip="Stampa offerta"></dx:ASPxImage>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="Contratti_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Denom, CodCli, IdProdotto, Totale, Totinterventi, ResiduoOre, U_CC, DataCar, U_Carnet, U_ContrattoHWSW, U_Print, U_TotOreContratto, U_Tipo_Assistenza, DescrTipoAssistenza, ContM, Descrizione FROM U_Carnet_Contratti_View_Intra WHERE CodCli= @CodCliSelezionato ORDER BY  DataCar desc">
        <SelectParameters>
            <asp:SessionParameter SessionField="CodCliSelezionatoSession" Name="CodCliSelezionato"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Clienti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodCli, Denom FROM Clienti WHERE (FlagAnnullo = 0) ORDER BY Denom"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT Denom, CodCliente, IDProdotto, Totale, Totinterventi, ResiduoOre, U_CC, DataCar FROM U_CarnetAttivi_KING_View ORDER BY ResiduoOre"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script type="text/javascript">
    function apriReport() {
        if (!ASPxClientEdit.ValidateGroup('InsertValidation')) return;

        var codCli = Cliente_Combobox.GetValue();
        var idContratto = Contratti_Combobox.GetValue();

        if (!codCli || !idContratto) return;

        var url = '/stats/Contratto_Report_Preview.aspx?CodCli=' + encodeURIComponent(codCli) + '&IdContratto=' + encodeURIComponent(idContratto);
        window.open(url, '_blank');
    }

    // Bind manuale al click immagine
    window.onload = function () {
        var stampaBtn = document.getElementById('<%= StampaRpt_Img.ClientID %>');
        if (stampaBtn) {
            stampaBtn.style.cursor = "pointer";
            stampaBtn.onclick = function () {
                apriReport();
                return false;
            };
        }
    };
    </script>

</asp:Content>
