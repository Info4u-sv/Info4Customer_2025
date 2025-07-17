<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VersioneIntranet_Tbl_CRUD.aspx.cs" Inherits="INTRA.SuperAdmin.VersioneIntranet_Tbl_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">people_alt</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">VersioneIntranet 2023 Tbl CRUD </h4>
                   <strong> questa pagina consente la modifica dei dati della versione.
                    non è più necessario modificare a mano il file xml e il web.config</strong>
                    <div class="datagrid">
                        <table>
                           
                            <tbody>
                                <tr>
                                    <td class="style1">&nbsp;
                                    </td>
                                    <td>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">TitVers:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="alt">
                                    <td class="style1">NewFeatures:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">BugFix:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="alt">
                                    <td class="style1">NumeroLic:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox4" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="alt">
                                    <td class="style1">RagSoc:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox5" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="alt">
                                    <td class="style1" colspan="2">
                                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Insert" />
                                        &nbsp;&nbsp;
                        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Cancel" />
                                        &nbsp;&nbsp;
                        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
                                        <br />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" Height="50px"
                            OnItemCommand="DetailsView1_ItemCommand" OnItemDeleting="DetailsView1_ItemDeleting"
                            Width="300px" DataKeyNames="Id" OnModeChanging="DetailsView1_ModeChanging" OnPageIndexChanging="DetailsView1_PageIndexChanging1"
                            AllowPaging="true" DefaultMode="ReadOnly">
                            <Fields>
                                <asp:TemplateField HeaderText="Id">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TitVers">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("TitVers") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NewFeatures">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("NewFeatures") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BugFix">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("BugFix") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NumeroLic">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("NumeroLic") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RagSoc">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("RagSoc") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:Button ID="Button3" runat="server" CommandName="Edit" Text="Edit" />
                                        &nbsp;<asp:Button ID="Button4" runat="server" CommandName="Delete" Text="Delete" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
