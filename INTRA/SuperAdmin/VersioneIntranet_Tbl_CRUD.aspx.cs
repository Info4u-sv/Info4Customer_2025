using System;
using System.Data;
using System.IO;
using System.Linq;

namespace INTRA.SuperAdmin
{
    public partial class VersioneIntranet_Tbl_CRUD : System.Web.UI.Page
    {
        private string XmlFilePath => Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid();
        }

        private void BindGrid()
        {
            if (!File.Exists(XmlFilePath))
            {
                // Crea tabella vuota se non esiste file
                DataTable dt = new DataTable("APP_Versioni");
                dt.Columns.Add("Id", typeof(int));
                dt.Columns["Id"].AutoIncrement = true;
                dt.Columns["Id"].AutoIncrementSeed = 1;
                dt.Columns["Id"].AutoIncrementStep = 1;
                dt.Columns["Id"].ReadOnly = true;
                dt.Columns.Add("TitVers", typeof(string));
                dt.Columns.Add("NewFeatures", typeof(string));
                dt.Columns.Add("BugFix", typeof(string));
                dt.Columns.Add("NumeroLic", typeof(string));
                dt.Columns.Add("RagSoc", typeof(string));
                DataSet ds = new DataSet();
                ds.Tables.Add(dt);
                ds.WriteXml(XmlFilePath, XmlWriteMode.WriteSchema);
            }

            DataSet dataset = new DataSet();
            dataset.ReadXml(XmlFilePath);
            GridView1.DataSource = dataset.Tables["APP_Versioni"];
            GridView1.DataBind();
        }

        protected void GridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            DataSet ds = new DataSet();
            ds.ReadXml(XmlFilePath);

            DataTable dt = ds.Tables["APP_Versioni"];

            int id = Convert.ToInt32(e.Keys["Id"]);
            DataRow row = dt.Rows.Cast<DataRow>().FirstOrDefault(r => (int)r["Id"] == id);

            if (row != null)
            {
                row["TitVers"] = e.NewValues["TitVers"]?.ToString() ?? "";
                row["NewFeatures"] = e.NewValues["NewFeatures"]?.ToString() ?? "";
                row["BugFix"] = e.NewValues["BugFix"]?.ToString() ?? "";
                row["NumeroLic"] = e.NewValues["NumeroLic"]?.ToString() ?? "";
                row["RagSoc"] = e.NewValues["RagSoc"]?.ToString() ?? "";
            }

            ds.WriteXml(XmlFilePath, XmlWriteMode.WriteSchema);

            e.Cancel = true;
            GridView1.CancelEdit();
            BindGrid();
        }

        protected void GridView1_PageIndexChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void GridView1_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(e.NewValues["TitVers"]?.ToString()))
                e.Errors[GridView1.Columns["TitVers"]] = "TitVers è obbligatorio.";
        }
    }
}
