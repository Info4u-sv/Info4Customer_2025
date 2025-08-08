using INTRA.Ticket.AppCode;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ticket
{
    public partial class ViewDoc_Empty : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GestioneTicket_Rpt report = new GestioneTicket_Rpt();
            report.Parameters["IdTicket"].Value = Request.QueryString["IdTicket"];
            string fileName = "TCK_" + Request.QueryString["IdTicket"];

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
        }
    }
}