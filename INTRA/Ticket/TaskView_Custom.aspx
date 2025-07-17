<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="TaskView_Custom.aspx.cs" Inherits="INTRA.Ticket.TaskView_Custom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
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
    <dx:ASPxGridView ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" runat="server" DataSourceID="Generic_Sql" Width="100%" AutoGenerateColumns="False" KeyFieldName="CodRapportino">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CodRapportino" ReadOnly="True" VisibleIndex="0">
                <EditFormSettings Visible="False"></EditFormSettings>
            </dx:GridViewDataTextColumn>

        </Columns>
        <Settings ShowColumnHeaders="false" />
        <Templates>
            <DataRow>
                <h2 style="padding-left: 20px; font-size: 36.4px; font-family: Roboto,Arial, Helvetica, sans-serif">Richiesta assistenza N° <%# Eval("CodRapportino") %><br />
                    <br />
                </h2>

                <div class="row">
                    <div class="col-lg-12 ticket-section">
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Ticket N°:</span>
                            <span class="ticket-value"><%# Eval("CodRapportino") %></span>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Data richiesta:</span>
                            <span class="ticket-value"><%# Eval("CreatedOn") %></span>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Cliente:</span>
                            <span class="ticket-value"><%# Eval("Società") %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section">
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Nome di riferimento:</span>
                            <span class="ticket-value"><%# Eval("NomePersonaRiferimento") %></span>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Telefono di riferimento:</span>
                            <span class="ticket-value"><%# HiddenTelChar(Eval("TelPersonaRiferimento")) %></span>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Email di riferimento:</span>
                            <span class="ticket-value"><%# HiddenEmailChar(Eval("MailPersonaRiferimento")) %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section">
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Area competenza:</span>
                            <span class="ticket-value"><%# Eval("AreaCompetenza") %></span>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-6 col-sm-12">
                            <span class="ticket-label">Status:</span>
                            <span class='<%# Eval("LabelClass") %> status-label'><%# Eval("Status") %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <span class="ticket-label">Eseguito:</span>
                            <span class="ticket-value"><%# Eval("Eseguito") %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section" style="border-top: 1px solid #eceaea;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <span class="ticket-label">Oggetto:</span>
                            <span class="ticket-value"><%# Eval("OggettoTCK") %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section" style="border-top: 1px solid #eceaea;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <span class="ticket-label">Motivo chiamata:</span>
                            <span class="ticket-value">
                                <%# Eval("MotivoChiamata") %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section" style="border-top: 1px solid #eceaea;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <span class="ticket-label">Lavoro eseguito:</span>
                            <span class="ticket-value">
                                <%# Eval("LavoroEseguito") %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section" style="border-top: 1px solid #eceaea;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <span class="ticket-label">Tecnici:</span>
                            <span class="ticket-value">
                                <%# Eval("NameValues") %></span>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section" style="border-top: 1px solid #eceaea;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <a href="javascript: Allegati_Popup.Show();">
                                <dx:ASPxImage runat="server"
                                    ClientVisible='<%# Eval("CountAllegati") == DBNull.Value ? false : true %>'
                                    ImageUrl="../img/DevExButton/attach.png"
                                    Width="30px"
                                    ToolTip="Allegati" />
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-12 ticket-section" style="border-top: 1px solid #eceaea;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <a href="TCK_List.aspx">Ritorna alla lista dei ticket</a>
                        </div>
                    </div>
                </div>
            </DataRow>
        </Templates>

    </dx:ASPxGridView>

    <dx:ASPxPopupControl ID="Allegati_Popup" HeaderText="Allegati ticket" ClientInstanceName="Allegati_Popup" runat="server" Modal="true" CloseAction="CloseButton" Width="1200px" Height="1000px" AutoUpdatePosition="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides">
        <ClientSideEvents Shown="function(s,e){DocumentiView_CallbackPnl.PerformCallback(0)}" />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="col-lg-4 col-md-4 col-xs-12 col-sm-12">
                            <dx:ASPxGridView ID="Allegati_grw" ClientInstanceName="Allegati_grw" runat="server" Width="100%" DataSourceID="Allegati_Dts" AutoGenerateColumns="False" KeyFieldName="ID">
                                <Settings ShowColumnHeaders="false" />
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IDTicket" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
                                        <EditFormSettings Visible="False"></EditFormSettings>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PathFolder" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DisplayName" VisibleIndex="3"></dx:GridViewDataTextColumn>

                                </Columns>
                                <Templates>
                                    <DataRow>
                                        <div class="table-responsive table-sales" style="padding: 0; margin: 0">
                                            <table class="table">
                                                <tbody>
                                                    <tr style="padding: 0; margin: 0; padding-top: 5px; height: 60px; border-bottom: 1px solid #eceaea">
                                                        <td style="padding-top: 0; padding-left: 10px; padding-bottom: 0; text-align: left !important">
                                                            <%# Eval("DisplayName") %>
                                                        </td>
                                                        <td class="text-right" style="padding-top: 0; padding-bottom: 0">
                                                            <a href='javascript: DocumentiView_CallbackPnl.PerformCallback(<%# Eval("ID") %>)'>
                                                                <img src="../img/DevExButton/preview.png" width="30" />
                                                            </a>

                                                            <a href='<%# Eval("PathFolder") %>' download>
                                                                <img src="../img/DevExButton/print.png" width="30" />
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </DataRow>
                                </Templates>
                            </dx:ASPxGridView>
                        </div>
                        <div class="col-lg-8 col-md-8 col-xs-12 col-sm-12">
                            <div class="table-responsive table-sales" style="padding: 0; margin: 0">
                                <dx:ASPxCallbackPanel ID="DocumentiView_CallbackPnl" ClientInstanceName="DocumentiView_CallbackPnl" runat="server" Width="100%" OnCallback="DocumentiView_CallbackPnl_Callback">
                                    <PanelCollection>
                                        <dx:PanelContent>
                                            <iframe id="iframe1" runat="server" height="600" style="width: 100%"></iframe>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </div>
                        </div>
                    </div>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <asp:SqlDataSource runat="server" ID="Allegati_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT IDTicket, ID, PathFolder, DisplayName FROM PRT_DocumentiTCK WHERE (IDTicket = @IdTicket)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="IdTicket" Name="IdTicket"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT t.CodRapportino, t.CreatedOn, t.OggettoTCK, s.Descrizione AS Status, s.LabelClass, t.MailPersonaRiferimento, t.Società, t.MotivoChiamata, t.LavoroEseguito, v.NameValues, a.Descrizione AS AreaCompetenza, e.Descrizione AS Eseguito, t.NomePersonaRiferimento, t.TelPersonaRiferimento, d.CountAllegati FROM INFO4U_INTRA_2021.dbo.TCK_TestataTicket t INNER JOIN INFO4U_INTRA_2021.dbo.TCK_AreaCompetenza a ON t.TCK_AreaCompetenza = a.IdAreaAss INNER JOIN INFO4U_INTRA_2021.dbo.TCK_TipoEsecuzione e ON t.TCK_TipoEsecuzione = e.Id LEFT OUTER JOIN (SELECT COUNT(ID) AS CountAllegati, IDTicket FROM INFO4U_INTRA_2021.dbo.PRT_DocumentiTCK GROUP BY IDTicket) d ON t.CodRapportino = d.IDTicket LEFT OUTER JOIN INFO4U_INTRA_2021.dbo.TCK_TecniciVsTicket_View v ON t.CodRapportino = v.CodRapportino LEFT OUTER JOIN INFO4U_INTRA_2021.dbo.TCK_StatusChiamata s ON t.TCK_StatusChiamataChiusura = s.Id WHERE t.CodCli LIKE @CodCli AND t.CodRapportino = @CodRapportino">
        <SelectParameters>
            <asp:Parameter Name="CodCli"></asp:Parameter>
            <asp:QueryStringParameter QueryStringField="IdTicket" Name="CodRapportino"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .dxgvTable_Office365 {
            border: none;
        }

