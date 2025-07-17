<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftMenuCustomer.ascx.cs" Inherits="INTRA.ShopRM.Customer.Controls.LeftMenuCustomer" %>
<div class="sidebar-navigation" style="border: 0">
    <div class="title">Menù<i class="fa fa-angle-down"></i></div>
    <div class="list" style="padding-top:10px;">

        <div class="article-container style-1">
            <ul class="Nav4u">             
                <li><a href="~/ShopRM/customer/i_miei_dati.aspx" runat="server" id="L2" class=""><span>I miei dati</span></a></li>
                <li><a href="~/ShopRM/customer/CambiaPassword.aspx" runat="server" id="A1" class=""><span>Cambia Password</span></a></li>
                <li><a href="~/ShopRM/customer/CambiaEmail.aspx" runat="server" id="A4" class=""><span>Cambia Email</span></a></li>

                <li><a href="~/ShopRM/customer/i_miei_ordini.aspx" runat="server" id="A2" class=""><span>i miei ordini</span></a></li>
                <li><a href="~/ShopRM/customer/richiedi_assistenza.aspx" runat="server" id="A3" class=""><span>Richiesta assistenza</span></a></li>
            </ul>
        </div>
    </div>


</div>

