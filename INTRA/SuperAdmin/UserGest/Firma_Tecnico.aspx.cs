using System;
using System.Web.Profile;

namespace IntranetTemplate2017.SuperAdmin.UserGest
{
    public partial class Firma_Tecnico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SalvaFirma_Btn_ServerClick(object sender, EventArgs e)
        {
            string username = Request.QueryString["username"];
            string FirmaCliente = signatureOut.Text;
            dynamic MyProfile = ProfileBase.Create(username);
#pragma warning disable CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
            try
            {
                MyProfile.FirmaTecnico = FirmaCliente;
                MyProfile.Save();
                Response.Redirect("edit_user_tm.aspx?username=" + username + "&Msg=1");
            }
            catch (Exception ex)
            {

            }
#pragma warning restore CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
        }
    }
}