using Info4U;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;

namespace WebService4u.Models
{
    public class JsonOfferteKingStat
    {
        public int Anno { get; set; }
        public string MeseText { get; set; }
        public int Mese { get; set; }
        public int TotOfferte { get; set; }
        public decimal TotOfferteEuro { get; set; }
        public static List<JsonOfferteKingStat> GetJsonOfferteKingStats_List(string DocType)
        {
            CultureInfo culture = new CultureInfo(CultureInfo.CurrentCulture.ToString());
            List<JsonOfferteKingStat> jsonList = new List<JsonOfferteKingStat>();
            string SqlTxt = @"SELECT YEAR(OrdDat) AS Anno, MONTH(OrdDat) AS Mese, COUNT(OrdNum) AS TotOfferte
                        FROM  U_CRM_OrdCliTest
                        WHERE (TipoDoc = '{0}') AND (CodCli IS NOT NULL)
                        GROUP BY MONTH(OrdDat), YEAR(OrdDat)
                        ORDER BY Anno, Mese, TotOfferte";
            SqlTxt = string.Format(SqlTxt, DocType);
            using (SqlConnection sqlConnection = WebUtils.GetSqlConGestionale())
            {
                sqlConnection.Open();
                using (SqlCommand sqlCommand = new SqlCommand(SqlTxt, sqlConnection))

                using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
                {
                    while (sqlDataReader.Read())
                    {
                        jsonList.Add(new JsonOfferteKingStat()
                        {
                            Anno = (int)sqlDataReader["Anno"],
                            Mese = (int)sqlDataReader["Mese"],
                            MeseText = culture.DateTimeFormat.GetMonthName((int)sqlDataReader["Mese"]),
                            TotOfferteEuro = GetTotMonthEuro((int)sqlDataReader["Mese"], (int)sqlDataReader["Anno"], DocType),
                            TotOfferte = (int)sqlDataReader["TotOfferte"]
                        });
                    }
                }
            }

            return jsonList;
        }

        //public static Dictionary<string,List<JsonOfferteKingStat>> GetJsonOfferteKingStats_Dictionary()
        //{
        //    Dictionary<string, List<JsonOfferteKingStat>> result = new Dictionary<string, List<JsonOfferteKingStat>>();
        //    List<JsonOfferteKingStat> jsonList = new List<JsonOfferteKingStat>();
        //    List<int> anni = new List<int>();
        //    string sql = @"SELECT YEAR(DataOfferta) AS Anno
        //                    FROM  U_CRM4U_OfferteTest_1_7_3
        //                    WHERE (TipoDoc = 'OC') AND (CodCli IS NOT NULL)
        //                    GROUP BY YEAR(DataOfferta)";
        //    using (SqlConnection sqlConnection = WebUtils.GetSqlConGestionale())
        //    {
        //        sqlConnection.Open();
        //        using (SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection))

        //        using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
        //        {
        //            while (sqlDataReader.Read())
        //            {
        //                anni.Add(sqlDataReader.GetInt32(0));
        //                //jsonList.Add(new JsonOfferteKingStat()
        //                //{
        //                //    Anno = (int)(sqlDataReader["Anno"]),
        //                //    Mese = (int)sqlDataReader["Mese"],
        //                //    TotOfferte = (int)sqlDataReader["TotOfferte"]
        //                //});
        //            }
        //        }
        //    }


        //    foreach(int anno in anni)
        //    {
        //        int actualMonth = 0;
        //        sql = @"SELECT MONTH(DataOfferta) AS Mese, COUNT(OffNum) AS TotOfferte
        //                    FROM  U_CRM4U_OfferteTest_1_7_3
        //                    WHERE (TipoDoc = 'OC') AND (CodCli IS NOT NULL) AND (YEAR(DataOfferta)={0})
        //                    GROUP BY YEAR(DataOfferta),MONTH(DataOfferta)";
        //        sql = string.Format(sql, anno);
        //        using (SqlConnection sqlConnection = WebUtils.GetSqlConGestionale())
        //        {
        //            JsonOfferteKingStat J = new JsonOfferteKingStat();
        //            sqlConnection.Open();
        //            using (SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection))

