<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_UsersCalendar.aspx.cs" Inherits="INTRA.PRT_Calendar.PRT_UsersCalendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">
                            <dx:ASPxGridView ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" DataSourceID="Generic_Dts" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID">
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
                                <SettingsPopup>
                                    <EditForm AllowResize="True" Modal="True" VerticalAlign="WindowCenter">
                                    </EditForm>
                                </SettingsPopup>
                                <SettingsSearchPanel Visible="True" />
                                <EditFormLayoutProperties ColCount="2">
                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                </EditFormLayoutProperties>
                                <Columns>
                                    <dx:GridViewCommandColumn  ShowClearFilterButton="true" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" ReadOnly="True">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Name" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DisplayName" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Department" VisibleIndex="4">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Phone" VisibleIndex="5">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="6">
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataBinaryImageColumn FieldName="PhotoBytes" VisibleIndex="7">
                                        <PropertiesBinaryImage ImageHeight="170px" ImageWidth="160px">
                                            <EditingSettings Enabled="true" UploadSettings-UploadValidationSettings-MaxFileSize="4194304" />
                                        </PropertiesBinaryImage>
                                    </dx:GridViewDataBinaryImageColumn>


                                </Columns>
                            </dx:ASPxGridView>
                            <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM PRT_UsersCalendar WHERE (ID = @ID)" InsertCommand="INSERT INTO PRT_UsersCalendar(Name, DisplayName, Department, Phone, Email, PhotoBytes) VALUES (@Name, @DisplayName, @Department, @Phone, @Email, @PhotoBytes)" SelectCommand="SELECT ID, Name, DisplayName, Department, Phone, Email, PhotoBytes FROM PRT_UsersCalendar" UpdateCommand="UPDATE PRT_UsersCalendar SET Name = @Name, DisplayName = @DisplayName, Department = @Department, Phone = @Phone, Email = @Email, PhotoBytes = @PhotoBytes WHERE (ID = @ID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Name" />
                                    <asp:Parameter Name="DisplayName" />
                                    <asp:Parameter Name="Department" />
                                    <asp:Parameter Name="Phone" />
                                    <asp:Parameter Name="Email" />
                                    <asp:Parameter Name="PhotoBytes" DbType="Binary" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Name" />
                                    <asp:Parameter Name="DisplayName" />
                                    <asp:Parameter Name="Department" />
                                    <asp:Parameter Name="Phone" />
                                    <asp:Parameter Name="Email" />
                                    <asp:Parameter Name="PhotoBytes" DbType="Binary"/>
                                    <asp:Parameter Name="ID" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
