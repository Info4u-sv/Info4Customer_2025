using INTRA.AppCode;

using INTRA.AppCode.Portal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class SHP_Product
    {
        public SHP_Product()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }

        private int GetIDLocale(int IDRemoto)
        {
            string SqlString = "Select  ProductID from  SHP_Product_Local  WHERE (productidlocal = " + IDRemoto + ")";
            int ProductID = 0;
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
                        ProductID = Convert.ToInt32(myReader["ProductID"].ToString());
                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            return ProductID;
        }
        private List<SHP_Product> GetProductsBySubCatMacroCatBrandIdMiele(int CategoryId, int MacroCatego, int BrandId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> GetSHPCategoryProductLst = new List<SHP_Product>();
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            objParams[1] = new SqlParameter("@MacroCatego", MacroCatego);
            objParams[2] = new SqlParameter("@BrandId", BrandId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetProductsBySubCatMacroCatBrandId", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                        BrandId = 1
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
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
                    SHP_Product Prodlocale = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
                    if (ProdLocaleList[0].PromoPrice == 0)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                    }
                    else
                    {
                        DateTime DStart = ProdLocaleList[0].PromoStartDate;
                        DateTime Dstop = ProdLocaleList[0].PromoStopDate;
                        DateTime DNow = DateTime.Now;
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
                            SHPProduct.PromoStatus = false;
                        }


                    }

                    SHPProduct.Price = ProdLocaleList[0].PriceFixed <= 0 ? reader.GetDecimal(reader.GetOrdinal("Price")) : ProdLocaleList[0].PriceFixed;

                    SHPProduct.AttributesList = string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList")))
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("AttributesList"));
                    GetSHPCategoryProductLst.Add(SHPProduct);
                }
                reader.Close();

                //        CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
            }
            return GetSHPCategoryProductLst;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
        }
        private List<SHP_Product> GetSHPProductByCategoryIdLocal(int CategoryId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> GetSHPCategoryProductLst = new List<SHP_Product>();
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductByCategoryId_V2", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
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
                    SHP_Product Prodlocale = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
                    if (ProdLocaleList[0].PromoPrice == 0)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                    }
                    else
                    {
                        DateTime DStart = ProdLocaleList[0].PromoStartDate;
                        DateTime Dstop = ProdLocaleList[0].PromoStopDate;
                        DateTime DNow = DateTime.Now;
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
                            SHPProduct.PromoStatus = false;
                        }


                    }

                    SHPProduct.Price = ProdLocaleList[0].PriceFixed <= 0 ? reader.GetDecimal(reader.GetOrdinal("Price")) : ProdLocaleList[0].PriceFixed;

                    SHPProduct.AttributesList = string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList")))
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("AttributesList"));
                    GetSHPCategoryProductLst.Add(SHPProduct);
                }
                reader.Close();

                //        CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
            }
            return GetSHPCategoryProductLst;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
        }
        private List<SHP_Product> GetSHPProductByProductIdLocal(int ProductId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductById_Top1", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    //SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
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
                    SHP_Product Prodlocale = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
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
        private List<SHP_Product> GetSHPProductByProductIdLocalTop1(int ProductId)
        {
            _ = new DataTable();
            //string CacheTable = "CacheTShpProductByid" + Convert.ToString(CategoryId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductById_Top1", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    //SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
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
                    SHP_Product Prodlocale = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
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
        private List<SHP_Product> GetSHPProductInPromoByBrandLocal(int BrandId)
        {
            _ = new DataTable();
            string CacheTable = "CacheTShpProductInPromo";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@BrandId", BrandId);
            INTRA.ShopRM.AppCode.SHPCategory catego = new INTRA.ShopRM.AppCode.SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromoByBrand", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductIdLocal"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    SHP_Product ProdRemote = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdRemoteList = ProdRemote.GetSHPProductByProductId(SHPProduct.ProductId);

                    if (ProdRemoteList.Count > 0)
                    {

                        SHPProduct.CategoryID = ProdRemoteList[0].CategoryID;
                        SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(ProdRemoteList[0].CategoryID);
                        SHPProduct.ProductCod = ProdRemoteList[0].ProductCod;
                        SHPProduct.DisplayName = ProdRemoteList[0].DisplayName;

                        SHPProduct.ShortDescription = ProdRemoteList[0].ShortDescription;

                        SHPProduct.FullDescription = ProdRemoteList[0].FullDescription; ;
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
        private List<SHP_Product> GetSHPProductInPromoByIdCategoLocal(int CategoryId)
        {
            _ = new DataTable();
            string CacheTable = "CacheTShpProductInPromo";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> GetSHPCategoryProductLst = new List<SHP_Product>();
            INTRA.ShopRM.AppCode.SHPSql4Helper objSqlHelper = new INTRA.ShopRM.AppCode.SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromoByIdCatego", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
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
            SHPCategory catego = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromo_V2", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductIdLocal"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    SHP_Product ProdRemote = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdRemoteList = ProdRemote.GetSHPProductByProductId(SHPProduct.ProductId);



                    SHPProduct.CategoryID = ProdRemoteList[0].CategoryID;
                    SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(ProdRemoteList[0].CategoryID);
                    SHPProduct.ProductCod = ProdRemoteList[0].ProductCod;
                    SHPProduct.DisplayName = ProdRemoteList[0].DisplayName;

                    SHPProduct.ShortDescription = ProdRemoteList[0].ShortDescription;

                    SHPProduct.FullDescription = ProdRemoteList[0].FullDescription; ;
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
                reader.Close();
                CacheHelper_23.Insert(CacheTable, LocalList);
            }
            return LocalList;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
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
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductSearch_V2", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
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
                    // sono qui
                    SHP_Product Prodlocale = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdLocaleList = Prodlocale.GetSHPProductByProductIdLocale(SHPProduct.ProductId);
                    if (ProdLocaleList[0].PromoPrice == 0)
                    {
                        SHPProduct.PromoPrice = 0;
                        SHPProduct.PromoStatus = false;
                    }
                    else
                    {
                        DateTime DStart = ProdLocaleList[0].PromoStartDate;
                        DateTime Dstop = ProdLocaleList[0].PromoStopDate;
                        DateTime DNow = DateTime.Now;
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
                            SHPProduct.PromoStatus = false;
                        }


                    }

                    SHPProduct.Price = ProdLocaleList[0].PriceFixed <= 0 ? reader.GetDecimal(reader.GetOrdinal("Price")) : ProdLocaleList[0].PriceFixed;


                    //if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                    //{
                    //    SHPProduct.PromoPrice = 0;
                    //    SHPProduct.PromoStatus = false;
                    //    SHPProduct.PromoStatusDB = false;
                    //    SHPProduct.PromoId = 0;
                    //}
                    //else
                    //{
                    //    SHPProduct.PromoId = reader.GetInt32(reader.GetOrdinal("PromoId"));
                    //    SHPProduct.PromoStatusDB = true;
                    //    DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                    //    DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                    //    DateTime DNow = DateTime.Now;
                    //    if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                    //    {
                    //        SHPProduct.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                    //        SHPProduct.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                    //        SHPProduct.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                    //        SHPProduct.PromoStatus = true;
                    //    }
                    //    else
                    //    {
                    //        SHPProduct.PromoPrice = 0;
                    //        SHPProduct.PromoStatus = false;
                    //    }


                    //}
                    //SHPProduct.PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"));


                    //if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                    //{
                    //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                    //    SHPProduct.PriceFixed = 0;
                    //}
                    //else
                    //{
                    //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                    //    SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                    //}

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
        private bool SetProductPromoId(int ProductId, int PromoId)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
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
        public DataTable GetProducInPromotByCategoryIdDT(int CategoryId)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductInPromoByIdCategoLocal(CategoryId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }

        /*plus **************/
        public DataTable GetProductsBySubCatMacroCatBrandIdMieleDT(int CategoryId, int MacroCatego, int BrandId)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetProductsBySubCatMacroCatBrandIdMiele(CategoryId, MacroCatego, BrandId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }
        public DataTable GetSHPAllProductInPromoLocalDT()
        {
            // questa la uso per ottenere tutti i prodotti in promo per poi filtrare per categoria padre categoria
            _ = new DataTable();
            string CacheTable = "CacheTShpAllProductInPromo";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            SHPCategory catego = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromo_V2", objParams))
            {
                while (reader.Read())
                {

                    //SHP_Product SHPProduct = new SHP_Product();
                    SHP_Product ProdRemote = new SHP_Product();
                    _ = new List<SHP_Product>();
                    List<SHP_Product> ProdRemoteList = ProdRemote.GetSHPProductByProductId(reader.GetInt32(reader.GetOrdinal("ProductIdLocal")));
                    for (int i = 0; i < ProdRemoteList.Count; i++) // Loop through List with for
                    {
                        SHP_Product SHPProduct = new SHP_Product
                        {
                            ProductId = ProdRemoteList[i].ProductId
                        };
                        SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                        SHPProduct.CategoryID = ProdRemoteList[i].CategoryID;
                        SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(ProdRemoteList[i].CategoryID);
                        SHPProduct.ProductCod = ProdRemoteList[i].ProductCod;
                        SHPProduct.DisplayName = ProdRemoteList[i].DisplayName;
                        SHPProduct.ShortDescription = ProdRemoteList[i].ShortDescription;
                        SHPProduct.FullDescription = ProdRemoteList[i].FullDescription;
                        SHPProduct.units = ProdRemoteList[i].units;
                        SHPProduct.quantity = ProdRemoteList[i].quantity;
                        SHPProduct.PictureUrl = ProdRemoteList[i].PictureUrl;
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
                        SHPProduct.PriceStart = ProdRemoteList[i].Price;


                        if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                        {
                            SHPProduct.Price = ProdRemoteList[i].Price;
                            SHPProduct.PriceFixed = 0;
                        }
                        else
                        {
                            SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                            SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        }

                        SHPProduct.AttributesList = ProdRemoteList[i].AttributesList;

                        LocalList.Add(SHPProduct);
                    }
                }
                reader.Close();
                CacheHelper_23.Insert(CacheTable, LocalList);
            }
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(LocalList);
            return table;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
        }
        public DataTable GetSHPAllProductInPromoLocalDT_CAT()
        {
            // questa la uso per ottenere tutti i prodotti in promo per poi filtrare per categoria padre categoria
            _ = new DataTable();
            string CacheTable = "CacheTShpAllProductInPromoCAT";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHP_Product> LocalList = new List<SHP_Product>();
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            SHPCategory catego = new SHPCategory();
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductInPromo_V2", objParams))
            {
                while (reader.Read())
                {

                    //SHP_Product SHPProduct = new SHP_Product();
                    SHP_Product ProdRemote = new SHP_Product();
                    FIT_SHP_Product SHPProductFit = new FIT_SHP_Product();
                    _ = new List<SHP_Product>();
                    _ = new List<FIT_SHP_Product>();
                    if (SHPProductFit.ControlFittizio(reader.GetInt32(reader.GetOrdinal("ProductId"))))
                    {
                        List<FIT_SHP_Product> ProdLocalList = SHPProductFit.GetSHPProductByProductIdLocalAndCatego(reader.GetInt32(reader.GetOrdinal("ProductId")));
                        for (int i = 0; i < ProdLocalList.Count; i++) // Loop through List with for
                        {
                            SHP_Product SHPProduct = new SHP_Product
                            {
                                ProductIdLocal = ProdLocalList[i].ProductId,
                                ProductId = ProdLocalList[i].ProductId,
                                CategoryID = ProdLocalList[i].CategoryID,
                                BrandId = ProdLocalList[i].BrandId
                            };
                            //SHPProduct.ProdCategoParentalId = ProdLocalList[i].ProdCategoParentalId;
                            //if (catego.GetMyParentalID(SHPProduct.CategoryID) == 0) 
                            //{
                            //    SHPProduct.ProdCategoParentalId = SHPProduct.CategoryID;
                            //}
                            //else
                            //{
                            //    SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(SHPProduct.CategoryID);
                            //}
                            SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(SHPProduct.CategoryID);
                            SHPProduct.ProductCod = ProdLocalList[i].ProductCod;
                            SHPProduct.DisplayName = ProdLocalList[i].DisplayName;
                            SHPProduct.ShortDescription = ProdLocalList[i].ShortDescription;
                            SHPProduct.FullDescription = ProdLocalList[i].FullDescription;
                            SHPProduct.units = ProdLocalList[i].units;
                            SHPProduct.quantity = ProdLocalList[i].quantity;
                            SHPProduct.PictureUrl = System.Web.HttpContext.Current.Request.ApplicationPath.TrimEnd('/') + "/" + ProdLocalList[i].PictureUrl;
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
                            SHPProduct.PriceStart = ProdLocalList[i].Price;


                            if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                            {
                                SHPProduct.Price = ProdLocalList[i].Price;
                                SHPProduct.PriceFixed = 0;
                            }
                            else
                            {
                                SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                                SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                            }

                            SHPProduct.AttributesList = ProdLocalList[i].AttributesList;

                            LocalList.Add(SHPProduct);
                        }
                    }
                    else
                    {
                        List<SHP_Product> ProdRemoteList = ProdRemote.GetSHPProductByProductIdForPromo(reader.GetInt32(reader.GetOrdinal("ProductIdLocal")));
                        for (int i = 0; i < ProdRemoteList.Count; i++) // Loop through List with for
                        {
                            SHP_Product_Responsive IdLocale = new SHP_Product_Responsive();
                            int IdLocal = IdLocale.ProdId_LOCAL_by_ProdId_ReomoteGET(ProdRemoteList[i].ProductId);
                            SHP_Product SHPProduct = new SHP_Product
                            {
                                ProductIdLocal = ProdRemoteList[i].ProductId,

                                ProductId = IdLocal,
                                //SHPProduct.ProductId = ProdRemoteList[i].ProductIdLocal;
                                BrandId = 1,
                                CategoryID = 0,
                                Fittizio = 0,
                                ProdCategoParentalId = ProdRemoteList[i].ProdCategoParentalId,
                                //SHPProduct.ProdCategoParentalId = catego.GetMyParentalID(ProdRemoteList[i].CategoryID);
                                ProductCod = ProdRemoteList[i].ProductCod,
                                DisplayName = ProdRemoteList[i].DisplayName,
                                ShortDescription = ProdRemoteList[i].ShortDescription,
                                FullDescription = ProdRemoteList[i].FullDescription,
                                units = ProdRemoteList[i].units,
                                quantity = ProdRemoteList[i].quantity,
                                PictureUrl = ProdRemoteList[i].PictureUrl
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
                            SHPProduct.PriceStart = ProdRemoteList[i].Price;


                            if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                            {
                                SHPProduct.Price = ProdRemoteList[i].Price;
                                SHPProduct.PriceFixed = 0;
                            }
                            else
                            {
                                SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                                SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                            }

                            SHPProduct.AttributesList = ProdRemoteList[i].AttributesList;

                            LocalList.Add(SHPProduct);
                        }
                    }
                }
                reader.Close();
                CacheHelper_23.Insert(CacheTable, LocalList);
            }
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(LocalList);
            return table;
            //}
            //return CacheHelper_23.Retrieve<List<SHP_Product>>(CacheTable);
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
                    //while (reader.Read())
                    //{
                    //    SHP_Product SHPProduct = new SHP_Product();
                    //    SHPProduct.ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"));
                    //    SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                    //    SHPProduct.ProductCod = reader.GetString(reader.GetOrdinal("ProductCod"));
                    //    SHPProduct.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                    //    //SHPProduct.NameRw = reader.GetString(reader.GetOrdinal("NameRW"));
                    //    SHPProduct.ShortDescription = reader.GetString(reader.GetOrdinal("ShortDescription"));
                    //    SHPProduct.FullDescription = reader.GetString(reader.GetOrdinal("FullDescription"));
                    //    SHPProduct.quantity = reader.GetInt32(reader.GetOrdinal("quantity"));
                    //    SHPProduct.PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"));
                    //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                    //    if (string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList"))))
                    //    {
                    //        SHPProduct.AttributesList = "n.d.";
                    //    }
                    //    else
                    //    {
                    //        SHPProduct.AttributesList = reader.GetString(reader.GetOrdinal("AttributesList"));
                    //    }
                    //    GetSHPCategoryProductLst.Add(SHPProduct);
                    //}
                    //reader.Close();


                    //CollectionHelper.ConvertTo
                    CacheHelper_23.Insert(CacheTable, dt);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.RetrieveDT(CacheTable);
        }

        //[SHP_GetSHPProductCategory]
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
                            ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"))
                        };
                        SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                        SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                        SHPProduct.ProductCod = reader.GetString(reader.GetOrdinal("ProductCod"));
                        SHPProduct.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                        //SHPProduct.NameRw = reader.GetString(reader.GetOrdinal("NameRW"));
                        SHPProduct.ShortDescription = reader.GetString(reader.GetOrdinal("ShortDescription"));
                        SHPProduct.FullDescription = reader.GetString(reader.GetOrdinal("FullDescription"));
                        SHPProduct.units = reader.GetValue(reader.GetOrdinal("units")) == DBNull.Value ? "Pz." : reader.GetString(reader.GetOrdinal("units"));
                        SHPProduct.quantity = reader.GetInt32(reader.GetOrdinal("quantity"));
                        SHPProduct.PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"));
                        SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                        SHPProduct.AttributesList = string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList")))
                            ? "n.d."
                            : reader.GetString(reader.GetOrdinal("AttributesList"));
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
                    //while (reader.Read())
                    //{
                    //    SHP_Product SHPProduct = new SHP_Product();
                    //    SHPProduct.ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"));
                    //    SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                    //    SHPProduct.ProductCod = reader.GetString(reader.GetOrdinal("ProductCod"));
                    //    SHPProduct.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                    //    //SHPProduct.NameRw = reader.GetString(reader.GetOrdinal("NameRW"));
                    //    SHPProduct.ShortDescription = reader.GetString(reader.GetOrdinal("ShortDescription"));
                    //    SHPProduct.FullDescription = reader.GetString(reader.GetOrdinal("FullDescription"));
                    //    SHPProduct.quantity = reader.GetInt32(reader.GetOrdinal("quantity"));
                    //    SHPProduct.PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"));
                    //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                    //    if (string.IsNullOrEmpty(reader.GetString(reader.GetOrdinal("AttributesList"))))
                    //    {
                    //        SHPProduct.AttributesList = "n.d.";
                    //    }
                    //    else
                    //    {
                    //        SHPProduct.AttributesList = reader.GetString(reader.GetOrdinal("AttributesList"));
                    //    }
                    //    GetSHPCategoryProductLst.Add(SHPProduct);
                    //}
                    //reader.Close();


                    //CollectionHelper.ConvertTo
                    //CacheHelper_23.Insert(CacheTable, GetSHPCategoryProductLst);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return dt;
        }
        public DataTable GetSHPProductByCategoryIdDTV2(int CategoryId)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductByCategoryIdLocal(CategoryId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }
        public DataTable GetSHPProductByIdDT(int ProductId)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductByProductIdLocal(ProductId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }
        public DataTable GetSHPProductByIdDTTop1(int ProductId)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductByProductIdLocalTop1(ProductId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
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
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"))
                    };
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
                    SHPProduct.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
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
                    //if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                    //{
                    //    SHPProduct.PromoPrice = 0;
                    //    SHPProduct.PromoStatus = false;
                    //    SHPProduct.PromoStatusDB = false;
                    //    SHPProduct.PromoId = 0;
                    //}
                    //else
                    //{
                    //    SHPProduct.PromoId = reader.GetInt32(reader.GetOrdinal("PromoId"));
                    //    SHPProduct.PromoStatusDB = true;
                    //    DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                    //    DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                    //    DateTime DNow = DateTime.Now;
                    //    if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                    //    {
                    //        SHPProduct.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                    //        SHPProduct.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                    //        SHPProduct.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                    //        SHPProduct.PromoStatus = true;
                    //    }
                    //    else
                    //    {
                    //        SHPProduct.PromoPrice = 0;
                    //        SHPProduct.PromoStatus = false;
                    //    }


                    //}
                    SHPProduct.PriceStart = reader.GetDecimal(reader.GetOrdinal("Price"));
                    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));

                    //if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                    //{
                    //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                    //    SHPProduct.PriceFixed = 0;
                    //}
                    //else
                    //{
                    //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                    //    SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                    //}

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
        public List<SHP_Product> GetSHPProductByProductIdForPromo(int ProductId)
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
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPProductByIdForPromo", objParams))
            {

                while (reader.Read())
                {
                    SHP_Product SHPProduct = new SHP_Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),

                        CategoryID = 0,
                        Fittizio = 0,
                        ProdCategoParentalId = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                        ProductCod = reader.GetString(reader.GetOrdinal("ProductCod")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        ShortDescription = reader.GetValue(reader.GetOrdinal("ShortDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("ShortDescription")),
                        FullDescription = reader.GetValue(reader.GetOrdinal("FullDescription")) == DBNull.Value
                        ? "n.d."
                        : reader.GetString(reader.GetOrdinal("FullDescription")),
                        units = reader.GetValue(reader.GetOrdinal("units")) == DBNull.Value ? "Pz." : reader.GetString(reader.GetOrdinal("units")),
                        quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                        PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl")),
                        //if (reader.GetValue(reader.GetOrdinal("PromoPrice")) == DBNull.Value)
                        //{
                        //    SHPProduct.PromoPrice = 0;
                        //    SHPProduct.PromoStatus = false;
                        //    SHPProduct.PromoStatusDB = false;
                        //    SHPProduct.PromoId = 0;
                        //}
                        //else
                        //{
                        //    SHPProduct.PromoId = reader.GetInt32(reader.GetOrdinal("PromoId"));
                        //    SHPProduct.PromoStatusDB = true;
                        //    DateTime DStart = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                        //    DateTime Dstop = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                        //    DateTime DNow = DateTime.Now;
                        //    if (DStart.Date <= DNow.Date && Dstop.Date >= DNow.Date)
                        //    {
                        //        SHPProduct.PromoPrice = reader.GetDecimal(reader.GetOrdinal("PromoPrice"));
                        //        SHPProduct.PromoStartDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                        //        SHPProduct.PromoStopDate = reader.GetDateTime(reader.GetOrdinal("StopDate"));
                        //        SHPProduct.PromoStatus = true;
                        //    }
                        //    else
                        //    {
                        //        SHPProduct.PromoPrice = 0;
                        //        SHPProduct.PromoStatus = false;
                        //    }


                        //}
                        PriceStart = reader.GetDecimal(reader.GetOrdinal("Price")),
                        Price = reader.GetDecimal(reader.GetOrdinal("Price")),

                        //if (reader.GetDecimal(reader.GetOrdinal("PriceFixed")) <= 0)
                        //{
                        //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("Price"));
                        //    SHPProduct.PriceFixed = 0;
                        //}
                        //else
                        //{
                        //    SHPProduct.Price = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        //    SHPProduct.PriceFixed = reader.GetDecimal(reader.GetOrdinal("PriceFixed"));
                        //}

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
                    SHPProduct.ProductIdLocal = SHPProduct.ProductId;
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
        public bool GetSHPProductInCategory(int ProductId, int CategoryID)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductID", ProductId);
            objParams[1] = new SqlParameter("@CategoryID", CategoryID);
            return Convert.ToBoolean(objSqlHelper.ExecuteNonQueryReturnValue("SHP_GetSHPProductInCategory", objParams));

        }
        public DataTable GetSHPProductInPromoByBrandDT(int BrandId)
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductInPromoByBrandLocal(BrandId);
            DataTable table = CollectionHelper.ConvertTo<SHP_Product>(SHPProductLst);
            return table;
        }
        public DataTable GetSHPProductInPromoDT()
        {
            _ = new List<SHP_Product>();
            List<SHP_Product> SHPProductLst = GetSHPProductInPromoLocal();
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
        public int Fittizio { get; set; }
        #endregion

    }
}