using System.Configuration;
using System.Data.SqlClient;

namespace WebService4u.Models
{
    public class PRT_Parameter
    {
        public static string GetTemplateMail(string CodParam)
        {
            string ReturnTemplate = string.Empty;

            {

                string SqlString = "select PRT_Parameter.[Value] from  PRT_Parameter where CodParam = '{0}'";

                SqlString = string.Format(SqlString, CodParam);
                using (SqlConnection myConnection = new SqlConnection())
                {
                    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = SqlString;
                    myConnection.Open();
                    SqlDataReader myReader = myCommand.ExecuteReader();
                    if (!myReader.HasRows)
                    { ReturnTemplate = string.Empty; }

                    else
                    {
                        while (myReader.Read())
                        {
                            ReturnTemplate = myReader["Value"].ToString();
                        }
                    }
                    myReader.Close();
                    myConnection.Close();
                }


                return ReturnTemplate;
            }

        }

        public static string GetParameterValue(string CodParam)
        {
            string ReturnTemplate = string.Empty;
            {
                string SqlString = "select PRT_Parameter.[Value] from  PRT_Parameter where CodParam = '{0}'";
                SqlString = string.Format(SqlString, CodParam);
                using (SqlConnection myConnection = new SqlConnection())
                {
                    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = SqlString;
                    myConnection.Open();
                    SqlDataReader myReader = myCommand.ExecuteReader();
                    if (!myReader.HasRows)
                    { ReturnTemplate = string.Empty; }

                    else
                    {
                        while (myReader.Read())
                        {
                            ReturnTemplate = myReader["Value"].ToString();
                        }
                    }
                    myReader.Close();
                    myConnection.Close();
                }
                return ReturnTemplate;
            }

        }

    }
}