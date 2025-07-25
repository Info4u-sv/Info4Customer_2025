<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AppointmentDragToolTip.ascx.cs" Inherits="UserForms_AppointmentDragToolTip" %>
<%@ Register Assembly="DevExpress.Web.v24.2" Namespace="DevExpress.Web"
    TagPrefix="dxe" %>

<div style="white-space:nowrap;">
    <dxe:ASPxLabel ID="lblInterval" runat="server" Text="CustomDragAppointmentTooltip" EnableClientSideAPI="true">
        </dxe:ASPxLabel>
    <br />
    <dxe:ASPxLabel ID="lblInfo" runat="server" Text="Press ESC to cancel operation" EnableClientSideAPI="true"></dxe:ASPxLabel>
</div>

<script id="dxss_ASPxClientAppointmentDragTooltip" type="text/javascript"><!--
    ASPxClientAppointmentDragTooltip = ASPx.CreateClass(ASPxClientToolTipBase, {
        CalculatePosition: function(bounds) {
            return new ASPxClientPoint(bounds.GetLeft(), bounds.GetTop() - bounds.GetHeight());
        },
        Update: function (toolTipData) {
            var stringInterval = this.GetToolTipContent(toolTipData);
            var oldText = this.controls.lblInterval.GetText();
            if (oldText != stringInterval)
                this.controls.lblInterval.SetText(stringInterval);
        },
        GetToolTipContent: function(toolTipData) {	
	        var interval = toolTipData.GetInterval();
	        return this.ConvertIntervalToString(interval);
        }
    });
//--></script>