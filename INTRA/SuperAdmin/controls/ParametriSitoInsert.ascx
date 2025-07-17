<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ParametriSitoInsert.ascx.cs"
    Inherits="AdminPanel_controls_ParametriSitoInsert" %>
<%@ Register Assembly="DevExpress.Web.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<link href="/assets/css/shCore.css" rel="stylesheet" />
<link href="/assets/css/buttons.dataTables.css" rel="stylesheet" />
<script src="../assets/js/jquery.min.js"></script>

<link href="../Default.css" rel="stylesheet" />
<style>
    input[type="checkbox"], input[type="radio"] {
        margin: 3px 10px 0px !important;
        opacity: 1 !important;
        position: inherit !important;
        left: 0px !important;
        z-index: 12 !important;
        width: 0px !important;
        height: 0px !important;
        cursor: pointer !important;
    }
</style>

<div class="row">
    <div class="col-xs-12 col-md-12">
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <div class="widget">
                    <div class="widget-header bordered-bottom bordered-yellow">
                        <span class="widget-caption" style="float: inherit !important;">
                            <div style="float: left;">Pannello parametri sito</div>

                        </span>

                        <div class="widget-buttons">
                            <%--<a href="#" data-toggle="maximize">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a href="#" data-toggle="collapse">
                            <i class="fa fa-minus"></i>
                        </a>
                        <a href="#" data-toggle="dispose">
                            <i class="fa fa-times"></i>
                        </a>--%>
                        </div>
                    </div>

                    <div class="widget-body">
                        <style>
                            th > input {
                                width: auto;
                                max-width: 100px;
                            }

                            .auto-style1 {
                                height: 155px;
                            }
                        </style>
                        <fieldset>
                            <small style="color: red; font-size: 20px">Tramite questa sezione puoi aggiornare i dati del tuo sito.<br />
                                Attenzione per rendere definitivi i dati dopo l'aggiornamento devi "Cancellare la
                    Cache"!</small>
                            <br />
                            <asp:LinkButton ID="btnDeleteCache" runat="server"
                                CssClass="btn btn-labeled btn-danger" data-toggle="tooltip" title="Elimina cache"
                                OnClick="btnDeleteCache_Click">
            <i class="btn-label fa fa-trash"></i>Cache</asp:LinkButton>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--contenuto principale-->
<div class="row">
    <div class="col-xs-12 col-md-12">
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <div class="widget">
                    <div class="widget-header bordered-bottom bordered-yellow">
                        <span class="widget-caption" style="float: inherit !important;">
                            <div style="float: left;">Elenco parametri</div>

                        </span>

                        <div class="widget-buttons">
                            <%--<a href="#" data-toggle="maximize">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a href="#" data-toggle="collapse">
                            <i class="fa fa-minus"></i>
                        </a>
                        <a href="#" data-toggle="dispose">
                            <i class="fa fa-times"></i>
                        </a>--%>
                        </div>
                    </div>

                    <div class="widget-body">
                        <style>
                            th > input {
                                width: auto;
                                max-width: 100px;
                            }

                            .auto-style1 {
                                height: 155px;
                            }
                        </style>
                        <fieldset>
                            <div class="col-xs-12 col-md-12 col-lg-12 no-padding">

                                <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="ASPxGridView1" Width="100%" runat="server" DataSourceID="GenericSqlDS" KeyFieldName="SettingID" AutoGenerateColumns="False" Theme="Office365" OnRowUpdating="ASPxGridView1_RowUpdating" OnRowInserting="ASPxGridView1_RowInserting">
                                    <SettingsEditing Mode="inline"></SettingsEditing>

                                    <Settings ShowFilterRow="True" />
                                    <SettingsCommandButton>
                                                    <ClearFilterButton RenderMode="Image">
                                                        <Image Url="../img/DevExButton/clear.png" Width="25px" ToolTip="Svuota ricerche" />
                                                    </ClearFilterButton>
                                                    <EditButton RenderMode="Image">
                                                        <Image Url="../img/DevExButton/edit.png" Width="30px" ToolTip="Modifica" />
                                                    </EditButton>
                                                    <DeleteButton RenderMode="Image">
                                                        <Image Url="../img/DevExButton/delete.png" Width="30px" ToolTip="Elimina" />
                                                    </DeleteButton>
                                                    <UpdateButton RenderMode="Image">
                                                        <Image Url="../img/DevExButton/save.png" Width="30px" ToolTip="Salva" />
                                                    </UpdateButton>
                                                    <CancelButton RenderMode="Image">
                                                        <Image Url="../img/DevExButton/cancel.png" Width="30px" ToolTip="Annulla" />
                                                    </CancelButton>
                                                    <NewButton RenderMode="Image">
                                                        <Image Url="../img/DevExButton/new.png" Width="30px" ToolTip="Annulla" />
                                                    </NewButton>
                                                </SettingsCommandButton>
                                    <SettingsDataSecurity AllowDelete="False" />
                                    <SettingsSearchPanel Visible="True" />
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" ShowClearFilterButton="True">
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="SettingID" ReadOnly="True" VisibleIndex="1">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Name" VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="3">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="4">
                                      
                                            <PropertiesTextEdit EncodeHtml="false"></PropertiesTextEdit>

                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="5">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataCheckColumn FieldName="SystemParameter" VisibleIndex="6">
                                        </dx:GridViewDataCheckColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                            </div>
                        </fieldset>

                    </div>
                    <!--fine span 12-->
                </div>
            </div>
        </div>
    </div>
</div>
<!--/sortable-->
<asp:SqlDataSource ID="GenericSqlDS" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
    SelectCommand="SELECT SettingID, Name, Value, Description, DisplayOrder, SystemParameter FROM PRT_Setting ORDER BY SettingID" InsertCommand="UPDATE PRT_Documenti SET Description = Description WHERE (1 = 2)" UpdateCommand="UPDATE PRT_Documenti SET Description = Description WHERE (1 = 2)"></asp:SqlDataSource>

<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/dataTables.buttons.js"></script>
<%-- bottone Excel--%>
<script src="/assets/js/datatable/jszip.min.js"></script>
<%-- CREAZIONE PDF --%>
<script src="/assets/js/datatable/pdfmake.min.js"></script>
<script src="/assets/js/datatable/vfs_fonts.js"></script>
<%--CREAZIONE PDF FINE--%>
<script src="/assets/js/datatable/buttons.html5.js"></script>
<script src="/assets/js/datatable/buttons.colVis.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script>InitiateSearchableDataHTML5NOIDTable.init();</script>

<script src="/assets/js/validation/formValidation.min.js"></script>
<script src="/assets/js/validation/framework/bootstrap.min.js"></script>
<script src="/assets/js/bootbox/bootbox.min.js"></script>
<script src="/assets/js/toastr/toastr.js"></script>

<script src="/assets/js/select2/select2.js"></script>
<script>
    $('[data-rel="chosen"],[rel="chosen"]').select2({
        placeholder: "Seleziona",
        allowClear: true
    });
    $(".js-example-language").select2({
        language: "it"
    });
</script>
<script src="/assets/js/Info4u-Custom-Beyond.js"></script>


<script>
    $(document).ready(function () {
        CompattaSideBar();
    });
    // Funzione per fare lo scroll up alla chiusura del ticket
    $('#btnChiudiTicket').click(
        function () {
            window.scrollTo(0, 0);
        });
</script>
