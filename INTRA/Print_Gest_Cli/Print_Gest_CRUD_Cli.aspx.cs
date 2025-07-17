using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest_Cli
{
    public partial class Print_Gest_CRUD_Cli : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Generic_gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            e.NewValues["CreatedUser"] = HttpContext.Current.User.Identity.Name;
            e.NewValues["EditUser"] = HttpContext.Current.User.Identity.Name;

        }

        protected void Generic_gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            e.NewValues["EditUser"] = HttpContext.Current.User.Identity.Name;
        }
        protected void Modello_Txt_Init(object sender, EventArgs e)
        {
            ASPxTextBox txt = (ASPxTextBox)sender;
            GridViewDataItemTemplateContainer container = (GridViewDataItemTemplateContainer)txt.NamingContainer;
            HiddenField hid = (HiddenField)container.FindControl("Modello_Hid");
            txt.Text = hid.Value;
        }

        protected void Tipologia_Txt_Init(object sender, EventArgs e)
        {
            ASPxTextBox txt = (ASPxTextBox)sender;
            GridViewDataItemTemplateContainer container = (GridViewDataItemTemplateContainer)txt.NamingContainer;
            HiddenField hid = (HiddenField)container.FindControl("Tipologia_Hid");
            txt.Text = hid.Value;
        }
        protected void Articoli_Grw_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            // Prendo il container dell'edit form
            GridViewEditFormTemplateContainer container = Articoli_Grw.FindEditFormTemplateControl("Modello_Txt")?.NamingContainer as GridViewEditFormTemplateContainer;

            if (container != null)
            {
                ASPxTextBox modelloTxt = container.FindControl("Modello_Txt") as ASPxTextBox;
                ASPxTextBox tipologiaTxt = container.FindControl("Tipologia_Txt") as ASPxTextBox;
                ASPxTextBox idPrinterTxt = container.FindControl("ID_Printer_Txt") as ASPxTextBox;

                if (modelloTxt != null)
                    e.NewValues["Modello"] = modelloTxt.Text;

                if (tipologiaTxt != null)
                    e.NewValues["ID_Tipologia"] = tipologiaTxt.Text;
                if (idPrinterTxt != null)
                    e.NewValues["ID_Printer"] = idPrinterTxt.Text;
            }
            else
            {
                // fallback
                ASPxTextBox modelloTxt = Articoli_Grw.FindEditFormTemplateControl("Modello_Txt") as ASPxTextBox;
                ASPxTextBox tipologiaTxt = Articoli_Grw.FindEditFormTemplateControl("Tipologia_Txt") as ASPxTextBox;
                ASPxTextBox idPrinterTxt = Articoli_Grw.FindEditFormTemplateControl("ID_Printer_Txt") as ASPxTextBox;

                if (modelloTxt != null)
                    e.NewValues["Modello"] = modelloTxt.Text;

                if (tipologiaTxt != null)
                    e.NewValues["ID_Tipologia"] = tipologiaTxt.Text;
                if (idPrinterTxt != null)
                    e.NewValues["ID_Printer"] = idPrinterTxt.Text;
            }
        }
        protected void Printer_Ordini_DTS_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                int newID = 0;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT CAST(MAX(ID) AS INT) FROM Printer_ANA", conn))
                    {
                        newID = (int)cmd.ExecuteScalar();
                    }
                }
                string url = $"Print_Gest_Edit_Cli.aspx?ID={newID}";
                DevExpress.Web.ASPxWebControl.RedirectOnCallback(url);
            }
        }
    }
}