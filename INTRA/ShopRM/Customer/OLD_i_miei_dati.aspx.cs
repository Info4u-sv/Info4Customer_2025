using DevExpress.Web;
using System;
using System.Data;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;

namespace INTRA.ShopRM.Customer
{
    public partial class OLD_i_miei_dati : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                _ = ProfileBase.Create(User.Identity.Name, true);
                UserTxt.Text = User.Identity.Name;

                AppoggioUpd_Dts.SelectParameters["UtenteIntranet"].DefaultValue = User.Identity.Name;
                DataView dv2 = (DataView)AppoggioUpd_Dts.Select(DataSourceSelectArguments.Empty);
                DataTable dt2 = dv2.ToTable();


                Email_Txt.Text = dt2.Rows[0]["EmailContatto"].ToString();

            }

        }



        protected void SalvaPsw_Callback_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            _ = UserLog.ChangePassword(UserLog.ResetPassword(), passwordTextBox.Text);
            Membership.UpdateUser(UserLog);
        }

        protected void CambiaPassword_Callback_Callback(object source, CallbackEventArgs e)
        {
            if (e.Parameter == string.Empty)
            {
                MembershipUser UserLog = Membership.GetUser();
                _ = UserLog.ChangePassword(UserLog.ResetPassword(), passwordTextBox.Text);
            }
            else
            {
                AppoggioUpd_Dts.UpdateParameters["EmailContatto"].DefaultValue = Email_Txt.Text;
                AppoggioUpd_Dts.UpdateParameters["UtenteIntranet"].DefaultValue = User.Identity.Name;
                _ = AppoggioUpd_Dts.Update();
            }
        }
    }
}