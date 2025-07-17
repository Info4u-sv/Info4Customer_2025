using Info4U;
using System.Data.SqlClient;

namespace WebService4u.Models
{
    public class JsonOrdiniBoxStats
    {
        public int TotaleOrdini { get; set; }
        public int LastCodCliOrdini { get; set; }
        public string LastCliOrd { get; set; }

        public static JsonOrdiniBoxStats GetOrdiniStats(int anno)
        {
            JsonOrdiniBoxStats retval = new JsonOrdiniBoxStats();
            string sql = @"SELECT        Ordini_Tot.TotaleOrdini, LastCode.NomeUltimo, LastCode.LastCliOrd
FROM            (SELECT        COUNT(ID) AS TotaleOrdini
                          FROM            U_CRM_OrdCliTest
                          WHERE        (TipoDoc = 'OC') AND (Anno = {0})) AS Ordini_Tot CROSS JOIN
                             (SELECT        TOP (1) CONVERT(int, RIGHT(U_CRM_OrdCliTest_4.CodCli, 4)) AS LastCliOrd, Clienti.Denom AS NomeUltimo
                               FROM            U_CRM_OrdCliTest AS U_CRM_OrdCliTest_4 INNER JOIN
                                                         Clienti ON U_CRM_OrdCliTest_4.CodCli = Clienti.CodCli
                               WHERE        (U_CRM_OrdCliTest_4.Anno = {0}) AND (U_CRM_OrdCliTest_4.TipoDoc = 'OC')
                               ORDER BY U_CRM_OrdCliTest_4.ID DESC) AS LastCode";
            sql = string.Format(sql, anno);
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
                        retval.TotaleOrdini = (int)sqlDataReader["TotaleOrdini"];
                        retval.LastCodCliOrdini = (int)sqlDataReader["LastCliOrd"];
                        retval.LastCliOrd = sqlDataReader["NomeUltimo"].ToString();
                    }
                }

            }
            return retval;
        }
    }
}