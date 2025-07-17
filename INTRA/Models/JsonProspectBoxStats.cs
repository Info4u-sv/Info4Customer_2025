using Info4U;
using System.Data.SqlClient;

namespace WebService4u.Models
{
    public class JsonProspectBoxStats
    {
        public int TotaleProspect { get; set; }
        public int LastCodP { get; set; }
        public string LastProspect { get; set; }

        public static JsonProspectBoxStats GetProspectStats()
        {
            JsonProspectBoxStats retval = new JsonProspectBoxStats();

            string sql = @"declare @LastProspect nvarchar(max)
                           declare @LastId int
                           Select top(1) @LastProspect = Denom,@LastId = ID From CRM4U_Prospect_Clienti Where Prospect = 1 Order by ID desc
                           Select Count(*) as Totale, @LastProspect as LastProspect,@LastId as LastId From CRM4U_Prospect_Clienti Where Prospect = 1";
            using (SqlConnection sqlConnection = WebUtils.GetSqlConnection())
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
                        retval.TotaleProspect = (int)sqlDataReader["Totale"];
                        retval.LastProspect = sqlDataReader["LastProspect"].ToString();
                        retval.LastCodP = (int)sqlDataReader["LastId"];
                    }
                }

            }

            return retval;
        }
    }

}
