using Info4U.Models;
using INTRA.AppCode;
using INTRA.AppCode.Portal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
namespace INTRA.ShopRM.AppCode
{
    public class SHPCategory
    {
        private string _GerarchiaUrl;

        //[MetaTitle] [nvarchar](400) NULL,
        private string _MetaTitle;
        private readonly List<SHPCategory> AllPrtCategory = new List<SHPCategory>();

        //List<SHPCategory> AllSHPCategoryList = new List<SHPCategory>();
        private readonly List<SHPCategory> AllSHPCategory = new List<SHPCategory>();
        private readonly List<SHPCategory> categorySHPWithParents = new List<SHPCategory>();
        private readonly List<SHPCategory> categoryWithParents = new List<SHPCategory>();
        private readonly List<SHPCategory> GetUrlGerachiaLst = new List<SHPCategory>();

        public SHPCategory()
        {

        }

        protected void GetAllPrtCategory()
        {

            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetAllPrtCategory", objParams);
            while (reader.Read())
            {
                int varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                if (varParentCategoryID == 0)
                {
                    SHPCategory SHPCategory = new SHPCategory
                    {
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        //NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                        ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                        LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                    };
                    AllPrtCategory.Add(SHPCategory);
                    GetAllPrtCategoryChild(varCategoryID, "----");

                }

            }
            reader.Close();
        }
        protected void GetAllPrtCategoryChild(int CategoryID, string level)
        {
            INTRA.AppCode.Sql4Gestionale sql4Gestionale = new INTRA.AppCode.Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = sql4Gestionale.ExecuteReader("U_SHP_GetSHPCategoryById", objParams);
            while (reader.Read())
            {
                _ = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                SHPCategory SHPCategory = new SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                    DisplayName = level + reader.GetString(reader.GetOrdinal("DisplayName")),
                    //NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                    ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                    LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                };
                AllPrtCategory.Add(SHPCategory);
                GetAllPrtCategoryChild(varCategoryID, level + "----");

            }
            reader.Close();

        }


        protected void GetAllSHPCategoryChild(int CategoryID, string level)
        {
            INTRA.AppCode.Sql4Gestionale sql4Gestionale = new INTRA.AppCode.Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = sql4Gestionale.ExecuteReader("U_SHP_GetSHPCategoryById", objParams);
            while (reader.Read())
            {
                _ = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                SHPCategory SHPCategory = new SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                    DisplayName = level + reader.GetString(reader.GetOrdinal("DisplayName")),
                    NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                    ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                    LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory")),
                    PassInfo = level
                };

                AllSHPCategory.Add(SHPCategory);
                GetAllSHPCategoryChild(varCategoryID, level + "----");
            }
            reader.Close();
        }
        protected void GetAllSHPHieraticCategory()
        {
            INTRA.AppCode.Sql4Gestionale sql4Gestionale = new INTRA.AppCode.Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            SqlDataReader reader = sql4Gestionale.ExecuteReader("U_SHP_GetAllSHPCategory", objParams);
            while (reader.Read())
            {
                int varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                if (varParentCategoryID == 0)
                {
                    SHPCategory SHPCategory = new SHPCategory
                    {
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                        ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                        LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory")),
                        PassInfo = reader.GetString(reader.GetOrdinal("NameRw"))
                    };
                    //SHPCategory.
                    AllSHPCategory.Add(SHPCategory);
                    GetAllSHPCategoryChild(varCategoryID, reader.GetString(reader.GetOrdinal("NameRw")));
                }
            }
            reader.Close();
        }

