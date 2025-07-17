using System;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class PRT_DocCategoryVsFolder_Crud
    {
        public int ParentCategoryID { get; set; }
        public int CategoryId { get; set; }
        public string Title { get; set; }
        public string NameRwFolder { get; set; }
        public bool DefaultFolder { get; set; }
        public string DocCategoryRw { get; set; }
        public string PathFolder { get; set; }
        public int LevelCategory { get; set; }
        public string DisplayName { get; set; }
        public string CodCli { get; set; }
        public string Url { get; set; }
        public string EditUser { get; set; }

        public int InsertRow_PRT_DocCategoryVsFolder(PRT_DocCategoryVsFolder_Crud RowItem)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[9];
            Item_IT_Category ClVsFold = new Item_IT_Category();
            objParams[0] = new SqlParameter("@ParentCategoryID", RowItem.ParentCategoryID);
            objParams[1] = new SqlParameter("@NameRwFolder", RowItem.NameRwFolder);
            objParams[2] = new SqlParameter("@DefaultFolder", Convert.ToBoolean(RowItem.DefaultFolder));
            objParams[3] = new SqlParameter("@DocCategoryRw", RowItem.DocCategoryRw);
            objParams[4] = new SqlParameter("@PathFolder", RowItem.PathFolder);
            objParams[5] = new SqlParameter("@LevelCategory", RowItem.LevelCategory);
            objParams[6] = new SqlParameter("@DisplayName", RowItem.DisplayName);
            objParams[7] = new SqlParameter("@CodCli", RowItem.CodCli);
            objParams[8] = new SqlParameter("@EditUser", RowItem.EditUser);
            int LastId = objSqlHelper.ExecuteNonQueryForNews("PRT_DocCategoryVsFolder_INSERT", objParams);
            return LastId;
        }

        public bool GetCustomerFolderExist(string CodCli)
        {

            string SqlString = "SELECT top 1 [CLCCLI] FROM[PRT_DocCategoryVsFolder] where CLCCLI = '" + CodCli + "' and levelcategory = 0";
            //SqlString = string.Format(SqlString, NuovoIdIntervento);

            bool Exist = false;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
#pragma warning disable CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                bool retVal = false;
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {
                        if (myReader["CLCCLI"] != null)
                        {
                            Exist = true;
                        }
                        //lastIdMacchina = Convert.ToInt32(myReader["IdMacchina"].ToString());

                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            return Exist;
        }

        public Tuple<int, int> GetCountOfItBookFolder(string CodCli)
        {

            string SqlString = "SELECT appoggio1.Count, PRT_DocCategoryVsFolder_1.CategoryID FROM (SELECT COUNT(CLCCLI) AS Count FROM PRT_DocCategoryVsFolder WHERE (CLCCLI = '" + CodCli + "') AND (LevelCategory = 1)) AS appoggio1 CROSS JOIN PRT_DocCategoryVsFolder AS PRT_DocCategoryVsFolder_1 WHERE (PRT_DocCategoryVsFolder_1.LevelCategory = 0) and (CLCCLI = '" + CodCli + "')";

            //SqlString = string.Format(SqlString, NuovoIdIntervento);
            int Count = 0;
            int CategoryID = 0;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
#pragma warning disable CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                bool retVal = false;
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {
                        if (myReader["Count"] != null)
                        {
                            Count = Convert.ToInt32(myReader["Count"].ToString());
                            CategoryID = Convert.ToInt32(myReader["CategoryID"].ToString());
                        }
                        //lastIdMacchina = Convert.ToInt32(myReader["IdMacchina"].ToString());

                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            return new Tuple<int, int>(Count, CategoryID);

        }

    }

}