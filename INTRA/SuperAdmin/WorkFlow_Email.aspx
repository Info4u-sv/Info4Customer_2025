<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WorkFlow_Email.aspx.cs" Inherits="INTRA.SuperAdmin.WorkFlow_Email" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function UpdateGridView() {
            if (ASPxClientEdit.ValidateGroup("testValidation")) {
                Generic_Gridview.UpdateEdit();
            }
        }
        function OnGetRowValuesElimina(index) {
            ConfermaOperazioneWithClientFunction("Conferma Cancellazione", "Confermi di voler eliminare il dato selezionato?", "Conferma", "Annulla", Elimina,null, index,null);
        }
        function Elimina(Valore) {
            console.log('Valore => ' + Valore);
            Generic_Gridview.DeleteRow(Valore);
        }
        function ConfermaOperazioneWithClientFunction(Title, Testo, BtnConfirmTxt, BtnCancelTxt, Function, paramFunction = null) {
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
                console.log('ConfermaOperazioneWithClientFunction => ' + isConfirm + ' paramFunction => ' + paramFunction);
                if (isConfirm) {
                    if (paramFunction != null) {
                        Function(paramFunction);
                    } else {
                        Function();
                    }
                }
            });
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

                    <dx:ASPxGridView runat="server" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" AutoGenerateColumns="False" DataSourceID="Generic_Dts" KeyFieldName="ID" Styles-AlternatingRow-Enabled="True" SettingsPopup-EditForm-HorizontalAlign="WindowCenter" SettingsPopup-EditForm-VerticalAlign="WindowCenter" Width="100%" OnRowInserting="Generic_Gridview_RowInserting" OnRowUpdating="Generic_Gridview_RowUpdating">
                        <ClientSideEvents EndCallback="function(s,e){if(e.command == 'DELETEROW'){Generic_Gridview.Refresh(); showNotification();}}" CustomButtonClick="function(s,e){if(e.buttonID == 'Elimina'){OnGetRowValuesElimina(e.visibleIndex);}}" />
                        <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                        <Settings AutoFilterCondition="Contains" ShowFilterRowMenu="true" />
                        <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="Center" EditForm-Modal="true"></SettingsPopup>
                        <SettingsPopup>
                            <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                        </SettingsPopup>
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
                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm"></SettingsEditing>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowNewButtonInHeader="True" VisibleIndex="0" ShowEditButton="True" ShowClearFilterButton="false" Width="60px">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" Text="" />
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false" Width="60px">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataSpinEditColumn FieldName="IdStatus" VisibleIndex="9" Visible="false"></dx:GridViewDataSpinEditColumn>
                            <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="3" EditFormSettings-ColumnSpan="2">
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink" />
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink" />
                                        <RequiredField IsRequired="True" ErrorText="L'email è obbligatoria." />
                                        <RegularExpression ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorText="Formato email non valido." />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                                <DataItemTemplate>
                                    <dx:ASPxTokenBox runat="server" Text='<%# Eval("Email") %>' Width="100%" ReadOnly="true"
                                        BackColor="Transparent" Border-BorderWidth="0" Border-BorderStyle="None">
                                    </dx:ASPxTokenBox>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="CreatedOn" VisibleIndex="5" EditFormSettings-Visible="False" Width="80px"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="UpdatedOn" VisibleIndex="7" EditFormSettings-Visible="False" Width="80px"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="EditUser" VisibleIndex="8" EditFormSettings-Visible="False" Width="100px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="InsertUser" VisibleIndex="6" EditFormSettings-Visible="False" Width="100px"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="4">
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CodParam" VisibleIndex="2" Width="100px">
                                <PropertiesTextEdit>
                                    <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                        <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                        <RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataCheckColumn FieldName="IsFrontEnd" Width="80px"></dx:GridViewDataCheckColumn>
                        </Columns>
                        <Templates>
                            <EditForm>
                                <div class="col-lg-12">
                                    <dx:ASPxLabel runat="server" ID="CodParam_Lbl" ClientInstanceName="CodParam_Lbl"
                                        Visible='<%# string.IsNullOrEmpty(Eval("CodParam") as string) ? false : true %>'
                                        Text='<%# string.Format("CodParam: {0}", Eval("CodParam")) %>' Font-Bold="true" />
                                </div>

                                <div class="col-lg-12">
                                    <dx:ASPxLabel runat="server" ID="ASPxLabel1" Text='CodParam:' ForeColor="Black"
                                        Visible='<%# string.IsNullOrEmpty(Eval("CodParam") as string) ? true : false %>' />
                                    <dx:ASPxTextBox runat="server" ID="CodParam_Txt" ClientInstanceName="CodParam_Txt" Width="100%"
                                        Visible='<%# string.IsNullOrEmpty(Eval("CodParam") as string) ? true : false %>'
                                        Text='<%# Bind("CodParam") %>'>
                                        <InvalidStyle BackColor="LightPink" />
                                        <ValidationSettings ValidationGroup="testValidation" ErrorDisplayMode="None">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </div>

                                <div class="col-lg-12">
                                    Email:
            <dx:ASPxTokenBox runat="server" ID="Email_Token" ClientInstanceName="Email_Token"
                DataSourceID="Email_List_Dts" ValueField="ID" TextField="Email" Width="100%"
                Text='<%# Bind("Email") %>'>
                <InvalidStyle BackColor="LightPink" />
                <ValidationSettings ValidationGroup="testValidation" ErrorDisplayMode="None">
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:ASPxTokenBox>
                                </div>

                                <div class="col-lg-12">
                                    Descrizione:
            <dx:ASPxTextBox runat="server" ID="Descrizione_Txt" ClientInstanceName="Descrizione_Txt" Width="100%"
                Text='<%# Bind("Descrizione") %>'>
                <InvalidStyle BackColor="LightPink" />
                <ValidationSettings ValidationGroup="testValidation" ErrorDisplayMode="None">
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:ASPxTextBox>
                                </div>

                                <div class="col-lg-12">
                                    Modificabile dal cliente:
            <dx:ASPxCheckBox runat="server" ID="IsFrontEnd_Check" ClientInstanceName="IsFrontEnd_Check"
                Checked='<%# Eval("IsFrontEnd") != null && (bool)Eval("IsFrontEnd") %>' />
                                </div>

                                <div style="float: right; padding-top: 30px !important">
                                    <a href="javascript: UpdateGridView();">
                                        <img src="../img/DevExButton/save.png" style="width: 30px !important" />
                                    </a>
                                    <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement1"
                                        ReplacementType="EditFormCancelButton" runat="server" />
                                </div>
                            </EditForm>
                        </Templates>


                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Generic_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, IdStatus, Email, CreatedOn, UpdatedOn, EditUser, InsertUser, Descrizione, CodParam, IsFrontEnd FROM U_Workflow_Email" InsertCommand="INSERT INTO U_Workflow_Email(IdStatus, Email, CreatedOn, InsertUser, Descrizione, CodParam, IsFrontEnd) VALUES (@IdStatus, @Email, @CreatedOn, @InsertUser, @Descrizione, @CodParam, @IsFrontEnd)" UpdateCommand="UPDATE U_Workflow_Email SET Email = @Email, UpdatedOn = GETDATE(), EditUser = @EditUser, Descrizione = @Descrizione, IsFrontEnd = @IsFrontEnd WHERE (ID = @ID)" DeleteCommand="DELETE FROM U_Workflow_Email WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="IdStatus" DbType="Int32"></asp:Parameter>
            <asp:Parameter Name="Email" DbType="String"></asp:Parameter>
            <asp:Parameter Name="CreatedOn" DbType="DateTime"></asp:Parameter>
            <asp:Parameter Name="InsertUser" DbType="String"></asp:Parameter>
            <asp:Parameter Name="Descrizione" DbType="String"></asp:Parameter>
            <asp:Parameter Name="CodParam" DbType="String"></asp:Parameter>
            <asp:Parameter Name="IsFrontEnd"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Email"></asp:Parameter>
            <asp:Parameter Name="EditUser"></asp:Parameter>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="IsFrontEnd"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Email_List_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, Email FROM U_Workflow_Email_Ana"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