@media (max-width: 992px) {
    .ticket-section {
        border-top: none !important;
        margin-bottom: 15px;
        padding-top: 10px;
    }

    .ticket-label {
        font-size: 16px;
    }

    .ticket-value {
        font-size: 15px;
        word-wrap: break-word;
    }

    h2 {
        font-size: 28px !important;
        padding-left: 10px !important;
    }
}

        .ticket-section {
            margin-bottom: 20px;
        }

        .ticket-label {
            font-weight: bold;
            font-size: 14px;
            margin-bottom: 5px;
            display: block;
        }

        .status-label {
            display: inline-block;
            padding: 4px 10px;
            font-size: 12px;
            font-weight: bold;
            color: white;
            border-radius: 5px;
            text-transform: uppercase;
        }

        .label-green {
            background-color: #74c476;
        }

        .label-orange {
            background-color: #ff9800;
        }

        .label-red {
            background-color: #f44336;
        }

        .label-azure, .badge-azure {
            background-color: #2dc3e8;
            background-image: none !important;
        }

            .label-azure.graded, .badge-azure.graded {
                background: linear-gradient(to right,#2dc3e8,#5edfff) !important;
            }

        .label-blueberry, .badge-blueberry {
            background-color: #6f85bf;
            background-image: none !important;
        }

            .label-blueberry.graded, .badge-blueberry.graded {
                background: linear-gradient(to right,#6f85bf,#ced5e9) !important;
            }

        .label-palegreen, .badge-palegreen {
            background-color: #a0d468;
            background-image: none !important;
        }

            .label-palegreen.graded, .badge-palegreen.graded {
                background: linear-gradient(to right,#a0d468,#c5e9b6) !important;
            }

        .label-success, .badge-success {
            background-color: #53a93f;
            background-image: none !important;
        }

            .label-success.graded, .badge-success.graded {
                background: linear-gradient(to right,#53a93f,#b0e0a4) !important;
            }

        .label-green, .badge-green {
            background-color: #8cc474;
            background-image: none !important;
        }

            .label-green.graded, .badge-green.graded {
                background: linear-gradient(to right,#8cc474,#a0d468) !important;
            }

        .label-lightyellow, .badge-lightyellow {
            background-color: #f6d52e;
            background-image: none !important;
        }

            .label-lightyellow.graded, .badge-lightyellow.graded {
                background: linear-gradient(to right,#f6d52e,#f8e26d) !important;
            }

        .label-yellow, .badge-yellow {
            background-color: #ffce55;
            background-image: none !important;
        }

            .label-yellow.graded, .badge-yellow.graded {
                background: linear-gradient(to right,#ffce55,#f6d52e) !important;
            }

        .label-grey, .badge-grey {
            background-color: #808080;
            background-image: none !important;
        }

        .label-warning, .badge-warning {
            background-color: #f4b400;
            background-image: none !important;
        }

            .label-warning.graded, .badge-warning.graded {
                background: linear-gradient(to right,#f4b400,#f8df95) !important;
            }

        .label-gold, .badge-gold {
            background-color: #f9b256;
            background-image: none !important;
        }

            .label-gold.graded, .badge-gold.graded {
                background: linear-gradient(to right,#f9b256,#fece90) !important;
            }

        .label-orange, .badge-orange {
            background-color: #fb6e52;
            background-image: none !important;
        }

            .label-orange.graded, .badge-orange.graded {
                background: linear-gradient(to right,#fb6e52,#fb9f8d) !important;
            }

        .label-lightred, .badge-lightred {
            background-color: #e46f61;
            background-image: none !important;
        }

            .label-lightred.graded, .badge-lightred.graded {
                background: linear-gradient(to right,#e46f61,#f88f83) !important;
            }

        .label-darkorange, .badge-darkorange {
            background-color: #ed4e2a;
            background-image: none !important;
        }

            .label-darkorange.graded, .badge-darkorange.graded {
                background: linear-gradient(to right,#ed4e2a,#f5a998) !important;
            }

        .label-red, .badge-red {
            background-color: #df5138;
            background-image: none !important;
        }

            .label-red.graded, .badge-red.graded {
                background: linear-gradient(to right,#df5138,#f5836f) !important;
            }

        .label-pink, .badge-pink {
            background-color: #e75b8d;
            background-image: none !important;
        }

            .label-pink.graded, .badge-pink.graded {
                background: linear-gradient(to right,#e75b8d,#f299b9) !important;
            }

        .label-darkpink, .badge-darkpink {
            background-color: #cc324b;
            background-image: none !important;
        }

            .label-darkpink.graded, .badge-darkpink.graded {
                background: linear-gradient(to right,#cc324b,#fb6880) !important;
            }

        .label-danger, .badge-danger {
            background-color: #d73d32;
            background-image: none !important;
        }

            .label-danger.graded, .badge-danger.graded {
                background: linear-gradient(to right,#d73d32,#f7b5b0) !important;
            }

        .label-magenta, .badge-magenta {
            background-color: #bc5679;
            background-image: none !important;
        }

            .label-magenta.graded, .badge-magenta.graded {
                background: linear-gradient(to right,#bc5679,#e9abc0) !important;
            }

        .label-purple, .badge-purple {
            background-color: #7e3794;
            background-image: none !important;
        }

            .label-purple.graded, .badge-purple.graded {
                background: linear-gradient(to right,#7e3794,#daafe8) !important;
            }

        .label-maroon, .badge-maroon {
            background-color: #981b48;
            background-image: none !important;
        }

            .label-maroon.graded, .badge-maroon.graded {
                background: linear-gradient(to right,#981b48,#eab6c9) !important;
            }
    </style>
</asp:Content>
