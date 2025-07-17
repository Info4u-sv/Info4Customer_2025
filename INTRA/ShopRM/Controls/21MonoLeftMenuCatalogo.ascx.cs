using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;

namespace INTRA.ShopRM.Controls
{
    public partial class _21MonoLeftMenuCatalogo : System.Web.UI.UserControl
    {
        public string BrandId { get; set; } = "1";

        public string BrandRwName { get; set; } = string.Empty;

        public string MacroCatego { get; set; } = string.Empty;

        public string MacroCategoRw { get; set; } = string.Empty;

        public string CategoId { get; set; } = string.Empty;

        public string CategoName { get; set; } = string.Empty;

        public string SubCategoId { get; set; } = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            //_CategoId = Request["Cat"];
            BrandLabel.Text = BrandId;
            MacroCategoLabel.Text = MacroCatego;
            SubCategoLabel.Text = CategoId;
            MielePanel.Visible = BrandId == "1";


        }
        protected List<SHPCategory> GetTagsMiele(int CategoryId)
        {

            SHPCategory shp1 = new SHPCategory();
            _ = CategoName + "/" + CategoId;
            //return shp1.GetSubCategoByBrandCategoMacroCatego(Convert.ToInt32(CategoryId), Convert.ToInt32(_MacroCatego), Convert.ToInt32(_BrandId));
            return shp1.GetSHPSubCategoryByid(Convert.ToInt32(CategoryId));
        }
        protected List<INTRA.ShopRM.AppCode.PLS_SHPCategory> GetTagsNoMiele(int CategoryId)
        {

            PLS_SHPCategory shp1 = new PLS_SHPCategory();
            //return shp1.GetSHPSubCategoryByid(CategoryId);
            _ = CategoName + "/" + CategoId;
            return shp1.GetSubCategoByBrandCategoMacroCatego(Convert.ToInt32(CategoryId), Convert.ToInt32(MacroCatego), Convert.ToInt32(BrandId));
        }

        protected string GetTags_Actived_Catego(int CategoryId)
        {
            string ReTString = string.Empty;
            try
            {

                if (Convert.ToInt16(CategoId) == CategoryId || Convert.ToInt16(SubCategoId) == CategoryId)
                {
                    ReTString = " active ";
                }
            }
            catch { }

            return ReTString;
        }
        protected string GetTags_DisplayBlock_Catego(int CategoryId)
        {

            string ReTString = string.Empty;
            try
            {
                if (Convert.ToInt16(CategoId) == CategoryId || Convert.ToInt16(SubCategoId) == CategoryId)
                {
                    ReTString = " display:block ";
                }
            }
            catch { }
            return ReTString;
        }


        protected string GetTags_Actived_SubCatego(int CategoryId)
        {

            string ReTString = string.Empty;
            try
            {
                if (Convert.ToInt16(SubCategoId) == CategoryId)
                {
                    ReTString = " active ";
                }
            }
            catch { }

            return ReTString;
        }
        //protected string GetGerarchiaStaticaMiele(int categoId, string CategoRw)
        //{
        //    SHPCategory shp1 = new SHPCategory();

        //    string ReTString = string.Empty;
        //    //string[] Catego = shp1.FirstBrandCatego(BrandId, MacroCatego);
        //    //int CategoId = Convert.ToInt16(Catego[0].ToString());
        //    //ReTString = Catego[1].ToString();
        //    //string MAcroCatego = "PROFESSIONAL";
        //    //if (_MacroCatego == "-1")
        //    //{
        //    //    MAcroCatego = "ELETTRODOMESTICI";
        //    //}

        //    ReTString = _MacroCategoRw + "/" + _BrandRwName + "/" + _BrandId + "/" + CategoRw + "/" + categoId + "/" + shp1.FirstSubCatego(categoId)[1].ToString() + "/" + shp1.FirstSubCatego(categoId)[0].ToString();
        //    //{
        //    //    ReTString = " actived hover";
        //    //}

