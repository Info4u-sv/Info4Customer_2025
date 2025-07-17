<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="roles.aspx.cs" Inherits="IntranetTemplate2017.SuperAdmin.RulesGest.Role" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Roles</h4>
                    <div class="col-lg-6 col-md-6 col-sm-12" style="padding-bottom: 20px;">
                        New Role:
                                    <asp:TextBox runat="server" ID="NewRole"></asp:TextBox>

                        <asp:LinkButton ID="Button2" runat="server" OnClick="AddRole" class="btn btn-labeled btn-success shiny"><i class="btn-label fa fa-plus"></i>Add Role</asp:LinkButton>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <asp:GridView runat="server" ID="UserRoles" AutoGenerateColumns="false"
                            CssClass="list" AlternatingRowStyle-CssClass="odd" GridLines="none">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <div class="col-lg-4 col-md-4 col-sm-4">Role Name</div>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div class="col-lg-4 col-md-4 col-sm-4" style="padding-top: 20px;">
                                            <%# Eval("Role Name") %>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <div class="col-lg-4 col-md-4 col-sm-4 ">User Count</div>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div class="col-lg-4 col-md-4 col-sm-4 " style="padding-top: 20px;">
                                            <%# Eval("User Count") %>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <div class="col-lg-4 col-md-4 col-sm-4 ">Delete Role</div>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div class="col-lg-4 col-md-4 col-sm-4 " style="padding-top: 20px;">
                                            <asp:LinkButton ID="Button1" class="btn btn-danger btn-md" runat="server" OnClientClick="return ShowConfirmBootboxV2(this.id,'Elimina Ruolo','NoValidator')" OnCommand="DeleteRole" CommandName="DeleteRole" CommandArgument='<%# Eval("Role Name") %>'><i class="fa fa-trash"></i></asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" style="padding-bottom: 20px;">
                        <div runat="server" id="ConfirmationMessage" class="alert">
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
