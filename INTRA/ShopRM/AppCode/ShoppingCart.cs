using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;

namespace INTRA.ShopRM.AppCode
{
    public class CartItem
    {

        public decimal PrezzoPrecedente { get; set; }
        public string PictureUrl { get; set; }
        public string CodLis { get; set; }


        public CartItem()
        {
        }
        public CartItem(string MenuItemID, string ItemName, decimal qtasel, decimal Quantity,
         decimal ItemPrice, int IdContattoRM, string NomeContattoRM, decimal Quota,
         decimal QuotaRidotta, string ScontoApplicato, decimal PercentualeSconto, string TokenAttributi, bool EnableEditQta, bool GiorniRichiestiFlag)
        {
            this.MenuItemID = MenuItemID;
            this.ItemName = ItemName;
            this.qtasel = qtasel;
            this.Quantity = Quantity;
            this.ItemPrice = ItemPrice;
            this.IdContattoRM = IdContattoRM;
            this.NomeContattoRM = NomeContattoRM;

            this.Quota = Quota;
            this.QuotaRidotta = QuotaRidotta;
            this.ScontoApplicato = ScontoApplicato;
            this.PercentualeSconto = PercentualeSconto;
            this.TokenAttributi = TokenAttributi;
            this.EnableEditQta = EnableEditQta;
            this.GiorniRichiestiFlag = GiorniRichiestiFlag;
        }


        public string MenuItemID { get; set; }
        public string ItemName { get; set; }
        public decimal qtasel { get; set; }
        public decimal Quantity { get; set; }
        public decimal ItemPrice { get; set; }
#pragma warning disable CS0169 // Il campo 'CartItem._LineValue' non viene mai usato
        private readonly decimal _LineValue;
#pragma warning restore CS0169 // Il campo 'CartItem._LineValue' non viene mai usato

        public decimal LineValue { get; set; }
        public decimal SubTotal { get; set; }
        public decimal DeliveryCharge { get; set; }
        public decimal Total { get; set; }

        public int IdContattoRM { get; set; }
        public string NomeContattoRM { get; set; }

        public bool EnableEditQta { get; set; } = true;

        public decimal Quota { get; set; }

        public decimal QuotaRidotta { get; set; }

        public string ScontoApplicato { get; set; } // Nucleo Familiare, Tesserato FIR

        public decimal PercentualeSconto { get; set; } //Conterrà per esempio i Giorni (lunedì, martedì) o la taglia colore (XL, rosso) Per ora non la utilizziamo

        public string TokenAttributi { get; set; } //Conterrà per esempio i Giorni (lunedì, martedì) o la taglia colore (XL, rosso)  Per ora non la utilizziamo

        public string Stagione { get; set; } //Conterrà stagione in essere 

        public bool GiorniRichiestiFlag { get; set; }
        public string RM_VicoliRegistrazioneAna { get; set; }
        public int CategoryID { get; set; }
        public string UM { get; set; }
        public string U_Confez_Intra { get; set; }
        public decimal u_pz_lordo { get; set; }
        public string NumDec { get; set; }
        public string RifIva { get; set; }
        public decimal U_Sc2 { get; set; }
        public decimal U_Sc1 { get; set; }

        public string Misura { get; set; }

        public decimal Spedizione { get; set; }
        public float QtaXConf { get; set; }

        public string Descrizione { get; set; }
    }


    public class ShoppingCart
    {
        // costo per il trasporto
        private decimal _DeliveryCharge;
        private readonly int _AttivaSpeseTrasporto;
        // superato questo prezzo le spese di trasporto non vengono imputate
        private readonly decimal _MinimoAcq;
        public decimal DeliveryChargeAppoggio;

        public ShoppingCart()
        {
            if (Items == null)
            {
                Items = new List<CartItem>();
            }

            SalesTaxPercent = Convert.ToDecimal(ConfigurationManager.AppSettings["SalesTax"]);
            _DeliveryCharge = DeliveryChargeAppoggio;
            _MinimoAcq = Convert.ToDecimal(ConfigurationManager.AppSettings["MinimoAcq"]);
            _AttivaSpeseTrasporto = Convert.ToInt32(ConfigurationManager.AppSettings["AttivaSpeseTrasporto"]);
        }

        public List<CartItem> Items { get; }

        public decimal SubTotal
        {
            get
            {
                string CodCli = HttpContext.Current.Request.Cookies["CodCli"].Value.Split('=')[1];
                decimal tot = ESK_ShoppingCart.SubTotalLocal(CodCli);

                //foreach (CartItem item in _items)
                //    tot += item.LineValue;
                return tot;
            }
        }

        // Private _deliveryCharge As Decimal = 0
        // spese di trasporto
        public decimal DeliveryCharge
        {
            get => _AttivaSpeseTrasporto == 1 ? SubTotal > _MinimoAcq ? 0 : _DeliveryCharge : _DeliveryCharge;
            set => _DeliveryCharge = value;
        }


        public decimal SalesTaxPercent { get; }
        public decimal SalesTax => (SubTotal + DeliveryCharge) * SalesTaxPercent;


        public decimal Total => SubTotal + DeliveryCharge + SalesTax;


        /// Insert a new item into the cart

