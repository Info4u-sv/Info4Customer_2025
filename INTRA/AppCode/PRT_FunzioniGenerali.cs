using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Descrizione di riepilogo per FunzioniGenerali
/// </summary>
/// 
namespace info4lab
{
    public class FunzioniGenerali
    {
        public FunzioniGenerali()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }


        public static Control GetPostbackControl(Page targPage)
        {
            if (targPage.IsPostBack)
            {
                // try to find the name of the postback control in the hidden 
                // __EVENTTARGET field
                string ctlName = targPage.Request.Form["__EVENTTARGET"];
                // if the string is not null, return the control with that name
                if (ctlName.Trim().Length > 0)
                {
                    return targPage.FindControl(ctlName);
                }
                // the trick above does not work if the postback is caused by standard 
                // buttons.
                // In that case we retrieve the control the ASP-way: by looking in the 
                // Page's Form collection
                // to find the name of a button control, that actually is the control 
                // that submitted the page
                //string keyName = String.Empty;
                foreach (string keyName in targPage.Request.Form)
                {
                    Control ctl = targPage.FindControl(keyName);
                    // if a control named as this key exists,
                    // check whether it is a button - if it is, return it!
                    if ((ctl != null))
                    {
                        if (ctl is Button)
                        {
                            return ctl;
                        }
                    }
                }
            }

            return null;
        }

        public static string Taglia_Descr(string Descr, int iMaxChar)
        {
            //int iMaxChar = 100;
            string sResult = Descr;
            if (sResult.Length > iMaxChar)
            {
                if (Descr.IndexOf(" ", iMaxChar) > 0)
                {
                    sResult = sResult.Substring(0, Descr.IndexOf(" ", iMaxChar)) + "...";
                }
            }
            return (sResult);
        }

        public static bool ResizeImageAndUpload(System.IO.FileStream newFile, string folderPathAndFilenameNoExtension, double maxHeight, double maxWidth)
        {
            try
            {

                // Declare variable for the conversion
                float ratio;

                // Create variable to hold the image
                System.Drawing.Image thisImage = System.Drawing.Image.FromStream(newFile);

                // Get height and width of current image
                int width = thisImage.Width;
                int height = thisImage.Height;

                // Ratio and conversion for new size
                if (width > maxWidth)
                {
                    ratio = (float)width / (float)maxWidth;
                    width = (int)(width / ratio);
                    height = (int)(height / ratio);
                }

                // Ratio and conversion for new size
                if (height > maxHeight)
                {
                    ratio = (float)height / (float)maxHeight;
                    height = (int)(height / ratio);
                    width = (int)(width / ratio);
                }

                // Create "blank" image for drawing new image
                Bitmap outImage = new Bitmap(width, height);
                Graphics outGraphics = Graphics.FromImage(outImage);
                SolidBrush sb = new SolidBrush(System.Drawing.Color.White);


                // Fill "blank" with new sized image
                outGraphics.FillRectangle(sb, 0, 0, outImage.Width, outImage.Height);
                outGraphics.DrawImage(thisImage, 0, 0, outImage.Width, outImage.Height);
                sb.Dispose();
                outGraphics.Dispose();
                thisImage.Dispose();

                // Save new image as jpg
                outImage.Save(System.Web.HttpContext.Current.Server.MapPath(folderPathAndFilenameNoExtension), System.Drawing.Imaging.ImageFormat.Jpeg);
                outImage.Dispose();

                return true;

            }
            catch (Exception)
            {
                return false;
            }
        }


