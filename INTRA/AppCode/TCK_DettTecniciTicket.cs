using info4lab;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Descrizione di riepilogo per Col_Rapportini
/// </summary>
public class TCK_DettTecniciTicket
{
    public TCK_DettTecniciTicket()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }

    private int _CodRapportino;
    public int CodRapportino
    {
        get { return _CodRapportino; }
        set { _CodRapportino = value; }
    }


    public string Utente
    {
        get; set;
    }

    private string _Ore;
    public string Ore
    {
        get { return _Ore; }
        set { _Ore = value; }
    }

    //---------------


    public string OraInizio { get; set; }
    public string OraFine { get; set; }
    public int Id { get; set; }
    public float Tempo { get; set; }
    public string UM { get; set; }
    public float TotaleTempo { get; set; }
    public int TotTecnici { get; set; }

    public int TCK_DettTecniciTicket_Insert(TCK_DettTecniciTicket Tecnici)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[7];

        objParams[0] = new SqlParameter("@CodRapportino", Tecnici.CodRapportino);
        objParams[1] = new SqlParameter("@Utente", Tecnici.Utente);
        objParams[2] = new SqlParameter("@Ore", Tecnici.Ore);
        objParams[3] = new SqlParameter("@OraInizio", Tecnici.OraInizio);
        objParams[4] = new SqlParameter("@OraFine", Tecnici.OraFine);
        objParams[5] = new SqlParameter("@Tempo", Tecnici.Tempo);
        objParams[6] = new SqlParameter("@UM", Tecnici.UM);
        //COL_Det_Tecnici_Insert TCK_DettTecniciTicket_Insert
        int LastId = objSqlHelper.ExecuteNonQueryForNews("TCK_DettTecniciTicket_Insert", objParams);
        return LastId;
    }

    public void TCK_DettTecniciTicket_Update(TCK_DettTecniciTicket Tecnici)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[5];

        objParams[0] = new SqlParameter("@id", Tecnici.Id);
        objParams[1] = new SqlParameter("@Tempo", Tecnici.Tempo);
        objParams[2] = new SqlParameter("@OraInizio", Tecnici.OraInizio);
        objParams[3] = new SqlParameter("@OraFine", Tecnici.OraFine);
        objParams[4] = new SqlParameter("@UM", Tecnici.UM);
        //COL_Det_Tecnici_Edit 
        objSqlHelper.ExecuteNonQueryForNews("TCK_DettTecniciTicket_Update", objParams);
    }
    public void TCK_DettTecniciTicket_Delete(TCK_DettTecniciTicket Tecnici)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];

        objParams[0] = new SqlParameter("@id", Tecnici.Id);


        objSqlHelper.ExecuteNonQueryForNews("TCK_DettTecniciTicket_Delete", objParams);
    }
    public void TCK_DettTecniciTicket_AvviaTicket(TCK_DettTecniciTicket Tecnici)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[4];

        objParams[0] = new SqlParameter("@CodRapportino", Tecnici.CodRapportino);
        objParams[1] = new SqlParameter("@Ore", Tecnici.Ore);
        objParams[2] = new SqlParameter("@OraInizio", Convert.ToDateTime(Tecnici.OraInizio));
        objParams[3] = new SqlParameter("@OraFine", Convert.ToDateTime(Tecnici.OraFine));

        //COL_Det_Tecnici_Edit 
        objSqlHelper.ExecuteNonQueryForNews("TCK_DettTecniciTicket_AvviaTicket", objParams);
    }
    public string CalcolaOreTecnico(double MinOraInizio, double MinOraFine, int TCK_TipoEsecuzione)
    {
        string TotaleOreReturn = string.Empty;
        TCK_TipoEsecuzione _ParamCalcolo = new TCK_TipoEsecuzione();
        _ParamCalcolo = _ParamCalcolo.ParametriCalcoloTempoFattura(TCK_TipoEsecuzione);
        double TotaleOre = (MinOraFine - MinOraInizio) / 60;
        double TotaleMinuti = (MinOraFine - MinOraInizio);
        //double ArrotodamentoVar = _ParamCalcolo.ArrotodamentoMinuti;
        //double MinimoFatturabileVar = _ParamCalcolo.MinimoFatturabileMinuti;

        //double MinimoFatturabile = MinimoFatturabileVar / 60;
        //double Arrotondamento = ArrotodamentoVar / 60;
        //double TotaleArrotondamento = Math.Truncate(TotaleOre / Arrotondamento) * Arrotondamento;
        //// verifico se è un multiplo del minimo fatturabile   


        ////double appoggio = ((TotaleArrotondamento - Math.Truncate(TotaleArrotondamento)) / Arrotondamento) % 1;
        //double Diff = TotaleArrotondamento - Math.Truncate(TotaleArrotondamento);
        //if (ArrotodamentoVar > 0)
        //{
        //    if ((TotaleOre - TotaleArrotondamento) > 0)
        //    {
        //        TotaleOre = TotaleArrotondamento + Arrotondamento;
        //    }
        //    else { TotaleOre = TotaleArrotondamento; }
        //    //sulla base degli arrotondamenti devo restituire il totale arrotondato
        //    // ,[MinimoFatturabileMinuti] ,[ArrotodamentoMinuti] tabella [TCK_TipoEsecuzione]
        //    TotaleOreReturn = TotaleOre.ToString();
        //}
        //if (TotaleOre < MinimoFatturabile)
        //{
        //    TotaleOreReturn = MinimoFatturabile.ToString();
        //}
        //else
        //{
        //    TotaleOreReturn = TotaleMinuti.ToString();
        //}
        if (_ParamCalcolo.UM == "Min")
        {
            TotaleOreReturn = TotaleMinuti.ToString();
        }
        else
        {
            TotaleOreReturn = Convert.ToString(TotaleOre);
        }
        return TotaleOreReturn;

    }
    public double CalcolaTotaleOre(float TotaleTempo, string UM, int TCK_TipoEsecuzione)
    {
        double TotaleOreReturn = 0;
        TCK_TipoEsecuzione _ParamCalcolo = new TCK_TipoEsecuzione();
        _ParamCalcolo = _ParamCalcolo.ParametriCalcoloTempoFattura(TCK_TipoEsecuzione);

        double TotaleOre = 0;
        double TotaleMinuti = 0;

        if (UM == "Min")
        {
            TotaleMinuti = TotaleTempo;
            TotaleOre = TotaleTempo / 60;
        }
        else
        {
            TotaleMinuti = TotaleTempo * 60;
            TotaleOre = TotaleTempo;
        }
        double ArrotodamentoVar = _ParamCalcolo.ArrotodamentoMinuti;
        double MinimoFatturabileVar = _ParamCalcolo.MinimoFatturabileMinuti;

        double MinimoFatturabile = MinimoFatturabileVar / 60;
        double Arrotondamento = ArrotodamentoVar / 60;
        double TotaleArrotondamento = Math.Truncate(TotaleOre / Arrotondamento) * Arrotondamento;
        // verifico se è un multiplo del minimo fatturabile   


        //double appoggio = ((TotaleArrotondamento - Math.Truncate(TotaleArrotondamento)) / Arrotondamento) % 1;
        double Diff = TotaleArrotondamento - Math.Truncate(TotaleArrotondamento);
        if (ArrotodamentoVar > 0)
        {
            if ((TotaleOre - TotaleArrotondamento) > 0)
            {
                TotaleOre = TotaleArrotondamento + Arrotondamento;
            }
            else { TotaleOre = TotaleArrotondamento; }
            //sulla base degli arrotondamenti devo restituire il totale arrotondato
            // ,[MinimoFatturabileMinuti] ,[ArrotodamentoMinuti] tabella [TCK_TipoEsecuzione]
            TotaleOreReturn = TotaleOre;
        }
        if (TotaleOre < MinimoFatturabile)
        {
            TotaleOreReturn = MinimoFatturabile;
        }
        //else
        //{
        //    TotaleOreReturn = TotaleMinuti;
        //}
        if (_ParamCalcolo.UM == "Min")
        {
            TotaleOreReturn = TotaleMinuti;
        }

        return TotaleOreReturn;

    }
    public TCK_DettTecniciTicket TotaleTempo_e_UM_Get(int IdTicket)
    {
        TCK_DettTecniciTicket _RetObj = new TCK_DettTecniciTicket();
        string ConnectionStrings = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(ConnectionStrings))
        {
            string query = "SELECT SUM(Tempo) AS TotaleTempo, UM, CodRapportino, COUNT(Utente) AS TotTecnici FROM TCK_DettTecniciTicket GROUP BY UM, CodRapportino HAVING(CodRapportino = " + IdTicket + ")";
            SqlCommand cmd = new SqlCommand(query, conn);
            try
            {
                conn.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        _RetObj.TotaleTempo = (float)Convert.ToDouble(rdr["TotaleTempo"].ToString());
                        _RetObj.UM = rdr["UM"].ToString();
                        _RetObj.TotTecnici = Convert.ToInt32(rdr["TotTecnici"].ToString());
                    }
                    rdr.Close();
                }
            }
            finally
            {
                cmd.Cancel();
                conn.Close();
            }
            return _RetObj;
        }
    }
    public TCK_DettTecniciTicket TotTicketTec_Get(int IdTicket)
    {
        TCK_DettTecniciTicket _RetObj = new TCK_DettTecniciTicket();
        string ConnectionStrings = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(ConnectionStrings))
        {
            string query = "SELECT [TotTecnici] ,[TempoInterventoTotale] ,[UM] FROM [TCK_TestataTicket] where CodRapportino = " + IdTicket;
            SqlCommand cmd = new SqlCommand(query, conn);
            try
            {
                conn.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        _RetObj.TotaleTempo = (float)Convert.ToDouble(rdr["TempoInterventoTotale"].ToString());
                        _RetObj.UM = rdr["UM"].ToString();
                        _RetObj.TotTecnici = Convert.ToInt32(rdr["TotTecnici"].ToString());
                    }
                    rdr.Close();
                }
            }
            finally
            {
                cmd.Cancel();
                conn.Close();
            }
            return _RetObj;
        }
    }
    public TCK_DettTecniciTicket TCK_TestataTicket_InizioFine_Get(int CodRapportino)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];
        objParams[0] = new SqlParameter("@CodRapportino", CodRapportino);
        //----------------
        TCK_DettTecniciTicket TCK_TestataTicket_InizioFine_Get = new TCK_DettTecniciTicket();
        using (SqlDataReader reader = objSqlHelper.ExecuteReader("TCK_TestataTicket_InizioFine_Get", objParams))
        {
            while (reader.Read())
            {
                if (reader.IsDBNull(reader.GetOrdinal("OraInizio")))
                { TCK_TestataTicket_InizioFine_Get.OraInizio = string.Empty; }
                else
                { TCK_TestataTicket_InizioFine_Get.OraInizio = Convert.ToString(reader.GetTimeSpan(reader.GetOrdinal("OraInizio"))); }

                if (reader.IsDBNull(reader.GetOrdinal("OraFine")))
                { TCK_TestataTicket_InizioFine_Get.OraFine = string.Empty; }
                else { TCK_TestataTicket_InizioFine_Get.OraFine = Convert.ToString(reader.GetTimeSpan(reader.GetOrdinal("OraFine"))); }
            }
            reader.Close();
        }
        return TCK_TestataTicket_InizioFine_Get;
    }

    public List<TCK_DettTecniciTicket> TCK_TestataTicket_Tecnici_get(int CodRapportino)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];
        objParams[0] = new SqlParameter("@CodRapportino", CodRapportino);
        //----------------
        List<TCK_DettTecniciTicket> listTeck = new List<TCK_DettTecniciTicket>();
        using (SqlDataReader reader = objSqlHelper.ExecuteReader("TCK_TestataTicket_Tecnici_get", objParams))
        {
            while (reader.Read())
            {
                TCK_DettTecniciTicket DetTeck = new TCK_DettTecniciTicket();
                DetTeck.Utente = reader.GetString(reader.GetOrdinal("Utente"));
                listTeck.Add(DetTeck);
            }
            reader.Close();
        }
        return listTeck;
    }

}