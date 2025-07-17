using System;
using System.IO;
using System.Web.Hosting;

namespace INTRA.AppCode
{
    public class PRT_ErrorGest_23
    {
        public static void ErrorLogSave(string ex)
        {
            string message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            message += Environment.NewLine;
            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            message += string.Format("Message: {0}", ex.ToString());

            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            string path = HostingEnvironment.MapPath("~/ErrorLog.txt");
            using (StreamWriter writer = new StreamWriter(path, true))
            {
                writer.WriteLine(message);
                writer.Close();
            }
        }

    }
}