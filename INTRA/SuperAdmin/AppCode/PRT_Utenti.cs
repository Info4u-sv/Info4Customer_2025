using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.SuperAdmin.AppCode
{
    public class PRT_Utenti
    {
        public string Cognome { get; set; }

        public string FirmaTecnico { get; set; }

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

        public PRT_Utenti GetTecnicoByPushCode(string PushCode)
        {
            string SqlString = "SELECT [FirmaBase64], Cognome FROM  [PRT_DipendentiAna] where pushtoken = '{0}'";
            SqlString = string.Format(SqlString, PushCode);
            string FirmaTecnico = string.Empty;

            PRT_Utenti Dati = new AppCode.PRT_Utenti();
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

    }

}