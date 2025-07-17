using System;
using System.Drawing;

namespace INTRA.INTRA_Anagrafica
{
    public partial class CRUD_Status_Offerta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected Color GetColor(object container)
        {
            try
            {
                int ColorDec = Convert.ToInt32(container.ToString().Replace("#", string.Empty), 16);
                Color color = Color.FromArgb(ColorDec);
                return color;
            }
            catch (Exception)
            {
                return Color.Red;
            }
        }

        //protected void Generic_gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        //{
        //    ASPxColorEdit colorEdit = Generic_gridview.FindEditRowCellTemplateControl(Generic_gridview.Columns["LabelClass"] as GridViewDataColumn, "ColorEditHeaderBackColor") as ASPxColorEdit;
        //    e.NewValues["LabelClass"] = colorEdit.Text;
        //}

        //protected void Generic_gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        //{
        //    ASPxColorEdit colorEdit = Generic_gridview.FindEditRowCellTemplateControl(Generic_gridview.Columns["LabelClass"] as GridViewDataColumn, "ColorEditHeaderBackColor") as ASPxColorEdit;
        //    e.NewValues["LabelClass"] = colorEdit.Text;
        //}
    }
}