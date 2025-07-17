using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class SHPSql4Helper
    {
        private readonly string strConnectionString = string.Empty;
        //private string myCnn = String.Empty;

        public SHPSql4Helper()
        {
            strConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            //myCnn = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
        }


        public static SqlConnection Getinfo4Connection()
        {
            string connstr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            return new SqlConnection(connstr);
        }
        public static string Getinfo4StringConnection()
        {
            string connstr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            return connstr;
        }
        public SqlDataReader ExecuteReader(string query)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("SELECT") | query.StartsWith("select"))
            {
                cnn.Open();
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cnn.Open();
            }
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        public SqlDataReader ExecuteReader(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn)
            {
                CommandType = query.StartsWith("SELECT") | query.StartsWith("select") ? CommandType.Text : CommandType.StoredProcedure
            };
            int i;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                _ = cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        public bool ExecuteReaderForPrincImg(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn)
            {
                CommandType = query.StartsWith("SELECT") | query.StartsWith("select") ? CommandType.Text : CommandType.StoredProcedure
            };
            int i;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                _ = cmd.Parameters.Add(parameters[i]);
                cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            cnn.Open();
            _ = cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToBoolean(cmd.Parameters["ReturnValue"].Value);
        }

        public int ExecuteNonQuery(string query)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn)
            {
                CommandType = query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete")
                ? CommandType.Text
                : CommandType.StoredProcedure
            };
            int retval = 0;
            try
            {
                cnn.Open();
                retval = cmd.ExecuteNonQuery();
            }
            catch (Exception exp)
            {
                throw exp;
            }
            finally
            {
                if (cnn.State == ConnectionState.Open)
                {
                    cnn.Close();
                }
            }

            return retval;
        }

        public int ExecuteNonQuery(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn)
            {
                CommandType = query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete")
                ? CommandType.Text
                : CommandType.StoredProcedure
            };
            int i;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                _ = cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            int retval = cmd.ExecuteNonQuery();
            cnn.Close();
            return retval;
        }

        public int ExecuteNonQueryForNews(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            int i;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                _ = cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            _ = cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToInt32(cmd.Parameters["ReturnValue"].Value);
        }
        public int ExecuteNonQueryReturnValue(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            int i;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                _ = cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            _ = cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToInt32(cmd.Parameters["ReturnValue"].Value);
        }
        public int ExecuteScalarReturnId(string query, params SqlParameter[] parameters)
        {
            object returnValue;
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn)
            {
                CommandType = query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete")
                ? CommandType.Text
                : CommandType.StoredProcedure
            };
            int i;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                _ = cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            //ReturnId = (Int32)cmd.ExecuteScalar();
            //cmd.ExecuteScalar();
            returnValue = cmd.ExecuteScalar();

            cnn.Close();
            return Convert.ToInt32(returnValue);
        }
    }
}