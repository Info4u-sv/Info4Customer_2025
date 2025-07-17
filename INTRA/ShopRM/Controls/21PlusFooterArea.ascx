<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="21PlusFooterArea.ascx.cs" Inherits="INTRA.ShopRM.Controls._21PlusFooterArea" %>
<%@ Register Src="~/ShopRM/Controls/16SocialBox.ascx" TagPrefix="uc1" TagName="SocialBox" %>


<div class="row">
</div>
<!-- FOOTER -->
<div class="footer-wrapper style-3" >   
        <footer class="type-1" >
           
            <div class="footer-bottom-navigation">
                <div class="cell-view">
                  
                    <div class="copyright">
                        <%--<asp:Label ID="LblCopyright" runat="server" Text="Label" ></asp:Label>--%>
                        <dx:ASPxLabel ID="CompanyLbl" runat="server" Text="Label" OnInit="CompanyLbl_Init"></dx:ASPxLabel>
                    </div>
                </div>
                <div class="cell-view">
                    <%--<uc1:SocialBox runat="server" ID="SocialBox" />--%>
                    
                </div>
            </div>
        </footer>
   
</div>