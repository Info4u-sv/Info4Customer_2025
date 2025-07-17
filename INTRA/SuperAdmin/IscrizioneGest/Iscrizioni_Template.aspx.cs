using INTRA.SuperAdmin.AppCode;
using System;
using System.Data;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.SuperAdmin.IscrizioneGest
{
    public partial class Iscrizioni_Template : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void getUserPrivileges()
        {
            try
            {
                string strQuery = "EXEC PRT_Privilege_Rules_getRolePrivileges '" + RmTipoIscrizAtleta_Combobox.SelectedItem.Value.ToString() + "'";
                DataSet ds = DataControl.GetDataSet(strQuery);
                if (ds.Tables[0].Rows.Count > 0)
                {
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
        private void GetUserDetails()
        {
            try
            {
                string strQuery = string.Empty;
                //bool isAccessPermission = false;
                //cbUserStatus.Enabled = true;
                var user = Membership.GetUser(Request.QueryString["username"]);
                if (Request.QueryString["uid"] != null)
                {

                }
                else
                {
                    Session["userType"] = "Admin"; // forzo per testare
                    if (Session["userType"].ToString().Equals("User"))
                    {
                        Response.Redirect(ResolveUrl("~/Exception/accessDenied.aspx"), true);
                    }
                    else
                    {

                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "User Type", "<script type='text/javascript'>changeUserType('0');</script>", false);

                        strQuery = "SELECT [MenuId] , ";
                        strQuery += " Replicate('&nbsp;', Level *4)+ Replicate('|', Level ) + Replicate('_', Level * 4)+[Title] as Title,";
                        strQuery += " [Description] ,";
                        strQuery += " CAST('False' AS bit) AS add_permission,";
                        strQuery += " CAST('False' AS bit) AS delete_permission,";
                        strQuery += " CAST('False' AS bit) AS modify_permission,";
                        strQuery += " CAST('False' AS bit) AS read_permission";
                        strQuery += " FROM [PRT_Menus] ORDER BY [MenuId] ASC";

                    }
                }
                DataSet ds = DataControl.GetDataSet(strQuery);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    grdPrivileges.DataSource = ds;
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
        private void UpdatePermessi()
        {
            try
            {
                for (int i = 0; i < grdPrivileges.Rows.Count; i++)
                {
                    //int intFormId = int.Parse(((HiddenField)grdPrivileges.Rows[i].FindControl("hdnFormId")).Value);
                    //bool isAdd, isDelete, isModify, isRead;
                    //CheckBox cbAdd = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxAdd");
                    //CheckBox cbDelete = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxDelete");
                    //CheckBox cbModify = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxModify");
                    //CheckBox cbRead = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxRead");

                    //if (cbAdd.Checked) isAdd = true; else isAdd = false;
                    //if (cbDelete.Checked) isDelete = true; else isDelete = false;
                    //if (cbModify.Checked) isModify = true; else isModify = false;
                    //if (cbRead.Checked) isRead = true; else isRead = false;

                    //string strQuery = String.Empty;

                    //strQuery = "UPDATE PRT_Privilege_Rules SET";
                    //strQuery += " add_permission = '" + isAdd + "',";
                    //strQuery += " delete_permission = '" + isDelete + "',";
                    //strQuery += " modify_permission = '" + isModify + "',";
                    //strQuery += " read_permission = '" + isRead + "'";
                    //strQuery += " WHERE form_id_fk = '" + intFormId + "' AND Rules_id_fk = '" + Ruoli_Combobox.SelectedItem + "'";

                    //bool isUpdateResult = DataControl.ExecuteNonQuery(strQuery);
                    //if (isUpdateResult == true)
                    //{
                    //    //
                    //}
                    ////FireJavascriptEvents();
                    int intFormId = int.Parse(((HiddenField)grdPrivileges.Rows[i].FindControl("hdnFormId")).Value);
                    string hdnRolesId = RmTipoIscrizAtleta_Combobox.SelectedItem.ToString();

                    bool isAdd, isDelete, isModify, isRead;
                    CheckBox cbAdd = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxAdd");
                    CheckBox cbDelete = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxDelete");
                    CheckBox cbModify = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxModify");
                    CheckBox cbRead = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxRead");

                    if (cbAdd.Checked) isAdd = true; else isAdd = false;
                    if (cbDelete.Checked) isDelete = true; else isDelete = false;
                    if (cbModify.Checked) isModify = true; else isModify = false;
                    if (cbRead.Checked) isRead = true; else isRead = false;

                    //string strQuery = String.Empty;
                    PRT_Privilege_SA _objPriv = new PRT_Privilege_SA();
                    _objPriv.form_id_fk = intFormId;
                    _objPriv.Rules_id_fk = hdnRolesId;
                    _objPriv.add_permission = isAdd;
                    _objPriv.delete_permission = isDelete;
                    _objPriv.modify_permission = isModify;
                    _objPriv.read_permission = isRead;

                    _objPriv.PRT_Privilege_Rule_SET(_objPriv);

                }
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "User Type", "<script type='text/javascript'>showNotification();</script>", false);
            }

            catch (Exception ex)
            {
                string PathIntranetAssoluto = Server.MapPath("~/").ToString();
                LogFile Errore = new LogFile();
                System.Web.Security.MembershipUser edtUsr = Membership.GetUser();
                Errore.ErrorLog(PathIntranetAssoluto + "\\Error_LogFile\\LogFile", "Errore: " + "  -  " + edtUsr.UserName + "  -  " + ex);
            }
        }
        public void FireJavascriptEvents()
        {
            try
            {
                if (Session["userType"] != null)
                {
                    if (Session["userType"].ToString().Equals("Admin"))
                    {
                        //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Status", "<script type='text/javascript'>activeInactive();</script>", false);
                        //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Status", "<script type='text/javascript'>displayFullName()</script>", false);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "chkBoxAddPermission", "<script type='text/javascript'>findUnselectedCheckboxes('chkBoxAddPermission', 'Add');</script>", false);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "chkBoxDeletePermission", "<script type='text/javascript'>findUnselectedCheckboxes('chkBoxDeletePermission', 'Delete');</script>", false);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "chkBoxModifyPermission", "<script type='text/javascript'>findUnselectedCheckboxes('chkBoxModifyPermission', 'Modify');</script>", false);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "chkBoxReadPermission", "<script type='text/javascript'>findUnselectedCheckboxes('chkBoxReadPermission', 'Read');</script>", false);
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
            finally { }
        }

        protected void UpdatePermessi_Btn_Click(object sender, EventArgs e)
        {
            UpdatePermessi();

        }



        protected void AggiornaPermessi_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {

            UpdatePermessi();
        }

        protected void Ruoli_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {


            if (e.Parameter == "1")
            {
                Generic_Sql.DataBind();
                UpdatePermessi();
            }


            grdPrivileges.DataBind();
        }

        private void ControlRolePrivileges()
        {
            try
            {
                string strQuery = string.Empty;

                strQuery = "SELECT [ValueFieldNumber] as MenuId,";
                strQuery += " [TextField] as Title ,";
                strQuery += " [ValueField] as Description,";
                strQuery += " CAST('False' AS bit) AS add_permission,";
                strQuery += " CAST('False' AS bit) AS delete_permission,";
                strQuery += " CAST('False' AS bit) AS modify_permission,";
                strQuery += " CAST('False' AS bit) AS read_permission";
                strQuery += " FROM [PRT_DropDown_Elementi]  where [DropDown_Famiglia] = 27 ORDER BY [DisplayOrder] ASC";
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

                        strSQLQuery = "EXEC RM_Iscrizione_Privilege_Rules_addRolePrivileges";
                        strSQLQuery += " '" + intFormId + "',";
                        strSQLQuery += " " + RmTipoIscrizAtleta_Combobox.SelectedItem.Value.ToString() + ",";
                        strSQLQuery += " '" + isAdd + "',";
                        strSQLQuery += " '" + isDelete + "',";
                        strSQLQuery += " '" + isModify + "',";
                        strSQLQuery += " '" + isRead + "'";

                        bool isResult = DataControl.ExecuteNonQuery(strSQLQuery);
                        if (isResult == true)
                        {
                            FireJavascriptEvents();

                        }
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

        protected void grdPrivileges_DataBinding(object sender, EventArgs e)
        {
            //ControlRolePrivileges();
            //getUserPrivileges();
            //FireJavascriptEvents();
        }

        protected void salva_btn_Click(object sender, EventArgs e)
        {
            UpdatePermessi();
        }

        protected void grdPrivileges_DataBinding1(object sender, EventArgs e)
        {
            ControlRolePrivileges();
            getUserPrivileges();
            FireJavascriptEvents();
            Generic_Sql.DataBind();
        }

        protected void RmTipoIscrizAtleta_Combobox_SelectedIndexChanged(object sender, EventArgs e)
        {
            ControlRolePrivileges();
            getUserPrivileges();
            FireJavascriptEvents();
            grdPrivileges.DataBind();
        }
    }
}