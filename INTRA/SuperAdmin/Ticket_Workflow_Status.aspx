<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Ticket_Workflow_Status.aspx.cs" Inherits="INTRA.SuperAdmin.Ticket_Workflow_Status" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server" />

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .card.border-success {
            border: 1px solid #28a745;
        }

        .card-header.bg-success {
            border-bottom: 2px solid #28a745;
        }

        .btn-sm {
            font-size: 17px !important;
            padding: 2px 8px;
        }

        .associaButton {
            background-color: #57b5e3 !important;
            border-color: #57b5e3;
            color: #fff;
        }
    </style>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/AjaxControlToolkit/Bundle" />
        </Scripts>
    </asp:ScriptManager>
    <asp:UpdateProgress ID="UpdateProgressDefault" runat="server">
        <ProgressTemplate>
            <div class="loading-container" style="display: block; z-index: 999; opacity: 0.6; filter: alpha(opacity=60); -moz-opacity: 0.8;">
                <div class="loader" style="display: block; z-index: 1000;"></div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header card-header-icon" data-background-color="blue">
                            <i class="material-icons">confirmation_number</i>
                        </div>
                        <div class="card-content">
                            <h4 class="card-title">Dettagli Ticket</h4>
                            <div class="card-body">
                                <div class="row g-3">
                                    <!-- Area Competenza -->
                                    <div class="col-lg-6 col-md-6">
                                        <div class="card border-success h-100">
                                            <div class="card-header bg-success text-white">Area di Competenza*</div>
                                            <div class="card-body">
                                                <asp:RadioButtonList ID="rbtAreaAss" runat="server"
                                                    DataSourceID="DtsTCK_AreaCompetenza" DataTextField="Descrizione"
                                                    DataValueField="IdAreaAss" CssClass="form-check"
                                                    RepeatDirection="Vertical" AutoPostBack="True" Style="margin-left: 15px; margin-top: 10px;" />
                                            </div>
                                        </div>
                                    </div>


                                    <!-- Email Vs Ticket -->
                                    <div class="col-lg-6 col-md-12">
                                        <div class="card border-info h-100" style="border: 1px solid #89a5b9">
                                            <div class="card-header bg-info text-white" style="border: 2px solid #89a5b9">Email Vs Ticket*</div>
                                            <div class="card-body">
                                                <dx:ASPxGridView runat="server" ID="Generic_Gridview" DataSourceID="DtsTCK_EmailInvioStatusAreaTicket" KeyFieldName="IdRow" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" Width="100%" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter">
                                                    <ClientSideEvents CustomButtonClick="function(s,e){
 if(e.buttonID == 'Elimina'){
        OnGetRowValuesElimina(e.visibleIndex);
    }
}"
                                                        EndCallback="function(s,e){if (e.command == 'UPDATEEDIT') {;showNotification();}}" />
                                                    <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                                    <SettingsPager PageSizeItemSettings-Items="10,20,50,100" PageSizeItemSettings-Visible="true" PageSizeItemSettings-AllItemText="All" PageSizeItemSettings-ShowAllItem="true" Position="TopAndBottom"></SettingsPager>
                                                    <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>
                                                    <SettingsPopup>
                                                        <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                                                    </SettingsPopup>
                                                    <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                                                    <SettingsCustomizationDialog Enabled="true" />
                                                    <Settings ShowFilterRow="True"></Settings>
                                                    <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
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
                                                    <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm"></SettingsEditing>

                                                    <Columns>
                                                        <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True" ShowDeleteButton="false" ShowClearFilterButton="true" Width="60px">
                                                            <CustomButtons>
                                                                <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />

                                                            </CustomButtons>
                                                        </dx:GridViewCommandColumn>
                                                        <dx:GridViewDataTextColumn FieldName="IdRow" Visible="false" />
                                                        <dx:GridViewDataComboBoxColumn FieldName="IdStatus" Caption="Status Ticket" VisibleIndex="1" Width="40%" EditFormSettings-CaptionLocation="Top">
                                                            <PropertiesComboBox
                                                                DataSourceID="DtsTCK_StatusTicket"
                                                                TextField="Descrizione"
                                                                ValueField="ID"
                                                                ValueType="System.Int32">
                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                    <RequiredField IsRequired="True" />
                                                                    <ErrorFrameStyle BackColor="LightPink" />
                                                                </ValidationSettings>
                                                            </PropertiesComboBox>

                                                            <DataItemTemplate>
                                                                <label class='label <%# Eval("Descrizione").ToString().Replace(" ", "") %>'><%# Eval("Descrizione")%></label>
                                                            </DataItemTemplate>
                                                        </dx:GridViewDataComboBoxColumn>
                                                        <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="2" EditFormSettings-ColumnSpan="2" EditFormSettings-CaptionLocation="Top" Caption="Email">
                                                            <PropertiesTextEdit>
                                                                <InvalidStyle BackColor="LightPink" />
                                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                                                    <ErrorFrameStyle BackColor="LightPink" />
                                                                    <RequiredField IsRequired="True" />
                                                                    <RegularExpression
                                                                        ValidationExpression="^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,7}$"
                                                                        ErrorText="Formato email non valido" />
                                                                </ValidationSettings>
                                                            </PropertiesTextEdit>
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <asp:SqlDataSource ID="DtsTCK_EmailInvioStatusAreaTicket" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT        TCK_EmailInvioStatusAreaTicket.IdRow, TCK_EmailInvioStatusAreaTicket.IdAreaAss, TCK_EmailInvioStatusAreaTicket.IdStatus, TCK_EmailInvioStatusAreaTicket.Email, TCK_EmailInvioStatusAreaTicket.CreatedOn, 
                         TCK_EmailInvioStatusAreaTicket.UpdatedOn, TCK_EmailInvioStatusAreaTicket.DeletedOn, TCK_EmailInvioStatusAreaTicket.EditUser, TCK_EmailInvioStatusAreaTicket.InsertUser, TCK_EmailInvioStatusAreaTicket.DeleteUser, 
                         TCK_StatusChiamata.Descrizione
