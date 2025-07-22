using info4lab;
using INTRA.AppCode;
using System;
using System.Data.SqlClient;

/// <summary>
/// Descrizione di riepilogo per STD_Servizi
/// </summary>
public class DomVsService
{
    public DomVsService()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }

    private int _IdServizio;
    public int IdServizio
    {
        get { return _IdServizio; }
        set { _IdServizio = value; }
    }

    private string _NomeServizio;
    public string NomeServizio
    {
        get { return _NomeServizio; }
        set { _NomeServizio = value; }
    }

    private string _DataAtt;
    public string DataAtt
    {
        get { return _DataAtt; }
        set { _DataAtt = value; }
    }

    private string _DataScad;
    public string DataScad
    {
        get { return _DataScad; }
        set { _DataScad = value; }
    }

    private string _Descrizione;
    public string Descrizione
    {
        get { return _Descrizione; }
        set { _Descrizione = value; }
    }

    private decimal _Prezzo;
    public decimal Prezzo
    {
        get { return _Prezzo; }
        set { _Prezzo = value; }
    }

    private string _IdTipoServizio;
    public string IdTipoServizio
    {
        get { return _IdTipoServizio; }
        set { _IdTipoServizio = value; }
    }

    private string _EditUser;
    public string EditUser
    {
        get { return _EditUser; }
        set { _EditUser = value; }
    }

    private string _CreatedOn;
    public string CreatedOn
    {
        get { return _CreatedOn; }
        set { _CreatedOn = value; }
    }

    private string _UpdatedOn;
    public string UpdatedOn
    {
        get { return _UpdatedOn; }
        set { _UpdatedOn = value; }
    }

    private string _DeletedOn;
    public string DeletedOn
    {
        get { return _DeletedOn; }
        set { _DeletedOn = value; }
    }

    private int _KeyId;
    public int KeyId
    {
        get { return _KeyId; }
        set { _KeyId = value; }
    }

    private string _KeyName;
    public string KeyName
    {
        get { return _KeyName; }
        set { _KeyName = value; }
    }


    public int InsertSTD_Servizi(DomVsService Servizi)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[12];

        objParams[0] = new SqlParameter("@NomeServizio", Servizi.NomeServizio);
        objParams[1] = new SqlParameter("@DataAtt", Convert.ToDateTime(Servizi.DataAtt));
        objParams[2] = new SqlParameter("@DataScad", Convert.ToDateTime(Servizi.DataScad));
        objParams[3] = new SqlParameter("@Descrizione", Servizi.Descrizione);
        objParams[4] = new SqlParameter("@Prezzo", Convert.ToDecimal(Servizi.Prezzo));
        objParams[5] = new SqlParameter("@IdTipoServizio", Convert.ToInt32(Servizi.IdTipoServizio));
        objParams[6] = new SqlParameter("@EditUser", Servizi.EditUser);
        objParams[7] = new SqlParameter("@CreatedOn", Convert.ToDateTime(Servizi.CreatedOn));
        objParams[8] = new SqlParameter("@UpdatedOn", Convert.ToDateTime(Servizi.UpdatedOn));
        objParams[9] = new SqlParameter("@DeletedOn", Convert.ToDateTime(Servizi.DeletedOn));
        objParams[10] = new SqlParameter("@KeyId", Convert.ToInt32(Servizi.KeyId));
        objParams[11] = new SqlParameter("@KeyName", Servizi.KeyName);

        int LastId = objSqlHelper.ExecuteNonQueryForNews("DomVsServiceInsert", objParams);
        return LastId;

    }

    public void UpdateSTD_Servizi(DomVsService Servizi)
    {

        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[10];

        objParams[0] = new SqlParameter("@NomeServizio", Servizi.NomeServizio);
        objParams[1] = new SqlParameter("@DataAtt", Convert.ToDateTime(Servizi.DataAtt));
        objParams[2] = new SqlParameter("@DataScad", Convert.ToDateTime(Servizi.DataScad));
        objParams[3] = new SqlParameter("@Descrizione", Servizi.Descrizione);
        objParams[4] = new SqlParameter("@Prezzo", Convert.ToDecimal(Servizi.Prezzo));
        objParams[5] = new SqlParameter("@IdTipoServizio", Convert.ToInt32(Servizi.IdTipoServizio));
        objParams[6] = new SqlParameter("@EditUser", Servizi.EditUser);
        objParams[7] = new SqlParameter("@UpdatedOn", Convert.ToDateTime(Servizi.UpdatedOn));
        objParams[8] = new SqlParameter("@DeletedOn", Convert.ToDateTime(Servizi.DeletedOn));
        objParams[9] = new SqlParameter("@IdServizio", Convert.ToInt32(Servizi.IdServizio));

        objSqlHelper.ExecuteNonQueryForNews("DomVsServiceEdit", objParams);

    }
    public void DeleteSTD_Servizi(int idServizio)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];

        objParams[0] = new SqlParameter("@IdServizio", idServizio);

        objSqlHelper.ExecuteNonQueryForNews("DomVsServiceDelete", objParams);
    }
}