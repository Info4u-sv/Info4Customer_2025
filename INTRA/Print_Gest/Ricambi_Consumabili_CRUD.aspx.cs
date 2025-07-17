using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest
{
    public partial class Ricambi_Consumabili_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Generic_gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            e.NewValues["CreatedUser"] = HttpContext.Current.User.Identity.Name;
        }

        protected void Generic_gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            e.NewValues["EditUser"] = HttpContext.Current.User.Identity.Name;
        }
        protected void ASPxGridView1_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == GridViewRowType.Data)
            {
                int brandId = Convert.ToInt32(e.GetValue("BrandId"));
                var imgControl = Generic_Gridview.FindRowCellTemplateControl(e.VisibleIndex, (GridViewDataColumn)Generic_Gridview.Columns["BrandImageColumn"], "imgBrand") as System.Web.UI.WebControls.Image;

                if (imgControl != null)
                {
                    byte[] imgBytes = GetBrandImageBytes(brandId);
                    if (imgBytes != null)
                    {
                        string base64String = Convert.ToBase64String(imgBytes);
                        imgControl.ImageUrl = "data:image/jpeg;base64," + base64String;
                    }
                }
            }
        }
        private byte[] GetBrandImageBytes(int brandId)
        {
            byte[] bytes = null;
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            using (var conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand("SELECT PhotoBytes FROM Brand WHERE ID = @ID", conn))
                {
                    cmd.Parameters.AddWithValue("@ID", brandId);
                    var result = cmd.ExecuteScalar();
                    if (result != DBNull.Value && result != null)
                        bytes = (byte[])result;
                }
            }
            return bytes;
        }
        protected string GetColorDotAndName(int coloreID)
        {
            var colori = new Dictionary<int, (string descr, string hex)>()
    {
        { 1, ("Nero", "#000000") },
        { 2, ("Giallo", "#FFFF00") },
        { 3, ("Magenta", "#FF00FF") },
        { 4, ("Ciano", "#00FFFF") },
        { 5, ("Waste", "#FFFFFF") },
        { 7, ("Nessuno", "#FFFFFF") },
        { 9, ("CMYK", "#FFFFFF") },
    };

            if (!colori.ContainsKey(coloreID))
                return "<div>Sconosciuto</div>";

            var (descr, hex) = colori[coloreID];

            return $"<div style='display:flex; align-items:center; gap:6px;'>"
                 + $"<div style='width:16px; height:16px; background-color:{hex}; border-radius:3px; border:1px solid #ccc;'></div>"
                 + $"<span>{descr}</span>"
                 + $"</div>";
        }
        protected void Generic_Image_CustomCallback(object sender, CallbackEventArgsBase e)
        {
            string imgBase64 = e.Parameter;

            ASPxBinaryImage image = (ASPxBinaryImage)sender;

            string xxx = imgBase64.Replace("data:image/jpeg;base64,", " ");
            byte[] imgByte = Convert.FromBase64String(xxx);

            image.Value = imgByte;

        }
    }
}