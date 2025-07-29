using DevExpress.Web;
using System;
using System.Data;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace INTRA.SuperAdmin.RulesGest
{


    public partial class Role : System.Web.UI.Page
    {

        private bool createRoleSuccess = true;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void cpRolePanel_Callback(object sender, CallbackEventArgsBase e)
        {
            if (e.Parameter == "add")
            {
                string roleName = NewRole.Text.Trim();
                if (!string.IsNullOrEmpty(roleName) && !Roles.RoleExists(roleName))
                {
                    Roles.CreateRole(roleName);
                    ControlRolePrivileges(roleName);
                    cpRolePanel.JSProperties["cp_showNotification"] = true;
                }
            }

            Generic_Gridview.DataBind();
        }

        protected void Generic_Gridview_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            string roleName = e.Values["RoleName"].ToString();

            try
            {
                // cancello il ruolo e tutti i riferimenti
                Roles.DeleteRole(roleName, throwOnPopulatedRole: false);            }
            catch (Exception ex)
            {
            }

            e.Cancel = true;
            Generic_Gridview.CancelEdit();
            Generic_Gridview.DataBind();
        }
        protected void Generic_Gridview_CustomButtonInitialize(object sender, DevExpress.Web.ASPxGridViewCustomButtonEventArgs e)
        {
            if (e.ButtonID == "DeleteConfirmButton")
            {
                if (e.VisibleIndex < 0) // Rimuovo anche dalla riga filtro/header
                {
                    e.Visible = DevExpress.Utils.DefaultBoolean.False;
                    return;
                }

                int userCount = Convert.ToInt32(Generic_Gridview.GetRowValues(e.VisibleIndex, "NumeroUtenti"));

                e.Visible = (userCount > 0)
                    ? DevExpress.Utils.DefaultBoolean.False
                    : DevExpress.Utils.DefaultBoolean.True;
            }
        }
        private void ControlRolePrivileges(string roleName)
        {
            try
            {
                string query = @"
                    SELECT MenuId, Title, Description,
                           CAST('False' AS bit) AS add_permission,
                           CAST('False' AS bit) AS delete_permission,
                           CAST('False' AS bit) AS modify_permission,
                           CAST('False' AS bit) AS read_permission
                    FROM PRT_Menus
                    ORDER BY MenuId ASC";

                DataSet ds = DataControl.GetDataSet(query);
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    int formId = Convert.ToInt32(row["MenuId"]);
                    bool isAdd = false, isDelete = false, isModify = false, isRead = false;

                    string sql = $"EXEC PRT_Privilege_Rules_addRolePrivileges '{formId}', '{roleName}', '{isAdd}', '{isDelete}', '{isModify}', '{isRead}'";
                    DataControl.ExecuteNonQuery(sql);
                }
            }
            catch (Exception ex)
            {
                string logPath = Server.MapPath("~/Error_LogFile/LogFile");
                var log = new LogFile();
                var user = Membership.GetUser();
                log.ErrorLog(logPath, $"Errore: - {user?.UserName} - {ex}");
            }
        }

    }
}