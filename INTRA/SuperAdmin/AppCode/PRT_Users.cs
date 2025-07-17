using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace INTRA.SuperAdmin.AppCode
{
    public class PRT_Users
    {

        public static MembershipUser GetUserById(string UserId)
        {
            string SqlString = "Select [UserName]  FROM [dbo].[aspnet_Users] where UserId ='" + UserId + "'";

            string UserName = string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    retVal = false;
                }

                else
                {
                    while (myReader.Read())
                    {
                        UserName = myReader["UserName"].ToString();
                    }

                }
                myReader.Close();
                myConnection.Close();
                MembershipUser UserById = Membership.GetUser(UserName);
                return UserById;
            }

        }

        public bool CheckEmail(string Email)
        {
            string SqlString = "Select [Email]  FROM [dbo].[aspnet_Membership] where Email ='" + Email + "'";

            bool Esiste = false;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    retVal = false;
                }

                else
                {
                    while (myReader.Read())
                    {
                        Esiste = true;
                    }

                }
                myReader.Close();
                myConnection.Close();

                return Esiste;
            }
        }

    }
}