FROM            TCK_EmailInvioStatusAreaTicket INNER JOIN
                         TCK_StatusChiamata ON TCK_EmailInvioStatusAreaTicket.IdStatus = TCK_StatusChiamata.Id WHERE (IdAreaAss = @IdAreaAss)"
                InsertCommand="INSERT INTO TCK_EmailInvioStatusAreaTicket(IdAreaAss, IdStatus, Email) VALUES (@IdAreaAss, @IdStatus, @Email)" DeleteCommand="DELETE FROM TCK_EmailInvioStatusAreaTicket WHERE (IdRow = @IdRow)" UpdateCommand="UPDATE TCK_EmailInvioStatusAreaTicket SET IdStatus = @IdStatus, Email = @Email WHERE (IdRow = @IdRow)">
                <DeleteParameters>
                    <asp:Parameter Name="IdRow"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="rbtAreaAss" Name="IdAreaAss" PropertyName="SelectedValue" />
                    <asp:Parameter Name="IdStatus" />
                    <asp:Parameter Name="Email" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="rbtAreaAss" Name="IdAreaAss" PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdStatus"></asp:Parameter>
                    <asp:Parameter Name="Email"></asp:Parameter>
                    <asp:Parameter Name="IdRow"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="DtsTCK_StatusTicket" runat="server"
                ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
                SelectCommand="SELECT Id, Descrizione FROM [TCK_StatusChiamata] ORDER BY Id" />

            <asp:SqlDataSource ID="DtsTCK_AreaCompetenza" runat="server"
                ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
                SelectCommand="SELECT Descrizione, DisplayOrder, LabelClass, IdAreaAss FROM [TCK_AreaCompetenza] ORDER BY DisplayOrder" />

            <asp:SqlDataSource ID="Dts_MailAssociata" runat="server"
                ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
                SelectCommand="SELECT EmailRiferimento, IdAreaAss FROM TCK_AreaCompetenza WHERE (IdAreaAss = @IdAreaAss)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="rbtAreaAss"
                        Name="IdAreaAss" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

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
            .label.Chiuso,
            .label.Inviato {
                background-color: #8cc474;
            }

            .label.Assegnato {
                background-color: #ffce55;
            }

            .label.Inlavorazione {
                background-color: #5db2ff;
            }


            .label.Chiusoconriserva {
                background-color: #808080;
            }

            .label.Aperto {
                background-color: #df5138;
            }

            .label.Annullato {
                background-color: #fb6e52;
            }

            .label.ControlloTicket {
                background-color: #7e3794;
            }
    </style>
    <script>
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare l'email?", "Conferma", "Annulla", Elimina, null, index, null);
        }
        function Elimina(Valore) {
            Generic_Gridview.DeleteRow(Valore);
            showNotification();
        }
        function ConfermaOperazioneWithClientFunction(Title, Testo, BtnConfirmTxt, BtnCancelTxt, Function, FunctionCancel = null, FunctionParam = null, FunctionCancelParam = null) {

            swal({

                title: Title,

                text: Testo,

                type: 'warning',

                showCancelButton: true,

                confirmButtonClass: 'btn btn-success',

                cancelButtonClass: 'btn btn-danger',

                confirmButtonText: BtnConfirmTxt,

                buttonsStyling: false,

                cancelButtonText: BtnCancelTxt,

            }).then(function (isConfirm) {

                if (isConfirm) {

                    if (FunctionParam != null) {

                        Function(FunctionParam);

                    } else {

                        Function();

                    }

                }



            }).catch(function () {

                console.log("Test");

                if (FunctionCancelParam != null) {

                    FunctionCancel(FunctionCancelParam);

                } else {

                    FunctionCancel();

                }

            });

        }
    </script>
    <%-- <script src="/assets/js/validation/formValidation.min.js"></script>--%>
    <script src="/assets/js/validation/framework/bootstrap.min.js"></script>
    <script src="/assets/js/bootbox/bootbox.min.js"></script>
    <script src="/assets/js/toastr/toastr.js"></script>
    <script>
        var VarformValid = false;
        var ControlValidation = false;
        var ControlValidationObj = false;
    </script>

    <!--Jquery Select2-->
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
    <script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
    <script src="/assets/js/datatable/ZeroClipboard.js"></script>
    <script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
    <script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
    <script src="/assets/js/datatable/datatables-init.js"></script>

    <script type="text/javascript">
        // Script Corretti e verificati
        var confirmed = false;
        function ShowConfirm(controlID) {
            //istanzio la form
            var $myForm = $('#aspnetForm');
            // verifico se i validator Html5 sono validi e in quel caso visualizzo il popup di conferma
            if ($myForm[0].checkValidity()) {
                if (confirmed) { return true; } else {
                    bootbox.confirm("Confermi l'operazione?", function (result) {
                        if (result) {
                            if (controlID != null) {
                                var controlToClick = document.getElementById(controlID);
                                if (controlToClick != null) {
                                    confirmed = true;
                                    controlToClick.click();
                                    confirmed = false;
                                    VarformValid = false;
                                }
                            }
                        }
                    });
                    return false;
                }
            }
        }

        // script per ovviare al problema del caricamento dei jquery dopo il postback
        $(document).ready(function () {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_initializeRequest(InitializeRequest);
            prm.add_endRequest(EndRequest);

        });
        function InitializeRequest(sender, args) { }
        function EndRequest(sender, args) {
            // after the UpdatePanel finish the render from ajax call
            //  and the DOM is ready, re-initilize the InitiateSearchableDataTable
            //InitiateSearchableDataTable.init();
            //clockpicker_init();
        }
        function EndRequest(sender, args) {
            console.log("Postback async completato!");
        }
        // FINE ------------script per ovviare al problema del caricamento dei jquery dopo il postback
    </script>
    <%--  <script type="text/javascript" src="../_clockpicker/dist/bootstrap-clockpicker.min.js"></script>
   <script type="text/javascript" src="../_clockpicker/assets/js/highlight.min.js"></script>--%>

    <!--Bootstrap Date Picker-->
    <%--  <script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
   <script>
      //--Bootstrap Date Picker--
       $('.date-picker').datepicker();</script>
   <script src="/assets/js/Info4u-Custom-Beyond.js"></script>--%>   <%-- <script src="/assets/js/validation/formValidation.min.js"></script>--%>
    <script src="~/assets/js/validation/framework/bootstrap.min.js"></script>
    <script src="~/assets/js/bootbox/bootbox.min.js"></script>
    <script src="~/assets/js/toastr/toastr.js"></script>
    <script>
        var VarformValid = false;
        var ControlValidation = false;
        var ControlValidationObj = false;
    </script>

    <!--Jquery Select2-->
    <script src="~/assets/js/select2/select2.js"></script>
    <script>
        $('[data-rel="chosen"],[rel="chosen"]').select2({
            placeholder: "Seleziona",
            allowClear: true
        });
        $(".js-example-language").select2({
            language: "it"
        });
    </script>
    <script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
    <script src="/assets/js/datatable/ZeroClipboard.js"></script>
    <script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
    <script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
    <script src="/assets/js/datatable/datatables-init.js"></script>

    <script type="text/javascript">
        // Script Corretti e verificati
        var confirmed = false;
        function ShowConfirm(controlID) {
            //istanzio la form
            var $myForm = $('#aspnetForm');
            // verifico se i validator Html5 sono validi e in quel caso visualizzo il popup di conferma
            if ($myForm[0].checkValidity()) {
                if (confirmed) { return true; } else {
                    bootbox.confirm("Confermi l'operazione?", function (result) {
                        if (result) {
                            if (controlID != null) {
                                var controlToClick = document.getElementById(controlID);
                                if (controlToClick != null) {
                                    confirmed = true;
                                    controlToClick.click();
                                    confirmed = false;
                                    VarformValid = false;
                                }
                            }
                        }
                    });
                    return false;
                }
            }
        }
        //function clockpicker_init() {
        //    $('.clockpicker').clockpicker({
        //        placement: 'top',
        //        align: 'left',
        //        donetext: 'Done',
        //        'default': 'now'
        //    });
        //}

        // script per ovviare al problema del caricamento dei jquery dopo il postback
        $(document).ready(function () {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_initializeRequest(InitializeRequest);
            prm.add_endRequest(EndRequest);
            // on page ready first init of your InitiateSearchableDataTable           
            //InitiateSearchableDataTable.init();
            //clockpicker_init();

        });
        function InitializeRequest(sender, args) { }
        function EndRequest(sender, args) {
            // after the UpdatePanel finish the render from ajax call
            //  and the DOM is ready, re-initilize the InitiateSearchableDataTable
            //InitiateSearchableDataTable.init();
            //clockpicker_init();
        }
        // FINE ------------script per ovviare al problema del caricamento dei jquery dopo il postback
    </script>
    <%--  <script type="text/javascript" src="../_clockpicker/dist/bootstrap-clockpicker.min.js"></script>
   <script type="text/javascript" src="../_clockpicker/assets/js/highlight.min.js"></script>--%>

    <!--Bootstrap Date Picker-->
    <%--  <script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
   <script>
      //--Bootstrap Date Picker--
       $('.date-picker').datepicker();</script>
   <script src="/assets/js/Info4u-Custom-Beyond.js"></script>--%>
</asp:Content>
