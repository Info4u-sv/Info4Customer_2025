using info4lab;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class ITAL_Offerta_Zone_Det_CRUD
    {
        public int IdOfferta { get; set; }
        public int ZonaNum { get; set; }
        public int Campate { get; set; }
        public decimal LarghezzaUtile { get; set; }
        public string Taglia { get; set; }
        public int TagliaDisplayOrder { get; set; }
        public int L_Misure { get; set; }
        public int P_Misure { get; set; }
        public int H_Misure { get; set; }
        public int Piani { get; set; }
        public int Vano_Portata { get; set; }
        public int Colonna_Vano { get; set; }
        public int Fronte { get; set; }
        public int Centro { get; set; }
        public int Retro { get; set; }
        public bool Bordo_Fronte { get; set; }
        public bool Divisorio_Fronte { get; set; }
        public bool Schermo_Fronte { get; set; }
        public bool Bordo_Centro { get; set; }
        public bool Divisorio_Centro { get; set; }
        public bool Schermo_Centro { get; set; }
        public bool Bordo_Retro { get; set; }
        public bool Divisorio_Retro { get; set; }
        public bool Schermo_Retro { get; set; }
        public int QtaPerRackTotale { get; set; }

        public int Posti_pallet { get; set; }

        public static List<ITAL_Offerta_Zone_Det_CRUD> ITAL_ZonaCRUD_Get(int IdOfferta, int ZonaNum)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@IdOfferta", IdOfferta);
            objParams[1] = new SqlParameter("@ZonaNum", ZonaNum);

            List<ITAL_Offerta_Zone_Det_CRUD> ZonaDetList = new List<ITAL_Offerta_Zone_Det_CRUD>();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("ITAL_ZonaCRUD_Get", objParams))
            {
                while (reader.Read())
                {
                    ITAL_Offerta_Zone_Det_CRUD ZonaDet = new ITAL_Offerta_Zone_Det_CRUD();
                    ZonaDet.IdOfferta = reader.GetInt32(reader.GetOrdinal("IdOfferta"));
                    ZonaDet.ZonaNum = reader.GetInt32(reader.GetOrdinal("ZonaNum"));
                    ZonaDet.Campate = reader.GetInt32(reader.GetOrdinal("Campate"));
                    ZonaDet.LarghezzaUtile = reader.GetDecimal(reader.GetOrdinal("LarghezzaUtile"));
                    ZonaDet.Taglia = reader.GetString(reader.GetOrdinal("Taglia"));
                    ZonaDet.TagliaDisplayOrder = reader.GetInt32(reader.GetOrdinal("TagliaDisplayOrder"));
                    ZonaDet.L_Misure = reader.GetInt32(reader.GetOrdinal("L_misure"));
                    ZonaDet.P_Misure = reader.GetInt32(reader.GetOrdinal("P_misure"));
                    ZonaDet.H_Misure = reader.GetInt32(reader.GetOrdinal("H_misure"));
                    ZonaDet.Piani = reader.GetInt32(reader.GetOrdinal("Piani"));
                    ZonaDet.Vano_Portata = reader.GetInt32(reader.GetOrdinal("Vanno_Portata"));
                    ZonaDet.Colonna_Vano = reader.GetInt32(reader.GetOrdinal("Colonna_Vano"));
                    ZonaDet.Fronte = reader.GetInt32(reader.GetOrdinal("Fronte"));
                    ZonaDet.Centro = reader.GetInt32(reader.GetOrdinal("Centro"));
                    ZonaDet.Retro = reader.GetInt32(reader.GetOrdinal("Retro"));
                    ZonaDet.Bordo_Fronte = reader.GetBoolean(reader.GetOrdinal("Bordo_Fronte"));
                    ZonaDet.Divisorio_Fronte = reader.GetBoolean(reader.GetOrdinal("Divisorio_Fronte"));
                    ZonaDet.Schermo_Fronte = reader.GetBoolean(reader.GetOrdinal("Schermo_Fronte"));
                    ZonaDet.Bordo_Centro = reader.GetBoolean(reader.GetOrdinal("Bordo_Centro"));
                    ZonaDet.Divisorio_Centro = reader.GetBoolean(reader.GetOrdinal("Divisorio_Centro"));
                    ZonaDet.Schermo_Centro = reader.GetBoolean(reader.GetOrdinal("Schermo_Centro"));
                    ZonaDet.Bordo_Retro = reader.GetBoolean(reader.GetOrdinal("Bordo_Retro"));
                    ZonaDet.Divisorio_Retro = reader.GetBoolean(reader.GetOrdinal("Divisorio_Retro"));
                    ZonaDet.Schermo_Retro = reader.GetBoolean(reader.GetOrdinal("Schermo_Retro"));
                    ZonaDet.QtaPerRackTotale = ZonaDet.Fronte + ZonaDet.Centro + ZonaDet.Retro;
                    ZonaDetList.Add(ZonaDet);

                }
                reader.Close();
            }
            return ZonaDetList;
        }
        public static ITAL_Offerta_Zone_Det_CRUD ITAL_ZonaCRUD_Dettaglio_Get(int IdOfferta, int ZonaNum, string Taglia)
        {
            List<ITAL_Offerta_Zone_Det_CRUD> _objListFilterd = new List<ITAL_Offerta_Zone_Det_CRUD>();
            _objListFilterd = ITAL_Offerta_Zone_Det_CRUD.ITAL_ZonaCRUD_Get(IdOfferta, ZonaNum).Where(x => x.Taglia == Taglia).ToList();
            return _objListFilterd[0];

        }

        public int ITAL_Offerta_Zone_Det_Update(ITAL_Offerta_Zone_Det_CRUD _obj)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[18];
            objParams[0] = new SqlParameter("@IdOfferta", _obj.IdOfferta);
            objParams[1] = new SqlParameter("@ZonaNum", _obj.ZonaNum);
            objParams[2] = new SqlParameter("@Campate", _obj.Campate);
            objParams[3] = new SqlParameter("@Fronte", _obj.Fronte);
            objParams[4] = new SqlParameter("@Centro", _obj.Centro);
            objParams[5] = new SqlParameter("@Retro", _obj.Retro);
            objParams[6] = new SqlParameter("@Bordo_Fronte", _obj.Bordo_Fronte);
            objParams[7] = new SqlParameter("@Divisorio_Fronte", _obj.Divisorio_Fronte);
            objParams[8] = new SqlParameter("@Schermo_Fronte", _obj.Schermo_Fronte);
            objParams[9] = new SqlParameter("@Bordo_Centro", _obj.Bordo_Centro);
            objParams[10] = new SqlParameter("@Divisorio_Centro", _obj.Divisorio_Centro);
            objParams[11] = new SqlParameter("@Schermo_Centro", _obj.Schermo_Centro);
            objParams[12] = new SqlParameter("@Bordo_Retro", _obj.Bordo_Retro);
            objParams[13] = new SqlParameter("@Divisorio_Retro", _obj.Divisorio_Retro);
            objParams[14] = new SqlParameter("@Schermo_Retro", _obj.Schermo_Retro);
            objParams[15] = new SqlParameter("@Taglia", _obj.Taglia);
            objParams[16] = new SqlParameter("@LarghezzaUtile", _obj.LarghezzaUtile);
            objParams[17] = new SqlParameter("@Posti_pallet", _obj.Posti_pallet);
            return objSqlHelper.ExecuteNonQuery("ITAL_Offerta_Zone_Det_Update", objParams);
        }
    }
}