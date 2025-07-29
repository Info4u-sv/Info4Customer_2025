using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Stats
{
    public partial class Contratto_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Session["GeneraPdfSession"] != null)
                //{
                //    //Exporting
                //    DevExpress.XtraReports.UI.XtraReport report = new Contratto_Riepilogo_Rpt();
                //    report.Parameters["CodCliParam"].Value = "C0190";
                //    report.Parameters["IDcontrattoParam"].Value = "CAR020-2020/05/26";
                //    report.Parameters["IDcontrattoParam"].Value = "CAR020-2020/05/26";
                //    report.Parameters["FromParam"].Value = Scadenza_Date_Da.Date;
                //    report.Parameters["ToParam"].Value = Scadenza_Date_A.Date;
                //    string format = "pdf";
                //    string fileName = "Report" ;

                //    MemoryStream ms = new MemoryStream();
                //    report.ExportToPdf(ms);
                //    Byte[] FileBuffer = ms.ToArray();
                //    if (FileBuffer != null)
                //    {
                //        Response.ContentType = "application/pdf";
                //        Response.AddHeader("Content-Disposition", "filename=" + fileName + ".pdf");
                //        Response.AddHeader("content-length", FileBuffer.Length.ToString());
                //        Response.BinaryWrite(FileBuffer);
                //    }
                //    Session["GeneraPdfSession"] = null;
                //}
            }
        }

        protected void Contratti_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            Session["CodCliSelezionatoSession"] = Cliente_Combobox.SelectedItem.GetFieldValue("CodCli").ToString();
            Contratti_Combobox.SelectedIndex = -1;
            Contratti_Combobox.DataBind();
        }

        protected void FiltroContratto_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {

        }

        protected void Label_Callbackpnl_Callback(object sender, CallbackEventArgsBase e)
        {
            try
            {
                if (Contratti_Combobox.SelectedItem != null)
                {
                    TotaleContr_Lbl.Text = Convert.ToString(Contratti_Combobox.SelectedItem.GetFieldValue("Totale"));
                    Totinterventi_Lbl.Text = Convert.ToString(Contratti_Combobox.SelectedItem.GetFieldValue("Totinterventi"));
                    ResiduoOre_Lbl.Text = Convert.ToString(Contratti_Combobox.SelectedItem.GetFieldValue("ResiduoOre"));
                    TipoContr_Lbl.Text = Convert.ToString(Contratti_Combobox.SelectedItem.GetFieldValue("Descrizione"));
                    //Label_Callbackpnl.JSProperties["cpSottrazione"] = Convert.ToDecimal(MateriaPrima_Combobox.SelectedItem.GetFieldValue("QtaOrd")) - Convert.ToDecimal(MateriaPrima_Combobox.SelectedItem.GetFieldValue("QtaEva"));
                }
                else
                {
                    TotaleContr_Lbl.Text = "?";
                    Totinterventi_Lbl.Text = "?";
                    ResiduoOre_Lbl.Text = "?";
                    TipoContr_Lbl.Text = "?";
                }
            }
            catch
            {
                //Label_Callbackpnl.JSProperties["cpSottrazione"] = "";
            }
        }

        protected void StampaReport_Click(object sender, EventArgs e)
        {
            string host = HttpContext.Current.Request.Url.Host;
            string QueryStr = "CodCli={0}&IdContratto={1}";
            string CodCli = Cliente_Combobox.SelectedItem.GetFieldValue("CodCli").ToString();
            string IdContratto = Contratti_Combobox.SelectedItem.GetFieldValue("IdProdotto").ToString();
            QueryStr = string.Format(QueryStr, CodCli, IdContratto);
            Response.Write("<script>window.open('/stats/Contratto_Report_Preview.aspx?" + QueryStr + "','_blank');</script>");

            //string Id = Request.QueryString["ID"];
            //string url = "Contratto_Report_Preview.aspx?ID=" + Id;
            //Session["GeneraPdfSession"] = 1;
            //Server.Transfer(url);
        }
    }
}