<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Controls_SideBarMenu.ascx.cs" Inherits="INTRA.Controls.Controls_SideBarMenu" %>

<style>
    /*customizzo sidebar menu*/
    nav-mobile-menu {
        display: block !important;
    }

    .tit-menu {
         display: block !important;
    }

    .caret-custom {
        display: inline !important;
    }

    @media (min-width: 992px) {
        .sidebar-mini .sidebar .sidebar-wrapper > .nav [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar .sidebar-wrapper .user .info [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar .sidebar-wrapper .user .info > a > span, .sidebar-mini .sidebar .sidebar-wrapper > .nav li > a .tit-menu {
            opacity: 0;
            display: block !important;
        }

        .sidebar-mini .sidebar .sidebar-wrapper > .nav [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar .sidebar-wrapper .user .info [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar .sidebar-wrapper .user .info > a > span, .sidebar-mini .sidebar .sidebar-wrapper > .nav li > a .caret-custom {
            opacity: 0;
            display: block !important;
        }
    }

    .sidebar-mini .sidebar:hover .sidebar-wrapper > .nav li > a .tit-menu, .sidebar-mini .sidebar:hover .sidebar-wrapper > .nav [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar:hover .sidebar-wrapper .user .info [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar:hover .sidebar-wrapper > .nav li > a .tit-menu {
        -webkit-transform: translate3d(0px, 0, 0);
        -moz-transform: translate3d(0px, 0, 0);
        -o-transform: translate3d(0px, 0, 0);
        -ms-transform: translate3d(0px, 0, 0);
        transform: translate3d(0px, 0, 0);
        opacity: 1;
        display: block !important;
        z-index: 99999;
    }

    .sidebar-mini .sidebar:hover .sidebar-wrapper > .nav li > a .caret-custom, .sidebar-mini .sidebar:hover .sidebar-wrapper > .nav [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar:hover .sidebar-wrapper .user .info [data-toggle="collapse"] ~ div > ul > li > a .sidebar-normal, .sidebar-mini .sidebar:hover .sidebar-wrapper > .nav li > a .caret-custom {
        -webkit-transform: translate3d(0px, 0, 0);
        -moz-transform: translate3d(0px, 0, 0);
        -o-transform: translate3d(0px, 0, 0);
        -ms-transform: translate3d(0px, 0, 0);
        transform: translate3d(0px, 0, 0);
        opacity: 1;
        display: inline !important;
        z-index: 99999;
    }
    
.sidebar .nav li > a {
    color: white !important;
}
    .sidebar-wrapper {
        overflow-y: hidden !important;
    }

    .sidebar .nav li > a {
        margin: 0 !important;
        margin-left: 0px !important;
        margin-top: 0px !important;
        margin-bottom: 0px !important;
        padding-left: 10px !important;
        padding-right: 0px !important;
    }

    .sidebar .nav {
        margin-top: 0px !important;
    }

        .sidebar .nav li > a {
            border-radius: 3px 0 0 3px !important;
        }

        .sidebar .nav i {
            margin-right: 5px !important;
        }
</style>
<ul class="nav accordion" id="accordion" runat="server" clientidmode="static">
</ul>
<span style="color: #957043">
    <asp:Label ID="VersioneIntranet_Lbl" runat="server"></asp:Label>
</span>
