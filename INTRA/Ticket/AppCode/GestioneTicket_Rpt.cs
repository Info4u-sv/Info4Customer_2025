using DevExpress.XtraReports.UI;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.IO;

namespace INTRA.Ticket.AppCode
{
    public partial class GestioneTicket_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public GestioneTicket_Rpt()
        {
            InitializeComponent();
        }

        private void xrPictureBox2_BeforePrint(object sender, CancelEventArgs e)
        {
            XRPictureBox xrBox = sender as XRPictureBox;
            string base64String = this.GetCurrentColumnValue("ImgFirmaTecnico") as string;
            if (base64String != null && base64String != "")
            {

                Image img = ByteArrayToImage(Convert.FromBase64String(base64String.Replace("data:image/png;base64,", "")));
                xrBox.Image = img;
            }
        }
        public Image ByteArrayToImage(byte[] byteArrayIn)
        {
            MemoryStream ms = new MemoryStream(byteArrayIn);
            Image returnImage = Image.FromStream(ms);
            return returnImage;
        }

        private void xrPictureBox3_BeforePrint(object sender, CancelEventArgs e)
        {
            XRPictureBox xrBox = sender as XRPictureBox;
            string base64String = this.GetCurrentColumnValue("ImgFirmaCliente") as string;
            if (base64String != null && base64String != "")
            {
                Image img = ByteArrayToImage(Convert.FromBase64String(base64String.Replace("data:image/png;base64,", "")));
                xrBox.Image = img;
            }
        }
    }
}
