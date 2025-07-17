using System;

namespace INTRA.Parametri_Cliente_Frontend
{
    public partial class PRT_Parameter_Frontend : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            //BootstrapTextBox Generic_textbox = (BootstrapTextBox)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["Value"] as BootstrapGridViewDataColumn, "Generic_textbox");
            //ASPxHtmlEditor Generic_HtmlEditor = (ASPxHtmlEditor)Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["Value"] as BootstrapGridViewDataColumn, "Generic_HtmlEditor");
            //ASPxGridView gridView = (ASPxGridView)sender;

            //if (Generic_textbox.Text != "" && e.NewValues["Type"].ToString() != "HTML")
            //{
            //    e.NewValues["Value"] = Generic_textbox.Text;
            //}
            //else
            //{
            //    if (Generic_HtmlEditor.Html != "")
            //    {
            //        e.NewValues["Value"] = Generic_HtmlEditor.Html;
            //    }
            //}
        }
    }
}