<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TCK_AreaCompetenza.aspx.cs" Inherits="INTRA.SuperAdmin.TCK_CRUD.TCK_AreaCompetenza" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <%-- Script necessari per il Drag & Drop --%>
    <script src="../../assets/js/draggable/jquery-ui.min.js"></script>
    <script src="../../assets/js/draggable/jquery.ui.touch-punch.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
            $('.draggable').draggable({
                helper: 'clone',
                start: function (ev, ui) {
                    var $draggingElement = $(ui.helper);
                    $draggingElement.width(Generic_Gridview.GetWidth());
                }
            });
            $('.draggable').droppable({
                activeClass: "hover",
                tolerance: "intersect",
                hoverClass: "activeHover",
                drop: function (event, ui) {
                    var draggingSortIndex = ui.draggable.attr("sortOrder");
                    var targetSortIndex = $(this).attr("sortOrder");
                    MakeAction("DRAGROW|" + draggingSortIndex + '|' + targetSortIndex);
                }
            });
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
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header card-header-text" data-background-color="orange">
                    <h4 class="card-title">Area Competenza Crud</h4>
                </div>
                <div class="card-content">
                    <div class="row">
                        <div class="col-lg-12">
                            <dx:ASPxButton ID="btMoveUp" runat="server" Text="Up" Width="100px" AutoPostBack="false" ClientInstanceName="btMoveUp">
                                <ClientSideEvents Click="btMoveUp_Click" />
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btMoveDown" runat="server" Text="Down" Width="100px" AutoPostBack="false" ClientInstanceName="btMoveDown">
                                <ClientSideEvents Click="btMoveDown_Click" />
                            </dx:ASPxButton>
                            <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" OnHtmlRowPrepared="Generic_Gridview_HtmlRowPrepared" ClientInstanceName="Generic_Gridview" DataSourceID="Generic_Dts" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="IdAreaAss" OnRowInserting="Generic_Gridview_RowInserting" OnCustomCallback="Generic_Gridview_CustomCallback" OnCustomJSProperties="Generic_Gridview_CustomJSProperties" SettingsBehavior-ConfirmDelete="true" OnRowUpdating="Generic_Gridview_RowUpdating" OnHtmlDataCellPrepared="Generic_Gridview_HtmlDataCellPrepared">
                                <ClientSideEvents Init="Generic_Gridview_Init" />
                                <SettingsAdaptivity>
                                    <AdaptiveDetailLayoutProperties ColCount="2">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                    </AdaptiveDetailLayoutProperties>
                                </SettingsAdaptivity>
                                <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                                <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter">
                                    <EditForm HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" AllowResize="True" Modal="True"></EditForm>
                                </SettingsPopup>
                                <Settings ShowFilterRow="True" />
                                <SettingsCommandButton>
                                    <NewButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Nuovo" Url="../../img/DevExButton/new.png" Width="30px" Height="30px"></Image>
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
                                <SettingsPopup>
                                    <EditForm AllowResize="True" Modal="True" VerticalAlign="WindowCenter">
                                    </EditForm>
                                </SettingsPopup>
                                <SettingsSearchPanel Visible="True" />
                                <EditFormLayoutProperties ColCount="2">
                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                </EditFormLayoutProperties>
                                <Columns>
                                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="IdAreaAss" VisibleIndex="1" ReadOnly="True">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="3" SortOrder="Ascending">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="LabelClass" VisibleIndex="4">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="EmailRiferimento" VisibleIndex="5">

                                        <PropertiesTextEdit>
                                            <ValidationSettings CausesValidation="True" Display="Dynamic" SetFocusOnError="True">
                                                <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>

                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Color" VisibleIndex="6">
                                        <EditItemTemplate>
                                            <dx:ASPxColorEdit ID="colorEdit" runat="server" Color='<%# GetColor(Eval("Color")) %>' EnableCustomColors="true"></dx:ASPxColorEdit>
                                        </EditItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="IconPath" VisibleIndex="4">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <Styles>
                                    <Row CssClass="draggable"></Row>
                                </Styles>
                                <SettingsBehavior AllowSort="false" AllowFocusedRow="true" ProcessFocusedRowChangedOnServer="True" />
                                <SettingsPager Mode="ShowAllRecords" />
                                <ClientSideEvents Init="Generic_Gridview_Init" EndCallback="Generic_Gridview_EndCallback" />
                            </dx:ASPxGridView>
                            <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM TCK_AreaCompetenza WHERE (IdAreaAss = @IdAreaAss)" InsertCommand="INSERT INTO TCK_AreaCompetenza(PhotoBytes, Descrizione, DisplayOrder, LabelClass, EmailRiferimento, Color, IconPath) VALUES (@PhotoBytes, @Descrizione, @DisplayOrder, @LabelClass, @EmailRiferimento, @Color, @IconPath)" SelectCommand="SELECT * FROM TCK_AreaCompetenza" UpdateCommand="UPDATE TCK_AreaCompetenza SET PhotoBytes = @PhotoBytes, Descrizione = @Descrizione, DisplayOrder = @DisplayOrder, LabelClass = @LabelClass, EmailRiferimento = @EmailRiferimento, Color = @Color, IconPath = @IconPath WHERE (IdAreaAss = @IdAreaAss)">
                                <DeleteParameters>
                                    <asp:Parameter Name="IdAreaAss" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="PhotoBytes" DbType="Binary" />
                                    <asp:Parameter Name="Descrizione" />
                                    <asp:Parameter Name="DisplayOrder" />
                                    <asp:Parameter Name="LabelClass" />
                                    <asp:Parameter Name="EmailRiferimento" />
                                    <asp:Parameter Name="Color" />
                                    <asp:Parameter Name="IconPath" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="PhotoBytes" DbType="Binary" />
                                    <asp:Parameter Name="Descrizione" />
                                    <asp:Parameter Name="DisplayOrder" />
                                    <asp:Parameter Name="LabelClass" />
                                    <asp:Parameter Name="EmailRiferimento" />
                                    <asp:Parameter Name="Color" />
                                    <asp:Parameter Name="IconPath" />
                                    <asp:Parameter Name="IdAreaAss" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsHelper" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
                                SelectCommand="SELECT IdAreaAss FROM TCK_AreaCompetenza WHERE (DisplayOrder = @DisplayOrder)" UpdateCommand="UPDATE TCK_AreaCompetenza SET DisplayOrder = @DisplayOrder WHERE (IdAreaAss = @IdAreaAss)">
                                <SelectParameters>
                                    <asp:Parameter Name="DisplayOrder" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="DisplayOrder" />
                                    <asp:Parameter Name="IdAreaAss" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
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
