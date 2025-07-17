using System;

namespace INTRA.Catalogo
{
    public partial class Lista_Articoli : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Generic_Grw_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.VisibleIndex > -1)
            {
                string _ScadenzaDocumento = Generic_Grw.GetRowValues(e.VisibleIndex, "Scadenza").ToString();

                if (e.DataColumn.FieldName == "StopDate" || e.DataColumn.FieldName == "StartDate" || e.DataColumn.FieldName == "PromoPrice")
                {
                    if (_ScadenzaDocumento.Contains("SCADUTO"))
                    {
                        e.Cell.BackColor = System.Drawing.Color.FromName("#ff3300");
                        e.Cell.ForeColor = System.Drawing.Color.White;
                    }
                    else if (_ScadenzaDocumento.Contains("IN SCADENZA"))
                    {
                        e.Cell.BackColor = System.Drawing.Color.FromName("#ff9900");
                        e.Cell.ForeColor = System.Drawing.Color.White;
                    }
                    else if (_ScadenzaDocumento.Contains("ATTIVO"))
                    {
                        e.Cell.BackColor = System.Drawing.Color.FromName("#00cc00");
                        e.Cell.ForeColor = System.Drawing.Color.White;
                    }
                }
            }
        }

        protected void Elimina_CallbackPnl_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string ProductID = Generic_Grw.GetRowValues(Convert.ToInt32(e.Parameter), "ProductID").ToString();
            AppoggioEliminazione_Sql.DeleteParameters["ProductID"].DefaultValue = ProductID;
            _ = AppoggioEliminazione_Sql.Delete();


        }
    }
}