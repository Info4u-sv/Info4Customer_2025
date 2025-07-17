using INTRA.AppCode;
using INTRA.AppCode.Portal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
namespace INTRA.ShopRM.AppCode
{
    public class PLS_SHPCategory
    {
        public PLS_SHPCategory()
        {

        }

        public int CategoryID { get; set; }

        public string DisplayName { get; set; }

        public string NameRw { get; set; }
        public string Description { get; set; }

        public string MetaKeywords { get; set; }
        public string MetaDescription { get; set; }

        public string MetaTitle { get; set; }
        public int ParentCategoryID { get; set; }

        public int LevelCategory { get; set; }
        public int PictureID { get; set; }

        public bool ShowOnHomePage { get; set; }
        public bool Published { get; set; }

        public bool Deleted { get; set; }
        public int DisplayOrder { get; set; }

        public string CreatedOn { get; set; }
        public string UpdatedOn { get; set; }

        public string PassInfo { get; set; }
        public string GerarchiaUrl { get; set; }

        public string PictureUrl { get; set; }
        public int MacroCatego { get; set; }

        public int BrandId { get; set; }
        public string BrandNameRW { get; set; }

        public string BrandName { get; set; }
        public int InsertSHPCategory(PLS_SHPCategory SHPCategory)
        {

            PLS_SHPSql4Helper objSqlHelper = new INTRA.ShopRM.AppCode.PLS_SHPSql4Helper();
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
            int LastId = objSqlHelper.ExecuteNonQueryReturnValue("PLS_SHP_CategoryInsert", objParams);
            return LastId;
        }
        public int SHP_GetChildCount(int CategoryId)
        {

            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryId", CategoryId);

            int LastId = objSqlHelper.ExecuteNonQueryReturnValue("PLS_SHP_GetChildCount", objParams);
            return LastId;
        }
        public int PLS_SHP_CountProdInCatego(int CategoryId)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryId", CategoryId);

