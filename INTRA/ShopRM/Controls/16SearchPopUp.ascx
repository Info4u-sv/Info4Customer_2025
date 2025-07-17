<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="16SearchPopUp.ascx.cs" Inherits="INTRA.ShopRM.Controls._16SearchPopUp" %>
<script type="text/javascript">
    function Search1(TxtRicerca) {
 
        window.location.href = '/ShopRM/RicercaAvanzata.aspx?r1=' + TxtRicerca;

      return false;
    }
</script>
<div class="search-box popup">
    <div class="search-button">
        <i class="fa fa-search"></i>
        <%-- <input type="submit" runat="server" id="Ricerca16" OnClick="SeaarchBt_Click"/>--%>
        <asp:Button ID="ButtonpopUp" runat="server" Text="ricerca prodotto" ValidationGroup="_search" OnClientClick="return Search1(SearchTxtBoxDX1.GetText());" UseSubmitBehavior="true" />
    </div>
   <%-- <div class="search-field" style="margin-right: 5px; border: 1px #e8e8e8 solid; width: 300px; float: right">--%>
        <%--        <dx:ASPxTextBox ID="SearchTxtBoxPopUp" runat="server" value="" placeholder="Ricerca prodotto" ValidationGroup="_search" />--%>
        <dx:ASPxTextBox ID="SearchTxtBoxDX1" ClientInstanceName="SearchTxtBoxDX1" runat="server" AutoPostBack="false" placeholder="Ricerca prodotto" ValidationGroup="_search" CssClass="search-field-popup" >
                      <ClientSideEvents KeyPress="function(s, e){  
            if (e.htmlEvent.keyCode == 13) {  
                
                return Search1(s.GetText());
            }} " />
        </dx:ASPxTextBox>

    <%--</div>--%>
</div>
