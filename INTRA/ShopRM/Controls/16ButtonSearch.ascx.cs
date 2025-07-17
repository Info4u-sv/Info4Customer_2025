using System;

namespace INTRA.ShopRM.Controls
{
    public partial class _16ButtonSearch : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //string path = HttpContext.Current.Request.Url.AbsolutePath;
                //if (path.IndexOf("login") > 0)
                //{
                //    SeaarchBt.Enabled = false;
                //}
                string search = Request.QueryString["r1"];
                SearchTxtBoxDX.Text = search;
            }
            catch { }
        }
        //protected void SeaarchBt_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("~/ShopRM/RicercaAvanzata.aspx?r1=" + SearchTxtBox.Text);
        //}

    }
}