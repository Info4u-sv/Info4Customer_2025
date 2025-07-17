using DevExpress.XtraReports.Web;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Web;

namespace INTRA.ShopRM
{
    public partial class ReportViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DevExpress.XtraReports.UI.XtraReport Report = new AppCode.WishListMiele_Rpt();
            _ = new List<CartItem_wish>();
            List<CartItem_wish> MyCartItems = StoredShoppingCart_wish.ReadItems();
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
            ASPxWebDocumentViewer1.OpenReport(new CachedReportSourceWeb(Report));

        }
    }
}