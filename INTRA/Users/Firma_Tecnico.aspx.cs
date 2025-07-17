using System;
using System.Web.Profile;
using System.Web.Security;

namespace INTRA.Users
{
    public partial class Firma_Tecnico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SalvaFirma_Btn_ServerClick(object sender, EventArgs e)
        {
            MembershipUser UserLogged = Membership.GetUser();

            string username = UserLogged.UserName;
            string FirmaCliente = signatureOut.Text;



            dynamic MyProfile = ProfileBase.Create(username, true);

#pragma warning disable CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
            try
            {
                MyProfile.FirmaTecnico = FirmaCliente;
                MyProfile.Save();
                Response.Redirect("ProfiloUtente.aspx?Msg=1");
            }


            catch (Exception ex)
            {

            }
#pragma warning restore CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata

        }

    }
}