        public void Insert(string MenuItemID, string ItemName, decimal qtasel, decimal Quantity, int CategoryID, string UM)
        {

            // check to see if the item already exists in the cart
            // attenzione forse questo va cambiato


            //int idx = ItemIndex(MenuItemID, qtasel, IdContattoRM);
            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
            CodDep = CodDep.Replace("CodDep=", string.Empty);
            int idx = ESK_ShoppingCart.ItemIndexLocal(MenuItemID, qtasel, CodDep);

            // -1 means the item wasn't in the cart already, so add it
            if (idx == -1)
            {
                // create a new cart item
                CartItem NewItem = new CartItem
                {
                    // set the properties of the new cart item to those passed into the Insert method
                    MenuItemID = MenuItemID,
                    qtasel = 0,
                    ItemName = ItemName
                };
                NewItem.Quantity = qtasel > 0 ? qtasel : Quantity;
                NewItem.CategoryID = CategoryID;
                NewItem.UM = UM;

                // add the new item to the collection

                //_items.Add(NewItem);

                ESK_ShoppingCart.ItemsAddLocal(NewItem, CodDep);

                // qui devo esegure l'insert nella tabella ESK_ShoppingCart

            }
            else
                // the item already exists, so just increment the quantity

                // qui devo eseguire l'update nella tabella ESK_ShoppingCart


                if (qtasel > 0)
            {
                Items[idx].Quantity += qtasel;
            }
            else
            {
                Items[idx].Quantity += 1;
            }
        }


        /// Update the quantity for an existing item in the cart

        public void Update(string MenuItemID, int qtasel, string itemName, decimal Quantity, decimal prezzo, int IdContattoRM, bool EnableEditQta, float QtaXConf)
        {
            if (EnableEditQta) // se il prodotto può incrementare la qtà allora procedo altrimenti lascio così
            {
                //int idx = ItemIndex(MenuItemID, 0, IdContattoRM);
                string CodCli = HttpContext.Current.Request.Cookies["CodCli"].Value;
                CodCli = CodCli.Replace("CodCli=", string.Empty);
                int idx = ESK_ShoppingCart.ItemIndexLocal(MenuItemID, qtasel, CodCli);

                if (idx != -1)
                {
                    // qui devo exegure la procedura di update sul Database
                    Items[idx].Quantity = Quantity;
                    Items[idx].ItemPrice = prezzo;
                    Items[idx].QtaXConf = QtaXConf;
                }
            }
        }


        /// Delete an item from the collection

        public void Delete(string MenuItemID, int qtasel, int IdContattoRM)
        {

            // find the index number of the item
            //int idx = ItemIndex(MenuItemID, 0, IdContattoRM);

            string CodCli = HttpContext.Current.Request.Cookies["CodCli"].Value;
            CodCli = CodCli.Replace("CodCli=", string.Empty);

            int idx = ESK_ShoppingCart.ItemIndexLocal(MenuItemID, qtasel, CodCli);


            // if the item exists (that is, if the index value isn't -1), then remove it
            if (idx != -1)
            {
                // qui devo eseguire la delete Sulla tabella ESK_ShoppingCart trasmite IDX
                Items.RemoveAt(idx);
            }
        }


        // Public Function ItemIndex(ByVal MenuItemID As String, ByVal qtasel As Integer) As Integer
        //private int ItemIndex(string MenuItemID, int qtasel, int IdContattoRM)
        //{
        //    int index = 0;

        //    // loop through the items search for a match
        //    foreach (CartItem item in _items)
        //    {
        //        // if the ID and the Size match, then the item has been found
        //        if (item.MenuItemID == MenuItemID && item.qtasel == 0 && item.IdContattoRM == IdContattoRM)
        //            return index;
        //        index += 1;
        //    }

        //    // -1 indicates no match, so the item didn't exist in the collection
        //    return -1;
        //}
        //public int controllo(string MenuItemID, int IdContattoRM)
        //{
        //    int index = 0;

        //    // loop through the items search for a match
        //    foreach (CartItem item in _items)
        //    {
        //        // if the ID and the Size match, then the item has been found
        //        if (item.MenuItemID == MenuItemID && item.IdContattoRM == IdContattoRM)
        //            return item.Quantity;
        //        index += 1;
        //    }

        //    // -1 indicates no match, so the item didn't exist in the collection
        //    return -1;
        //}

        //public int verifica(string MenuItemID, int IdContattoRM)
        //{

        //    // TODO: reader exercise
        //    // If the quantity is 0 the item could be removed from the cart
        //    // you could put an 'If' statement in to check for the quantity
        //    // - if it is less than or equal to 0 then cal the Delete method
        //    // - if it is greater than 0 then use the code below


        //    // find the index number of the item
        //    // ItemIndex(MenuItemID, 0) qtasel deve essere sempre 0 in questo caso

        //    //int qta = controllo(MenuItemID, IdContattoRM);

        //    string CodCli = HttpContext.Current.Session["CodCli"].ToString();
        //    int qta = ESK_ShoppingCart.ControlloLocal(MenuItemID, CodCli);

        //    // if the item exists (that is, if the index value isn't -1), then update it

        //    if (qta != -1)
        //        // _items(idx).Quantity = Quantity
        //        return qta;
        //    else
        //        return -1;
        //}

        public decimal VerificaLocal(string MenuItemID, string CodDep)
        {

            // TODO: reader exercise
            // If the quantity is 0 the item could be removed from the cart
            // you could put an 'If' statement in to check for the quantity
            // - if it is less than or equal to 0 then cal the Delete method
            // - if it is greater than 0 then use the code below


            // find the index number of the item
            // ItemIndex(MenuItemID, 0) qtasel deve essere sempre 0 in questo caso

            //int qta = controllo(MenuItemID, IdContattoRM);

            //string CodCli = HttpContext.Current.Session["CodCli"].ToString();
            decimal qta = ESK_ShoppingCart.ControlloLocal(MenuItemID, CodDep);

            // if the item exists (that is, if the index value isn't -1), then update it

            if (qta != -1)
            {
                // _items(idx).Quantity = Quantity
                return qta;
            }
            else
            {
                return -1;
            }
        }

    }
}