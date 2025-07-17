using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class COB_King_ControlliGenerali
    {
        public string GetCodDocFromNazione(string CodNaz, string Ambito) //Ambito = Ordine-Offerta
        {
            string CodDoc = string.Empty;
            if (Ambito == "Ordine")
            {
                CodDoc = "ORD";
            }
            else { CodDoc = "OFF"; }
            if (CodNaz == "IT")
            {
                CodDoc = CodDoc + "CLI";
            }
            else
            {
                string sql = "SELECT Cee FROM TabNaz WHERE CodNaz = '" + CodNaz + "'";
                bool ritorno = false;
                using (SqlConnection myConnection = new SqlConnection())
                {
                    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = sql;
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
                            ritorno = myReader.GetBoolean(0);
                        }
                    }
                    myReader.Close();
                    myConnection.Close();
                }
                if (ritorno)
                {
                    CodDoc = CodDoc + "CCE";
                }
                else { CodDoc = CodDoc + "CXE"; }
            }

            return CodDoc;
        }
        public string GetCodNazCliente(string CodCli)
        {
            string CodNaz = string.Empty;
            string sql = "Select CodNaz From CLienti WHERE CodCli = '" + CodCli + "'";
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = sql;
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
                        CodNaz = myReader.GetString(0);
                    }
                }
                myReader.Close();
                myConnection.Close();
            }

            return CodNaz;
        }
        public string GetCodNazProspect(int IdProspect)
        {
            string CodNaz = string.Empty;
            string sql = "Select CodNaz From U_INTRA_Prospect WHERE IDProspect = " + IdProspect;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = sql;
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
                        CodNaz = myReader.GetString(0);
                    }
                }
                myReader.Close();
                myConnection.Close();
            }

            return CodNaz;
        }
        public string GetProtocollo(string CodDoc)
        {
            string sql = "SELECT Protocollo FROM TabCodDoc WHERE CodDoc = '" + CodDoc + "'";
            string ritorno = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = sql;
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
                        ritorno = myReader.GetString(0);
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ritorno;
        }
        public string GetCodDocProspect(int IdProspect)
        {
            string CodNaz = GetCodNazProspect(IdProspect);
            return GetCodDocFromNazione(CodNaz, "Offerta");
        }
        public string GetLastOrdNum()
        {
            string sql = @"declare @lastId int
                            Select @lastId = max(ID) From OrdCliTest
                            Select OrdNum From OrdCliTest Where ID = @lastId";
            string ritorno = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = sql;
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
                        ritorno = myReader.GetString(0);
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ritorno;
        }

        public string GetElementFromTable(string table, string element, string where, string type)
        {
            string sql = @"Select {0} From {1} Where {2}";
            sql = string.Format(sql, element, table, where);
            string ritorno = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = sql;
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
                        switch (type)
                        {
                            case "string":
                                ritorno = myReader.GetString(0);
                                break;
                            case "int":
                                ritorno = Convert.ToString(myReader.GetInt32(0));
                                break;
                            case "bool":
                                ritorno = Convert.ToString(myReader.GetBoolean(0));
                                break;
                            case "float":
                                ritorno = Convert.ToString(myReader.GetFloat(0));
                                break;
                        }

                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ritorno;
        }

        public string GetLastElementFromTable(string Element, string Table, string returnType)
        {
            string sql = "SELECT TOP(1) " + Element + " From " + Table + " ORDER BY ID DESC";
            string retval = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = sql;
                myConnection.Open();
                bool CheckVal = false;
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    CheckVal = false;
                }
                else
                {
                    while (myReader.Read())
                    {
                        switch (returnType)
                        {
                            case "string":
                                retval = myReader.GetString(0);
                                break;
                            case "int":
                                retval = Convert.ToString(myReader.GetInt32(0));
                                break;
                            case "bool":
                                retval = Convert.ToString(myReader.GetBoolean(0));
                                break;
                            case "float":
                                retval = Convert.ToString(myReader.GetFloat(0));
                                break;
                        }

                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return retval;
        }
    }
}