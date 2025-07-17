using INTRA.AppCode;
using System;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM.Customer
{
    public partial class CambiaEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MembershipUser user = Membership.GetUser();
                UserTxt.Text = user.UserName;
                RegMailLbl.Text = user.Email;
            }
        }
        protected void btnSaveRegister_Command(object sender, CommandEventArgs e)
        {
            try
            {
                int result = VIO_Utenti.AppCode.VIO_Utenti_CRUD.Email_Update(UserTxt.Text, RegMailTxt.Text);
                result = ClientiCat_Crud.UpdateEmailCliente(UserTxt.Text, RegMailTxt.Text);

                MembershipUser User = Membership.GetUser();

                User.Email = RegMailTxt.Text;
                Membership.UpdateUser(User);

                MyMessageBox1.ShowSuccess("L'indirizzo mail è stato modificato");
                RegMailLbl.Text = User.Email;
                RegMailTxt.Text = string.Empty;
            }
            catch (Exception ex)
            {
                MyMessageBox1.ShowError("Si è verificato un errore: " + ex.Message);
            }
        }

    }
}