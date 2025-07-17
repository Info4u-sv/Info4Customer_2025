using System;

namespace INTRA.ShopRM
{
    public partial class _conferma_ordine : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["ok"]))
            {

                SHP_CartView.TitCartView = "Conferma Ordine";
                SHP_CartView.TipoPagina = "ConfermaOrdine";
            }
            else
            {
                SHP_CartView.TitCartView = "Ordine Inviato";
                SHP_CartView.TipoPagina = "Pagato";
            }
        }
    }
}