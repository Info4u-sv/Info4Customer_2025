namespace INTRA.ShopRM.AppCode
{
    public class SHP_Order_Settings : SpecializedEnum<SHP_Order_Settings, string>
    {
        public static readonly string DaEvadere = "OK";
        public static readonly string Evaso = "CL";
        public static readonly string Annullato = "NL";
        public static readonly string BonificoDaEvadere = "EB";
        public static readonly string BonificoEvaso = "OB";
        public static readonly string BonificoAnnullato = "KB";
        public static readonly string BonificoInAttesaPagamento = "BB";
        public static readonly string PaypalDaEvadere = "EP";
        public static readonly string PaypalEvaso = "OP";
        public static readonly string PaypalAnnullato = "KP";
        public static readonly string PaypalInAttesaPagamento = "PP";
    }
}