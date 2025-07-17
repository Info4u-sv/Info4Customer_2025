using Info4U;
using System.Data.SqlClient;
namespace WebService4u.Models
{
    public class JsonClientiBoxStats
    {
        public int TotaleCli { get; set; }
        public int LastCodCli { get; set; }
        public string LastCli { get; set; }


        public static JsonClientiBoxStats GetClientiStats()
        {
            JsonClientiBoxStats retval = new JsonClientiBoxStats();
            string sql = @"SELECT        COUNT(*) AS Totale, Ultimo.LastCodCli, Ultimo.Denom
FROM            Clienti CROSS JOIN
                             (SELECT        TOP (1)  CONVERT(int, RIGHT(CodCli, 4)) as LastCodCli, Denom
                               FROM            Clienti AS Clienti_1
                               ORDER BY CONVERT(int, RIGHT(CodCli, 4)) DESC) AS Ultimo
GROUP BY Ultimo.LastCodCli, Ultimo.Denom";

            using (SqlConnection sqlConnection = WebUtils.GetSqlConGestionale())
            {
                sqlConnection.Open();
                //using (SqlCommand sqlCommand = new SqlCommand(SqlTxt, sqlConnection))
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandText = sql;
                SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                if (sqlDataReader.HasRows)
                {
                    while (sqlDataReader.Read())
                    {
                        retval.TotaleCli = (int)sqlDataReader["Totale"];
                        retval.LastCli = sqlDataReader["Denom"].ToString();
                        retval.LastCodCli = (int)sqlDataReader["LastCodCli"];
                    }
                }

            }

            return retval;
        }
    }
}