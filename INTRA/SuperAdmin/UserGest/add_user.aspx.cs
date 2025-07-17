using DevExpress.Web;
using INTRA.SuperAdmin.AppCode;
using System;
using System.Web.Security;

namespace IntranetTemplate2017.SuperAdmin.UserGest
{
    public partial class add_user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Cache.SetNoStore();
        }
        protected void UserCallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            try
            {
                Page.Validate("UserForm");
                if (Page.IsValid)
                {
                    AddUser();
                    PRT_Privilege_SA _objPriv = new PRT_Privilege_SA();
                    _objPriv.tbl_um_privilege_By_UserVsRoles_SET(username_Txt.Text);

                    UserCallbackPanel.JSProperties["cpResetForm"] = true;
                }
                else
                {
                    EmailError_Lbl.Text = "Dati non validi lato server";
                }
            }
            catch (Exception ex)
            {
                EmailError_Lbl.Text = "L'email è già associata ad un account, cambiare email e riprovare";
            }
        }
        protected void AddUser()
        {
            MembershipUser newUser = Membership.CreateUser(username_Txt.Text, password_Txt.Text, email.Text);
            newUser.Comment = comment.Text;
            Membership.UpdateUser(newUser);
            foreach (ListEditItem rolebox in UserRoles.Items)
            {
                if (rolebox.Selected)
                {
                    Roles.AddUserToRole(username_Txt.Text, rolebox.Text);
                }
            }
            try
            {
                PRT_Utenti_SA Ins = new PRT_Utenti_SA();
                Ins.Dashboard_User_Insert(username_Txt.Text);
            }
            catch { }
        }
        private void Page_PreRender()
        {
            UserRoles.DataSource = Roles.GetAllRoles();
            UserRoles.DataBind();
        }


        protected void reset_Click(object sender, EventArgs e)
        {
            Response.Redirect("users.aspx");
        }
    }
}