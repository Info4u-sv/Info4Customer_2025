using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.VIO_Utenti.AppCode
{
    public class VIO_Parametri
    {
        public decimal DefaultValue { get; set; }

        public string GetValue(string NomeCampo, string Filtro, string Tabella, string NomeCampoDaFiltrare)
        {
            string Risultato = string.Empty;


            string SqlString = "Select [" + NomeCampo + "] FROM " + Tabella + " where " + NomeCampoDaFiltrare + " ='" + Filtro + "'";

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
                        Risultato = myReader[NomeCampo].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Risultato;
        }



    }
}