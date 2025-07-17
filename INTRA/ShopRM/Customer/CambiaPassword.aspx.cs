using DevExpress.Web;
using System;
using System.Web.Security;

namespace INTRA.ShopRM.Customer
{
    public partial class CambiaPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ChangePassword_pnl_Callback(object sender, CallbackEventArgsBase e)
        {
            MembershipUser user = Membership.GetUser();
            _ = user.ChangePassword(user.ResetPassword(), confirmPasswordTextBox.Text);

        }
    }
}