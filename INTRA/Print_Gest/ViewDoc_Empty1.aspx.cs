using INTRA.Print_Gest.AppCode;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest
{
    public partial class ViewDoc_Empty1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Print_Cli_Rpt report = new Print_Cli_Rpt();
            report.Parameters["ID"].Value = Request.QueryString["ID"];
            string fileName = "Print1_" + Request.QueryString["ID"];

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