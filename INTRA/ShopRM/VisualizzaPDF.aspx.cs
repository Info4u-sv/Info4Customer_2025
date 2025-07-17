using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
namespace INTRA.ShopRM
{
    public partial class VisualizzaPDF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DevExpress.XtraReports.UI.XtraReport Report = new AppCode.WishListMiele_Rpt();

                List<CartItem_wish> MyCartItems = new List<CartItem_wish>();
                MyCartItems = StoredShoppingCart_wish.ReadItems();
                string ListFilter = "'0',";
                if (MyCartItems.Count > 0)
                {
                    for (int i = 0; i < MyCartItems.Count; i++)
                    {
                        ListFilter += "'" + MyCartItems[i].MenuItemID.ToString() + "',";
                    }
                }

                //Report.Parameters["ListProductCod"].Value = ListFilter.Remove(ListFilter.Length - 1);
                Report.Parameters["ListProductCod"].Value = " where ProductCod IN (" + ListFilter.Remove(ListFilter.Length - 1) + ") ";
                string Path = HttpContext.Current.Server.MapPath("~");
                Session["IntraPathAssoluto"] = Path;
                string fileName = "WishListMiele";
                MemoryStream ms = new MemoryStream();
                Report.ExportToPdf(ms);

                byte[] FileBuffer = ms.ToArray();
                if (FileBuffer != null)
                {
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", "filename=" + fileName + ".pdf");
                    Response.AddHeader("content-length", FileBuffer.Length.ToString());
                    Response.BinaryWrite(FileBuffer);
                }
                //// Specify export options.
                //PdfExportOptions pdfExportOptions = new PdfExportOptions()
                //{
                //    PdfACompatibility = PdfACompatibility.PdfA1b
                //};

                //// Specify the path for the exported PDF file.  
                //string pdfExportFile =
                //    Environment.GetFolderPath(Environment.SpecialFolder.UserProfile) +
                //    @"\Downloads\" +
                //    Report.Name +
                //    ".pdf";

                //// Export the report.
                //Report.ExportToPdf(pdfExportFile, pdfExportOptions);

                // ASPxWebDocumentViewer1.OpenReport(new CachedReportSourceWeb(Report));

            }
            catch { }
        }
    }
}