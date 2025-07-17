using DevExpress.Web;
using System;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM.Controls
{
    public partial class _21LoginArea : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void OnLoggedIn(object sender, EventArgs e)
        {
            if (Context.User.IsInRole("customer"))
            {
                Response.Redirect("~/customer/default.aspx");
            }
            //else if (Context.User.IsInRole("managers"))
            //{
            //    this.Response.Redirect("~/client/default.aspx");
            //}
        }
        //void SiteSpecificUserLoggingMethod(string UserName)
        //{
        //    // Insert code to record the current date and time
        //    // when this user was authenticated at the site.
        //}
        protected void Login1_LoggedIn(object sender, EventArgs e)
        {
            Login lg = (Login)LoginView1.Controls[0].Controls[0].FindControl("Login1");
            TextBox tb = (TextBox)lg.FindControl("UserName");
            string user = tb.Text;
            if (Context.User.Identity.IsAuthenticated)
            {
                user = Context.User.Identity.Name;
            }
            //LoginName1
            if (Roles.IsUserInRole(user, "Administrator"))
            {
                Response.Redirect("~/AdminPanel/Admin/default.aspx");
            }
            else if (Roles.IsUserInRole(user, "Customer"))
            {
                Response.Redirect("~/customer/default.aspx");
            }
        }

        protected void logOut_callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            ASPxWebControl.RedirectOnCallback("login.aspx");

        }
    }
}