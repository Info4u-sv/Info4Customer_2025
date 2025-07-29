using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Stats
{
    public partial class Clienti : System.Web.UI.Page
    {
        HashSet<string> classiValide = new HashSet<string>
{
     "DaContratto", "DaFatturareParzialmente", "DaDefinire", "DaCommessa", "InGaranzia", "NonDefinito", "DaFatturare", "DaCarnet"
};
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != GridViewRowType.Data) return;

            string fatt = e.GetValue("Fatturazione")?.ToString();
            int colIndex = Generic_Gridview.Columns["Fatturazione"].VisibleIndex;

            if (!string.IsNullOrWhiteSpace(fatt) && classiValide.Contains(fatt.Replace(" ", "")))
            {
                e.Row.Cells[colIndex].Controls.Clear();
                e.Row.Cells[colIndex].Controls.Add(new Literal
                {
                    Text = $"<label class='label {fatt.Replace(" ", "")}'>{fatt}</label>"
                });
            }
        }
        protected void Generic_Gridview_ToolbarItemClick(object source, DevExpress.Web.Data.ASPxGridViewToolbarItemClickEventArgs e)
        {
            if (e.Item.Name == "CustomExportToXlsx")
            {
                Generic_Gridview.DataColumns["MotivoChiamata"].Visible = true;
                Generic_Gridview.DataColumns["LavoroEseguito"].Visible = true;

                Generic_Gridview.ExportXlsxToResponse();
            }

        }
    }
}