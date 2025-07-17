using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ordini
{
	public partial class Dettaglio_Ordini_Fornitore : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void Dettaglio_Grw_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            try
            {
                if (e.RowType != GridViewRowType.Data) return;
                string TipoNota = e.GetValue("TipoNota").ToString();
                string Descrizione = e.GetValue("Nota").ToString();

                int numerocolonne = e.Row.Cells.Count;
                // e.Row.Cells[1].Equals("Descrizione");

                if (TipoNota.Equals("N"))
                {
                    int columnIndex = 0;

                    //int index = GetColumnIndexByName(e.Row, "myDataField");

                    for (int i = numerocolonne - 1; i > 1; i--)
                    {
                        //bool xxx = e.Row.Cells[i].Equals("Descrizione");

                        e.Row.Cells.Remove(e.Row.Cells[i]);
                    }
                    TableCell Descr_vart = new TableCell();
                    Descr_vart.Text = Descrizione;
                    e.Row.Cells.Add(Descr_vart);
                    int numerocolonneDopo = e.Row.Cells.Count;
                    e.Row.Cells[numerocolonneDopo - 1].ColumnSpan = numerocolonne - 1;
                    e.Row.Cells[numerocolonneDopo - 1].BackColor = Color.Beige;
                }
            }
            catch (Exception ex) { }
        }
    }
}