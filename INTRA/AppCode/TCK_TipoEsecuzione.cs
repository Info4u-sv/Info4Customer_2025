using System;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Descrizione di riepilogo per TCK_TipoEsecuzione
/// </summary>
public class TCK_TipoEsecuzione
{
    public int IdTipoEsecuzione { get; set; }
    public int MinimoFatturabileMinuti { get; set; }
    public int ArrotodamentoMinuti { get; set; }
    public string UM { get; set; }
    public TCK_TipoEsecuzione()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }

    public TCK_TipoEsecuzione ParametriCalcoloTempoFattura(int IdTipoEsecuzione)
    {
        TCK_TipoEsecuzione _RetObj = new TCK_TipoEsecuzione();
        string ConnectionStrings = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(ConnectionStrings))
        {
            string query = "SELECT [MinimoFatturabileMinuti], [ArrotodamentoMinuti], [UM], [id] FROM [TCK_TipoEsecuzione]  where Id = " + IdTipoEsecuzione;
            SqlCommand cmd = new SqlCommand(query, conn);
            try
            {
                conn.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        _RetObj.MinimoFatturabileMinuti = Convert.ToInt32(rdr["MinimoFatturabileMinuti"].ToString());
                        _RetObj.ArrotodamentoMinuti = Convert.ToInt32(rdr["ArrotodamentoMinuti"].ToString());
                        _RetObj.UM = rdr["UM"].ToString();
                        _RetObj.IdTipoEsecuzione = Convert.ToInt32(rdr["id"].ToString());
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

}