using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Magazzino
{
    public partial class Dashboard_Magazzino : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void detail_Gridview_BeforePerformDataSelect(object sender, EventArgs e)
        {
            string c = (sender as ASPxGridView).GetMasterRowKeyValue() as string;
            Session["CodDep_Session"] = c;
        }

        protected void detail_Gridview_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != DevExpress.Web.GridViewRowType.Data)
            {
                return;

            }
            else
            {
                int scorta = Convert.ToInt32(e.GetValue("Giacenza")) - Convert.ToInt32(e.GetValue("Qta_Min"));
                if (scorta <= 0)
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#feb0bc");
                }
                else if (scorta > 0 && scorta <= 2)
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#f2f28f");
                }
                else if (scorta > 2)
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#a4e6a4");
                }

            }
        }
    }
}