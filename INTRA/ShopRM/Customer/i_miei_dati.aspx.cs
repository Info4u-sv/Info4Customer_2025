using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using info4lab.Portal;
using System.Configuration;
using System.Web.Security;
using System.Web.Profile;
using DevExpress.Web;
using System.Data;
using INTRA.AppCode;

namespace INTRA.ShopRM.Customer
{
    public partial class i_miei_dati : System.Web.UI.Page
    {

       
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                
                dynamic Profile = (ProfileBase)ProfileBase.Create(User.Identity.Name, true);
                UserTxt.Text = User.Identity.Name;

                AppoggioUpd_Dts.SelectParameters["UtenteIntranet"].DefaultValue = User.Identity.Name;
                DataView dv2 = (DataView)AppoggioUpd_Dts.Select(DataSourceSelectArguments.Empty);
                DataTable dt2 = dv2.ToTable();

                if (dt2.Rows.Count > 0)
                {
                    Email_Txt.Text = dt2.Rows[0]["EmailContatto"].ToString();
                }
                else
                {
                    SalvaEmail_Btn.ClientEnabled = false;
                    signUp.ClientEnabled = false;
                }

            }

        }
 
        

        protected void SalvaPsw_Callback_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            UserLog.ChangePassword(UserLog.ResetPassword(), passwordTextBox.Text);
            Membership.UpdateUser(UserLog);
        }

        protected void CambiaPassword_Callback_Callback(object source, CallbackEventArgs e)
        {
            if(e.Parameter == "")
            {
                MembershipUser UserLog = Membership.GetUser();
                UserLog.ChangePassword(UserLog.ResetPassword(), passwordTextBox.Text);
            }
            else
            {
                AppoggioUpd_Dts.UpdateParameters["EmailContatto"].DefaultValue = Email_Txt.Text;
                AppoggioUpd_Dts.UpdateParameters["UtenteIntranet"].DefaultValue = User.Identity.Name;
                AppoggioUpd_Dts.Update();
            }
        }
    }
}