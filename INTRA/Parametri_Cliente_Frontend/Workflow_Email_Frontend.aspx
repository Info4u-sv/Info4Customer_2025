<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Workflow_Email_Frontend.aspx.cs" Inherits="INTRA.Parametri_Cliente_Frontend.Workflow_Email_Frontend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function UpdateGridView() {
            if (ASPxClientEdit.ValidateGroup('InsertValid')) {
                Generic_Gridview.UpdateEdit();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">people_alt</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Workflow Email</h4>

                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Dts" KeyFieldName="ID" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" Width="100%" OnRowUpdating="Generic_Gridview_RowUpdating">
                        <ClientSideEvents EndCallback="function(s,e){if (e.command == 'UPDATEEDIT') {
                            Generic_Gridview.Refresh();
                showNotification();
            }}" />
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                        <Toolbars>
                            <dx:GridViewToolbar>
                                <Items>
                                    <dx:GridViewToolbarItem Alignment="left">
                                        <Template>
                                            <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                                <Buttons>
                                                    <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                </Buttons>
                                            </dx:ASPxButtonEdit>
                                        </Template>
                                    </dx:GridViewToolbarItem>
                                    <dx:GridViewToolbarItem Command="ClearFilter" Text="Cancella Flitro" />
                                    <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                </Items>
                            </dx:GridViewToolbar>
                        </Toolbars>
                        <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>
                        <SettingsPopup>
                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                        </SettingsPopup>
                        <SettingsSearchPanel CustomEditorID="tbToolbarSearch" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Email" />
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
                        <SettingsDataSecurity AllowInsert="False"></SettingsDataSecurity>

                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowEditButton="True" ShowClearFilterButton="false" Width="40px">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false" Width="60px">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataSpinEditColumn FieldName="IdStatus" VisibleIndex="9" Visible="false"></dx:GridViewDataSpinEditColumn>
                            <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="3" EditFormSettings-ColumnSpan="2">
                                <DataItemTemplate>
                                    <dx:ASPxTokenBox runat="server" Text='<%# Eval("Email") %>' Width="100%" ReadOnly="true" BackColor="Transparent" Border-BorderWidth="0" Border-BorderStyle="None"></dx:ASPxTokenBox>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="CreatedOn" VisibleIndex="5" EditFormSettings-Visible="False" Width="80px" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="UpdatedOn" VisibleIndex="7" EditFormSettings-Visible="False" Width="80px"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="EditUser" VisibleIndex="8" EditFormSettings-Visible="False" Width="100px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="InsertUser" VisibleIndex="6" EditFormSettings-Visible="False" Width="100px" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="4"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodParam" VisibleIndex="2" Width="100px"></dx:GridViewDataTextColumn>
                        </Columns>
                        <Templates>
                            <EditForm>
                                <div class="col-lg-12">
                                    <dx:ASPxLabel runat="server" ID="CodParam_Lbl" ClientInstanceName="CodParam_Lbl" Visible='<%# string.IsNullOrEmpty(Eval("CodParam") as string) ? false : true %>' Text='<%# string.Format("CodParam: {0}",Eval("CodParam")) %>' Font-Bold="true"></dx:ASPxLabel>
                                </div>
                                <div class="col-lg-12">
                                    <dx:ASPxLabel runat="server" ID="ASPxLabel1" Text='CodParam:' Visible='<%# string.IsNullOrEmpty(Eval("CodParam") as string) ? true : false %>' ForeColor="Black"></dx:ASPxLabel>
                                    <dx:ASPxTextBox runat="server" ID="CodParam_Txt" ClientInstanceName="CodParam_Txt" Width="100%" Visible='<%# string.IsNullOrEmpty(Eval("CodParam") as string) ? true : false %>'></dx:ASPxTextBox>
                                </div>
                                <div class="col-lg-12">
                                    Email:
                                    <dx:ASPxTokenBox runat="server" ID="Email_Token" ClientInstanceName="Email_Token" DataSourceID="Email_List_Dts" ValueField="ID" TextField="Email" Width="100%" Text='<%#Bind("Email") %>'>
                                        <ValidationSettings ValidateOnLeave="false" ErrorDisplayMode="None" ValidationGroup="InsertValid">
                                            <RequiredField IsRequired="true" />
                                        </ValidationSettings>
                                        <InvalidStyle BackColor="LightPink" />
                                    </dx:ASPxTokenBox>
                                </div>

                                <div class="col-lg-12">
                                    Descrizione:
                                    <dx:ASPxTextBox runat="server" ID="Descrizione_Txt" ClientInstanceName="Descrizione_Txt" Width="100%" Text='<%#Bind("Descrizione") %>' ReadOnly="true"></dx:ASPxTextBox>
                                </div>
                                <div style="float: right; padding-top: 30px !important">
                                    <a href="javascript: UpdateGridView();">
                                        <img src="../img/DevExButton/save.png" style="width: 30px !important" /></a>
                                    <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement1" ReplacementType="EditFormCancelButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
                                </div>
                            </EditForm>
                        </Templates>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Generic_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, IdStatus, Email, CreatedOn, UpdatedOn, EditUser, InsertUser, Descrizione, CodParam FROM U_Workflow_Email WHERE IsFrontEnd = 1" UpdateCommand="UPDATE U_Workflow_Email SET Email = @Email, UpdatedOn = GETDATE(), EditUser = @EditUser, Descrizione = @Descrizione WHERE (ID = @ID)">
        <UpdateParameters>
            <asp:Parameter Name="Email"></asp:Parameter>
            <asp:Parameter Name="EditUser"></asp:Parameter>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Email_List_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, Email FROM U_Workflow_Email_Ana"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
