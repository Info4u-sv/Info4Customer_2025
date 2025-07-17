using info4lab;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class ITAL_Articoli_CRUD
    {
        public string Taglia { get; set; }
        public int Misura_L { get; set; }
        public int Misura_P { get; set; }
        public int Misura_H { get; set; }
        public int Livelli { get; set; }
        public int Portata { get; set; }
        public int Portata_nominale { get; set; }
        public int Stima_referenze { get; set; }
        public string Dimensioni { get; set; }


        public static ITAL_Articoli_CRUD U_ArticoloDet_Get(string Taglia)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter objParams = new SqlParameter("@Taglia", Taglia);
            ITAL_Articoli_CRUD ArticoloDet = new ITAL_Articoli_CRUD();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("ITAL_ArticoliCRUD_Get", objParams))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        ArticoloDet.Taglia = reader["Taglia"].ToString();
                        ArticoloDet.Misura_L = (int)reader["L"];
                        ArticoloDet.Misura_P = (int)reader["P"];
                        ArticoloDet.Misura_H = (int)reader["H"];
                        ArticoloDet.Livelli = (int)reader["Livelli"];
                        ArticoloDet.Portata = (int)reader["Portata"];
                        ArticoloDet.Portata_nominale = (int)reader["Portata_nominale"];
                        ArticoloDet.Stima_referenze = (int)reader["Stima_referenze"];
                        ArticoloDet.Dimensioni = $"{ArticoloDet.Misura_L}L x {ArticoloDet.Misura_P}P x {ArticoloDet.Misura_H}H";
                    }
                    reader.Close();
                }
            }
            return ArticoloDet;
        }
    }
}