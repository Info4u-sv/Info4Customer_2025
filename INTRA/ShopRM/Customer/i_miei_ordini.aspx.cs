using System;
using System.Web;

namespace INTRA.ShopRM.Customer
{
    public partial class i_miei_ordini : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["CodCli"] = HttpContext.Current.User.Identity.Name;
        }
    }
}