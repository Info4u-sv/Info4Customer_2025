<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_DropDown_Elementi.aspx.cs" Inherits="INTRA.SuperAdmin.PRT_CRUD.PRT_DropDown_Elementi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <%-- Script necessari per il Drag & Drop --%>
    <script src="../../assets/js/draggable/jquery-ui.min.js"></script>
    <script src="../../assets/js/draggable/jquery.ui.touch-punch.min.js"></script>
    <style>
        .hover {
            background-color: lightblue;
        }

        .activeHover {
            background-color: lightgray;
        }

        .ui-draggable-dragging {
            background-color: lightgreen;
            color: White;
        }
    </style>
    <script type="text/javascript">
        var states = [];

        function InitalizejQuery() {
            //$('.draggable').draggable({
            //    helper: 'clone',
            //    start: function (ev, ui) {
            //        var $draggingElement = $(ui.helper);
            //        $draggingElement.width(Generic_Gridview.GetWidth());
            //    }
            //});
            //$('.draggable').droppable({
            //    activeClass: "hover",
            //    tolerance: "intersect",
            //    hoverClass: "activeHover",
            //    drop: function (event, ui) {
            //        var draggingSortIndex = ui.draggable.attr("sortOrder");
            //        var targetSortIndex = $(this).attr("sortOrder");
            //        MakeAction("DRAGROW|" + draggingSortIndex + '|' + targetSortIndex);
            //    }
            //});
        }
        function UpdatedGridViewButtonsState(grid) {
            btMoveUp.SetEnabled(Generic_Gridview.cpbtMoveUp_Enabled);
            btMoveDown.SetEnabled(Generic_Gridview.cpbtMoveDown_Enabled);
        }

        function Generic_Gridview_Init(s, e) {
            UpdatedGridViewButtonsState(s);
        }

        function Generic_Gridview_EndCallback(s, e) {
            UpdatedGridViewButtonsState(s);
            NextAction();
        }

        function btMoveUp_Click(s, e) {
            MakeAction("MOVEUP");
        }

        function btMoveDown_Click(s, e) {
            MakeAction("MOVEDOWN");
        }

        function MakeAction(action) {
            if (Generic_Gridview.InCallback())
                states.push(action)
            else
                Generic_Gridview.PerformCallback(action)
        }

        function NextAction() {
            if (states.length != 0) {
                var currentState = states.shift();
                if (currentState == "MOVEUP" && Generic_Gridview.cpbtMoveUp_Enabled)
                    Generic_Gridview.PerformCallback(currentState);
                else if (currentState == "MOVEDOWN" && Generic_Gridview.cpbtMoveDown_Enabled)
                    Generic_Gridview.PerformCallback(currentState);
                else if (currentState.indexOf("DRAGROW") != -1)
                    Generic_Gridview.PerformCallback(currentState);
                else
                    NextAction();
            }
        }

    </script>
    <%--    script per gestione upload--%>

    <script type="text/javascript">
        function OnFileUploadComplete(s, e) {
            if (e.callbackData !== "") {
                lblFileName.SetText(e.callbackData);
                IconPathImg_Edit.SetImageUrl(e.callbackData);
                Icon_switch.SetVisible(true);
                btnDeleteFile.SetVisible(true);
            }
        }
        function OnClick(s, e) {
            callback.PerformCallback(lblFileName.GetText());
        }
        function OnCallbackComplete(s, e) {
            if (e.result === "ok") {
                lblFileName.SetText(null);
                btnDeleteFile.SetVisible(false);
            }
        }
    </script>
    <%--  Fine script per gestione upload--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-lg-12">
            <dx:ASPxButton ID="btMoveUp" runat="server" Text="Up" Width="100px" AutoPostBack="false" ClientInstanceName="btMoveUp">
                <ClientSideEvents Click="btMoveUp_Click" />
            </dx:ASPxButton>
            <dx:ASPxButton ID="btMoveDown" runat="server" Text="Down" Width="100px" AutoPostBack="false" ClientInstanceName="btMoveDown">
                <ClientSideEvents Click="btMoveDown_Click" />
            </dx:ASPxButton>
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">
                            <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="callback" OnCallback="ASPxCallback1_Callback">
                                <ClientSideEvents CallbackComplete="OnCallbackComplete" />
                            </dx:ASPxCallback>

                            <%--<dx:ASPxCallback ID="ASPxCallback1" OnHtmlRowPrepared="Generic_Gridview_HtmlRowPrepared" runat="server" ClientInstanceName="callback" OnCallback="ASPxCallback1_Callback" OnRowInserting="Generic_Gridview_RowInserting" OnCustomCallback="Generic_Gridview_CustomCallback" SettingsBehavior-ConfirmDelete="true" OnRowUpdating="Generic_Gridview_RowUpdating" OnHtmlDataCellPrepared="Generic_Gridview_HtmlDataCellPrepared">
                                <ClientSideEvents CallbackComplete="OnCallbackComplete" />
                            </dx:ASPxCallback>--%>
                            <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" OnHtmlRowPrepared="Generic_Gridview_HtmlRowPrepared" OnRowInserting="Generic_Gridview_RowInserting" OnCustomJSProperties="Generic_Gridview_CustomJSProperties" DataSourceID="Generic_Dts" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID" OnCustomErrorText="Generic_Gridview_CustomErrorText" OnRowUpdating="Generic_Gridview_RowUpdating" OnCancelRowEditing="Generic_Gridview_CancelRowEditing" OnRowDeleting="Generic_Gridview_RowDeleting" OnCustomCallback="Generic_Gridview_CustomCallback">
                                <SettingsPopup>
                                    <EditForm AllowResize="True" Modal="True" VerticalAlign="WindowCenter" HorizontalAlign="WindowCenter">
                                    </EditForm>

                                    <HeaderFilter MinHeight="140px"></HeaderFilter>
                                </SettingsPopup>
                                <SettingsBehavior AutoExpandAllGroups="true" />
                                <SettingsBehavior ConfirmDelete="true" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                                <SettingsText ConfirmDelete="Confermi l'eliminazione?" />
                                <Styles>
                                    <Row CssClass="draggable"></Row>
                                </Styles>
                                <SettingsBehavior AllowSort="false" AllowFocusedRow="true" ProcessFocusedRowChangedOnServer="True" />
                                <SettingsPager PageSize="10" />
                                <ClientSideEvents Init="Generic_Gridview_Init" EndCallback="Generic_Gridview_EndCallback" />
                                <SettingsAdaptivity>
                                    <AdaptiveDetailLayoutProperties ColCount="2">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                    </AdaptiveDetailLayoutProperties>
                                </SettingsAdaptivity>
                                <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                                <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                <SettingsCommandButton>
                                    <NewButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Nuovo" Url="../../img/DevExButton/new.png" Width="30px"></Image>
                                    </NewButton>
                                    <UpdateButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Aggiorna" Height="30px" Url="../../img/DevExButton/update.png" Width="30px"></Image>
                                    </UpdateButton>
                                    <CancelButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Annulla" Height="30px" Url="../../img/DevExButton/cancel.png" Width="30px"></Image>
                                    </CancelButton>
                                    <EditButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Modifica" Height="30px" Url="../../img/DevExButton/edit.png" Width="30px"></Image>
                                    </EditButton>
                                    <DeleteButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Elimina" Height="30px" Url="../../img/DevExButton/delete.png" Width="30px"></Image>
                                    </DeleteButton>
                                </SettingsCommandButton>
                                <%--          <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter">
                                    <EditForm HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" AllowResize="True" Modal="True"></EditForm>
                                </SettingsPopup>--%>
                                <SettingsSearchPanel Visible="True" />
                                <EditFormLayoutProperties ColCount="2">
                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                </EditFormLayoutProperties>
                                <Columns>
                                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="TextField" VisibleIndex="3" EditFormSettings-ColumnSpan="1">
                                        <PropertiesTextEdit>
                                            <ValidationSettings CausesValidation="True" Display="Dynamic">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>

                                        <EditFormSettings ColumnSpan="2"></EditFormSettings>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Color" VisibleIndex="3" EditFormSettings-ColumnSpan="1">
                                        <PropertiesTextEdit>
                                            <ValidationSettings CausesValidation="True" Display="Dynamic">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                        <Settings FilterMode="Value" AutoFilterCondition="Default" AllowHeaderFilter="True" />
                                        <DataItemTemplate>
                                            <div style='width: 20px; background-color: <%# Eval("Color") %>; float: left; border: 1px solid'>&nbsp;</div>
                                            <div style='float: left; text-transform: uppercase;'>&nbsp;&nbsp;<%# Eval("Color") %></div>
                                        </DataItemTemplate>
                                        <EditItemTemplate>
                                            <dx:ASPxColorEdit runat="server" EnableCustomColors="true" ID="ColorEditHeaderBackColor" Color='<%# GetColor(Eval("Color")) %>' Width="100%" ClearButton-DisplayMode="Never">
                                            </dx:ASPxColorEdit>
                                        </EditItemTemplate>
                                        <EditFormSettings ColumnSpan="1"></EditFormSettings>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ValueField" VisibleIndex="6">
                                        <PropertiesTextEdit>
                                            <ValidationSettings CausesValidation="True" Display="Dynamic">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn VisibleIndex="4" ReadOnly="true" Caption="ID DD Famiglia">
                                        <Settings FilterMode="Value" AutoFilterCondition="Default" AllowHeaderFilter="True" />
                                        <DataItemTemplate>
                                            <%# Eval("DropDown_Famiglia") %>
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn VisibleIndex="4" ReadOnly="true" Caption="CodFamilyFilter" FieldName="CodFamilyFilter" >
                                        <Settings FilterMode="Value" AutoFilterCondition="Default" AllowHeaderFilter="True" />
                                        <DataItemTemplate>
                                            <%# Eval("CodFamilyFilter") %>
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="7" SortOrder="Ascending">
                                        <PropertiesTextEdit>
                                            <ValidationSettings CausesValidation="True" Display="Dynamic">
                                                <RequiredField IsRequired="True" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Selected" VisibleIndex="8">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="DropDown_Famiglia" VisibleIndex="5" EditFormSettings-ColumnSpan="2" GroupIndex="1">
                                        <PropertiesComboBox DataSourceID="PRT_DropDown_Famglia_Dts" ValueField="DropDown_Famiglia" TextField="Titolo">
                                        </PropertiesComboBox>

                                        <EditFormSettings ColumnSpan="2"></EditFormSettings>
                                        <EditItemTemplate>
                                            <dx:ASPxComboBox runat="server" ID="ComboboxFamiglia" TextFormatString="{0}" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>" ClientInstanceName="ComboboxFamiglia" DataSourceID="PRT_DropDown_Famglia_Dts" ValueField="DropDown_Famiglia" TextField="Titolo" Value='<%# Eval("DropDown_Famiglia") %>' ValueType="System.Int32">
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="Titolo" />
                                                    <dx:ListBoxColumn FieldName="ConImmagine" />
                                                </Columns>
                                                <ClientSideEvents
                                                    SelectedIndexChanged="function(s,e){var Index = s.GetSelectedIndex();if(Index > -1)
                                                    {
                                                    var item = ComboboxFamiglia.GetSelectedItem();
                                                    
                                                    if (item.GetColumnText(1) == 'True'){ ASPxUploadControl1.SetEnabled(true); lblFileName.SetEnabled(true); lblFileName.SetText(null); lblFileName.SetVisible(true) ;
                                                    }else{ASPxUploadControl1.SetEnabled(false);lblFileName.SetVisible(false); lblFileName.SetText('ND1') ;}                                                                                            
                                                    }else{ASPxUploadControl1.SetEnabled(false);lblFileName.SetVisible(false); lblFileName.SetText('ND1');}}" />
                                                <ValidationSettings CausesValidation="True" Display="Dynamic">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </EditItemTemplate>
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Calendar" VisibleIndex="11">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="EditEnabled" VisibleIndex="11">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataSpinEditColumn FieldName="ValueFieldNumber" VisibleIndex="11" PropertiesSpinEdit-DecimalPlaces="0">
                                    </dx:GridViewDataSpinEditColumn>

                                    <dx:GridViewDataCheckColumn FieldName="TaskAbilita" VisibleIndex="11">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="SingleTask" VisibleIndex="11">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataTextColumn FieldName="WidthArea" VisibleIndex="11">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataSpinEditColumn FieldName="ParentID" VisibleIndex="11" PropertiesSpinEdit-MinValue="0" PropertiesSpinEdit-MaxValue="9999999">
                                    </dx:GridViewDataSpinEditColumn>
                                    <dx:GridViewDataTextColumn FieldName="IconPath" VisibleIndex="2">
                                        <Settings FilterMode="Value" AutoFilterCondition="Default" AllowHeaderFilter="True" />
                                        <DataItemTemplate>
                                            <dx:ASPxImage ImageUrl='<%# Eval("IconPath") %>' runat="server" ID="IconPath1" Width="30px" Height="30px"></dx:ASPxImage>
                                        </DataItemTemplate>
                                        <EditItemTemplate>
                                            <dx:ASPxImage ImageUrl='<%# Eval("IconPath") %>' runat="server" ID="IconPathImg_Saved" ClientInstanceName="IconPathImg_Edit" Width="30px" Height="30px"></dx:ASPxImage>
                                            <dx:ASPxImage ImageUrl='../../img/DevExButton/Sostituisci.png' ClientVisible="false" runat="server" ID="Icon_switch" ClientInstanceName="Icon_switch" Width="45px" Height="45px"></dx:ASPxImage>
                                            <dx:ASPxImage ImageUrl='#' runat="server" ID="IconPathImg_Edit" ClientInstanceName="IconPathImg_Edit" Width="30px" Height="30px"></dx:ASPxImage>
                                            <br />
                                            <dx:ASPxLabel ID="lblAllowebMimeType" runat="server" Text="Immagini ammesse types: jpeg, jpg, png" Font-Size="8pt" />
                                            <br />
                                            <dx:ASPxLabel ID="lblMaxFileSize" runat="server" Text="Maximum file size: 4Mb" Font-Size="8pt" />
                                            <br />
                                            <dx:ASPxUploadControl ID="ASPxUploadControl1" ClientInstanceName="ASPxUploadControl1" ShowProgressPanel="true" UploadMode="Auto" AutoStartUpload="true" FileUploadMode="OnPageLoad"
                                                OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete" runat="server">
                                                <ValidationSettings MaxFileSize="4194304" MaxFileSizeErrorText="Size of the uploaded file exceeds maximum file size" AllowedFileExtensions=".jpg,.jpeg,.png">
                                                </ValidationSettings>
                                                <ClientSideEvents FileUploadComplete="OnFileUploadComplete" FilesUploadStart="function(s,e){ASPxUploadControl1.cpFamigliaFoto = ComboboxFamiglia.GetText();}"
                                                    Init="function(s,e){var Index = ComboboxFamiglia.GetSelectedIndex();if(Index > -1){ASPxUploadControl1.SetEnabled(true);lblFileName.SetVisible(true);}else{ ASPxUploadControl1.SetEnabled(false);lblFileName.SetVisible(false);}}" />
                                            </dx:ASPxUploadControl>
                                            <br />

                                            <%--<dx:ASPxLabel ID="lblFileName" runat="server" ClientInstanceName="lblFileName" Font-Size="8pt" />--%>
                                            <dx:ASPxTextBox ID="lblFileName" runat="server" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>" Width="170px" ClientInstanceName="lblFileName" ClientEnabled="true" Text='<%# Eval("IconPath") %>'>
                                                <ValidationSettings>
                                                    <RequiredField IsRequired="true" ErrorText="Richiesto" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>

                                            <dx:ASPxButton ID="btnDeleteFile" RenderMode="Link" runat="server" ClientVisible="false" ClientInstanceName="btnDeleteFile" AutoPostBack="false" Text="Remove">
                                                <ClientSideEvents Click="OnClick" />
                                            </dx:ASPxButton>
                                        </EditItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>
                            <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM PRT_DropDown_Elementi WHERE (ID = @ID)" InsertCommand="INSERT INTO PRT_DropDown_Elementi(IconPath, DisplayOrder, DropDown_Famiglia, ValueField, TextField, Selected, Color, Calendar, EditEnabled, ValueFieldNumber, TaskAbilita, SingleTask, WidthArea, ParentID) VALUES (@IconPath, @DisplayOrder, @DropDown_Famiglia, @ValueField, @TextField, @Selected, @Color, @Calendar, @EditEnabled, @ValueFieldNumber, @TaskAbilita, @SingleTask, @WidthArea, @ParentID)" SelectCommand="SELECT PRT_DropDown_Elementi.ID, PRT_DropDown_Elementi.IconPath, PRT_DropDown_Elementi.DisplayOrder, PRT_DropDown_Elementi.DropDown_Famiglia, PRT_DropDown_Elementi.ValueField, PRT_DropDown_Elementi.TextField, PRT_DropDown_Elementi.Selected, PRT_DropDown_Elementi.Color, PRT_DropDown_Elementi.Calendar, PRT_DropDown_Elementi.EditEnabled, PRT_DropDown_Elementi.ValueFieldNumber, PRT_DropDown_Elementi.TaskAbilita, PRT_DropDown_Elementi.SingleTask, PRT_DropDown_Elementi.WidthArea, PRT_DropDown_Elementi.ParentID, PRT_DropDown_Famglia.CodFamilyFilter FROM PRT_DropDown_Elementi INNER JOIN PRT_DropDown_Famglia ON PRT_DropDown_Elementi.DropDown_Famiglia = PRT_DropDown_Famglia.ID" UpdateCommand="UPDATE PRT_DropDown_Elementi SET IconPath = @IconPath, DisplayOrder = @DisplayOrder, DropDown_Famiglia = @DropDown_Famiglia, ValueField = @ValueField, TextField = @TextField, Selected = @Selected, Color = @Color, Calendar = @Calendar, EditEnabled = @EditEnabled, ValueFieldNumber = @ValueFieldNumber, TaskAbilita = @TaskAbilita, SingleTask = @SingleTask, WidthArea = @WidthArea, ParentID = @ParentID WHERE (ID = @ID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="IconPath" />
                                    <asp:Parameter Name="DisplayOrder" />
                                    <asp:Parameter Name="DropDown_Famiglia" />
                                    <asp:Parameter Name="ValueField" />
                                    <asp:Parameter Name="TextField" />
                                    <asp:Parameter Name="Selected" />
                                    <asp:Parameter Name="Color"></asp:Parameter>
                                    <asp:Parameter Name="Calendar"></asp:Parameter>
                                    <asp:Parameter Name="EditEnabled"></asp:Parameter>
                                    <asp:Parameter Name="ValueFieldNumber"></asp:Parameter>
                                    <asp:Parameter Name="TaskAbilita"></asp:Parameter>
                                    <asp:Parameter Name="SingleTask"></asp:Parameter>
                                    <asp:Parameter Name="WidthArea"></asp:Parameter>
                                    <asp:Parameter Name="ParentID"></asp:Parameter>
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="IconPath" />
                                    <asp:Parameter Name="DisplayOrder" />
                                    <asp:Parameter Name="DropDown_Famiglia" />
                                    <asp:Parameter Name="ValueField" />
                                    <asp:Parameter Name="TextField" />
                                    <asp:Parameter Name="Selected" />
                                    <asp:Parameter Name="Color" />
                                    <asp:Parameter Name="Calendar"></asp:Parameter>
                                    <asp:Parameter Name="EditEnabled"></asp:Parameter>
                                    <asp:Parameter Name="ValueFieldNumber"></asp:Parameter>
                                    <asp:Parameter Name="TaskAbilita"></asp:Parameter>
                                    <asp:Parameter Name="SingleTask"></asp:Parameter>
                                    <asp:Parameter Name="WidthArea"></asp:Parameter>
                                    <asp:Parameter Name="ParentID"></asp:Parameter>
                                    <asp:Parameter Name="ID"></asp:Parameter>
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsHelper" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
                                SelectCommand="SELECT ID FROM PRT_DropDown_Elementi WHERE (DisplayOrder = @DisplayOrder)" UpdateCommand="UPDATE PRT_DropDown_Elementi SET DisplayOrder = @DisplayOrder WHERE (ID = @ID)">
                                <SelectParameters>
                                    <asp:Parameter Name="DisplayOrder" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="DisplayOrder" />
                                    <asp:Parameter Name="ID" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="PRT_DropDown_Famglia_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT ID as DropDown_Famiglia, Titolo, ConImmagine FROM PRT_DropDown_Famglia"></asp:SqlDataSource>

                            <dx:ASPxGlobalEvents ID="ge" runat="server">
                                <ClientSideEvents ControlsInitialized="InitalizejQuery" EndCallback="InitalizejQuery" />
                            </dx:ASPxGlobalEvents>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
