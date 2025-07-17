using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxScheduler;

public partial class AppointmentMobileToolTip : ASPxSchedulerToolTipBase {
    public override bool ToolTipShowStem {
        get {
            return false;
        }
    }
    public override bool ToolTipCloseOnClick {
        get {
            return true;
        }
    }
    public override bool ToolTipResetPositionByTimer {
        get {
            return false;
        }
    }

    public override string ClassName { get { return "ASPxClientAppointmentMobileToolTip"; } }

    protected override Control[] GetChildControls() {
        return new Control[] { lblSubject, lblInterval, lblDescription, closeImg };
    }
}