using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using System.Data;
using System.Web;
using System.IO;
using DevExpress.XtraPrinting.Drawing;

namespace INTRA.AppCode
{
    public partial class ReportCliente : DevExpress.XtraReports.UI.XtraReport
    {
        public ReportCliente()
        {
            InitializeComponent();
        }

        private void xrPictureBox2_BeforePrint(object sender, CancelEventArgs e)
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
