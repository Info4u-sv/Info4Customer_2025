<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AppointmentToolTip.ascx.cs" Inherits="UserForms_AppointmentToolTip" %>
<%@ Register Assembly="DevExpress.Web.v24.2" Namespace="DevExpress.Web"
    TagPrefix="dxe" %>
<div runat="server" id="buttonDiv">
    <dxe:ASPxButton ID="btnShowMenu" runat="server" AutoPostBack="False" AllowFocus="False">
        <Border BorderWidth="0px" />
        <Paddings Padding="0px" />
        <FocusRectPaddings Padding="4px" />
        <FocusRectBorder BorderStyle="None" BorderWidth="0px" />
    </dxe:ASPxButton>
</div>    

<script type="text/javascript" id="dxss_ASPxClientAppointmentToolTip">
    ASPxClientAppointmentToolTip = ASPx.CreateClass(ASPxClientToolTipBase, {
        Initialize: function() {
            ASPxClientUtils.AttachEventToElement(this.controls.buttonDiv, "click", ASPx.CreateDelegate(this.OnButtonDivClick, this));
        },
        OnButtonDivClick: function(s,e) {
            this.ShowAppointmentMenu(s);
        }
    });    
</script>
