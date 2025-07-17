using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;

namespace INTRA.ShopRM
{
    public partial class prodotti : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string url = HttpContext.Current.Request.Path;
            string[] ArrUrl = Regex.Split(url, "/");
            SHPCategory Parental = new SHPCategory();

            Parental = Parental.GetParentalCatego(Convert.ToInt32(Request["Cat"]));
            int PosizioneCatalogo = Array.IndexOf(ArrUrl, "catalogo");
            string MacroCategoRw = string.Empty;
            string BrandRWName = string.Empty;
            string BrandId = "1";
            string CategoName = Parental.ParentalDisplayName;
            string CategoId = Parental.ParentCategoryID.ToString();
            string SubCategoId = Parental.CategoryID.ToString();

            SHPCategory Shp_Obj = new SHPCategory();
            List<SHPCategory> LShop1 = new List<SHPCategory>();
            LShop1 = Shp_Obj.GetSHPCategoryPicture();
            SHPCategory em = LShop1.Find(a => a.CategoryID == Convert.ToInt32(CategoId));
            string UrlImg = string.Empty;
            PlusDisplayBannerImgRandom.TitoloSezione = string.IsNullOrEmpty(Parental.DisplayName)
                ? "CATALOGO"
                : Parental.ParentalDisplayName == "NULL" ? Parental.DisplayName : Parental.ParentalDisplayName;
            if (em != null)
            {
                UrlImg = em.PictureUrl;
                PlusDisplayBannerImgRandom.TestataImg = "public/catalogo/testata/" + UrlImg;
            }
            //PlusDisplayBannerCatalogoDx1.BrandId = BrandId;

            //PlusLeftMenuCatalogo.BrandId = BrandId;
            //PlusLeftMenuCatalogo.CategoId = CategoId;
            //PlusLeftMenuCatalogo.SubCategoId = SubCategoId;
            //PlusLeftMenuCatalogo.BrandRwName = BrandRWName;
            //PlusLeftMenuCatalogo.MacroCategoRw = MacroCategoRw;
            //PlusLeftMenuCatalogo.CategoName = CategoName;

            //leftpromo1.BrandId = Convert.ToInt32(BrandId);
            //leftpromo1.SearchType = Catalog_settings.Promo;

            string macrocatego = "-2";
            //SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();
            //string MAcroCategoVar = PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.DescrCatMeno1);
            //MAcroCategoVar = PRT_FunzioniGenerali_23.RewriteString(MAcroCategoVar);
            //if (@MacroCategoRw == @MAcroCategoVar)
            //{
            //    macrocatego = "-1";
            //}

            //PlusLeftMenuCatalogo.MacroCatego = macrocatego;

            if (IsPostBack)
            {
                PlusContentAreaProdotti.Post_back = 1;
            }
            string search = SubCategoId;
            int CategoryId = 0;
            CategoryId = Convert.ToInt32(search);
            //LeftMenu1.CategoryId = CategoryId;
            SHPCategory Shp1 = new SHPCategory();
            PlusContentAreaProdotti.CategoryId = Convert.ToInt32(SubCategoId);
            PlusContentAreaProdotti.BrandId = Convert.ToInt32(BrandId);
            PlusContentAreaProdotti.MacroCatego = Convert.ToInt32(macrocatego);



        }

    }
}