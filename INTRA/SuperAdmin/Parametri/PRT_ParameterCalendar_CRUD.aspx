<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_ParameterCalendar_CRUD.aspx.cs" Inherits="INTRA.SuperAdmin.Parametri.PRT_ParameterCalendar_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">
                            <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" SettingsText-ConfirmDelete="true" DataSourceID="Generic_Dts" KeyFieldName="ID" runat="server" Width="100%" AutoGenerateColumns="False">
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
                                        <Image ToolTip="Nuovo" Url="~/img/DevExButton/new.png" Width="30px" Height="30px"></Image>
                                    </NewButton>
                                    <UpdateButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Aggiorna" Height="30px" Url="~/img/DevExButton/update.png" Width="30px"></Image>
                                    </UpdateButton>
                                    <CancelButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Annulla" Height="30px" Url="~/img/DevExButton/cancel.png" Width="30px"></Image>
                                    </CancelButton>
                                    <EditButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Modifica" Height="30px" Url="~/img/DevExButton/edit.png" Width="30px"></Image>
                                    </EditButton>
                                    <DeleteButton ButtonType="Image" RenderMode="Image">
                                        <Image ToolTip="Elimina" Height="30px" Url="~/img/DevExButton/delete.png" Width="30px"></Image>
                                    </DeleteButton>
                                </SettingsCommandButton>
                                <SettingsDataSecurity AllowDelete="False" />
                                <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter">
                                    <EditForm HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" AllowResize="True" Modal="True"></EditForm>

                                    <HeaderFilter MinHeight="140px"></HeaderFilter>
                                </SettingsPopup>
                                <SettingsSearchPanel Visible="True" />

                                <SettingsText ConfirmDelete="true"></SettingsText>

                                <EditFormLayoutProperties ColCount="2">
                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                </EditFormLayoutProperties>
                                <Columns>
                                    <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" ReadOnly="True">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="CodParam" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="4">
                                    </dx:GridViewDataTextColumn>


                                </Columns>
                            </dx:ASPxGridView>
                            <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM PRT_ParameterCalendar WHERE (ID = @ID)" InsertCommand="INSERT INTO PRT_ParameterCalendar(CodParam, Value, Type, Descrizione) VALUES (@CodParam, @Value, @Type, @Descrizione)" SelectCommand="SELECT * from PRT_ParameterCalendar order by id " UpdateCommand="UPDATE PRT_ParameterCalendar SET Value = @Value, Type = @Type, Descrizione = @Descrizione where ID = @ID">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="CodParam" />
                                    <asp:Parameter Name="Value" />
                                    <asp:Parameter Name="Type"></asp:Parameter>
                                    <asp:Parameter Name="Descrizione"></asp:Parameter>
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Value" />
                                    <asp:Parameter Name="Type" />
                                    <asp:Parameter Name="Descrizione" />
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
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
