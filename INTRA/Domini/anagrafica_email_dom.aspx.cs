using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Domini
{
    public partial class anagrafica_email_dom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Generic_Gridview_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int IdEmail = Convert.ToInt32(e.Keys["IdEmail"]);

            STD_Email IstanzaSTD_Email = new STD_Email();
            IstanzaSTD_Email.IdEmail = IdEmail;
            IstanzaSTD_Email.DeleteSTD_Email(IstanzaSTD_Email);

            // Ferma il comportamento di default (che usa il SqlDataSource per cancellare)
            e.Cancel = true;

            // Rebind dei dati
            Generic_Gridview.DataBind();
        }
        protected void Generic_Gridview_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            int idEmail = Convert.ToInt32(Generic_Gridview.GetRowValues(e.VisibleIndex, "IdEmail"));
            int idDom = Convert.ToInt32(Generic_Gridview.GetRowValues(e.VisibleIndex, "IdDominio"));

            switch (e.ButtonID)
            {
                case "VisualizzaEmail":
                    Response.Redirect($"email_dom_gest.aspx?idEmail={idEmail}&idDom={idDom}&Type=0");
                    break;

                case "ModificaEmail":
                    Response.Redirect($"email_dom_gest.aspx?idEmail={idEmail}&idDom={idDom}&Type=2");
                    break;
            }
        }

    }
}