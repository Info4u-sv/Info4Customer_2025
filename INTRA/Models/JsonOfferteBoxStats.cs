using Info4U;
using INTRA.Models;
using System.Data.SqlClient;

namespace WebService4u.Models
{
    public class JsonOfferteBoxStats : JsonGetPorbFatturato
    {
        public int TotOfferte { get; set; }
        public int TotChiuse { get; set; }
        public int TotEvase { get; set; }
        public int TotRifiutate { get; set; }
        public string Last { get; set; }
        public string LastCode { get; set; }



        public static JsonOfferteBoxStats GetOfferteStats(int Anno)
        {
            JsonGetPorbFatturato Prob = GetStats(Anno);
            JsonOfferteBoxStats retval = new JsonOfferteBoxStats();
            string sql = @"SELECT        Offerte_Tot.TotaleOfferte, Chiuse.TotaleChiuse, Evase.TotaleEvase, Rifiutate.TotaleRifiutate, LastCode.NomeUltimo, LastCode.LastCliOff
FROM            (SELECT        COUNT(ID) AS TotaleOfferte
                          FROM            U_CRM_OrdCliTest
                          WHERE        (TipoDoc = 'RC') AND (Anno = {0})) AS Offerte_Tot CROSS JOIN
                             (SELECT        COUNT(ID) AS TotaleChiuse
                               FROM            U_CRM_OrdCliTest AS U_CRM_OrdCliTest_3
                               WHERE        (ID IS NOT NULL) AND (FlagEvaso = 3) AND (U_Motivazione IS NULL) AND (TipoDoc = 'RC') AND (Anno = {0})) AS Chiuse CROSS JOIN
                             (SELECT        COUNT(ID) AS TotaleEvase
                               FROM            U_CRM_OrdCliTest AS U_CRM_OrdCliTest_2
                               WHERE        (ID IS NOT NULL) AND (FlagEvaso = 2) AND (TipoDoc = 'RC') AND (Anno = {0})) AS Evase CROSS JOIN
                             (SELECT        COUNT(ID) AS TotaleRifiutate
                               FROM            U_CRM_OrdCliTest AS U_CRM_OrdCliTest_1
                               WHERE        (ID IS NOT NULL) AND (FlagEvaso = 3) AND (U_Motivazione IS NOT NULL) AND (TipoDoc = 'RC') AND (Anno = {0})) AS Rifiutate CROSS JOIN
                             (SELECT        TOP (1) CONVERT(int, RIGHT(U_CRM_OrdCliTest_4.CodCli, 4)) AS LastCliOff, Clienti.Denom AS NomeUltimo
                               FROM            U_CRM_OrdCliTest AS U_CRM_OrdCliTest_4 INNER JOIN
                                                         Clienti ON U_CRM_OrdCliTest_4.CodCli = Clienti.CodCli
                               WHERE        (U_CRM_OrdCliTest_4.Anno = {0}  AND (U_CRM_OrdCliTest_4.TipoDoc='RC'))
                               ORDER BY U_CRM_OrdCliTest_4.ID DESC) AS LastCode";
            sql = string.Format(sql, Anno);

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
                        retval.TotOfferte = (int)sqlDataReader["TotaleOfferte"];
                        retval.TotChiuse = (int)sqlDataReader["TotaleChiuse"];
                        retval.TotEvase = (int)sqlDataReader["TotaleEvase"];
                        retval.TotRifiutate = (int)sqlDataReader["TotaleRifiutate"];
                        retval.Last = sqlDataReader["NomeUltimo"].ToString();
                        retval.LastCode = sqlDataReader["LastCliOff"].ToString();
                    }
                }

            }

            retval.TotaleValoreOff = Prob.TotaleValoreOff;
            retval.TotaleProbValOff = Prob.TotaleProbValOff;
            retval.ProbPercOfferte = Prob.ProbPercOfferte;
            return retval;
        }
    }
}