        //**** plus
        public string[] FirstBrandCatego(int BrandId, int MacroCatego)
        {
            string[] RetArray;
            RetArray = new string[2];
            RetArray[0] = "0";
            RetArray[1] = "0";
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@BrandId", BrandId);
            objParams[1] = new SqlParameter("@CatPiccoloGrande", MacroCatego);
            SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_FirstBrandCatego", objParams);
            //int varCategoryID = 0;
            while (reader.Read())
            {

                RetArray[0] = reader.GetInt32(reader.GetOrdinal("CategoId")).ToString();
                RetArray[1] = reader.GetString(reader.GetOrdinal("NameRWCatego")).ToString();


                //}
                //GetAllSHPCategoryChild(varCategoryID, level + "----");
            }
            reader.Close();
            return RetArray;
        }
        public string[] FirstSubCatego(int CategoryId)
        {
            string[] RetArray;
            RetArray = new string[2];
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryId", CategoryId);
            SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetFirstChildCategory", objParams);
            //int varCategoryID = 0;
            RetArray[0] = "0";
            RetArray[1] = "ND";
            while (reader.Read())
            {

                RetArray[0] = reader.GetInt32(reader.GetOrdinal("CategoryID")).ToString();
                RetArray[1] = reader.GetString(reader.GetOrdinal("NameRW")).ToString();
                //}
                //GetAllSHPCategoryChild(varCategoryID, level + "----");
            }
            reader.Close();
            return RetArray;
        }
        public string[] FirstSubCategoBrandMacrocatego(int CategoryId, int BrandId, int MacroCatego)
        {
            string[] RetArray;
            RetArray = new string[2];
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@CategoId", CategoryId);
            objParams[1] = new SqlParameter("@MacroCatego", MacroCatego);
            objParams[2] = new SqlParameter("@BrandId", BrandId);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetTop1SubCategoByBrandCategoMacroCatego", objParams);
            //int varCategoryID = 0;
            while (reader.Read())
            {

                RetArray[0] = reader.GetInt32(reader.GetOrdinal("CategoryID")).ToString();
                RetArray[1] = reader.GetString(reader.GetOrdinal("NameRW")).ToString();
                //}
                //GetAllSHPCategoryChild(varCategoryID, level + "----");
            }
            reader.Close();
            return RetArray;
        }
        public List<SHPCategory> GetAllHieraticPrtCategory()
        {
            GetAllPrtCategory();
            return AllPrtCategory;
        }
        public List<SHPCategory> GetAllHieraticSHPCategory()
        {
            GetAllSHPHieraticCategory();
            return AllSHPCategory;
        }
        public List<SHPCategory> GetAllSHPCategoryList()
        {
            string CacheTable = "SHP_GetAllSHPCategoryList";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                List<SHPCategory> SHPCategoryLst = new List<SHPCategory>();
                SHPSql4Helper objSqlHelper = new SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[0];
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetAllSHPCategoryDb", objParams))
                {
                    while (reader.Read())
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                            //NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                            ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                            LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                        };
                        SHPCategoryLst.Add(SHPCategory);
                    }
                    reader.Close();
                }
                CacheHelper_23.Insert(CacheTable, SHPCategoryLst);
            }
            return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        public List<SHPCategory> GetAllSHPCategoryPrincipali()
        {
            string CacheTable = "SHP_GetAllSHPCategoryPrincipali";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                List<SHPCategory> SHPCategoyLst = new List<SHPCategory>();
                SHPSql4Helper objSqlHelper = new SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[0];
                DataTable dt = new DataTable();
                int Rowcount = 0;
                int RowcountReader = 1;
                // interrogo Cat_assistenza per etrarre le categorie
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetAllSHPCategory", objParams))
                {
                    IDataReader reader2 = reader;
                    dt.Load(reader2);

                    Rowcount = dt.Rows.Count;
                }
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetAllSHPCategory", objParams))
                {
                    while (reader.Read())
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                            NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                            ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                            LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                        };
                        if (RowcountReader == 1)
                        {
                            SHPCategory.PassInfo = "data-position='first' data-item='" + reader.GetString(reader.GetOrdinal("DisplayName")) + "'";
                        }

                        if (RowcountReader == Rowcount)
                        {
                            SHPCategory.PassInfo = "data-position='last' data-item='" + reader.GetString(reader.GetOrdinal("DisplayName")) + "'";
                        }
                        if (RowcountReader != Rowcount && RowcountReader != 1)
                        {
                            SHPCategory.PassInfo = "data-item='" + reader.GetString(reader.GetOrdinal("DisplayName")) + "'";
                        }
                        RowcountReader++;
                        SHPCategoyLst.Add(SHPCategory);
                    }
                    //reader.Close();

                }
                //CollectionHelper.ConvertTo
                CacheHelper_23.Insert(CacheTable, SHPCategoyLst);
            }
            //now it definitely exists in cache
            return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        public int GetCategoryIdByNameRW(string NameRw)
        {
            //restituisce il LevelCategory del padre
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@NameRw", NameRw);
            //int LastId = objSqlHelper.ExecuteNonQuery("SHP_GetSHPCategoryByNameRW", objParams);
            SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryByNameRW", objParams);
            int CategoryId = -1;
            while (reader.Read())
            {
                _ = new SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"))
                };
                //AllSHPCategory.Add(SHPCategoryId);
                CategoryId = reader.GetInt32(reader.GetOrdinal("CategoryID"));

            }
            reader.Close();
            return CategoryId;
        }
        public List<SHPCategory> GetCategoryinPromo()
        {
            string CacheTable = "CacheTableCategoryPromo";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                SHP_Product_SuperAdmin ProdSuperAdmin = new SHP_Product_SuperAdmin();
                DataTable ProductInPromoDt = ProdSuperAdmin.GetSHPProductInPromoDT();
                List<SHPCategory> CategoListReturn = new List<SHPCategory>();
                foreach (DataRow dr in ProductInPromoDt.Rows)
                {
                    _ = new List<SHPCategory>();
                    List<SHPCategory> CategoLocaleList = GetSHPCategoryByProductId(Convert.ToInt32(dr["ProductId"].ToString()));
                    SHPCategory SHPCategory = new SHPCategory
                    {
                        CategoryID = GetCategoryRoot(CategoLocaleList[0].ParentCategoryID)
                    };
                    SHPCategory.DisplayName = GetCategoryName(SHPCategory.CategoryID);
                    SHPCategory.GerarchiaUrl = GetUrlGerachia(SHPCategory.CategoryID, string.Empty);
                    CategoListReturn.Add(SHPCategory);
                }
                CacheHelper_23.Insert(CacheTable, CategoListReturn);
                //List<SHPCategory> SHPSubCategoyLstByid = new List<SHPCategory>();
                //Sql4Helper objSqlHelper = new Sql4Helper();
                //SqlParameter[] objParams = new SqlParameter[0];
                ////objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                //using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_CategoryInPromo_Local", objParams))
                //{
                //    while (reader.Read())
                //    {
                //        SHPCategory SHPCategory = new SHPCategory();
                //        SHPCategory.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                //        SHPCategory.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                //        //SHPCategory.Description = reader.GetString(reader.GetOrdinal("Description"));
                //        SHPCategory.GerarchiaUrl = GetUrlGerachia(reader.GetInt32(reader.GetOrdinal("CategoryID")), "");
                //        //SHPCategory.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));
                //        //SHPCategory.ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                //        //SHPCategory.LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"));
                //        SHPSubCategoyLstByid.Add(SHPCategory);
                //    }
                //    reader.Close();


                //CollectionHelper.ConvertTo
                //    CacheHelper_23.Insert(CacheTable, SHPSubCategoyLstByid);
                //}
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        public DataTable GetCategoryinPromo_V2()
        {

            //string CacheTable = "CacheTableCategoryPromo_v2";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            _ = new SHP_Product_SuperAdmin();

            SHP_Product_Responsive _obj = new SHP_Product_Responsive();
            DataTable ProductInPromoDt = _obj.ProdottiInPromo_DTS();
            //DataTable ProductInPromoDt = ProdSuperAdmin.GetSHPProductInPromoDT();
            List<SHPCategory> CategoListReturn = new List<SHPCategory>();
            INTRA.ShopRM.AppCode.FIT_SHP_Product SHPProduct = new INTRA.ShopRM.AppCode.FIT_SHP_Product();
            foreach (DataRow dr in ProductInPromoDt.Rows)
            {
                if (SHPProduct.ControlFittizio(Convert.ToInt32(dr["ProductId"].ToString())))
                {
                    // primo trovo tutte le catego dal map
                    // secondo pesco le info della catego da remoto
                    // terzo le aggingo 
                    _ = new List<SHPCategory>();
                    List<SHPCategory> CategoLocaleListCAT = GetSHPCategoryByProductIdCAT(Convert.ToInt32(dr["ProductId"].ToString()));
                    for (int i = 0; i < CategoLocaleListCAT.Count; i++)
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CategoryID = GetCategoryRoot(CategoLocaleListCAT[i].CategoryID)
                        };
                        SHPCategory.DisplayName = GetCategoryName(SHPCategory.CategoryID);
                        SHPCategory.GerarchiaUrl = GetUrlGerachia(SHPCategory.CategoryID, string.Empty);
                        CategoListReturn.Add(SHPCategory);
                    }

                }
                else
                {
                    _ = new List<SHPCategory>();
                    List<SHPCategory> CategoLocaleList = GetSHPCategoryByProductId(Convert.ToInt32(dr["productidlocal"].ToString()));
                    for (int i = 0; i < CategoLocaleList.Count; i++)
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CategoryID = GetCategoryRoot(CategoLocaleList[i].CategoryID)
                        };
                        SHPCategory.DisplayName = GetCategoryName(SHPCategory.CategoryID);
                        SHPCategory.GerarchiaUrl = GetUrlGerachia(SHPCategory.CategoryID, string.Empty);
                        CategoListReturn.Add(SHPCategory);
                    }
                }
            }

            _ = new List<SHPCategory>();

            DataTable table = INTRA.AppCode.CollectionHelper.ConvertTo<SHPCategory>(CategoListReturn);
            table = table.DefaultView.ToTable(true);
            //table.Tables["Employee"].DefaultView.ToTable(true, "employeeid");
            //CategoListReturnDef = CategoListReturn.Distinct();
            //    CacheHelper_23.Insert(CacheTable, CategoListReturnDef);
            //}
            //return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
            return table;

        }
        public string GetCategoryName(int CategoryIdVar)
        {
            string returnstring = string.Empty;
            _ = new List<SHPCategory>();
            List<SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (SHPCategory list in LShop1)
            {
                if (list.CategoryID == CategoryIdVar)
                {
                    returnstring = list.DisplayName;
                    break;
                }
            }
            return returnstring;
        }
        public int GetCategoryRoot(int CategoryIdVar)
        {
            int returnId = -1;
            _ = new List<SHPCategory>();
            List<SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (SHPCategory list in LShop1)
            {
                if (list.CategoryID == CategoryIdVar)
                {
                    if (list.ParentCategoryID == 0)
                    {

                        returnId = list.CategoryID;
                        break;
                    }
                    else
                    {
                        returnId = GetCategoryRoot(list.ParentCategoryID);
                        break;
                    }
                }
            }
            return returnId;
        }
        public int GetMyFirstChildID(int CategoryIdVar)
        {
            int returnId = -1;
            _ = new List<SHPCategory>();
            List<SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (SHPCategory list in LShop1)
            {
                if (list.ParentCategoryID == CategoryIdVar)
                {
                    returnId = list.CategoryID;
                    break;
                }
            }
            return returnId;
        }

        public int GetMyParentalID(int CategoryIdVar)
        {
            int returnId = -1;
            _ = new List<SHPCategory>();
            List<SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (SHPCategory list in LShop1)
            {
                if (list.CategoryID == CategoryIdVar)
                {
                    returnId = list.ParentCategoryID;
                    break;
                }
            }
            return returnId;
        }
        public int GetParentalIdLevel(int ParentCategoryID)
        {
            //restituisce il LevelCategory del padre
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", ParentCategoryID);
            int LastId = objSqlHelper.ExecuteNonQuery("SHP_GetParentalIdLevel", objParams);
            return LastId;
        }
        public List<SHPCategory> GetSHPCategoryByProductId(int ProductId)
        {
            string CacheTable = "CategoryByProductId" + Convert.ToString(ProductId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHPCategory> GenericList = new List<SHPCategory>();
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryByProductId", objParams))
            {
                while (reader.Read())
                {
                    SHPCategory SHPCategory = new SHPCategory
                    {
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                        LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                    };
                    GenericList.Add(SHPCategory);
                }
                reader.Close();


                //CollectionHelper.ConvertTo
                CacheHelper_23.Insert(CacheTable, GenericList);
                return GenericList;
            }
            //now it definitely exists in cache

            //return SHPSubCategoyLstByid;
            //}
            //return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        public List<SHPCategory> GetSHPCategoryByProductIdCAT(int ProductId)
        {
            string CacheTable = "CategoryByProductId" + Convert.ToString(ProductId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHPCategory> GenericList = new List<SHPCategory>();
            INTRA.AppCode.Sql4Helper objSqlHelper = new INTRA.AppCode.Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryByProductIdCAT", objParams))
            {
                while (reader.Read())
                {
                    SHPCategory SHPCategory = new SHPCategory();
                    _ = new List<SHPCategory>();
                    SHPCategory.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                    List<SHPCategory> SHPCategoryRemoteList = SHPCategory.GetSHPCategoryDetailsById(SHPCategory.CategoryID);
                    SHPCategory.DisplayName = SHPCategoryRemoteList[0].DisplayName;
                    SHPCategory.ParentCategoryID = SHPCategoryRemoteList[0].ParentCategoryID;
                    SHPCategory.LevelCategory = SHPCategoryRemoteList[0].LevelCategory;
                    GenericList.Add(SHPCategory);
                }
                reader.Close();


                //CollectionHelper.ConvertTo
                CacheHelper_23.Insert(CacheTable, GenericList);
                return GenericList;
            }

            //now it definitely exists in cache

            //return SHPSubCategoyLstByid;
            //}
            //return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        public List<SHPCategory> GetSHPCategoryDetailsById(int CategoryId)
        {
            string CacheTable = "CacheTableSubCategory" + Convert.ToString(CategoryId);
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                List<SHPCategory> GetSHPCategoryDetailsById = new List<SHPCategory>();
                SHPSql4Helper objSqlHelper = new SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryDetailsById", objParams))
                {
                    while (reader.Read())
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                            Description = reader.IsDBNull(reader.GetOrdinal("Description")) ? string.Empty : reader.GetString(reader.GetOrdinal("Description")),

                            //SHPCategory.GerarchiaUrl = GetUrlGerachia(reader.GetInt32(reader.GetOrdinal("CategoryID")), "");
                            //SHPCategory.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));
                            ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                            LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                        };
                        GetSHPCategoryDetailsById.Add(SHPCategory);
                    }
                    reader.Close();


                    //CollectionHelper.ConvertTo
                    CacheHelper_23.Insert(CacheTable, GetSHPCategoryDetailsById);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        //Aggiunta il 17/01/2024 per prendere tutti gli articoli dalla tabella articoli del king. Duplicata e modificata la funzione GetSHPCategoryDetailsById
        public List<SHPCategory> GetSHPCategoryDetailsByIdGestionale(int CategoryId)
        {
            string CacheTable = "PLSCacheTableSubCategory" + Convert.ToString(CategoryId);
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                List<SHPCategory> GetSHPCategoryDetailsById = new List<SHPCategory>();
                INTRA.AppCode.Sql4Gestionale objSqlHelper = new INTRA.AppCode.Sql4Gestionale();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("U_SHP_GetSHPCategoryDetailsById", objParams))
                {
                    while (reader.Read())
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CodArt = reader["CodArt"] as string,
                            Descrizione = reader["Descrizione"] as string,
                            Categoria = reader["Categoria"] as string
                        };
                        GetSHPCategoryDetailsById.Add(SHPCategory);
                    }
                    reader.Close();


                    //CollectionHelper.ConvertTo
                    CacheHelper_23.Insert(CacheTable, GetSHPCategoryDetailsById);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        public List<SHPCategory> GetSHPCategoryPicture()
        {
            string CacheTable = "CacheTableShpCategoryPicture";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);

                List<SHPCategory> GetSHPCategoryPictureLst = new List<SHPCategory>();
                SHPSql4Helper objSqlHelper = new SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[0];
                //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryPicture", objParams))
                {
                    while (reader.Read())
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            PictureUrl = reader.GetString(reader.GetOrdinal("PictureUrl"))
                        };

                        //SHPCategory.GerarchiaUrl = GetUrlGerachia(reader.GetInt32(reader.GetOrdinal("CategoryID")), "");
                        //SHPCategory.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));

                        GetSHPCategoryPictureLst.Add(SHPCategory);
                    }
                    reader.Close();


                    //CollectionHelper.ConvertTo
                    CacheHelper_23.Insert(CacheTable, GetSHPCategoryPictureLst);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }
        //public List<SHPCategory> GetAllSHPCategory()
        //{
        //    GetAllSHPCategory();
        //    return AllSHPCategory;
        //}
        public List<SHPCategory> GetSHPSubCategory(string NameRw)
        {
            //string CacheTable = "SHP_GetSHPCategoryByNameRW";
            //if (!CacheHelper_23.ItemExists(CacheTable))

            int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHPCategory> SHPSubCategoyLst = new List<SHPCategory>();
            INTRA.AppCode.Sql4Gestionale sql4Gestionale = new INTRA.AppCode.Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            using (SqlDataReader reader = sql4Gestionale.ExecuteReader("U_SHP_GetSHPCategoryById", objParams))
            {
                while (reader.Read())
                {
                    SHPCategory SHPCategory = new SHPCategory
                    {
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                        ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                        LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                    };
                    SHPSubCategoyLst.Add(SHPCategory);
                }
                reader.Close();
            }

            //CollectionHelper.ConvertTo
            //CacheHelper_23.Insert(CacheTable, SHPSubCategoyLst);
            //}
            //now it definitely exists in cache
            //return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
            return SHPSubCategoyLst;
        }
        public List<SHPCategory> GetSHPSubCategoryByid(int CategoryId)
        {
            string CacheTable = "CacheTableCategory" + Convert.ToString(CategoryId);
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                List<SHPCategory> SHPSubCategoyLstByid = new List<SHPCategory>();
                INTRA.AppCode.Sql4Gestionale sql4Gestionale = new INTRA.AppCode.Sql4Gestionale();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = sql4Gestionale.ExecuteReader("U_SHP_GetSHPCategoryById", objParams))
                {
                    while (reader.Read())
                    {
                        SHPCategory SHPCategory = new SHPCategory
                        {
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                            //SHPCategory.Description = reader.GetString(reader.GetOrdinal("Description"));
                            GerarchiaUrl = GetUrlGerachia(reader.GetInt32(reader.GetOrdinal("CategoryID")), string.Empty),
                            //SHPCategory.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));
                            ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                            LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                        };
                        SHPSubCategoyLstByid.Add(SHPCategory);
                    }
                    reader.Close();


                    //CollectionHelper.ConvertTo
                    CacheHelper_23.Insert(CacheTable, SHPSubCategoyLstByid);
                }
                //now it definitely exists in cache

                //return SHPSubCategoyLstByid;
            }
            return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
        }


        //public string GetUrlGerachiaCAtegoBrandMacroCatego(int CategoryID, int BrandId, int MacroCatego, string UrlRW)
        //{
        //    SHPSql4Helper objSqlHelper = new SHPSql4Helper();
        //    SqlParameter[] objParams = new SqlParameter[3];
        //    objParams[0] = new SqlParameter("@CategoId", CategoryID);
        //    objParams[1] = new SqlParameter("@MacroCatego", MacroCatego);
        //    objParams[2] = new SqlParameter("@BrandId", BrandId);
        //    SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSubCategoByBrandCategoMacroCatego", objParams);
        //    string NameRwVar = string.Empty;
        //    int varParentCategoryID;
        //    int varCategoryID;
        //    while (reader.Read())
        //    {
        //        varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
        //        varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")); ;
        //        SHPCategory SHPCategoryGerarchia = new SHPCategory();
        //        SHPCategoryGerarchia.CategoryID = CategoryID;
        //        SHPCategoryGerarchia.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));
        //        if (varParentCategoryID > 0)
        //        {
        //            //NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" + UrlRW;
        //        }
        //        else
        //        {
        //            NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" + varCategoryID + "/" + UrlRW;
        //        }
        //        //NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" +UrlRW;
        //        SHPCategoryGerarchia.ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
        //        //GetUrlGerachiaLst.Add(SHPCategoryGerarchia);
        //        if (varParentCategoryID > 0)
        //        {
        //            NameRwVar = GetUrlGerachiaCAtegoBrandMacroCatego(varParentCategoryID, BrandId, MacroCatego, reader.GetString(reader.GetOrdinal("NameRw")) + "/" + UrlRW);
        //        }
        //        else
        //        {
        //            NameRwVar = reader.GetString(reader.GetOrdinal("CategoRw")) + "/" + CategoryID.ToString() + "/" + NameRwVar;
        //        }

        //    }
        //    reader.Close();
        //    return NameRwVar;
        //}


        public List<SHPCategory> GetSubCategoByBrandCategoMacroCatego(int CategoryId, int MacroCatego, int BrandId)
        {
            string CacheTable = "PLSCacheTableSubCategoByBrandCategoMacroCatego" + Convert.ToString(CategoryId) + Convert.ToString(MacroCatego) + Convert.ToString(BrandId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<SHPCategory> SHPSubCategoyLstByid = new List<SHPCategory>();
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            //SqlParameter[] objParams = new SqlParameter[1];
            //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@CategoId", CategoryId);
            objParams[1] = new SqlParameter("@MacroCatego", MacroCatego);
            objParams[2] = new SqlParameter("@BrandId", BrandId);
            string CategoId = CategoryId.ToString();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSubCategoByBrandCategoMacroCatego", objParams))
            {
                while (reader.Read())
                {
                    SHPCategory SHPCategory = new SHPCategory
                    {
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"))
                    };
                    string CategoRw = reader.GetString(reader.GetOrdinal("CategoRw"));
                    string SubCategoId = reader.GetInt32(reader.GetOrdinal("CategoryID")).ToString();
                    string SubCategoRW = reader.GetString(reader.GetOrdinal("NameRw"));
                    //SHPCategory.Description = reader.GetString(reader.GetOrdinal("Description"));
                    SHPCategory.GerarchiaUrl = CategoRw + "/" + CategoId + "/" + SubCategoRW + "/" + SubCategoId + "/";
                    //SHPCategory.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));
                    SHPCategory.ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                    //SHPCategory.LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"));
                    SHPSubCategoyLstByid.Add(SHPCategory);
                }
                reader.Close();


                //CollectionHelper.ConvertTo
                CacheHelper_23.Insert(CacheTable, SHPSubCategoyLstByid);
            }
            //now it definitely exists in cache

            return SHPSubCategoyLstByid;
            //}
            //return CacheHelper_23.Retrieve<List<PLS_SHPCategory>>(CacheTable);
        }
        public string GetUrlGerachia(int CategoryID, string UrlRW)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetParentalId", objParams);
            string NameRwVar = string.Empty;
            int varParentCategoryID;
            while (reader.Read())
            {
                varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                _ = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                SHPCategory SHPCategoryGerarchia = new SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                    //NameRw = reader.GetString(reader.GetOrdinal("NameRw"))
                };
                if (varParentCategoryID > 0)
                {
                    //NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" + UrlRW;
                }
                else
                {
                    NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" + reader.GetInt32(reader.GetOrdinal("CategoryID")).ToString() + "/" + UrlRW;
                }
                //NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" +UrlRW;
                SHPCategoryGerarchia.ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                //GetUrlGerachiaLst.Add(SHPCategoryGerarchia);
                if (varParentCategoryID > 0)
                {
                    //NameRwVar = GetUrlGerachia(varParentCategoryID, reader.GetString(reader.GetOrdinal("NameRw")) + "/" + UrlRW);
                }
                else
                {

                }

            }
            reader.Close();
            return NameRwVar;
        }


        public SHPCategory GetParentalCatego(int CategoryID)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetParentalId", objParams);

            SHPCategory SHPCategoryGerarchia = new SHPCategory();
            while (reader.Read())
            {
                _ = reader.GetOrdinal("CategoryID").ToString();
                SHPCategoryGerarchia.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                SHPCategoryGerarchia.ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                //SHPCategoryGerarchia.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));
                SHPCategoryGerarchia.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                SHPCategoryGerarchia.ParentalDisplayName = reader.GetString(reader.GetOrdinal("ParentalDisplayName"));
            }
            reader.Close();
            return SHPCategoryGerarchia;
        }


        //List<SHPCategory> GetUrlGerachiaLst = new List<SHPCategory>();
        public string GetUrlGerachiaCAtegoBrandMacroCatego(int CategoryID, int BrandId, int MacroCatego, string UrlRW)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@CategoId", CategoryID);
            objParams[1] = new SqlParameter("@MacroCatego", MacroCatego);
            objParams[2] = new SqlParameter("@BrandId", BrandId);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSubCategoByBrandCategoMacroCatego", objParams);
            string NameRwVar = string.Empty;
            int varParentCategoryID;
            int varCategoryID;
            while (reader.Read())
            {
                varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")); ;
                SHPCategory SHPCategoryGerarchia = new SHPCategory
                {
                    CategoryID = CategoryID,
                    NameRw = reader.GetString(reader.GetOrdinal("NameRw"))
                };
                if (varParentCategoryID > 0)
                {
                    //NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" + UrlRW;
                }
                else
                {
                    NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" + varCategoryID + "/" + UrlRW;
                }
                //NameRwVar = reader.GetString(reader.GetOrdinal("NameRw")) + "/" +UrlRW;
                SHPCategoryGerarchia.ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                //GetUrlGerachiaLst.Add(SHPCategoryGerarchia);
                NameRwVar = varParentCategoryID > 0
                    ? GetUrlGerachiaCAtegoBrandMacroCatego(varParentCategoryID, BrandId, MacroCatego, reader.GetString(reader.GetOrdinal("NameRw")) + "/" + UrlRW)
                    : reader.GetString(reader.GetOrdinal("CategoRw")) + "/" + CategoryID.ToString() + "/" + NameRwVar;

            }
            reader.Close();
            return NameRwVar;
        }
        public int InsertSHPCategory(SHPCategory SHPCategory)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[15];
            objParams[0] = new SqlParameter("@DisplayName", SHPCategory.DisplayName);
            objParams[1] = new SqlParameter("@NameRw", SHPCategory.NameRw);
            objParams[2] = new SqlParameter("@Description", SHPCategory.Description);
            objParams[3] = new SqlParameter("@MetaKeywords", SHPCategory.MetaKeywords);
            objParams[4] = new SqlParameter("@MetaDescription", SHPCategory.MetaDescription);
            objParams[5] = new SqlParameter("@MetaTitle", SHPCategory.MetaTitle);
            objParams[6] = new SqlParameter("@ParentCategoryID", SHPCategory.ParentCategoryID);
            objParams[7] = new SqlParameter("@LevelCategory", SHPCategory.LevelCategory);
            objParams[8] = new SqlParameter("@PictureID", SHPCategory.PictureID);
            objParams[9] = new SqlParameter("@ShowOnHomePage", SHPCategory.ShowOnHomePage);
            objParams[10] = new SqlParameter("@Published", SHPCategory.Published);
            objParams[11] = new SqlParameter("@Deleted", SHPCategory.Deleted);
            objParams[12] = new SqlParameter("@DisplayOrder", SHPCategory.DisplayOrder);
            objParams[13] = new SqlParameter("@CreatedOn", Convert.ToDateTime(SHPCategory.CreatedOn));
            objParams[14] = new SqlParameter("@UpdatedOn", Convert.ToDateTime(SHPCategory.UpdatedOn));
            int LastId = objSqlHelper.ExecuteNonQueryForNews("SHP_CategoryInsert", objParams);
            return LastId;
        }

        public int SHP_CountProdInCatego(int CategoryId)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryId", CategoryId);

            int LastId = objSqlHelper.ExecuteNonQueryReturnValue("SHP_CountProdInCatego", objParams);
            return LastId;
        }
        public int SHP_GetChildCount(int CategoryId)
        {

            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryId", CategoryId);

            int LastId = objSqlHelper.ExecuteNonQueryReturnValue("SHP_GetChildCount", objParams);
            return LastId;
        }
        public void UpdateSHPCategory(SHPCategory SHPCategory)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[15];
            objParams[0] = new SqlParameter("@DisplayName", SHPCategory.DisplayName);
            objParams[1] = new SqlParameter("@NameRw", SHPCategory.NameRw);
            objParams[2] = new SqlParameter("@Description", SHPCategory.Description);
            objParams[3] = new SqlParameter("@MetaKeywords", SHPCategory.MetaKeywords);
            objParams[4] = new SqlParameter("@MetaDescription", SHPCategory.MetaDescription);
            objParams[5] = new SqlParameter("@Primopiano", SHPCategory.MetaTitle);
            objParams[6] = new SqlParameter("@Home", SHPCategory.ParentCategoryID);
            objParams[7] = new SqlParameter("@Bozza", SHPCategory.LevelCategory);
            objParams[8] = new SqlParameter("@DataInizio", SHPCategory.PictureID);
            objParams[9] = new SqlParameter("@DataFine", SHPCategory.ShowOnHomePage);
            objParams[10] = new SqlParameter("@Regione", SHPCategory.Published);
            objParams[11] = new SqlParameter("@Provincia", SHPCategory.Deleted);
            objParams[12] = new SqlParameter("@Comune", SHPCategory.DisplayOrder);
            objParams[13] = new SqlParameter("@Orari", SHPCategory.CreatedOn);
            objParams[14] = new SqlParameter("@Contatti", SHPCategory.UpdatedOn);
            _ = objSqlHelper.ExecuteNonQuery("SHP_CategoryUpdate", objParams);
        }

        public int CategoryID { get; set; }
        public string CreatedOn { get; set; }
        public bool Deleted { get; set; }
        public string Description { get; set; }
        public string DisplayName { get; set; }
        public int DisplayOrder { get; set; }
        public string GerarchiaUrl
        {
            get => _GerarchiaUrl;
            set => _GerarchiaUrl = value;
        }
        public int LevelCategory { get; set; }
        public string MetaDescription { get; set; }
        public string MetaKeywords { get; set; }
        public string MetaTitle
        {
            get => _MetaTitle;
            set => _MetaTitle = value;
        }
        public string NameRw { get; set; }
        public int ParentCategoryID { get; set; }
        public string PassInfo { get; set; }
        public int PictureID { get; set; }
        public string PictureUrl { get; set; }
        public bool Published { get; set; }
        public bool ShowOnHomePage { get; set; }
        public string UpdatedOn { get; set; }
        public string ParentalDisplayName
        {
            get; set;
        }
        //Aggiunti il 17/01/2024 per visualizzare dalla tabella articoli
        public string CodArt { get; set; }
        public string Descrizione { get; set; }
        public string Categoria { get; set; }
    }
}