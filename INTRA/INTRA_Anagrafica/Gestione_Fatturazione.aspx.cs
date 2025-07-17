using System;
using System.IO;

namespace GMSL_V1.INTRA_Anagrafica
{
    public partial class Gestione_Fatturazione : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["DocMancanteSess"] = null;
            }
        }


        protected void ListaDoc_Gridview_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.VisibleIndex > -1)
            {
                if (e.Column.Name == "Exist")
                {
                    string Path = ListaDoc_Gridview.GetRowValues(e.VisibleIndex, "PercorsoFile").ToString();
                    bool Obbligatorio = Convert.ToBoolean(ListaDoc_Gridview.GetRowValues(e.VisibleIndex, "Obbligatorio"));
                    if (File.Exists(Server.MapPath(Path)))
                    {
                        e.DisplayText = "ESISTE";
                    }
                    else
                    {
                        if (Obbligatorio)
                        {
                            e.DisplayText = "NON ESISTE";

                        }
                        else
                        {
                            e.DisplayText = "NON ESISTE MA NON OBBLIGATORIO";

                        }
                    }
                }
            }
        }

        protected void ListaDoc_Gridview_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.VisibleIndex > -1)
            {
                if (e.DataColumn.Name == "Exist")
                {

                    string Path = ListaDoc_Gridview.GetRowValues(e.VisibleIndex, "PercorsoFile").ToString();
                    bool Obbligatorio = Convert.ToBoolean(ListaDoc_Gridview.GetRowValues(e.VisibleIndex, "Obbligatorio"));

                    if (File.Exists(Server.MapPath(Path)))
                    {
                        e.Cell.BackColor = System.Drawing.Color.LightGreen;

                    }
                    else
                    {
                        if (Obbligatorio)
                        {
                            e.Cell.BackColor = System.Drawing.Color.Red;
                        }
                        else
                        {
                            e.Cell.BackColor = System.Drawing.Color.LightGreen;
                        }
                    }
                    e.Cell.ForeColor = System.Drawing.Color.White;
                }
            }

        }


        protected void ListaDoc_Gridview_BeforePerformDataSelect(object sender, EventArgs e)
        {
            string Path = string.Empty;

            for (int i = 0; i < ListaDoc_Gridview.VisibleRowCount; i++)
            {
                Path = ListaDoc_Gridview.GetRowValues(i, "PercorsoFile").ToString();
                if (Session["DocMancanteSess"] == null)
                {
                    if (!File.Exists(Path))
                    {
                        ImportaDoc_Btn.ClientEnabled = false;
                        Session["DocMancanteSess"] = 1;
                    }
                }

            }
        }

        protected void ListaDoc_Gridview_Unload(object sender, EventArgs e)
        {


            string Path = string.Empty;

            for (int i = 0; i < ListaDoc_Gridview.VisibleRowCount; i++)
            {
                Path = ListaDoc_Gridview.GetRowValues(i, "PercorsoFile").ToString();
                if (Session["DocMancanteSess"] == null)
                {
                    if (!File.Exists(Path))
                    {
                        ImportaDoc_Btn.ClientEnabled = false;
                        Session["DocMancanteSess"] = 1;
                    }
                }

            }
        }
    }
}