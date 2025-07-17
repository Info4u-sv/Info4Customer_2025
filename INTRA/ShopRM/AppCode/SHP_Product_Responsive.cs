
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


namespace INTRA.ShopRM.AppCode
{
    public class SHP_Product_Responsive
    {
        public SHP_Product_Responsive()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }


        private List<SHP_Product_Responsive> AllProductPrezzoFissa_COMM_Get()
        {
            _ = new DataTable();

            List<SHP_Product_Responsive> LocalList = new List<SHP_Product_Responsive>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            _ = new SqlParameter[0];
            _ = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SELECT  *  FROM [SHP_Product] where PriceFixed > 0"))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        _ = new SHP_Product_Responsive();
                        SHP_Product_Responsive SHPProduct = ProdottoDettGet(reader.GetInt32(reader.GetOrdinal("ProductId")));
                        if (SHPProduct.Published)
                        {
                            LocalList.Add(SHPProduct);
                        }
                    }
                }
                reader.Close();

            }
            return LocalList;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);

        }

        private List<SHP_Product_Responsive> AllProducts_COMM_Get()
        {
            _ = new DataTable();

            List<SHP_Product_Responsive> LocalList = new List<SHP_Product_Responsive>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            _ = new SqlParameter[0];
            _ = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SELECT  *  FROM SHP_AllProductWithPromo "))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        _ = new SHP_Product_Responsive();
                        SHP_Product_Responsive SHPProduct = ProductTemplateGet(reader, reader.GetInt32(reader.GetOrdinal("ProductId")), 0);

                        SHPProduct.tags = SHPProduct.ProductCod + " " + SHPProduct.DisplayName + " " + SHPProduct.ShortDescription + " " + SHPProduct.FullDescription + " " + SHPProduct.AttributesList + " "/* + SHPProduct.brandname*/;


                        SHPProduct.tags = reader.GetOrdinal("Tags").ToString();

                        LocalList.Add(SHPProduct);
                    }
                }
                reader.Close();

            }
            return LocalList;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);

        }
        //private List<SHP_Product_Responsive> AspiraAccessoriRicercaAvanzata_Remote(string txt, string model)
        //{
        //    // Ricerca accessori Aspirapovere 
        //    DataTable dt = new DataTable();
        //    //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
        //    //if (!CacheHelper_23.ItemExists(CacheTable))
        //    //{
        //    //int CategoryID = GetCategoryIdByNameRW(NameRw);
        //    List<SHP_Product_Responsive> LocalList = new List<SHP_Product_Responsive>();
        //    Sql4Helper objSqlHelper = new Sql4Helper();
        //    SqlParameter[] objParams = new SqlParameter[2];
        //    objParams[0] = new SqlParameter("@r1", txt);
        //    objParams[1] = new SqlParameter("@r2", model);
        //    using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductSearch_V2", objParams))
        //    {

        //        while (reader.Read())
        //        {
        //            SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
        //            int _productIdLocal = ProdId_LOCAL_by_ProdId_ReomoteGET(reader.GetInt32(reader.GetOrdinal("ProductId")));
        //            SHPProduct = ProdottoReomotoGet(_productIdLocal);
        //            SHPProduct.tags = SHPProduct.ProductCod + " " + SHPProduct.DisplayName + " " + SHPProduct.ShortDescription + " " + SHPProduct.FullDescription + " " + SHPProduct.AttributesList + " "/* + SHPProduct.brandname*/;

        //            LocalList.Add(SHPProduct);
        //        }
        //        reader.Close();
        //        //CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
        //    }
        //    //}
        //    return LocalList;
        //}
        private void COMM_ProductRemoteCreateInLocal(int ProductId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            _ = objSqlHelper.ExecuteNonQuery("COMM_ProductRemoteCreate", objParams);

        }
        private List<SHP_Product_Responsive> ProdottiInPromo_LIST()
        {
            _ = new DataTable();

            List<SHP_Product_Responsive> LocalList = new List<SHP_Product_Responsive>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            _ = new SqlParameter[0];
            _ = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SELECT  * FROM [SHP_AllProductWithPromo] where [Published] = 1 and promoid > 0 and startdate is not null"))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
                        //SHPProduct = ProdottoDettGet(reader.GetInt32(reader.GetOrdinal("ProductId")));
                        SHPProduct = SHPProduct.ProductTemplateGet(reader, reader.GetInt32(reader.GetOrdinal("ProductId")), 0);

                        SHPProduct.tags = reader.GetOrdinal("Tags").ToString();

                        LocalList.Add(SHPProduct);
                    }
                }
                reader.Close();

            }
            return LocalList;

        }

        // recupero prodotti dal DATABASE REMOTO con annesse promozioni locali e prezzo fisato 

        private List<SHP_Product_Responsive> Product_Remote_ByCategoryId(int CategoryId)
        {
            _ = new DataTable();

            List<SHP_Product_Responsive> GetSHPCategoryProductLst = new List<SHP_Product_Responsive>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductByCategoryId_V2", objParams))
            {
                while (reader.Read())
                {
                    _ = new SHP_Product_Responsive();
                    int _productIdLocal = ProdId_LOCAL_by_ProdId_ReomoteGET(reader.GetInt32(reader.GetOrdinal("ProductId")));
                    SHP_Product_Responsive SHPProduct = ProdottoReomotoGet(_productIdLocal);

                    GetSHPCategoryProductLst.Add(SHPProduct);
                }
                reader.Close();


            }
            return GetSHPCategoryProductLst;

        }
        // Questa funzione restitiuisce tutti i prodotti sia remoti che locali Fondamentale per tutte le ricerche
        // restitiusice inoltre il ProductId della tabella SHP_Product_Local per la gestione della giacenza

        private List<SHP_Product_Responsive> ProductsByCategoryID_COMM_Get(int CategoryId)
        {
            _ = new DataTable();
            List<SHP_Product_Responsive> GetSHPCategoryProductLst = new List<SHP_Product_Responsive>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            List<SHP_Product_Responsive> _ListConcat = new List<SHP_Product_Responsive>();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("COMM_Product_Local_ByCategoryId_Get", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
                    int _productId = reader.GetInt32(reader.GetOrdinal("ProductId"));

                    SHPProduct = SHPProduct.ProductTemplateGet(reader, _productId, 0);

                    GetSHPCategoryProductLst.Add(SHPProduct);
                }
                reader.Close();


                SHP_Product_Responsive _obj1 = new SHP_Product_Responsive();


                List<SHP_Product_Responsive> _ListRemore = new List<SHP_Product_Responsive>();

                //_ListRemore = _obj1.Product_Remote_ByCategoryId(CategoryId);
                _ListConcat = GetSHPCategoryProductLst.Concat(_ListRemore).ToList();

            }
            return _ListConcat;

        }

        private SHP_Product_Responsive ProductTemplateGet(SqlDataReader reader, int _productId, int _Fittizio)
        {

            SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();

            SHPProduct.ProdCategoParentalId = _Fittizio == 1
                ? reader.IsDBNull(reader.GetOrdinal("ParentCategoryID")) ? 0 : reader.GetInt32(reader.GetOrdinal("ParentCategoryID"))
                : reader.IsDBNull(reader.GetOrdinal("CategoryID")) ? 0 : reader.GetInt32(reader.GetOrdinal("CategoryID"));

            SHPProduct.Giacenza = 0;
            SHPProduct.Published = true;
            SHPProduct.Fittizio = _Fittizio;
            SHPProduct.ProductIdLocal = reader.GetInt32(reader.GetOrdinal("ProductId"));
            SHPProduct.ProductId = _productId;
            SHPProduct.BrandId = reader.GetInt32(reader.GetOrdinal("BrandId"));
            //SHPProduct.ProductId = SHPProduct.ProductIdLocal;
            //_ProdReturnObj.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
            SHPProduct.CategoryID = reader.IsDBNull(reader.GetOrdinal("CategoryID")) ? 0 : reader.GetInt32(reader.GetOrdinal("CategoryID"));

            //SHPProduct = reader.GetString(reader.GetOrdinal("ProductCod"));
            SHPProduct.ProductCod = reader.GetString(reader.GetOrdinal("ProductCod"));
            SHPProduct.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
            SHPProduct.ShortDescription = reader.GetValue(reader.GetOrdinal("ShortDescription")) == DBNull.Value
                ? "n.d."
                : reader.GetString(reader.GetOrdinal("ShortDescription"));
            SHPProduct.FullDescription = reader.GetValue(reader.GetOrdinal("FullDescription")) == DBNull.Value
                ? "n.d."
                : reader.GetString(reader.GetOrdinal("FullDescription"));
            SHPProduct.units = reader.GetValue(reader.GetOrdinal("units")) == DBNull.Value ? "Pz." : reader.GetString(reader.GetOrdinal("units"));
            SHPProduct.quantity = reader.GetInt32(reader.GetOrdinal("quantity"));
            if (_Fittizio == 1)
            {
                string ReTString = "{0}/{1}";
                string suffisso = PRT_FunzioniGenerali_23.GetSiteRoot();
                try
                {
                    SHPProduct.PictureUrl = string.Format(ReTString, suffisso, reader.GetString(reader.GetOrdinal("PictureUrl")));
                }
                catch
                {
                    SHPProduct.PictureUrl = string.Empty;
                }
                SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
            }
            else
            {
                try
                {
                    SHPProduct.PictureUrl = reader.GetString(reader.GetOrdinal("PathImmagine"));
                }
                catch
                {
                    SHPProduct.PictureUrl = string.Empty;
                }
            }


            SHPProduct.PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"));
            SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
            SHP_Product_Responsive Prodlocale = new SHP_Product_Responsive();

            SHPProduct = Prodlocale.PromoAndFixPriceGet(SHPProduct.ProductId, SHPProduct);



            SHPProduct.AttributesList = reader.IsDBNull(reader.GetOrdinal("AttributesList")) ? "n.d." : reader.GetString(reader.GetOrdinal("AttributesList"));

            ECOM_Giacenze_wish _GiacenzaObj = new ECOM_Giacenze_wish();
            SHPProduct.Giacenza = _GiacenzaObj.GiacenzaGet(SHPProduct.ProductId);
            return SHPProduct;
        }

        //Creata il 18/01/24 per la visualizzazione degli articoli, clonata e modificata da ProductsByCategoryID_COMM_Get
        private List<SHP_Product_Responsive> ProductsByCategoryID_COMM_GetArt(int CategoryId)
        {
            _ = new DataTable();
            List<SHP_Product_Responsive> GetSHPCategoryProductLst = new List<SHP_Product_Responsive>();
            Sql4Gestionale sql4Gestionale = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            List<SHP_Product_Responsive> _ListConcat = new List<SHP_Product_Responsive>();
            using (SqlDataReader reader = sql4Gestionale.ExecuteReader("U_COMM_Product_Local_ByCategoryId_GetArt", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
                    string _productId = reader["CodArt"] as string;

                    SHPProduct = SHPProduct.ProductTemplateGetArt(reader, _productId, 0);

                    GetSHPCategoryProductLst.Add(SHPProduct);
                }
                reader.Close();


                SHP_Product_Responsive _obj1 = new SHP_Product_Responsive();


                List<SHP_Product_Responsive> _ListRemore = new List<SHP_Product_Responsive>();

                //_ListRemore = _obj1.Product_Remote_ByCategoryId(CategoryId);
                _ListConcat = GetSHPCategoryProductLst.Concat(_ListRemore).ToList();

            }
            return _ListConcat;

        }
        private List<SHP_Product_Responsive> ProductsByCategoryID_COMM_GetArt_Inventario()
        {
            _ = new DataTable();
            List<SHP_Product_Responsive> GetSHPCategoryProductLst = new List<SHP_Product_Responsive>();
            Sql4Gestionale sql4Gestionale = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
            if (CodDep_cookie != null /*&& CodCLiDett_cookie != null*/)
            {
                objParams[0] = new SqlParameter("@CodDep", CodDep_cookie.Values["CodDep"].ToString());
            }
            List<SHP_Product_Responsive> _ListConcat = new List<SHP_Product_Responsive>();
            using (SqlDataReader reader = sql4Gestionale.ExecuteReader("U_COMM_Product_Local_ByCodDep_GetArt_Inventario", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
                    string _productId = reader["CodArt"] as string;

                    SHPProduct = SHPProduct.ProductTemplateGetArt(reader, _productId, 0);

                    GetSHPCategoryProductLst.Add(SHPProduct);
                }
                reader.Close();


                SHP_Product_Responsive _obj1 = new SHP_Product_Responsive();


                List<SHP_Product_Responsive> _ListRemore = new List<SHP_Product_Responsive>();

                //_ListRemore = _obj1.Product_Remote_ByCategoryId(CategoryId);
                _ListConcat = GetSHPCategoryProductLst.Concat(_ListRemore).ToList();

            }
            return _ListConcat;

        }

        //Creata il 18/01/24 per visualizzare gli articoli come prodotti
        private SHP_Product_Responsive ProductTemplateGetArt(SqlDataReader reader, string _productId, int _Fittizio)
        {

            SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();

            SHPProduct.ProdCategoParentalId = _Fittizio == 1
                ? reader.IsDBNull(reader.GetOrdinal("ParentCategoryID")) ? 0 : reader.GetInt32(reader.GetOrdinal("ParentCategoryID"))
                : reader.IsDBNull(reader.GetOrdinal("CategoryID")) ? 0 : reader.GetInt32(reader.GetOrdinal("CategoryID"));

            SHPProduct.Giacenza = 0;
            SHPProduct.Published = true;
            SHPProduct.Fittizio = _Fittizio;
            //SHPProduct.ProductIdLocal = reader.GetInt32(reader.GetOrdinal("ProductId"));
            SHPProduct.BrandId = 1;
            SHPProduct.CategoryID = reader.IsDBNull(reader.GetOrdinal("CategoryID")) ? 0 : reader.GetInt32(reader.GetOrdinal("CategoryID"));

            //SHPProduct = reader.GetString(reader.GetOrdinal("ProductCod"));
            SHPProduct.ProductCod = _productId;
            SHPProduct.DisplayName = _productId;
            SHPProduct.ShortDescription = reader.GetValue(reader.GetOrdinal("DisplayName")) == DBNull.Value
                ? "n.d."
                : reader.GetString(reader.GetOrdinal("DisplayName"));
            SHPProduct.FullDescription = reader.GetValue(reader.GetOrdinal("Descrizione")) == DBNull.Value
                ? "n.d."
                : reader.GetString(reader.GetOrdinal("Descrizione"));
            SHPProduct.units = reader.GetValue(reader.GetOrdinal("Misura")) == DBNull.Value ? "PZ" : reader.GetString(reader.GetOrdinal("Misura"));
            SHPProduct.quantity = 1;
            if (_Fittizio == 1)
            {
                string ReTString = "{0}/{1}";
                string suffisso = PRT_FunzioniGenerali_23.GetSiteRoot();
                try
                {
                    SHPProduct.PictureUrl = string.Format(ReTString, suffisso, reader.GetString(reader.GetOrdinal("PictureUrl")));
                }
                catch
                {
                    SHPProduct.PictureUrl = string.Empty;
                }
                SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
            }
            else
            {
                try
                {
                    SHPProduct.PictureUrl = reader.GetString(reader.GetOrdinal("PathImmagine"));
                }
                catch
                {
                    SHPProduct.PictureUrl = string.Empty;
                }
            }


            SHPProduct.PriceStart = 0;
            SHPProduct.Price = 0;
            SHP_Product_Responsive Prodlocale = new SHP_Product_Responsive();

            //SHPProduct = Prodlocale.PromoAndFixPriceGet(SHPProduct.ProductId, SHPProduct);



            SHPProduct.AttributesList = reader.IsDBNull(reader.GetOrdinal("Desc2")) ? "n.d." : reader.GetString(reader.GetOrdinal("Desc2"));

            //ECOM_Giacenze_wish _GiacenzaObj = new ECOM_Giacenze_wish();
            //SHPProduct.Giacenza = _GiacenzaObj.GiacenzaGet(SHPProduct.ProductId);
            return SHPProduct;
        }
        private bool SetProductPromoId(int ProductId, int PromoId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            objParams[1] = new SqlParameter("@PromoId", PromoId);
            try
            {
                _ = objSqlHelper.ExecuteNonQuery("COMM_UpdateProductPromoId", objParams);
                return true;
            }
            catch
            {
                return false;
            }
        }


        public DataTable AllProductPrezzoFissa_COMM_Get_DTB()
        {
            _ = new List<SHP_Product_Responsive>();
            List<SHP_Product_Responsive> SHPProductLst = AllProductPrezzoFissa_COMM_Get();
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }

        public DataTable AllProducts_COMM_Get_DTB()
        {
            _ = new List<SHP_Product_Responsive>();
            List<SHP_Product_Responsive> SHPProductLst = AllProducts_COMM_Get();
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }

        public DataTable AspiraAccessoriRicercaAvanzata_Remote_DTS(string txt, string model)
        {
            List<SHP_Product_Responsive> SHPProductLst = new List<SHP_Product_Responsive>();
            //SHPProductLst = AspiraAccessoriRicercaAvanzata_Remote(txt, model);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        public bool DeleteProductPromo(int ProductId, int PromoId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@PromoId", PromoId);

            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_DeleteProductPromo", objParams);
                _ = SetProductPromoId(ProductId, 0);
                return true;
            }
            catch
            {
                return false;
            }
        }
        public int ProdId_LOCAL_by_ProdId_ReomoteGET(int _ProductID_Remote)
        {
            _ = new SqlCommand();
            int ProdIDVar = 0;
            using (SqlConnection connection = new SqlConnection(PLS_SHPSql4Helper.Getinfo4StringConnection()))
            {
                //controllo se esiste in locale il prodotto e se non esiste lo creo
                COMM_ProductRemoteCreateInLocal(_ProductID_Remote);
                using (SqlCommand cmd = new SqlCommand("SELECT [ProductId] FROM [SHP_Product] WHERE fittizio = 0 and [ProductId] = " + _ProductID_Remote, connection))
                {
                    connection.Open();
                    ProdIDVar = (int)cmd.ExecuteScalar();
                }
            }
            return ProdIDVar;
        }
        public int ProdId_Reomote_by_ProdId_LOCALGET(int _ProductIDLocal)
        {
            _ = new SqlCommand();
            int ProdIDVar = 0;
            if (_ProductIDLocal > 0)
            {
                using (SqlConnection connection = new SqlConnection(PLS_SHPSql4Helper.Getinfo4StringConnection()))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT [ProductID] as ProductIdLocal FROM [SHP_Product] WHERE fittizio = 0 and [ProductId] = " + _ProductIDLocal, connection))
                    {
                        connection.Open();
                        ProdIDVar = (int)cmd.ExecuteScalar();
                    }
                }
            }
            return ProdIDVar;
        }

        /// PROMOZIONI GET 
        /// 
        public DataTable ProdottiInPromo_DTS()
        {
            _ = new List<SHP_Product_Responsive>();
            List<SHP_Product_Responsive> SHPProductLst = ProdottiInPromo_LIST();
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        public SHP_Product_Responsive ProdottoDettGet(int _productId)
        {
            _ = new SHP_Product_Responsive();
            //if (SHPProduct.ProductGetIfFittizio(_productId) == 1)
            //{
            //    // prodotto Fittizio 
            //    SHPProduct = ProdottoFittizioGet(_productId);
            //}
            //else
            //{
            // prodotto Remoto
            SHP_Product_Responsive SHPProduct = ProdottoReomotoGet(_productId);
            //}


            return SHPProduct;
        }
        public DataTable ProdottoDettGetdDT(int ProductId)
        {
            // datatable dettaglio prodotto
            List<SHP_Product_Responsive> SHPProductLst = new List<SHP_Product_Responsive>
            {
                ProdottoDettGet(ProductId)
            };
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        public SHP_Product_Responsive ProdottoFittizioGet(int _productId)
        {
            SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
            using (SqlConnection connection = new SqlConnection(PLS_SHPSql4Helper.Getinfo4StringConnection()))
            {
                PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@ProductId", _productId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("COMM_Product_Local_ByProductId_Get", objParams))
                {
                    while (reader.Read())
                    {
                        SHPProduct = SHPProduct.ProductTemplateGet(reader, _productId, 1);
                    }
                    reader.Close();
                }
            }

            return SHPProduct;
        }
        public DataTable ProdottoFittizioGetdDT(int ProductId)
        {
            List<SHP_Product_Responsive> SHPProductLst = new List<SHP_Product_Responsive>
            {
                ProdottoFittizioGet(ProductId)
            };
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        public SHP_Product_Responsive ProdottoReomotoGet(int _productId)
        {
            SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
            //int _productIdRemote = ProdId_Reomote_by_ProdId_LOCALGET(_productId);
            int _productIdRemote = ProdId_Reomote_by_ProdId_LOCALGET(_productId);
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", _productIdRemote);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductById_Top1", objParams))
            {
                while (reader.Read())
                {
                    if (reader.GetBoolean(reader.GetOrdinal("Published")))
                    {
                        SHPProduct = SHPProduct.ProductTemplateGet(reader, _productId, 0);
                        SHPProduct.BrandId = 1;
                    }
                }
                reader.Close();
            }

            return SHPProduct;
        }
        public DataTable ProdottoReomotoGetdDT(int ProductId)
        {
            List<SHP_Product_Responsive> SHPProductLst = new List<SHP_Product_Responsive>
            {
                ProdottoReomotoGet(ProductId)
            };
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        public int ProductGetIfFittizio(int _ProductID)
        {
            _ = new SqlCommand();
            int fittizio = 0;
            using (SqlConnection connection = new SqlConnection(PLS_SHPSql4Helper.Getinfo4StringConnection()))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT [fittizio] FROM [SHP_Product] WHERE ProductId = " + _ProductID, connection))
                {
                    connection.Open();
                    fittizio = (int)cmd.ExecuteScalar();
                }
            }
            return fittizio;
        }
        public DataTable ProductsByCategoryID_COMM_Get_DTB(int CategoryId)
        {
            _ = new List<SHP_Product_Responsive>();
            List<SHP_Product_Responsive> SHPProductLst = ProductsByCategoryID_COMM_GetArt(CategoryId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        public DataTable ProductsByCategoryID_COMM_Get_DTB_Inventario()
        {
            _ = new List<SHP_Product_Responsive>();
            List<SHP_Product_Responsive> SHPProductLst = ProductsByCategoryID_COMM_GetArt_Inventario();
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        public SHP_Product_Responsive PromoAndFixPriceGet(int ProductId, SHP_Product_Responsive _SHP_Product_Responsive)
        {
            _ = new DataTable();
            _ = new List<SHP_Product_Responsive>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("COMM_PromoGet", objParams))
            {
                if (reader.HasRows) // controllo se è pieno 
                {
                    while (reader.Read())
                    {
                        _SHP_Product_Responsive.ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"));
                        if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                        {
                            _SHP_Product_Responsive.PromoPrice = 0;
                            _SHP_Product_Responsive.PromoStatus = false;
                            _SHP_Product_Responsive.PromoStatusDB = false;
                            _SHP_Product_Responsive.PromoId = 0;
                        }
                        else
                        {
                            _SHP_Product_Responsive.PromoId = reader.GetInt32(reader.GetOrdinal("PromoId"));
                            _SHP_Product_Responsive.PromoStatusDB = true;
                            DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                            DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                            DateTime DNow = DateTime.Now;
                            if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                            {
                                _SHP_Product_Responsive.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                                _SHP_Product_Responsive.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                                _SHP_Product_Responsive.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                                _SHP_Product_Responsive.PromoStatus = true;
                            }
                            else
                            {
                                _SHP_Product_Responsive.PromoPrice = 0;
                                _SHP_Product_Responsive.PromoStatus = false;
                            }


                        }
                        //SHPProduct.PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"));


                        if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                        {
                            //SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                            _SHP_Product_Responsive.PriceFixed = 0;
                        }
                        else
                        {
                            _SHP_Product_Responsive.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                            _SHP_Product_Responsive.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        }


                        //if (string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList"))))
                        //{
                        //    SHPProduct.AttributesList = "n.d.";
                        //}
                        //else
                        //{
                        //    SHPProduct.AttributesList = reader.GetString(reader.GetOrdinal("AttributesList"));
                        //}
                        //LocalList.Add(SHPProduct);
                    }
                    reader.Close();
                }
                //CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
            }
            //}
            return _SHP_Product_Responsive;
        }

        public bool SetPriceFixed(int ProductId, decimal PriceFixed)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            objParams[1] = new SqlParameter("@PriceFixed", PriceFixed);
            try
            {
                _ = objSqlHelper.ExecuteNonQuery("COMM_SetPriceFixed", objParams);
                return true;
            }
            catch
            {
                return false;
            }
        }
        public int SetProductPromo(int ProductId, DateTime StartDate, DateTime StopDate, decimal PromoPrice)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[4];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            objParams[1] = new SqlParameter("@StartDate", StartDate);
            objParams[2] = new SqlParameter("@StopDate", StopDate);
            objParams[3] = new SqlParameter("@PromoPrice", PromoPrice);
            try
            {
                int PromoId = objSqlHelper.ExecuteScalarReturnId("SHP_InsertProductPromo", objParams);
                _ = SetProductPromoId(ProductId, PromoId);
                return PromoId;

            }
            catch
            {
                return 0;
            }
        }
        public bool UpdateProductPromo(int PromoId, DateTime StartDate, DateTime StopDate, decimal PromoPrice)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[4];
            objParams[0] = new SqlParameter("@PromoId", PromoId);
            objParams[1] = new SqlParameter("@StartDate", StartDate);
            objParams[2] = new SqlParameter("@StopDate", StopDate);
            objParams[3] = new SqlParameter("@PromoPrice", PromoPrice);
            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_UpdateProductPromo", objParams);

                return true;
            }
            catch
            {
                return false;
            }
        }

        // 2021 Simone Nuove procedure di filtro e ricerca 

        public DataTable AllProducts_COMM_Get_DTB_FilterTags(string FilterTags)
        {
            _ = new List<SHP_Product_Responsive>();
            List<SHP_Product_Responsive> SHPProductLst = AllProducts_COMM_Get_DTB_FilterTags_List(FilterTags);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }
        private List<SHP_Product_Responsive> AllProducts_COMM_Get_DTB_FilterTags_List(string FilterTags)
        {
            _ = new DataTable();

            List<SHP_Product_Responsive> LocalList = new List<SHP_Product_Responsive>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            _ = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);

            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@Filter", FilterTags);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductFilter", objParams))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        _ = new SHP_Product_Responsive();
                        SHP_Product_Responsive SHPProduct = ProductTemplateGet(reader, reader.GetInt32(reader.GetOrdinal("ProductId")), 0);

                        SHPProduct.tags = SHPProduct.ProductCod + " " + SHPProduct.DisplayName + " " + SHPProduct.ShortDescription + " " + SHPProduct.FullDescription + " " + SHPProduct.AttributesList + " "/* + SHPProduct.brandname*/;


                        SHPProduct.tags = reader.GetOrdinal("Tags").ToString();

                        LocalList.Add(SHPProduct);
                    }
                }
                reader.Close();

            }
            return LocalList;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);

        }


        #region Property
        public int ProductId { get; set; }
        public int CategoryID { get; set; }
        public string ProductCod { get; set; }
        public string DisplayName { get; set; }
        public string NameRw { get; set; }
        public string ShortDescription { get; set; }
        public string FullDescription { get; set; }
        public string units { get; set; }
        public int quantity { get; set; }
        public decimal Price { get; set; }
        public string AttributesList { get; set; }
        public string PictureUrl { get; set; }
        public decimal PriceFixed { get; set; }
        public DateTime PromoStartDate { get; set; }
        public DateTime PromoStopDate { get; set; }
        public decimal PromoPrice { get; set; }
        public bool PromoStatus { get; set; }
        public bool PromoStatusDB { get; set; }
        public decimal PriceStart { get; set; }
        public int PromoId { get; set; }
        public bool Published { get; set; }
        public int ProdCategoParentalId { get; set; }
        public int ProductIdLocal { get; set; }
        public int BrandId { get; set; }
        public int Giacenza { get; set; }
        public int Fittizio { get; set; }
        public string tags { get; set; }

        #endregion

    }
}