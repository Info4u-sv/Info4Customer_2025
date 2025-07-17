<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RuoloAbilitaGeneraUtente.aspx.cs" Inherits="INTRA.SuperAdmin.RulesGest.RuoloAbilitaGeneraUtente" %>

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
                                <h4 class="card-title">Ruoli abilita per inserimento untente Fornt End</h4>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="card-content" style="position: initial; padding: 15px 0px !important;">
                    <div class="col-lg-12" style="color: red">Impostare descrizione a 1 per visuale il ruolo nella gestione utenti Front End</div>

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
                            <dx:GridViewCommandColumn ShowEditButton="true" VisibleIndex="0"></dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="RoleId" VisibleIndex="1"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="RoleName" VisibleIndex="2"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTokenBoxColumn FieldName="Description" VisibleIndex="3">
                                <PropertiesTokenBox DataSourceID="PRT_DropDown_Elementi_View_Dts" TextField="TextField" ValueField="ValueField" AllowCustomTokens="false">
                                </PropertiesTokenBox>
                            </dx:GridViewDataTokenBoxColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="PRT_DropDown_Elementi_View_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        TextField, ValueField
FROM            PRT_DropDown_Elementi_View
WHERE        (CodFamilyFilter = N'StdRuoloUtenteParm')"></asp:SqlDataSource>
    <
    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT        ApplicationId, RoleId, RoleName, [Description]
FROM            aspnet_Roles"
        UpdateCommand="UPDATE aspnet_Roles SET Description = @Description WHERE (RoleId = @RoleId)">
        <UpdateParameters>
            <asp:Parameter Name="Description"></asp:Parameter>
            <asp:Parameter Name="RoleId"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
