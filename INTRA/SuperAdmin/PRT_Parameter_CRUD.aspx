<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_Parameter_CRUD.aspx.cs" Inherits="INTRA.SuperAdmin.PRT_Parameter_CRUD" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header card-header-icon" data-background-color="blue">
                <i class="material-icons">assignment</i>
            </div>
            <div class="card-content">
                <div class="col-md-8">
                    <h4 class="card-title">Lista Parametri 
                    </h4>
                </div>
                <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" SettingsText-ConfirmDelete="true" DataSourceID="Generic_Dts" KeyFieldName="ID" runat="server" Width="100%" AutoGenerateColumns="False" OnRowInserting="Generic_Gridview_RowInserting" OnRowUpdating="Generic_Gridview_RowUpdating">
                    <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                     <ClientSideEvents EndCallback="function(s,e){if(e.command == 'UPDATEEDIT'){Generic_Gridview.Refresh(); showNotification();}}" />
                    <SettingsPopup>
                        <EditForm AllowResize="True" Modal="True" VerticalAlign="WindowCenter">
                        </EditForm>
                    </SettingsPopup>
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                    <Settings ShowFilterRow="True" />
                    <SettingsCommandButton>
                        <NewButton ButtonType="Image" RenderMode="Image">
                            <Image ToolTip="Nuovo" Url="../../assets/img/DevExButton/new.png" Width="30px" Height="30px"></Image>
                        </NewButton>
                        <UpdateButton ButtonType="Image" RenderMode="Image">
                            <Image ToolTip="Aggiorna" Height="30px" Url="../../assets/img/DevExButton/update.png" Width="30px"></Image>
                        </UpdateButton>
                        <CancelButton ButtonType="Image" RenderMode="Image">
                            <Image ToolTip="Annulla" Height="30px" Url="../../assets/img/DevExButton/cancel.png" Width="30px"></Image>
                        </CancelButton>
                        <EditButton ButtonType="Image" RenderMode="Image">
                            <Image ToolTip="Modifica" Height="30px" Url="../../assets/img/DevExButton/edit.png" Width="30px"></Image>
                        </EditButton>
                        <DeleteButton ButtonType="Image" RenderMode="Image">
                            <Image ToolTip="Elimina" Height="30px" Url="../../assets/img/DevExButton/delete.png" Width="30px"></Image>
                        </DeleteButton>
                    </SettingsCommandButton>
                    <SettingsDataSecurity AllowDelete="False" />
                    <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter">
                        <EditForm HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" AllowResize="True" Modal="True"></EditForm>

                        <HeaderFilter MinHeight="140px"></HeaderFilter>
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
                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Parametri" />
                    <SettingsCustomizationDialog Enabled="true" />
                    <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                    <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup>
                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>

                    <SettingsText ConfirmDelete="true"></SettingsText>

                    <EditFormLayoutProperties ColCount="2">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" Visible="false" ReadOnly="True">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodParam" VisibleIndex="2">
                            <PropertiesTextEdit>
                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                    <RequiredField IsRequired="True"></RequiredField>
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="3" EditFormSettings-ColumnSpan="2">
                            <PropertiesTextEdit>
                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                    <RequiredField IsRequired="True"></RequiredField>
                                </ValidationSettings>
                            </PropertiesTextEdit>
                            <EditItemTemplate>
                                <dx:BootstrapTextBox runat="server" ID="Generic_textbox" Text='<%# Bind("Value") %>' Visible='<%# Eval("Type") != null ? Eval("Type").ToString() == "HTML"  ? false : true : true%>'></dx:BootstrapTextBox>
                                <dx:ASPxHtmlEditor ID="Generic_HtmlEditor" Settings-AllowHtmlView="true" Settings-AllowPreview="false" ClientInstanceName="Generic_HtmlEditor" runat="server" Html='<%# Bind("Value") %>' Visible='<%# Eval("Type") != null ? Eval("Type").ToString() == "HTML"  ? true : false : true%>' EncodeHtml="false">
                                </dx:ASPxHtmlEditor>
                            </EditItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn FieldName="IsFrontEnd" VisibleIndex="6" EditFormSettings-ColumnSpan="1" EditFormSettings-VisibleIndex="3" Width="7%">
                            <PropertiesCheckEdit>
                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                    <RequiredField IsRequired="True"></RequiredField>
                                </ValidationSettings>
                            </PropertiesCheckEdit>
                        </dx:GridViewDataCheckColumn>

                        <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="4" EditFormSettings-CaptionLocation="Top" Width="6%">
                            <PropertiesTextEdit>
                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                    <RequiredField IsRequired="True"></RequiredField>
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataMemoColumn FieldName="Descrizione" VisibleIndex="5" EditFormSettings-ColumnSpan="2" PropertiesMemoEdit-Height="60px" EditFormSettings-CaptionLocation="Top">
                            <PropertiesMemoEdit>
                                <InvalidStyle BackColor="LightPink"></InvalidStyle>
                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" ValidationGroup="testValidation">
                                    <ErrorFrameStyle BackColor="LightPink"></ErrorFrameStyle>
                                    <RequiredField IsRequired="True"></RequiredField>
                                </ValidationSettings>
                            </PropertiesMemoEdit>
                        </dx:GridViewDataMemoColumn>

                    </Columns>
                </dx:ASPxGridView>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM PRT_Parameter WHERE (ID = @ID)" InsertCommand="INSERT INTO PRT_Parameter(CodParam, Value, Type, Descrizione, IsFrontEnd) VALUES (@CodParam, @Value, @Type, @Descrizione, @IsFrontEnd)" SelectCommand="SELECT ID, CodParam, Value, Type, Descrizione, Cookie, IsFrontEnd FROM PRT_Parameter" UpdateCommand="UPDATE PRT_Parameter SET Value = @Value, Type = @Type, Descrizione = @Descrizione, IsFrontEnd = @IsFrontEnd WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CodParam" />
            <asp:Parameter Name="Value" />
            <asp:Parameter Name="Type"></asp:Parameter>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="IsFrontEnd"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Value" />
            <asp:Parameter Name="Type" />
            <asp:Parameter Name="Descrizione" />
            <asp:Parameter Name="IsFrontEnd"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

