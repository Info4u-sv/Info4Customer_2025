using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using info4lab;

using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Descrizione di riepilogo per Col_Clienti
/// </summary>
/// 
namespace INTRA.Age_Ordini.AppCode
{
    public class Ordini_Crud
    {
        public Ordini_Crud()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }
        public int ID { get; set; }

        public DateTime OrdDat { get; set; }

        public DateTime PrevCons { get; set; }

        public string CodCli { get; set; }

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

        public string Note { get; set; }

        public string CodDiv { get; set; }

        public string CodSpe1 { get; set; }

        public string CodSpe2 { get; set; }
        public string CodPor { get; set; }

        public string CodArt { get; set; }
        public string DescrizioneArticolo { get; private set; }
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

        public bool FlagTrasporto { get; set; }

        public decimal CostoTrasporto { get; set; }

        public float CostoTrasportoString { get; set; }

        public string U_Confez_Intra { get; set; }

        public decimal QtaOrdVar { get; set; }

        public decimal QtaOrdBozze { get; set; }

        public decimal QtaAnagBozze { get; set; }

        public string DescrizioneCondPag { get; set; }

        public float U_Trasporto { get; set; }

        public int IdSpesa { get; set; }

        public string CodIva { get; set; }

        public string Tipo { get; set; }

        public int Nriga { get; set; }

        public decimal Percent { get; set; }



        public int U_OrdCliTest_Insert(Ordini_Crud Ordini)
        {

            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[22];
            objParams[0] = new SqlParameter("@OrdDat", Ordini.OrdDat);
            objParams[1] = new SqlParameter("@PrevCons", Ordini.PrevCons);
            objParams[2] = new SqlParameter("@CodCli", Ordini.CodCli);
            objParams[3] = new SqlParameter("@CodPag", Ordini.CodPag);
            objParams[4] = new SqlParameter("@CodBan", Ordini.CodBan);
            objParams[5] = new SqlParameter("@BanCli", Ordini.BanCli);
            objParams[6] = new SqlParameter("@NumOrdCli", Ordini.NumOrdCli);
            objParams[7] = new SqlParameter("@DataOrdCli", Ordini.DataOrdCli);
            objParams[8] = new SqlParameter("@CodVal", Ordini.CodVal);
            objParams[9] = new SqlParameter("@Agente", Ordini.Agente);
            objParams[10] = new SqlParameter("@Deposito", Ordini.Deposito);
            objParams[11] = new SqlParameter("@Sconto1", Ordini.Sconto1);
            objParams[12] = new SqlParameter("@Sconto2", Ordini.Sconto2);
            objParams[13] = new SqlParameter("@CodLis", Ordini.CodLis);
            objParams[14] = new SqlParameter("@Note", Ordini.Note);
            objParams[15] = new SqlParameter("@CodDiv", Ordini.CodDiv);
            objParams[16] = new SqlParameter("@CodSpe1", Ordini.CodSpe1);
            objParams[17] = new SqlParameter("@CodSpe2", Ordini.CodSpe2);
            objParams[18] = new SqlParameter("@CodPor", Ordini.CodPor);
            objParams[19] = new SqlParameter("@OrdNum", Ordini.OrdNum);
            objParams[20] = new SqlParameter("@U_Flag_Trasp", Ordini.FlagTrasporto);
            objParams[21] = new SqlParameter("@U_TrasportoAgente", Ordini.CostoTrasporto);
            int LastId = objSqlHelper.ExecuteNonQueryForNews("U_OrdCliTest_Insert", objParams);
            return LastId;
        }

