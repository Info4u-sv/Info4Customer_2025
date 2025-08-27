using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ticket
{
    public partial class Ticket_Firma : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public System.Drawing.Image Base64ToImage(string base64String)
        {
            // Convert Base64 String to byte[]
            byte[] imageBytes = Convert.FromBase64String(base64String);
            MemoryStream ms = new MemoryStream(imageBytes, 0,
              imageBytes.Length);

            // Convert byte[] to Image
            ms.Write(imageBytes, 0, imageBytes.Length);
            System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true);
            return image;
        }



        protected void SalvaFirma_Btn_Click(object sender, EventArgs e)
        {

            string IdTicket = Request.QueryString["IdTicket"];
            string FirmaCliente = signatureOut.Text;
            TCK_Ticket Rapportini = new TCK_Ticket();
            // salviamo la firma nel campo ImgFirmaCliente della testa rapportino 
            Rapportini.CodRapportino = Convert.ToInt32(IdTicket);
            Rapportini.ImgFirmaCliente = FirmaCliente;
            Label firmacliente_Lbl = (Label)DatiFirmaTck_FW.FindControl("firmacliente_Lbl");
            Rapportini.FirmaCliente = firmacliente_Lbl.Text;
            Rapportini.TicketFirmato = true;
            Rapportini.TCK_TestataTicket_FirmaUpdate(Rapportini);
            Response.Redirect("Ticket_view.aspx?IdTicket=" + IdTicket + "&Msg=1");
            // System.Drawing.Image test = Base64ToImage()
            // valoriziamo il campo TicketFirmato a 1 
        }
    }
}