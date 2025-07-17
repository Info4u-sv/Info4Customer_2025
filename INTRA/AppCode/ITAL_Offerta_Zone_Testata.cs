using info4lab;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class ITAL_Offerta_Zone_Testata
    {
        public int IdOfferta { get; set; }
        public int ZonaNum { get; set; }
        public string Posizione { get; set; }
        public string Taglia { get; set; }
        public bool Bordi { get; set; }
        public bool Divisorio { get; set; }
        public bool Schermo { get; set; }

        public static ITAL_Offerta_Zone_Testata U_ZonaTestata_Get(int IdOfferta, int ZonaNum, string Posizione)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@IdOfferta", IdOfferta);
            objParams[1] = new SqlParameter("@ZonaNum", ZonaNum);
            objParams[2] = new SqlParameter("@Posizione", Posizione);
            ITAL_Offerta_Zone_Testata ZonaTestata = new ITAL_Offerta_Zone_Testata();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("ITAL_ZoneTestata_Get", objParams))
            {
                while (reader.Read())
                {
                    //ZonaTestata.Posizione = reader.GetString(reader.GetOrdinal("Posizione"));
                    //ZonaTestata.Taglia = reader.GetString(reader.GetOrdinal("Taglia"));
                    //ZonaTestata.Bordi = reader.GetBoolean(reader.GetOrdinal("Bordi"));
                    //ZonaTestata.Divisorio = reader.GetBoolean(reader.GetOrdinal("Divisorio"));
                    //ZonaTestata.Schermo = reader.GetBoolean(reader.GetOrdinal("Schermo"));
                    //ZonaTestata.ZonaNum = reader.GetInt32(reader.GetOrdinal("ZonaNum"));
                    //ZonaTestata.IdOfferta = reader.GetInt32(reader.GetOrdinal("IdOfferta")); 

                    ZonaTestata.Posizione = reader["Posizione"] as string;
                    ZonaTestata.Taglia = reader["Taglia"] as string;
                    ZonaTestata.Bordi = (bool)reader["Bordi"];
                    ZonaTestata.Divisorio = (bool)reader["Divisorio"];
                    ZonaTestata.Schermo = (bool)reader["Schermo"]; //reader.GetBoolean(reader.GetOrdinal("Schermo"));
                    ZonaTestata.ZonaNum = (int)reader["ZonaNum"]; //reader.GetInt32(reader.GetOrdinal("ZonaNum"));
                    ZonaTestata.IdOfferta = (int)reader["IdOfferta"]; //reader.GetInt32(reader.GetOrdinal("IdOfferta"));
                }
                reader.Close();
            }
            return ZonaTestata;
        }

        public void ITAL_Offerta_Zone_Testata_Update(ITAL_Offerta_Zone_Testata _obj)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[7];
            objParams[0] = new SqlParameter("@IdOfferta", _obj.IdOfferta);
            objParams[1] = new SqlParameter("@ZonaNum", _obj.ZonaNum);
            objParams[2] = new SqlParameter("@Posizione", _obj.Posizione);
            objParams[3] = new SqlParameter("@Taglia", _obj.Taglia);
            objParams[4] = new SqlParameter("@Bordi", _obj.Bordi);
            objParams[5] = new SqlParameter("@Divisorio", _obj.Divisorio);
            objParams[6] = new SqlParameter("@Schermo", _obj.Schermo);

            objSqlHelper.ExecuteNonQuery("ITAL_Offerta_Zone_Testata_Update", objParams);
        }

    }
}