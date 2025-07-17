using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class VIO_Parametri
    {
        public decimal DefaultValue { get; set; }

        public string GetValue(string NomeCampo, string Filtro, string Tabella, string NomeCampoDaFiltrare)
        {
            string Risultato = "";


            string SqlString = "Select [" + NomeCampo + "] FROM " + Tabella + " where " + NomeCampoDaFiltrare + " ='" + Filtro + "'";

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
                        Risultato = myReader[NomeCampo].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Risultato;
        }

        public string GetCount(string NomeCampo, string Filtro, string Tabella, string NomeCampoDaFiltrare)
        {
            string Risultato = "";


            string SqlString = "Select COUNT( [" + NomeCampo + "] ) as " + NomeCampo + " FROM " + Tabella + " where " + NomeCampoDaFiltrare + " ='" + Filtro + "'";

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
                        Risultato = myReader[NomeCampo].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Risultato;
        }

        public string GetValueGestionale(string NomeCampo, string Filtro, string Tabella, string NomeCampoDaFiltrare)
        {
            string Risultato = "";


            string SqlString = "Select [" + NomeCampo + "] FROM " + Tabella + " where " + NomeCampoDaFiltrare + " ='" + Filtro + "'";

            string UserName = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {

                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
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