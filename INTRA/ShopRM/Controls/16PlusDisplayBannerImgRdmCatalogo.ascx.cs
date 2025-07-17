using System;

namespace INTRA.ShopRM.Controls
{
    public partial class _16PlusDisplayBannerImgRdmCatalogo : System.Web.UI.UserControl
    {
        public string ImageBanner1 { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                System.Random rand = new System.Random();
                int VarRandom = rand.Next(1, 5);
                _ = string.Format("cat_{0}.jpg", VarRandom);
                string img = "cat_1.jpg";

                ImageBanner1 = Request.ApplicationPath.TrimEnd('/') + "/images/banner-catalogo/" + img + string.Empty;
            }

            // Commentato Simone 16/09/2021 da verificare

            //if (string.IsNullOrEmpty(_TestataImg) )
            //{
            //    ImageBanner = Request.ApplicationPath.TrimEnd('/') + "/images/banner-catalogo/" + img + "";
            //    //MainImg.Style.Add("background-image", "url(" + Request.ApplicationPath.TrimEnd('/') +"/static/img/" + img + ")");
            //}
            //else
            //{
            //    ImageBanner = Request.ApplicationPath.TrimEnd('/') + "/" + _TestataImg;
            //    //MainImg.Style.Add("background-image","url("+_TestataImg+")");
            //}


            if (string.IsNullOrEmpty(_TitoloSezione))
            {
                // LabelTitleSection.Text = "errore";
            }
            else
            {
                LabelTitleSection.Text = _TitoloSezione;
            }

        }
        protected string _TitoloSezione;
        public string TitoloSezione
        {
            get => _TitoloSezione;
            set => _TitoloSezione = value;
        }
        protected string _TestataImg;
        public string TestataImg
        {
            get => _TestataImg;
            set => _TestataImg = value;
        }

    }
}