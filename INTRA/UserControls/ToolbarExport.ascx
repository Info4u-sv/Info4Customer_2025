<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ToolbarExport.ascx.cs" Inherits="INTRA.UserControls.ToolbarExport" %>
<div class="OptionsBottomMargin">
    <dx:ASPxMenu runat="server" ID="MenuExportButtons" ClientInstanceName="MenuExportButtons" ShowAsToolbar="true" OnItemClick="MenuExportButtons_ItemClick" AutoPostBack="true">
        <Items>
            <dx:MenuItem Name="ToolbarCaption">
                <Template>
                    <div class="exportToolbarCaption">
                        <dx:ASPxLabel runat="server" ID="labelCaption" Text="Download:" />
                    </div>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</div>