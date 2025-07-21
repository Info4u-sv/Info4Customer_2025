using info4lab;
using INTRA.AppCode;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Descrizione di riepilogo per AgentiCrud
/// </summary>
public class TCK_EmailInvioStatusAreaTicket
{
    public TCK_EmailInvioStatusAreaTicket()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }




    #region Property
    // Chiave
    public int IdRow { get; set; }
    public int IdAreaAss { get; set; }
    public int IdStatus { get; set; }
    public string Email { get; set; }

    public string CreatedOn { get; set; }
    public string UpdatedOn { get; set; }
    public string DeletedOn { get; set; }
    public string CrudUser { get; set; }

    #endregion


    public void EmailInvioStatusAreaTicket_Insert(TCK_EmailInvioStatusAreaTicket Obj)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[4];
        objParams[0] = new SqlParameter("@CrudUser", Obj.CrudUser);

        objParams[1] = new SqlParameter("@IdAreaAss", Obj.IdAreaAss);
        objParams[2] = new SqlParameter("@IdStatus", Obj.IdStatus);
        objParams[3] = new SqlParameter("@Email", Obj.Email);

        objSqlHelper.ExecuteNonQueryForNews("TCK_EmailInvioStatusAreaTicket_Insert", objParams);
    }

    //public void EmailInvioStatusAreaTicket__Update(TCK_EmailInvioStatusAreaTicket Obj)
    //{
    //    Sql4Helper objSqlHelper = new Sql4Helper();
    //    SqlParameter[] objParams = new SqlParameter[3];
    //    objParams[0] = new SqlParameter("@Cod_Agente", Agenti.Cod_Agente);
    //    objParams[1] = new SqlParameter("@NOMINATIVO", Agenti.NOMINATIVO);
    //    //objParams[2] = new SqlParameter("@UpdatedOn", Agenti.UpdatedOn);

    //    objParams[2] = new SqlParameter("@CrudUser", Agenti.CrudUser);

    //    objSqlHelper.ExecuteNonQueryForNews("Agenti_Kom_N_Update", objParams);
    //}

    public TCK_EmailInvioStatusAreaTicket EmailInvioStatusAreaTicket__Get(int IdRow)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];
        objParams[0] = new SqlParameter("@IdRow", IdRow);
        //----------------
        // objSqlHelper.ExecuteNonQueryForNews("AgentiKomCrud_U", objParams);


        TCK_EmailInvioStatusAreaTicket Istanza = new TCK_EmailInvioStatusAreaTicket();
        using (SqlDataReader reader = objSqlHelper.ExecuteReader("TCK_EmailInvioStatusAreaTicket__Get", objParams))
        {
            while (reader.Read())
            {

                Istanza.Email = reader.GetString(reader.GetOrdinal("Email"));


            }
            reader.Close();
        }
        return Istanza;
    }

    public void EmailInvioStatusAreaTicket_Delete(int IdRow)
    {
        string conString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ToString();
        SqlConnection con = new SqlConnection(conString);
        con.Open();
        string sql = @"DELETE FROM TCK_EmailInvioStatusAreaTicket where IdRow = " + IdRow;
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }

}