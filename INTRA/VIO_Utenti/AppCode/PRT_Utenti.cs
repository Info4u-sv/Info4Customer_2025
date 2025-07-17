using info4lab;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.VIO_Utenti.AppCode
{
    public class PRT_Utenti
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
                        UserName = myReader["UserName"].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return UserName;
        }

        public void VIO_Utenti_Sospensione(PRT_Utenti setting)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", setting.ID);

            objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Sospensione", objParams);
        }


        public void VIO_Utenti_Riattivazione(PRT_Utenti setting)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", setting.ID);

            objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Riattivazione", objParams);
        }

    }

}