        public static void Elimina_Files(string Directory)
        {
            DirectoryInfo dir = new DirectoryInfo(Directory);
            if (dir.Exists)
            {
                FileInfo[] Files = dir.GetFiles();

                foreach (FileInfo fi in Files)
                {
                    fi.Delete();
                }
            }
            //DirectoryInfo[] subdirEntries = dir.GetDirectories(Directory);
            //foreach (DirectoryInfo subdir in subdirEntries)
            //{

            //}
        }
        public static string RewriteString(string Stringa)
        {
            Stringa = Stringa.Trim();
            string stFormD = Stringa.Normalize(NormalizationForm.FormD);
            StringBuilder sb = new StringBuilder();

            for (int ich = 0; ich < stFormD.Length; ich++)
            {
                UnicodeCategory uc = CharUnicodeInfo.GetUnicodeCategory(stFormD[ich]);
                if (uc != UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(stFormD[ich]);
                }
            }
            string input = sb.ToString().Normalize(NormalizationForm.FormC);
            string pattern = "\\W+";
            string replacement = "_";
            Regex rgx = new Regex(pattern);
            string resultRw = rgx.Replace(input, replacement);
            return resultRw;
        }
        public static string NormalizzaDocImport(string Stringa)
        {
            Stringa = Stringa.Trim();
            string stFormD = Stringa.Normalize(NormalizationForm.FormD);
            StringBuilder sb = new StringBuilder();

            for (int ich = 0; ich < stFormD.Length; ich++)
            {
                UnicodeCategory uc = CharUnicodeInfo.GetUnicodeCategory(stFormD[ich]);
                if (uc != UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(stFormD[ich]);
                }
            }
            string input = sb.ToString().Normalize(NormalizationForm.FormC);
            input = input.Replace("_", "__");
            string pattern = "\\W+";
            string replacement = "_";
            Regex rgx = new Regex(pattern);
            string resultRw = rgx.Replace(input, replacement);
            // resultRw = resultRw.Replace("_", "__");
            return resultRw;
        }
        /// <summary>
        /// Convert a List{T} to a DataTable.
        /// </summary>
        public static DataTable ToDataTable<T>(List<T> items)
        {
            var tb = new DataTable(typeof(T).Name);

            PropertyInfo[] props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);

            foreach (PropertyInfo prop in props)
            {
                Type t = GetCoreType(prop.PropertyType);
                tb.Columns.Add(prop.Name, t);
            }

            foreach (T item in items)
            {
                var values = new object[props.Length];

                for (int i = 0; i < props.Length; i++)
                {
                    values[i] = props[i].GetValue(item, null);
                }

                tb.Rows.Add(values);
            }

