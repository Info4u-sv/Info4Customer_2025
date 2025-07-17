using info4lab;
using System;
using System.Data.SqlClient;

namespace INTRA.AppCode
{

    public class VIO_Utenti_CRUD_23
    {
        public string ID { get; set; }
        public string UtenteIntranet { get; set; }
        public string EmailContatto { get; set; }
        public DateTime? DataBlocco { get; set; }
        public string Tipologia { get; set; }
        public bool Scaduto { get; set; }
        public string Azienda { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public string CodAge { get; set; }
        public string CodCli { get; set; }
        public string FirmaEmail { get; set; }
        public string UtenteSMTP { get; set; } = null;
        public string PasswordSMTP { get; set; } = null;

        public VIO_Utenti_CRUD_23() { }
        public VIO_Utenti_CRUD_23(string Username)
        {
            string sql = @"SELECT ID, UtenteIntranet, EmailContatto, DataBlocco, Tipologia, Azienda, Scaduto, CodCli, FirmaEmail, Nome, Cognome, UtenteSMTP, PasswordSMTP FROM VIO_Utenti WHERE (UtenteIntranet = @UtenteIntranet)";

            SqlParameter param = new SqlParameter("@UtenteIntranet", Username);
            Sql4Helper helper = new Sql4Helper();
            SqlDataReader reader = helper.ExecuteReader(sql, param);

            if (reader.Read())
            {
                this.UtenteIntranet = reader["UtenteIntranet"] as string;
                this.EmailContatto = reader["EmailContatto"] as string;
                this.Scaduto = (bool)reader["Scaduto"];
                try
                {
                    this.DataBlocco = (DateTime)reader["DataBlocco"];
                }
                catch
                {
                    this.DataBlocco = this.Scaduto ? DateTime.Now.AddYears(-100) : DateTime.Now.AddYears(100);
                    string UpdateDatBlocco = "UPDATE VIO_Utenti SET DataBlocco = @DataBlocco WHERE (UtenteIntranet = @UtenteIntranet)";
                    SqlParameter[] paramsUpdate = new SqlParameter[] {
                        new SqlParameter("@DataBlocco", this.DataBlocco),
                        new SqlParameter("@UtenteIntranet", Username)
                    };

                    helper.ExecuteNonQuery(UpdateDatBlocco, paramsUpdate);
                }
                this.Tipologia = reader["Tipologia"] as string;
                this.Azienda = reader["Azienda"] as string;
                this.CodCli = reader["CodCli"] as string;
                this.FirmaEmail = reader["FirmaEmail"] as string;
                this.Nome = reader["Nome"] as string;
                this.Cognome = reader["Cognome"] as string;
                this.UtenteSMTP = reader["UtenteSMTP"] as string;
                this.PasswordSMTP = DataControl.Decrypt(reader["PasswordSMTP"] as string);
            }
        }



        public int VIO_Utenti_INSERT(VIO_Utenti_CRUD_23 Utente)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[10];

            objParams[0] = new SqlParameter("@Nome", Utente.Nome);
            objParams[1] = new SqlParameter("@Cognome", Utente.Cognome);
            objParams[2] = new SqlParameter("@EmailContatto", Utente.EmailContatto);
            objParams[3] = new SqlParameter("@UtenteIntranet", Utente.UtenteIntranet);
            objParams[4] = new SqlParameter("@Tipologia", Utente.Tipologia);
            objParams[5] = new SqlParameter("@Azienda", Utente.Azienda);
            objParams[6] = new SqlParameter("@FirmaEmail", Utente.FirmaEmail);
            objParams[7] = new SqlParameter("@DataBlocco", Utente.DataBlocco);
            objParams[8] = new SqlParameter("@UtenteSMTP", Utente.UtenteSMTP);
            objParams[9] = new SqlParameter("@PasswordSMTP", Utente.PasswordSMTP);


            return objSqlHelper.ExecuteNonQuery("VIO_Utenti_Insert", objParams);
        }

        public void VIO_Utenti_Update(VIO_Utenti_CRUD_23 _obj)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[4];

            objParams[0] = new SqlParameter("@Nome", _obj.Nome);
            objParams[1] = new SqlParameter("@Cognome", _obj.Cognome);
            objParams[2] = new SqlParameter("@EmailContatto", _obj.EmailContatto);
            objParams[3] = new SqlParameter("@UtenteIntranet", _obj.UtenteIntranet);
            objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Update", objParams);
        }


        public static int VIO_Utenti_DELETE(string userName)
        {
            int result = 0;

            string sql = "DELETE FROM VIO_Utenti WHERE UtenteIntranet = @UserName";
            SqlParameter param = new SqlParameter("@UserName", userName);

            result = new Sql4Helper().ExecuteNonQuery(sql, param);
            return result;
        }


        public static string VIO_Utente_GetFirmaEMail(string userName)
        {
            string retval = string.Empty;

            string sql = "SELECT FirmaEmail FROM VIO_Utenti WHERE UtenteIntranet = @UserName";
            SqlParameter param = new SqlParameter("@UserName", userName);

            SqlDataReader reader = new Sql4Helper().ExecuteReader(sql, param);
            if (reader.Read())
            {
                retval = reader["FirmaEmail"] as string;
            }
            return retval;
        }

        public static bool CheckIfUserExists(string UserID)
        {
            bool retval = false;
            string sql = @"SELECT         VIO_Utenti.UtenteIntranet
                            FROM            aspnet_Users LEFT OUTER JOIN
                                            VIO_Utenti ON aspnet_Users.UserName = VIO_Utenti.UtenteIntranet
                            WHERE aspnet_Users.UserId = @UserID";

            SqlParameter param = new SqlParameter("@UserID", UserID);

            SqlDataReader reader = new Sql4PortalHelper().ExecuteReader(sql, param);

            if (reader.Read())
            {
                retval = !(string.IsNullOrEmpty(reader["UtenteIntranet"] as string));
            }
            return retval;
        }
    }

}