using INTRA.AppCode;
using INTRA.SuperAdmin.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;

namespace INTRA
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(tbUserName.Text, tbPassword.Text))
            {
                PRT_Parameter.SetPathAssolutoIntranet();
                FormsAuthentication.SetAuthCookie(tbUserName.Text, false);

                string CodCli = tbUserName.Text.Split('-')[0];
                Session["CodCliLog"] = CodCli;
                string CodDep = null;
                string denom = null;
                Guid? u_token = null;
                DateTime? dataCens = null;

                string connectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                string query = @"
            SELECT TabDep.CodDep, Clienti.Denom, TabDep.U_Token, TabDep.U_UltimoControllo_Inventario
            FROM TabDep
            INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli
            WHERE TabDep.CodCli = @CodCli";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CodCli", CodCli);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                CodDep = reader["CodDep"]?.ToString();
                                denom = reader["Denom"] as string;

                                if (reader["U_Token"] != DBNull.Value)
                                    u_token = reader.GetGuid(reader.GetOrdinal("U_Token"));

                                if (reader["U_UltimoControllo_Inventario"] != DBNull.Value)
                                    dataCens = Convert.ToDateTime(reader["U_UltimoControllo_Inventario"]);
                            }
                        }
                    }
                }

                // Rimuove cookie esistenti
                DeleteCookie("CodDep");
                DeleteCookie("Dep_Denom");
                DeleteCookie("U_Token");
                DeleteCookie("Action_Giornata");
                DeleteCookie("DataCensimento");

                // Scrive nuovi cookie
                if (!string.IsNullOrEmpty(CodDep))
                {
                    SetCookie("CodDep", "CodDep", CodDep);
                    SetCookie("Dep_Denom", "Dep_Denom", denom);
                    SetCookie("U_Token", "U_Token", u_token.HasValue ? u_token.ToString() : null);
                    SetCookie("Action_Giornata", "Action_Giornata", null);

                    if (dataCens.HasValue)
                    {
                        SetCookie("DataCensimento", "DataCensimento", dataCens.Value.Date.ToString("yyyy-MM-dd"));
                    }
                }

                // Determina la pagina di default
                string Username = tbUserName.Text;
                string DefaultPage = (Roles.IsUserInRole(Username, "ClienteAdmin") || Roles.IsUserInRole(Username, "Cliente"))
                    ? "/ShopRM/Default.aspx"
                    : PRT_DefaultPage_SA.GetIntraDefaultPageByUser(Username);

                // Pulisce la cache
                var cache = HttpRuntime.Cache;
                foreach (System.Collections.DictionaryEntry cacheEntry in cache)
                {
                    cache.Remove(cacheEntry.Key.ToString());
                }

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
                Response.Cache.SetNoStore();
                Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);

                Response.Redirect(DefaultPage);
            }
            else
            {
                tbUserName.ErrorText = "Invalid user";
                tbUserName.IsValid = false;
            }
        }

        private void DeleteCookie(string name)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[name];
            if (cookie != null)
            {
                cookie.Expires = DateTime.Now.AddDays(-1);
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
        }

        private void SetCookie(string cookieName, string key, string value)
        {
            HttpCookie cookie = new HttpCookie(cookieName);
            cookie.Values.Add(key, value);
            cookie.Expires = DateTime.MaxValue;
            HttpContext.Current.Response.Cookies.Add(cookie);
        }

    }
}