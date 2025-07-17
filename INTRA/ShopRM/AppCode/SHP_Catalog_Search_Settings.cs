namespace INTRA.ShopRM.AppCode
{
    public class Catalog_settings : INTRA.ShopRM.AppCode.SpecializedEnum<Catalog_settings, string>
    {
        public static readonly string Default = "DF";
        public static readonly string Prodotto = "PO";
        public static readonly string Promo = "PR";
        public static readonly string Search = "SR";
        public static readonly string SearchAdvanced = "SA";
        public static readonly string SearchEngine = "SE";
    }
}