            return tb;
        }

        /// <summary>
        /// Determine of specified type is nullable
        /// </summary>
        public static bool IsNullable(Type t)
        {
            return !t.IsValueType || (t.IsGenericType && t.GetGenericTypeDefinition() == typeof(Nullable<>));
        }

        /// <summary>
        /// Return underlying type if type is Nullable otherwise return the type
        /// </summary>
        public static Type GetCoreType(Type t)
        {
            if (t != null && IsNullable(t))
            {
                if (!t.IsValueType)
                {
                    return t;
                }
                else
                {
                    return Nullable.GetUnderlyingType(t);
                }
            }
            else
            {
                return t;
            }
        }

        public string TxtToHtml(string text, bool allow)
        {
            //Create a StringBuilder object from the string intput
            //parameter
            StringBuilder sb = new StringBuilder(text);
            //Replace all double white spaces with a single white space
            //and &nbsp;
            sb.Replace("  ", " &nbsp;");
            //Check if HTML tags are not allowed
            if (!allow)
            {
                //Convert the brackets into HTML equivalents
                sb.Replace("<", "&lt;");
                sb.Replace(">", "&gt;");
                //Convert the double quote
                sb.Replace("\"", "&quot;");
            }
            //Create a StringReader from the processed string of 
            //the StringBuilder object
            StringReader sr = new StringReader(sb.ToString());
            StringWriter sw = new StringWriter();
            //Loop while next character exists
            while (sr.Peek() > -1)
            {
                //Read a line from the string and store it to a temp
                //variable
                string temp = sr.ReadLine();
                //write the string with the HTML break tag
                //Note here write method writes to a Internal StringBuilder
                //object created automatically
                sw.Write(temp + "<br>");
            }
            //Return the final processed text
            return sw.GetStringBuilder().ToString();
        }
        public static string TxtUpdateCommand(string txt)
        {
            return txt.Replace("'", "''");
        }

        public static string BaseSiteUrl
        {
            get
            {
                HttpContext context = HttpContext.Current;
                string baseUrl = context.Request.Url.Scheme + "://" + context.Request.Url.Authority + context.Request.ApplicationPath.TrimEnd('/') + '/';
                return baseUrl;
            }
        }
        public static string GetSiteRoot()
        {
            string port = System.Web.HttpContext.Current.Request.ServerVariables["SERVER_PORT"];
            if (port == null || port == "80" || port == "443")
                port = string.Empty;
            else
                port = ":" + port;

            string protocol = System.Web.HttpContext.Current.Request.ServerVariables["SERVER_PORT_SECURE"];
            if (protocol == null || protocol == "0")
                protocol = "http://";
            else
                protocol = "https://";

            string sOut = protocol + System.Web.HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + port + System.Web.HttpContext.Current.Request.ApplicationPath;

            if (sOut.EndsWith("/"))
            {
                sOut = sOut.Substring(0, sOut.Length - 1);
            }

            return sOut;
        }
        public static string GetSiteServerName()
        {
            string port = System.Web.HttpContext.Current.Request.ServerVariables["SERVER_PORT"];
            if (port == null || port == "80" || port == "443")
                port = string.Empty;
            else
                port = ":" + port;

            string protocol = System.Web.HttpContext.Current.Request.ServerVariables["SERVER_PORT_SECURE"];
            if (protocol == null || protocol == "0")
                protocol = "http://";
            else
                protocol = "https://";

            string sOut = protocol + System.Web.HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + port;

            if (sOut.EndsWith("/"))
            {
                sOut = sOut.Substring(0, sOut.Length - 1);
            }

            return sOut;
        }
        public static decimal ConvertStringToDecimal(string Number)
        {
            decimal ReturnNumber;
            //NumberFormatInfo provider = new NumberFormatInfo();

            //provider.NumberDecimalSeparator = ",";
            //provider.NumberGroupSeparator = ".";

            //ReturnNumber = Convert.ToDecimal(Number, provider);
            ReturnNumber = decimal.Parse(Number, CultureInfo.InvariantCulture);
            return ReturnNumber;
        }

        public static string NormalizeString(string Stringa)
        {
            Stringa = Stringa.Trim();
            string stFormD = Stringa.Normalize(NormalizationForm.FormD);
            StringBuilder sb = new StringBuilder();

            for (int ich = 0; ich < stFormD.Length; ich++)
            {
                UnicodeCategory uc = CharUnicodeInfo.GetUnicodeCategory(stFormD[ich]);
                if (uc != UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(stFormD[ich]);
                }
            }
            string input = sb.ToString().Normalize(NormalizationForm.FormC);
            string pattern = "\\W+";
            string replacement = " ";
            Regex rgx = new Regex(pattern);
            string resultRw = rgx.Replace(input, replacement);
            return resultRw;
        }

        public static bool Svuota_tabella(string NomeTabella)
        {
            string consString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            string DeleteStr = "truncate table " + NomeTabella + string.Empty;
            using (SqlConnection con = new SqlConnection(consString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(DeleteStr, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            return true;
        }

        public static bool Svuota_tabella_KING(string NomeTabella)
        {
            string consString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
            string DeleteStr = "truncate table " + NomeTabella + string.Empty;
            using (SqlConnection con = new SqlConnection(consString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(DeleteStr, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            return true;
        }
        public static bool Svuota_tabella_SqlDb(string NomeTabella, string ConnectionString)
        {

            string DeleteStr = "truncate table " + NomeTabella + string.Empty;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(DeleteStr, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            return true;
        }

        public static bool EseguiQuery(string QueryString, string ConnectionString)
        {
            string consString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(QueryString, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            return true;
        }
        public static string[] SplitAndTrim(string text, char separator)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return null;
            }

            return text.Split(separator).Select(t => t.Trim()).ToArray();
        }
        public static string MakeValidFileName(string name)
        {
            // 26/01/2022 Simone nuova funzione 
            // normalizza il nome del file da caricare con l'upload             
            // @"[^\w\.] accetta tutte le lettere, numeri e punti il resto non lo considera BUONO

            return Regex.Replace(name, @"[^\w\.]", "_");
        }

        public static string ValidazioneCampo(string Campo, string Where, string Tabella)
        {
            string ValoreDiRitorno = "0";
            string SqlString = "Select " + Campo + " FROM " + Tabella + " where " + Where + string.Empty;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
#pragma warning disable CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                bool retVal = false;
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                    retVal = false;
                }
                else
                {
                    while (myReader.Read())
                    {
                        ValoreDiRitorno = "1";
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return ValoreDiRitorno;
        }


        public static string GetAbsolutePathIntrant()
        {
            // ritorna il path assoluto del progetto 
            string _RetVal;
            _RetVal = HttpContext.Current.Server.MapPath("~").ToString();
            return _RetVal;
        }
    }
}