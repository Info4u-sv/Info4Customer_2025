using info4lab;
using INTRA.AppCode;
using System;
using System.Data.SqlClient;

/// <summary>
/// Descrizione di riepilogo per Col_Clienti
/// </summary>
public class WEB_Domini
{
    public WEB_Domini()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }

    private string _IdDominio;
    public string IdDominio
    {
        get { return _IdDominio; }
        set { _IdDominio = value; }
    }

    private DateTime _DataAttivazione;
    public DateTime DataAttivazione
    {
        get { return _DataAttivazione; }
        set { _DataAttivazione = value; }
    }

    private DateTime _DataScadenza;
    public DateTime DataScadenza
    {
        get { return _DataScadenza; }
        set { _DataScadenza = value; }
    }

    private string _Provider;
    public string Provider
    {
        get { return _Provider; }
        set { _Provider = value; }
    }

    private string _EditUser;
    public string EditUser
    {
        get { return _EditUser; }
        set { _EditUser = value; }
    }

    private string _URL;
    public string URL
    {
        get { return _URL; }
        set { _URL = value; }
    }

    private string _KeyName;
    public string KeyName
    {
        get { return _KeyName; }
        set { _KeyName = value; }
    }

    private string _CodCli;
    public string CodCli
    {
        get { return _CodCli; }
        set { _CodCli = value; }
    }

    private int _KeyId;
    public int KeyId
    {
        get { return _KeyId; }
        set { _KeyId = value; }
    }



    public int InsertWEB_Domini(WEB_Domini StdDominio)
    {

        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[7];
        objParams[0] = new SqlParameter("@URL", StdDominio.URL);
        objParams[1] = new SqlParameter("@DataAttivazione", StdDominio.DataAttivazione);
        objParams[2] = new SqlParameter("@DataScadenza", StdDominio.DataScadenza);
        objParams[3] = new SqlParameter("@Provider", StdDominio.Provider);
        objParams[4] = new SqlParameter("@EditUser", StdDominio.EditUser);
        objParams[5] = new SqlParameter("@KeyName", StdDominio.KeyName);
        objParams[6] = new SqlParameter("@CodCli", StdDominio.CodCli);

        int LastIdCliente = objSqlHelper.ExecuteNonQueryForNews("WEB_DominiInsert", objParams);
        return LastIdCliente;
    }

    public void UpdateWEB_Domini(WEB_Domini StdDominio)
    {

        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[6];
        objParams[0] = new SqlParameter("@IdDominio", StdDominio.IdDominio);
        objParams[1] = new SqlParameter("@URL", StdDominio.URL);
        objParams[2] = new SqlParameter("@DataAttivazione", StdDominio.DataAttivazione);
        objParams[3] = new SqlParameter("@DataScadenza", StdDominio.DataScadenza);
        objParams[4] = new SqlParameter("@Provider", StdDominio.Provider);
        objParams[5] = new SqlParameter("@EditUser", StdDominio.EditUser);

        objSqlHelper.ExecuteNonQueryForNews("WEB_DominiEdit", objParams);
    }




    public void DeleteWEB_Domini(WEB_Domini StdDominio)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];

        objParams[0] = new SqlParameter("@IdDominio", StdDominio.IdDominio);
        //----------------


        objSqlHelper.ExecuteNonQueryForNews("Del_Dominio_Totale", objParams);
    }

}