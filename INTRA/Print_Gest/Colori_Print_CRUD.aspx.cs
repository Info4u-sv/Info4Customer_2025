using DevExpress.Web;
using Info4U.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest
{
    public partial class Colori_Print_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string GetColorBox(object hexValue)
        {
            if (hexValue == null) return "";
            string color = hexValue.ToString();

            return $"<div style='display:flex; align-items:center; gap:6px;'>" +
                   $"<div style='width:16px; height:16px; background-color:{color}; border-radius:3px; border:1px solid #ccc;'></div>" +
                   $"<span style='color:#000;font-weight:normal'>{color}</span></div>";
        }

        protected Color ConvertHexToColor(object value)
        {
            try
            {
                if (value == null) return Color.Transparent;
                return ColorTranslator.FromHtml(value.ToString());
            }
            catch
            {
                return Color.Transparent;
            }
        }

        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            ASPxColorEdit colorEdit = grid.FindEditRowCellTemplateControl(
                (GridViewDataColumn)grid.Columns["HexColor"], "ColorIconBackColorEdit") as ASPxColorEdit;

            if (colorEdit != null)
            {
                e.NewValues["HexColor"] = ColorTranslator.ToHtml(colorEdit.Color);
            }
            e.NewValues["CreatedUser"] = HttpContext.Current.User.Identity.Name;

            int dsOrder = e.NewValues["DisplayOrder"] != null ? Convert.ToInt32(e.NewValues["DisplayOrder"]) : 0;
            if(dsOrder == 0)
            {
                SqlDataReader reader = new Sql4Helper().ExecuteReader("SELECT MAX(DisplayOrder) AS Ds FROM Colori_Print");
                if (reader.Read())
                {
                    e.NewValues["DisplayOrder"] = Convert.ToInt32(reader["Ds"]) + 1;
                }
                reader.Close();
            }
        }

        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            ASPxColorEdit colorEdit = grid.FindEditRowCellTemplateControl(
                (GridViewDataColumn)grid.Columns["HexColor"], "ColorIconBackColorEdit") as ASPxColorEdit;

            if (colorEdit != null)
            {
                e.NewValues["HexColor"] = ColorTranslator.ToHtml(colorEdit.Color);
            }
            e.NewValues["EditUser"] = HttpContext.Current.User.Identity.Name;

            int dsOrder = e.NewValues["DisplayOrder"] != null ? Convert.ToInt32(e.NewValues["DisplayOrder"]) : 0;
            if (dsOrder == 0)
            {
                SqlDataReader reader = new Sql4Helper().ExecuteReader("SELECT MAX(DisplayOrder) AS Ds FROM Colori_Print");
                if (reader.Read())
                {
                    e.NewValues["DisplayOrder"] = Convert.ToInt32(reader["Ds"]) + 1;
                }
                reader.Close();
            }
        }

    }
}