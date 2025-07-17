<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_DropDown_Famglia.aspx.cs" Inherits="INTRA.SuperAdmin.PRT_CRUD.PRT_DropDown_Famglia" %>

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
                                <SettingsBehavior ConfirmDelete="true" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                                <SettingsText ConfirmDelete="Confermi l'eliminazione?" />
                                <SettingsAdaptivity>
                                    <AdaptiveDetailLayoutProperties ColCount="2">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                    </AdaptiveDetailLayoutProperties>
                                </SettingsAdaptivity>
                                <SettingsEditing EditFormColumnCount="2" Mode="Batch" />
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
                                    <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1" ReadOnly="True">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Titolo" VisibleIndex="2">
                                        <PropertiesTextEdit>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Caption" VisibleIndex="3">
                                        <PropertiesTextEdit>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="CodFamilyFilter" VisibleIndex="4">
                                        <PropertiesTextEdit>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="5" Caption="Dove si Utilizza">
                                        <PropertiesTextEdit>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="ConImmagine" VisibleIndex="6">
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                            </dx:ASPxGridView>
                            <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" DeleteCommand="DELETE FROM PRT_DropDown_Famglia WHERE (ID = @ID)
DELETE   FROM [PRT_DropDown_Elementi] WHERE DropDown_Famiglia = @ID"
                                InsertCommand="INSERT INTO PRT_DropDown_Famglia(Titolo, Note, ConImmagine, CodFamilyFilter, Caption) VALUES (@Titolo, @Note, @ConImmagine, @CodFamilyFilter, @Caption)" SelectCommand="SELECT * from PRT_DropDown_Famglia order by ID" UpdateCommand="UPDATE PRT_DropDown_Famglia SET Titolo = @Titolo, Note = @Note, ConImmagine = @ConImmagine, Caption = @Caption WHERE (ID = @ID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Titolo" />
                                    <asp:Parameter Name="Note" />
                                    <asp:Parameter Name="ConImmagine"></asp:Parameter>
                                    <asp:Parameter Name="CodFamilyFilter"></asp:Parameter>
                                    <asp:Parameter Name="Caption"></asp:Parameter>
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Titolo" />
                                    <asp:Parameter Name="Note" />
                                    <asp:Parameter Name="ConImmagine" />
                                    <asp:Parameter Name="Caption" />
                                    <asp:Parameter Name="ID"></asp:Parameter>
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
