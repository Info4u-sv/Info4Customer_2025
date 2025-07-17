using DevExpress.Web;
using System;
using System.Data;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace INTRA.SuperAdmin.RulesGest
{
    public partial class users_by_role : System.Web.UI.Page
    {

        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["UserGridData"] != null)
            {
                User_Grdw.DataSource = GetStoredGridData();
                User_Grdw.DataBind();
            }
        }

        //private void Page_PreRender()
        //{
        /*
         * Dan Clem, 3/7/2007 and 4/27/2007.
         * The logic here is necessitated by the limitations of the built-in object model.
         * The Membership class does not provide a method to get users by role.
         * The Roles class DOES provide a GetUsersInRole method, but it returns an array of UserName strings
         * rather than a proper collection of MembershipUser objects.
         * 
         * This is my workaround.
         * 
         * Note to self: the two-collection approach is necessitated because you can't remove items from a collection
         * while iterating through it: "Collection was modified; enumeration operation may not execute."
         */

        //MembershipUserCollection allUsers = Membership.GetAllUsers();
        //MembershipUserCollection filteredUsers = new MembershipUserCollection();

        //if (UserRoles.SelectedIndex > 0)
        //{
        //    string[] usersInRole = Roles.GetUsersInRole(UserRoles.SelectedValue);
        //    foreach (MembershipUser user in allUsers)
        //    {
        //        foreach (string userInRole in usersInRole)
        //        {
        //            if (userInRole == user.UserName)
        //            {
        //                filteredUsers.Add(user);
        //                break; // Breaks out of the inner foreach loop to avoid unneeded checking.
        //            }
        //        }
        //    }
        //}
        //else
        //{              
        //    filteredUsers = allUsers;
        // }
        //    User_Grdw.DataSource = DatagridLoad("Show All");
        //    User_Grdw.DataBind();

        //}

        protected void EditButton_Click(object sender, EventArgs e)
        {
            ASPxButton button = sender as ASPxButton;
            int visibleIndex = (button.Parent as GridViewDataItemTemplateContainer).VisibleIndex;
            string username = User_Grdw.GetRowValues(visibleIndex, User_Grdw.KeyFieldName).ToString();
            string userId = Membership.GetUser(username).ProviderUserKey.ToString();

            Response.Redirect($"../UserGest/edit_user_tm.aspx?userId={userId}");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserRoles.DataSource = Roles.GetAllRoles();
                UserRoles.DataBind();


                if (!UserRoles.Items.Cast<ListItem>().Any(i => i.Value == "Show All"))
                    UserRoles.Items.Insert(0, new ListItem("Show All", "Show All"));

                var dt = DatagridLoad("Show All");
                Session["UserGridData"] = dt;
                User_Grdw.DataSource = dt;
                User_Grdw.DataBind();
            }

        }
        protected void User_Grdw_DataBinding(object sender, EventArgs e)
        {
            User_Grdw.DataSource = GetStoredGridData();
        }
        protected void UserRoles_SelectedIndexChanged(object sender, EventArgs e)
        {
            User_Grdw.PageIndex = 0;
            string selectedRole = UserRoles.SelectedValue;
            User_Grdw.DataSource = DatagridLoad(selectedRole);
            User_Grdw.DataBind();
        }
        protected void User_Grdw_PageIndexChanged(object sender, EventArgs e)
        {
            User_Grdw.DataSource = GetStoredGridData();
            User_Grdw.DataBind();
        }

        //protected void EditCallback_Callback(object source, CallbackEventArgs e)
        //{
        //    string username = e.Parameter.ToString();
        //    string UserId = Membership.GetUser(username).ProviderUserKey.ToString();
        //    string url = "../UserGest/edit_user_tm.aspx?userId=" + UserId;
        //    ASPxWebControl.RedirectOnCallback(url);
        //ASPxWebControl.RedirectOnCallback("javascript:window.open('" + url + "', '_blank');");
        //}
        //aggiunto metodo per la call back

        protected void GridCallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string selectedRole = e.Parameter;
            var dt = DatagridLoad(selectedRole); 
            Session["UserGridData"] = dt;         
            User_Grdw.DataSource = dt;
            User_Grdw.DataBind();
        }
        protected void User_Grdw_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            User_Grdw.DataSource = GetStoredGridData();
            User_Grdw.DataBind();
        }
        private DataTable DatagridLoad(string selectedRole)
        {
            var dt = new DataTable();

            // Definisci colonne
            dt.Columns.Add("UserName");
            dt.Columns.Add("Email");
            dt.Columns.Add("Comment");
            dt.Columns.Add("CreationDate");
            dt.Columns.Add("LastLoginDate");
            dt.Columns.Add("LastActivityDate");
            dt.Columns.Add("IsApproved");
            dt.Columns.Add("IsOnline");
            dt.Columns.Add("IsLockedOut");
            dt.Columns.Add("UserId");

            var allUsers = Membership.GetAllUsers();

            if (!string.IsNullOrEmpty(selectedRole) && selectedRole != "Show All")
            {
                var usersInRole = Roles.GetUsersInRole(selectedRole);

                foreach (MembershipUser user in allUsers)
                {
                    if (usersInRole.Contains(user.UserName))
                    {
                        dt.Rows.Add(
                            user.UserName,
                            user.Email,
                            user.Comment,
                            user.CreationDate.ToString(),
                            user.LastLoginDate.ToString(),
                            user.LastActivityDate.ToString(),
                            user.IsApproved.ToString(),
                            user.IsOnline.ToString(),
                            user.IsLockedOut.ToString(),
                            user.ProviderUserKey.ToString());
                    }
                }
            }
            else
            {
                foreach (MembershipUser user in allUsers)
                {
                    dt.Rows.Add(
                        user.UserName,
                        user.Email,
                        user.Comment,
                        user.CreationDate.ToString(),
                        user.LastLoginDate.ToString(),
                        user.LastActivityDate.ToString(),
                        user.IsApproved.ToString(),
                        user.IsOnline.ToString(),
                        user.IsLockedOut.ToString(),
                        user.ProviderUserKey.ToString());
                }
            }
            Session["UserGridData"] = dt;
            return dt;
        }
        private DataTable GetStoredGridData()
        {
            return Session["UserGridData"] as DataTable ?? DatagridLoad("Show All");
        }

    }
}