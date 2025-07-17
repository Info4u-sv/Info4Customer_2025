using INTRA.AppCode;
using INTRA.AppCode.Portal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class SHP_Product_SuperAdmin
    {
        public SHP_Product_SuperAdmin()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
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
        public int BrandId { get; set; }
        #endregion




        public int UpdateAllProductPrice(SHP_Product_SuperAdmin product)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            try
            {
                return objSqlHelper.ExecuteScalarReturnId("SHP_UpdateAllProductPrice", objParams);
            }
            catch
            {
                return -1;
            }
        }

        private List<SHP_Product> GetSHPProductInPromoByIdCategoLocal(int CategoryId)
        {
            _ = new DataTable();
            string CacheTable = "CacheTShpProductInPromo";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);

            List<SHP_Product> GetSHPCategoryProductLst = new List<SHP_Product>();
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromoByIdCatego", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        ProductCod = reader.GetString(reader.GetOrdinal("ProductCod")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        ShortDescription = reader.GetValue(reader.GetOrdinal("ShortDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("ShortDescription")),
                        FullDescription = reader.GetValue(reader.GetOrdinal("FullDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("FullDescription")),
                        quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                        PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"))
                    };
                    if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                    }
                    else
                    {
                        DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                        DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                        DateTime DNow = DateTime.Now;
                        if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        {
                            SHPProduct.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                            SHPProduct.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                            SHPProduct.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                            SHPProduct.PromoStatus = true;
                        }
                        else
                        {
                            SHPProduct.PromoPrice = 0;
                            SHPProduct.PromoStatus = false;
                        }


                    }

                    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0
                        ? reader.GetDecimal(reader.GetOrdinal("Price"))
                        : reader.GetDecimal(reader.GetOrdinal("PriceFixed"));

                    SHPProduct.AttributesList = string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList")))
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("AttributesList"));
                    GetSHPCategoryProductLst.Add(SHPProduct);
                }
                reader.Close();
                CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
            }
            return GetSHPCategoryProductLst;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
        }

        public List<SHP_Product> GetSHPProductByProductIdLocale(int ProductId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetProductLocal", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductIdLocal"))
                    };

                    if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                        SHPProduct.PromoStatusDB = false;
                        SHPProduct.PromoId = 0;
                    }
                    else
                    {
                        SHPProduct.PromoId = reader.GetInt32(reader.GetOrdinal("PromoId"));
                        SHPProduct.PromoStatusDB = true;
                        DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                        DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                        DateTime DNow = DateTime.Now;
                        if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        {
                            SHPProduct.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                            SHPProduct.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                            SHPProduct.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                            SHPProduct.PromoStatus = true;
                        }
                        else
                        {
                            SHPProduct.PromoPrice = 0;
                            SHPProduct.PromoStatus = false;
                        }


                    }
                    //SHPProduct.PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"));


                    if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                    {
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        SHPProduct.PriceFixed = 0;
                    }
                    else
                    {
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                    }

                    //if (string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList"))))
                    //{
                    //    SHPProduct.AttributesList = "n.d.";
                    //}
                    //else
                    //{
                    //    SHPProduct.AttributesList = reader.GetString(reader.GetOrdinal("AttributesList"));
                    //}
                    LocalList.Add(SHPProduct);
                }
                reader.Close();
                //CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
            }
            //}
            return LocalList;
        }
        public List<SHP_Product> GetSHPProductByProductId(int ProductId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductById_V2", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        ProductCod = reader.GetString(reader.GetOrdinal("ProductCod")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        ShortDescription = reader.GetValue(reader.GetOrdinal("ShortDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("ShortDescription")),
                        FullDescription = reader.GetValue(reader.GetOrdinal("FullDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("FullDescription")),
                        quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                        PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl")),
                        PriceStart = reader.GetDecimal(reader.GetOrdinal("Price")),
                        Price = reader.GetDecimal(reader.GetOrdinal("Price")),
                        AttributesList = string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList")))
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("AttributesList"))
                    };
                    LocalList.Add(SHPProduct);
                }
                reader.Close();
                //CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
            }
            //}
            return LocalList;
        }
        private List<SHP_Product> GetSHPProductSearchLocal(string txt, string model)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@r1", txt);
            objParams[1] = new SqlParameter("@r2", model);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductSearch", objParams))
            {

                while (reader.Read())
                {
                    INTRA.ShopRM.AppCode.SHP_Product SHPProduct = new INTRA.ShopRM.AppCode.SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        ProductCod = reader.GetString(reader.GetOrdinal("ProductCod")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        ShortDescription = reader.GetValue(reader.GetOrdinal("ShortDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("ShortDescription")),
                        FullDescription = reader.GetValue(reader.GetOrdinal("FullDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("FullDescription")),
                        quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                        PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"))
                    };
                    if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                        SHPProduct.PromoStatusDB = false;
                        SHPProduct.PromoId = 0;
                    }
                    else
                    {
                        SHPProduct.PromoId = reader.GetInt32(reader.GetOrdinal("PromoId"));
                        SHPProduct.PromoStatusDB = true;
                        DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                        DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                        DateTime DNow = DateTime.Now;
                        if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        {
                            SHPProduct.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                            SHPProduct.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                            SHPProduct.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                            SHPProduct.PromoStatus = true;
                        }
                        else
                        {
                            SHPProduct.PromoPrice = 0;
                            SHPProduct.PromoStatus = false;
                        }


                    }
                    SHPProduct.PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"));


                    if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                    {
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                        SHPProduct.PriceFixed = 0;
                    }
                    else
                    {
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                    }

                    SHPProduct.AttributesList = string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList")))
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("AttributesList"));
                    LocalList.Add(SHPProduct);
                }
                reader.Close();
                //CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
            }
            //}
            return LocalList;
        }

        public DataTable GetProducInPromotByCategoryIdDT(int CategoryId)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductInPromoByIdCategoLocal(CategoryId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }

        public DataTable GetSHpProductSearch(string txt, string modelType)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductSearchLocal(txt, modelType);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }


        public List<SHP_Product> GetSHPProductByCategoryId(int CategoryId)
        {
            DataTable dt = new DataTable();
            string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                List<SHP_Product> GetSHPCategoryProductLst = new List<SHP_Product>();
                SHPSql4Helper objSqlHelper = new SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductByCategoryId", objParams))
                {
                    dt.Load(reader);
                    while (reader.Read())
                    {
                        SHP_Product SHPProduct = new SHP_Product
                        {
                            ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            ProductCod = reader.GetString(reader.GetOrdinal("ProductCod")),
                            DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                            //SHPProduct.NameRw = reader.GetString(reader.GetOrdinal("NameRW"));
                            ShortDescription = reader.GetString(reader.GetOrdinal("ShortDescription")),
                            FullDescription = reader.GetString(reader.GetOrdinal("FullDescription")),
                            quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                            PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl")),
                            Price = reader.GetDecimal(reader.GetOrdinal("Price")),
                            AttributesList = string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList")))
                            ? "n.d."
                            : reader.GetString(reader.GetOrdinal("AttributesList"))
                        };
                        GetSHPCategoryProductLst.Add(SHPProduct);
                    }
                    reader.Close();


                    //CollectionHelper.ConvertTo
                    CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
        }
        public bool GetSHPProductInCategoryLocal(int ProductId, int CategoryID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductID", ProductId);
            objParams[1] = new SqlParameter("@CategoryID", CategoryID);
            return Convert.ToBoolean(objSqlHelper.ExecuteNonQueryReturnValue("PLS_SHP_GetSHPProductInCategory", objParams));

        }
        public bool GetSHPProductInCategory(int ProductId, int CategoryID)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductID", ProductId);
            objParams[1] = new SqlParameter("@CategoryID", CategoryID);
            return Convert.ToBoolean(objSqlHelper.ExecuteNonQueryReturnValue("SHP_GetSHPProductInCategory", objParams));

        }
        public DataTable GetSHPProductCategoryDT(int ProductId)
        {
            DataTable dt = new DataTable();
            _ = new List<SHP_Product>();
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductID", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductCategory", objParams))
            {
                dt.Load(reader);
            }
            return dt;
        }

        public DataTable GetSHPProductByCategoryIdDT(int CategoryId)
        {

            DataTable dt = new DataTable();
            string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);

            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                _ = new List<SHP_Product>();
                SHPSql4Helper objSqlHelper = new SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductByCategoryId", objParams))
                {
                    dt.Load(reader);

                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return dt;
        }
        public DataTable GetSHPProductByCategoryDT(int CategoryId)
        {
            DataTable dt = new DataTable();
            string CacheTable = "CacheTShpProductByCategory" + Convert.ToString(CategoryId);
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                _ = new List<SHP_Product>();
                SHPSql4Helper objSqlHelper = new SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[0];
                //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductByCategory", objParams))
                {
                    dt.Load(reader);

                    CacheHelper_23.Insert(CacheTable, dt);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.RetrieveDT(CacheTable);
        }
        public bool SetPriceFixed(int ProductId, decimal PriceFixed)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            objParams[1] = new SqlParameter("@PriceFixed", PriceFixed);
            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_SetPriceFixed_V2", objParams);
                return true;
            }
            catch
            {
                return false;
            }
        }
        private bool SetProductPromoId(int ProductId, int PromoId)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            objParams[1] = new SqlParameter("@PromoId", PromoId);
            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_UpdateProductPromoId_V2", objParams);
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool SetSlideShowPromoId(int SlideID, int PromoId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@SlideID", SlideID);
            objParams[1] = new SqlParameter("@PromoId", PromoId);
            try
            {
                _ = objSqlHelper.ExecuteNonQuery("PRT_UpdateSlideShowPromoId", objParams);
                return true;
            }
            catch
            {
                return false;
            }
        }
        public int GetSlideIDbyPromoId(int PromoId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@PromoId", PromoId);
            try
            {

                return objSqlHelper.ExecuteNonQueryForNews("PRT_GetSlideIDbyPromoId", objParams);
            }
            catch
            {
                return -1;
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
        public int InsertProduct(SHP_Product_SuperAdmin product)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[11];

            objParams[0] = new SqlParameter("@DisplayName", product.DisplayName);
            objParams[1] = new SqlParameter("@ProductCod", product.ProductCod);
            objParams[2] = new SqlParameter("@ShortDescription", product.ShortDescription);
            objParams[3] = new SqlParameter("@FullDescription", product.FullDescription);
            objParams[4] = new SqlParameter("@units", product.units);
            objParams[5] = new SqlParameter("@quantity", product.quantity);
            objParams[6] = new SqlParameter("@Price", product.Price);
            objParams[7] = new SqlParameter("@AttributesList", product.AttributesList);
            objParams[8] = new SqlParameter("@Published", product.Published);
            objParams[9] = new SqlParameter("@BrandId", product.BrandId);
            objParams[10] = new SqlParameter("@NameRw", product.NameRw);


            try
            {
                return objSqlHelper.ExecuteScalarReturnId("SHP_InsertProduct_Admin", objParams);


            }
            catch
            {
                return -1;
            }
        }
        public bool UpdateProduct(SHP_Product_SuperAdmin product)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[11];

            objParams[0] = new SqlParameter("@ProductId", product.ProductId);
            objParams[1] = new SqlParameter("@ProductCod", product.ProductCod);
            objParams[2] = new SqlParameter("@ShortDescription", product.ShortDescription);
            objParams[3] = new SqlParameter("@FullDescription", product.FullDescription);
            objParams[4] = new SqlParameter("@units", product.units);
            objParams[5] = new SqlParameter("@quantity", product.quantity);
            objParams[6] = new SqlParameter("@Price", product.Price);
            objParams[7] = new SqlParameter("@AttributesList", product.AttributesList);
            objParams[8] = new SqlParameter("@Published", product.Published);
            objParams[9] = new SqlParameter("@DisplayName", product.DisplayName);
            objParams[10] = new SqlParameter("@BrandId", product.BrandId);


            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_UpdateProduct_Admin", objParams);

                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool AzzeraCategorieProdotto(int ProductId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];

            objParams[0] = new SqlParameter("@ProductId", ProductId);



            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_AzzeraCategorieProdotto_Admin", objParams);

                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool AssociaCategorieProdotto(int ProductId, int CategoryID)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];

            objParams[0] = new SqlParameter("@ProductId", ProductId);
            objParams[1] = new SqlParameter("@CategoryID", CategoryID);



            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_AssociaCategorieProdotto_Admin", objParams);

                return true;
            }
            catch
            {
                return false;
            }
        }
        public DataTable GetSHPProductInPromoDT()
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductInPromoLocal();
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }
        private List<SHP_Product> GetSHPProductInPromoLocal()
        {
            _ = new DataTable();
            string CacheTable = "CacheTShpProductInPromo";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromo_V2", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductIdLocal"))
                    };
                    SHP_Product ProdRemote = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdRemoteList = ProdRemote.GetSHPProductByProductId(SHPProduct.ProductId);



                    SHPProduct.CategoryID = ProdRemoteList[0].CategoryID;
                    SHPProduct.ProductCod = ProdRemoteList[0].ProductCod;
                    SHPProduct.DisplayName = ProdRemoteList[0].DisplayName;

                    SHPProduct.ShortDescription = ProdRemoteList[0].ShortDescription;

                    SHPProduct.FullDescription = ProdRemoteList[0].FullDescription; ;

                    SHPProduct.quantity = ProdRemoteList[0].quantity;
                    SHPProduct.PictureUrl = ProdRemoteList[0].PictureUrl;
                    if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                        SHPProduct.PromoStatusDB = false;
                        SHPProduct.PromoId = 0;
                    }
                    else
                    {
                        SHPProduct.PromoId = reader.GetInt32(reader.GetOrdinal("PromoId"));
                        SHPProduct.PromoStatusDB = true;
                        DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                        DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                        DateTime DNow = DateTime.Now;
                        if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        {
                            SHPProduct.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                            SHPProduct.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                            SHPProduct.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                            SHPProduct.PromoStatus = true;
                        }
                        else
                        {
                            SHPProduct.PromoPrice = 0;
                            SHPProduct.PromoStatus = false;
                        }


                    }
                    SHPProduct.PriceStart = ProdRemoteList[0].Price;


                    if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                    {
                        SHPProduct.Price = ProdRemoteList[0].Price;
                        SHPProduct.PriceFixed = 0;
                    }
                    else
                    {
                        SHPProduct.Price = ProdRemoteList[0].Price;
                        SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                    }


                    SHPProduct.AttributesList = ProdRemoteList[0].AttributesList;

                    LocalList.Add(SHPProduct);
                }
                reader.Close();
                CacheHelper_23.Insert(CacheTable, LocalList);
            }
            return LocalList;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
        }
    }
}