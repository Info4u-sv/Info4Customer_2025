<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Iscrizioni_Template.aspx.cs" Inherits="INTRA.SuperAdmin.IscrizioneGest.Iscrizioni_Template" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <link href='//fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700' rel='stylesheet' type='text/css' />
    <link href="/assets/css/Croppie-master/prism.css" rel="stylesheet" />
    <link rel="Stylesheet" type="text/css" href="bower_components/sweetalert/dist/sweetalert.css" />
    <link href="/assets/css/Croppie-master/bower_components/sweetalert/dist/sweetalert.css" rel="stylesheet" />
    <link href="/assets/css/Croppie-master/croppie.css" rel="stylesheet" />
    <link href="/assets/css/Croppie-master/demo.css" rel="stylesheet" />
    <script type="text/javascript">
        function changeUserType(userType) {
            var grid = document.getElementById('<%=grdPrivileges.ClientID %>');
            var list = grid.getElementsByTagName("input");
            var rowIndex;
            if (userType.value == "Admin") {
                for (var i = 1; i < grid.rows.length; i++) {
                    rowIndex = grid.rows[i].rowIndex;
                    var list = grid.rows[rowIndex].getElementsByTagName("input");
                    for (j = 0; j < list.length; j++) {

                        if (list[j].type == "checkbox") {
                            list[j].checked = true;
                        }
                        if (list[j].checked = true) {
                            list[j].setAttribute("class", "inputCheckboxChecked");
                        } else {
                            list[j].setAttribute("class", "inputCheckboxUnchecked");
                        }
                    }
                }
                findUnselectedCheckboxes("chkBoxAddPermission", "Add");
                findUnselectedCheckboxes("chkBoxDeletePermission", "Delete");
                findUnselectedCheckboxes("chkBoxModifyPermission", "Modify");
                findUnselectedCheckboxes("chkBoxReadPermission", "Read");
            }
            else if (userType.value == "User") {
                for (var i = 1; i < grid.rows.length; i++) {
                    rowIndex = grid.rows[i].rowIndex;
                    var list = grid.rows[rowIndex].getElementsByTagName("input");
                    for (j = 0; j < list.length; j++) {
                        if (list[j].type == "checkbox"
                            && list[j].id != "MainContent_grdPrivileges_chkBoxAdd_0"
                            && list[j].id != "MainContent_grdPrivileges_chkBoxModify_0"
                            && list[j].id != "MainContent_grdPrivileges_chkBoxDelete_0"
                            && list[j].id != "MainContent_grdPrivileges_chkBoxRead_0"

                            && list[j].id != "MainContent_grdPrivileges_chkBoxDelete_1"
                            && list[j].id != "MainContent_grdPrivileges_chkBoxDelete_2"
                            && list[j].id != "MainContent_grdPrivileges_chkBoxDelete_3") {
                            list[j].checked = true;
                            list[j].setAttribute("class", "inputCheckboxChecked");
                        } else {
                            list[j].checked = false;
                            list[j].setAttribute("class", "inputCheckboxUnchecked");
                        }
                    }
                }
                findUnselectedCheckboxes("chkBoxAddPermission", "Add");
                findUnselectedCheckboxes("chkBoxDeletePermission", "Delete");
                findUnselectedCheckboxes("chkBoxModifyPermission", "Modify");
                findUnselectedCheckboxes("chkBoxReadPermission", "Read");
            }
            else {
                for (var i = 1; i < grid.rows.length; i++) {
                    rowIndex = grid.rows[i].rowIndex;

                    var list = grid.rows[rowIndex].getElementsByTagName("input");
                    for (j = 0; j < list.length; j++) {

                        if (list[j].type == "checkbox") {
                            list[j].checked = false;
                            list[j].setAttribute("class", "inputCheckboxUnchecked");
                        }
                    }
                }
                findUnselectedCheckboxes("chkBoxAddPermission", "Add");
                findUnselectedCheckboxes("chkBoxDeletePermission", "Delete");
                findUnselectedCheckboxes("chkBoxModifyPermission", "Modify");
                findUnselectedCheckboxes("chkBoxReadPermission", "Read");
            }
        }
        function checkAll(inputHeaderChkBox, inputControlId, permissionType) {
            var arr = inputHeaderChkBox.id.split('_');
            var objInputHeaderChkBoxId = arr[2].toString();
            var grid = document.getElementById('<%=grdPrivileges.ClientID %>');
            var list = grid.getElementsByTagName("input");
            var rowIndex;
            for (var i = 1; i < grid.rows.length; i++) {
                rowIndex = grid.rows[i].rowIndex;
                var list = grid.rows[rowIndex].getElementsByTagName("input");
                for (j = 0; j < list.length; j++) {
                    if (list[j].type == "checkbox" && list[j].id == grid.id + "_" + inputControlId + "_" + (i - 1).toString()) {
                        if (inputHeaderChkBox.checked) {
                            list[j].checked = true;
                            list[j].setAttribute("class", "inputCheckboxChecked");
                        } else {
                            list[j].checked = false;
                            list[j].setAttribute("class", "inputCheckboxUnchecked");
                        }
                    }
                }
            }
            //findUnselectedCheckboxes(objInputHeaderChkBoxId, permissionType);
        }
        function findUnselectedCheckboxes(inputHeaderChkBoxId, permissionType) {
            var grid = document.getElementById('<%=grdPrivileges.ClientID %>');
            var list = grid.getElementsByTagName("input");
            var rowIndex;
            var objTotalCheckBoxQty = 0; //----------------------- Total number of checkboxes in the gridview.
            var objSelectedCheckBoxQty = 0; //-------------------- Total number of selected checkboxes in the gridview.
            var objColumnSelectedChkBoxCount = 0; //-------------- Total number of selected checkboxes in each column (Add, Delete, Modify, Read) respectively.
            var objColumnTotalChkBoxCount = 0; //----------------- Total number of checkboxes in each column.
            for (var i = 1; i < grid.rows.length; i++) {
                rowIndex = grid.rows[i].rowIndex;
                var list = grid.rows[rowIndex].getElementsByTagName("input");
                for (j = 0; j < list.length; j++) {
                    if (list[j].type == "checkbox" && list[j].checked == true) {
                        objSelectedCheckBoxQty = objSelectedCheckBoxQty + 1;
                        list[j].setAttribute("class", "inputCheckboxChecked");
                    } else
                        list[j].setAttribute("class", "inputCheckboxUnchecked");
                    if (list[j].type == "checkbox") {
                        objTotalCheckBoxQty = objTotalCheckBoxQty + 1;
                    }
                    if (list[j].type == "checkbox" && list[j].id == grid.id + "_chkBox" + permissionType + "_" + (i - 1).toString() && list[j].checked == true) {
                        if (grid.id + "_chkBox" + permissionType + "_" + (i - 1).toString().checked)
                            objColumnSelectedChkBoxCount = objColumnSelectedChkBoxCount + 1;
                    }
                    if (list[j].type == "checkbox" && list[j].id == grid.id + "_chkBox" + permissionType + "_" + (i - 1).toString())
                        objColumnTotalChkBoxCount = objColumnTotalChkBoxCount + 1;
                }
            }
            if (objColumnTotalChkBoxCount == objColumnSelectedChkBoxCount) {
                document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).checked = true;
                document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).setAttribute("class", "inputCheckboxChecked");
            } else {
                document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).checked = false;
                document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).setAttribute("class", "inputCheckboxUnchecked");
            }
            if (objTotalCheckBoxQty > objSelectedCheckBoxQty)
                document.getElementById('ddlUserRole').selectedIndex = "2"; // User
            else if (objTotalCheckBoxQty == objSelectedCheckBoxQty)
                document.getElementById('ddlUserRole').selectedIndex = "1"; // Admin
            if (objSelectedCheckBoxQty == "0")
                document.getElementById('ddlUserRole').selectedIndex = "0";
        }
    </script>
    <style>
        input[type="text"] {
            width: 100% !important;
        }
    </style>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header card-header-icon" data-background-color="red">
                        <i class="material-icons">assignment</i>
                    </div>
                    <div class="card-content">
                        <h4 class="card-title">Tipo Iscrizione</h4>



                        <dx:ASPxComboBox ID="RmTipoIscrizAtleta_Combobox" ClientInstanceName="RmTipoIscrizAtleta_Combobox" DataSourceID="RmTipoIscrizAtleta_Sql" runat="server" ValueType="System.Int32" ValueField="ValueFieldNumber" TextField="TextField" AutoPostBack="true" OnSelectedIndexChanged="RmTipoIscrizAtleta_Combobox_SelectedIndexChanged">
                        </dx:ASPxComboBox>
                    </div>
                </div>
            </div>

            <%--    <dx:ASPxCallbackPanel runat="server" ID="Ruoli_CallbackPnl" ClientInstanceName="Ruoli_CallbackPnl" Width="100%" OnCallback="Ruoli_CallbackPnl_Callback">
        <PanelCollection>
            <dx:PanelContent>--%>
            <div class="col-md-12">
                <div class="card">
                    <div class="card-content">
                        <h4 class="card-title">Gestione permessi ruolo</h4>
                        <asp:GridView ID="grdPrivileges" runat="server" Width="100%" AutoGenerateColumns="False" ClientIDMode="Predictable"
                            DataKeyNames="MenuId" GridLines="None" DataSourceID="Generic_Sql" OnDataBinding="grdPrivileges_DataBinding1">
                            <AlternatingRowStyle BackColor="#99CCFF" />
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <table class="bordered" width="100%">
                                            <thead>
                                                <tr style="height: 20px" valign="middle">
                                                    <th style="width: 60%" rowspan="2">
                                                        <span>Web Page</span>
                                                    </th>
                                                    <th style="width: 60%" align="center" colspan="4">
                                                        <span style="font-size: 13px;">Permission</span><br />
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 10%; height: 20px; text-align: center;">
                                                        <span style="font-size: 13px;">Add</span><br />
                                                        <asp:CheckBox ID="chkBoxAddPermission" runat="server" onClick="checkAll(this, 'chkBoxAdd', 'Add');" />
                                                    </th>
                                                    <th style="width: 10%; height: 20px; text-align: center;">
                                                        <span style="font-size: 13px;">Delete</span><br />
                                                        <asp:CheckBox ID="chkBoxDeletePermission" runat="server" onClick="checkAll(this, 'chkBoxDelete', 'Delete');" />
                                                    </th>
                                                    <th style="width: 10%; height: 20px; text-align: center;">
                                                        <span style="font-size: 13px;">Modify</span><br />
                                                        <asp:CheckBox ID="chkBoxModifyPermission" runat="server" onClick="checkAll(this, 'chkBoxModify', 'Modify');" />
                                                    </th>
                                                    <th style="width: 10%; height: 20px; text-align: center;">
                                                        <span style="font-size: 13px;">Read</span><br />
                                                        <asp:CheckBox ID="chkBoxReadPermission" runat="server" onClick="checkAll(this, 'chkBoxRead', 'Read');" />
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table class="bordered" width="100%">
                                            <tr>
                                                <td style="width: 60%">
                                                    <asp:Label ID="lblDisplayFormNameEnglish" runat="server" Text='<%# Bind("Title") %>'
                                                        CssClass="inputLabel" Style="color: #000000; font-weight: bold;"></asp:Label>
                                                    <asp:HiddenField ID="hdnFormId" runat="server" Value='<%# Bind("MenuId") %>' />
                                                    <asp:HiddenField ID="hdnRolesId" runat="server" Value='<%# Bind("Title") %>' />
                                                </td>
                                                <td style="width: 10%" align="center">
                                                    <asp:CheckBox ID="chkBoxAdd" runat="server" Checked='<%# Bind("add_permission") %>'
                                                        onClick="findUnselectedCheckboxes('chkBoxAddPermission', 'Add');" CssClass="checkBox" />
                                                </td>
                                                <td style="width: 10%" align="center">
                                                    <asp:CheckBox ID="chkBoxDelete" runat="server" BorderStyle="Solid" BorderColor="Transparent"
                                                        CssClass="inputCheckBox" BorderWidth="1px" Checked='<%# Bind("delete_permission") %>'
                                                        onClick="findUnselectedCheckboxes('chkBoxDeletePermission', 'Delete');" />
                                                </td>
                                                <td style="width: 10%" align="center">
                                                    <asp:CheckBox ID="chkBoxModify" runat="server" BorderStyle="Solid" BorderColor="Transparent"
                                                        CssClass="inputCheckBox" BorderWidth="1px" Checked='<%# Bind("modify_permission") %>'
                                                        onClick="findUnselectedCheckboxes('chkBoxModifyPermission', 'Modify');" />
                                                </td>
                                                <td style="width: 10%" align="center">
                                                    <asp:CheckBox ID="chkBoxRead" runat="server" Checked='<%# Bind("read_permission") %>'
                                                        CssClass="inputCheckBox" BorderStyle="Solid" BorderColor="Transparent" BorderWidth="1px"
                                                        onClick="findUnselectedCheckboxes('chkBoxReadPermission', 'Read');" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <div style="float: right; padding-top: 20px">
                            <dx:ASPxButton Text="Aggiorna Permessi" runat="server" ID="salva_btn" OnClick="salva_btn_Click">
                            </dx:ASPxButton>
                        </div>
                    </div>
                </div>
            </div>
            <%--   </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>--%>

            <%--    <dx:ASPxCallback runat="server" ID="AggiornaPermessi_Callback" ClientInstanceName="AggiornaPermessi_Callback" OnCallback="AggiornaPermessi_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){Ruoli_CallbackPnl.PerformCallback();}" />
    </dx:ASPxCallback>--%>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="RmTipoIscrizAtleta_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' DeleteCommand="select 1 where 1 = 2 " InsertCommand="select 1 where 1 = 2 " SelectCommand="SELECT PRT_DropDown_Elementi.TextField, PRT_DropDown_Elementi.ValueField, PRT_DropDown_Elementi.ValueFieldNumber FROM PRT_DropDown_Famglia INNER JOIN PRT_DropDown_Elementi ON PRT_DropDown_Famglia.ID = PRT_DropDown_Elementi.DropDown_Famiglia WHERE (PRT_DropDown_Famglia.CodFamilyFilter = N'RmTipoIscrizAtleta')"></asp:SqlDataSource>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' DeleteCommand="select 1 where 1 = 2 " InsertCommand="select 1 where 1 = 2 " SelectCommand="PRT_Privilege_Rules_getRolePrivileges" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RmTipoIscrizAtleta_Combobox" PropertyName="Text" Name="Rules_id_fk" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

