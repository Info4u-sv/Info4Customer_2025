using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Stats
{
    public partial class Contratto_Report_Preview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Exporting
            string CodCli = Request.QueryString["CodCli"].ToString();
            string IdContratto = Request.QueryString["IdContratto"].ToString();
            Contratto_Riepilogo_Rpt report = new Contratto_Riepilogo_Rpt();
            report.Parameters["CodCliParam"].Value = CodCli;
            report.Parameters["IDcontrattoParam"].Value = IdContratto;
            //report.Parameters["FromParam"].Value = Convert.ToDateTime(FromData);
            //report.Parameters["ToParam"].Value = Convert.ToDateTime(ToData);
            string format = "pdf";
            string fileName = "Report";

            MemoryStream ms = new MemoryStream();
            report.ExportToPdf(ms);
            Byte[] FileBuffer = ms.ToArray();
            if (FileBuffer != null)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "filename=" + fileName + ".pdf");
                Response.AddHeader("content-length", FileBuffer.Length.ToString());
                Response.BinaryWrite(FileBuffer);
            }

            ////Exporting

            //string CodCli = Request.QueryString["CodCli"].ToString();
            //string IdContratto = Request.QueryString["IdContratto"].ToString();
            //string FromData = Request.QueryString["From"].ToString();
            //string ToData = Request.QueryString["To"].ToString();
            //DevExpress.XtraReports.UI.XtraReport report = new Contratto_Riepilogo_Rpt();
            //report.Parameters["CodCliParam"].Value = CodCli;
            //report.Parameters["IDcontrattoParam"].Value = IdContratto;
            //report.Parameters["FromParam"].Value = Convert.ToDateTime(FromData);
            //report.Parameters["ToParam"].Value = Convert.ToDateTime(ToData);

            //ASPxWebDocumentViewer1.OpenReport(report);
        }
    }
}