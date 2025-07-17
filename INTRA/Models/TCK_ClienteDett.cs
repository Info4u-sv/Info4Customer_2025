using Info4U.Models;
using System.Data.SqlClient;

/// <summary>
/// Descrizione di riepilogo per Col_Rapportini
/// </summary>
public class TCK_ClienteDett
{
    public TCK_ClienteDett()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }

    #region property

    public string societa { get; set; }
    public string Denom { get; set; }
    public string Ind { get; set; }
    public string Cap { get; set; }
    public string Prov { get; set; }
    public string Loc { get; set; }
    public string Tel { get; set; }
    public string Fax { get; set; }
    public string Riferim { get; set; }
    public string PIva { get; set; }
    public string EMail { get; set; }



    #endregion



    public TCK_ClienteDett TCK_ClienteDet_Get(string codCli)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];
        objParams[0] = new SqlParameter("@CodCli", codCli);

        //----------------



        TCK_ClienteDett IstanzaTCK_ClienteDett = new TCK_ClienteDett();
        using (SqlDataReader reader = objSqlHelper.ExecuteReader("TCK_ClienteDet_Get", objParams))
        {
            while (reader.Read())
            {



                IstanzaTCK_ClienteDett.Denom = reader.GetString(reader.GetOrdinal("Denom"));





                if (reader.IsDBNull(reader.GetOrdinal("Tel"))) { IstanzaTCK_ClienteDett.Tel = string.Empty; } else { IstanzaTCK_ClienteDett.Tel = reader.GetString(reader.GetOrdinal("Tel")); }
                if (reader.IsDBNull(reader.GetOrdinal("Fax"))) { IstanzaTCK_ClienteDett.Fax = string.Empty; } else { IstanzaTCK_ClienteDett.Fax = reader.GetString(reader.GetOrdinal("Fax")); }
                if (reader.IsDBNull(reader.GetOrdinal("Riferim"))) { IstanzaTCK_ClienteDett.Riferim = string.Empty; } else { IstanzaTCK_ClienteDett.Riferim = reader.GetString(reader.GetOrdinal("Riferim")); }

                if (reader.IsDBNull(reader.GetOrdinal("PIva"))) { IstanzaTCK_ClienteDett.PIva = string.Empty; } else { IstanzaTCK_ClienteDett.PIva = reader.GetString(reader.GetOrdinal("PIva")); }
                if (reader.IsDBNull(reader.GetOrdinal("EMail"))) { IstanzaTCK_ClienteDett.EMail = string.Empty; } else { IstanzaTCK_ClienteDett.EMail = reader.GetString(reader.GetOrdinal("EMail")); }
                if (reader.IsDBNull(reader.GetOrdinal("Loc"))) { IstanzaTCK_ClienteDett.Loc = string.Empty; } else { IstanzaTCK_ClienteDett.Loc = reader.GetString(reader.GetOrdinal("Loc")); }

                if (reader.IsDBNull(reader.GetOrdinal("Prov"))) { IstanzaTCK_ClienteDett.Prov = string.Empty; } else { IstanzaTCK_ClienteDett.Prov = reader.GetString(reader.GetOrdinal("Prov")); }
                if (reader.IsDBNull(reader.GetOrdinal("Cap"))) { IstanzaTCK_ClienteDett.Cap = string.Empty; } else { IstanzaTCK_ClienteDett.Cap = reader.GetString(reader.GetOrdinal("Cap")); }
                if (reader.IsDBNull(reader.GetOrdinal("Ind"))) { IstanzaTCK_ClienteDett.Ind = string.Empty; } else { IstanzaTCK_ClienteDett.Ind = reader.GetString(reader.GetOrdinal("Ind")); }


            }
            reader.Close();
        }
        return IstanzaTCK_ClienteDett;
    }










}