using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM
{
    public partial class prodotto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.Header.DataBind();
        }

        protected string ImmaginePrincipale(object id)
        {
            string classe = "url";

            if (id != null)
            {
                if (id.ToString() == Request.QueryString["cod"])
                {
                    classe = "immagineSelezionata";
                }
            }

            return classe;
        }


        protected void CaricaSliderZoom_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            ASPxImageSliderZoom.DataSourceID = e.Parameter;
            ASPxImageSliderZoom.DataBind();
        }
        protected void AggiungiAllaWishlist_Callback_Callback(object source, CallbackEventArgs e)
        {
            _ = Membership.GetUser();
            //dynamic MyProfile = (ProfileBase)ProfileBase.Create(UserLog.UserName, true);
            _ = Convert.ToInt32(e.Parameter);

            ListViewItem Item = ListViewProdotto.Items[0];
            Label PriceLabel = (Label)Item.FindControl("PriceLabel");
            //Label ProductCodLabel = (Label)Item.FindControl("ProductCodLabel");
            Label DisplayNameLabel = (Label)Item.FindControl("DisplayNameLabel");
            //Panel PromoPanel = (Panel)Item.FindControl("PromoPanel");

            string ProductId = Request.QueryString["cod"];
            string ProductCodLabel = Request.QueryString["cod"];
            string Price = PriceLabel.Text;
            //Label PriceLabel = (Label)ShopList1.FindCardTemplateControl(VisibleIndex, "PriceLabel");

            //Label ProductCodLabel = (Label)ShopList1.FindCardTemplateControl(VisibleIndex, "ProductCodLabel");
            string ProductCod = ProductId;

            string DisplayName = DisplayNameLabel.Text;
            Label PromoPriceLabel = (Label)Item.FindControl("PromoPriceLabel");
            string PriceLabelValue = PromoPriceLabel.Text == "0" || string.IsNullOrEmpty(PromoPriceLabel.Text) ? PriceLabel.Text : PromoPriceLabel.Text;
            _ = Convert.ToDecimal(PriceLabelValue);
            _ = ProductCodLabel + " - " + DisplayNameLabel.Text;


            string ScontoApplicato = string.Empty;
            decimal QuotaRidotta = 0;
            decimal Quota = Convert.ToDecimal(Price);
            if (string.IsNullOrEmpty(PriceLabelValue) || PriceLabelValue == "0")
            {
                PriceLabelValue = Price;

                ;
            }
            else
            {
                //Label PromoPriceLabel = (Label)ShopList1.FindCardTemplateControl(VisibleIndex, "PromoPriceLabel");
                //PriceLabelValue = PriceLabelValue;
                QuotaRidotta = Convert.ToDecimal(PriceLabelValue);
                ScontoApplicato = "Promo";
            }

            decimal ItemPrice = Convert.ToDecimal(PriceLabelValue);
            string descrizione = ProductCod + " - " + DisplayName;
            _ = new StoredShoppingCart_wish();
            //ShoppingCart shop1 = new ShoppingCart();
            int IdContattoRM = 0;
            //ASPxTokenBox Giorni_token = (ASPxTokenBox)AtletiAssociati_Gridview.FindRowCellTemplateControl(VisibleIndex, (GridViewDataColumn)AtletiAssociati_Gridview.Columns["GiorniGest"], "Giorni_token");
            //ASPxTokenBox Giorni2_token = (ASPxTokenBox)AtletiAssociati_Gridview.FindRowCellTemplateControl(VisibleIndex, (GridViewDataColumn)AtletiAssociati_Gridview.Columns["Resp"], "Giorni2_token");
            //string VarGiorni_token = Giorni_token.Text;
            //string VarGiorniResp_token = Giorni2_token.Text;
            int verificacart = StoredShoppingCart_wish.verifica(ProductId, 0);
            string NomeContattoRM = string.Empty;
            _ = NomeContattoRM.ToUpper();

            SHP_Articoli _ArticoloSelect = new SHP_Articoli();
            int qtasel;
            //_ArticoloSelect = SHP_Articoli.Caglio_GetDettaglioSHP_Articolo(ProductId, CategoryId, MyProfile.CodLis);

            if (verificacart == -1)
            {
                qtasel = 1;
                if (!string.IsNullOrEmpty(_ArticoloSelect.CategoScontoQuotaRidotta))
                {
                    _ = _ArticoloSelect.CategoScontoQuotaRidotta.Split(';');
                }
                //bool ScontoFamigliaPresente = Order.GetSeRMScontoFamiglia(IdContattoRM);
                //bool ScontoTesseratiPresente = INTRA.AppCode.RM_Atleti.GetSeFamigliaTesserataFIR(IdContattoRM);

                //List<CartItem> MyCartItems = new List<CartItem>();
                //MyCartItems = StoredShoppingCart.ReadItems();

                //if (MyCartItems.Count > 0)
                //{
                //    ScontoFamigliaPresente = true;
                //}

                //string _VarCodScontoApplicato = string.Empty;
                //if (ScontoFamigliaPresente)
                //{
                //    _VarCodScontoApplicato = "FAMIGLIA";
                //}
                //else
                //{
                //    if (ScontoTesseratiPresente)
                //    {
                //        _VarCodScontoApplicato = "FIR";
                //    }
                //    else
                //    {
                //        _VarCodScontoApplicato = string.Empty;
                //    }

                //}
                //List<PRT_DropDown_ElementiClass> _PRT_DropDownList = new List<PRT_DropDown_ElementiClass>();

                //if (ScontoFamigliaPresente || ScontoTesseratiPresente)
                //{
                //    _PRT_DropDownList = PRT_DropDown_ElementiClass.GetPRT_DropDown_ElementiRows("RmShopQuotaRidotta");
                //}



                //if (!string.IsNullOrEmpty(_VarCodScontoApplicato) && _ArticoloSelect.CategoScontoQuotaRidotta.Contains(_VarCodScontoApplicato))
                //{
                //    // devo recuperare da prt_dropdown il testo dello sconto applicato e associarlo alla variabile sconto applicato
                //    ItemPrice = _ArticoloSelect.QuotaRidotta;
                //    List<PRT_DropDown_ElementiClass> _PRT_DropDownListFilter = new List<PRT_DropDown_ElementiClass>();
                //    _PRT_DropDownListFilter = _PRT_DropDownList.Where(x => x.ValueField == _VarCodScontoApplicato).ToList();
                //    ScontoApplicato = "Applicato Sconto " + _PRT_DropDownListFilter[0].TextField;
                //}


                decimal PercentualeSconto = _ArticoloSelect.PercentualeSconto;
                string TokenAttributi = string.Empty;

                //if (VarGiorni_token != "")
                //{
                //    TokenAttributi = VarGiorni_token;
                //}
                //else
                //{
                //    TokenAttributi = VarGiorniResp_token;
                //}


                bool EnableEditQta = _ArticoloSelect.EnableEditQta;


                _ = StoredShoppingCart_wish.InsertItem(ProductId, descrizione, qtasel, qtasel, ItemPrice, 0, string.Empty, Quota,
             QuotaRidotta, ScontoApplicato, PercentualeSconto, TokenAttributi, EnableEditQta, _ArticoloSelect.Stagione, _ArticoloSelect.GiorniRichiestiFlag,
             _ArticoloSelect.CategoryID);


                //SetSpeseTrasporto();
                //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRM/carrello.aspx");
                //Panel_articolo_inserito.Visible = True
            }
            else
            {

                if (_ArticoloSelect.EnableEditQta)
                {
                    qtasel = verificacart + 1;
                    bool EnableEditQta = false;
                    _ = StoredShoppingCart_wish.UpdateItem(ProductId, descrizione, qtasel, qtasel, ItemPrice, IdContattoRM, EnableEditQta);
                    //SetSpeseTrasporto();
                }
                //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRM/carrello.aspx");

            }

            //ASPxButton AddCart_Btn = (ASPxButton)AtletiAssociati_Gridview.FindRowCellTemplateControl(VisibleIndex, (GridViewDataColumn)AtletiAssociati_Gridview.Columns["Associa"], "AddCart_Btn");
            //AddCart_Btn.Enabled = false;
        }

    }
}