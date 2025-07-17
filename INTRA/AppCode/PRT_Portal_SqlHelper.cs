using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

/// <summary>
/// Descrizione di riepilogo per SqlHelper
/// </summary>
/// 
namespace info4lab
{
    public class Sql4PortalHelper
    {
        private string strConnectionString = String.Empty;
        //private string myCnn = String.Empty;

        public Sql4PortalHelper()
        {
            //strConnectionString = ConfigurationManager.ConnectionStrings["CobraAnaConnectionString"].ConnectionString;

            strConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
        }


        public static SqlConnection Getinfo4Connection()
        {
            string connstr = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            return new SqlConnection(connstr);
        }
        public static String Getinfo4StringConnection()
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
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("SELECT") | query.StartsWith("select"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        public bool ExecuteReaderForPrincImg(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("SELECT") | query.StartsWith("select"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
                cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToBoolean(cmd.Parameters["ReturnValue"].Value);
        }

        public int ExecuteNonQuery(string query)
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
            }
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
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
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
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
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
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToInt32(cmd.Parameters["ReturnValue"].Value);
        }
        public int ExecuteScalarReturnId(string query, params SqlParameter[] parameters)
        {

            Object returnValue;
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            //ReturnId = (Int32)cmd.ExecuteScalar();
            //cmd.ExecuteScalar();
            returnValue = cmd.ExecuteScalar();

            cnn.Close();
            return Convert.ToInt32(returnValue);
        }

        public Array ExecuteNonQueryReturnArrayValueString(string query, int numCampi, params SqlParameter[] parameters)
        {
            // uso questa funzione per ritornare il valore di un campo della select 
            string[] returnstring = new string[100];
            using (SqlDataReader reader = ExecuteReader(query, parameters))
            {
                while (reader.Read())
                {
                    for (int i = 0; i <= (numCampi - 1); i++)
                    {
                        returnstring[i] = reader.GetString(i);
                    }

                }
                reader.Close();
            }
            return returnstring;
        }
    }

    public class Gestionale4PortalHelper
    {
        private string strConnectionString = String.Empty;
        //private string myCnn = String.Empty;

        public Gestionale4PortalHelper()
        {
            //strConnectionString = ConfigurationManager.ConnectionStrings["CobraAnaConnectionString"].ConnectionString;

            strConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
        }


        public static SqlConnection Getinfo4Connection()
        {
            string connstr = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;

            return new SqlConnection(connstr);
        }
        public static String Getinfo4StringConnection()
        {
            string connstr = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;

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
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("SELECT") | query.StartsWith("select"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        public bool ExecuteReaderForPrincImg(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("SELECT") | query.StartsWith("select"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
                cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToBoolean(cmd.Parameters["ReturnValue"].Value);
        }

        public int ExecuteNonQuery(string query)
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
            }
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
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
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
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
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
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToInt32(cmd.Parameters["ReturnValue"].Value);
        }
        public int ExecuteScalarReturnId(string query, params SqlParameter[] parameters)
        {

            Object returnValue;
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            //ReturnId = (Int32)cmd.ExecuteScalar();
            //cmd.ExecuteScalar();
            returnValue = cmd.ExecuteScalar();

            cnn.Close();
            return Convert.ToInt32(returnValue);
        }

        public Array ExecuteNonQueryReturnArrayValueString(string query, int numCampi, params SqlParameter[] parameters)
        {
            // uso questa funzione per ritornare il valore di un campo della select 
            string[] returnstring = new string[100];
            using (SqlDataReader reader = ExecuteReader(query, parameters))
            {
                while (reader.Read())
                {
                    for (int i = 0; i <= (numCampi - 1); i++)
                    {
                        returnstring[i] = reader.GetString(i);
                    }

                }
                reader.Close();
            }
            return returnstring;
        }
    }
    public class King4PortalHelper
    {
        private string strConnectionString = String.Empty;
        //private string myCnn = String.Empty;

        public King4PortalHelper()
        {
            //strConnectionString = ConfigurationManager.ConnectionStrings["CobraAnaConnectionString"].ConnectionString;

            strConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
        }


        public static SqlConnection Getinfo4Connection()
        {
            string connstr = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;

            return new SqlConnection(connstr);
        }
        public static String Getinfo4StringConnection()
        {
            string connstr = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;

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
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("SELECT") | query.StartsWith("select"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }

        public bool ExecuteReaderForPrincImg(string query, params SqlParameter[] parameters)
        {
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("SELECT") | query.StartsWith("select"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
                cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToBoolean(cmd.Parameters["ReturnValue"].Value);
        }

        public int ExecuteNonQuery(string query)
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
            }
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
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
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
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
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
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            cmd.ExecuteNonQuery();
            cnn.Close();
            return Convert.ToInt32(cmd.Parameters["ReturnValue"].Value);
        }
        public int ExecuteScalarReturnId(string query, params SqlParameter[] parameters)
        {

            Object returnValue;
            SqlConnection cnn = new SqlConnection(strConnectionString);
            SqlCommand cmd = new SqlCommand(query, cnn);
            if (query.StartsWith("INSERT") | query.StartsWith("insert") | query.StartsWith("UPDATE") | query.StartsWith("update") | query.StartsWith("DELETE") | query.StartsWith("delete"))
            {
                cmd.CommandType = CommandType.Text;
            }
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add("ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            }
            int i = 0;
            for (i = 0; i <= parameters.Length - 1; i++)
            {
                cmd.Parameters.Add(parameters[i]);
            }
            cnn.Open();
            //ReturnId = (Int32)cmd.ExecuteScalar();
            //cmd.ExecuteScalar();
            returnValue = cmd.ExecuteScalar();

            cnn.Close();
            return Convert.ToInt32(returnValue);
        }

        public Array ExecuteNonQueryReturnArrayValueString(string query, int numCampi, params SqlParameter[] parameters)
        {
            // uso questa funzione per ritornare il valore di un campo della select 
            string[] returnstring = new string[100];
            using (SqlDataReader reader = ExecuteReader(query, parameters))
            {
                while (reader.Read())
                {
                    for (int i = 0; i <= (numCampi - 1); i++)
                    {
                        returnstring[i] = reader.GetString(i);
                    }

                }
                reader.Close();
            }
            return returnstring;
        }
    }
}