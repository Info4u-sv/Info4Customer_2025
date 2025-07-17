using info4lab;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class ITAL_Offerta_Testata_CRUD
    {
        public int IdOfferta { get; set; }
        public int IdClienteProspect { get; set; }
        public bool Bozza { get; set; }
        public DateTime DataOfferta { get; set; }
        public string DirittoRecesso { get; set; }
        public bool DirittoRecessoFlag { get; set; }
        public string CodAge { get; set; }
        public decimal ScaffalaturaEquivalente { get; set; }
        public decimal CapacitaVolumetrica { get; set; }
        public decimal CapacitaDiAppoggio { get; set; }
        public decimal VaniTotali { get; set; }
        public decimal StimaReferenzeGestibili { get; set; }
        public decimal Portata { get; set; }
        public decimal Imponibile { get; set; }
        public decimal ScontoConcesso { get; set; }
        public decimal NettoFornitura { get; set; }
        public string ValiditaOfferta { get; set; }
        public string ConsegnaIndicativa { get; set; }
        public string Resa { get; set; }
        public string Montaggio { get; set; }
        public string Pagamento { get; set; }
        public string DirittoDiRecesso { get; set; }
        public string EsclusioniDescr { get; set; }
        public DateTime CreatedOn { get; set; }
        public string CreatedUser { get; set; }
        public DateTime UpdatedOn { get; set; }
        public string UpdatedUser { get; set; }
        public int AmpiezzaZona_1 { get; set; }
        public int AmpiezzaZona_2 { get; set; }
        public int AmpiezzaZona_3 { get; set; }
        public int CampateZona_1 { get; set; }
        public int CampateZona_2 { get; set; }
        public int CampateZona_3 { get; set; }

        public int StimaReferenze_TagliaS { get; set; }
        public int StimaReferenze_TagliaM { get; set; }
        public int StimaReferenze_TagliaL { get; set; }

        public decimal LarghezzaUtileZona_1 { get; set; }
        public decimal LarghezzaUtileZona_2 { get; set; }
        public decimal LarghezzaUtileZona_3 { get; set; }

        public decimal ProfonditaUtileZona_1 { get; set; }
        public decimal ProfonditaUtileZona_2 { get; set; }
        public decimal ProfonditaUtileZona_3 { get; set; }



        public static ITAL_Offerta_Testata_CRUD U_OffCliTest_Get(int IdOff)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@IdOff", IdOff);
            ITAL_Offerta_Testata_CRUD TestataOfferta = new ITAL_Offerta_Testata_CRUD();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("ITAL_OffertaTestata_Get", objParams))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        TestataOfferta.IdOfferta = reader.GetInt32(reader.GetOrdinal("IdOfferta"));
                        TestataOfferta.IdClienteProspect = reader.GetInt32(reader.GetOrdinal("IdClienteProspect"));
                        TestataOfferta.Bozza = reader.GetBoolean(reader.GetOrdinal("Bozza"));
                        TestataOfferta.DataOfferta = reader.GetDateTime(reader.GetOrdinal("DataOfferta"));
                        TestataOfferta.DirittoRecesso = reader.GetString(reader.GetOrdinal("DirittoRecesso"));
                        TestataOfferta.DirittoRecessoFlag = reader.GetBoolean(reader.GetOrdinal("DirittoRecessoFlag"));
                        TestataOfferta.CodAge = reader.GetString(reader.GetOrdinal("CodAge"));
                        TestataOfferta.ScaffalaturaEquivalente = reader.GetDecimal(reader.GetOrdinal("ScaffalaturaEquivalente"));
                        TestataOfferta.CapacitaVolumetrica = reader.GetDecimal(reader.GetOrdinal("CapacitaVolumetrica"));
                        TestataOfferta.CapacitaDiAppoggio = reader.GetDecimal(reader.GetOrdinal("CapacitaDiAppoggio"));
                        TestataOfferta.VaniTotali = reader.GetDecimal(reader.GetOrdinal("VaniTotali"));
                        TestataOfferta.StimaReferenzeGestibili = reader.GetDecimal(reader.GetOrdinal("StimaReferenzeGestibili"));
                        TestataOfferta.Portata = reader.GetDecimal(reader.GetOrdinal("Portata"));
                        TestataOfferta.Imponibile = reader.GetDecimal(reader.GetOrdinal("Imponibile"));
                        TestataOfferta.ScontoConcesso = reader.GetDecimal(reader.GetOrdinal("ScontoConcesso"));
                        TestataOfferta.NettoFornitura = reader.GetDecimal(reader.GetOrdinal("NettoFornitura"));
                        TestataOfferta.ValiditaOfferta = reader.GetString(reader.GetOrdinal("ValiditaOfferta"));
                        TestataOfferta.ConsegnaIndicativa = reader.GetString(reader.GetOrdinal("ConsegnaIndicativa"));
                        TestataOfferta.Resa = reader.GetString(reader.GetOrdinal("Resa"));
                        TestataOfferta.Montaggio = reader.GetString(reader.GetOrdinal("Montaggio"));
                        TestataOfferta.Pagamento = reader.GetString(reader.GetOrdinal("Pagamento"));
                        TestataOfferta.DirittoDiRecesso = reader.GetString(reader.GetOrdinal("DirittoDiRecesso"));
                        TestataOfferta.EsclusioniDescr = reader.GetString(reader.GetOrdinal("EsclusioniDescr"));
                        TestataOfferta.CreatedOn = reader.GetDateTime(reader.GetOrdinal("CreatedOn"));
                        TestataOfferta.CreatedUser = reader.GetString(reader.GetOrdinal("CreatedUser"));
                        TestataOfferta.UpdatedOn = reader.GetDateTime(reader.GetOrdinal("UpdatedOn"));
                        TestataOfferta.UpdatedUser = reader.GetString(reader.GetOrdinal("UpdatedUser"));
                        TestataOfferta.AmpiezzaZona_1 = reader.GetInt32(reader.GetOrdinal("AmpiezzaZona_1"));
                        TestataOfferta.AmpiezzaZona_2 = reader.GetInt32(reader.GetOrdinal("AmpiezzaZona_2"));
                        TestataOfferta.AmpiezzaZona_3 = reader.GetInt32(reader.GetOrdinal("AmpiezzaZona_3"));
                        TestataOfferta.CampateZona_1 = reader.GetInt32(reader.GetOrdinal("CampateZona_1"));
                        TestataOfferta.CampateZona_2 = reader.GetInt32(reader.GetOrdinal("CampateZona_2"));
                        TestataOfferta.CampateZona_3 = reader.GetInt32(reader.GetOrdinal("CampateZona_3"));

                        TestataOfferta.StimaReferenze_TagliaS = reader.GetInt32(reader.GetOrdinal("StimaReferenze_TagliaS"));
                        TestataOfferta.StimaReferenze_TagliaM = reader.GetInt32(reader.GetOrdinal("StimaReferenze_TagliaM"));
                        TestataOfferta.StimaReferenze_TagliaL = reader.GetInt32(reader.GetOrdinal("StimaReferenze_TagliaL"));

                    }
                    reader.Close();
                }
            }
            return TestataOfferta;
        }
        public static int ITAL_Offerta_Testata_Update(ITAL_Offerta_Testata_CRUD _obj)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[42];
            objParams[0] = new SqlParameter("@IdOfferta", _obj.IdOfferta);
            objParams[1] = new SqlParameter("@IdClienteProspect", _obj.IdClienteProspect);
            objParams[2] = new SqlParameter("@Bozza", _obj.Bozza);
            objParams[3] = new SqlParameter("@DataOfferta", _obj.DataOfferta);
            objParams[4] = new SqlParameter("@DirittoRecesso", _obj.DirittoRecesso);
            objParams[5] = new SqlParameter("@DirittoRecessoFlag", _obj.DirittoRecessoFlag);
            objParams[6] = new SqlParameter("@CodAge", _obj.CodAge);
            objParams[7] = new SqlParameter("@ScaffalaturaEquivalente", _obj.ScaffalaturaEquivalente);
            objParams[8] = new SqlParameter("@CapacitaVolumetrica", _obj.CapacitaVolumetrica);
            objParams[9] = new SqlParameter("@CapacitaDiAppoggio", _obj.CapacitaDiAppoggio);
            objParams[10] = new SqlParameter("@VaniTotali", _obj.VaniTotali);
            objParams[11] = new SqlParameter("@StimaReferenzeGestibili", _obj.StimaReferenzeGestibili);
            objParams[12] = new SqlParameter("@Portata", _obj.Portata);
            objParams[13] = new SqlParameter("@Imponibile", _obj.Imponibile);
            objParams[14] = new SqlParameter("@ScontoConcesso", _obj.ScontoConcesso);
            objParams[15] = new SqlParameter("@NettoFornitura", _obj.NettoFornitura);
            objParams[16] = new SqlParameter("@ValiditaOfferta", _obj.ValiditaOfferta);
            objParams[17] = new SqlParameter("@ConsegnaIndicativa", _obj.ConsegnaIndicativa);
            objParams[18] = new SqlParameter("@Resa", _obj.Resa);
            objParams[19] = new SqlParameter("@Montaggio", _obj.Montaggio);
            objParams[20] = new SqlParameter("@Pagamento", _obj.Pagamento);
            objParams[21] = new SqlParameter("@DirittoDiRecesso", _obj.DirittoDiRecesso);
            objParams[22] = new SqlParameter("@EsclusioniDescr", _obj.EsclusioniDescr);
            objParams[23] = new SqlParameter("@CreatedOn", _obj.CreatedOn);
            objParams[24] = new SqlParameter("@CreatedUser", _obj.CreatedUser);
            objParams[25] = new SqlParameter("@UpdatedOn", _obj.UpdatedOn);
            objParams[26] = new SqlParameter("@UpdatedUser", _obj.UpdatedUser);
            objParams[27] = new SqlParameter("@AmpiezzaZona_1", _obj.AmpiezzaZona_1);
            objParams[28] = new SqlParameter("@AmpiezzaZona_2", _obj.AmpiezzaZona_2);
            objParams[29] = new SqlParameter("@AmpiezzaZona_3", _obj.AmpiezzaZona_3);
            objParams[30] = new SqlParameter("@CampateZona_1", _obj.CampateZona_1);
            objParams[31] = new SqlParameter("@CampateZona_2", _obj.CampateZona_2);
            objParams[32] = new SqlParameter("@CampateZona_3", _obj.CampateZona_3);
            objParams[33] = new SqlParameter("@StimaReferenze_TagliaS", _obj.StimaReferenze_TagliaS);
            objParams[34] = new SqlParameter("@StimaReferenze_TagliaM", _obj.StimaReferenze_TagliaM);
            objParams[35] = new SqlParameter("@StimaReferenze_TagliaL", _obj.StimaReferenze_TagliaL);
            objParams[36] = new SqlParameter("@ProfonditaUtileZona_1", _obj.ProfonditaUtileZona_1);
            objParams[37] = new SqlParameter("@ProfonditaUtileZona_2", _obj.ProfonditaUtileZona_2);
            objParams[38] = new SqlParameter("@ProfonditaUtileZona_3", _obj.ProfonditaUtileZona_3);
            objParams[39] = new SqlParameter("@LarghezzaUtileZona_1", _obj.LarghezzaUtileZona_1);
            objParams[40] = new SqlParameter("@LarghezzaUtileZona_2", _obj.LarghezzaUtileZona_2);
            objParams[41] = new SqlParameter("@LarghezzaUtileZona_3", _obj.LarghezzaUtileZona_3);


            return objSqlHelper.ExecuteNonQuery("ITAL_Offerta_Update", objParams);

        }
    }
}