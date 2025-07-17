using info4lab;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class PRT_Utenti_SA
    {
        public int ID { get; set; }

        public string GetUtenteById(string Id)
        {
            string SqlString = "Select [UserName] FROM [dbo].[vw_aspnet_Users] where UserId ='" + Id + "'";

            string UserName = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {

                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    retVal = false;
                }

                else
                {
                    while (myReader.Read())
                    {
                        UserName = myReader["UserName"].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return UserName;
        }

        public void VIO_Utenti_Sospensione(PRT_Utenti_SA setting)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", setting.ID);
           
            objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Sospensione", objParams);
        }


        public void VIO_Utenti_Riattivazione(PRT_Utenti_SA setting)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", setting.ID);

            objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Riattivazione", objParams);
        }

    }

}