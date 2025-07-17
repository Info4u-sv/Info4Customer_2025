using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class PRT_ItemMenu_SA
    {
        public int ParentId { get; set; }
        public int CategoryId { get; set; }
        public string Title { get; set; }
        public string Url { get; set; }

        public IList<PRT_ItemMenu_SA> GetItemMenu(string UserLogin)
        {

            string SqlString = " SELECT * , tbl_um_privilege.read_permission, tbl_um_privilege.user_id_fk FROM PRT_Menus INNER JOIN  tbl_um_privilege ON PRT_Menus.MenuId = tbl_um_privilege.form_id_fk WHERE (tbl_um_privilege.read_permission = 1) AND (tbl_um_privilege.user_id_fk = '" + UserLogin + "' ) and IsVisible = 1 order by DisplayOrder";

            List<PRT_ItemMenu_SA> _GetItemMenu = new List<PRT_ItemMenu_SA>();


            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = SqlString
                };
                myConnection.Open();

                SqlDataReader myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    PRT_ItemMenu_SA _ItemMenuRow = new PRT_ItemMenu_SA
                    {
                        CategoryId = Convert.ToInt32(myReader["MenuId"].ToString()),
                        ParentId = Convert.ToInt32(myReader["ParentMenuId"].ToString()),
                        Title = myReader["Title"].ToString(),
                        Url = myReader["Url"].ToString()
                    };
                    _GetItemMenu.Add(_ItemMenuRow);
                }
                myReader.Close();
                myConnection.Close();
            }
            return _GetItemMenu;
        }

    }

}