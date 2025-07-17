<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="21LoginArea.ascx.cs" Inherits="INTRA.ShopRM.Controls._21LoginArea" %>
<style>
    .reposition {
        position: relative;
        top: -1px;
    }

    .colorePrimario,
    .colorePrimario * {
        color: #0055A6 !important;
    }

    @media (max-width: 1024px) {
        .header-top-entry .title {
            display: flex;
            align-items: center;
            min-height: 35px;
            padding-left: 5px;
            font-weight: bold;
        }

        .header-functionality-entry {
            display: inline-flex;
            align-items: center;
            justify-content: flex-start;
            padding: 0;
            margin: 0;
        }

            .header-functionality-entry i {
                font-size: 18px !important;
                color: #0055A6 !important;
                margin: 0;
                line-height: 1;
            }

            .header-functionality-entry span {
                display: none !important;
            }
    }
</style>

<dx:ASPxCallback ID="logOut_callback" runat="server" ClientInstanceName="logOut_callback" OnCallback="logOut_callback_Callback"></dx:ASPxCallback>

<asp:LoginView ID="LoginView1" runat="server">
    <AnonymousTemplate>
        <div class="header-top-entry">
            <div class="title colorePrimario">
                <a href="~/login.aspx" runat="server" id="linkAiuto" class="colorePrimario"><b>MY AREA</b></a>
            </div>
        </div>
    </AnonymousTemplate>
    <LoggedInTemplate>
        <div class="header-top-entry">
            <div class="title colorePrimario">
                <b>Bentornato,
            <asp:LoginName ID="LoginName1" runat="server" />
                </b>
            </div>
        </div>
    </LoggedInTemplate>
    <RoleGroups>
        <%-- <asp:RoleGroup Roles="Cliente, Administrator, SuperAdmin, Cat, TecnicoCat">
            <ContentTemplate>
                <div class="header-top-entry">
                    <div class="title colorePrimario">
                        <b>Bentornato,
                        <asp:LoginName ID="LoginName2" runat="server" />
                        </b>
                    </div>
                </div>
            </ContentTemplate>
        </asp:RoleGroup>--%>
        <%--        <asp:RoleGroup Roles="TecnicoCat, Administrator, SuperAdmin, Operatore">
            <ContentTemplate>--%>
        <%-- <a class="header-functionality-entry" href="/QrCodeReader.aspx" runat="server" id="A6"><i class="fa fa-qrcode"></i><span>Cambia Deposito</span></a>
                <a class="header-functionality-entry" href="/QrCode_Giornata.aspx" runat="server" id="A5"><i class="fa fa-clock-o"></i><span>Inizio/Fine Sessione</span></a>
                <a class="header-functionality-entry" href="javascript:logOut_callback.PerformCallback()" runat="server" id="A1"><i class="fa fa-sign-out"></i><span>Logout</span></a>--%>
        <%--                <dx:ASPxHyperLink ID="Logout_link" CssClass="header-functionality-entry" runat="server" ClientSideEvents-Click="function(s,e){logOut_callback.PerformCallback();}"><i class="fa fa-sign-out"></i><span>Logout</span></dx:ASPxHyperLink>--%>

        <%--                <div class="header-top-entry">
                    <div class="title colorePrimario">
                        <b>Bentornato,
                        <asp:LoginName ID="LoginName2" runat="server" />
                        </b>
                    </div>
                </div>--%>
        <%--  <div class="header-top-entry">
                    <div class="title colorePrimario">
                        <a id="A2" runat="server" href="~/ShopRM/TecZone/DashBoardTec.aspx" class="colorePrimario"><b>My Area</b></a>
                    </div>
                </div>--%>
        <%--            </ContentTemplate>
        </asp:RoleGroup>--%>
        <asp:RoleGroup Roles="Cliente,ClienteAdmin,Administrator, SuperAdmin,">
            <ContentTemplate>
                <div class="header-top-entry">
                    <div class="title colorePrimario">
                        <b>Bentornato,
                        <asp:LoginName ID="LoginName1" runat="server" />
                        </b>
                    </div>
                </div>
                <div class="header-top-entry">
                    <div class="title colorePrimario">
                        <a id="A2" class="colorePrimario" runat="server" href="~/ShopRM/customer/i_miei_dati.aspx"><b>Modifica dati</b></a>
                    </div>
                </div>
                <div class="header-top-entry">
                    <div class="title colorePrimario">
                        <a class="header-functionality-entry" href="javascript:logOut_callback.PerformCallback()" runat="server" id="A1"><i class="fa fa-sign-out"></i><span class="logout-text">Logout</span></a>
                    </div>
                </div>
            </ContentTemplate>
        </asp:RoleGroup>
    </RoleGroups>
</asp:LoginView>

<%--<div class="header-top-entry">
    <div class="title colorePrimario">
        <a id="A2" runat="server" href="~/ShopRM/customer/i_miei_dati.aspx" class="colorePrimario"><b>Modifica dati</b></a>
    </div>
</div>

<div class="header-top-entry">
    <div class="title colorePrimario">
        <a id="A1" runat="server" href="~/ShopRM/customer/i_miei_ordini.aspx" class="colorePrimario"><b>I miei ordini</b></a>
    </div>
</div>--%>
<%--<div class="header-top-entry">
    <div class="title colorePrimario">
        <b>--%>
<%--        </b>
    </div>
</div>--%>
