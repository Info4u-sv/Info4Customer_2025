using DevExpress.Web;
using info4lab.Portal;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Users
{
    public partial class Recupero_Dati : System.Web.UI.Page
    {
        MembershipUser user;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["UserId"] == null)
            {
                Response.Redirect("~/login.aspx");
            }
        }

        
        protected void CambiaPassword_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            user = PRT_Users_SA.GetUserById(Request.QueryString["UserId"]);
            //MembershipUser user = Membership.GetUser(Request.QueryString["UserId"]);
            user.ChangePassword(user.ResetPassword(), passwordTextBox.Text);

            //HttpContext.Current.Response.Redirect("~/login.aspx");
            //ASPxWebControl.RedirectOnCallback("/login.aspx");
           // try
           // {
           //   ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute("~/login.aspx"));
           //  System.Web.VirtualPathUtility.ToAbsolute("~/login.aspx");
           //   HttpContext.Current.Response.RedirectLocation =
           //System.Web.VirtualPathUtility.ToAbsolute("~/login.aspx");
           //     Response.Redirect("~/login.aspx", true);

           // }
           // catch (ApplicationException ex) { System.Web.VirtualPathUtility.ToAbsolute("~/login.aspx"); }
        }
    }
}