using DevExpress.Web;
using DevExpress.Web.ASPxHtmlEditor;
using DevExpress.Web.Bootstrap;
using System;

namespace INTRA.SuperAdmin
{
    public partial class PRT_Parameter_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            BootstrapTextBox Generic_textbox = (BootstrapTextBox)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["Value"] as BootstrapGridViewDataColumn, "Generic_textbox");
            ASPxHtmlEditor Generic_HtmlEditor = (ASPxHtmlEditor)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["Value"] as BootstrapGridViewDataColumn, "Generic_HtmlEditor");

            if (Generic_textbox.Text != string.Empty)
            {
                e.NewValues["Value"] = Generic_textbox.Text;
            }
            if (Generic_HtmlEditor.Html != "")
            {
                e.NewValues["Value"] = Generic_HtmlEditor.Html;
            }
        }

        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            BootstrapTextBox Generic_textbox = (BootstrapTextBox)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["Value"] as BootstrapGridViewDataColumn, "Generic_textbox");
            ASPxHtmlEditor Generic_HtmlEditor = (ASPxHtmlEditor)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["Value"] as BootstrapGridViewDataColumn, "Generic_HtmlEditor");
            ASPxGridView gridView = (ASPxGridView)sender;

            if (Generic_textbox.Text != string.Empty && e.NewValues["Type"].ToString() != "HTML")
            {
                e.NewValues["Value"] = Generic_textbox.Text;
            }
            else
            {
                if (Generic_HtmlEditor.Html != string.Empty)
                {
                    e.NewValues["Value"] = Generic_HtmlEditor.Html;
                }
            }
        }
    }
}