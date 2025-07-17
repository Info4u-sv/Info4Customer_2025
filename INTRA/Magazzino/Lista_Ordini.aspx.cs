using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Magazziniere
{
    public partial class Lista_Ordini : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Generic_Gridview_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != DevExpress.Web.GridViewRowType.Data)
            {
                return;

            }
            else
            {
                string Descrizione = e.GetValue("Descrizione").ToString();
                if (Descrizione == "INSERITO")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#feb0bc");
                }
                else if (Descrizione == "PARZIALMENTE EVASO")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#f2f28f");
                }
                else if (Descrizione == "EVASO" || Descrizione == "CHIUSO")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#a4e6a4");
                }

            }
        }

    }
}