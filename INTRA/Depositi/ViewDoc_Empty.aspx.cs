using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Anagrafiche
{
    public partial class ViewDoc_Empty : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Deposito_Cliente_Rpt Report = new Deposito_Cliente_Rpt();
                Report.Parameters["CodDep"].Value = Request.QueryString["CodDep"];
                Report.Name = $"Deposito_{Request.QueryString["CodDep"]}";
                string fileName = $"Deposito_{Request.QueryString["CodDep"]}";
                MemoryStream ms = new MemoryStream();
                Report.ExportToPdf(ms);
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
}