        public int U_OrdCliTestBozza_Insert(Ordini_Crud Ordini)
        {

            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[22];
            objParams[0] = new SqlParameter("@OrdDat", Ordini.OrdDat);
            objParams[1] = new SqlParameter("@PrevCons", Ordini.PrevCons);
            objParams[2] = new SqlParameter("@CodCli", Ordini.CodCli);
            objParams[3] = new SqlParameter("@CodPag", Ordini.CodPag);
            objParams[4] = new SqlParameter("@CodBan", Ordini.CodBan);
            objParams[5] = new SqlParameter("@BanCli", Ordini.BanCli);
            objParams[6] = new SqlParameter("@NumOrdCli", Ordini.NumOrdCli);
            objParams[7] = new SqlParameter("@DataOrdCli", Ordini.DataOrdCli);
            objParams[8] = new SqlParameter("@CodVal", Ordini.CodVal);
            objParams[9] = new SqlParameter("@Agente", Ordini.Agente);
            objParams[10] = new SqlParameter("@Deposito", Ordini.Deposito);
            objParams[11] = new SqlParameter("@Sconto1", Ordini.Sconto1);
            objParams[12] = new SqlParameter("@Sconto2", Ordini.Sconto2);
            objParams[13] = new SqlParameter("@CodLis", Ordini.CodLis);
            objParams[14] = new SqlParameter("@Note", Ordini.Note);
            objParams[15] = new SqlParameter("@CodDiv", Ordini.CodDiv);
            objParams[16] = new SqlParameter("@CodSpe1", Ordini.CodSpe1);
            objParams[17] = new SqlParameter("@CodSpe2", Ordini.CodSpe2);
            objParams[18] = new SqlParameter("@CodPor", Ordini.CodPor);
            objParams[19] = new SqlParameter("@OrdNum", Ordini.OrdNum);
            objParams[20] = new SqlParameter("@U_Flag_Trasp", Ordini.FlagTrasporto);
            objParams[21] = new SqlParameter("@U_TrasportoAgente", Ordini.CostoTrasporto);
            int LastId = objSqlHelper.ExecuteNonQueryForNews("U_OrdCliTestBozza_Insert", objParams);
            return LastId;
        }



        public void U_OrdCliDett_Insert(Ordini_Crud Articolo)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[11];
            objParams[0] = new SqlParameter("@CodArt", Articolo.CodArt);
            objParams[1] = new SqlParameter("@UM", Articolo.UM);
            objParams[2] = new SqlParameter("@QtaOrd", Articolo.QtaOrd);
            objParams[3] = new SqlParameter("@Prezzo", Articolo.Prezzo);

