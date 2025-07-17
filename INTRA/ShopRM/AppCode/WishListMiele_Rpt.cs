using INTRA.AppCode;
using System.Drawing;

namespace INTRA.ShopRM.AppCode
{
    public partial class WishListMiele_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public WishListMiele_Rpt()
        {
            InitializeComponent();
        }

        private void xrPictureBox1_BeforePrint(object sender, System.ComponentModel.CancelEventArgs e)
        {

            string TestStringaFoto = GetCurrentColumnValue("PictureUrl").ToString();
            string TestStringaAssoluta;
            if (!string.IsNullOrEmpty(TestStringaFoto))
            {
                try
                {
                    TestStringaAssoluta = PRT_Parameter_23.GetPRT_ParameterValueByCodParam("PathRepositoryMiele") + TestStringaFoto.Replace("/", "\\");
                    //this.xrPictureBox1.ImageUrl = HttpContext.Current.Server.MapPath( "~" +TestStringaFoto) ;
                    xrPictureBox1.Image = Image.FromFile(TestStringaAssoluta);
                }
                catch
                {
                    TestStringaAssoluta = PRT_Parameter_23.GetPRT_ParameterValueByCodParam("PathRepositoryMiele") + "\\ShopRM\\noimage.jpg";
                    xrPictureBox1.Image = Image.FromFile(TestStringaAssoluta);
                }
            }
            else
            {
                TestStringaAssoluta = PRT_Parameter_23.GetPRT_ParameterValueByCodParam("PathRepositoryMiele") + "\\ShopRM\\noimage.jpg";
                xrPictureBox1.Image = Image.FromFile(TestStringaAssoluta);
            }
        }

        private void FullDescription_xrRichText_BeforePrint(object sender, System.ComponentModel.CancelEventArgs e)
        {
            FullDescription_xrRichText.Html = string.Format("<font size='2' face='arial' style='text-align:left'> {0}</font>", GetCurrentColumnValue("FullDescription"));

        }

        private void ShortDescriptionxr_RichText_BeforePrint(object sender, System.ComponentModel.CancelEventArgs e)
        {
            ShortDescriptionxr_RichText.Html = string.Format("<font size='2' face='arial' style='text-align:left'> {0}</font>", GetCurrentColumnValue("ShortDescription"));

        }

        private void xrLabel4_BeforePrint(object sender, System.ComponentModel.CancelEventArgs e)
        {

        }

        private void InPromo_xrLabel_BeforePrint(object sender, System.ComponentModel.CancelEventArgs e)
        {
            string PromoPrice = GetCurrentColumnValue("PromoPrice").ToString();
            if (string.IsNullOrEmpty(PromoPrice))
            {
                InPromo_xrLabel.Visible = false;
                PriceNoPromo.Visible = false;
                Price_xrLabel.Visible = true;
            }
            else
            {
                InPromo_xrLabel.Visible = true;
                PriceNoPromo.Visible = true;
                Price_xrLabel.Visible = false;
            }
        }
    }
}
