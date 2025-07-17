using DevExpress.XtraReports.UI;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;

namespace INTRA.Print_Gest.AppCode
{
    public partial class Print_Cli_Consumabili_Sub_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public Print_Cli_Consumabili_Sub_Rpt()
        {
            InitializeComponent();
        }

        private void xrLabel3_BeforePrint(object sender, CancelEventArgs e)
        {

            var label = sender as DevExpress.XtraReports.UI.XRLabel;
            string colorHex = label.Text;

            try
            {
                System.Drawing.Color color = System.Drawing.ColorTranslator.FromHtml(colorHex);
                label.BackColor = color;
                label.Text = "";
            }
            catch
            {
                label.BackColor = System.Drawing.Color.Transparent;
                label.Text = "Invalid";
            }
        }


    }
}
