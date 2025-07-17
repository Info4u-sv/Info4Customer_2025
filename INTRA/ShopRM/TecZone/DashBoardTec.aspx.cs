using System;
using System.Web;

namespace INTRA.ShopRM.TecZone
{
    public partial class DashBoardTec : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["CodTecnicoCat"] = HttpContext.Current.User.Identity.Name;
        }
    }
}