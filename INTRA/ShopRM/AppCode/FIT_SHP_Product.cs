using INTRA.AppCode;
using INTRA.AppCode.Portal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class FIT_SHP_Product
    {


        public FIT_SHP_Product()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }

        private List<FIT_SHP_Product> GetSHPProductByProductIdLocalTop1(int ProductId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<FIT_SHP_Product> LocalList = new List<FIT_SHP_Product>();

            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_CAT_GetSHPProductById_Top1", objParams))
            {
                while (reader.Read())
                {
                    FIT_SHP_Product SHPProduct = new FIT_SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                        //SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                        ProductCod = reader.GetString(reader.GetOrdinal("ProductCod")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        BrandId = reader.GetInt32(reader.GetOrdinal("BrandId")),
                        ShortDescription = reader.GetValue(reader.GetOrdinal("ShortDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("ShortDescription")),
                        FullDescription = reader.GetValue(reader.GetOrdinal("FullDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("FullDescription")),
                        units = reader.GetValue(reader.GetOrdinal("units")) == DBNull.Value ? "Pz." : reader.GetString(reader.GetOrdinal("units")),
                        quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                        PictureUrl = System.Web.HttpContext.Current.Request.ApplicationPath.TrimEnd('/') +
                        "/" +
                        reader.GetString(reader.GetOrdinal("PictureUrl")),
                        //SHPProduct.PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"));
                        PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"))
                    };
                    FIT_SHP_Product Prodlocale = new FIT_SHP_Product();
                    _ = new List<FIT_SHP_Product>();
                    List<FIT_SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
                    if (ProdLocaleList[0].PromoPrice == 0)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                    }
                    else
                    {
                        SHPProduct.PromoStatusDB = true;
                        DateTime DStart = ProdLocaleList[0].PromoStartDate;
                        DateTime Dstop = ProdLocaleList[0].PromoStopDate;
                        DateTime DNow = DateTime.Now;
                        SHPProduct.PromoId = ProdLocaleList[0].PromoId;
                        if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        {
                            SHPProduct.PromoPrice = ProdLocaleList[0].PromoPrice;
                            SHPProduct.PromoStartDate = ProdLocaleList[0].PromoStartDate;
                            SHPProduct.PromoStopDate = ProdLocaleList[0].PromoStopDate;
                            SHPProduct.PromoStatus = true;
                        }
                        else
                        {
                            SHPProduct.PromoPrice = 0;
                            SHPProduct.PromoStartDate = DateTime.Today.Date;
                            SHPProduct.PromoStopDate = DateTime.Today.Date;
                            SHPProduct.PromoStatus = false;
                        }
                    }

                    if (ProdLocaleList[0].PriceFixed <= 0)
                    {
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                    }
                    else
                    {
                        SHPProduct.Price = ProdLocaleList[0].PriceFixed;
                        SHPProduct.PriceFixed = ProdLocaleList[0].PriceFixed;
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

        private List<FIT_SHP_Product> GetSHPProductInPromoLocal()
        {
            _ = new DataTable();
            string CacheTable = "CacheTShpProductInPromoCAT";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<FIT_SHP_Product> LocalList = new List<FIT_SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            SHPCategory catego = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromo_V2", objParams))
            {
                while (reader.Read())
                {
                    FIT_SHP_Product SHPProduct = new FIT_SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductIdLocal"))
                    };
                    // qui devo controllare se il prodotto è locale o remoto tramite il campo "fittizio"
                    SHP_Product ProdRemote = new SHP_Product();
                    _ = new List<SHP_Product>();
                    FIT_SHP_Product ProdLocal = new FIT_SHP_Product();
                    _ = new List<FIT_SHP_Product>();
                    if (SHPProduct.ControlFittizio(SHPProduct.ProductId))
                    {
                        //prodotto fittizio
                        //ProdRemoteList = ProdRemote.GetSHPProductByProductId(SHPProduct.ProductId);
                        List<FIT_SHP_Product> ProdLocalList = ProdLocal.GetSHPProductByProductIdLocal(SHPProduct.ProductId);


                        SHPProduct.CategoryID = ProdLocalList[0].CategoryID;
                        SHPProduct.BrandId = reader.GetInt32(reader.GetOrdinal("BrandId"));
                        SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(SHPProduct.CategoryID);
                        //SHPProduct.ProdCategoParentalId = 0;
                        SHPProduct.ProductCod = ProdLocalList[0].ProductCod;
                        SHPProduct.DisplayName = ProdLocalList[0].DisplayName;

                        SHPProduct.ShortDescription = ProdLocalList[0].ShortDescription;

                        SHPProduct.FullDescription = ProdLocalList[0].FullDescription;
                        ;
                        SHPProduct.units = ProdLocalList[0].units;
                        SHPProduct.quantity = ProdLocalList[0].quantity;
                        SHPProduct.PictureUrl = System.Web.HttpContext.Current.Request.ApplicationPath.TrimEnd('/') +
                            "/" +
                            ProdLocalList[0].PictureUrl;
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
                        SHPProduct.PriceStart = ProdLocalList[0].PriceStart;


                        if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                        {
                            SHPProduct.Price = ProdLocalList[0].Price;
                            SHPProduct.PriceFixed = 0;
                        }
                        else
                        {
                            SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                            SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        }


                        SHPProduct.AttributesList = ProdLocalList[0].AttributesList;

                        LocalList.Add(SHPProduct);
                    }
                    else
                    {
                        // prodotto non fittizio
                        List<SHP_Product> ProdRemoteList = ProdRemote.GetSHPProductByProductId(SHPProduct.ProductId);
                        SHPProduct.CategoryID = ProdRemoteList[0].CategoryID;
                        SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(SHPProduct.CategoryID);
                        SHPProduct.ProductCod = ProdRemoteList[0].ProductCod;
                        SHPProduct.DisplayName = ProdRemoteList[0].DisplayName;

                        SHPProduct.ShortDescription = ProdRemoteList[0].ShortDescription;

                        SHPProduct.FullDescription = ProdRemoteList[0].FullDescription;
                        ;
                        SHPProduct.units = ProdRemoteList[0].units;
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
                            SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                            SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        }


                        SHPProduct.AttributesList = ProdRemoteList[0].AttributesList;

                        LocalList.Add(SHPProduct);
                    }
                }
                reader.Close();
                CacheHelper_23.Insert(CacheTable, LocalList);
            }
            return LocalList;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
        }

        public bool ControlFittizio(int ProductId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            int fittizio = objSqlHelper.ExecuteNonQueryReturnValue("SHP_CAT_ControlFittizio", objParams);
            return Convert.ToBoolean(fittizio);
        }

        public bool DeleteProduct(int ProductId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);

            try
            {
                _ = objSqlHelper.ExecuteNonQuery("SHP_DeleteProduct", objParams);

                return true;
            }
            catch
            {
                return false;
            }
        }

        public DataTable GetSHPProductByIdDT(int ProductId)
        {
            _ = new List<FIT_SHP_Product>();
            List<FIT_SHP_Product> SHPProductLst = GetSHPProductByProductIdLocal(ProductId);
            DataTable table = CollectionHelper.ConvertTo<FIT_SHP_Product>(SHPProductLst);
            return table;
        }

        public DataTable GetSHPProductByIdDTTop1(int ProductId)
        {
            _ = new DataTable();
            _ = new List<FIT_SHP_Product>();
            List<FIT_SHP_Product> SHPProductLst = GetSHPProductByProductIdLocalTop1(ProductId);
            DataTable table = CollectionHelper.ConvertTo<FIT_SHP_Product>(SHPProductLst);
            return table;
        }

        public List<FIT_SHP_Product> GetSHPProductByProductIdLocal(int ProductId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<FIT_SHP_Product> LocalList = new List<FIT_SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_CAT_GetSHPProductByIdAndCatego", objParams))
            {
                while (reader.Read())
                {
                    FIT_SHP_Product SHPProduct = new FIT_SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                        BrandId = reader.GetInt32(reader.GetOrdinal("BrandId")),
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"))
                    };
                    SHPCategory catego = new SHPCategory();
                    SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(SHPProduct.CategoryID);

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
                    SHPProduct.PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"));
                    SHPProduct.PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"));
                    FIT_SHP_Product Prodlocale = new FIT_SHP_Product();
                    _ = new List<FIT_SHP_Product>();
                    List<FIT_SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
                    if (ProdLocaleList[0].PromoPrice == 0)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                    }
                    else
                    {
                        SHPProduct.PromoStatusDB = true;
                        DateTime DStart = ProdLocaleList[0].PromoStartDate;
                        DateTime Dstop = ProdLocaleList[0].PromoStopDate;
                        DateTime DNow = DateTime.Now;
                        SHPProduct.PromoId = ProdLocaleList[0].PromoId;
                        if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        {
                            SHPProduct.PromoPrice = ProdLocaleList[0].PromoPrice;
                            SHPProduct.PromoStartDate = ProdLocaleList[0].PromoStartDate;
                            SHPProduct.PromoStopDate = ProdLocaleList[0].PromoStopDate;
                            SHPProduct.PromoStatus = true;
                        }
                        else
                        {
                            SHPProduct.PromoPrice = 0;
                            SHPProduct.PromoStartDate = DateTime.Today.Date;
                            SHPProduct.PromoStopDate = DateTime.Today.Date;
                            SHPProduct.PromoStatus = false;
                        }
                    }

                    if (ProdLocaleList[0].PriceFixed <= 0)
                    {
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                    }
                    else
                    {
                        SHPProduct.Price = ProdLocaleList[0].PriceFixed;
                        SHPProduct.PriceFixed = ProdLocaleList[0].PriceFixed;
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

        public List<FIT_SHP_Product> GetSHPProductByProductIdLocalAndCatego(int ProductId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<FIT_SHP_Product> LocalList = new List<FIT_SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_CAT_GetSHPProductByIdAndCatego", objParams))
            {
                while (reader.Read())
                {
                    FIT_SHP_Product SHPProduct = new FIT_SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        ProductCod = reader.GetString(reader.GetOrdinal("ProductCod")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        BrandId = reader.GetInt32(reader.GetOrdinal("BrandId")),
                        ShortDescription = reader.GetValue(reader.GetOrdinal("ShortDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("ShortDescription")),
                        FullDescription = reader.GetValue(reader.GetOrdinal("FullDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("FullDescription")),
                        units = reader.GetValue(reader.GetOrdinal("units")) == DBNull.Value ? "Pz." : reader.GetString(reader.GetOrdinal("units")),
                        quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                        PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl")),
                        PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"))
                    };
                    FIT_SHP_Product Prodlocale = new FIT_SHP_Product();
                    _ = new List<FIT_SHP_Product>();
                    List<FIT_SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
                    if (ProdLocaleList[0].PromoPrice == 0)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                    }
                    else
                    {
                        SHPProduct.PromoStatusDB = true;
                        DateTime DStart = ProdLocaleList[0].PromoStartDate;
                        DateTime Dstop = ProdLocaleList[0].PromoStopDate;
                        DateTime DNow = DateTime.Now;
                        SHPProduct.PromoId = ProdLocaleList[0].PromoId;
                        if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        {
                            SHPProduct.PromoPrice = ProdLocaleList[0].PromoPrice;
                            SHPProduct.PromoStartDate = ProdLocaleList[0].PromoStartDate;
                            SHPProduct.PromoStopDate = ProdLocaleList[0].PromoStopDate;
                            SHPProduct.PromoStatus = true;
                        }
                        else
                        {
                            SHPProduct.PromoPrice = 0;
                            SHPProduct.PromoStartDate = DateTime.Today.Date;
                            SHPProduct.PromoStopDate = DateTime.Today.Date;
                            SHPProduct.PromoStatus = false;
                        }
                    }

                    if (ProdLocaleList[0].PriceFixed <= 0)
                    {
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                    }
                    else
                    {
                        SHPProduct.Price = ProdLocaleList[0].PriceFixed;
                        SHPProduct.PriceFixed = ProdLocaleList[0].PriceFixed;
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

        public List<FIT_SHP_Product> GetSHPProductByProductIdLocale(int ProductId)
        // pesco i dati della promo se c'è
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<FIT_SHP_Product> LocalList = new List<FIT_SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetProductLocal", objParams))
            {
                while (reader.Read())
                {
                    FIT_SHP_Product SHPProduct = new FIT_SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductIdLocal"))
                    };
                    //SHPProduct.BrandId = reader.GetInt32(reader.GetOrdinal("BrandId"));
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

        public bool GetSHPProductInCategoryCat(int ProductId, int CategoryID)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductID", ProductId);
            objParams[1] = new SqlParameter("@CategoryID", CategoryID);
            return Convert.ToBoolean(
                objSqlHelper.ExecuteNonQueryReturnValue("SHP_CAT_GetSHPProductInCategory", objParams));
        }

        public DataTable GetSHPProductInPromoDT()
        {
            _ = new List<FIT_SHP_Product>();
            List<FIT_SHP_Product> SHPProductLst = GetSHPProductInPromoLocal();
            DataTable table = CollectionHelper.ConvertTo<FIT_SHP_Product>(SHPProductLst);
            return table;
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


        public int BrandId { get; set; }
        #endregion
    }
}