<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="CambiaEmail.aspx.cs" Inherits="INTRA.ShopRM.Customer.CambiaEmail" %>

<%@ Register Src="~/ShopRM/Customer/Controls/LeftMenuCustomer.ascx" TagPrefix="uc1" TagName="LeftMenuCustomer" %>
<%@ Register Src="~/ShopRM/Controls/MyMessageBox.ascx" TagPrefix="msgbox" TagName="MyMessageBox" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuCustomer runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">Modifica indirizzo e-mail</h2>
            </div>
            <div class="article-container">
                <p>Tramite questo pannello puoi modificare la tua e-mail di accesso all'area riservata.</p>
                        <msgbox:MyMessageBox ID="MyMessageBox1" runat="server" Visible="false" />
                        <asp:Panel ID="PanelPrivato" runat="server" Style="margin-top: 0px">
                            <p>
                                <label>Nome Utente</label>
                                <asp:Label ID="UserTxt" runat="server" Text="" Style="font-weight: 700"></asp:Label>
                            </p>
                            <p>
                                <label> E-mail attuale</label>
                                <asp:Label ID="RegMailLbl" runat="server" Style="font-weight: 700"></asp:Label>
                            </p>
                            <p>
                                <label>Nuovo indirizzo E-mail</label>
                                <asp:TextBox class="simple-field" ID="RegMailTxt" runat="server" AutoPostBack="true"></asp:TextBox>
                              
                                
                            </p>
                            &nbsp;<br />
                        </asp:Panel>
                        <div class="register" style="padding: 0; margin: 0">
                            <asp:LinkButton ID="btnSaveRegister" runat="server" Text="Aggiorna >"
                                ValidationGroup="ValidLogin" CommandArgument="Aggiorna"
                                OnCommand="btnSaveRegister_Command" class="button style-12">Aggiorna ></asp:LinkButton>
                        </div>
                        <br />
                        <br />
                  
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
