using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class PRT_Utenti
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
                        UserName = myReader["UserName"].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return UserName;
        }

        public PRT_Utenti GetTecnicoByPushCode(string PushCode)
        {
            string SqlString = "SELECT [FirmaBase64], Cognome FROM  [PRT_DipendentiAna] where pushtoken = '{0}'";
            SqlString = string.Format(SqlString, PushCode);
            PRT_Utenti Dati = new AppCode.PRT_Utenti();
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
                if (!myReader.HasRows)
                {
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
            _ = objSqlHelper.ExecuteNonQueryForNews("Dashboard_User_Insert", objParams);

        }
        public void VIO_Utenti_Sospensione(PRT_Utenti setting)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", setting.ID);

            _ = objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Sospensione", objParams);
        }


        public void VIO_Utenti_Riattivazione(PRT_Utenti setting)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", setting.ID);

            _ = objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Riattivazione", objParams);
        }


        public string CodCliAssociato_Get(string Username)
        {
            string SqlString = "SELECT  [CodCli]  FROM [VIO_Utenti] where [UtenteIntranet] = '" + Username + "'";

            string CodCli = string.Empty;
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
                        CodCli = myReader["CodCli"].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return CodCli;
        }

    }

}