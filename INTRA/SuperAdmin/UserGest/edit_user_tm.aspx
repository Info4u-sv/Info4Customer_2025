<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="edit_user_tm.aspx.cs" Inherits="INTRA.SuperAdmin.UserGest.edit_user_tm" %>

<%@ Register Src="~/Controls/GestioneUtente_SuperAdmin.ascx" TagPrefix="dx" TagName="GestioneUtente_SuperAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">

    <script>
        function abilitaCampi() {
            if (typeof AnagraficaUserPanel !== "undefined") {
                AnagraficaUserPanel.PerformCallback('ABILITA');
            } else {
                console.error("AnagraficaUserPanel non definito");
            }
        }
        function nascondiEditAndRolesPanel() {
            if (typeof EditAndRolesPanel !== 'undefined') {
                EditAndRolesPanel.SetVisible(false);
                AnagraficaUser.SetVisible(false);
            }
        }
        function SalvaSelezioneRuoliECallback() {
            var roles = [];
            var checkboxes = document.querySelectorAll('#<%= UserRoles.ClientID %> input[type=checkbox]');
            checkboxes.forEach(function (cb) {
                if (cb.checked) {
                    roles.push(cb.value);
                }
            });
            EditAndRolesPanel.PerformCallback('SALVA|' + roles.join(','));
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">

        <dx:ASPxCallbackPanel ID="AnagraficaUserPanel" runat="server" ClientInstanceName="AnagraficaUserPanel" OnCallback="AnagraficaUserPanel_Callback" Visible="true">
            <%-- <ClientSideEvents EndCallback="onCallbackComplete" />--%>
            <ClientSideEvents EndCallback="function(s, e) {
    if (AnagraficaUser.cpShowPanel) {
        AnagraficaUser.SetVisible(true);
    }
}" />
            <PanelCollection>
                <dx:PanelContent>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="version-text" style="position: absolute; top: 1px; right: 45px; font-size: 13px; color: #999; font-family: 'Helvetica Neue', Arial, sans-serif; font-style: italic; z-index: 999;">
                                Versione 7/2025
                            </div>
                            <div class="card-header card-header-icon" data-background-color="red">
                                <i class="material-icons">assignment</i>
                            </div>
                            <div class="card-header">
                                <h4 class="card-title">Informazioni Utente</h4>
                            </div>
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-4">
                                        <h5 style="margin-left: 15px;">Main Info</h5>
                                        <div class="card shadow-sm mb-4" style="margin-left: 15px;">
                                            <div class="card-header bg-primary text-white">
                                                <h6>Dettagli Utente</h6>
                                            </div>
                                            <div class="card-body" style="padding: 15px 20px;">
                                                <asp:DetailsView runat="server" ID="InfoUser" AutoGenerateRows="false">
                                                    <Fields>
                                                        <asp:BoundField DataField="UserName" HeaderText="User Name" ReadOnly="True" />
                                                        <asp:BoundField DataField="Email" HeaderText="Email" />
                                                        <asp:BoundField DataField="Comment" HeaderText="Comment" />
                                                        <asp:CheckBoxField DataField="IsApproved" HeaderText="Active User" />
                                                        <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Is Locked Out" ReadOnly="true" />
                                                        <asp:CheckBoxField DataField="IsOnline" HeaderText="Is Online" ReadOnly="True" />
                                                        <asp:BoundField DataField="CreationDate" HeaderText="CreationDate" ReadOnly="True" />
                                                        <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" ReadOnly="True" />
                                                        <asp:BoundField DataField="LastLoginDate" HeaderText="LastLoginDate" ReadOnly="True" />
                                                        <asp:BoundField DataField="LastLockoutDate" HeaderText="LastLockoutDate" ReadOnly="True" />
                                                        <asp:BoundField DataField="LastPasswordChangedDate" HeaderText="LastPasswordChangedDate" ReadOnly="True" />
                                                    </Fields>
                                                </asp:DetailsView>
                                                <br />
                                                <div>
                                                    <dx:BootstrapButton runat="server"
                                                        Text='Modifica Utente'
                                                        ID="btnModificaUtente"
                                                        AutoPostBack="False"
                                                        Badge-CssClass="BadgeBtn-just-icon"
                                                        CssClasses-Control="btn btn-primary">
                                                        <ClientSideEvents Click="function(s,e){
                                                        AnagraficaUserPanel.PerformCallback('ABILITA');
                                                        EditAndRolesPanel.PerformCallback('LOAD');
                                                         showNotification();
                                                    }" />
                                                        <Badge IconCssClass="fa fa-user-edit" />
                                                        <SettingsBootstrap Sizing="Large" />
                                                    </dx:BootstrapButton>

                                                    <dx:BootstrapButton runat="server"
                                                        AutoPostBack="False"
                                                        Text='Cancella'
                                                        Badge-CssClass="BadgeBtn-just-icon"
                                                        CssClasses-Control="btn btn-secondary">
                                                        <ClientSideEvents Click="function(s,e){
                                                        showNotification();
                                                        nascondiEditAndRolesPanel();
                                                    }" />
                                                        <Badge IconCssClass="fa fa-times" />
                                                        <SettingsBootstrap Sizing="Large" />
                                                    </dx:BootstrapButton>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="margin-left: 15px;">
                                            <dx:GestioneUtente_SuperAdmin runat="server" id="GestioneUtente_SuperAdmin" RefreshPanel="Refresh_pnl" />
                                        </div>
                                    </div>

                                    <dx:ASPxCallbackPanel ID="EditAndRolesPanel" runat="server" ClientInstanceName="EditAndRolesPanel" OnCallback="EditAndRolesPanel_Callback" ClientVisible="false">
                                        <ClientSideEvents EndCallback="function(s,e){
        if(s.cpShowPanel){
            s.SetVisible(true);
        }
    }" />
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <asp:HiddenField ID="HiddenSelectedRoles" runat="server" />
                                                <div class="container-fluid">
                                                    <div class="row">

                                                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4 text-start">
                                                            <h5>Roles</h5>

                                                            <asp:CheckBoxList
                                                                ID="UserRoles"
                                                                runat="server"
                                                                RepeatLayout="Flow"
                                                                RepeatDirection="Vertical"
                                                                CssClass="text-start"
                                                                AutoPostBack="false">
                                                            </asp:CheckBoxList>
                                                            <br />
                                                            <dx:BootstrapButton ID="BtnSalvaRuoli" runat="server"
                                                                AutoPostBack="False"
                                                                CssClasses-Control="btn btn-success mt-2"
                                                                Text='Salva Ruoli' Badge-CssClass="BadgeBtn-just-icon">
                                                                <ClientSideEvents Click="function(s,e){
            e.processOnServer = false;
            SalvaSelezioneRuoliECallback();
            showNotification();
        }" />
                                                                <Badge IconCssClass="fa fa-save" />
                                                                <SettingsBootstrap Sizing="Large" />
                                                            </dx:BootstrapButton>
                                                        </div>

                                                        <div class="col-lg-4 col-md-4 col-sm-12 mb-4">
                                                            <div class="card">
                                                                <div class="card-header card-header-icon" data-background-color="red">
                                                                    <i class="material-icons">assignment</i>
                                                                </div>
                                                                <div class="card-content">
                                                                    <h4 class="card-title">Stai modificando</h4>

                                                                    <strong>Nome Utente</strong>:&nbsp;<asp:Label ID="UserTxt" runat="server"></asp:Label><br />
                                                                    <strong>E-mail</strong>:&nbsp;<asp:Label ID="RegMailTxt" runat="server"></asp:Label>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-4 col-md-4 col-sm-12 mb-4">
                                                            <div class="card">
                                                                <div class="card-header card-header-icon" data-background-color="red">
                                                                    <i class="material-icons">assignment</i>
                                                                </div>
                                                                <div class="card-content">
                                                                    <h4 class="card-title">Cambia Password</h4>
                                                                    <strong>Inserisci Nuova Password:</strong><br />
                                                                    <dx:ASPxTextBox ID="NewPassword_Txt" runat="server" Width="100%" Password="true" Theme="Office365"></dx:ASPxTextBox>
                                                                    <br />
                                                                    <dx:BootstrapButton ID="Button3" runat="server"
                                                                        AutoPostBack="True"
                                                                        CssClasses-Control="btn btn-warning shiny"
                                                                        Text='Modifica Password'
                                                                        Badge-CssClass="BadgeBtn-just-icon"
                                                                        OnClick="Button3_Click">
                                                                        <ClientSideEvents Click="function(s, e) { showNotification(); }" />
                                                                        <Badge IconCssClass="fa fa-key" />
                                                                        <SettingsBootstrap Sizing="Large" />

                                                                    </dx:BootstrapButton>
                                                                </div>
                                                                <!--fine horizontal-->
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

                    <dx:ASPxCallbackPanel ID="AnagraficaUser" runat="server" ClientInstanceName="AnagraficaUser" ClientVisible="false">

                        <ClientSideEvents EndCallback="function(s, e) {
        if (s.cpShowPanel) {
            s.SetVisible(true);
        }
    }" />
                        <PanelCollection>
                            <dx:PanelContent>
                                <%--sezione anagrafica utente--%>

                                <div class="col-md-12 mt-5">
                                    <div class="card">
                                        <div class="card-header card-header-icon" data-background-color="red">
                                            <i class="material-icons">assignment</i>
                                        </div>
                                        <div class="card-header">
                                            <h4 class="card-title">Anagrafica Utente</h4>
                                        </div>
                                        <div class="col-xs-12 col-md-6 col-sm-12 col-lg-12" style="padding-top: 10px;">

                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">


                                                <label class="control-label" for="NomeTxt" style="color: Red;">
                                                    Nome*:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="NomeTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <ValidationSettings ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </div>
                                            </div>

                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="CognomeTxt" style="color: Red;">
                                                    Cognome*:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="CognomeTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <ValidationSettings ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/cognome-->
                                            <!--Società-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="SocietaTxt">
                                                    Società:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="SocietaTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/società-->
                                            <!--Tipo società-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="TipoSocietaTxt">
                                                    Tipo Società:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="TipoSocietaTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/Tipo società-->
                                            <!--Telefono-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="TelPrivTxt">
                                                    Telefono:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="TelPrivTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <MaskSettings Mask="(999)99-99-999" ErrorText="Inserire un numero di cellulare valido." />
                                                        <ValidationSettings ErrorTextPosition="Bottom"></ValidationSettings>
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/telefono-->
                                            <!--Fax-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="TelPrivTxt">
                                                    Fax:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="FaxPrivTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-xs-12 col-md-6 col-sm-12 col-lg-12" style="padding-top: 10px;">

                                            <!--/fax-->
                                            <!--Email di contatto-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="ContactMailTxt" style="color: red;">
                                                    Email di contatto*:</label>
                                                <div class="controls">

                                                    <dx:ASPxTextBox ID="ContactMailTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <ValidationSettings ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto." />
                                                            <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="L'email non è valida." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/email di contatto-->
                                            <!--Codice fiscale-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="CodFiscPrivTxt">
                                                    Codice fiscale:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="CodFiscPrivTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/codice fiscale-->
                                            <!--Indirizzo-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="IndPrivTxt" style="color: Red;">
                                                    Indirizzo*:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="IndPrivTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <ValidationSettings ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/indirizzo-->
                                            <!--CAP-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="CapPrivTxt" style="color: Red;">
                                                    CAP*:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="CapPrivTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <ValidationSettings ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto." />
                                                        </ValidationSettings>
                                                        <MaskSettings Mask="00000" ErrorText="Inserire un CAP valido." />

                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/CAP-->
                                            <!--Città-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="CittaPrivTxt" style="color: Red;">
                                                    Città*:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="CittaPrivTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <ValidationSettings ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>

                                                </div>
                                            </div>
                                            <!--/città-->
                                            <!--Provincia-->
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <label class="control-label" for="ProvPrivTxt" style="color: Red;">
                                                    Provincia*:</label>
                                                <div class="controls">
                                                    <dx:ASPxTextBox ID="ProvPrivTxt" runat="server" Width="100%" Theme="Office365" ClientEnabled="false">
                                                        <ValidationSettings ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Il campo non può essere vuoto." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-md-6 col-sm-12 col-lg-12" style="padding-top: 10px;">

                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <dx:BootstrapButton ID="FirmaTecnico_LinkB" runat="server"
                                                    AutoPostBack="True"
                                                    OnClick="FirmaTecnico_LinkB_Click"
                                                    CssClasses-Control="btn btn-azure btn-labeled"
                                                    Text='Carica Firma'
                                                    Badge-CssClass="BadgeBtn-just-icon"
                                                    ToolTip="Aggiorna i dati">
                                                    <Badge IconCssClass="fa fa-upload" />
                                                    <SettingsBootstrap Sizing="Large" />

                                                </dx:BootstrapButton>
                                            </div>
                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-2">
                                                <dx:BootstrapButton ID="btnSaveRegister" runat="server"
                                                    AutoPostBack="True"
                                                    CssClasses-Control="btn btn-success btn-labeled"
                                                    Text='Aggiorna i dati'
                                                    Badge-CssClass="BadgeBtn-just-icon"
                                                    CausesValidation="true"
                                                    OnClick="BtnSaveRegister_Click">
                                                    <ClientSideEvents Click="function(s, e) {
                                                    showNotification();
                                                }" />
                                                    <Badge IconCssClass="fa fa-save" />
                                                    <SettingsBootstrap Sizing="Large" />
                                                </dx:BootstrapButton>
                                            </div>

                                        </div>

                                        <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12" style="padding-top: 10px;">


                                            <div class="col-xs-12 col-md-6 col-sm-12 col-lg-6">
                                                <label class="control-label" for="ProvPrivTxt" style="color: Red;">
                                                    Firma*:</label>
                                                <div class="controls">
                                                    <img id="firmaTecnico" class="img-responsive" src="" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-6">
                                                <label class="control-label" for="ProvPrivTxt" style="color: Red;">
                                                    Avatar*:</label>
                                                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                                    <div class="upload-msg" style="margin: 0px !important;">
                                                        Carica un immagine
                                                    </div>
                                                    <div id="upload-demo" style="margin: 0px !important"></div>
                                                    <%--   <div class="actions">--%>

                                                    <a class="btn file-btn">
                                                        <span>Upload</span>
                                                        <input type="file" id="upload" value="Choose a file" accept="image/*" />
                                                    </a>

                                                    <%-- <button class="upload-result1">Result</button>--%>
                                                    <button id="expcoll" class="upload-result" onclick="return false;" runat="server">Carica</button>
                                                    <%--     </div>--%>
                                                </div>
                                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                                    <img id="ImgTecnico" src="" class="header-avatar" runat="server" />
                                                    <textarea id="ImgTextArea" cols="20" rows="2" runat="server" style="display: none"></textarea>

                                                </div>

                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>

        <div class="col-md-12 mt-5">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="red">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-header">
                    <h4 class="card-title">Gestione Permessi Utente</h4>
                </div>
                <div class="card-body">
                    <dx:ASPxCallbackPanel ID="PrivilegesPanel" runat="server" ClientInstanceName="PrivilegesPanel" OnCallback="PrivilegesPanel_Callback">
                        <ClientSideEvents EndCallback="function(s,e){
                findUnselectedCheckboxes('chkBoxAddPermission', 'Add');
                findUnselectedCheckboxes('chkBoxDeletePermission', 'Delete');
                findUnselectedCheckboxes('chkBoxModifyPermission', 'Modify');
                findUnselectedCheckboxes('chkBoxReadPermission', 'Read');
            }" />
                        <PanelCollection>
                            <dx:PanelContent>
                                <asp:GridView ID="grdPrivileges" runat="server" Width="100%" AutoGenerateColumns="False" ClientIDMode="Predictable"
                                    DataKeyNames="MenuId" GridLines="None">
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
                                                            <th style="width: 10%" align="center" colspan="4">
                                                                <span style="font-size: 13px;">Permission</span><br />
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 10%; height: 20px; text-align: center;">
                                                                <span style="font-size: 13px;">Add</span><br />
                                                                <asp:CheckBox ID="chkBoxAddPermission" runat="server" OnClick="checkAll(this, 'chkBoxAdd', 'Add');" />
                                                            </th>
                                                            <th style="width: 10%; height: 20px; text-align: center;">
                                                                <span style="font-size: 13px;">Delete</span><br />
                                                                <asp:CheckBox ID="chkBoxDeletePermission" runat="server" OnClick="checkAll(this, 'chkBoxDelete', 'Delete');" />
                                                            </th>
                                                            <th style="width: 10%; height: 20px; text-align: center;">
                                                                <span style="font-size: 13px;">Modify</span><br />
                                                                <asp:CheckBox ID="chkBoxModifyPermission" runat="server" OnClick="checkAll(this, 'chkBoxModify', 'Modify');" />
                                                            </th>
                                                            <th style="width: 10%; height: 20px; text-align: center;">
                                                                <span style="font-size: 13px;">Read</span><br />
                                                                <asp:CheckBox ID="chkBoxReadPermission" runat="server" OnClick="checkAll(this, 'chkBoxRead', 'Read');" />
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
                                                        </td>
                                                        <td style="width: 10%" align="center">
                                                            <asp:CheckBox ID="chkBoxAdd" runat="server" Checked='<%# Bind("add_permission") %>'
                                                                OnClick="findUnselectedCheckboxes('chkBoxAddPermission', 'Add');" CssClass="checkBox" />
                                                        </td>
                                                        <td style="width: 10%" align="center">
                                                            <asp:CheckBox ID="chkBoxDelete" runat="server" Checked='<%# Bind("delete_permission") %>'
                                                                OnClick="findUnselectedCheckboxes('chkBoxDeletePermission', 'Delete');" CssClass="checkBox" />
                                                        </td>
                                                        <td style="width: 10%" align="center">
                                                            <asp:CheckBox ID="chkBoxModify" runat="server" Checked='<%# Bind("modify_permission") %>'
                                                                OnClick="findUnselectedCheckboxes('chkBoxModifyPermission', 'Modify');" CssClass="checkBox" />
                                                        </td>
                                                        <td style="width: 10%" align="center">
                                                            <asp:CheckBox ID="chkBoxRead" runat="server" Checked='<%# Bind("read_permission") %>'
                                                                OnClick="findUnselectedCheckboxes('chkBoxReadPermission', 'Read');" CssClass="checkBox" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                                <div style="float: right; padding-top: 20px">
                                    <dx:BootstrapButton ID="UpdatePermessi_Btn" runat="server"
                                        AutoPostBack="False"
                                        CssClasses-Control="btn btn-info"
                                        Badge-CssClass="BadgeBtn-just-icon"
                                        Text='Aggiorna Permessi'>
                                        <ClientSideEvents Click="function(s, e) {
                                        showNotification();
                                        PrivilegesPanel.PerformCallback('save');
                                    }" />
                                        <Badge IconCssClass="fa fa-shield-alt" />
                                        <SettingsBootstrap Sizing="Large" />
                                    </dx:BootstrapButton>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
    <style>
        .btn.btn-primary, .btn.btn-secondary {
            background-color: #0055A6;
            color: #ffffff;
        }

            .btn.btn-primary:hover, .btn.btn:hover, .btn.btn-secondary:hover {
                background-color: #0055A6;
                color: #ffffff;
            }

            .btn.btn-primary:focus {
                background-color: #0055A6;
                color: #ffffff;
            }
    </style>
</asp:Content>
