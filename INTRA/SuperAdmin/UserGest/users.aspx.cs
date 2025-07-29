using DevExpress.Web;
using Info4U.Models;
using INTRA.AppCode;
using System;
using System.Data.SqlClient;
using System.Web.Security;

namespace INTRA.SuperAdmin.UserGest
{
    public partial class users : System.Web.UI.Page
    {
        public int OnlineCount
        {
            get
            {
                if (Session["OnlineCount"] == null)
                {
                    var Users = Membership.GetAllUsers();
                    int counter = 0;
                    foreach (MembershipUser User in Users)
                    {
                        if (User.IsOnline)
                        {
                            counter++;
                        }
                    }
                    Session["OnlineCount"] = counter;
                }
                return (int)Session["OnlineCount"];
            }

        }
        public int LockedCount
        {
            get
            {
                if (Session["LockedCount"] == null)
                {
                    var Users = Membership.GetAllUsers();
                    int counter = 0;
                    foreach (MembershipUser User in Users)
                    {
                        if (User.IsLockedOut)
                        {
                            counter++;
                        }
                    }
                    Session["LockedCount"] = counter;
                }
                return (int)Session["LockedCount"];
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                User_Grdw.DataSource = Membership.GetAllUsers();
                User_Grdw.DataBind();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            User_Grdw.DataSource = Membership.GetAllUsers();
            User_Grdw.DataBind();
        }

        protected void EditButton_Click(object sender, EventArgs e)
        {
            ASPxButton button = sender as ASPxButton;
            int visibleIndex = (button.Parent as GridViewDataItemTemplateContainer).VisibleIndex;
            string username = User_Grdw.GetRowValues(visibleIndex, User_Grdw.KeyFieldName).ToString();
            string UserId = Membership.GetUser(username).ProviderUserKey.ToString();
            Response.Redirect("edit_user_tm.aspx?userId=" + UserId);
        }

        protected void AddUtente_Click(object sender, EventArgs e)
        {
            Response.Redirect("add_user.aspx");
        }

        protected void EditCallback_Callback(object source, CallbackEventArgs e)
        {
            string username = e.Parameter.ToString();
            string UserId = Membership.GetUser(username).ProviderUserKey.ToString();
            string url = "/SuperAdmin/UserGest/edit_user_tm.aspx?userId=" + UserId;
            ASPxWebControl.RedirectOnCallback(url);
        }

        protected void Reset_Callback_Callback(object source, CallbackEventArgs e)
        {
            string username = e.Parameter;
            string ruolo = Ruolo_cb.Text;
            INTRA.AppCode.Sql4Helper objSqlHelper = new INTRA.AppCode.Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@Rules_id_fk", ruolo);
            objParams[1] = new SqlParameter("@UserName", username);
            objSqlHelper.ExecuteNonQueryForNews("PRT_Privilege_Reset_Users", objParams);
        }
        protected void User_Grdw_CustomButtonInitialize(object sender, ASPxGridViewCustomButtonEventArgs e)
        {
            if (e.VisibleIndex > -1)
            {
                bool Scaduto = Convert.ToBoolean(User_Grdw.GetRowValues(e.VisibleIndex, "IsLockedOut"));
                if (Scaduto)
                {
                    if (e.ButtonID == "Sospendi")
                    {
                        e.Visible = DevExpress.Utils.DefaultBoolean.False;
                    }


                }
                else
                {
                    if (e.ButtonID == "Riattiva")
                    {
                        e.Visible = DevExpress.Utils.DefaultBoolean.False;
                    }
                }
            }
        }
        protected void User_Grdw_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] parts = e.Parameters.Split('|');
            if (parts.Length == 2 && parts[0] == "Sospendi")
            {
                int visibleIndex = int.Parse(parts[1]);
                User_Grdw_CustomButtonCallback(sender, new ASPxGridViewCustomButtonCallbackEventArgs("Sospendi", visibleIndex));
            }
            if (parts.Length == 2 && parts[0] == "Riattiva")
            {
                int visibleIndex = int.Parse(parts[1]);
                User_Grdw_CustomButtonCallback(sender, new ASPxGridViewCustomButtonCallbackEventArgs("Riattiva", visibleIndex));
            }
        }
        protected void User_Grdw_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            string username = User_Grdw.GetRowValues(e.VisibleIndex, "UserName")?.ToString();

            if (!string.IsNullOrEmpty(username))
            {
                MembershipUser user = Membership.GetUser(username);
                Guid userId = (Guid)user.ProviderUserKey;

                string query = string.Empty;
                switch (e.ButtonID)
                {
                    case "Riattiva":
                        query = @"UPDATE aspnet_Membership 
              SET IsLockedOut = 0
              WHERE UserId = @UserId";
                        break;

                    case "Sospendi":
                        query = @"UPDATE aspnet_Membership 
                          SET IsLockedOut = 1, LastLockoutDate = GETDATE() 
                          WHERE UserId = @UserId";
                        break;

                    case "Password":
                        Session["UsernameModPsw"] = username;
                        User_Grdw.JSProperties["cpCambiaPassword"] = 1;
                        return;
                }

                if (!string.IsNullOrEmpty(query))
                {
                    using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }

                    User_Grdw.JSProperties["cpCambiaPassword"] = 0;
                    User_Grdw.JSProperties["cpRefreshGrid"] = true;
                }
            }

            User_Grdw.DataBind();
        }



    }
}