            int LastId = objSqlHelper.ExecuteNonQueryReturnValue("PLS_SHP_CountProdInCatego", objParams);
            return LastId;
        }
        public void UpdateSHPCategory(PLS_SHPCategory PLS_SHPCategory)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[15];
            objParams[0] = new SqlParameter("@DisplayName", PLS_SHPCategory.DisplayName);
            objParams[1] = new SqlParameter("@NameRw", PLS_SHPCategory.NameRw);
            objParams[2] = new SqlParameter("@Description", PLS_SHPCategory.Description);
            objParams[3] = new SqlParameter("@MetaKeywords", PLS_SHPCategory.MetaKeywords);
            objParams[4] = new SqlParameter("@MetaDescription", PLS_SHPCategory.MetaDescription);
            objParams[5] = new SqlParameter("@Primopiano", PLS_SHPCategory.MetaTitle);
            objParams[6] = new SqlParameter("@Home", PLS_SHPCategory.ParentCategoryID);
            objParams[7] = new SqlParameter("@Bozza", PLS_SHPCategory.LevelCategory);
            objParams[8] = new SqlParameter("@DataInizio", PLS_SHPCategory.PictureID);
            objParams[9] = new SqlParameter("@DataFine", PLS_SHPCategory.ShowOnHomePage);
            objParams[10] = new SqlParameter("@Regione", PLS_SHPCategory.Published);
            objParams[11] = new SqlParameter("@Provincia", PLS_SHPCategory.Deleted);
            objParams[12] = new SqlParameter("@Comune", PLS_SHPCategory.DisplayOrder);
            objParams[13] = new SqlParameter("@Orari", PLS_SHPCategory.CreatedOn);
            objParams[14] = new SqlParameter("@Contatti", PLS_SHPCategory.UpdatedOn);
            _ = objSqlHelper.ExecuteNonQuery("SHP_CategoryUpdate", objParams);
        }
        public int GetParentalIdLevel(int ParentCategoryID)
        {
            //restituisce il LevelCategory del padre
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", ParentCategoryID);
            int LastId = objSqlHelper.ExecuteNonQueryReturnValue("PLS_SHP_GetParentalIdLevel", objParams);
            return LastId;
        }
        public int GetCategoryIdByNameRW(string NameRw)
        {
            //restituisce il LevelCategory del padre
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@NameRw", NameRw);
            //int LastId = objSqlHelper.ExecuteNonQuery("SHP_GetSHPCategoryByNameRW", objParams);
            SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryByNameRW", objParams);
            int CategoryId = -1;
            while (reader.Read())
            {
                _ = new PLS_SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"))
                };
                //AllSHPCategory.Add(SHPCategoryId);
                CategoryId = reader.GetInt32(reader.GetOrdinal("CategoryID"));

            }
            reader.Close();
            return CategoryId;
        }

        //List<SHPCategory> AllSHPCategoryList = new List<SHPCategory>();
        private readonly List<PLS_SHPCategory> AllSHPCategory = new List<PLS_SHPCategory>();
        private readonly List<PLS_SHPCategory> categorySHPWithParents = new List<PLS_SHPCategory>();
        public List<PLS_SHPCategory> GetAllSHPCategoryList()
        {
            string CacheTable = "PLS_SHP_GetAllSHPCategoryList";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                List<PLS_SHPCategory> SHPCategoryLst = new List<PLS_SHPCategory>();
                PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[0];
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetAllSHPCategoryDb", objParams))
                {
                    while (reader.Read())
                    {
                        PLS_SHPCategory SHPCategory = new PLS_SHPCategory
                        {
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                            NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                            ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                            LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                        };
                        SHPCategoryLst.Add(SHPCategory);
                    }
                    reader.Close();
                }
                CacheHelper_23.Insert(CacheTable, SHPCategoryLst);
            }
            return CacheHelper_23.Retrieve<List<PLS_SHPCategory>>(CacheTable);
        }

        public int GetMyParentalID(int CategoryIdVar)
        {
            int returnId = -1;
            _ = new List<PLS_SHPCategory>();
            List<PLS_SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (PLS_SHPCategory list in LShop1)
            {
                if (list.CategoryID == CategoryIdVar)
                {
                    returnId = list.ParentCategoryID;
                    break;
                }
            }
            return returnId;
        }
        public string[] FirstBrandCatego(int BrandId, int MacroCatego)
        {
            string[] RetArray;
            RetArray = new string[2];
            RetArray[0] = "0";
            RetArray[1] = "0";
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@BrandId", BrandId);
            objParams[1] = new SqlParameter("@CatPiccoloGrande", MacroCatego);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_FirstBrandCatego", objParams);
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
        public string[] FirstSubCategoBrandMacrocatego(int CategoryId, int BrandId, int MacroCatego)
        {
            string[] RetArray;
            RetArray = new string[2];
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
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
        public string[] FirstSubCatego(int CategoryId)
        {
            string[] RetArray;
            RetArray = new string[2];
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryId", CategoryId);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetFirstChildCategory", objParams);
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
        public string GetCategoryName(int CategoryIdVar)
        {
            string returnstring = string.Empty;
            _ = new List<PLS_SHPCategory>();
            List<PLS_SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (PLS_SHPCategory list in LShop1)
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
            _ = new List<PLS_SHPCategory>();
            List<PLS_SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (PLS_SHPCategory list in LShop1)
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
            _ = new List<PLS_SHPCategory>();
            List<PLS_SHPCategory> LShop1 = GetAllSHPCategoryList();
            foreach (PLS_SHPCategory list in LShop1)
            {
                if (list.ParentCategoryID == CategoryIdVar)
                {
                    returnId = list.CategoryID;
                    break;
                }
            }
            return returnId;
        }
        public List<PLS_SHPCategory> GetAllHieraticSHPCategory()
        {
            GetAllSHPHieraticCategory();
            return AllSHPCategory;
        }
        public List<PLS_SHPCategory> GetTop1HieraticSHPCategory(int MacroCatego)
        {
            GetTop1SHPHieraticCategory(MacroCatego);
            return AllSHPCategory;
        }
        protected void GetTop1SHPHieraticCategory(int MacroCatego)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetAllSHPCategory", objParams);
            while (reader.Read())
            {
                int varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                if (varParentCategoryID == 0)
                {
                    //PLS_SHPCategory SHPCategory = new PLS_SHPCategory();
                    //SHPCategory.CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                    //SHPCategory.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                    //SHPCategory.NameRw = reader.GetString(reader.GetOrdinal("NameRw"));
                    //SHPCategory.ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                    //SHPCategory.LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"));
                    //SHPCategory.PassInfo = reader.GetString(reader.GetOrdinal("NameRw"));
                    ////SHPCategory.
                    //AllSHPCategory.Add(SHPCategory);
                    GetTop1SHPCategoryChild(varCategoryID, reader.GetString(reader.GetOrdinal("NameRw")), MacroCatego);
                }
            }
            reader.Close();
        }
        protected void GetTop1SHPCategoryChild(int CategoryID, string level, int MacroCatego)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetFirstChildCategory", objParams);
            while (reader.Read())
            {
                _ = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                _ = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                PLS_SHPCategory SHPCategory = new PLS_SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                    DisplayName = level + reader.GetString(reader.GetOrdinal("DisplayName")),
                    NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                    ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                    LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory")),
                    PassInfo = level
                };
                _ = new List<PLS_SHPCategory>();
                //SHPBrandlistLst = GetBrandSHPCategoryChild(reader.GetInt32(reader.GetOrdinal("CategoryID")), MacroCatego);
                //if (SHPBrandlistLst.Count > 0)
                //{
                //    SHPCategory.BrandId = SHPBrandlistLst[0].BrandId;
                //    SHPCategory.BrandNameRW = SHPBrandlistLst[0].BrandNameRW;
                //    SHPCategory.BrandName = SHPBrandlistLst[0].BrandName;
                //    SHPCategory.GerarchiaUrl = SHPBrandlistLst[0].BrandName + "/" + level + "/" + reader.GetString(reader.GetOrdinal("NameRw")) + "/" + reader.GetInt32(reader.GetOrdinal("CategoryID"));
                AllSHPCategory.Add(SHPCategory);
                //}
                //GetAllSHPCategoryChild(varCategoryID, level + "----");
            }
            reader.Close();
        }
        protected List<PLS_SHPCategory> GetBrandSHPCategoryChild(int CategoryID, int MacroCatego)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            List<PLS_SHPCategory> SHPBrandlistLst = new List<PLS_SHPCategory>();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@CategoId", CategoryID);
            objParams[1] = new SqlParameter("@MacroCatego ", MacroCatego);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetBrandInSubCategoAndMacroCatego", objParams);
            while (reader.Read())
            {

                PLS_SHPCategory SHPCategoryBrand = new PLS_SHPCategory
                {
                    BrandId = reader.GetInt32(reader.GetOrdinal("BrandId")),
                    BrandNameRW = reader.GetString(reader.GetOrdinal("NameRW")),
                    BrandName = reader.GetString(reader.GetOrdinal("DisplayName"))
                };
                SHPBrandlistLst.Add(SHPCategoryBrand);
                //GetAllSHPCategoryChild(varCategoryID, level + "----");
            }
            reader.Close();
            return SHPBrandlistLst;
        }
        protected void GetAllSHPHieraticCategory()
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetAllSHPCategory", objParams);
            while (reader.Read())
            {
                int varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                if (varParentCategoryID == 0)
                {
                    PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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


        protected void GetAllSHPCategoryChild(int CategoryID, string level)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSHPCategoryById", objParams);
            while (reader.Read())
            {
                _ = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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

        private readonly List<PLS_SHPCategory> GetUrlGerachiaLst = new List<PLS_SHPCategory>();
        public string GetUrlGerachiaCAtegoBrandMacroCatego(int CategoryID, int BrandId, int MacroCatego, string UrlRW)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
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
                PLS_SHPCategory SHPCategoryGerarchia = new PLS_SHPCategory
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



        public string GetUrlGerachia(int CategoryID, string UrlRW)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetParentalId", objParams);
            string NameRwVar = string.Empty;
            int varParentCategoryID;
            while (reader.Read())
            {
                varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                _ = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                PLS_SHPCategory SHPCategoryGerarchia = new PLS_SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                    NameRw = reader.GetString(reader.GetOrdinal("NameRw"))
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
                    NameRwVar = GetUrlGerachia(varParentCategoryID, reader.GetString(reader.GetOrdinal("NameRw")) + "/" + UrlRW);
                }
                else
                {

                }

            }
            reader.Close();
            return NameRwVar;
        }
        public List<PLS_SHPCategory> GetAllSHPCategoryPrincipali()
        {
            string CacheTable = "PLS_SHP_GetAllSHPCategoryPrincipali";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                List<PLS_SHPCategory> SHPCategoyLst = new List<PLS_SHPCategory>();
                PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[0];
                DataTable dt = new DataTable();
                int Rowcount = 0;
                int RowcountReader = 1;
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetAllSHPCategory", objParams))
                {
                    IDataReader reader2 = reader;
                    dt.Load(reader2);

                    Rowcount = dt.Rows.Count;
                }
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetAllSHPCategory", objParams))
                {
                    while (reader.Read())
                    {
                        PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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
            return CacheHelper_23.Retrieve<List<PLS_SHPCategory>>(CacheTable);
        }
        //public List<SHPCategory> GetAllSHPCategory()
        //{
        //    GetAllSHPCategory();
        //    return AllSHPCategory;
        //}
        public List<PLS_SHPCategory> GetSHPSubCategory(string NameRw)
        {
            //string CacheTable = "SHP_GetSHPCategoryByNameRW";
            //if (!CacheHelper_23.ItemExists(CacheTable))

            int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<PLS_SHPCategory> SHPSubCategoyLst = new List<PLS_SHPCategory>();
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSHPCategoryById", objParams))
            {
                while (reader.Read())
                {
                    PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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
        public DataTable GetCategoryinPromo_V2()
        {
            //string CacheTable = "CacheTableCategoryPromo_v2";
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);

            INTRA.ShopRM.AppCode.SHP_Product_SuperAdmin ProdSuperAdmin = new INTRA.ShopRM.AppCode.SHP_Product_SuperAdmin();
            DataTable ProductInPromoDt = ProdSuperAdmin.GetSHPProductInPromoDT();
            List<PLS_SHPCategory> CategoListReturn = new List<PLS_SHPCategory>();
            foreach (DataRow dr in ProductInPromoDt.Rows)
            {
                _ = new List<PLS_SHPCategory>();
                List<PLS_SHPCategory> CategoLocaleList = GetSHPCategoryByProductId(Convert.ToInt32(dr["ProductId"].ToString()));
                for (int i = 0; i < CategoLocaleList.Count; i++)
                {
                    PLS_SHPCategory SHPCategory = new PLS_SHPCategory
                    {
                        CategoryID = GetCategoryRoot(CategoLocaleList[i].CategoryID)
                    };
                    SHPCategory.DisplayName = GetCategoryName(SHPCategory.CategoryID);
                    SHPCategory.GerarchiaUrl = GetUrlGerachia(SHPCategory.CategoryID, string.Empty);
                    CategoListReturn.Add(SHPCategory);
                }
            }

            _ = new List<PLS_SHPCategory>();

            DataTable table = CollectionHelper.ConvertTo<PLS_SHPCategory>(CategoListReturn);
            table = table.DefaultView.ToTable(true);
            //table.Tables["Employee"].DefaultView.ToTable(true, "employeeid");
            //CategoListReturnDef = CategoListReturn.Distinct();
            //    CacheHelper_23.Insert(CacheTable, CategoListReturnDef);
            //}
            //return CacheHelper_23.Retrieve<List<SHPCategory>>(CacheTable);
            return table;

        }
        public List<PLS_SHPCategory> GetCategoryinPromo()
        {
            string CacheTable = "PLSCacheTableCategoryPromo";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                INTRA.ShopRM.AppCode.SHP_Product_SuperAdmin ProdSuperAdmin = new INTRA.ShopRM.AppCode.SHP_Product_SuperAdmin();
                DataTable ProductInPromoDt = ProdSuperAdmin.GetSHPProductInPromoDT();
                List<PLS_SHPCategory> CategoListReturn = new List<PLS_SHPCategory>();
                foreach (DataRow dr in ProductInPromoDt.Rows)
                {
                    _ = new List<PLS_SHPCategory>();
                    List<PLS_SHPCategory> CategoLocaleList = GetSHPCategoryByProductId(Convert.ToInt32(dr["ProductId"].ToString()));
                    PLS_SHPCategory SHPCategory = new PLS_SHPCategory
                    {
                        CategoryID = GetCategoryRoot(CategoLocaleList[0].CategoryID)
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
            return CacheHelper_23.Retrieve<List<PLS_SHPCategory>>(CacheTable);
        }
        public List<PLS_SHPCategory> GetSubCategoByBrandCategoMacroCatego(int CategoryId, int MacroCatego, int BrandId)
        {
            string CacheTable = "PLSCacheTableSubCategoByBrandCategoMacroCatego" + Convert.ToString(CategoryId) + Convert.ToString(MacroCatego) + Convert.ToString(BrandId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<PLS_SHPCategory> SHPSubCategoyLstByid = new List<PLS_SHPCategory>();
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
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
                    PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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

        public List<PLS_SHPCategory> GetSHPSubCategoryByid(int CategoryId)
        {
            string CacheTable = "PLSCacheTableCategory" + Convert.ToString(CategoryId);
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                List<PLS_SHPCategory> SHPSubCategoyLstByid = new List<PLS_SHPCategory>();
                PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSHPCategoryById", objParams))
                {
                    while (reader.Read())
                    {
                        PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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
            return CacheHelper_23.Retrieve<List<PLS_SHPCategory>>(CacheTable);
        }
        public List<PLS_SHPCategory> GetSHPCategoryDetailsById(int CategoryId)
        {
            string CacheTable = "PLSCacheTableSubCategory" + Convert.ToString(CategoryId);
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);
                List<PLS_SHPCategory> GetSHPCategoryDetailsById = new List<PLS_SHPCategory>();
                PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[1];
                objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSHPCategoryDetailsById", objParams))
                {
                    while (reader.Read())
                    {
                        PLS_SHPCategory SHPCategory = new PLS_SHPCategory
                        {
                            CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                            DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                            Description = reader.GetString(reader.GetOrdinal("Description")),
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
            return CacheHelper_23.Retrieve<List<PLS_SHPCategory>>(CacheTable);
        }
        
        public List<PLS_SHPCategory> GetSHPCategoryByProductId(int ProductId)
        {
            string CacheTable = "CategoryByProductId" + Convert.ToString(ProductId);
            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //int CategoryID = GetCategoryIdByNameRW(NameRw);
            List<PLS_SHPCategory> GenericList = new List<PLS_SHPCategory>();
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ProductId", ProductId);
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryByProductId", objParams))
            {
                while (reader.Read())
                {
                    PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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
        public List<PLS_SHPCategory> GetSHPCategoryPicture()
        {
            string CacheTable = "PLSCacheTableShpCategoryPicture";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                //int CategoryID = GetCategoryIdByNameRW(NameRw);

                List<PLS_SHPCategory> GetSHPCategoryPictureLst = new List<PLS_SHPCategory>();
                PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
                SqlParameter[] objParams = new SqlParameter[0];
                //objParams[0] = new SqlParameter("@CategoryID", CategoryId);
                using (SqlDataReader reader = objSqlHelper.ExecuteReader("SHP_GetSHPCategoryPicture", objParams))
                {
                    while (reader.Read())
                    {
                        PLS_SHPCategory SHPCategory = new PLS_SHPCategory
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
            return CacheHelper_23.Retrieve<List<PLS_SHPCategory>>(CacheTable);
        }

        private readonly List<PLS_SHPCategory> AllPrtCategory = new List<PLS_SHPCategory>();
        private readonly List<PLS_SHPCategory> categoryWithParents = new List<PLS_SHPCategory>();
        public List<PLS_SHPCategory> GetAllHieraticPrtCategory()
        {
            GetAllPrtCategory();
            return AllPrtCategory;
        }
        protected void GetAllPrtCategory()
        {

            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetAllPrtCategory", objParams);
            while (reader.Read())
            {
                int varParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                if (varParentCategoryID == 0)
                {
                    PLS_SHPCategory SHPCategory = new PLS_SHPCategory
                    {
                        CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                        DisplayName = reader.GetString(reader.GetOrdinal("DisplayName")),
                        NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
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
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CategoryID", CategoryID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("PLS_SHP_GetSHPCategoryById", objParams);
            while (reader.Read())
            {
                _ = reader.GetInt32(reader.GetOrdinal("ParentCategoryID"));
                int varCategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID"));
                PLS_SHPCategory SHPCategory = new PLS_SHPCategory
                {
                    CategoryID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
                    DisplayName = level + reader.GetString(reader.GetOrdinal("DisplayName")),
                    NameRw = reader.GetString(reader.GetOrdinal("NameRw")),
                    ParentCategoryID = reader.GetInt32(reader.GetOrdinal("ParentCategoryID")),
                    LevelCategory = reader.GetInt32(reader.GetOrdinal("LevelCategory"))
                };
                AllPrtCategory.Add(SHPCategory);
                GetAllPrtCategoryChild(varCategoryID, level + "----");

            }
            reader.Close();

        }
    }
}