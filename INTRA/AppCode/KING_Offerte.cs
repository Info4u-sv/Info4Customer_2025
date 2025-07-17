using info4lab;
using System;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class KING_Offerte
    {

        public string CodRapportino { get; set; }
        public string CodCliente { get; set; }
        public string Società { get; set; }
        public string PIva { get; set; }
        public string Indirizzo { get; set; }
        public string Cap { get; set; }
        public string Località { get; set; }
        public string Provincia { get; set; }
        public string Telefono { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string Matricola { get; set; }
        public string Scala { get; set; }
        public int TipoImpianto { get; set; }
        public string PersonaDaContattare { get; set; }
        public int TipoChiamata { get; set; }
        public int AreaAss { get; set; }
        public string MotivoChiamata { get; set; }
        public string Note { get; set; }
        public string GuastoRilevato { get; set; }
        public string LavoroEseguito { get; set; }
        public bool InterventoChiuso { get; set; }
        public string Osservazioni { get; set; }
        public string DataIntervento { get; set; }
        public string DataIns { get; set; }
        public string EditUser { get; set; }
        public string CreatedOn { get; set; }
        public string UpdatedOn { get; set; }

        public string User { get; set; }
        public string Ore { get; set; }
        public int StatusRpt { get; set; }

        public int Id { get; set; }
        public string IncaricatoCli { get; set; }
        public string ImmagineTxt { get; set; }
        public string PercorsoImmagine { get; set; }

        //--- modifica 16-04-2016
        public int TCK_TipoRichiesta { get; set; }
        public int TCK_AreaCompetenza { get; set; }
        public int TCK_TipoEsecuzionePresunta { get; set; }
        public int TCK_TipoEsecuzione { get; set; }
        public int TCK_StatusChiamata { get; set; }
        public int TCK_StatusChiamataChiusura { get; set; }
        public int TCK_PrioritaRichiesta { get; set; }
        public int TCK_TipoChiusuraChiamataFattura { get; set; }

        public string OraInzioIntervento { get; set; }
        public string OraFineIntervento { get; set; }
        public string NomePersonaRiferimento { get; set; }
        public string TelPersonaRiferimento { get; set; }
        public string MailPersonaRiferimento { get; set; }
        public float DirittoFisso { get; set; }
        public float TariffaOraria { get; set; }
        public int SpeseViaggioKm { get; set; }
        public float SpeseViaggioEuro { get; set; }
        public float TotaleEuroForfait { get; set; }
        //--- modifica 1/08/2016
        public string TCK_StatusChiamata_etichetta { get; set; }
        public string TCK_TipoRichiesta_etichetta { get; set; }
        public string TCK_AreaCompetenza_etichetta { get; set; }
        public string TCK_TipoEsecuzionePresunta_etichetta { get; set; }
        public string TCK_TipoEsecuzione_etichetta { get; set; }
        public string TCK_PrioritaRichiesta_etichetta { get; set; }

        //--- modifica 5/08/2016
        public string ImgFirmaCliente { get; set; }
        public string ImgFirmaTecnico { get; set; }
        public string FirmaCliente { get; set; }
        public bool TicketFirmato { get; set; }
        //--- modifica 1/09/2016
        public string InterventoPresso { get; set; }
        public string FirmaTecnico { get; set; }
        public string NoteAnnullamentoTck { get; set; }
        public string NoteTecnico { get; set; }
        public string LinkTckPdf { get; set; }
        public string TckInviatoA { get; set; }
        public string TCK_StatusChiamataChiusura_Etichetta { get; set; }

        public int TotTecnici_TCK { get; set; }
        public float TempoInterventoTotale { get; set; }
        public string UM_Tempo { get; set; }
        //--- modifica 29/09/2016

        public int StatusControlloFatt { get; set; }
        public string ApprovatoDa { get; set; }

        //modifica 21/12/2016
        public int StatusControlloRegistrazione { get; set; }

        public int NumeroRegistrazione { get; set; }

        public string NoteFatturazioneFinale { get; set; }

        public int StatusControlloFatturazioneFinale { get; set; }

        // modifica 27/12/2016
        public string societa { get; set; }
        public string Denom { get; set; }
        public string Ind { get; set; }

        public string Prov { get; set; }
        public string Loc { get; set; }
        public string Tel { get; set; }

        public string Riferim { get; set; }

        public string EMail { get; set; }
        public string CodCli { get; set; }

        //modifica del 13/01/2017 Alessio

        public string CodArt_King { get; set; }
        public int IdIntervento_King { get; set; }

        public decimal PrezzoDa { get; set; }

        public decimal PrezzoA { get; set; }

        public string EmailTecnicoPerCliente { get; set; }

        public bool FlagPrezzoA { get; set; }

        public decimal ScontoIncondizionato { get; set; }

        public int ID { get; set; }

        public DateTime OrdDat { get; set; }

        public DateTime PrevCons { get; set; }

        public string CodPag { get; set; }

        public string CodBan { get; set; }

        public int BanCli { get; set; }

        public string NumOrdCli { get; set; }

        public DateTime DataOrdCli { get; set; }

        public string CodVal { get; set; }

        public string Agente { get; set; }

        public string Deposito { get; set; }

        public float Sconto1 { get; set; }

        public float Sconto2 { get; set; }

        public string CodLis { get; set; }

        public string CodDiv { get; set; }

        public string CodSpe1 { get; set; }

        public string CodSpe2 { get; set; }
        public string CodPor { get; set; }

        public string CodArt { get; set; }
        public string DescrizioneArticolo { get; set; }
        public string UM { get; set; }

        public float QtaOrd { get; set; }

        public float Prezzo { get; set; }

        public float Sconto { get; set; }

        public float Importo { get; set; }

        public int IdTestata { get; set; }

        public float TotQta { get; set; }

        public float TotImp { get; set; }

        public int NRiga { get; set; }

        public float QtaAnag { get; set; }

        public string OrdNum { get; set; }

        public bool Valuta { get; set; }

        public string DescrizioneListino { get; set; }

        public bool FlagListino { get; set; }


        public decimal CostoTrasporto { get; set; }

        public float CostoTrasportoString { get; set; }

        public string U_Confez_Intra { get; set; }

        public decimal QtaOrdVar { get; set; }

        public decimal QtaOrdBozze { get; set; }

        public decimal QtaAnagBozze { get; set; }

        public string DescrizioneCondPag { get; set; }


        public int IdSpesa { get; set; }

        public string CodIva { get; set; }

        public string Tipo { get; set; }

        public int Nriga { get; set; }

        public decimal Percent { get; set; }

        public int U_IdBozza { get; set; }

        public string NumDec { get; set; }

        public string RifIva { get; set; }

        public decimal u_pz_lordo { get; set; }

        public decimal U_Sc1 { get; set; }

        public decimal U_Sc2 { get; set; }

        // modifica Simone 05/10/18
        public bool U_Flag_Edit_Trasp { get; set; }

        public KING_Offerte U_DatiCliente_Get(string CodCli)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CodCli", CodCli);
            KING_Offerte DatiOrdine = new KING_Offerte();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("U_GetDatiCliente", objParams))
            {
                while (reader.Read())
                {
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto1"))) { DatiOrdine.Sconto1 = 0; } else { DatiOrdine.Sconto1 = reader.GetFloat(reader.GetOrdinal("Sconto1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto2"))) { DatiOrdine.Sconto2 = 0; } else { DatiOrdine.Sconto2 = reader.GetFloat(reader.GetOrdinal("Sconto2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodLis"))) { DatiOrdine.CodLis = string.Empty; } else { DatiOrdine.CodLis = reader.GetString(reader.GetOrdinal("CodLis")); }
                    if (reader.IsDBNull(reader.GetOrdinal("DescrizioneListino"))) { DatiOrdine.DescrizioneListino = string.Empty; } else { DatiOrdine.DescrizioneListino = reader.GetString(reader.GetOrdinal("DescrizioneListino")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Valuta"))) { DatiOrdine.Valuta = false; } else { DatiOrdine.Valuta = reader.GetBoolean(reader.GetOrdinal("Valuta")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodBan"))) { DatiOrdine.CodBan = string.Empty; } else { DatiOrdine.CodBan = reader.GetString(reader.GetOrdinal("CodBan")); }
                    if (reader.IsDBNull(reader.GetOrdinal("FlagListino"))) { DatiOrdine.FlagListino = false; } else { DatiOrdine.FlagListino = reader.GetBoolean(reader.GetOrdinal("FlagListino")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpd"))) { DatiOrdine.CodSpe1 = string.Empty; } else { DatiOrdine.CodSpe1 = reader.GetString(reader.GetOrdinal("CodSpd")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodAge"))) { DatiOrdine.Agente = string.Empty; } else { DatiOrdine.Agente = reader.GetString(reader.GetOrdinal("CodAge")); }
                }
                reader.Close();
            }
            return DatiOrdine;
        }

        public KING_Offerte U_OrdCliTest_Get(int Nord, string CodCli)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@NOrd", Nord);
            objParams[1] = new SqlParameter("@CodCli", CodCli);
            KING_Offerte DatiOrdine = new KING_Offerte();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("U_GetDatiOrdine", objParams))
            {
                while (reader.Read())
                {
                    if (reader.IsDBNull(reader.GetOrdinal("NumOrdCli"))) { DatiOrdine.NumOrdCli = string.Empty; } else { DatiOrdine.NumOrdCli = reader.GetString(reader.GetOrdinal("NumOrdCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("DataOrdCli"))) { DatiOrdine.DataOrdCli = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.DataOrdCli = reader.GetDateTime(reader.GetOrdinal("DataOrdCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Note"))) { DatiOrdine.Note = string.Empty; } else { DatiOrdine.Note = reader.GetString(reader.GetOrdinal("Note")).Replace("\n", "<br /> "); }
                    if (reader.IsDBNull(reader.GetOrdinal("OrdDat"))) { DatiOrdine.OrdDat = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.OrdDat = reader.GetDateTime(reader.GetOrdinal("OrdDat")); }
                    if (reader.IsDBNull(reader.GetOrdinal("PrevCons"))) { DatiOrdine.PrevCons = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.PrevCons = reader.GetDateTime(reader.GetOrdinal("PrevCons")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodDiv"))) { DatiOrdine.CodDiv = string.Empty; } else { DatiOrdine.CodDiv = reader.GetString(reader.GetOrdinal("CodDiv")); }
                    if (reader.IsDBNull(reader.GetOrdinal("OrdNum"))) { DatiOrdine.OrdNum = string.Empty; } else { DatiOrdine.OrdNum = reader.GetString(reader.GetOrdinal("OrdNum")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto1"))) { DatiOrdine.Sconto1 = 0; } else { DatiOrdine.Sconto1 = (float)reader.GetDouble(reader.GetOrdinal("Sconto1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto2"))) { DatiOrdine.Sconto2 = 0; } else { DatiOrdine.Sconto2 = (float)reader.GetDouble(reader.GetOrdinal("Sconto2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodLis"))) { DatiOrdine.CodLis = string.Empty; } else { DatiOrdine.CodLis = reader.GetString(reader.GetOrdinal("CodLis")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodPor"))) { DatiOrdine.CodPor = string.Empty; } else { DatiOrdine.CodPor = reader.GetString(reader.GetOrdinal("CodPor")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Descrizione"))) { DatiOrdine.DescrizioneListino = string.Empty; } else { DatiOrdine.DescrizioneListino = reader.GetString(reader.GetOrdinal("Descrizione")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Valuta"))) { DatiOrdine.Valuta = false; } else { DatiOrdine.Valuta = reader.GetBoolean(reader.GetOrdinal("Valuta")); }
                    if (reader.IsDBNull(reader.GetOrdinal("BanCli"))) { DatiOrdine.BanCli = 0; } else { DatiOrdine.BanCli = reader.GetInt32(reader.GetOrdinal("BanCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodBan"))) { DatiOrdine.CodBan = string.Empty; } else { DatiOrdine.CodBan = reader.GetString(reader.GetOrdinal("CodBan")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Agente"))) { DatiOrdine.Agente = string.Empty; } else { DatiOrdine.Agente = reader.GetString(reader.GetOrdinal("Agente")); }
                    if (reader.IsDBNull(reader.GetOrdinal("FlagListino"))) { DatiOrdine.FlagListino = false; } else { DatiOrdine.FlagListino = reader.GetBoolean(reader.GetOrdinal("FlagListino")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpe1"))) { DatiOrdine.CodSpe1 = string.Empty; } else { DatiOrdine.CodSpe1 = reader.GetString(reader.GetOrdinal("CodSpe1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpe2"))) { DatiOrdine.CodSpe2 = string.Empty; } else { DatiOrdine.CodSpe2 = reader.GetString(reader.GetOrdinal("CodSpe2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("DescrizioneCondPag"))) { DatiOrdine.DescrizioneCondPag = string.Empty; } else { DatiOrdine.DescrizioneCondPag = reader.GetString(reader.GetOrdinal("DescrizioneCondPag")); }

                }
                reader.Close();
            }
            return DatiOrdine;
        }

    }
}