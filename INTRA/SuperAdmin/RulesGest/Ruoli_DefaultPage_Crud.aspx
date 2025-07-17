<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ruoli_DefaultPage_Crud.aspx.cs" Inherits="INTRA.SuperAdmin.RulesGest.Ruoli_DefaultPage_Crud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">
                            <div style="float: left">
                                <h4 class="card-title">Ruoli abilita Pagina di Default</h4>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="card-content" style="position: initial; padding: 15px 0px !important;">
                    <div class="col-lg-12" style="color: red">Questa pagina di default per il ruolo viene sostituita dalla pagina di default impostata sul singolo utente. <br /> La pagina viene salvata per ogni utente in un cookie, quindi per testare la modifica devi cancellare i Cookie</div>

                    <dx:ASPxGridView ID="Generic_Gridview" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Generic_Gridview" DataSourceID="Generic_Sql" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="RoleId">
                        <Settings ShowFilterRow="True" ShowHeaderFilterButton="True" AutoFilterCondition="Contains"></Settings>
                        <SettingsBehavior FilterRowMode="OnClick"></SettingsBehavior>
                        <SettingsCommandButton>
                            <NewButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Nuovo" Url="/assets/img/DevExButton/new.png" Width="30px" Height="30px"></Image>
                            </NewButton>
                            <UpdateButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Aggiorna" Height="30px" Url="/assets/img/DevExButton/update.png" Width="30px"></Image>
                            </UpdateButton>
                            <CancelButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Annulla" Height="30px" Url="/assets/img/DevExButton/cancel.png" Width="30px"></Image>
                            </CancelButton>
                            <EditButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Modifica" Height="30px" Url="/assets/img/DevExButton/edit.png" Width="30px"></Image>
                            </EditButton>
                            <DeleteButton ButtonType="Image" RenderMode="Image">
                                <Image ToolTip="Elimina" Height="30px" Url="/assets/img/DevExButton/delete.png" Width="30px"></Image>
                            </DeleteButton>
                        </SettingsCommandButton>
                        <Columns>
                            <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" VisibleIndex="0"></dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="RoleId" VisibleIndex="1" Visible="false" ReadOnly="true"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="RoleName" VisibleIndex="2" ReadOnly="true"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="PageDefault" VisibleIndex="3"></dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        ApplicationId, RoleId, RoleName, [Description], PageDefault
FROM            aspnet_Roles"
        UpdateCommand="UPDATE aspnet_Roles SET PageDefault = @PageDefault WHERE (RoleId = @RoleId)">
        <UpdateParameters>
            <asp:Parameter Name="PageDefault"></asp:Parameter>
            <asp:Parameter Name="RoleId"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