        //            using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
        //            {
        //                while (sqlDataReader.Read())
        //                {
        //                        if((int)sqlDataReader["Mese"] == J.Mesi[actualMonth])
        //                        {
        //                        string mese = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(J.Mesi[actualMonth]);
        //                            jsonList.Add(new JsonOfferteKingStat()
        //                            {
        //                                Mese = (int)(sqlDataReader["Mese"]),
        //                                TotOfferte = (int)(sqlDataReader["TotOfferte"])
        //                            });
        //                    }
        //                    else {
        //                        while ((int)sqlDataReader["Mese"] < J.Mesi[actualMonth])
        //                        {
        //                            jsonList.Add(new JsonOfferteKingStat()
        //                            {
        //                                Mese = J.Mesi[actualMonth],
        //                                TotOfferte = 0
        //                            });
        //                            actualMonth++;
        //                        }
        //                    }
        //                    actualMonth++;
        //                    if(actualMonth >= 12) { break; }
        //                }
        //            }
        //        }
        //        //string[,] test = jsonList.ToArray();
        //        //for(int i = 0; i < test.Length; i++)
        //        //{

        //        //}
        //        result.Add(anno.ToString(), jsonList);
        //        jsonList.Clear();
        //    }
        //    return result;
        //}





        //public override string ToString()
        //{

        //    string Obj = "{Anno : "+Anno+",";
        //    for(int i = 0; i < 12; i++)
        //    {
        //        string Mese = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Mesi[i]);
        //        if(i != 11)
        //        {
        //            Obj += "" + Mese + " : " + Values[i] + "," ;
        //        }
        //        else
        //        {
        //            Obj += "" + Mese + " : " + Values[i] ;
        //        }

        //    }
        //    Obj += "}";

        //    return Obj;
        //}

        public static decimal GetTotMonthEuro(int month, int anno, string DocType)
        {
            decimal result = 0;
            string SqlTxt = @"Select SUM(TotImp) as totale 
                            From U_CRM_OrdCliTest
                            Where (MONTH(OrdDat) =  {0}) AND (YEAR(OrdDat) = {1}) AND (TipoDoc = '{2}')
";
            SqlTxt = string.Format(SqlTxt, month, anno, DocType);
            using (SqlConnection sqlConnection = WebUtils.GetSqlConGestionale())
            {
                sqlConnection.Open();
                //using (SqlCommand sqlCommand = new SqlCommand(SqlTxt, sqlConnection))
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandText = SqlTxt;
                SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                if (sqlDataReader.HasRows)
                {
                    while (sqlDataReader.Read())
                    {
                        result = Convert.ToDecimal(sqlDataReader["totale"]);
                    }
                }

            }

            return result;
        }
        public static List<JsonOfferteKingStat> GetStatsByYear(int year, string DocType)
        {
            CultureInfo culture = new CultureInfo(CultureInfo.CurrentCulture.ToString());
            List<JsonOfferteKingStat> result = new List<JsonOfferteKingStat>();
            List<JsonOfferteKingStat> ListaAppoggio = new List<JsonOfferteKingStat>();
            string sql = @"SELECT YEAR(OrdDat) as Anno,MONTH(OrdDat) AS Mese, COUNT(OrdNum) AS TotOfferte
                            FROM  U_CRM_OrdCliTest
                            WHERE (TipoDoc = '{0}') AND (CodCli IS NOT NULL) AND (YEAR(OrdDat)={1})
                            GROUP BY YEAR(OrdDat),MONTH(OrdDat)";
            sql = string.Format(sql, DocType, year);
            using (SqlConnection sqlConnection = WebUtils.GetSqlConGestionale())
            {

                sqlConnection.Open();
                using (SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection))

                using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
                {
                    while (sqlDataReader.Read())
                    {
                        result.Add(new JsonOfferteKingStat()
                        {
                            Anno = (int)sqlDataReader["Anno"],
                            Mese = (int)sqlDataReader["Mese"],
                            MeseText = culture.DateTimeFormat.GetMonthName((int)sqlDataReader["Mese"]),
                            TotOfferteEuro = GetTotMonthEuro((int)sqlDataReader["Mese"], year, DocType),
                            TotOfferte = (int)sqlDataReader["TotOfferte"],

                        });
                    }
                }
            }
            return result;
        }

    }

}