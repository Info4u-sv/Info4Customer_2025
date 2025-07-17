using System;
using System.IO;
using System.Web;

namespace Info4U.Models
{
    public class ErrorLog
    {
        public static void SaveErrorLog(Exception ex)
        {

            string filePath = @"~/Error.txt";
            // string ex = "test";
            using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePath), true))
            {
                writer.WriteLine("Errore :" + DateTime.Now.ToString() + " " + Environment.NewLine);
                writer.WriteLine(ex.ToString() + Environment.NewLine);
                writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
            }
        }
    }
}