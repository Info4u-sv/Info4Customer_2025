using info4lab;
using INTRA.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace INTRA.SuperAdmin.AppCode
{
    public class PRT_DefaultPage_SA
    {
        public static string GetIntraDefaultPageByUser(string Username)
        {

            // la funzione cotrolla a quale ruolo appartiene l'utente e se è stata impostata una pagina di default a livello di utente
            // in questo secondo caso la pagina vince su tutto
            string ReturnUrl = null;

            string xmlfile = HttpContext.Current.Server.MapPath(@"~\App_Data\VersioneIntranet_2023_Tbl.xml");
            var doc = XDocument.Load(xmlfile);
            string suffisso = FunzioniGenerali.NormalizzaDocImport(doc.Descendants("RagSoc").Last().ToString()).Replace("_", string.Empty);
            string cookieName = "4uCookie" + suffisso + Username.ToLower();
            // Check if cookie exists in the current request.
            HttpCookie Intra4uDefVal = HttpContext.Current.Request.Cookies[cookieName];
            if (Intra4uDefVal == null)
            {
                ReturnUrl = GetUserDefaultPageByDb(Username);
                CreateCookieDefaultPage(cookieName, ReturnUrl);
            }
            else
            {
                string DefaultPage = PRT_Cookie_Crud.GetFromCookie(cookieName, "DefaultPage");
                if (DefaultPage != null)
                {

                    ReturnUrl = DefaultPage;
                }
                else
                {
                    ReturnUrl = GetUserDefaultPageByDb(Username);
                    CreateCookieDefaultPage(cookieName, DefaultPage);
                }


            }
            return ReturnUrl;
        }
        private static string GetDbUserDefaultPage(string Username)

        {
            string ReturnUrl = null;
            string SqlString = "SELECT PageDefault FROM [aspnet_Users] where LoweredUserName = '{0}'";
            SqlString = string.Format(SqlString, Username.ToLower());
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {

                        ReturnUrl = myReader["PageDefault"].ToString();


                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ReturnUrl;

        }

        private static string GetDbUserRolesDefaultPage(string Username)

        {
            string ReturnUrl = null;
            string SqlString = @"SELECT  aspnet_Users.LoweredUserName, aspnet_Roles.PageDefault FROM aspnet_Roles INNER JOIN 
                                aspnet_UsersInRoles ON aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId AND 
                                aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId AND aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId 
                                AND  aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId AND aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId 
                                AND aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId AND   aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId 
                                AND aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId INNER JOIN    aspnet_Users ON aspnet_UsersInRoles.UserId = aspnet_Users.UserId 
                                AND aspnet_UsersInRoles.UserId = aspnet_Users.UserId AND aspnet_UsersInRoles.UserId = aspnet_Users.UserId 
                                AND  aspnet_UsersInRoles.UserId = aspnet_Users.UserId AND aspnet_UsersInRoles.UserId = aspnet_Users.UserId 
                                AND aspnet_UsersInRoles.UserId = aspnet_Users.UserId AND   aspnet_UsersInRoles.UserId = aspnet_Users.UserId 
                                AND aspnet_UsersInRoles.UserId = aspnet_Users.UserId 
                                WHERE (LoweredUserName = '{0}') AND (aspnet_Roles.PageDefault <> 'ND') 
                                AND (NOT (aspnet_Roles.PageDefault IS NULL))";
            SqlString = string.Format(SqlString, Username.ToLower());
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {

                        ReturnUrl = myReader["PageDefault"].ToString();


                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ReturnUrl;

        }
        private static void CreateCookieDefaultPage(string cookieName, string DefaultPage)
        {

            //string cookieName = "Intra4uDefVal" + Username.ToLower();
            DateTime now = DateTime.Now;
            HttpCookie myCookie = new HttpCookie(cookieName);
            myCookie.Values.Set("DefaultPage", DefaultPage);
            myCookie.Expires = now.AddDays(1);
            HttpContext.Current.Response.Cookies.Add(myCookie);

        }

        private static string GetUserDefaultPageByDb(string Username)
        {
            string ReturnUrl = null;

            ReturnUrl = GetDbUserDefaultPage(Username);
            if (ReturnUrl == "ND" || ReturnUrl == null)
            {
                //richiamo la funzione di ricerca pagina default per ruolo
                // e lo assegno alla variabile ReturnUrl
                ReturnUrl = GetDbUserRolesDefaultPage(Username);

                if (ReturnUrl == "ND" || ReturnUrl == null)
                {
                    ReturnUrl = "/Default.aspx";
                }
            }
            return ReturnUrl;
        }
    }
}
