using DevExpress.Web;
using Info4U.Models;
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
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@Rules_id_fk", ruolo);
            objParams[1] = new SqlParameter("@UserName", username);
            objSqlHelper.ExecuteNonQueryForNews("PRT_Privilege_Reset_Users", objParams);
        }
    }
}