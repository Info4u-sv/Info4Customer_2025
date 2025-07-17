using info4lab;
using INTRA.AppCode;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.SuperAdmin.AppCode
{

    public class PRT_Utenti_SA
    {
        public string Cognome { get; set; }

        public string FirmaTecnico { get; set; }

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

        public PRT_Utenti_SA GetTecnicoByPushCode(string PushCode)
        {
            string SqlString = "SELECT [FirmaBase64], Cognome FROM  [PRT_DipendentiAna] where pushtoken = '{0}'";
            SqlString = string.Format(SqlString, PushCode);
            string FirmaTecnico = string.Empty;

            PRT_Utenti_SA Dati = new AppCode.PRT_Utenti_SA();
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
                        Dati.FirmaTecnico = myReader["FirmaBase64"].ToString();
                        Dati.Cognome = myReader["Cognome"].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Dati;
        }

        public void Dashboard_User_Insert(string NomeUtente)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];

            objParams[0] = new SqlParameter("@Utente", NomeUtente);
            //COL_Rapportini_NoteTecnico_Edit
            objSqlHelper.ExecuteNonQueryForNews("Dashboard_User_Insert", objParams);

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