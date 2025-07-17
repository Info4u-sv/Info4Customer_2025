using System;

namespace INTRA.ShopRM
{
    public partial class carrello : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SHP_CartView.TitCartView = "Carrello";
        }
        protected void CatReturn_Click(object sender, EventArgs e)
        {
            string url = Session["UrlReferrer"].ToString();
            Session["UrlReferrer"] = string.Empty;
            Response.Redirect(url);
        }
    }
}