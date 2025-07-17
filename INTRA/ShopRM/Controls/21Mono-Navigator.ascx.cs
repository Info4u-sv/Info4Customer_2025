using System;

namespace INTRA.ShopRM.Controls
{
    public partial class _21Mono_Navigator : System.Web.UI.UserControl
    {
        public string LinkMenuMeno2 { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            LinkMenuMeno2 = "test";
        }
        protected string GetGerarchiaMiele_17Mono(int BrandId, int MacroCatego, string BrandRwName, int CategoId_var, string CategoRw)
        {
            //    SHPCategory shp1 = new SHPCategory();
            //string[] Catego = shp1.FirstBrandCatego(1, MacroCatego);
            //int CategoId = Convert.ToInt16(Catego[0].ToString());
            ////ReTString = Catego[1].ToString();
            //Portal4Set PortalConfig = new Portal4Set();
            //string MAcroCatego = PortalConfig.GetConfigurationValue(Portal4Set.Settings.DescrCatMeno2);
            //if (MacroCatego == -1)
            //{
            //    MAcroCatego = PortalConfig.GetConfigurationValue(Portal4Set.Settings.DescrCatMeno1);
            //}
            //MAcroCatego = info4lab.FunzioniGenerali.RewriteString(MAcroCatego);
            //string[] FirstSubCatego = shp1.FirstSubCatego(CategoId_var);


            //ReTString = MAcroCatego + "/" + BrandRwName + "/" + BrandId + "/" + CategoRw + "/" + CategoId_var.ToString() + "/" + shp1.FirstSubCatego(CategoId_var)[1].ToString() + "/" + shp1.FirstSubCatego(CategoId_var)[0].ToString();
            ////if (shp1.FirstBrandCatego(Convert.ToInt16(BrandLabel.Text), Convert.ToInt16(MacroCategoLabel.Text)) == CategoryId)
            ////{
            ////    ReTString = " actived hover";
            ////}
            string ReTString = CategoId_var.ToString();
            return ReTString;
        }

    }
}