using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class Istanze_Generiche
    {

        public string[] GetValue_Generic(string[] NomeCampi, string Filtro, string Tabella)
        {
            string[] Valori = new string[NomeCampi.Count()];
            string NomeCampo = string.Join(",", NomeCampi);

            string SqlString = "Select " + NomeCampo + " FROM " + Tabella + " where " + Filtro + "";

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
                        for (int i = 0; i < NomeCampi.Count(); i++)
                        {
                            Valori[i] = myReader[NomeCampi[i]].ToString();
                        }
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Valori;
        }

        public void UpdateDynamic(string StringaAggiornamento, string NomeTabella, string Filtro)
        {
            // Devo fare un update nella tabella TCK_DettTecniciTicket
            string Command_Txt = " UPDATE [" + NomeTabella + "] set " + StringaAggiornamento + " where " + Filtro;
            using (SqlConnection connection =
                   new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(Command_Txt, connection);
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }

            //PRT_LogErrorGest.Prt_LogOperazioneInsert(Command_Txt, "TCK_TestataTicket", "UPDATE", "info4portaleConnectionString");
        }


        public string[] GetValue_Generic_2(string NomeCampo, string Filtro, string Tabella)
        {
            string[] Valori;
            int RowCount = 0;
            string SqlString = "Select " + NomeCampo + " FROM " + Tabella + " where " + Filtro + "";

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
                DataTable dt = new DataTable();
                dt.Load(myReader);
                int numRows = dt.Rows.Count;
                Valori = new string[numRows];
                myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    retVal = false;
                }
                else
                {
                    while (myReader.Read())
                    {
                        Valori[RowCount] = myReader[NomeCampo].ToString();
                        RowCount += 1;
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Valori;
        }
    }
}