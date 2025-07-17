<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyMessageBox.ascx.cs" Inherits="INTRA.ShopRM.Controls.MyMessageBox" %>
<div class="information-blocks">
    <div class="row">&nbsp;</div>
    <asp:Panel ID="MessageBox" runat="server" >       
        <div class="message-box message-warning">
            <div class="message-icon"><i class="fa fa-exclamation"></i></div>
            <div class="message-text"><b>
                <asp:Literal ID="litMessage" runat="server"></asp:Literal></b></div>
            <div class="message-close"><i class="fa fa-times"></i></div>
        </div>
    </asp:Panel>
</div>
