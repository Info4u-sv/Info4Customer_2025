using System;
using DevExpress.Web.ASPxScheduler;
using DevExpress.XtraScheduler;
using Microsoft.AspNet.EntityDataSource;
using DevExpress.Web.Demos;
using System.Web.UI.WebControls;

namespace INTRA.PRT_Calendar
{
    public partial class PRT_UserAppointments : System.Web.UI.Page
    {
        protected void Page_Init()
        {
            DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
            DemoHelper.Instance.PrepareControlOptions(OptionsFormLayout, new ControlOptionsSettings
            {
                ColumnMinWidth = 400,
                ColumnCountMode = RecalculateColumnCountMode.RootGroup
            });
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SchedulerDemoUtils.ApplyDefaults(this, ASPxScheduler1);
            DataHelper.SetupDefaultMappings(ASPxScheduler1);
            DataHelper.ProvideRowInsertion(ASPxScheduler1, AppointmentDataSource);
            DataHelper.SetupStatuses(ASPxScheduler1);
            DataHelper.SetupLabels(ASPxScheduler1);
            ApplyOptions();
            ASPxScheduler1.DataBind();
        }

        void ApplyOptions()
        {
            ASPxScheduler1.BeginUpdate();
            try
            {
                DevExpress.Web.ASPxScheduler.DayView dayView = ASPxScheduler1.DayView;
                dayView.ShowWorkTimeOnly = chkShowWorkTimeOnly.Checked;
                dayView.ShowAllDayArea = chkShowAllDayArea.Checked;
                dayView.ShowDayHeaders = chkShowDayHeaders.Checked;
                dayView.DayCount = (int)cbDayCount.SelectedIndex + 1;

                dayView.AppointmentDisplayOptions.SnapToCellsMode = (AppointmentSnapToCellsMode)cbSnapToCellsMode.Value;
                dayView.AppointmentDisplayOptions.StartTimeVisibility = (AppointmentTimeVisibility)cbStartTimeVisibility.Value;
                dayView.AppointmentDisplayOptions.EndTimeVisibility = (AppointmentTimeVisibility)cbEndTimeVisibility.Value;
                dayView.AppointmentDisplayOptions.ShowRecurrence = cbShowRecurrence.Checked;
            }
            finally
            {
                ASPxScheduler1.EndUpdate();
            }
            ApplyCommonOptions();
            ASPxScheduler1.ApplyChanges(ASPxSchedulerChangeAction.NotifyVisibleIntervalsChanged);
        }

        void ApplyCommonOptions()
        {
            ASPxScheduler1.OptionsBehavior.HighlightSelectionHeaders = HighlightSelectionCheckBox.Checked;
            ASPxScheduler1.OptionsView.AppointmentSelectionAppearanceMode = (AppointmentSelectionAppearanceMode)SelectionAppearanceModeComboBox.Value;
            ASPxScheduler1.OptionsBehavior.ShowViewNavigator = ShowViewNavigatorCheckBox.Checked;
            ASPxScheduler1.OptionsBehavior.ShowViewVisibleInterval = ShowViewVisibleIntervalCheckBox.Checked;
        }

    }
}