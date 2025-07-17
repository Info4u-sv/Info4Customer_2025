<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Parametri_WebConfig.aspx.cs" Inherits="INTRA.SuperAdmin.Parametri.Parametri_WebConfig" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div id="InfoArea" class="col-md-12 no-padding" style="padding: 0; padding-right: 2px">
        <div class="card">
            <div class="card-header card-header-icon " data-background-color="blue">
                <i class="material-icons">build</i>
            </div>
            <div class="card-content">
                <h4 class="card-title">Attività  
                                     
                </h4>


                <div class="card">
                    <div class="card-content">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-xs-12">
                                <dx:ASPxCallbackPanel runat="server" ID="WebConfig_CallbackPnl" ClientInstanceName="WebConfig_CallbackPnl" Width="100%" OnCallback="WebConfig_CallbackPnl_Callback">
                                    <ClientSideEvents EndCallback="showNotification" />
                                    <PanelCollection>
                                        <dx:PanelContent>
                                            <div class="col-lg-6 col-md-6 col-xs-6">
                                                <label class="label-control">Parametro:</label>
                                                <div class="controls">
                                                    <dx:ASPxComboBox ID="WebConfig_Combobox" ClientInstanceName="WebConfig_Combobox" runat="server" ValueType="System.String" Width="100%" >
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){WebConfig_Textbox.SetText(s.GetValue());}" />
                                                    </dx:ASPxComboBox>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-xs-6">
                                                <label class="label-control">Valore:</label>
                                                <div class="controls">
                                                    <dx:BootstrapTextBox runat="server" ID="WebConfig_Textbox" ClientInstanceName="WebConfig_Textbox"></dx:BootstrapTextBox>
                                                </div>
                                            </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                            <div class="col-lg-12 col-md-12 col-xs-12">
                                <div style="float: right">
                                    <dx:BootstrapButton runat="server" AutoPostBack="false" ID="Salva_Btn">
                                        <Badge Text="Salva" />
                                        <ClientSideEvents Click="function(s,e){WebConfig_CallbackPnl.PerformCallback();}" />
                                    </dx:BootstrapButton>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

