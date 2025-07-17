using System;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class ClientiCat_Crud
    {
        public string CodCli { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public string NomeCompleto { get; set; }
        public string Ind { get; set; }
        public string Prov { get; set; }
        public string Loc { get; set; }
        public string Tel { get; set; }
        public string CF { get; set; }
        public string EMail { get; set; }
        public string Cap { get; set; }
        public static void ClienteCat_Insert(ClientiCat_Crud NuovoCliente)
        {

            string Sql_Txt = @" INSERT INTO [dbo].[Clienti]
            ([CodCli] ,[Nome] ,[Cognome] ,[Ind] ,[Prov] ,[Loc] ,[Tel]  ,[CF]  ,[EMail] ,[Cap] )
     VALUES (@CodCli  ,@Nome  ,@Cognome  ,@Ind  ,@Prov  ,@Loc  ,@Tel   ,@CF ,@EMail ,@Cap)";
            using (SqlConnection sqlconnection = new SqlConnection())
            {
                sqlconnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                sqlconnection.Open();
                using (SqlCommand sqlCommand = new SqlCommand(Sql_Txt, sqlconnection))
                {
                    _ = sqlCommand.Parameters.AddWithValue("CodCli", NuovoCliente.CodCli);
                    _ = sqlCommand.Parameters.AddWithValue("Nome", NuovoCliente.Nome);

                    _ = sqlCommand.Parameters.AddWithValue("Cognome", NuovoCliente.Cognome);
                    _ = sqlCommand.Parameters.AddWithValue("ind", NuovoCliente.Ind);

                    _ = sqlCommand.Parameters.AddWithValue("Prov", NuovoCliente.Prov);
                    _ = sqlCommand.Parameters.AddWithValue("Loc", NuovoCliente.Loc);

                    _ = sqlCommand.Parameters.AddWithValue("Tel", NuovoCliente.Tel);
                    _ = sqlCommand.Parameters.AddWithValue("CF", NuovoCliente.CF);

                    _ = sqlCommand.Parameters.AddWithValue("EMail", NuovoCliente.EMail);
                    _ = sqlCommand.Parameters.AddWithValue("Cap", NuovoCliente.Cap);
                    _ = sqlCommand.ExecuteNonQuery();
                }
                sqlconnection.Close();
            }

        }

        public static ClientiCat_Crud GetClienteDataForEmail(string Username)
        {
            ClientiCat_Crud retval = new ClientiCat_Crud();
            string sql = $"SELECT Clienti.Cognome + ' ' + Clienti.Nome AS Cliente, Clienti.Tel, VIO_Utenti.EmailContatto FROM VIO_Utenti INNER JOIN  Clienti ON VIO_Utenti.CodCli = Clienti.CodCli WHERE (VIO_Utenti.UtenteIntranet = '{Username}')";
            SqlDataReader reader = new Sql4Helper().ExecuteReader(sql);

            try
            {
                _ = reader.Read();

                retval.NomeCompleto = reader["Cliente"].ToString();
                retval.Tel = reader["Tel"].ToString();
                retval.EMail = reader["EmailContatto"].ToString();
            }
            catch (Exception ex)
            {
                PRT_ErrorGest_23.ErrorLogSave(ex.Message);
            }

            return retval;
        }

        public static ClientiCat_Crud GetClientDatiSpedizione(string CodCli)
        {
            ClientiCat_Crud retval = new ClientiCat_Crud();
            string sql = $"SELECT Cognome + ' ' + Nome AS NomeCompleto,Ind,Cap,Prov,Loc FROM Clienti WHERE (CodCli = '{CodCli}')";

            SqlDataReader reader = new Sql4Helper().ExecuteReader(sql);
            try
            {
                _ = reader.Read();
                retval.NomeCompleto = reader["NomeCompleto"] as string;
                retval.Ind = reader["Ind"] as string;
                retval.Cap = reader["Cap"] as string;
                retval.Prov = reader["Prov"] as string;
                retval.Loc = reader["Loc"] as string;
            }
            catch (Exception ex)
            {
                PRT_ErrorGest_23.ErrorLogSave(ex.Message);
            }
            return retval;
        }

        public static string GetEmailCliente(string CodCli)
        {
            string retval = string.Empty;
            string sql = $"SELECT EmailContatto FROM VIO_Utenti WHERE UtenteIntranet = '{CodCli}'";

            try
            {
                SqlDataReader reader = new Sql4Helper().ExecuteReader(sql);
                _ = reader.Read();

                retval = reader["EmailContatto"].ToString();
            }
            catch
            {

            }
            return retval;
        }

        public static int UpdateEmailCliente(string Username, string Email)
        {
            string sql = $"UPDATE Clienti SET EMail = '{Email}' WHERE (CodCli = '{Username}')";

            return new Sql4Helper().ExecuteNonQuery(sql);
        }

        public static int CLienteCat_Update(ClientiCat_Crud Cliente)
        {
            string SqlUpdate = @"UPDATE Clienti 
                                SET Nome = @Nome, 
                                    Cognome = @Cognome,
                                    Ind = @Ind, 
                                    Prov = @Prov,
                                    Cap = @Cap,
                                    Loc = @Loc, 
                                    Tel = @Tel,
                                    EMail = @EMail,
                                    CF = @CF
                                WHERE (CodCli = @CodCli)
                                ";
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@Nome",Cliente.Nome),
                new SqlParameter("@Cognome",Cliente.Cognome),
                new SqlParameter("@Ind",Cliente.Ind),
                new SqlParameter("@Prov",Cliente.Prov),
                new SqlParameter("@Cap",Cliente.Cap),
                new SqlParameter("@Loc",Cliente.Loc),
                new SqlParameter("@Tel",Cliente.Tel),
                new SqlParameter("@EMail",Cliente.EMail),
                new SqlParameter("@CF", Cliente.CF),
                new SqlParameter("@CodCli",Cliente.CodCli)
            };

            int result = new Sql4Helper().ExecuteNonQuery(SqlUpdate, parameters);

            return result;
        }
    }
}