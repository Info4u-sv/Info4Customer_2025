<%@ Control Language="C#" AutoEventWireup="true" Inherits="AppointmentMobileToolTip" Codebehind="AppointmentMobileToolTip.ascx.cs" %>
<%@ Register Assembly="DevExpress.Web.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<div class="dxsc-mobile-appointment-tooltip">
    <div class="dxsc-mat-header">
        <div class="dxsc-mat-close" runat="server" id="closeImg"></div>

        <div class="dxsc-mat-interval">
            <dx:ASPxLabel runat="server" ID="lblInterval" CssClass="dxsc-mat-time" Font-Size="15px" EnableClientSideAPI="true">
            </dx:ASPxLabel>
        </div>
    </div>
    
    <div class="dxsc-mat-images-container"></div>
    <div class="dxsc-mat-content">
        <dx:ASPxLabel runat="server" ID="lblSubject" Font-Size="16px" EnableClientSideAPI="true">
        </dx:ASPxLabel>
        <br />
        <dx:ASPxLabel runat="server" ID="lblDescription" CssClass="dxsc-mat-description" Font-Size="14px" EnableClientSideAPI="true">
        </dx:ASPxLabel>
    </div>
</div>

<script type="text/javascript" id="dxss_mat">
    // <![CDATA[
    ASPxClientAppointmentMobileToolTip = ASPx.CreateClass(ASPxClientAppointmentMobileToolTipBase, {
        Initialize: function () {
            ASPxClientUtils.AttachEventToElement(this.controls.closeImg, "click", this.OnCloseClick.aspxBind(this));
        },
        OnCloseClick: function () {
            this.scheduler.appointmentSelection.ClearSelection();
        },
        Update: function (data) {
            var apt = data.GetAppointment();
            this.apt = apt;

            this.UpdateTooltipInfo(apt);

            var textInterval = this.ConvertIntervalToString(apt.interval);
            this.controls.lblInterval.SetText(textInterval);
            
        },
        UpdateTooltipInfo: function(apt) {
            this.controls.lblSubject.SetText(this.GetSubjectText(apt));
            this.controls.lblDescription.SetText(this.GetDescriptionText(apt));

            this.createAppointmentImages();
        },
        GetSubjectText: function(apt) {
            var subject = ASPx.Str.EncodeHtml(apt.GetSubject());
            var location = ASPx.Str.EncodeHtml(apt.GetLocation());
            if(location) {
                subject += " (" + location + ")";
            }
            return subject;
        },
        GetDescriptionText: function (apt) {
            return ASPx.Str.EncodeHtml(apt.GetDescription());
        }
    });
    // ]]> 
</script>
    