using DevExpress.XtraPrinting.Drawing;
using DevExpress.XtraReports.UI;
using System.Drawing;
using System.IO;

namespace INTRA.AppCode
{
    public partial class ReportCliente : DevExpress.XtraReports.UI.XtraReport
    {
        public ReportCliente()
        {
            InitializeComponent();
        }

        private void xrPictureBox2_BeforePrint(object sender, System.ComponentModel.CancelEventArgs e)
        {


            if (GetCurrentColumnValue("U_ImgBigliettoVisita2") != null)
            {
                try
                {
                    byte[] bytes = (byte[])GetCurrentColumnValue("U_ImgBigliettoVisita2");
                    MemoryStream mem = new MemoryStream(bytes);
                    Bitmap bmp = new Bitmap(mem);
                    Image img = bmp;

                    XRPictureBox pictureBox = (XRPictureBox)sender;
                    pictureBox.ImageSource = new ImageSource(img);
                }
                catch
                {

                }

            }

        }
    }
}
