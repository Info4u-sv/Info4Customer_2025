using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class Item_IT_Category
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

        public IList<Item_IT_Category> GetItemItCategory()
        {

            string SqlString = " SELECT [CategoryId]      ,[ParentCategoryId]      ,[Title]      ,[Description]      ,[Url]      ,[DisplayOrder]      ,[IsVisible]      ,[material_icons]  FROM [PRT_IT_Category]";

            List<Item_IT_Category> _GetItemMenu = new List<Item_IT_Category>();


            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();

                SqlDataReader myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    Item_IT_Category _ItemCategoryRow = new Item_IT_Category();
                    _ItemCategoryRow.CategoryId = Convert.ToInt32(myReader["CategoryId"].ToString());
                    _ItemCategoryRow.ParentCategoryID = Convert.ToInt32(myReader["ParentCategoryId"].ToString());
                    _ItemCategoryRow.Title = myReader["Title"].ToString();
                    _ItemCategoryRow.Url = myReader["Url"].ToString();
                    _GetItemMenu.Add(_ItemCategoryRow);
                }
                myReader.Close();
                myConnection.Close();
            }
            return _GetItemMenu;
        }
    }


}