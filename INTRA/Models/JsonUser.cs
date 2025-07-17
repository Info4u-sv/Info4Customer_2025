

using System;
using System.Data.SqlClient;
using System.Web;

namespace Info4U.Models
{
    public class JsonUser
    {
        public int id { get; set; }

        public string code { get; set; }

        public string name { get; set; }

        public int status { get; set; }

        public int user_type { get; set; }
        public string avatar_image { get; set; }
        public string signature_image { get; set; }


        public static JsonUser getUser(
      SqlConnection sqlconnection,
      HttpContext context,
      string userName,
      string password,
      out bool islocked)
        {
            // restituisce i dati del tecnico 
            JsonUser jsonUser = null;
            islocked = false;
            if (WebUtils.ValidateUser(userName, password))
            {
                using (SqlCommand sqlCommand = new SqlCommand("\r\n            SELECT ID, CodTec, [Nome] , [VersioneAvatar], UserNameProfileIntra , U_App, [UrlFirma] , [VersioneFirma], UrlAvatar, User_Type \r\n            FROM PRT_DipendentiAna \r\n            WHERE UserNameProfileIntra = @userName", sqlconnection))
                {
                    sqlCommand.Parameters.AddWithValue(nameof(userName), (object)userName);
                    //sqlCommand.Parameters.AddWithValue(nameof(password), (object)password);
                    using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
                    {
                        if (sqlDataReader.Read())
                        {
                            string urlRoot = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority); //returns "http://www.foobar.com"
                            jsonUser = new JsonUser();
                            jsonUser.id = Convert.ToInt32(sqlDataReader["ID"]);
                            jsonUser.code = sqlDataReader["CodTec"].ToString();
                            jsonUser.name = sqlDataReader["Nome"].ToString();
                            jsonUser.status = Convert.ToInt32(sqlDataReader["U_App"]);
                            string signature_image = urlRoot + sqlDataReader["UrlFirma"].ToString() + "?version=" + sqlDataReader["VersioneFirma"].ToString();
                            string avatar_image = urlRoot + sqlDataReader["UrlAvatar"].ToString() + "?version=" + sqlDataReader["VersioneAvatar"].ToString();
                            jsonUser.avatar_image = avatar_image;
                            jsonUser.signature_image = signature_image;
                            jsonUser.user_type = Convert.ToInt32(sqlDataReader["User_Type"]); //-> 0=master, 1=slave (come per il login)
                            islocked = jsonUser.status != 1;
                        }
                    }
                }
            }
            return jsonUser;
        }
    }

}
