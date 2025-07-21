using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class Utenti_CRUD_Class
    {

        public string NomeUtente { get; set; }
        public string Email { get; set; }
        public string Tipologia { get; set; }
        public string Azienda { get; set; }
        public string CodCli { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }

        public int InsertUtente(Utenti_CRUD_Class settings)
        {
            Sql4Helper helper = new Sql4Helper();
            SqlParameter[] parameters = new SqlParameter[7];
            parameters[0] = new SqlParameter("@UtenteIntranet", settings.NomeUtente);
            parameters[1] = new SqlParameter("@EmailContatto", settings.Email);
            parameters[2] = new SqlParameter("@Tipologia", settings.Tipologia);
            parameters[3] = new SqlParameter("@Azienda", settings.Azienda);
            parameters[4] = new SqlParameter("@CodCli", settings.CodCli);
            parameters[5] = new SqlParameter("@Nome", settings.Nome);
            parameters[6] = new SqlParameter("@Cognome", settings.Cognome);

            return helper.ExecuteNonQuery("VIO_Utenti_Insert", parameters);
        }

        public string GetCodLisForCli(string CodCli)
        {
            string retval = "";
            Sql4Helper helper = new Sql4Helper();
            string sql = $"select distinct top 1 CodLis from Clienti where CodCli = '{CodCli}'";
            SqlDataReader reader = helper.ExecuteReader(sql);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    retval = reader["CodLis"].ToString();
                }
            }
            return retval;
        }
        public int ContaUtentiPerCodCli(string codCli)
        {
            int count = 0;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                string query = "SELECT COUNT(*) FROM [TEMPLATE_25_INTRA].[dbo].[VIO_Utenti] WHERE CodCli = @CodCli";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CodCli", codCli);
                conn.Open();
                count = (int)cmd.ExecuteScalar();
            }
            return count;
        }
    }
}