            //objParams[5] = new SqlParameter("@Sconto2", Articolo.Sconto2);
            objParams[4] = new SqlParameter("@Importo", Articolo.Importo);
            objParams[5] = new SqlParameter("@Note", Articolo.Note);
            objParams[6] = new SqlParameter("@IdTestata", Articolo.IdTestata);
            objParams[7] = new SqlParameter("@NRiga", Articolo.NRiga);
            objParams[8] = new SqlParameter("@QtaAnag", Articolo.QtaAnag);
            objParams[9] = new SqlParameter("@U_Confez_Intra", Articolo.U_Confez_Intra);
            objParams[10] = new SqlParameter("@Sconto", Articolo.Sconto);
            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliDett_Insert", objParams);
        }

        public void U_OrdCliTestQta_Update(Ordini_Crud Articolo)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@TotQta", Articolo.TotQta);
            objParams[1] = new SqlParameter("@TotImp", Articolo.TotImp);
            objParams[2] = new SqlParameter("@IdTestata", Articolo.IdTestata);

            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliTestQta_Update", objParams);
        }
        public void OrdineListaPrelievo_U(Ordini_Crud Ordini)
        {

            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", Ordini.ID);
            objSqlHelper.ExecuteNonQueryForNews("U_Ordine_Lista_Prelievo_UPDATE", objParams);
        }
       
        public void RipristinaOrdineListaPrelievo_U(Ordini_Crud Ordini)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", Ordini.ID);
            objSqlHelper.ExecuteNonQueryForNews("U_Ordine_Lista_Prelievo_Ripristina_UPDATE", objParams);
        }
      
        public Ordini_Crud U_OrdCliTest_Get(int Nord, string CodCli)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@NOrd", Nord);
            objParams[1] = new SqlParameter("@CodCli", CodCli);
            Ordini_Crud DatiOrdine = new Ordini_Crud();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("U_GetDatiOrdine", objParams))
            {
                while (reader.Read())
                {
                    if (reader.IsDBNull(reader.GetOrdinal("NumOrdCli"))) { DatiOrdine.NumOrdCli = ""; } else { DatiOrdine.NumOrdCli = reader.GetString(reader.GetOrdinal("NumOrdCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("DataOrdCli"))) { DatiOrdine.DataOrdCli = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.DataOrdCli = reader.GetDateTime(reader.GetOrdinal("DataOrdCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Note"))) { DatiOrdine.Note = ""; } else { DatiOrdine.Note = reader.GetString(reader.GetOrdinal("Note")); }
                    if (reader.IsDBNull(reader.GetOrdinal("OrdDat"))) { DatiOrdine.OrdDat = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.OrdDat = reader.GetDateTime(reader.GetOrdinal("OrdDat")); }
                    if (reader.IsDBNull(reader.GetOrdinal("PrevCons"))) { DatiOrdine.PrevCons = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.PrevCons = reader.GetDateTime(reader.GetOrdinal("PrevCons")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodDiv"))) { DatiOrdine.CodDiv = ""; } else { DatiOrdine.CodDiv = reader.GetString(reader.GetOrdinal("CodDiv")); }
                    if (reader.IsDBNull(reader.GetOrdinal("OrdNum"))) { DatiOrdine.OrdNum = ""; } else { DatiOrdine.OrdNum = reader.GetString(reader.GetOrdinal("OrdNum")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto1"))) { DatiOrdine.Sconto1 = 0; } else { DatiOrdine.Sconto1 = (float)reader.GetDouble(reader.GetOrdinal("Sconto1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto2"))) { DatiOrdine.Sconto2 = 0; } else { DatiOrdine.Sconto2 = (float)reader.GetDouble(reader.GetOrdinal("Sconto2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodLis"))) { DatiOrdine.CodLis = ""; } else { DatiOrdine.CodLis = reader.GetString(reader.GetOrdinal("CodLis")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodPor"))) { DatiOrdine.CodPor = ""; } else { DatiOrdine.CodPor = reader.GetString(reader.GetOrdinal("CodPor")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Descrizione"))) { DatiOrdine.DescrizioneListino = ""; } else { DatiOrdine.DescrizioneListino = reader.GetString(reader.GetOrdinal("Descrizione")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Valuta"))) { DatiOrdine.Valuta = false; } else { DatiOrdine.Valuta = reader.GetBoolean(reader.GetOrdinal("Valuta")); }
                    if (reader.IsDBNull(reader.GetOrdinal("BanCli"))) { DatiOrdine.BanCli = 0; } else { DatiOrdine.BanCli = reader.GetInt32(reader.GetOrdinal("BanCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodBan"))) { DatiOrdine.CodBan = ""; } else { DatiOrdine.CodBan = reader.GetString(reader.GetOrdinal("CodBan")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Agente"))) { DatiOrdine.Agente = ""; } else { DatiOrdine.Agente = reader.GetString(reader.GetOrdinal("Agente")); }
                    if (reader.IsDBNull(reader.GetOrdinal("FlagListino"))) { DatiOrdine.FlagListino = false; } else { DatiOrdine.FlagListino = reader.GetBoolean(reader.GetOrdinal("FlagListino")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpe1"))) { DatiOrdine.CodSpe1 = ""; } else { DatiOrdine.CodSpe1 = reader.GetString(reader.GetOrdinal("CodSpe1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpe2"))) { DatiOrdine.CodSpe2 = ""; } else { DatiOrdine.CodSpe2 = reader.GetString(reader.GetOrdinal("CodSpe2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("U_Flag_Trasp"))) { DatiOrdine.FlagTrasporto = false; } else { DatiOrdine.FlagTrasporto = reader.GetBoolean(reader.GetOrdinal("U_Flag_Trasp")); }
                    if (reader.IsDBNull(reader.GetOrdinal("U_TrasportoAgente"))) { DatiOrdine.CostoTrasportoString = 0; } else { DatiOrdine.CostoTrasportoString = (float)reader.GetDouble(reader.GetOrdinal("U_TrasportoAgente")); }
                    if (reader.IsDBNull(reader.GetOrdinal("DescrizioneCondPag"))) { DatiOrdine.DescrizioneCondPag = ""; } else { DatiOrdine.DescrizioneCondPag = reader.GetString(reader.GetOrdinal("DescrizioneCondPag")); }

                }
                reader.Close();
            }
            return DatiOrdine;
        }

        public void U_OrdCliTest_Update(Ordini_Crud Ordini, int Nord)
        {

            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[21];

            objParams[0] = new SqlParameter("@OrdDat", Ordini.OrdDat);
            objParams[1] = new SqlParameter("@PrevCons", Ordini.PrevCons);
            objParams[2] = new SqlParameter("@CodPag", Ordini.CodPag);
            objParams[3] = new SqlParameter("@CodBan", Ordini.CodBan);
            objParams[4] = new SqlParameter("@BanCli", Ordini.BanCli);
            objParams[5] = new SqlParameter("@NumOrdCli", Ordini.NumOrdCli);
            objParams[6] = new SqlParameter("@DataOrdCli", Ordini.DataOrdCli);
            objParams[7] = new SqlParameter("@CodVal", Ordini.CodVal);
            objParams[8] = new SqlParameter("@Agente", Ordini.Agente);
            objParams[9] = new SqlParameter("@Deposito", Ordini.Deposito);
            objParams[10] = new SqlParameter("@Sconto1", Ordini.Sconto1);
            objParams[11] = new SqlParameter("@Sconto2", Ordini.Sconto2);
            objParams[12] = new SqlParameter("@CodLis", Ordini.CodLis);
            objParams[13] = new SqlParameter("@Note", Ordini.Note);
            objParams[14] = new SqlParameter("@CodDiv", Ordini.CodDiv);
            objParams[15] = new SqlParameter("@CodSpe1", Ordini.CodSpe1);
            objParams[16] = new SqlParameter("@CodSpe2", Ordini.CodSpe2);
            objParams[17] = new SqlParameter("@CodPor", Ordini.CodPor);
            objParams[18] = new SqlParameter("@ID", Nord);
            objParams[19] = new SqlParameter("@U_Flag_Trasp", Ordini.FlagTrasporto);
            objParams[20] = new SqlParameter("@U_TrasportoAgente", Ordini.CostoTrasporto);
            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliTest_Update", objParams);

        }

        public void U_OrdCliDett_Update(Ordini_Crud Articolo, int Nord)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[10];
            objParams[0] = new SqlParameter("@CodArt", Articolo.CodArt);
            objParams[1] = new SqlParameter("@UM", Articolo.UM);
            objParams[2] = new SqlParameter("@QtaOrd", Articolo.QtaOrd);
            objParams[3] = new SqlParameter("@Prezzo", Articolo.Prezzo);
            //objParams[4] = new SqlParameter("@Sconto", Articolo.Sconto);
            //objParams[5] = new SqlParameter("@Sconto2", Articolo.Sconto2);
            objParams[4] = new SqlParameter("@Importo", Articolo.Importo);
            //objParams[7] = new SqlParameter("@PrevCons", Articolo.PrevCons);
            objParams[5] = new SqlParameter("@ID", Nord);
            objParams[6] = new SqlParameter("@QtaAnag", Articolo.QtaAnag);

            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliDett_Update", objParams);
        }

        public Ordini_Crud U_DatiCliente_Get(string CodCli)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CodCli", CodCli);
            Ordini_Crud DatiOrdine = new Ordini_Crud();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("U_GetDatiCliente", objParams))
            {
                while (reader.Read())
                {

                    if (reader.IsDBNull(reader.GetOrdinal("Sconto1"))) { DatiOrdine.Sconto1 = 0; } else { DatiOrdine.Sconto1 = reader.GetFloat(reader.GetOrdinal("Sconto1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto2"))) { DatiOrdine.Sconto2 = 0; } else { DatiOrdine.Sconto2 = reader.GetFloat(reader.GetOrdinal("Sconto2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodLis"))) { DatiOrdine.CodLis = ""; } else { DatiOrdine.CodLis = reader.GetString(reader.GetOrdinal("CodLis")); }
                    if (reader.IsDBNull(reader.GetOrdinal("DescrizioneListino"))) { DatiOrdine.DescrizioneListino = ""; } else { DatiOrdine.DescrizioneListino = reader.GetString(reader.GetOrdinal("DescrizioneListino")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Valuta"))) { DatiOrdine.Valuta = false; } else { DatiOrdine.Valuta = reader.GetBoolean(reader.GetOrdinal("Valuta")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodBan"))) { DatiOrdine.CodBan = ""; } else { DatiOrdine.CodBan = reader.GetString(reader.GetOrdinal("CodBan")); }
                    if (reader.IsDBNull(reader.GetOrdinal("FlagListino"))) { DatiOrdine.FlagListino = false; } else { DatiOrdine.FlagListino = reader.GetBoolean(reader.GetOrdinal("FlagListino")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpd"))) { DatiOrdine.CodSpe1 = ""; } else { DatiOrdine.CodSpe1 = reader.GetString(reader.GetOrdinal("CodSpd")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodAge"))) { DatiOrdine.Agente = ""; } else { DatiOrdine.Agente = reader.GetString(reader.GetOrdinal("CodAge")); }
                    if (reader.IsDBNull(reader.GetOrdinal("U_Trasporto"))) { DatiOrdine.U_Trasporto = 0; } else { DatiOrdine.U_Trasporto = (float)reader.GetDouble(reader.GetOrdinal("U_Trasporto")); }
                }
                reader.Close();
            }
            return DatiOrdine;
        }


        public void U_EliminaArticolo(string CodiceArticolo, int NumeroOrdine)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@NumeroOrdine", NumeroOrdine);
            objParams[1] = new SqlParameter("@CodiceArticolo", CodiceArticolo);
            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliDett_ArticoliDelete", objParams);
        }

        public void U_SvuotaDettaglioOrdine(int NumeroOrdine)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@NumeroOrdine", NumeroOrdine);

            objSqlHelper.ExecuteNonQueryForNews("U_SvuotaDettaglioOrdine", objParams);
        }

        public float GetGiacenzaArticolo(string CodiceArticolo, DateTime Data)
        {
            string SqlString = "SELECT NumEser FROM Esercizi WHERE (DataIni < CONVERT(DATETIME, '" + Data + "')) AND (DataFine > CONVERT(DATETIME, '" + Data + "'))";
            float TotaleProdotto = 0;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;

                SqlDataReader myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    int NumEser = Convert.ToInt32(myReader["NumEser"].ToString());

                    SqlString = "SELECT top 1 (Giacenza + Carichi - Scarichi) as TotProdotto FROM SaldiMag where CodArt = '" + CodiceArticolo + "' and Esercizio = " + NumEser + "";

                    using (SqlConnection myConnection_2 = new SqlConnection())
                    {
                        myConnection_2.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                        SqlCommand myCommand_2 = new SqlCommand();
                        myCommand_2.Connection = myConnection_2;
                        myCommand_2.CommandText = SqlString;
                        myConnection_2.Open();


                        SqlDataReader myReader_2 = myCommand_2.ExecuteReader();

                        while (myReader_2.Read())
                        {
                            TotaleProdotto = (float)Convert.ToDouble(myReader_2["TotProdotto"].ToString());

                        }


                        myReader_2.Close();
                        myConnection_2.Close();
                    }

                }


                myReader.Close();
                myConnection.Close();
            }
            return TotaleProdotto;
        }
        public List<Ordini_Crud> U_ArticoliOrdini_Get(string NumeroOrdine)
        {
            string SqlString = "SELECT  dbo.OrdCliDett.CodArt,dbo.OrdCliDett.Note,  dbo.OrdCliDett.UM, dbo.OrdCliDett.QtaOrd, dbo.OrdCliDett.Prezzo, dbo.OrdCliDett.Importo, dbo.Articoli.Descrizione AS DescrizioneArticolo, dbo.OrdCliTest.ID, dbo.OrdCliTest.OrdNum FROM dbo.OrdCliDett INNER JOIN dbo.Articoli ON dbo.OrdCliDett.CodArt = dbo.Articoli.CodArt INNER JOIN dbo.OrdCliTest ON dbo.OrdCliDett.IDTestata = dbo.OrdCliTest.ID where OrdCliTest.OrdNum = '" + NumeroOrdine + "'";
            List<Ordini_Crud> ListaRicariche = new List<Ordini_Crud>();
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }
                else
                {
                    while (myReader.Read())
                    {
                        Ordini_Crud itemTemp1 = new Ordini_Crud();
                        itemTemp1.Note = myReader["Note"].ToString();
                        itemTemp1.CodArt = myReader["CodArt"].ToString();
                        itemTemp1.DescrizioneArticolo = myReader["DescrizioneArticolo"].ToString();
                        itemTemp1.UM = myReader["UM"].ToString();
                        itemTemp1.QtaOrdVar = Convert.ToDecimal(myReader["QtaOrd"]);
                        itemTemp1.Prezzo = (float)Convert.ToDouble(myReader["Prezzo"].ToString());
                        itemTemp1.Importo = (float)Convert.ToDouble(myReader["Importo"].ToString());
                        ListaRicariche.Add(itemTemp1);
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ListaRicariche;
        }
        public Ordini_Crud U_OrdCliTestBozza_Get(int Nord)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@NOrd", Nord);
            Ordini_Crud DatiOrdine = new Ordini_Crud();
            using (SqlDataReader reader = objSqlHelper.ExecuteReader("U_GetDatiOrdineBozza", objParams))
            {
                while (reader.Read())
                {
                    if (reader.IsDBNull(reader.GetOrdinal("NumOrdCli"))) { DatiOrdine.NumOrdCli = ""; } else { DatiOrdine.NumOrdCli = reader.GetString(reader.GetOrdinal("NumOrdCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("DataOrdCli"))) { DatiOrdine.DataOrdCli = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.DataOrdCli = reader.GetDateTime(reader.GetOrdinal("DataOrdCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Note"))) { DatiOrdine.Note = ""; } else { DatiOrdine.Note = reader.GetString(reader.GetOrdinal("Note")); }
                    if (reader.IsDBNull(reader.GetOrdinal("OrdDat"))) { DatiOrdine.OrdDat = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.OrdDat = reader.GetDateTime(reader.GetOrdinal("OrdDat")); }
                    if (reader.IsDBNull(reader.GetOrdinal("PrevCons"))) { DatiOrdine.PrevCons = Convert.ToDateTime("01/01/2000"); } else { DatiOrdine.PrevCons = reader.GetDateTime(reader.GetOrdinal("PrevCons")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodDiv"))) { DatiOrdine.CodDiv = ""; } else { DatiOrdine.CodDiv = reader.GetString(reader.GetOrdinal("CodDiv")); }
                    if (reader.IsDBNull(reader.GetOrdinal("OrdNum"))) { DatiOrdine.OrdNum = ""; } else { DatiOrdine.OrdNum = reader.GetString(reader.GetOrdinal("OrdNum")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto1"))) { DatiOrdine.Sconto1 = 0; } else { DatiOrdine.Sconto1 = (float)reader.GetDouble(reader.GetOrdinal("Sconto1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Sconto2"))) { DatiOrdine.Sconto2 = 0; } else { DatiOrdine.Sconto2 = (float)reader.GetDouble(reader.GetOrdinal("Sconto2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodLis"))) { DatiOrdine.CodLis = ""; } else { DatiOrdine.CodLis = reader.GetString(reader.GetOrdinal("CodLis")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodPor"))) { DatiOrdine.CodPor = ""; } else { DatiOrdine.CodPor = reader.GetString(reader.GetOrdinal("CodPor")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Descrizione"))) { DatiOrdine.DescrizioneListino = ""; } else { DatiOrdine.DescrizioneListino = reader.GetString(reader.GetOrdinal("Descrizione")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Valuta"))) { DatiOrdine.Valuta = false; } else { DatiOrdine.Valuta = reader.GetBoolean(reader.GetOrdinal("Valuta")); }
                    if (reader.IsDBNull(reader.GetOrdinal("BanCli"))) { DatiOrdine.BanCli = 0; } else { DatiOrdine.BanCli = reader.GetInt32(reader.GetOrdinal("BanCli")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodBan"))) { DatiOrdine.CodBan = ""; } else { DatiOrdine.CodBan = reader.GetString(reader.GetOrdinal("CodBan")); }
                    if (reader.IsDBNull(reader.GetOrdinal("Agente"))) { DatiOrdine.Agente = ""; } else { DatiOrdine.Agente = reader.GetString(reader.GetOrdinal("Agente")); }
                    if (reader.IsDBNull(reader.GetOrdinal("FlagListino"))) { DatiOrdine.FlagListino = false; } else { DatiOrdine.FlagListino = reader.GetBoolean(reader.GetOrdinal("FlagListino")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpe1"))) { DatiOrdine.CodSpe1 = ""; } else { DatiOrdine.CodSpe1 = reader.GetString(reader.GetOrdinal("CodSpe1")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodSpe2"))) { DatiOrdine.CodSpe2 = ""; } else { DatiOrdine.CodSpe2 = reader.GetString(reader.GetOrdinal("CodSpe2")); }
                    if (reader.IsDBNull(reader.GetOrdinal("U_Flag_Trasp"))) { DatiOrdine.FlagTrasporto = false; } else { DatiOrdine.FlagTrasporto = reader.GetBoolean(reader.GetOrdinal("U_Flag_Trasp")); }
                    if (reader.IsDBNull(reader.GetOrdinal("U_TrasportoAgente"))) { DatiOrdine.CostoTrasportoString = 0; } else { DatiOrdine.CostoTrasportoString = (float)reader.GetDouble(reader.GetOrdinal("U_TrasportoAgente")); }
                    if (reader.IsDBNull(reader.GetOrdinal("CodCli"))) { DatiOrdine.CodCli = ""; } else { DatiOrdine.CodCli = reader.GetString(reader.GetOrdinal("CodCli")); }

                }
                reader.Close();
            }
            return DatiOrdine;
        }
        public void U_OrdCliDettBozza_Insert(Ordini_Crud Articolo)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[11];
            objParams[0] = new SqlParameter("@CodArt", Articolo.CodArt);
            objParams[1] = new SqlParameter("@UM", Articolo.UM);
            objParams[2] = new SqlParameter("@QtaOrd", Articolo.QtaOrd);
            objParams[3] = new SqlParameter("@Prezzo", Articolo.Prezzo);
            //objParams[4] = new SqlParameter("@Sconto", Articolo.Sconto);
            //objParams[5] = new SqlParameter("@Sconto2", Articolo.Sconto2);
            objParams[4] = new SqlParameter("@Importo", Articolo.Importo);
            objParams[5] = new SqlParameter("@Note", Articolo.Note);
            objParams[6] = new SqlParameter("@IdTestata", Articolo.IdTestata);
            objParams[7] = new SqlParameter("@NRiga", Articolo.NRiga);
            objParams[8] = new SqlParameter("@QtaAnag", Articolo.QtaAnag);
            objParams[9] = new SqlParameter("@U_Confez_Intra", Articolo.U_Confez_Intra);
            objParams[10] = new SqlParameter("@Sconto", Articolo.Sconto);

            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliDettBozza_Insert", objParams);
        }
        public void U_OrdCliDettBozze_Update(Ordini_Crud Articolo, int Nord)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[6];
            objParams[0] = new SqlParameter("@CodArt", Articolo.CodArt);
            objParams[1] = new SqlParameter("@Note", Articolo.Note);
            objParams[2] = new SqlParameter("@QtaOrd", Articolo.QtaOrdBozze);
            objParams[3] = new SqlParameter("@QtaAnag", Articolo.QtaAnagBozze);
            objParams[4] = new SqlParameter("@Importo", Articolo.Importo);
            objParams[5] = new SqlParameter("@ID", Nord);


            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliDettBozze_Update", objParams);
        }
        public void U_OrdCliTestBozze_Delete(int Nord)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@NumeroOrdine", Nord);
            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliTestBozze_Delete", objParams);
        }

        public void U_OrdCliTestBozze_Update(Ordini_Crud Articolo, int Nord)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[6];
            objParams[0] = new SqlParameter("@DataOrdCli", Articolo.DataOrdCli);
            objParams[1] = new SqlParameter("@PrevCons", Articolo.PrevCons);
            objParams[2] = new SqlParameter("@FlagTrasporto", Articolo.FlagTrasporto);
            objParams[3] = new SqlParameter("@CostoTrasporto", Articolo.CostoTrasporto);
            objParams[4] = new SqlParameter("@Note", Articolo.Note);
            objParams[5] = new SqlParameter("@ID", Nord);
            objSqlHelper.ExecuteNonQueryForNews("U_OrdCliTestBozze_Update", objParams);
        }

        public void U_SaldiMagOrd_Update(Ordini_Crud SaldiOrd)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@CodArt", SaldiOrd.CodArt);
            objParams[1] = new SqlParameter("@QtaOrd", SaldiOrd.QtaOrd);

            objSqlHelper.ExecuteNonQueryForNews("U_SaldiMagOrd_Update", objParams);
        }

        public void U_OrdCSpese_Insert(Ordini_Crud Insert)
        {
            Gestionale4PortalHelper objSqlHelper = new Gestionale4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[6];
            objParams[0] = new SqlParameter("@IDTest", Insert.IdTestata);
            objParams[1] = new SqlParameter("@Tipo", Insert.Tipo);
            objParams[2] = new SqlParameter("@Nriga", Insert.Nriga);
            objParams[3] = new SqlParameter("@Percent", Insert.Percent);
            objParams[4] = new SqlParameter("@Importo", Insert.Importo);
            objParams[5] = new SqlParameter("@CodIva", Insert.CodIva);

            objSqlHelper.ExecuteNonQueryForNews("U_OrdCSpese_Insert", objParams);
        }

        public List<Ordini_Crud> U_DefSpese_GET()
        {
            string SqlString = "SELECT IdSpesa, codiva from defspese ";
            List<Ordini_Crud> ListaRicariche = new List<Ordini_Crud>();
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }
                else
                {
                    while (myReader.Read())
                    {
                        Ordini_Crud itemTemp1 = new Ordini_Crud();
                        itemTemp1.IdSpesa = Convert.ToInt32(myReader["IdSpesa"].ToString());
                        itemTemp1.CodIva = myReader["codiva"].ToString();
                        ListaRicariche.Add(itemTemp1);
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ListaRicariche;
        }

    }
}