using DevExpress.Utils;
using DevExpress.Web;
using System;
using System.Linq;

namespace INTRA.SuperAdmin.Parametri
{
    public partial class LFT_ParameterPeriodiche : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxDropDownEdit ddResource = (ASPxDropDownEdit)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["RuoliAbilitati"] as GridViewDataColumn, "ddResource");
            e.NewValues["RuoliAbilitati"] = ddResource.Text;
        }

        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            ASPxDropDownEdit ddResource = (ASPxDropDownEdit)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["RuoliAbilitati"] as GridViewDataColumn, "ddResource");
            e.NewValues["RuoliAbilitati"] = ddResource.Text;
        }

        protected void edtMultiResource_DataBinding(object sender, EventArgs e)
        {

        }

        protected void edtMultiResource_DataBound(object sender, EventArgs e)
        {
            ASPxDropDownEdit ddResource = (ASPxDropDownEdit)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["RuoliAbilitati"] as GridViewDataColumn, "ddResource");
            ASPxListBox edtMultiResource = (ASPxListBox)ddResource.FindControl("edtMultiResource");
            var Ruoli = ddResource.Text.Replace(" ", "").Split(',');
            for (int i = 0; i < Ruoli.Count(); i++)
            {
                foreach (ListEditItem item in edtMultiResource.Items)
                {
                    if (item.Text == Ruoli[i])
                    {
                        item.Selected = true;
                    }
                }
            }
        }

        protected void Generic_Gridview_HtmlEditFormCreated(object sender, ASPxGridViewEditFormEventArgs e)
        {
            //    int index = Generic_Gridview.EditingRowVisibleIndex;
            //    if (index > -1)
            //    {
            //        Generic_Gridview.Columns[3].CellStyle.CssClass = "hidecolumn";
            //        Generic_Gridview.Columns[1].CellStyle.CssClass = "hidecolumn";
            //    }
        }

        protected void Generic_Gridview_BeforeGetCallbackResult(object sender, EventArgs e)
        {
            ASPxGridView Generic_gridview = sender as ASPxGridView;
            if (!Generic_gridview.IsNewRowEditing)
            {
                (Generic_gridview.Columns["Type"] as GridViewDataColumn).EditFormSettings.Visible = DefaultBoolean.False;
                (Generic_gridview.Columns["CodParam"] as GridViewDataColumn).EditFormSettings.Visible = DefaultBoolean.False;
            }
        }
    }
}