        //    return ReTString;
        //}
        protected string GetGerarchiaStatica(int categoId, string CategoRw)
        {
            PLS_SHPCategory shp1 = new PLS_SHPCategory();
            //string[] Catego = shp1.FirstBrandCatego(BrandId, MacroCatego);
            //int CategoId = Convert.ToInt16(Catego[0].ToString());
            //ReTString = Catego[1].ToString();
            //string MAcroCatego = "PROFESSIONAL";
            //if (_MacroCatego == "-1")
            //{
            //    MAcroCatego = "ELETTRODOMESTICI";
            //}

            string ReTString = MacroCategoRw + "/" + BrandRwName + "/" + BrandId + "/" + CategoRw + "/" + categoId + "/" + shp1.FirstSubCatego(categoId)[1].ToString() + "/" + shp1.FirstSubCatego(categoId)[0].ToString();
            //{
            //    ReTString = " actived hover";
            //}

            return ReTString;
        }

        //protected string GetGerarchiaStaticaMiele(int categoId, string CategoRw)
        //{
        //    SHPCategory shp1 = new SHPCategory();

        //    string ReTString = string.Empty;
        //    //string[] Catego = shp1.FirstBrandCatego(BrandId, MacroCatego);
        //    //int CategoId = Convert.ToInt16(Catego[0].ToString());
        //    //ReTString = Catego[1].ToString();
        //    //string MAcroCatego = "PROFESSIONAL";
        //    //if (_MacroCatego == "-1")
        //    //{
        //    //    MAcroCatego = "ELETTRODOMESTICI";
        //    //}
        //    string[] FirstSubCatego = shp1.FirstSubCategoBrandMacrocatego(categoId, Convert.ToInt32(_BrandId), Convert.ToInt32(_MacroCatego));
        //    if (FirstSubCatego.Length < 0 || FirstSubCatego == null || FirstSubCatego[1] == null)
        //    {
        //        ReTString = "";
        //    }
        //    else
        //    {

        //        ReTString = "/catalogo/" + _MacroCategoRw + "/" + _BrandRwName + "/" + _BrandId + "/" + CategoRw + "/" + categoId + "/" + FirstSubCatego[1].ToString() + "/" + FirstSubCatego[0].ToString() + "/prodotti.aspx";
        //    }
        //    //ReTString = _MacroCategoRw + "/" + _BrandRwName + "/" + _BrandId + "/" + CategoRw + "/" + categoId + "/" + FirstSubCatego[1].ToString() + "/" + FirstSubCatego[0].ToString();
        //    //{
        //    //    ReTString = " actived hover";
        //    //}

        //    return ReTString;
        //}
        protected string GetGerarchiaStaticaNoMiele(int categoId, string CategoRw)
        {
            PLS_SHPCategory shp1 = new PLS_SHPCategory();
            //string[] Catego = shp1.FirstBrandCatego(BrandId, MacroCatego);
            //int CategoId = Convert.ToInt16(Catego[0].ToString());
            //ReTString = Catego[1].ToString();
            //string MAcroCatego = "PROFESSIONAL";
            //if (_MacroCatego == "-1")
            //{
            //    MAcroCatego = "ELETTRODOMESTICI";
            //}
            string[] FirstSubCatego = shp1.FirstSubCategoBrandMacrocatego(categoId, Convert.ToInt32(BrandId), Convert.ToInt32(MacroCatego));

            string ReTString = MacroCategoRw + "/" + BrandRwName + "/" + BrandId + "/" + CategoRw + "/" + categoId + "/" + FirstSubCatego[1].ToString() + "/" + FirstSubCatego[0].ToString();
            //{
            //    ReTString = " actived hover";
            //}

            return ReTString;
        }
        protected string GetGerarchiaBrandStaticaNoMiele()
        {
            _ = new PLS_SHPCategory();
            string ReTString = MacroCategoRw + "/" + BrandRwName + "/" + BrandId;
            return ReTString;
        }
        protected string GetGerarchiaBrandStaticaMiele()
        {
            _ = new PLS_SHPCategory();
            string ReTString = MacroCategoRw + "/" + BrandRwName + "/" + BrandId;
            return ReTString;
        }
        //protected string GetTags_Actived_SubCatego(int CategoryId)
        //{
        //    PLS_SHPCategory shp1 = new PLS_SHPCategory();
        //    string ReTString = "";
        //    if (Convert.ToInt16(_SubCategoId) == CategoryId)
        //    {
        //        ReTString = " actived ";
        //    }

        //    return ReTString;
        //}

    }


}