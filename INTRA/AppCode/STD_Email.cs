using info4lab;
using INTRA.AppCode;
using System;
using System.Data.SqlClient;

/// <summary>
/// Descrizione di riepilogo per Col_Clienti
/// </summary>
public class STD_Email
{
    public STD_Email()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }
    private int _IdEmail;
    public int IdEmail
    {
        get { return _IdEmail; }
        set { _IdEmail = value; }
    }

    private string _Email;
    public string Email
    {
        get { return _Email; }
        set { _Email = value; }
    }

    private string _NomeUtente;
    public string NomeUtente
    {
        get { return _NomeUtente; }
        set { _NomeUtente = value; }
    }

    private string _Password;
    public string Password
    {
        get { return _Password; }
        set { _Password = value; }
    }

    private string _Nome;
    public string Nome
    {
        get { return _Nome; }
        set { _Nome = value; }
    }

    private string _Cognome;
    public string Cognome
    {
        get { return _Cognome; }
        set { _Cognome = value; }
    }

    private string _Ruolo;
    public string Ruolo
    {
        get { return _Ruolo; }
        set { _Ruolo = value; }
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

    private string _Telefono;
    public string Telefono
    {
        get { return _Telefono; }
        set { _Telefono = value; }
    }

    private string _EditUser;
    public string EditUser
    {
        get { return _EditUser; }
        set { _EditUser = value; }
    }

    public int InsertSTD_Email(STD_Email StdEmail)
    {

        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[10];
        objParams[0] = new SqlParameter("@Email", StdEmail.Email);
        objParams[1] = new SqlParameter("@NomeUtente", StdEmail.NomeUtente);
        objParams[2] = new SqlParameter("@Password", StdEmail.Password);
        objParams[3] = new SqlParameter("@Nome", StdEmail.Nome);
        objParams[4] = new SqlParameter("@Cognome", StdEmail.Cognome);
        objParams[5] = new SqlParameter("@Ruolo", StdEmail.Ruolo);
        objParams[6] = new SqlParameter("@Telefono", StdEmail.Telefono);
        objParams[7] = new SqlParameter("@EditUser", StdEmail.EditUser);
        objParams[8] = new SqlParameter("@KeyId", Convert.ToInt32(StdEmail.KeyId));
        objParams[9] = new SqlParameter("@KeyName", StdEmail.KeyName);

        int LastIdEmail = objSqlHelper.ExecuteNonQueryForNews("STD_EmailInsert", objParams);
        return LastIdEmail;
    }

    public void UpdateSTD_Email(STD_Email StdEmail)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[9];
        objParams[0] = new SqlParameter("@IdEmail", StdEmail.IdEmail);
        objParams[1] = new SqlParameter("@Email", StdEmail.Email);
        objParams[2] = new SqlParameter("@NomeUtente", StdEmail.NomeUtente);
        objParams[3] = new SqlParameter("@Password", StdEmail.Password);
        objParams[4] = new SqlParameter("@Nome", StdEmail.Nome);
        objParams[5] = new SqlParameter("@Cognome", StdEmail.Cognome);
        objParams[6] = new SqlParameter("@Ruolo", StdEmail.Ruolo);
        objParams[7] = new SqlParameter("@Telefono", StdEmail.Telefono);
        objParams[8] = new SqlParameter("@EditUser", StdEmail.EditUser);

        objSqlHelper.ExecuteNonQueryForNews("STD_EmailEdit", objParams);
    }

    public void DeleteSTD_Email(STD_Email StdEmail)
    {
        Sql4Helper objSqlHelper = new Sql4Helper();
        SqlParameter[] objParams = new SqlParameter[1];

        objParams[0] = new SqlParameter("@IdEmail", StdEmail.IdEmail);
        //----------------


        objSqlHelper.ExecuteNonQueryForNews("STD_EmailDelete", objParams);
    }
}