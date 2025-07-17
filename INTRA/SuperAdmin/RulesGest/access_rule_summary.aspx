<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="access_rule_summary.aspx.cs" Inherits="IntranetTemplate2017.SuperAdmin.RulesGest.AccessRuleSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Website Access Security Summary</h4>
                    <div class="col-lg-12 col-md-12" style="padding-bottom: 50px">
                    <div class="col-xs-12 col-md-4 col-lg-2">

                        <asp:DropDownList ID="UserRoles" Style="width: 100%;" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="DisplayRoleSummary">
                            <asp:ListItem>Select Role</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-xs-12 col-md-4 col-lg-2" style="text-align: center">
                        - OR -
                    </div>
                    <div class="col-xs-12 col-md-4 col-lg-2">
                        <asp:DropDownList ID="UserList" Style="width: 100%;" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="DisplayUserSummary">
                            <asp:ListItem>Select User</asp:ListItem>
                            <asp:ListItem Text="Anonymous users (?)" Value="?"></asp:ListItem>
                            <asp:ListItem Text="Authenticated users not in a role (*)" Value="*"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                        </div>
                    <div class="col-xs-12 col-md-12 col-lg-12">
                        <div class="treeview">
                            <asp:TreeView runat="server" ID="FolderTree"
                                OnSelectedNodeChanged="FolderTree_SelectedNodeChanged">
                                <RootNodeStyle ImageUrl="/assets/img/folder.gif" />
                                <ParentNodeStyle ImageUrl="/assets/img/folder.gif" />
                                <LeafNodeStyle ImageUrl="/assets/img/folder.gif" />
                                <SelectedNodeStyle Font-Underline="true" ForeColor="#A21818" />
                            </asp:TreeView>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
