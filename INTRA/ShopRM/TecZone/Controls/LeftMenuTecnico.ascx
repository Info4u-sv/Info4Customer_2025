<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftMenuTecnico.ascx.cs" Inherits="INTRA.ShopRM.TecZone.Controls.LeftMenuTecnico" %>
<div class="sidebar-navigation" style="border: 0">
    <div class="title">Menù<i class="fa fa-angle-down"></i></div>
    <div class="list" style="padding-top: 10px;">
        <div class="article-container style-1">
            <ul class="Nav4u">
                <li><a class="" href="#" id="A0" runat="server" style="display:none"><span>Deposito</span></a></li>
                <li><a class="" href="#" id="A1" runat="server" style="display:none"><span>Inventario</span></a></li>
                <li><a href="~/QrCodeReader.aspx" runat="server" id="L1" class=" "><span>Cambia Deposito QrCode</span></a></li>
                <li><a href="~/QrCode_Giornata.aspx" runat="server" id="A2" class=" "><span>Inizio/Fine Sessione QrCode</span></a></li>

            </ul>
            <script>
                function getCookie(name) {
                    var match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
                    if (match) return match[2];
                }

                // Verifica se il cookie desiderato esiste
                var mioCookie = getCookie('U_Token');

                if (mioCookie) {
                    // Se il cookie esiste, mostra il link con il parametro del cookie
                    var link = document.getElementById('ContenutoPaginaContentPH_LeftMenuCustomer_'+ 'A0');
                    link.href = '/ShopRM/Deposito/Deposito_Dett.aspx?CodDep=' + mioCookie.replace('U_Token=', '');
                    link.style.display = 'inline'; // Mostra il link
                    var link2 = document.getElementById('ContenutoPaginaContentPH_LeftMenuCustomer_'+'A1');
                    link2.href = '/ShopRM/Inventario.aspx';
                    link2.style.display = 'inline'; // Mostra il link
                }
            </script>
        </div>

    </div>


</div>

