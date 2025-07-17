<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ActionToolbar.ascx.cs" Inherits="INTRA.UserControls.WebUserControl1" %>
<style>
    .dxeButtonEdit_Moderno .dxeEditArea_Moderno {
        /* background-color: #fafafa; */
        border-style: none;
        border-color: inherit;
        border-width: 0;
/*background-image: linear-gradient(#9c27b0, #9c27b0), linear-gradient(#D2D2D2, #D2D2D2) !important;*/
        background-size: 0 2px, 100% 1px;
        background-repeat: no-repeat;
        background-position: 0% 0%;
        background-color: transparent;
        transition: background 0s ease-out;
        float: none;
        box-shadow: none;
        border-radius: 0;
        font-weight: 400;
        /*background-attachment: scroll !important;*/
    }

    .dxeTextBox_Moderno .dxeFNTextSys, .dxeButtonEdit_Moderno .dxeFNTextSys, .dxeMemo_Moderno .dxeFNTextSys {
        color: #ffffff !important;
    }

    .dxeNullText_Moderno .dxeEditArea_Moderno, .dxeNullText_Moderno .dxeMemoEditArea_Moderno {
        color: #ffffff !important;
    }

    .dxeEditArea_Moderno, body input.dxeEditArea_Moderno {
        color: #ffffff !important;
        font-size: 14px !important;
    }

    input[type="text"].dxeEditArea_Moderno, input[type="password"].dxeEditArea_Moderno {
        margin-top: 0px !important;
        margin-bottom: 0px !important;
    }
</style>
  <%-- <script src="/Scripts/Demo.js"></script>--%>
   <%-- <strong>Menu Azioni</strong>
        <dx:BootstrapMenu ID="ActionMenu" runat="server" DataSourceID="ActionMenuDataSource"
            ClientInstanceName="ClientActionMenu"  
            OnItemDataBound="ActionMenu_ItemDataBound" ItemAutoWidth="false">
            <ClientSideEvents ItemClick="MailDemo.ClientActionMenu_ItemClick" />
           <%-- <Border BorderWidth="0" />
            <SubMenuStyle CssClass="SubMenu" />--%>
        <%--</dx:BootstrapMenu>--%>

<div style="float:right;"  >
    <div class="nform-group ">
       <%-- <dx:ASPxButtonEdit runat="server" ID="SearchBox" NullText="Filtra" CssClass="form-control"
            ClientInstanceName="ClientSearchBox" NullTextDisplayMode="UnfocusedAndFocused" Visible="true">

            <ClientSideEvents
                TextChanged="MailDemo.ClientSearchBox_TextChanged"
                KeyDown="MailDemo.ClientSearchBox_KeyDown"
                KeyPress="MailDemo.ClientSearchBox_KeyPress" />
            <%--  <Buttons>
                <dx:EditButton>                                              
                    <Image>
                        <SpriteProperties CssClass="material-icons"
                            HottrackedCssClass="material-icons"
                            PressedCssClass="material-icons" />
                    </Image>
                    
                </dx:EditButton>
            </Buttons>
            <ButtonStyle CssClass="btn btn-white btn-round btn-just-icon">
            </ButtonStyle>--%>
       <%--     <NullTextStyle Font-Italic="false" />
        </dx:ASPxButtonEdit>--%>
       <%-- <div class="btn btn-white btn-round btn-just-icon">
            <i class="material-icons">search</i>
            <div class="ripple-container"></div>--%>
       <%-- </div>--%>
    </div>
</div>


<%--<table class="ActionToolbar" style="width: 100%">
    <tr>
        <td class="Strut">
    <div style="float: left">
        <dx:aspximage id="ExpandPaneImage" runat="server" cursor="pointer" spritecssclass="Sprite_ExpandPane" tooltip="Expand" alternatetext="Expand"
            clientinstancename="ClientExpandPaneImage" clientvisible="false">
            <ClientSideEvents Click="MailDemo.ClientExpandPaneImage_Click" />
        </dx:aspximage>
    </div>
            <div style="float: left">
                <dx:aspxmenu id="ActionMenu" runat="server" datasourceid="ActionMenuDataSource"
                    showastoolbar="true" clientinstancename="ClientActionMenu" cssclass="ActionMenu" separatorwidth="0"
                    onitemdatabound="ActionMenu_ItemDataBound">
            <ClientSideEvents ItemClick="MailDemo.ClientActionMenu_ItemClick" />
            <Border BorderWidth="0" />
            <SubMenuStyle CssClass="SubMenu" />
        </dx:aspxmenu>
            </div>
            <div style="float: right">
                <dx:aspxmenu id="InfoMenu" runat="server" datasourceid="InfoMenuDataSource" clientinstancename="ClientInfoMenu"
                    showastoolbar="true" separatorwidth="0" cssclass="InfoMenu" onitemdatabound="InfoMenu_OnItemDataBound">
            <ClientSideEvents ItemClick="MailDemo.ClientInfoMenu_ItemClick" />
            <Border BorderWidth="0" />
            <SubMenuStyle CssClass="SubMenu" />
        </dx:aspxmenu>
            </div>
            <b class="clear"></b>
        </td>
        <td id="SearchBoxSpacer" class="Spacer" runat="server"><b></b></td>
        <td>
   
        </td>
    </tr>
</table>--%>

<asp:XmlDataSource ID="ActionMenuDataSource" runat="server" DataFile="~/App_Data/Actions.xml" />
<asp:XmlDataSource ID="InfoMenuDataSource" runat="server" DataFile="~/App_Data/InfoLayout.xml" XPath="Items/Item" />
