using System;

namespace INTRA.Controls
{
    public partial class Alert_Scadenze : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Scadenze_Gridview_DataBound(object sender, EventArgs e)
        {
            if (Scadenze_Gridview.VisibleRowCount > 0)
            {

                if (Session["ControlloDataPerPopupHome"] == null)
                {
                    AlertScadenze_Popup.ShowOnPageLoad = true;
                    Session["ControlloDataPerPopupHome"] = DateTime.Now.ToShortDateString();
                }


            }
        }
    }

}