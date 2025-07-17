<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default_menu_gest.aspx.cs" Inherits="INTRA.SuperAdmin.Default_menu_gest" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .ps-container .ps-scrollbar-y-rail {
            display: block !important;
        }

        .card-footer {
            margin-top: 24px !important;
        }

        /*.dxbButton_Office365 {
            background-color: transparent !important;
        }

            .dxbButton_Office365.dxbTSys {
                width: 40px !important;
                padding: 0 !important;
            }

            .dxbButton_Office365 div.dxb {
                padding: 0 !important;
            }*/
    </style>

    <style>
        .icon-preview {
            float: left;
            width: 30px;
            height: 30px;
            margin: 0;
            border-radius: 5px;
            background: #fff;
            text-align: center;
            font-size: 25px;
            line-height: 30px;
            color: #1e1e1e;
        }

        .get-and-preview button:hover {
            transform: scale(.97);
            box-shadow: 0 0 18px -6px #000;
        }

        .get-and-preview button {
            position: relative;
            transition: all .2s ease-in-out;
            cursor: pointer;
            float: left;
            color: #fff;
            background: #a94158;
            background: linear-gradient(to right bottom, #a94158, #99394e, #883144, #78293a, #692131);
            box-shadow: 0 2px 14px -6px #000;
            padding: 12px 18px;
            font-size: 11px;
            line-height: 10px;
            border: none;
            border-radius: 7px;
            margin: 7px 0 0;
        }
    </style>

    <link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    --%><%--<link href="/_Icon_picker_1/simple-iconpicker.min.css" rel='stylesheet' type='text/css' />--%>
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
            //if (objColumnTotalChkBoxCount == objColumnSelectedChkBoxCount) {
            //    document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).checked = true;
            //    document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).setAttribute("class", "inputCheckboxChecked");
            //} else {
            //    document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).checked = false;
            //    document.getElementById('MainContent_grdPrivileges_' + inputHeaderChkBoxId).setAttribute("class", "inputCheckboxUnchecked");
            //}
            //if (objTotalCheckBoxQty > objSelectedCheckBoxQty)
            //    document.getElementById('ddlUserRole').selectedIndex = "2"; // User
            //else if (objTotalCheckBoxQty == objSelectedCheckBoxQty)
            //    document.getElementById('ddlUserRole').selectedIndex = "1"; // Admin
            //if (objSelectedCheckBoxQty == "0")
            //    document.getElementById('ddlUserRole').selectedIndex = "0";
        }
    </script>
    <link rel="stylesheet" href="/assets/IconPicker-master/dist/fontawesome-5.11.2/css/all.min.css" />
    <link rel="stylesheet" href="/assets/IconPicker-master/dist/iconpicker-1.5.0.css" />
    <link rel="stylesheet" href="/assets/IconPicker-master/index.css?v=1.5.0" />
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>

                <div class="card-content">
                    <h4 class="card-title">Gestione menu</h4>
                    <div class="col-lg-12">
                        <small style="color: red; font-size: 20px">Tramite questa sezione puoi aggiornare i dati del tuo sito.<br />
                            Attenzione per rendere definitivi i dati dopo l'aggiornamento devi "Cancellare la Cache"!</small>
                        <br />
                        <table class="webparts">
                            <tr>

                                <td class="details">

                                    <asp:LinkButton ID="btnDeleteCache" runat="server" CssClass="btn btn-labeled btn-danger" data-toggle="tooltip" title="Elimina cache" OnClick="btnDeleteCache_Click"><i class="btn-label fas fa-trash"></i> Cache</asp:LinkButton>

                                </td>
                                <td>
                                    <asp:LinkButton ID="ResetColori" runat="server" CssClass="btn btn-labeled btn-info" data-toggle="tooltip" title="Reset Colori Icone" OnClick="ResetColori_Click"><i class="btn-label fas fa-redo"></i> Reset Colori</asp:LinkButton>

                                </td>
                                <td>

                                    <dx:ASPxColorEdit runat="server" ID="ColorIconBackColor" Color="#ffffff" Width="100%" ClearButton-DisplayMode="Always" EnableCustomColors="true">
                                    </dx:ASPxColorEdit>
                                </td>
                            </tr>
                        </table>
                        <script type="text/javascript">
                            function OnCustomButtonClick(s, e) {
                                //alert(TreeListMenu.GetFocusedNodeKey());
                                OnDetailsClick(TreeListMenu.GetFocusedNodeKey());
                                IconPicker.Run('#GetIconPicker');
                            }

                            function OnCustomButtonClick(s, e) {
                                //alert(TreeListMenu.GetFocusedNodeKey());
                                OnDetailsClick(TreeListMenu.GetFocusedNodeKey());
                            }
                            function OnDetailsClick(keyValue) {
                                popup.Show();
                                popup.PerformCallback(keyValue);
                            }
                        </script>
                        <dx:ASPxLoadingPanel runat="server" ID="Update_Loading" Modal="true" ClientInstanceName="Update_Loading" Text="Aggiornamento Permessi..."></dx:ASPxLoadingPanel>

                        <dx:ASPxCallback ID="ASPxCallPrivilegeUpdate" runat="server" ClientInstanceName="ASPxCallPrivilegeUpdate"
                            OnCallback="ASPxCallPrivilegeUpdate_Callback">
                            <%-- <ClientSideEvents CallbackComplete="OnCallbackComplete" />--%>
                        </dx:ASPxCallback>
                        <dx:ASPxCallbackPanel ID="PrivilegeUpdate_CallbackP" ClientInstanceName="PrivilegeUpdate_CallbackP" runat="server" Width="200px" OnCallback="PrivilegeUpdate_CallbackP_Callback">
                            <ClientSideEvents BeginCallback="function(s,e){Update_Loading.Show();}" EndCallback="function(s, e){Update_Loading.Hide(); popup.Hide(); }" />
                            <PanelCollection>
                                <dx:PanelContent>
                                    <dx:ASPxPopupControl ID="popup" ClientInstanceName="popup" runat="server" AllowDragging="true" LoadingPanelStyle-HorizontalAlign="Center" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                                        HeaderText="Gestione Autorizzazioni" OnWindowCallback="popup_WindowCallback" Width="320" Modal="True" CloseOnEscape="True">
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <table>
                                                    <tr>
                                                        <td>

                                                            <asp:GridView ID="grdPrivileges" runat="server" DataSourceID="PrivilageFilter_Sql" Width="100%" AutoGenerateColumns="False" ClientIDMode="Predictable"
                                                                DataKeyNames="FormId" GridLines="None">
                                                                <AlternatingRowStyle BackColor="#99CCFF" />
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <table class="bordered" style="width: 100% !important; min-width: 600px">
                                                                                <thead>
                                                                                    <tr style="height: 20px" valign="middle">
                                                                                        <th style="width: 60%" rowspan="2">
                                                                                            <span>Ruolo</span>
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
                                                                                <tr name="<%# Eval("Title") %>">
                                                                                    <td style="width: 60%">
                                                                                        <input type="checkbox" onclick='selezione("<%# Eval("Title") %>");' id="<%# Eval("Title") %>" />
                                                                                        <asp:Label ID="lblDisplayRoles" runat="server" Text='<%# Bind("Title") %>'
                                                                                            CssClass="inputLabel" Style="color: #000000; font-weight: bold;"></asp:Label>
                                                                                        <asp:HiddenField ID="hdnFormId" runat="server" Value='<%# Bind("FormId") %>' />
                                                                                        <asp:HiddenField ID="hdnRolesId" runat="server" Value='<%# Bind("Title") %>' />
                                                                                        <%# "FormId: " + Eval("FormId") %>
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
                                                            <asp:SqlDataSource ID="PrivilageFilter_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT aspnet_Roles.RoleName AS Title, @form_id_fk AS FormId, CAST((CASE WHEN add_permission IS NULL THEN 0 ELSE add_permission END) AS bit) AS add_permission, CAST((CASE WHEN delete_permission IS NULL THEN 0 ELSE delete_permission END) AS bit) AS delete_permission, CAST((CASE WHEN modify_permission IS NULL THEN 0 ELSE modify_permission END) AS bit) AS modify_permission, CAST((CASE WHEN read_permission IS NULL THEN 0 ELSE read_permission END) AS bit) AS read_permission FROM aspnet_Roles LEFT OUTER JOIN (SELECT prv_id_pk, form_id_fk, Rules_id_fk, add_permission, delete_permission, modify_permission, read_permission FROM PRT_Privilege_Rules AS PRT_Privilege_Rules_1 WHERE (form_id_fk = @form_id_fk)) AS PRT_Privilege_Rules_filtered ON aspnet_Roles.RoleName = PRT_Privilege_Rules_filtered.Rules_id_fk">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter SessionField="form_id_fk" DefaultValue="0" Name="form_id_fk"></asp:SessionParameter>
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <div style="float: right; padding-top: 20px">
                                                                <dx:ASPxButton ID="Update_ruoli_btn" runat="server" Text="Update" AutoPostBack="false">
                                                                    <ClientSideEvents Click="function(s, e){PrivilegeUpdate_CallbackP.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PopupControlContentControl>
                                        </ContentCollection>
                                    </dx:ASPxPopupControl>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                        <script type="text/javascript">
                            var currentNodeKey;
                            function ShowMenu(nodeKey, x, y) {
                                //TreeListMenu.SetFocusedNodeKey(currentNodeKey);
                                clientPopupMenu.ShowAtPos(x, y);
                                currentNodeKey = nodeKey;

                            }
                            function ProcessNodeClick(itemName) {
                                switch (itemName) {
                                    case "new":
                                        {
                                            if (TreeListMenu.IsEditing()) {
                                                TreeListMenu.UpdateEdit()
                                            }
                                            TreeListMenu.StartEditNewNode();
                                            break;
                                        }
                                    case "newchild":
                                        {
                                            if (TreeListMenu.IsEditing()) {
                                                TreeListMenu.UpdateEdit()
                                            }
                                            TreeListMenu.StartEditNewNode(currentNodeKey);
                                            break;
                                        }
                                    case "edt":
                                        {

                                            if (TreeListMenu.IsEditing()) {
                                                TreeListMenu.UpdateEdit()
                                            }
                                            TreeListMenu.StartEdit(currentNodeKey);
                                            break;
                                        }
                                    case "del":
                                        {
                                            if (TreeListMenu.IsEditing()) {
                                                TreeListMenu.UpdateEdit()
                                            }

                                            TreeListMenu.DeleteNode(currentNodeKey);
                                            break;
                                        }
                                    case "miExpandAll": {
                                        TreeListMenu.ExpandAll();
                                        return;
                                    }
                                    case "miCollapseAll": {
                                        TreeListMenu.CollapseAll();
                                        return;
                                    }
                                    default: return;
                                }

                            }
                            function HiddenViewDocumento() {
                                ASPxCallbackPanel1.SetVisible(false);
                                Gestione_ASPxCallBkPnl.SetVisible(true);
                            }
                        </script>
                        <dx:ASPxTreeList ID="TreeListMenu" ClientInstanceName="TreeListMenu" EnableViewState="False" runat="server" AutoGenerateColumns="False" DataSourceID="Menu_SqlDataSource" KeyFieldName="MenuId" ParentFieldName="ParentMenuId" Style="margin-top: 0px" OnNodeInserting="TreeListMenu_NodeInserting" OnNodeUpdating="TreeListMenu_NodeUpdating" OnNodeDeleting="TreeListMenu_NodeDeleting" OnNodeInserted="TreeListMenu_NodeInserted">
                            <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3">
                                <AlternatingNode BackColor="#f0f0f0" Enabled="True"></AlternatingNode>
                                <Header Wrap="True"></Header>
                            </Styles>
                            <ClientSideEvents ContextMenu="function(s, e) {
	       if (e.objectType != 'Node') return;
	       s.SetFocusedNodeKey(e.objectKey);
           s.PerformCallback(s.GetFocusedNodeKey());
	       var mouseX = ASPxClientUtils.GetEventX(e.htmlEvent);
	       var mouseY = ASPxClientUtils.GetEventY(e.htmlEvent);   
           ShowMenu(e.objectKey, mouseX, mouseY);
           }" />
                            <ClientSideEvents ContextMenu="function(s, e) {
	       if (e.objectType != 'Node') return;
	       s.SetFocusedNodeKey(e.objectKey);
           s.PerformCallback(s.GetFocusedNodeKey());
	       var mouseX = ASPxClientUtils.GetEventX(e.htmlEvent);
	       var mouseY = ASPxClientUtils.GetEventY(e.htmlEvent);   
           ShowMenu(e.objectKey, mouseX, mouseY);
           }" />
                            <Columns>

                                <dx:TreeListTextColumn FieldName="Title" VisibleIndex="0" CellStyle-Font-Bold="true" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-ErrorDisplayMode="None" PropertiesTextEdit-InvalidStyle-BackColor="LightPink">
                                </dx:TreeListTextColumn>
                                <dx:TreeListTextColumn FieldName="DisplayOrder" VisibleIndex="2" Width="30px">
                                </dx:TreeListTextColumn>
                                <dx:TreeListDataColumn FieldName="Material_Icons" VisibleIndex="1" Caption="Icon" Width="10px" CellStyle-HorizontalAlign="Right">
                                    <DataCellTemplate>
                                        <div class="icon-preview" style="background-color: #000">
                                            <i class="<%# Eval("Material_Icons") %>" style="font-size: 24px; color: #<%# Eval("Color") %>"></i>
                                        </div>
                                    </DataCellTemplate>
                                    <EditCellTemplate>
                                        <div class="">
                                            <div class="form-input form-input-icon">
                                                <div class="get-and-preview">
                                                    <div class="icon-preview" data-toggle="tooltip" title="Preview of selected Icon" style="background-color: black">
                                                        <i id="IconPreview" class="<%# Eval("Material_Icons") %>" style="color: #<%# Eval("Color") %>;"></i>
                                                    </div>

                                                    <button type="button" id="GetIconPicker" data-iconpicker-input=".IconInputCass" data-iconpicker-preview="i#IconPreview">Select Icon</button>

                                                </div>

                                                <div class="export">
                                                    <asp:TextBox ID="IconInput1" class="IconInputCass" name="Icon" runat="server" Text='<%# Bind("Material_Icons") %>'></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </EditCellTemplate>
                                </dx:TreeListDataColumn>
                                <dx:TreeListTextColumn FieldName="Description" VisibleIndex="4">
                                </dx:TreeListTextColumn>
                                <dx:TreeListTextColumn FieldName="Url" VisibleIndex="3" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesTextEdit-ValidationSettings-ErrorDisplayMode="None" PropertiesTextEdit-InvalidStyle-BackColor="LightPink">
                                </dx:TreeListTextColumn>

                                <dx:TreeListTextColumn FieldName="Color" VisibleIndex="2" Width="100px">
                                    <DataCellTemplate>
                                        <div style='width: 20px; background-color: #<%# Eval("Color") %>; float: left; border: 1px solid'>&nbsp;</div>
                                        <div style='float: left; width: 50px; text-transform: uppercase;'>&nbsp;&nbsp;#<%# Eval("Color") %></div>
                                    </DataCellTemplate>
                                    <EditCellTemplate>
                                        <dx:ASPxColorEdit runat="server" EnableCustomColors="true" ID="ColorEditHeaderBackColor" Color='<%# GetColor(Eval("Color")) %>' Width="150px" ClearButton-DisplayMode="Never">
                                        </dx:ASPxColorEdit>
                                    </EditCellTemplate>
                                </dx:TreeListTextColumn>
                                <dx:TreeListCheckColumn FieldName="IsVisible" VisibleIndex="5" Width="30px">
                                </dx:TreeListCheckColumn>
                                <dx:TreeListCheckColumn FieldName="DefaultPage" VisibleIndex="5" Width="30px">
                                </dx:TreeListCheckColumn>

                                <dx:TreeListCommandColumn VisibleIndex="6" ShowNewButtonInHeader="True" ButtonType="Link" ShowInCustomizationForm="False" Width="100px">
                                    <EditButton Visible="True" Text=" ">
                                        <Image Url="~/assets/img/DevExButton/edit.png" Width="35px"></Image>
                                    </EditButton>
                                    <NewButton Visible="True" Text=" ">
                                        <Image Url="~/assets/img/DevExButton/new.png" Width="35px"></Image>
                                    </NewButton>
                                    <DeleteButton Visible="True" Text=" ">
                                        <Image Url="~/assets/img/DevExButton/delete.png" Width="35px"></Image>
                                    </DeleteButton>
                                    <UpdateButton Text=" ">
                                        <Image Url="~/assets/img/DevExButton/save.png" Width="35px"></Image>
                                    </UpdateButton>

                                    <CancelButton Text=" ">
                                        <Image Url="~/assets/img/DevExButton/cancel.png" Width="35px"></Image>
                                    </CancelButton>
                                    <CustomButtons>
                                        <dx:TreeListCommandColumnCustomButton ID="btnDetails" Image-Width="35px" Image-ToolTip="Assegna Ruoli" Image-Url="../assets/img/DevExButton/Area.png" Text=" "></dx:TreeListCommandColumnCustomButton>
                                    </CustomButtons>
                                </dx:TreeListCommandColumn>

                            </Columns>
                            <SettingsBehavior AllowFocusedNode="True" AutoExpandAllNodes="True" />
                            <SettingsSelection Enabled="false" />
                            <SettingsEditing AllowNodeDragDrop="True" />
                            <ClientSideEvents CustomButtonClick="OnCustomButtonClick" EndCallback="function OnEndCallback(s, e) {if (e.command == 'StartEditNewNode' || e.command =='StartEdit') { IconPicker.Run('#GetIconPicker');}  }" />
                        </dx:ASPxTreeList>
                        <dx:ASPxPopupMenu ID="ASPxPopupMenu2" runat="server" ClientInstanceName="clientPopupMenu">
                            <Items>
                                <%-- <dx:MenuItem Name="new" Text="New">
            </dx:MenuItem>--%>
                                <dx:MenuItem Name="newchild" Text="+ Sotto Cartella">
                                </dx:MenuItem>
                                <%--  <dx:MenuItem Name="edt" Text="Edit">
            </dx:MenuItem>--%>
                                <%-- <dx:MenuItem Name="del" Text="Delete">
            </dx:MenuItem>--%>
                                <dx:MenuItem Name="miCollapseAll" Text="Collassa Tutto">
                                </dx:MenuItem>
                                <dx:MenuItem Name="miExpandAll" Text="Espandi Tutto">
                                </dx:MenuItem>
                            </Items>
                            <ClientSideEvents ItemClick="function(s, e) { ProcessNodeClick (e.item.name);}" />

                        </dx:ASPxPopupMenu>
                        <asp:SqlDataSource ID="Menu_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM [PRT_Menus] WHERE [MenuId] = @MenuId " InsertCommand="PRT_MenuInsert" InsertCommandType="StoredProcedure" OnInserted="Menu_SqlDataSource_Inserted"
                            SelectCommand="SELECT MenuId, ParentMenuId, Title, Description, Url, DisplayOrder, IsVisible, Material_Icons, Color, DefaultPage FROM PRT_Menus order by displayorder asc"
                            UpdateCommand="UPDATE PRT_Menus SET Material_Icons = @Material_Icons, ParentMenuId = @ParentMenuId, Title = @Title, Description = @Description, Url = @Url, IsVisible = @IsVisible, Color = @Color, DefaultPage = @DefaultPage, DisplayOrder = @DisplayOrder WHERE (MenuId = @MenuId)">
                            <DeleteParameters>
                                <asp:Parameter Name="MenuId" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>

                                <asp:Parameter Name="IdNew" Type="Int32" Direction="ReturnValue" />
                                <asp:Parameter Name="ParentMenuId" Type="Int32" />
                                <asp:Parameter Name="Title" Type="String" />
                                <asp:Parameter Name="Description" Type="String" />
                                <asp:Parameter Name="Url" Type="String" />
                                <asp:Parameter Name="IsVisible" Type="Boolean" />
                                <asp:Parameter Name="Material_Icons" Type="String" />
                                <asp:Parameter Name="Color" Type="String" />
                                <asp:Parameter Name="DefaultPage" />
                                <asp:Parameter Name="DisplayOrder" Type="Int32" DefaultValue="0" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="Material_Icons" Type="String" />
                                <asp:Parameter Name="ParentMenuId" Type="Int32" DefaultValue="0" />
                                <asp:Parameter Name="Title" Type="String" />
                                <asp:Parameter Name="Description" Type="String" />
                                <asp:Parameter Name="Url" Type="String" />
                                <asp:Parameter Name="IsVisible" Type="Boolean" />
                                <asp:Parameter Name="Color" Type="String" />
                                <asp:Parameter Name="DefaultPage" />
                                <asp:Parameter Name="DisplayOrder" Type="Int32" DefaultValue="0" />
                                <asp:Parameter Name="MenuId" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
    </div>
    -
    <script src="https://cdn.jsdelivr.net/npm/notiflix/dist/AIO/notiflix-aio-1.9.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="../assets/IconPicker-master/dist/iconpicker-1.5.0.js"></script>
    <script src="../assets/IconPicker-master/index-tooltip.js"></script>
    <script src="../assets/IconPicker-master/index.js?v=1.5.0"></script>


    <%--<script type='text/javascript' src="~/_Icon_picker_1/simple-iconpicker.min.js"></script>
        var whichInput = 0;

        $(document).ready(function () {
            //$('.input1').IconPicker.Run('.input1');
            //$('.input1').iconpicker(".input1");
            //    $('#inputid2').iconpicker("#inputid2");
            //    $('.input3').iconpicker(".input3");
        });
    </script>--%>
    <script>
        function Get_PopUp(btn) {
            var s = btn.id;
            alert(s);
            //$('#' + s).IconPicker('#' + s);
            IconPicker.Run('#GetIconPicker');

        };
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
    <script>
        function selezione(Ruolo) {

            const rowCheckboxes = document.querySelectorAll(`tr[name='${Ruolo}'] > td > span > input[type=checkbox]`)
            const ckhControl = document.getElementById(Ruolo);
            let state = false;
            let count = 0;
            if (ckhControl.checked === true) {
                state = true;
            }
            if (count === 0) {
                for (let index = 0; index < rowCheckboxes.length; index++) {
                    if (rowCheckboxes[index].type === "checkbox") {
                        rowCheckboxes[index].checked = state;
                    }
                }
                count++;
            }
        };

    </script>

</asp:Content>
