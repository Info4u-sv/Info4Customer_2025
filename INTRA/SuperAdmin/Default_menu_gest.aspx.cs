using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
using Info4U.Models;
using System;
using System.Collections;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using PRT_Privilege_SA = INTRA.SuperAdmin.AppCode.PRT_Privilege_SA;

namespace INTRA.SuperAdmin
{
    public partial class Default_menu_gest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {

            }
            if (IsCallback)
            {

            }
        }

        protected void ASPxCallPrivilegeUpdate_Callback(object sender, CallbackEventArgs e)
        {
            UpdatePermessi();
        }

        protected void TreeListMenu_NodeInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            // reset sessione menu
            Session["li_contenitore_Menu"] = null;
            if (e.NewValues["ParentMenuId"] == null)
            {
                e.NewValues["ParentMenuId"] = 0;
            }
            ASPxColorEdit edt = TreeListMenu.FindEditCellTemplateControl(TreeListMenu.Columns["Color"] as TreeListDataColumn, "ColorEditHeaderBackColor") as ASPxColorEdit;
            e.NewValues["Color"] = GetColor();

            // correzione Simone 
            if (e.NewValues["DefaultPage"] == null)
            {
                e.NewValues["DefaultPage"] = 0;
            }
            if (e.NewValues["IsVisible"] == null)
            {
                e.NewValues["IsVisible"] = 0;
            }





        }
        protected Color GetColor(object container)
        {
            try
            {
                int ColorDec = Convert.ToInt32(container.ToString(), 16);
                Color color = Color.FromArgb(ColorDec);
                return color;
            }
            catch (Exception)
            {
                return Color.Red;
            }
        }

        private string GetColor()
        {
            //GridViewDataTextColumn col = grid.Columns["DxColor"] as GridViewDataTextColumn;
            ASPxColorEdit colorEdit = TreeListMenu.FindEditCellTemplateControl(TreeListMenu.Columns["Color"] as TreeListDataColumn, "ColorEditHeaderBackColor") as ASPxColorEdit;

            //ASPxColorEdit colorEdit = grid.FindEditRowCellTemplateControl(col, "colorEdit") as ASPxColorEdit;
            Color color = colorEdit.Color;
            string colorex = color.Name.ToString();
            return colorex.Remove(0, 2);
            //return color.ToArgb().ToString();
        }

        protected void TreeListMenu_NodeUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {  // reset sessione menu
            Session["li_contenitore_Menu"] = null;
            ASPxColorEdit edt = TreeListMenu.FindEditCellTemplateControl(TreeListMenu.Columns["Color"] as TreeListDataColumn, "ColorEditHeaderBackColor") as ASPxColorEdit;
            string colorex = GetColor();
            e.NewValues["Color"] = GetColor();

        }
        protected void btnDeleteCache_Click(object sender, EventArgs e)
        {  // reset sessione menu
            Session["li_contenitore_Menu"] = null;
            foreach (DictionaryEntry de in HttpContext.Current.Cache)
            {
                HttpContext.Current.Cache.Remove((string)de.Key);
            }
            Response.Redirect("Default_menu_gest.aspx");
            //Response.Redirect("pannello_parametri_sito.aspx?Msg=1");
        }
        protected void popup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {

            Session["form_id_fk"] = e.Parameter;
            grdPrivileges.DataBind();

        }


        protected void UpdatePermessi_Btn_Click(object sender, EventArgs e)
        {
            UpdatePermessi();
        }


        private void UpdatePermessi()
        {
            // reset sessione menu
            Session["li_contenitore_Menu"] = null;
            try
            {
                //GetData(Session["eparameter"].ToString());
                //grdPrivileges.DataBind();
                for (int i = 0; i < grdPrivileges.Rows.Count; i++)
                {
                    int intFormId = int.Parse(((HiddenField)grdPrivileges.Rows[i].FindControl("hdnFormId")).Value);
                    string hdnRolesId = ((HiddenField)grdPrivileges.Rows[i].FindControl("hdnRolesId")).Value;

                    bool isAdd, isDelete, isModify, isRead;
                    CheckBox cbAdd = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxAdd");
                    CheckBox cbDelete = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxDelete");
                    CheckBox cbModify = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxModify");
                    CheckBox cbRead = (CheckBox)grdPrivileges.Rows[i].FindControl("chkBoxRead");

                    if (cbAdd.Checked) isAdd = true; else isAdd = false;
                    if (cbDelete.Checked) isDelete = true; else isDelete = false;
                    if (cbModify.Checked) isModify = true; else isModify = false;
                    if (cbRead.Checked) isRead = true; else isRead = false;

                    PRT_Privilege_SA _objPriv = new PRT_Privilege_SA();
                    _objPriv.form_id_fk = intFormId;
                    _objPriv.Rules_id_fk = hdnRolesId;
                    _objPriv.add_permission = isAdd;
                    _objPriv.delete_permission = isDelete;
                    _objPriv.modify_permission = isModify;
                    _objPriv.read_permission = isRead;

                    _objPriv.PRT_Privilege_Rule_SET(_objPriv);

                    Sql4Helper objSqlHelper = new Sql4Helper();
                    SqlParameter[] objParams = new SqlParameter[1];
                    objParams[0] = new SqlParameter("@Rules_id_fk", hdnRolesId);
                    objSqlHelper.ExecuteNonQueryForNews("PRT_Privilege_RulesSetPrivileges_Users", objParams);
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

        protected void PrivilegeUpdate_CallbackP_Callback(object sender, CallbackEventArgsBase e)
        {
            UpdatePermessi();
        }

        protected void TreeListMenu_NodeDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            // reset sessione menu
            Session["li_contenitore_Menu"] = null;
            PRT_Privilege_SA _ObjPriv = new PRT_Privilege_SA();
            int MenuId = Convert.ToInt32(e.Keys[0].ToString());
            _ObjPriv.PRT_Privileges_DELETE_ByFormId(MenuId);
        }

        protected void ResetColori_Click(object sender, EventArgs e)
        {
            string colorex = ColorIconBackColor.Color.Name.ToString();
            string updateCommand = " UPDATE [PRT_Menus] set [Color] = '" + colorex.Remove(0, 2) + "'";
            using (SqlConnection connection =
                   new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(updateCommand, connection);
                command.Connection.Open();
                command.ExecuteNonQuery();
            }

            foreach (DictionaryEntry de in HttpContext.Current.Cache)
            {
                HttpContext.Current.Cache.Remove((string)de.Key);
            }
            Response.Redirect("Default_menu_gest.aspx");
        }

        protected void TreeListMenu_NodeInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {

        }

        protected void Menu_SqlDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int newID = (int)e.Command.Parameters["@IdNew"].Value; // recupero ID

            TreeListNode aNode = TreeListMenu.FindNodeByKeyValue(newID.ToString()); // cerco il nodo appena inserito 
            if (aNode != null)
                aNode.Focus(); // focus

        }
    }
}