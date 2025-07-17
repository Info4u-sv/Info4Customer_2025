<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="access_rules.aspx.cs" Inherits="IntranetTemplate2017.SuperAdmin.RulesGest.RulesManagerAlbero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Website Access Rules</h4>
                    <div class="col-lg-12 col-md-12" style="padding-bottom: 50px">
                                            Use this page to manage access rules for your Web site. Rules are applied to folders, thus providing robust folder-level security enforced by the ASP.NET infrastructure. Rules are persisted as XML in each folder's Web.config file. <i>Page-level security and inner-page security are not handled using this tool &mdash; they are handled using specialized code that is available to the Web Developers.</i>

                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
		
      
				<div class="treeview">
				<asp:TreeView runat="server" ID="FolderTree"
					OnSelectedNodeChanged="FolderTree_SelectedNodeChanged">
					<RootNodeStyle ImageUrl="~/admin/i/folder.gif" />
					<ParentNodeStyle ImageUrl="~/admin/i/folder.gif" />
					<LeafNodeStyle ImageUrl="~/admin/i/folder.gif" />
					<SelectedNodeStyle Font-Underline="true" ForeColor="#A21818" />
				</asp:TreeView>
				</div> 
	</div>

                       <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
			<asp:Panel runat="server" ID="SecurityInfoSection" Visible="false">
				<h3 runat="server" id="TitleOne" class="alert"></h3>
				
				<p>
				Rules are applied in order. The first rule that matches applies, and the permission in each rule overrides the permissions in all following rules. Use the Move Up and Move Down buttons to change the order of the selected rule. Rules that appear dimmed are inherited from the parent and cannot be changed at this level. 
				</p>
				
				<asp:GridView runat="server" ID="RulesGrid" AutoGenerateColumns="false"
				CssClass="list" GridLines="none"
				OnRowDataBound="RowDataBound"
				>
					<Columns>
						<asp:TemplateField HeaderText="Action">
							<ItemTemplate>
								<%# GetAction((System.Web.Configuration.AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Roles">
							<ItemTemplate>
								<%# GetRole((System.Web.Configuration.AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="User">
							<ItemTemplate>
								<%# GetUser((System.Web.Configuration.AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Delete Rule">
							<ItemTemplate>
								<asp:Button ID="Button1" runat="server" Text="Delete Rule" CommandArgument="<%# (System.Web.Configuration.AuthorizationRule)Container.DataItem %>" OnClick="DeleteRule" OnClientClick="return confirm('Click OK to delete this rule.')" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Move Rule">
							<ItemTemplate>
								<asp:Button ID="Button2" runat="server" Text="  Up  " CommandArgument="<%# (System.Web.Configuration.AuthorizationRule)Container.DataItem %>" OnClick="MoveUp" />
								<asp:Button ID="Button3" runat="server" Text="Down" CommandArgument="<%# (System.Web.Configuration.AuthorizationRule)Container.DataItem %>" OnClick="MoveDown" />
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
				</asp:GridView>

				<br />
				<hr />
				<h3 runat="server" id="TitleTwo" class="alert"></h3>
				<b>Action:</b>
				<asp:RadioButton runat="server" ID="ActionDeny" GroupName="action" 
					Text="Deny" Checked="true" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:RadioButton runat="server" ID="ActionAllow" GroupName="action" 
					Text="Allow" />
				
				<br /><br />
				<b>Rule applies to:</b>
				<br />
				<asp:RadioButton runat="server" ID="ApplyRole" GroupName="applyto"
					Text="This Role:" Checked="true" />
				<asp:DropDownList ID="UserRoles" runat="server" AppendDataBoundItems="true">
				<asp:ListItem>Select Role</asp:ListItem>
				</asp:DropDownList>
				<br />
					
				<asp:RadioButton runat="server" ID="ApplyUser" GroupName="applyto"
					Text="This User:" />
				<asp:DropDownList ID="UserList" runat="server" AppendDataBoundItems="true">
				<asp:ListItem>Select User</asp:ListItem>
				</asp:DropDownList>	
				<br />
				
				
				<asp:RadioButton runat="server" ID="ApplyAllUsers" GroupName="applyto"
					Text="All Users (*)"  />
				<br />
				
				
				<asp:RadioButton runat="server" ID="ApplyAnonUser" GroupName="applyto"
					Text="Anonymous Users (?)"  />
				<br /><br />
				
				<asp:LinkButton ID="Button4" runat="server" CssClass="btn btn-labeled btn-success shiny"  OnClick="CreateRule"
					OnClientClick="return ShowConfirmBootBoxV2(this.id, 'Creazione Ruolo');"  ><i class="btn-label fa fa-plus"></i>Crea Ruolo</asp:LinkButton>
					
				<asp:Literal runat="server" ID="RuleCreationError"></asp:Literal>
			</asp:Panel>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
