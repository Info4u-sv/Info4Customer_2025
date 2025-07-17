using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    [Serializable]
    public class ProfileInfo
    {
        public string Indirizzo { get; set; }
        public string ImgTecnico { get; set; }
        public string Telefono_d { get; set; }
        public string Telefono { get; set; }
        public string Indirizzo_d { get; set; }
        public string note_d { get; set; }
        public string Cap_d { get; set; }
        public string Company_id { get; set; }
        public string nome { get; set; }
        public string email { get; set; }


        public bool EsistenzaValoreUtente_Check(string NomeCampo, string Filtro, string Tabella)
        {
            bool Esiste = false;


            string SqlString = "Select [" + NomeCampo + "] FROM "+ Tabella + " where "+ NomeCampo+ " ='" + Filtro + "'";

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
                        Esiste = true;
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Esiste;
        }


    }
}