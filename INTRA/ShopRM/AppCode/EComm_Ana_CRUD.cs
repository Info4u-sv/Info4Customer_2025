using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class EComm_Ana_CRUD
    {
        public int ID { get; set; }

        public bool Bonifico { get; set; }

        public bool Paypal { get; set; }

        public string BonificoDescr { get; set; }

        public int MinScorta { get; set; }

        public string ProdottoEsaurito { get; set; }

        public string ConsegnaTempi { get; set; }

        public string RiservaCorriereDescr { get; set; }

        public string EmailPaypal { get; set; }

        public bool PaypalTest { get; set; }


        public EComm_Ana_CRUD Get_Ana_Ecommerce(int Id)
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", Id);


            EComm_Ana_CRUD IstanzaGetDatiEcommerce = new EComm_Ana_CRUD();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("Get_Ana_Ecommerce", objParams))
            {
                while (reader.Read())
                {

                    IstanzaGetDatiEcommerce.Bonifico = reader.GetBoolean(reader.GetOrdinal("Bonifico"));
                    IstanzaGetDatiEcommerce.Paypal = reader.GetBoolean(reader.GetOrdinal("Paypal"));
                    IstanzaGetDatiEcommerce.PaypalTest = reader.GetBoolean(reader.GetOrdinal("PaypalTest"));
                    IstanzaGetDatiEcommerce.EmailPaypal = reader.GetString(reader.GetOrdinal("Paypal_Email"));
                    IstanzaGetDatiEcommerce.BonificoDescr = reader.IsDBNull(reader.GetOrdinal("BonificoDescr")) ? string.Empty : reader.GetString(reader.GetOrdinal("BonificoDescr"));
                    IstanzaGetDatiEcommerce.MinScorta = reader.IsDBNull(reader.GetOrdinal("MinScorta")) ? 0 : reader.GetInt32(reader.GetOrdinal("MinScorta"));
                    IstanzaGetDatiEcommerce.ProdottoEsaurito = reader.IsDBNull(reader.GetOrdinal("ProdottoEsaurito"))
                        ? string.Empty
                        : reader.GetString(reader.GetOrdinal("ProdottoEsaurito"));
                    IstanzaGetDatiEcommerce.ConsegnaTempi = reader.IsDBNull(reader.GetOrdinal("ConsegnaTempi")) ? string.Empty : reader.GetString(reader.GetOrdinal("ConsegnaTempi"));
                    IstanzaGetDatiEcommerce.RiservaCorriereDescr = reader.IsDBNull(reader.GetOrdinal("RiservaCorriereDescr"))
                        ? string.Empty
                        : reader.GetString(reader.GetOrdinal("RiservaCorriereDescr"));
                }
                reader.Close();
            }
            return IstanzaGetDatiEcommerce;

        }

        public void Update_Ana_Ecommerce()
        {
            SHPSql4Helper objSqlHelper = new SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[9];

            objParams[0] = new SqlParameter("@Bonifico", Bonifico);
            objParams[1] = new SqlParameter("@Paypal", Paypal);
            objParams[2] = new SqlParameter("@BonificoDescr", BonificoDescr);
            objParams[3] = new SqlParameter("@MinScorta", MinScorta);
            objParams[4] = new SqlParameter("@ProdottoEsaurito", ProdottoEsaurito);
            objParams[5] = new SqlParameter("@ConsegnaTempi", ConsegnaTempi);
            objParams[6] = new SqlParameter("@RiservaCorriereDescr", RiservaCorriereDescr);
            objParams[7] = new SqlParameter("@Paypal_Email", EmailPaypal);
            objParams[8] = new SqlParameter("@PaypalTest", PaypalTest);
            _ = objSqlHelper.ExecuteNonQueryForNews("Update_Ana_Ecommerce", objParams);
        }
    }
}