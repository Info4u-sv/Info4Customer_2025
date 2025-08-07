<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_Parameter_Frontend.aspx.cs" Inherits="INTRA.Parametri_Cliente_Frontend.PRT_Parameter_Frontend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <style>
        /*div#MainContent_Generic_Gridview_DXPEForm_PW-1 {
            top: -75px !important;
        }*/
    </style>
</asp:Content>
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
                <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" SettingsText-ConfirmDelete="true" DataSourceID="Generic_Dts" KeyFieldName="ID" runat="server" Width="100%" AutoGenerateColumns="False" OnRowUpdating="Generic_Gridview_RowUpdating">
                    <ClientSideEvents EndCallback="function(s,e){if (e.command == 'UPDATEEDIT') {
                showNotification();
            }}" />
                    <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>

                    <SettingsPopup EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter" EditForm-Modal="true"></SettingsPopup>
                    <SettingsPopup>
                        <EditForm AllowResize="True" AutoUpdatePosition="True"></EditForm>
                    </SettingsPopup>
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                    <Settings ShowFilterRow="True" />
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

                    <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                    <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup>
                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista_Parametri" />
                    <SettingsText ConfirmDelete="true"></SettingsText>

                    <EditFormLayoutProperties ColCount="2">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" Width="40px">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" ReadOnly="True" Width="40px" Visible="false">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodParam" VisibleIndex="2" ReadOnly="true"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="3" EditFormSettings-ColumnSpan="2" Width="60px"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn FieldName="IsFrontEnd" VisibleIndex="6" EditFormSettings-ColumnSpan="1" EditFormSettings-VisibleIndex="3" Width="40px" Visible="false"></dx:GridViewDataCheckColumn>

                        <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="4" Width="40px" ReadOnly="true">
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataMemoColumn FieldName="Descrizione" VisibleIndex="5" EditFormSettings-ColumnSpan="2" PropertiesMemoEdit-Height="150px" ReadOnly="true">
                        </dx:GridViewDataMemoColumn>

                    </Columns>
                    <Templates>
                        <EditForm>
                            <dx:ASPxMemo runat="server" Text='<%# Eval("Descrizione") %>' Width="100%" Caption="Descrizione" CaptionSettings-Position="Top" CaptionStyle-ForeColor="Black" ReadOnly="true"></dx:ASPxMemo>
                            <dx:ASPxTextBox runat="server" ID="Generic_textbox" Text='<%# Bind("Value") %>' Visible='<%# Eval("Type") != null ? Eval("Type").ToString() == "HTML"  ? false : true : true%>' Width="100%" Caption="Valore" CaptionSettings-Position="Top" CaptionStyle-ForeColor="Black">
                                <ValidationSettings ValidateOnLeave="false" ErrorDisplayMode="None" ValidationGroup="InsertValid">
                                    <RequiredField IsRequired="true" />
                                </ValidationSettings>
                                <InvalidStyle BackColor="LightPink" />
                            </dx:ASPxTextBox>
                            <div style="float: right">
                                <dx:BootstrapButton runat="server" Text="" ID="Update_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding ">
                                    <Badge IconCssClass="fa fa-save" Text="" />
                                    <SettingsBootstrap RenderOption="Success" Sizing="Small" />
                                    <ClientSideEvents Click="function(s,e){if(ASPxClientEdit.ValidateGroup('InsertValid')){Generic_Gridview.UpdateEdit();}}" />
                                </dx:BootstrapButton>
                                <dx:BootstrapButton runat="server" Text="" ID="Cancel_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn-just-icon" CssClasses-Control="btn btn-just-icon btn-just-icon-padding">
                                    <Badge IconCssClass="fa fa-times" />
                                    <SettingsBootstrap RenderOption="Default" Sizing="Small" />
                                    <ClientSideEvents Click="function(s,e){ Generic_Gridview.CancelEdit(); }" />
                                </dx:BootstrapButton>
                            </div>
                        </EditForm>
                    </Templates>
                </dx:ASPxGridView>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM PRT_Parameter WHERE (ID = @ID)" InsertCommand="INSERT INTO PRT_Parameter(CodParam, Value, Type, Descrizione, IsFrontEnd) VALUES (@CodParam, @Value, @Type, @Descrizione, @IsFrontEnd)" SelectCommand="SELECT ID, CodParam, Value, Type, Descrizione, Cookie, IsFrontEnd FROM PRT_Parameter WHERE (IsFrontEnd = 1)" UpdateCommand="UPDATE PRT_Parameter SET Value = @Value, Type = @Type, Descrizione = @Descrizione, IsFrontEnd = @IsFrontEnd WHERE (ID = @ID)">
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
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
