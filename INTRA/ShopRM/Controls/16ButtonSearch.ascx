<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="16ButtonSearch.ascx.cs" Inherits="INTRA.ShopRM.Controls._16ButtonSearch" %>
 <script type="text/javascript">
     function Search(s, e)
      {

         window.location.href = '/ShopRM/RicercaAvanzata.aspx?r1=' + TxtRicerca;
         return false;
      }    
      
 </script>
<div class="right-entry">
   
        <div class="search-box ">
          
            <div class="search-button">
                <i class="fa fa-search"></i>
           
                <asp:Button ID="SeaarchBt" runat="server"  Text="ricerca prodotto" ValidationGroup="_search" OnClientClick="return Search();"  usesubmitbehavior="true"  />
               
            </div>
            <div class="search-field" style="margin-right:5px; border: 1px #e8e8e8 solid; width: 400px; float:right">
                <dx:ASPxTextBox ID="SearchTxtBoxDX" ClientInstanceName="SearchTxtBoxDX" runat="server"  placeholder="Ricerca prodotto" ValidationGroup="_search" Width="390px" Paddings-Padding="0" Border-BorderWidth="0"  >
                  <ClientSideEvents KeyPress="function(s, e){  
            if (e.htmlEvent.keyCode == 13) {  
                     
                 Search();
            }} " />
                </dx:ASPxTextBox>
              
               <%-- <dx:ASPxButtonEdit ID="ASPxButtonEdit1" runat="server">
                    <Buttons>
                        <dx:EditButton>
                        </dx:EditButton>
                    </Buttons>
                </dx:ASPxButtonEdit>--%>
              <%--  <asp:TextBox ID="SearchTxtBox" runat="server"  placeholder="Ricerca prodotto" ValidationGroup="_search" Width="390px" />--%>
            </div>
           
</div>
  
</div>
