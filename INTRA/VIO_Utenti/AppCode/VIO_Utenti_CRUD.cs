using info4lab;
using INTRA.AppCode;
using System;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace INTRA.VIO_Utenti.AppCode
{

    public class VIO_Utenti_CRUD
    {
        public string ID { get; set; }
        public string UtenteIntranet { get; set; }
        public string EmailContatto { get; set; }
        public DateTime DataBlocco { get; set; }
        public string Tipologia { get; set; }
        public bool Scaduto { get; set; }
        public string Azienda { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public string CodAge { get; set; }
        public string TipoAge { get; set; }
        public string CodCat { get; set; }
        public string CodTecnicoCat { get; set; }
        public string CodCli { get; set; }
        public string NomeUtente { get; set; }
        public string Email { get; set; }
        public string CodCliCat { get; set; }


        public void VIO_Utenti_Update(VIO_Utenti_CRUD _obj)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[4];
            objParams[0] = new SqlParameter("@Nome", _obj.Nome);
            objParams[1] = new SqlParameter("@Cognome", _obj.Cognome);
            objParams[2] = new SqlParameter("@EmailContatto", _obj.EmailContatto);
            objParams[3] = new SqlParameter("@UtenteIntranet", _obj.UtenteIntranet);
            _ = objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Update", objParams);
        }

        public static VIO_Utenti_CRUD GetVIO_Utenti_Det(string UserName)
        {
            string SqlString = "SELECT * FROM [dbo].[VIO_Utenti] WHERE [UtenteIntranet] ='" + UserName + "'";
            VIO_Utenti_CRUD _retObj = new VIO_Utenti_CRUD();
            SqlDataReader reader = new Sql4Helper().ExecuteReader(SqlString);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    _retObj.Tipologia = reader["Tipologia"].ToString();
                    _retObj.CodCat = reader["CodCat"].ToString();
                    _retObj.CodTecnicoCat = reader["CodTecnicoCat"].ToString();
                    _retObj.CodCli = reader["CodCli"].ToString();
                }
            }
            return _retObj;
        }
        public int InsertUtente(VIO_Utenti_CRUD settings)
        {
            Sql4Helper helper = new Sql4Helper();
            SqlParameter[] parameters = new SqlParameter[5];
            parameters[0] = new SqlParameter("@UtenteIntranet", settings.NomeUtente);
            parameters[1] = new SqlParameter("@EmailContatto", settings.Email);
            parameters[2] = new SqlParameter("@Tipologia", settings.Tipologia);
            parameters[3] = new SqlParameter("@Azienda", settings.Azienda);
            parameters[4] = new SqlParameter("@CodCli", settings.CodCli);

            return helper.ExecuteNonQuery("VIO_Utenti_Insert", parameters);
        }
        public int InsertUtenteClienteCat(VIO_Utenti_CRUD settings)
        {
            Sql4Helper helper = new Sql4Helper();
            SqlParameter[] parameters = new SqlParameter[7];
            parameters[0] = new SqlParameter("@UtenteIntranet", settings.NomeUtente);
            parameters[1] = new SqlParameter("@EmailContatto", settings.Email);
            parameters[2] = new SqlParameter("@Tipologia", settings.Tipologia);
            parameters[3] = new SqlParameter("@Azienda", settings.Azienda);
            parameters[4] = new SqlParameter("@CodCat", settings.CodCat);
            parameters[5] = new SqlParameter("@CodCli", settings.CodCli);
            parameters[6] = new SqlParameter("@CodTecnicoCat", settings.CodTecnicoCat);
            return helper.ExecuteNonQuery("VIO_Utenti_ClienteCat_Insert", parameters);
        }
        public static VIO_Utenti_CRUD GetProssimoCodCliPerCat(string CodTecnicoCat)
        {

            VIO_Utenti_CRUD RetClass = new VIO_Utenti_CRUD();
            Sql4Helper helper = new Sql4Helper();
            SqlParameter[] parameters = new SqlParameter[1];
            parameters[0] = new SqlParameter("@CodTecnicoCat", CodTecnicoCat);
            SqlDataReader Reader = helper.ExecuteReader("GetProssimoCodCliPerCat", parameters);
#pragma warning disable CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
            try
            {
                _ = Reader.Read();
                RetClass.CodCli = Reader["ProssimoCodCli"].ToString();
                RetClass.CodCat = Reader["CodCat"].ToString();
                RetClass.Azienda = Reader["Azienda"].ToString();

            }
            catch (Exception)
            {

            }
#pragma warning restore CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
            return RetClass;
        }


        public static string CreatePassword(int length)
        {
            const string valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            while (0 < length--)
            {
                _ = res.Append(valid[rnd.Next(valid.Length)]);
            }
            return res.ToString();
        }

        public static int Utente_Cat_Insert(VIO_Utenti_CRUD utente)
        {
            Sql4Helper helper = new Sql4Helper();

            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@UtenteIntranet",utente.UtenteIntranet),
                new SqlParameter("@EmailContatto",utente.Email),
                new SqlParameter("@CodCat",utente.CodCat),
                new SqlParameter("@RagSoc",utente.Azienda)
                };

            int result = helper.ExecuteNonQuery("VIO_Utenti_CAT_Insert", parameters);
            return result;
        }


        public static int Utente_Tecnici_Insert(VIO_Utenti_CRUD utente)
        {
            Sql4Helper helper = new Sql4Helper();

            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@UtenteIntranet",utente.UtenteIntranet),
                new SqlParameter("@EmailContatto",utente.Email),
                new SqlParameter("@CodCliCat",utente.CodCliCat),
                new SqlParameter("@CodTecnicoCat",utente.UtenteIntranet),
                };

            int result = helper.ExecuteNonQuery("VIO_Utenti_TecniciCat_Insert", parameters);
            return result;
        }

        public static int VIO_Utenti_Delete(string Username, string Tipologia)
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@UtenteIntranet",Username),
                new SqlParameter("@Tipologia",Tipologia),
            };

            return new Sql4Helper().ExecuteNonQuery("VIO_Utenti_FlagEliminato_SET", parameters);
        }

        public static int Email_Update(string Username, string newEmail)
        {
            Sql4Helper helper = new Sql4Helper();
            string sql = $"UPDATE VIO_Utenti SET EmailContatto = '{newEmail}' WHERE UtenteIntranet = '{Username}'";

            return helper.ExecuteNonQuery(sql);
        }


        public static bool VIO_Utenti_CheckIfDeleted(string Username)
        {
            string Sql = $"SELECT * FROM VIO_Utenti WHERE UtenteIntranet = '{Username}' AND Eliminato = 1";

            return new Sql4Helper().ExecuteReader(Sql).HasRows;
        }
    }
}