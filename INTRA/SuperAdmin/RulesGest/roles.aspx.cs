using System;
using System.Data;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace IntranetTemplate2017.SuperAdmin.RulesGest
{


    public partial class Role : System.Web.UI.Page
    {

        private bool createRoleSuccess = true;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void Page_PreRender()
        {
            DataTable RoleList = new DataTable();
            RoleList.Columns.Add("Role Name");
            RoleList.Columns.Add("User Count");
            string[] allRoles = Roles.GetAllRoles();
            foreach (string roleName in allRoles)
            {
                int numberOfUsersInRole = Roles.GetUsersInRole(roleName).Length;
                string[] roleRow = { roleName, numberOfUsersInRole.ToString() };
                RoleList.Rows.Add(roleRow);
            }
            UserRoles.DataSource = RoleList;
            UserRoles.DataBind();

            if (createRoleSuccess)
            {
                NewRole.Text = string.Empty;
            }
        }

        public void AddRole(object sender, EventArgs e)
        {
            try
            {
                Roles.CreateRole(NewRole.Text);
                ControlRolePrivileges();
                ConfirmationMessage.InnerText = "The new role was added.";
                createRoleSuccess = true;
            }
            catch (Exception ex)
            {
                ConfirmationMessage.InnerText = ex.Message;
                createRoleSuccess = false;
            }
        }

        public void DeleteRole(object sender, CommandEventArgs e)
        {
            try
            {
                Roles.DeleteRole(e.CommandArgument.ToString());
                ConfirmationMessage.InnerText = "Role '" + e.CommandArgument.ToString() + "' was deleted.";
            }
            catch (Exception ex)
            {
                ConfirmationMessage.InnerText = ex.Message;
            }
        }

        protected void DisableRoleManager(object sender, EventArgs e)
        {
        }

        private void ControlRolePrivileges()
        {
            try
            {
                string strQuery = string.Empty;

                strQuery = "SELECT [MenuId],";
                strQuery += " [Title] ,";
                strQuery += " [Description],";
                strQuery += " CAST('False' AS bit) AS add_permission,";
                strQuery += " CAST('False' AS bit) AS delete_permission,";
                strQuery += " CAST('False' AS bit) AS modify_permission,";
                strQuery += " CAST('False' AS bit) AS read_permission";
                strQuery += " FROM [PRT_Menus] ORDER BY [MenuId] ASC";
                DataSet ds = DataControl.GetDataSet(strQuery);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        int intFormId = int.Parse(ds.Tables[0].Rows[i]["MenuId"].ToString());
                        bool isAdd = false, isDelete = false, isModify = false, isRead = false;

                        // Label lblFormName = (Label)grdPrivileges.Rows[i].FindControl("lblDisplayFormName");               

                        if (string.IsNullOrEmpty(ds.Tables[0].Rows[i]["add_permission"].ToString())) isAdd = false;
                        if (string.IsNullOrEmpty(ds.Tables[0].Rows[i]["delete_permission"].ToString())) isDelete = false;
                        if (string.IsNullOrEmpty(ds.Tables[0].Rows[i]["modify_permission"].ToString())) isModify = false;
                        if (string.IsNullOrEmpty(ds.Tables[0].Rows[i]["read_permission"].ToString())) isRead = false;

                        string strSQLQuery = String.Empty;

                        strSQLQuery = "EXEC PRT_Privilege_Rules_addRolePrivileges";
                        strSQLQuery += " '" + intFormId + "',";
                        strSQLQuery += " '" + NewRole.Text + "',";
                        strSQLQuery += " '" + isAdd + "',";
                        strSQLQuery += " '" + isDelete + "',";
                        strSQLQuery += " '" + isModify + "',";
                        strSQLQuery += " '" + isRead + "'";


                    }
                }
            }

            catch (Exception ex)
            {
                string PathIntranetAssoluto = Server.MapPath("~/").ToString();
                LogFile Errore = new LogFile();
                System.Web.Security.MembershipUser edtUsr = Membership.GetUser();
                Errore.ErrorLog(PathIntranetAssoluto + "\\Error_LogFile\\LogFile", "Errore: " + "  -  " + edtUsr.UserName + "  -  " + ex);

            }
        }
    }
}