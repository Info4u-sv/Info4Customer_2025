namespace INTRA.ShopRM.AppCode
{
    public class OrderItem
    {
        private string _NomeContattoRM;




        public int OrderID { get; set; }

        public string ProductID { get; set; }

        public string ProductName { get; set; }

        public decimal Quantity { get; set; }

        public decimal UnitCost { get; set; }

        public decimal TotCost { get; set; }
        public int IdContattoRM { get; set; }
        public string NomeContattoRM
        {
            get => _NomeContattoRM;
            set => _NomeContattoRM = value;
        }

        public decimal Quota { get; set; }

        public decimal QuotaRidotta { get; set; }

        public string ScontoApplicato { get; set; }

        public decimal PercentualeSconto { get; set; }

        public string TokenAttributi { get; set; }

        public string Stagione { get; set; }

        public string Giorni { get; set; }

        public string RM_VicoliRegistrazioneAnaDescr { get; set; }

        public string Misura { get; set; }
    }

}