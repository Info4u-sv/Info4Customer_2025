using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM.Controls
{

    public partial class _21COMM_ContentAreaProdotti : System.Web.UI.UserControl
    {


        protected int _CategoryId;
        public int CategoryId
        {
            get => _CategoryId;
            set => _CategoryId = value;
        }
        protected int _MacroCatego = 0;
        public int MacroCatego
        {
            get => _MacroCatego;
            set => _MacroCatego = value;
        }
        protected int _BrandId = 0;
        public int BrandId
        {
            get => _BrandId;
            set => _BrandId = value;
        }
        protected string _SearchType = INTRA.ShopRM.AppCode.Catalog_settings.Default;
        public string SearchType
        {
            get => _SearchType;
            set => _SearchType = value;
        }
        protected int _Post_back = 0;
        public int Post_back
        {
            get => _Post_back;
            set => _Post_back = value;
        }
        protected int _ProdID = 0;
        public int ProdID
        {
            get => _ProdID;
            set => _ProdID = value;
        }
        protected int _ProdIDLocal = 0;
        public int ProdIDLocal
        {
            get => _ProdIDLocal;
            set => _ProdIDLocal = value;
        }

        public string BrandRwName { get; set; } = "ADRIANA";
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpContext.Current.Session["CartBK"] = HttpContext.Current.Session["Cart"];

            _CategoryId = Convert.ToInt32(Request["Cat"]);
            _BrandId = 1;
            PLS_SHPCategory Shopcategory = new PLS_SHPCategory();
            SHP_Product_Responsive Product_COMM = new SHP_Product_Responsive();
            if (_BrandId > 1)
            {
                RepeaterTestata.DataSource = Shopcategory.GetSHPCategoryDetailsById(_CategoryId);
                RepeaterTestata.DataBind();
            }
            else
            {
                SHPCategory ShopcategoryAdriana = new SHPCategory();
                RepeaterTestata.DataSource = ShopcategoryAdriana.GetSHPCategoryDetailsByIdGestionale(_CategoryId);
                RepeaterTestata.DataBind();
            }

            BrandIdLbl.Text = _BrandId.ToString();
            //SearchPanel.Visible = _CategoryId == 19 && _BrandId == 1 && false;
            if (_SearchType == Catalog_settings.Default)
            {
                ShopList1.DataSource = COMM_ProductsByCategoryID_Get_ObjectDS;
                ShopList1.DataBind();
            }

            //if (_SearchType == Catalog_settings.SearchEngine)
            //{
            //    // 04/11/2021 modificato Simone introdotto nuovo sistema di filtro più performante 
            //    // tramite nuova store SHP_GetSHPProductFilter
            //    string _filterTags = CreateTagsFilter();
            //    ShopList1.DataSource = Product_COMM.AllProducts_COMM_Get_DTB_FilterTags(_filterTags);
            //    ShopList1.DataBind();

            //}


            //if (_SearchType == Catalog_settings.Promo)
            //{
            //    if (_BrandId > 1)
            //    {
            //        //ListViewProdotti.DataSource = COMM_ProdottiInPromo_ObjectDS;
            //        if (_ProdID > 0)
            //        {
            //            COMM_ProdottiInPromo_ObjectDS.FilterExpression = "ProductId =" + _ProdID;
            //        }
            //    }
            //    else
            //    {
            //        ShopList1.DataSource = COMM_ProdottiInPromo_ObjectDS;
            //        //string r = Request.QueryString["r"];
            //        //if (!string.IsNullOrEmpty(r))
            //        //{
            //        //    ListViewProdotti.DataSource = ALLPromoObjectDS;

            //        //    ALLPromoObjectDS.FilterExpression = "ProdCategoParentalId =" + r;
            //        //}
            //        // questo serve per filtrare l'object data source 
            //        // vedi anche PromoMieleObjectDS_selecting per assegnare l'object
            //        if (_ProdID > 0)
            //        {
            //            COMM_ProdottiInPromo_ObjectDS.FilterExpression = " ProductId =" + _ProdID;
            //        }

            //    }
            //    if (_ProdID > 0)
            //    {
            //    }
            //    ShopList1.DataBind();
            //}

            if (!IsPostBack || _Post_back == 0)
            {
                // COMMENTATO IN MIELE NON SERVE
                //Session["ProductIdSession"] = null;
                //Session["ProductIndexSession"] = null;
                //MembershipUser UserLog = Membership.GetUser();
                //try
                //{
                //    dynamic MyProfile = (ProfileBase)ProfileBase.Create(UserLog.UserName, true);
                //    if (string.IsNullOrEmpty(IDContatto_HField.Value.ToString()))
                //    {
                //        try
                //        {
                //            IDContatto_HField.Value = Session["IDContattoSession"].ToString();
                //        }
                //        catch
                //        {
                //            IDContatto_HField.Value = MyProfile.RM_IDContatto.ToString();
                //            Session["IDContattoSession"] = MyProfile.RM_IDContatto;
                //        }

                //    }
                //}
                //catch { }






                //try
                //{
                //    dynamic MyProfile2 = (ProfileBase)ProfileBase.Create(UserLog.UserName, true);
                //    bool IsGenitoreTutore = Roles.IsUserInRole(UserLog.UserName, "GenitoreTutore");
                //    bool IsAtleta = Roles.IsUserInRole(UserLog.UserName, "Atleta");
                //    bool IsSegreteria = Roles.IsUserInRole(UserLog.UserName, "Segreteria");

                //    if (IsAtleta)
                //    {
                //        GeneraMeStesso_Btn.Visible = false;
                //    }
                //}
                //catch { }

                //if (_SearchType == Catalog_settings.Prodotto)
                //{
                //    //if (_ProdIDLocal == 0)
                //    //{
                //    //ListViewProdotti.DataSource = COMM_ProductObjectDS;
                //    if (_ProdID > 0)
                //    {
                //        COMM_ProductObjectDS.SelectParameters.Clear();
                //        _ = COMM_ProductObjectDS.SelectParameters.Add(new Parameter("ProductId", System.Data.DbType.Int32, _ProdID.ToString()));
                //        COMM_ProductObjectDS.DataBind();
                //        //COMM_ProductObjectDS.FilterExpression = "ProductId =" + _ProdID;
                //    }
                //    //ListViewProdotti.DataSource = COMM_ProductObjectDS;
                //    //    ListViewProdotti.DataBind();
                //    //ListViewProdotti.DataBind();
                //    //}
                //    //else
                //    //{
                //    //    ProductMieleObjectDSLocal.SelectMethod = "GetSHPProductMieleDTLocal";
                //    //    // modificato il 1-8-2013
                //    //    ProductMieleObjectDSLocal.SelectParameters.Clear();
                //    //    ProductMieleObjectDSLocal.SelectParameters.Add(new Parameter("BrandId", System.Data.DbType.String, _BrandId.ToString()));
                //    //    ProductMieleObjectDSLocal.DataBind();
                //    //    //ProductObjectDS.SelectMethod = "GetSHPProductByIdDT";
                //    //    //string url = HttpContext.Current.Request.Path;
                //    //    //string[] ArrUrl = Regex.Split(url, "/");
                //    //    //string search = ArrUrl[ArrUrl.Length - 2];
                //    //    //e.InputParameters.Clear();
                //    //    //e.InputParameters.Add("BrandId", _BrandId);
                //    //    if (_ProdIDLocal > 0)
                //    //    {
                //    //        ProductMieleObjectDSLocal.FilterExpression = "ProductIdLocal =" + _ProdIDLocal;
                //    //    }
                //    //    ListViewProdotti.DataSource = ProductMieleObjectDSLocal;
                //    //    ListViewProdotti.DataBind();
                //    //}
                //    //if (_ProdID > 0)
                //    //{

                //    //}

                //}


                //if (_SearchType == Catalog_settings.SearchAdvanced)
                //{
                //    // Ricerca accessori aspirapolvere
                //    SearchPanel.Visible = false;
                //    string url = HttpContext.Current.Request.Path;
                //    string[] ArrUrl = Regex.Split(url, "/");
                //    _ = ArrUrl[ArrUrl.Length - 2];
                //    string r1, r2;
                //    if (string.IsNullOrEmpty(Request.QueryString["r1"].Replace("_", " ")))
                //    {
                //        r1 = "-1";
                //    }
                //    else
                //    {
                //        r1 = Request.QueryString["r1"].Replace("_", " ");
                //        SearchTxtBox.Text = r1;
                //    }
                //    r2 = string.IsNullOrEmpty(Request.QueryString["r2"].Replace("_", " ")) ? "-1" : Request.QueryString["r2"].Replace("_", " ");
                //    ShopList1.DataSource = Product_COMM.AspiraAccessoriRicercaAvanzata_Remote_DTS(r1.Replace("'", "''"), r2.Replace("'", "''"));
                //    //ListViewProdotti.DataSource = Product.GetSHpProductSearch("sacchetti", "S 1");
                //    ShopList1.DataBind();
                //}

            }
        }
        //protected void ListViewProdotti_ItemCommand(object sender, ListViewCommandEventArgs e)
        //{

        //    ListViewDataItem dataItem = (ListViewDataItem)e.Item;
        //    if (e.CommandName == "ApriPopup")
        //    {
        //        Session["ProductIdSession"] = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Value.ToString();
        //        Session["ProductIndexSession"] = dataItem.DisplayIndex;
        //    }
        //    else
        //    {

        //        if (e.CommandName == "SelectProduct")
        //        {
        //            string url = HttpContext.Current.Request.Path;
        //            string[] ArrUrl = Regex.Split(url, "/");
        //            string AreaProdotto = string.Empty;
        //            string BrandRWName = string.Empty;
        //            string BrandId = string.Empty;

        //            string SubCategoId = string.Empty;
        //            string MacroCategoRw = "Promozioni";
        //            int PosizioneInizialeUrl = Array.IndexOf(ArrUrl, "catalogo");
        //            int CategoId = 0;
        //            string NameRw = "";
        //            string StringaDettaglioProdotto = string.Empty;

        //            if (string.IsNullOrEmpty(Request.QueryString["r"]))
        //            {
        //                if (PosizioneInizialeUrl == -1)
        //                {
        //                    CategoId = Convert.ToInt32(ListViewProdotti.DataKeys[dataItem.DisplayIndex].Values["CategoryID"].ToString());

        //                    NameRw = GetCategoriaProdotto(CategoId);
        //                    PosizioneInizialeUrl = Array.IndexOf(ArrUrl, "promozioni");

        //                    BrandId = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Values["BrandId"].ToString();
        //                    BrandRWName = GetBrandbyID(Convert.ToInt32(BrandId));
        //                    AreaProdotto = "prodotto";
        //                }
        //                else
        //                {
        //                    CategoId = Convert.ToInt32(ArrUrl[PosizioneInizialeUrl + 5]);
        //                    BrandId = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Values["BrandId"].ToString();
        //                    BrandRWName = GetBrandbyID(Convert.ToInt32(BrandId));

        //                    AreaProdotto = "prodotto";
        //                    NameRw = ArrUrl[PosizioneInizialeUrl + 4];

        //                }
        //            }
        //            else
        //            {
        //                if (PosizioneInizialeUrl == -1)
        //                {
        //                    PosizioneInizialeUrl = Array.IndexOf(ArrUrl, "promozioni");
        //                    CategoId = Convert.ToInt32(ArrUrl[PosizioneInizialeUrl + 2]);

        //                    NameRw = ArrUrl[PosizioneInizialeUrl + 1];


        //                    BrandId = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Values["BrandId"].ToString();
        //                    BrandRWName = GetBrandbyID(Convert.ToInt32(BrandId));
        //                    AreaProdotto = "prodotto";
        //                }
        //                else
        //                {
        //                    CategoId = Convert.ToInt32(ArrUrl[PosizioneInizialeUrl + 5]);
        //                    BrandId = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Values["BrandId"].ToString();
        //                    BrandRWName = GetBrandbyID(Convert.ToInt32(BrandId));

        //                    AreaProdotto = "prodotto";
        //                    NameRw = ArrUrl[PosizioneInizialeUrl + 4];

        //                }
        //            }


        //            string ProductId = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Values[0].ToString();
        //            string ProductIdLocal = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Values[1].ToString();
        //            Label ProductIdLabel = (Label)e.Item.FindControl("ProductIdLabel");
        //            Label DisplayNameLabel = (Label)e.Item.FindControl("DisplayNameLabel");
        //            string UrlNameRw = DisplayNameLabel.Text;
        //            UrlNameRw = info4lab.FunzioniGenerali.RewriteString(UrlNameRw);
        //            StringaDettaglioProdotto = GetGerarchiaMiele_17Mono(Convert.ToInt32(BrandId), (-2), BrandRWName, CategoId, NameRw);



        //            String StrRedirect = "prodotto.aspx?Cod=";
        //            //string StrRedirect = Request.ApplicationPath.TrimEnd('/') + "/" + AreaProdotto + "/" + BrandRWName + "/" + BrandId + "/" + ProductId + "/" + ProductIdLocal + "/" + UrlNameRw + ".aspx";
        //            if (_SearchType == Catalog_settings.SearchEngine)
        //            {
        //                StrRedirect = Request.ApplicationPath.TrimEnd('/') + "/prodotto/" + StringaDettaglioProdotto + "/" + 0 + "/" + ProductId + "/" + ProductIdLocal + "/" + UrlNameRw + ".aspx";
        //            }
        //            //String StrRedirect = Request.ApplicationPath.TrimEnd('/') + "/" + AreaProdotto + "/" + BrandRWName + "/" + BrandId + "/" + ProductId + "/" + ProductIdLocal + "/" + UrlNameRw + ".aspx";
        //            //if (_SearchType == Catalog_settings.SearchEngine)
        //            //{
        //            //    StrRedirect = Request.ApplicationPath.TrimEnd('/') + "/prodotto/" + UrlNameRw + "/" + 0 + "/" + ProductId + "/" + ProductIdLocal + "/" + UrlNameRw + ".aspx";
        //            //}


        //            if (Array.IndexOf(ArrUrl, "p") == -1 && Array.IndexOf(ArrUrl, "prodotto") == -1)
        //            {
        //                Response.Redirect(StrRedirect);
        //            }
        //            else
        //            {
        //                // Response.Redirect(StrRedirect);
        //            }

        //        }
        //    }
        //    // commentato Simone lo vediamo più avanti 09/09/21



        //    //if (e.CommandName == "AddToCart")
        //    //{
        //    //    string ProductId = ListViewProdotti.DataKeys[dataItem.DisplayIndex].Value.ToString();
        //    //    //ListViewItem Item = (ListViewItem)ListViewProdotti.Items[e.ItemIndex];
        //    //    //int index = Convert.ToInt32(e.CommandArgument);

        //    //    Label PriceLabel = (Label)e.Item.FindControl("PriceLabel");
        //    //    Label ProductCodLabel = (Label)e.Item.FindControl("ProductCodLabel");
        //    //    Label DisplayNameLabel = (Label)e.Item.FindControl("DisplayNameLabel");
        //    //    Panel PromoPanel = (Panel)e.Item.FindControl("PromoPanel");
        //    //    string PriceLabelValue = string.Empty;

        //    //    if (PromoPanel.Visible == false)
        //    //    {
        //    //        PriceLabelValue = PriceLabel.Text;
        //    //    }
        //    //    else
        //    //    {
        //    //        Label PromoPriceLabel = (Label)e.Item.FindControl("PromoPriceLabel");
        //    //        PriceLabelValue = PromoPriceLabel.Text;
        //    //    }

        //    //    decimal ItemPrice = Convert.ToDecimal(PriceLabelValue);
        //    //    string descrizione = ProductCodLabel.Text + " - " + DisplayNameLabel.Text;
        //    //    StoredShoppingCart StoredShoppingCart = new StoredShoppingCart();
        //    //    //ShoppingCart shop1 = new ShoppingCart();

        //    //    int verificacart = StoredShoppingCart.verifica(ProductId);
        //    //    int qtasel = 0;
        //    //    if (verificacart == -1)
        //    //    {
        //    //        qtasel = 1;


        //    //        StoredShoppingCart.InsertItem(ProductId, descrizione, qtasel, qtasel, ItemPrice);
        //    //        SetSpeseTrasporto();
        //    //        //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRM/carrello.aspx");
        //    //        //Panel_articolo_inserito.Visible = True
        //    //    }
        //    //    else
        //    //    {

        //    //        qtasel = verificacart + 1;
        //    //        StoredShoppingCart.UpdateItem(ProductId, descrizione, qtasel, qtasel, ItemPrice);
        //    //        SetSpeseTrasporto();
        //    //        //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRM/carrello.aspx");

        //    //    }

        //    //}
        //}

        public static void ShowToastr(Page page, string message, string title, string type = "info", bool clearToast = false, string pos = "toast-top-right", bool Sticky = false)
        {
            string toastrScript = string.Format("Notify('{0}','{1}','{2}', '{3}', '{4}', '{5}');", message, title, type, clearToast, pos, Sticky);
            ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "script", toastrScript, true);
        }


        protected string GetImgUrl(string Url)
        {
            string ReTString = "{0}/{1}";
            string RicercaHref = "http://";
            string suffisso = Request.ApplicationPath.TrimEnd('/');
            //string suffisso = "";
            //if (_BrandId > 1)
            ReTString = Url.IndexOf(RicercaHref) < 0 ? string.Format(ReTString, suffisso, Url) : Url;

            return ReTString;
        }
        protected string GetUrlAddPromo(string VarProdId, int Fittizio)
        {
            string suffisso = Request.ApplicationPath.TrimEnd('/');
            string ReTString = suffisso + "/adminpanel/admin/COMM_Catalogo_Promo_Edit.aspx?id=" + VarProdId + "&Fittizio=" + Fittizio;

            return ReTString;
        }
        protected string GetUrlEditProd(string VarProdId, int Fittizio)
        {
            string suffisso = Request.ApplicationPath.TrimEnd('/');
            string ReTString = Fittizio == 1
    ? suffisso + "/Catalogo/Articoli_Crud.aspx?Cod=" + VarProdId
    : suffisso + "/Catalogo/Articoli_Crud.aspx?Cod=" + VarProdId;

            return ReTString;
        }
        //protected void PromoRBList_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    ListView ListViewProdottiLocal = new ListView();

        //    int id = ListViewProdotti.EditIndex;
        //    string ProductId = ListViewProdotti.DataKeys[id].Values["ProductId"].ToString();
        //    ListViewItem item = ListViewProdotti.Items[id];
        //    Panel panelpromoLocal = (Panel)item.FindControl("panelPromo");
        //    RadioButtonList PromoRBListLocal = (RadioButtonList)item.FindControl("PromoRBList");
        //    if (PromoRBListLocal.SelectedValue == "1")
        //    {
        //        panelpromoLocal.Visible = false;
        //    }
        //    else
        //    {
        //        panelpromoLocal.Visible = true;
        //    }
        //}
        //protected void ListViewProdotti_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        //{
        //    DataPager pager = (DataPager)((ListView)sender).FindControl("DataPager1");
        //    pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        //    if (_SearchType == Catalog_settings.Promo)
        //    {
        //        SHP_Product Products = new SHP_Product();
        //        ListViewProdotti.DataSource = COMM_ProdottiInPromo_ObjectDS;
        //        ListViewProdotti.DataBind();
        //    }
        //    if (_SearchType == Catalog_settings.Default)
        //    {
        //        SHP_Product Products = new SHP_Product();
        //        ListViewProdotti.DataSource = COMM_ProductsByCategoryID_Get_ObjectDS;
        //        ListViewProdotti.DataBind();
        //    }

        //}
        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            SHPCategory shp1 = new SHPCategory();
            SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();
            string MAcroCatego = PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.DescrCatMeno2);
            MAcroCatego = PRT_FunzioniGenerali_23.RewriteString(MAcroCatego);

            string CategoRw = "ACCESSORI";
            string[] FirstSubCatego = shp1.FirstSubCategoBrandMacrocatego(_CategoryId, Convert.ToInt32(_BrandId), Convert.ToInt32(_MacroCatego));
            _ = FirstSubCatego.Length < 0 || FirstSubCatego == null || FirstSubCatego[1] == null
    ? string.Empty
    : "/catalogo/" + MAcroCatego + "/" + BrandRwName + "/" + _BrandId + "/" + CategoRw + "/" + _CategoryId + "/" + FirstSubCatego[1].ToString() + "/" + FirstSubCatego[0].ToString();
            string ReTString = "catalogo/" + MAcroCatego + "/MIELE/1/ASPIRAPOLVERE/1/ACCESSORI/19/";
            //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/" + ReTString + "/ricerca.aspx?r1=" + SearchTxtBox.Text + "&r2=" + SearchDDL.SelectedValue);
        }
        protected void SetSpeseTrasporto()
        {
            SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();
            decimal SogliaSpeseTrasp = Convert.ToDecimal(PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.SogliaSpeseTrasp));
            decimal SpeseTraspOltreSoglia = Convert.ToDecimal(PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.SpeseTraspOltreSoglia));
            decimal SpeseTrasporto = Convert.ToDecimal(PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.SpeseTrasporto));
            bool GestioneSpeseTrasp = Convert.ToBoolean(PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.GestioneSpeseTrasp));
            if (GestioneSpeseTrasp)
            {
                _ = StoredShoppingCart_wish.GetSubTotale() > SogliaSpeseTrasp
                    ? StoredShoppingCart_wish.SetSpeseTrasporto(SpeseTraspOltreSoglia)
                    : StoredShoppingCart_wish.SetSpeseTrasporto(SpeseTrasporto);
            }
            else
            {
                _ = StoredShoppingCart_wish.SetSpeseTrasporto(SpeseTrasporto);
            }
        }
        protected void SearchDDL_PreRender(object sender, EventArgs e)
        {
            DropDownList SearchDDL = (DropDownList)FindControl("SearchDDL");
            if (_SearchType == Catalog_settings.SearchAdvanced)
            {
                string r2 = string.IsNullOrEmpty(Request.QueryString["r2"].Replace("_", " ")) ? "-1" : Request.QueryString["r2"];
                SearchDDL.SelectedValue = r2;
                SearchDDL.DataBind();
            }

        }
        protected void ListViewProdotti_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        protected void ListViewProdotti_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected List<string> keywords = new List<string>();
        //protected void COMM_AdvancedSearchV2ObjectDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        //{
        //    string RqKeyWords = Request.QueryString["r1"];
        //    if (string.IsNullOrEmpty(RqKeyWords))
        //    {
        //        RqKeyWords = "";
        //    }
        //    string[] keywords = RqKeyWords.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries);
        //    this.keywords = keywords.ToList();
        //    StringBuilder sqlBuilder = new StringBuilder();
        //    sqlBuilder.Append("");
        //    foreach (string item in keywords)
        //    {
        //        //sqlBuilder.AppendFormat("([DisplayName] like '%{0}%' or [ShortDescription] like '%{0}%' or [ProductCod] like '%{0}%' or [AttributesList] like '%{0}%')  and ", item);
        //        sqlBuilder.AppendFormat("([tags] like '%{0}%') and ", item);

        //    }

        //    // Remove unnecessary string " and " at the end of the command.
        //    string sql = "";
        //    if (keywords.Length <= 0)
        //    {
        //        sql = "[DisplayName] ='#261233234'";
        //    }
        //    else
        //    {
        //        sql = sqlBuilder.ToString(0, sqlBuilder.Length - 5);
        //    }
        //    COMM_AdvancedSearchV2ObjectDS.FilterExpression = sql;
        //    ListViewProdotti.DataSource = COMM_AdvancedSearchV2ObjectDS;
        //    ListViewProdotti.DataBind();

        //}


        protected void ProductObjectDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (_SearchType == Catalog_settings.Default)
            {
                SHPCategory Shopcategory = new SHPCategory();
                _ = new SHP_Product();
                //Shop4DataSetTableAdapters.SHP_CategoryTableAdapter SHP_CategoryTableAdapter1;
                //SHP_CategoryTableAdapter1 = new Shop4DataSetTableAdapters.SHP_CategoryTableAdapter();
                int ContaFigli = Shopcategory.SHP_GetChildCount(_CategoryId);
                int CategorySearch = ContaFigli > 0 ? Shopcategory.GetMyFirstChildID(_CategoryId) : _CategoryId;
                //LShop1 = Shopcategory.GetSHPSubCategoryByid(_CategoryId);
                _ = Shopcategory.GetMyParentalID(_CategoryId);
                //ProductObjectDS.SelectMethod = "GetSHPProductByCategoryIdDTV2";
                e.InputParameters.Clear();
                e.InputParameters.Add("CategoryId", CategorySearch);
            }
            if (_SearchType == Catalog_settings.Search)
            {
                SHPCategory Shopcategory = new SHPCategory();

                //LShop1 = Shopcategory.GetSHPSubCategoryByid(_CategoryId);
                _ = Shopcategory.GetMyParentalID(_CategoryId);
                //ProductObjectDS.SelectMethod = "GetSHPProductByCategoryIdDTV2";
                string url = HttpContext.Current.Request.Path;
                string[] ArrUrl = Regex.Split(url, "/");
                string search = ArrUrl[ArrUrl.Length - 2];
                e.InputParameters.Clear();
                e.InputParameters.Add("ProductID", search);
            }
            if (_SearchType == Catalog_settings.Promo)
            {
                _ = new SHP_Product();
                //ProductObjectDS.DataObjectTypeName = "GetSHPProductInPromoDT";

                //ListViewProdotti.DataSource = Products.GetSHPProductInPromoDT();


            }

        }
        protected string ControlloGiacenza(int _ProductId)
        {
            PRT_Ecommerce _obj = new PRT_Ecommerce();

            Tuple<bool, string> Risultato;
            Risultato = _obj.GiagenzaGet(_ProductId);
            return Risultato.Item2;


        }

        protected void ProductsByCategoryID_COMM_Get_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (_SearchType == Catalog_settings.Default)
            {
                SHPCategory Shopcategory = new SHPCategory();
                _ = new SHP_Product();
                //Shop4DataSetTableAdapters.SHP_CategoryTableAdapter SHP_CategoryTableAdapter1;
                //SHP_CategoryTableAdapter1 = new Shop4DataSetTableAdapters.SHP_CategoryTableAdapter();
                int ContaFigli = Shopcategory.SHP_GetChildCount(_CategoryId);
                int CategorySearch = ContaFigli > 0 ? Shopcategory.GetMyFirstChildID(_CategoryId) : _CategoryId;
                //LShop1 = Shopcategory.GetSHPSubCategoryByid(_CategoryId);
                _ = Shopcategory.GetMyParentalID(_CategoryId);
                //ProductObjectDS.SelectMethod = "GetSHPProductByCategoryIdDTV2";
                e.InputParameters.Clear();
                e.InputParameters.Add("CategoryId", CategorySearch);
            }
            if (_SearchType == Catalog_settings.Search)
            {
                _ = new SHPCategory();

                ////LShop1 = Shopcategory.GetSHPSubCategoryByid(_CategoryId);
                //int ParentalCategoryId = Shopcategory.GetMyParentalID(_CategoryId);
                //ProductObjectDS.SelectMethod = "GetSHPProductByCategoryIdDTV2";
                //string url = HttpContext.Current.Request.Path;
                //string[] ArrUrl = Regex.Split(url, "/");
                //string search = ArrUrl[ArrUrl.Length - 2];
                //e.InputParameters.Clear();
                //e.InputParameters.Add("ProductID", search);
            }
            if (_SearchType == Catalog_settings.Promo)
            {
                _ = new SHP_Product();
                //ProductObjectDS.DataObjectTypeName = "GetSHPProductInPromoDT";

                //ListViewProdotti.DataSource = Products.GetSHPProductInPromoDT();


            }
        }
        protected string GetGerarchiaMiele_17Mono(int BrandId, int MacroCatego, string BrandRwName, int CategoId_var, string CategoRw)
        {

            SHPCategory shp1 = new SHPCategory();
            string[] Catego = shp1.FirstBrandCatego(1, MacroCatego);
            _ = Convert.ToInt16(Catego[0].ToString());
            //ReTString = Catego[1].ToString();
            SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();
            string MAcroCatego = PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.DescrCatMeno2);
            if (MacroCatego == -1)
            {
                MAcroCatego = PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.DescrCatMeno1);
            }
            MAcroCatego = PRT_FunzioniGenerali_23.RewriteString(MAcroCatego);
            _ = shp1.FirstSubCatego(CategoId_var);
            string SottocategoriaDescr = shp1.FirstSubCatego(CategoId_var)[1].ToString();
            string SottocategoriaID = shp1.FirstSubCatego(CategoId_var)[0].ToString() == "0"
    ? CategoId_var.ToString()
    : shp1.FirstSubCatego(CategoId_var)[0].ToString();
            string ReTString = MAcroCatego + "/" + BrandRwName + "/" + BrandId + "/" + CategoRw + "/" + CategoId_var.ToString() + "/" + SottocategoriaDescr + "/" + SottocategoriaID;
            //if (shp1.FirstBrandCatego(Convert.ToInt16(BrandLabel.Text), Convert.ToInt16(MacroCategoLabel.Text)) == CategoryId)
            //{
            //    ReTString = " actived hover";
            //}

            return ReTString;
        }

        private string GetCategoriaProdotto(int ID)
        {
            string SqlString = "Select  NameRw from  SHP_Category  WHERE (categoryID = " + ID + ")";
            string Categoria = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {

                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = SqlString
                };
                myConnection.Open();
#pragma warning disable CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                bool retVal = false;
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    retVal = false;
                }

                else
                {
                    while (myReader.Read())
                    {
                        Categoria = myReader["NameRw"].ToString();
                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            return Categoria;
        }

        private string GetBrandbyID(int ID)
        {
            string SqlString = "Select  NameRW from  SHP_Brand  WHERE (BrandId = " + ID + ")";
            string Marchio = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {

                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = SqlString
                };
                myConnection.Open();
#pragma warning disable CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                bool retVal = false;
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    retVal = false;
                }

                else
                {
                    while (myReader.Read())
                    {
                        Marchio = myReader["NameRW"].ToString();
                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            return Marchio;
        }


        //protected void SelezionaAtleta_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        //{
        //    Session["ProductIdSession"] = ListViewProdotti.DataKeys[Convert.ToInt32(e.Parameter)].Value.ToString();
        //    Session["ProductIndexSession"] = e.Parameter;
        //    AtletiAssociati_Gridview.DataBind();
        //}

        protected void AggiungiAlCarrello_Btn_Init(object sender, EventArgs e)
        {
            if (sender is ASPxButton AggiungiAlCarrello_Btn)
            {
                AggiungiAlCarrello_Btn.ClientSideEvents.Click = "function(s,e){SelezionaAtleta_Callback.PerformCallback();}";
            }
        }

        //protected void AddCart_Btn_DataBinding(object sender, EventArgs e)
        //{
        //    ASPxButton AddCart_Btn = sender as ASPxButton;
        //    GridViewDataItemTemplateContainer container = AddCart_Btn.NamingContainer as GridViewDataItemTemplateContainer;

        //    if (AddCart_Btn != null)
        //    {
        //        bool GiorniRichiestiCheck = Convert.ToBoolean(AtletiAssociati_Gridview.GetRowValues(container.VisibleIndex, "GiorniRichiestiFlag"));

        //        if (GiorniRichiestiCheck)
        //        {
        //            AddCart_Btn.ClientSideEvents.Click = "function(s,e){if(" + HumanFriendlyInteger.IntegerToWritten(container.VisibleIndex) + "_Giorni_token.isValid){ SelezionaAtleta_Callback.PerformCallback(" + container.VisibleIndex + ");}}";
        //        }
        //        else
        //        {
        //            AddCart_Btn.ClientSideEvents.Click = "function(s,e){SelezionaAtleta_Callback.PerformCallback(" + container.VisibleIndex + ")}";
        //        }
        //        //AddCart_Btn.ClientSideEvents.Click = "function(s,e){alert(" + HumanFriendlyInteger.IntegerToWritten(container.VisibleIndex) + "_Giorni_token.isValid)}";

        //    }
        //}

        //protected void SelezionaAtleta_Callback_Callback(object source, CallbackEventArgs e)
        //{

        //    int VisibleIndex = Convert.ToInt32(e.Parameter);
        //    string ProductId = ListViewProdotti.DataKeys[Convert.ToInt32(Session["ProductIndexSession"])].Value.ToString();
        //    ListViewItem Item = ListViewProdotti.Items[Convert.ToInt32(Session["ProductIndexSession"])];
        //    Label PriceLabel = (Label)Item.FindControl("PriceLabel");
        //    Label ProductCodLabel = (Label)Item.FindControl("ProductCodLabel");
        //    Label DisplayNameLabel = (Label)Item.FindControl("DisplayNameLabel");
        //    Panel PromoPanel = (Panel)Item.FindControl("PromoPanel");
        //    string PriceLabelValue = string.Empty;

        //    if (PromoPanel.Visible == false)
        //    {
        //        PriceLabelValue = PriceLabel.Text;
        //    }
        //    else
        //    {
        //        Label PromoPriceLabel = (Label)Item.FindControl("PromoPriceLabel");
        //        PriceLabelValue = PromoPriceLabel.Text;
        //    }

        //    decimal ItemPrice = Convert.ToDecimal(PriceLabelValue);
        //    string descrizione = ProductCodLabel.Text + " - " + DisplayNameLabel.Text;
        //    StoredShoppingCart StoredShoppingCart = new StoredShoppingCart();
        //    //ShoppingCart shop1 = new ShoppingCart();
        //    int IdContattoRM = Convert.ToInt32(AtletiAssociati_Gridview.GetRowValues(VisibleIndex, "IDContatto"));
        //    ASPxTokenBox Giorni_token = (ASPxTokenBox)AtletiAssociati_Gridview.FindRowCellTemplateControl(VisibleIndex, (GridViewDataColumn)AtletiAssociati_Gridview.Columns["GiorniGest"], "Giorni_token");
        //    ASPxTokenBox Giorni2_token = (ASPxTokenBox)AtletiAssociati_Gridview.FindRowCellTemplateControl(VisibleIndex, (GridViewDataColumn)AtletiAssociati_Gridview.Columns["Resp"], "Giorni2_token");
        //    string VarGiorni_token = Giorni_token.Text;
        //    string VarGiorniResp_token = Giorni2_token.Text;
        //    int verificacart = StoredShoppingCart.verifica(ProductId, IdContattoRM);
        //    int qtasel = 0;

        //    string NomeContattoRM = AtletiAssociati_Gridview.GetRowValues(VisibleIndex, "Nome").ToString() + " " + AtletiAssociati_Gridview.GetRowValues(VisibleIndex, "Cognome").ToString();
        //    NomeContattoRM = NomeContattoRM.ToUpper();

        //    SHP_Articoli _ArticoloSelect = new SHP_Articoli();
        //    _ArticoloSelect = SHP_Articoli.GetDettaglioSHP_Articolo(Convert.ToInt32(ProductId), CategoryId);

        //    if (verificacart == -1)
        //    {
        //        string[] CategoScontoQuotaRidottaArray;
        //        qtasel = 1;
        //        if (!string.IsNullOrEmpty(_ArticoloSelect.CategoScontoQuotaRidotta))
        //        {
        //            CategoScontoQuotaRidottaArray = _ArticoloSelect.CategoScontoQuotaRidotta.Split(';');
        //        }
        //        bool ScontoFamigliaPresente = Order.GetSeRMScontoFamiglia(IdContattoRM);
        //        bool ScontoTesseratiPresente = INTRA.AppCode.RM_Atleti.GetSeFamigliaTesserataFIR(IdContattoRM);

        //        List<CartItem> MyCartItems = new List<CartItem>();
        //        MyCartItems = StoredShoppingCart.ReadItems();

        //        if (MyCartItems.Count > 0)
        //        {
        //            ScontoFamigliaPresente = true;
        //        }

        //        string _VarCodScontoApplicato = string.Empty;
        //        if (ScontoFamigliaPresente)
        //        {
        //            _VarCodScontoApplicato = "FAMIGLIA";
        //        }
        //        else
        //        {
        //            if (ScontoTesseratiPresente)
        //            {
        //                _VarCodScontoApplicato = "FIR";
        //            }
        //            else
        //            {
        //                _VarCodScontoApplicato = string.Empty;
        //            }

        //        }
        //        List<PRT_DropDown_ElementiClass> _PRT_DropDownList = new List<PRT_DropDown_ElementiClass>();

        //        if (ScontoFamigliaPresente || ScontoTesseratiPresente)
        //        {
        //            _PRT_DropDownList = PRT_DropDown_ElementiClass.GetPRT_DropDown_ElementiRows("RmShopQuotaRidotta");
        //        }

        //        string ScontoApplicato = string.Empty;

        //        if (!string.IsNullOrEmpty(_VarCodScontoApplicato) && _ArticoloSelect.CategoScontoQuotaRidotta.Contains(_VarCodScontoApplicato))
        //        {
        //            // devo recuperare da prt_dropdown il testo dello sconto applicato e associarlo alla variabile sconto applicato
        //            ItemPrice = _ArticoloSelect.QuotaRidotta;
        //            List<PRT_DropDown_ElementiClass> _PRT_DropDownListFilter = new List<PRT_DropDown_ElementiClass>();
        //            _PRT_DropDownListFilter = _PRT_DropDownList.Where(x => x.ValueField == _VarCodScontoApplicato).ToList();
        //            ScontoApplicato = "Applicato Sconto " + _PRT_DropDownListFilter[0].TextField;
        //        }
        //        decimal Quota = _ArticoloSelect.Price;
        //        decimal QuotaRidotta = _ArticoloSelect.QuotaRidotta;

        //        decimal PercentualeSconto = _ArticoloSelect.PercentualeSconto;
        //        string TokenAttributi = "";

        //        if (VarGiorni_token != "")
        //        {
        //            TokenAttributi = VarGiorni_token;
        //        }
        //        else
        //        {
        //            TokenAttributi = VarGiorniResp_token;
        //        }


        //        bool EnableEditQta = _ArticoloSelect.EnableEditQta;


        //        StoredShoppingCart.InsertItem(ProductId, descrizione, qtasel, qtasel, ItemPrice, IdContattoRM, NomeContattoRM, Quota,
        //     QuotaRidotta, ScontoApplicato, PercentualeSconto, TokenAttributi, EnableEditQta, _ArticoloSelect.Stagione, _ArticoloSelect.GiorniRichiestiFlag, _ArticoloSelect.CategoryID);
        //        SetSpeseTrasporto();
        //        //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRM/carrello.aspx");
        //        //Panel_articolo_inserito.Visible = True
        //    }
        //    else
        //    {

        //        if (_ArticoloSelect.EnableEditQta)
        //        {
        //            qtasel = verificacart + 1;
        //            bool EnableEditQta = false;
        //            StoredShoppingCart.UpdateItem(ProductId, descrizione, qtasel, qtasel, ItemPrice, IdContattoRM, EnableEditQta);
        //            SetSpeseTrasporto();
        //        }
        //        //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRM/carrello.aspx");

        //    }

        //    //ASPxButton AddCart_Btn = (ASPxButton)AtletiAssociati_Gridview.FindRowCellTemplateControl(VisibleIndex, (GridViewDataColumn)AtletiAssociati_Gridview.Columns["Associa"], "AddCart_Btn");
        //    //AddCart_Btn.Enabled = false;
        //}

        //protected void Giorni_token_Init(object sender, EventArgs e)
        //{
        //    ASPxTokenBox Giorni_token = (ASPxTokenBox)sender;
        //    GridViewDataItemTemplateContainer container = Giorni_token.NamingContainer as GridViewDataItemTemplateContainer;

        //    // You can remove the if statement, and try to insert a new record. You'll catch an exception, because the DataBinder returns null reference  
        //    if (Giorni_token != null)
        //    {
        //        Giorni_token.ClientInstanceName = HumanFriendlyInteger.IntegerToWritten(container.VisibleIndex) + "_Giorni_token";
        //        Giorni_token.IsValid = false;
        //        Giorni_token.ErrorText = "Bisogna selezionare " + AtletiAssociati_Gridview.GetRowValues(container.VisibleIndex, "GiorniRichiesti") + " giorni per continuare";
        //    }


        //}

        //protected void AggiungiWishList_Callback_Callback(object source, CallbackEventArgs e)
        //{
        //    // da verificare
        //    //ShopList1.DataBind();
        //    MembershipUser UserLog = Membership.GetUser();


        //    dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
        //    int VisibleIndex = 0;
        //    decimal Qta = 0;
        //    string[] Parametri = e.Parameter.Split(';');
        //    string ProductCod = string.Empty;


        //    if (Parametri.Count() > 1)
        //    {
        //        VisibleIndex = Convert.ToInt32(Parametri[0]);
        //        Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
        //        ProductCod = ShopList1.GetCardValues(VisibleIndex, "ProductCod").ToString();

        //        for (int j = 0; j < ShopList1.VisibleCardCount; j++)
        //        {
        //            if (ShopList1.GetCardValues(j, "ProductCod").ToString() == ProductCod)
        //            {
        //                VisibleIndex = j;
        //            }
        //        }
        //    }

        //    _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "Prezzo_Lbl");


        //    string Price = ShopList1.GetCardValues(VisibleIndex, "Price").ToString();
        //    string DisplayName = ShopList1.GetCardValues(VisibleIndex, "DisplayName").ToString();
        //    string PromoPrice = ShopList1.GetCardValues(VisibleIndex, "PromoPrice").ToString();
        //    _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "ProductCod_lbl");
        //    _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "DisplayName_lbl");

        //    //ASPxPanel DXPromoPanel = (ASPxPanel)ShopList1.FindCardTemplateControl(VisibleIndex, "DXPromoPanel");
        //    //Panel PromoPanel = (Panel)ShopList1.FindCardTemplateControl(VisibleIndex, "PromoPanel");
        //    //ASPxTextBox Qta_Txt = (ASPxTextBox)ShopList1.FindCardTemplateControl(VisibleIndex, "QtaDef_Txt");

        //    //ASPxLabel SpeseTrasporto_Lbl = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "SpeseTrasporto_Lbl");
        //    //ASPxCheckBox SpeseTrasporto_Ckbx = (ASPxCheckBox)ShopList1.FindCardTemplateControl(VisibleIndex, "SpeseTrasporto_Ckbx");
        //    string PriceLabelValue = PromoPrice == "0" ? Price : PromoPrice;
        //    decimal ItemPrice = Convert.ToDecimal(PriceLabelValue);
        //    string descrizione = ProductCod + " - " + DisplayName;
        //    _ = new StoredShoppingCart();
        //    int IdContattoRM = 0;

        //    string CodCli = HttpContext.Current.Request.Cookies["CodCli"].Value;
        //    CodCli = CodCli.Replace("CodCli=", string.Empty);
        //    decimal verificacart = StoredShoppingCart.VerificaItemStatic(ProductCod, CodCli);
        //    decimal qtasel = Qta;

        //    string NomeContattoRM = MyProfile.Name + " " + MyProfile.cognome;
        //    NomeContattoRM = NomeContattoRM.ToUpper();
        //    _ = new SHP_Articoli();
        //    SHP_Articoli _ArticoloSelect = SHP_Articoli.Caglio_GetDettaglioSHP_Articolo(ProductCod, CategoryId, "00");

        //    if (verificacart == -1)
        //    {
        //        string ScontoApplicato = string.Empty;
        //        decimal Quota = _ArticoloSelect.Price;
        //        decimal QuotaRidotta = _ArticoloSelect.QuotaRidotta;
        //        decimal PercentualeSconto = _ArticoloSelect.PercentualeSconto;
        //        string TokenAttributi = string.Empty;
        //        bool EnableEditQta = _ArticoloSelect.EnableEditQta;
        //        _ = _ArticoloSelect.QtaXConf;
        //        //string CodLis = MyProfile.CodLis;
        //        string CodLis = "00";
        //        _ = StoredShoppingCart.InsertItem(ProductCod, descrizione, qtasel, qtasel, ItemPrice, IdContattoRM, NomeContattoRM, Quota,
        //         QuotaRidotta, ScontoApplicato, PercentualeSconto, TokenAttributi, EnableEditQta, _ArticoloSelect.Stagione, _ArticoloSelect.GiorniRichiestiFlag,
        //         _ArticoloSelect.CategoryID, _ArticoloSelect.UM, _ArticoloSelect.U_Confez_Intra, _ArticoloSelect.u_pz_lordo, _ArticoloSelect.NumDec,
        //         _ArticoloSelect.RifIva, _ArticoloSelect.U_Sc2, _ArticoloSelect.U_Sc1, _ArticoloSelect.UM, _ArticoloSelect.PictureUrl, _ArticoloSelect.QtaXConf, CodLis);
        //        //SetSpeseTrasporto();
        //    }
        //    else
        //    {
        //        qtasel = verificacart + qtasel;
        //        bool EnableEditQta = true;
        //        _ = StoredShoppingCart.UpdateItem(ProductCod, descrizione, qtasel, qtasel, ItemPrice, IdContattoRM, EnableEditQta, _ArticoloSelect.QtaXConf);
        //        // SetSpeseTrasporto();
        //    }
        //}



        protected void AggiungiAlCarrello_Callback_Callback(object source, CallbackEventArgs e)
        {
            // da verificare
            //ShopList1.DataBind();
            MembershipUser UserLog = Membership.GetUser();


            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
            int VisibleIndex = 0;
            decimal Qta = 0;
            string[] Parametri = e.Parameter.Split(';');
            string ProductCod = string.Empty;


            if (Parametri.Count() > 1)
            {
                VisibleIndex = Convert.ToInt32(Parametri[0]);
                Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
                ProductCod = ShopList1.GetCardValues(VisibleIndex, "ProductCod").ToString();

                for (int j = 0; j < ShopList1.VisibleCardCount; j++)
                {
                    if (ShopList1.GetCardValues(j, "ProductCod").ToString() == ProductCod)
                    {
                        VisibleIndex = j;
                    }
                }
            }

            //_ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "Prezzo_Lbl");


            //string Price = ShopList1.GetCardValues(VisibleIndex, "Price").ToString();
            string DisplayName = ShopList1.GetCardValues(VisibleIndex, "FullDescription").ToString();
            //string ShortDescription = ShopList1.GetCardValues(VisibleIndex, "ShortDescription").ToString();
            //string PromoPrice = ShopList1.GetCardValues(VisibleIndex, "PromoPrice").ToString();
            _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "ProductCod_lbl");
            _ = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "DisplayName_lbl");

            //ASPxPanel DXPromoPanel = (ASPxPanel)ShopList1.FindCardTemplateControl(VisibleIndex, "DXPromoPanel");
            //Panel PromoPanel = (Panel)ShopList1.FindCardTemplateControl(VisibleIndex, "PromoPanel");
            //ASPxTextBox Qta_Txt = (ASPxTextBox)ShopList1.FindCardTemplateControl(VisibleIndex, "QtaDef_Txt");

            //ASPxLabel SpeseTrasporto_Lbl = (ASPxLabel)ShopList1.FindCardTemplateControl(VisibleIndex, "SpeseTrasporto_Lbl");
            //ASPxCheckBox SpeseTrasporto_Ckbx = (ASPxCheckBox)ShopList1.FindCardTemplateControl(VisibleIndex, "SpeseTrasporto_Ckbx");
            decimal ItemPrice = 0;
            string descrizione = DisplayName;
            _ = new StoredShoppingCart();
            int IdContattoRM = 0;

            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
            CodDep = CodDep.Replace("CodDep=", string.Empty);
            decimal verificacart = StoredShoppingCart.VerificaItemStatic(ProductCod, CodDep);
            decimal qtasel = Qta;

            string NomeContattoRM = MyProfile.Name + " " + MyProfile.cognome;
            _ = new SHP_Articoli();
            SHP_Articoli _ArticoloSelect = SHP_Articoli.U_GetDettaglioSHP_Articolo(ProductCod, CategoryId);

            if (verificacart == -1)
            {
                //_ = _ArticoloSelect.QtaXConf;
                //string CodLis = MyProfile.CodLis;
                _ = StoredShoppingCart.InsertItem(ProductCod, descrizione, qtasel, qtasel, _ArticoloSelect.CategoryID, _ArticoloSelect.UM);
                //SetSpeseTrasporto();
            }
            else
            {
                qtasel = verificacart + qtasel;
                bool EnableEditQta = true;
                _ = StoredShoppingCart.UpdateItem(ProductCod, qtasel);
                // SetSpeseTrasporto();
            }
        }


        public static class HumanFriendlyInteger
        {
            private static readonly string[] ones = new string[] { string.Empty, "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" };
            private static readonly string[] teens = new string[] { "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
            private static readonly string[] tens = new string[] { "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };
            private static readonly string[] thousandsGroups = { string.Empty, " Thousand", " Million", " Billion" };

            private static string FriendlyInteger(int n, string leftDigits, int thousands)
            {
                if (n == 0)
                {
                    return leftDigits;
                }

                string friendlyInt = leftDigits;

                if (friendlyInt.Length > 0)
                {
                    friendlyInt += " ";
                }

                if (n < 10)
                {
                    friendlyInt += ones[n];
                }
                else if (n < 20)
                {
                    friendlyInt += teens[n - 10];
                }
                else if (n < 100)
                {
                    friendlyInt += FriendlyInteger(n % 10, tens[(n / 10) - 2], 0);
                }
                else if (n < 1000)
                {
                    friendlyInt += FriendlyInteger(n % 100, ones[n / 100] + " Hundred", 0);
                }
                else
                {
                    friendlyInt += FriendlyInteger(n % 1000, FriendlyInteger(n / 1000, string.Empty, thousands + 1), 0);
                    if (n % 1000 == 0)
                    {
                        return friendlyInt;
                    }
                }

                return friendlyInt + thousandsGroups[thousands];
            }

            public static string IntegerToWritten(int n)
            {
                if (n == 0)
                {
                    return "Zero";
                }
                else if (n < 0)
                {
                    return "Negative " + IntegerToWritten(-n);
                }

                return FriendlyInteger(n, string.Empty, 0);
            }
        }



        protected string CreateTagsFilter()
        {
            // creato 04/11/2021 Simone
            string RqKeyWords = Request.QueryString["r1"];
            if (string.IsNullOrEmpty(RqKeyWords))
            {
                RqKeyWords = string.Empty;
            }
            string[] keywords = RqKeyWords.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries);
            this.keywords = keywords.ToList();
            StringBuilder sqlBuilder = new StringBuilder();
            _ = sqlBuilder.Append(string.Empty);
            foreach (string item in keywords)
            {
                //sqlBuilder.AppendFormat("([DisplayName] like '%{0}%' or [ShortDescription] like '%{0}%' or [ProductCod] like '%{0}%' or [AttributesList] like '%{0}%')  and ", item);
                _ = sqlBuilder.AppendFormat("([tags] like '%{0}%') and ", item);

            }
            // Remove unnecessary string " and " at the end of the command.
            string sql = keywords.Length <= 0 ? "[DisplayName] ='#261233234'" : sqlBuilder.ToString(0, sqlBuilder.Length - 5);
            string _retString = sql;
            return _retString;
        }

        protected void AggiungiAlCarrelloSubCatego_Callback_Callback(object source, CallbackEventArgs e)
        {
            int qtasel = 1;
            int CategoryID = int.Parse(Request.QueryString["Cat"].ToString());
            decimal Quota = 0;
            decimal QuotaRidotta = 0;
            string ScontoApplicato = string.Empty;
            decimal PercentualeSconto = 0;
            string TokenAttributi = string.Empty;
            bool EnableEditQta = false;
            string Stagione = string.Empty;
            bool GiorniRichiestiFlag = false;


            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("COMM_Product_Local_ByCategoryId_Get", objParams))
            {

                while (reader.Read())
                {
                    _ = reader.GetInt32(reader.GetOrdinal("ProductId"));
                    string ProductCod = reader.GetString(reader.GetOrdinal("ProductCod"));
                    string DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                    string descrizione = ProductCod + " - " + DisplayName;
                    decimal ItemPrice = reader.GetDecimal(reader.GetOrdinal("Price"));
                    int verificacart = StoredShoppingCart_wish.verifica(ProductCod, 0);
                    if (verificacart == -1)
                    {
                        _ = StoredShoppingCart_wish.InsertItem(ProductCod, descrizione, qtasel, qtasel, ItemPrice, 0, string.Empty, Quota,
                 QuotaRidotta, ScontoApplicato, PercentualeSconto, TokenAttributi, EnableEditQta, Stagione, GiorniRichiestiFlag,
                 CategoryID);
                    }

                }
                reader.Close();
            }




        }
        protected void AggiungiAllaWishlist_Callback_Callback(object source, CallbackEventArgs e)
        {
            _ = Membership.GetUser();
            //dynamic MyProfile = (ProfileBase)ProfileBase.Create(UserLog.UserName, true);
            int VisibleIndex = Convert.ToInt32(e.Parameter);
            string ProductId = ShopList1.GetCardValues(VisibleIndex, "ProductCod").ToString();
            string Price = ShopList1.GetCardValues(VisibleIndex, "Price").ToString();
            _ = (Label)ShopList1.FindCardTemplateControl(VisibleIndex, "PriceLabel");
            _ = (Label)ShopList1.FindCardTemplateControl(VisibleIndex, "ProductCodLabel");
            string ProductCod = ShopList1.GetCardValues(VisibleIndex, "ProductCod").ToString();
            _ = (Label)ShopList1.FindCardTemplateControl(VisibleIndex, "DisplayNameLabel");
            string DisplayName = ShopList1.GetCardValues(VisibleIndex, "DisplayName").ToString();
            _ = (Panel)ShopList1.FindCardTemplateControl(VisibleIndex, "PromoPanel");

            string PromoPrice = ShopList1.GetCardValues(VisibleIndex, "PromoPrice").ToString();
            string ScontoApplicato = string.Empty;
            decimal QuotaRidotta = 0;
            decimal Quota = Convert.ToDecimal(Price);
            string PriceLabelValue;
            if (string.IsNullOrEmpty(PromoPrice) || PromoPrice == "0")
            {
                PriceLabelValue = Price;

                ;
            }
            else
            {
                //Label PromoPriceLabel = (Label)ShopList1.FindCardTemplateControl(VisibleIndex, "PromoPriceLabel");
                PriceLabelValue = PromoPrice;
                QuotaRidotta = Convert.ToDecimal(PromoPrice);
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
            HttpContext.Current.Session["CartBK"] = HttpContext.Current.Session["Cart"];

            HttpContext.Current.Session["CartBK"] = HttpContext.Current.Session["Cart"];


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

                HttpContext.Current.Session["CartBK"] = HttpContext.Current.Session["Cart"];
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
                    // SetSpeseTrasporto();
                }
                //Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRM/carrello.aspx");

            }

            //ASPxButton AddCart_Btn = (ASPxButton)AtletiAssociati_Gridview.FindRowCellTemplateControl(VisibleIndex, (GridViewDataColumn)AtletiAssociati_Gridview.Columns["Associa"], "AddCart_Btn");
            //AddCart_Btn.Enabled = false;
        }
        protected void AggiungiAllaWishlistSubCatego_Callback_Callback(object source, CallbackEventArgs e)
        {
            int qtasel = 1;
            int CategoryID = int.Parse(Request.QueryString["Cat"].ToString());
            decimal Quota = 0;
            decimal QuotaRidotta = 0;
            string ScontoApplicato = string.Empty;
            decimal PercentualeSconto = 0;
            string TokenAttributi = string.Empty;
            bool EnableEditQta = false;
            string Stagione = string.Empty;
            bool GiorniRichiestiFlag = false;


            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("COMM_Product_Local_ByCategoryId_Get", objParams))
            {

                while (reader.Read())
                {
                    _ = reader.GetInt32(reader.GetOrdinal("ProductId"));
                    string ProductCod = reader.GetString(reader.GetOrdinal("ProductCod"));
                    string DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                    string descrizione = ProductCod + " - " + DisplayName;
                    decimal ItemPrice = reader.GetDecimal(reader.GetOrdinal("Price"));
                    int verificacart = StoredShoppingCart_wish.verifica(ProductCod, 0);
                    if (verificacart == -1)
                    {
                        _ = StoredShoppingCart_wish.InsertItem(ProductCod, descrizione, qtasel, qtasel, ItemPrice, 0, string.Empty, Quota,
                 QuotaRidotta, ScontoApplicato, PercentualeSconto, TokenAttributi, EnableEditQta, Stagione, GiorniRichiestiFlag,
                 CategoryID);
                    }

                }
                reader.Close();
            }




        }


    }
}