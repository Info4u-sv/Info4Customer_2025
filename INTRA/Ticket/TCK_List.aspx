<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="TCK_List.aspx.cs" Inherits="INTRA.Ticket.TCK_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <dx:ASPxGridView ID="Generic_Gridview" Settings-ShowHeaderFilterButton="true" SettingsBehavior-AllowFocusedRow="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Generic_Gridview" runat="server" DataSourceID="Generic_Sql" Width="100%" AutoGenerateColumns="False" KeyFieldName="CodRapportino">
        <Toolbars>
            <dx:GridViewToolbar>
                <Items>
                    <dx:GridViewToolbarItem Alignment="left">
                        <Template>
                            <dx:ASPxButtonEdit ID="tbToolbarSearch_Att" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                <Buttons>
                                    <dx:ClearButton DisplayMode="Always" Position="Right"></dx:ClearButton>
                                    <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                </Buttons>
                            </dx:ASPxButtonEdit>
                        </Template>
                    </dx:GridViewToolbarItem>

                    <dx:GridViewToolbarItem Command="ShowCustomizationDialog" Text="Filtro Avanzato" />
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>
        <SettingsSearchPanel CustomEditorID="tbToolbarSearch_Att" />
        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" Landscape="true" LeftMargin="30" FileName="TicketList" />
        <SettingsCustomizationDialog Enabled="true" />
        <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="1080" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="1">
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
        <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Cell-Paddings-PaddingBottom="1%" Cell-Paddings-PaddingTop="1%" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
        <SettingsPopup>
            <EditForm AllowResize="True" SettingsAdaptivity-Mode="Always" Modal="True" HorizontalAlign="Center" SettingsAdaptivity-HorizontalAlign="WindowCenter" VerticalAlign="Above" SettingsAdaptivity-VerticalAlign="WindowTop"></EditForm>
        </SettingsPopup>
        <Settings ShowFilterRow="True" />
        <SettingsCommandButton RenderMode="Image">
            <ClearFilterButton RenderMode="Image">
                <Image Url="../img/DevExButton/clear.png" Width="25px" ToolTip="Svuota ricerche" />
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
                <Image Url="../img/DevExButton/new.png" Width="30px" ToolTip="Nuovo" />
            </NewButton>
        </SettingsCommandButton>
        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>

        <SettingsSearchPanel Visible="false" />
        <Styles>
            <AdaptiveHeaderPanel CssClass="adaptiveHiddenCaption"></AdaptiveHeaderPanel>
        </Styles>
        <Columns>
            <dx:GridViewDataColumn VisibleIndex="0" HeaderStyle-Wrap="True" AdaptivePriority="1" Width="40px" SettingsHeaderFilter-DateRangeCalendarSettings-ShowClearButton="true">
                <DataItemTemplate>
                    <div>
                        <a href='TaskView_Custom.aspx?IdTicket=<%# Eval("CodRapportino") %>' class="btn btn-primary btn-sm" role="button" style="padding: 5px 8px;">
                            <i class="bi bi-arrow-right" style="color:white!important"></i>
                        </a>
                </DataItemTemplate>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn FieldName="CodRapportino" Caption="Cod. Tck." VisibleIndex="1" HeaderStyle-Wrap="True" AdaptivePriority="1" Width="50px">
            </dx:GridViewDataColumn>
            <dx:GridViewDataTextColumn FieldName="OggettoTCK" VisibleIndex="2" HeaderStyle-Wrap="True" AdaptivePriority="1">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataDateColumn FieldName="CreatedOn" Caption="Inserito il" VisibleIndex="3" HeaderStyle-Wrap="True" PropertiesDateEdit-DisplayFormatString="G" AdaptivePriority="1" Width="150px">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="InsertUser" Caption="Creato da" VisibleIndex="4" HeaderStyle-Wrap="True" AdaptivePriority="1" Width="100px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Descrizione" Caption="Area" VisibleIndex="5" HeaderStyle-Wrap="True" AdaptivePriority="1" Width="100px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataColumn FieldName="Status" VisibleIndex="6" HeaderStyle-Wrap="True" Width="100px">
                <DataItemTemplate>
                    <h5>
                        <label class='<%# Eval("LabelClass") %> label'><%# Eval("Expr1") %></label></h5>
                </DataItemTemplate>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn Name="Resp" Caption="." Width="0" VisibleIndex="40">
                <HeaderStyle CssClass="hidden-large" />
                <CellStyle CssClass="hidden-large"></CellStyle>
                <FilterCellStyle CssClass="hidden-large" />
                <FooterCellStyle CssClass="hidden-large" />
                <GroupFooterCellStyle CssClass="hidden-large" />
                <DataItemTemplate>
                    <div class="dxgvAdaptiveDetailCell_Office365">

                        <a href='TaskView_Custom.aspx?IdTicket=<%# Eval("CodRapportino") %>' class="btn btn-primary btn-sm">
                            <i class="bi bi-arrow-right"></i>
                        </a>

                        <div class="info-ticket">
                            <strong><%# Eval("OggettoTCK") %></strong>
                            <strong><%# Eval("CreatedOn", "{0:d}") %> - <%# Eval("InsertUser") %></strong>
                            <strong><%# Eval("Descrizione") %></strong>
                        </div>

                        <label class='<%# Eval("LabelClass") %> label status-label'>
                            <%# Eval("Expr1") %>
                        </label>

                    </div>
                </DataItemTemplate>
            </dx:GridViewDataColumn>
        </Columns>
        <SettingsPopup EditForm-SettingsAdaptivity-MaxWidth="1400px" EditForm-Width="1400px"></SettingsPopup>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT TCK_TestataTicket.CodRapportino, TCK_TestataTicket.CodCli, TCK_TestataTicket.Società, TCK_TestataTicket.PIva, TCK_TestataTicket.Indirizzo, TCK_TestataTicket.Cap, TCK_TestataTicket.Località, TCK_TestataTicket.Provincia, TCK_TestataTicket.Telefono, TCK_TestataTicket.Fax, TCK_TestataTicket.Email, TCK_TestataTicket.Matricola, TCK_TestataTicket.Scala, TCK_TestataTicket.TipoImpianto, TCK_TestataTicket.PersonaDaContattare, TCK_TestataTicket.TipoChiamata, TCK_TestataTicket.AreaAss, TCK_TestataTicket.MotivoChiamata, TCK_TestataTicket.NoteTecnico, TCK_TestataTicket.Note, TCK_TestataTicket.GuastoRilevato, TCK_TestataTicket.LavoroEseguito, TCK_TestataTicket.Osservazioni, TCK_TestataTicket.DataIntervento, TCK_TestataTicket.DataIns, TCK_TestataTicket.FirmaIncaricatoCol, TCK_TestataTicket.FirmaIncaricatoCli, TCK_TestataTicket.StatusRpt, TCK_TestataTicket.DisplayOrder, TCK_TestataTicket.IncaricatoCli, TCK_TestataTicket.ImmagineTxt, TCK_TestataTicket.PercorsoImmagine, TCK_TestataTicket.NomePersonaRiferimento, TCK_TestataTicket.TelPersonaRiferimento, TCK_TestataTicket.MailPersonaRiferimento, TCK_TestataTicket.InterventoPresso, TCK_TestataTicket.InterventoChiuso, TCK_TestataTicket.TCK_TipoRichiesta, TCK_TestataTicket.TCK_AreaCompetenza, TCK_TestataTicket.TCK_TipoEsecuzionePresunta, TCK_TestataTicket.TCK_TipoEsecuzione, TCK_TestataTicket.TCK_StatusChiamata, TCK_TestataTicket.TCK_StatusChiamataChiusura, TCK_TestataTicket.TCK_PrioritaRichiesta, TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura, TCK_TestataTicket.OraInzioIntervento, TCK_TestataTicket.OraFineIntervento, TCK_TestataTicket.InsertUser, TCK_TestataTicket.EditUser, TCK_TestataTicket.DeleteUser, TCK_TestataTicket.CreatedOn, TCK_TestataTicket.UpdatedOn, TCK_TestataTicket.DeletedOn, TCK_TestataTicket.DirittoFisso, TCK_TestataTicket.TariffaOraria, TCK_TestataTicket.SpeseViaggioKm, TCK_TestataTicket.SpeseViaggioEuro, TCK_TestataTicket.TotaleEuroForfait, TCK_TestataTicket.ImgFirmaTecnico, TCK_TestataTicket.ImgFirmaCliente, TCK_TestataTicket.FirmaCliente, TCK_TestataTicket.FirmaTecnico, TCK_TestataTicket.TicketFirmato, TCK_TestataTicket.NoteAnnullamentoTck, TCK_TestataTicket.LinkTckPdf, TCK_TestataTicket.TckInviatoA, TCK_TestataTicket.TotTecnici, TCK_TestataTicket.TempoInterventoTotale, TCK_TestataTicket.UM, TCK_TestataTicket.StatusCotrolloFatt, TCK_TestataTicket.ApprovatoDa, TCK_TestataTicket.OggettoEmail, TCK_TestataTicket.DettaglioRichiesta, TCK_TestataTicket.StatusControlloRegistrazione, TCK_TestataTicket.NumeroRegistrazione, TCK_TestataTicket.NoteFatturazioneFinale, TCK_TestataTicket.StatusControlloFatturazioneFinale, TCK_TestataTicket.CodArt_King, TCK_TestataTicket.IdIntervento_King, TCK_TestataTicket.OggettoTCK, TCK_TestataTicket.DataRegistrazioneKING, TCK_TestataTicket.Customer, TCK_TestataTicket.IDContrattoAssistenza, TCK_AreaCompetenza.Descrizione, TCK_StatusChiamata.Descrizione AS Expr1, TCK_AreaCompetenza.LabelClass AS Expr2, TCK_StatusChiamata.LabelClass FROM TCK_TestataTicket INNER JOIN TCK_AreaCompetenza ON TCK_TestataTicket.TCK_AreaCompetenza = TCK_AreaCompetenza.IdAreaAss INNER JOIN TCK_TipoRichiesta ON TCK_TestataTicket.TCK_TipoRichiesta = TCK_TipoRichiesta.Id INNER JOIN TCK_StatusChiamata ON TCK_TestataTicket.TCK_StatusChiamata = TCK_StatusChiamata.Id WHERE (TCK_TestataTicket.CodCli LIKE @CodCli) ORDER BY TCK_TestataTicket.CodRapportino DESC">
        <SelectParameters>
            <asp:Parameter Name="CodCli"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .dxgvAdaptiveDetailCell_Office365 {
            display: flex;
            justify-content: space-between;
            align-items: center; /* centra verticalmente tutto */
            padding: 0 10px;
            height: 100%;
            gap: 50px;
        }

        @media (min-width: 768px) and (max-width: 1024px) {
            .dxgvAdaptiveDetailCell_Office365 {
                gap: 150px;
            }
        }

        .dxgvAdaptiveDetailCell_Office365 .info-ticket {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start; /* allinea tutto a sinistra */
            flex: 1;
            min-width: 0;
            text-align: left; /* testo allineato a sinistra */
        }

            .dxgvAdaptiveDetailCell_Office365 .info-ticket strong {
                display: block; /* occupano tutta la larghezza */
                width: 100%;
                margin: 0;
            }

        .dxgvAdaptiveDetailCell_Office365 .status-label {
            position: absolute;
            right: 50px;
            display: flex;
            align-items: center;
            white-space: nowrap;
            flex-shrink: 0;
        }

        @media (max-width: 768px) {
            .dxgvAdaptiveDetailCell_Office365 .info-ticket strong {
                padding-right: 80px;
            }
        }



        .status-label {
            display: flex;
            align-items: center;
            margin-left: auto;
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
