using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.IO;
using info4lab;
using info4lab.Portal;
using System.Net.Mime;
using System.Threading;
/// <summary>
/// Descrizione di riepilogo per PRT_EmailUtility
/// </summary>
/// 
namespace INTRA.Age_Ordini.AppCode
{
    public static class EmailUtility
    {
        //public EmailUtility()
        //{
        //    //
        //    // TODO: aggiungere qui la logica del costruttore
        //    //
        //}
        public static void SendMail(string fromAddress, string toAddress, string subject, string body)
        {
            using (MailMessage mail = BuildMessageWith(fromAddress, toAddress.Replace(',', ';'), subject, body))
            {
                //SendMailEmbedImg(mail);
                SendMailEmbedImgV2(mail);
                //SendMailNoEmbedImg(mail);
            }
        }

        public static void SendMailAttach(string fromAddress, string toAddress, string subject, string body, string AttachLink)
        {
            using (MailMessage mail = BuildMessageWith(fromAddress, toAddress.Replace(',', ';'), subject, body))
            {

                mail.Attachments.Add(new Attachment(AttachLink));
                //SendMailEmbedImg(mail);
                SendMailEmbedImgV2(mail);
                //SendMailNoEmbedImg(mail);
            }
        }
        public static void SendMail(MailMessage mail)
        {
            try
            {
                //SmtpClient smtp = new SmtpClient(Portal4Set.Settings.SmtpServer, port);
                SmtpClient mailer = new SmtpClient();
                Portal4Set PortalConfig = new Portal4Set();
                mailer.Host = PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpServer);
                mailer.Credentials = new System.Net.NetworkCredential(PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpUser), PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpPassword));
                //mailer.Send("from@address.net", "to@address.net", "Subject line", "Main email text body");
                mailer.Send(mail);
            }
            catch (Exception e)
            {

            }
        }
        public static void SendMailNoEmbedImg(MailMessage mail)
        {
            try
            {
                Portal4Set PortalConfig = new Portal4Set();

                //SmtpClient smtp = new SmtpClient(Portal4Set.Settings.SmtpServer, port);
                SmtpClient mailer = new SmtpClient();
                string contentId = "image1";
                PRT_ElementiComuni comune = new PRT_ElementiComuni();

                string PathPrefix = comune.server_mapPath();

                string pathLogo = PathPrefix + "\\static\\img\\title.jpg";
                //string pathLogo = System.Web.HttpContext.Current.Server.MapPath("~/static/img/title.jpg"); // my logo is placed in images folder
                //try
                //{
                LinkedResource logo = new LinkedResource(pathLogo);
                logo.ContentId = "companylogo";
                //}
                //catch (Exception e) { 

                //}
                string pathUnderlogo = PathPrefix + "\\static\\img\\thin-horizontal-shadow.jpg"; // my logo is placed in images folder
                                                                                                 //string pathUnderlogo = System.Web.HttpContext.Current.Server.MapPath("~/static/img/thin-horizontal-shadow.jpg"); // my logo is placed in images folder
                LinkedResource underlogo = new LinkedResource(pathUnderlogo);
                underlogo.ContentId = "underlogo";
                //AlternateView av1 = AlternateView.CreateAlternateViewFromString(mail.Body, null, MediaTypeNames.Text.Html);
                //AlternateView plainView = AlternateView.CreateAlternateViewFromString(mail.Body, new ContentType("text/plain; charset=iso-8859-1"));
                //plainView.TransferEncoding = TransferEncoding.SevenBit;
                //mail.AlternateViews.Add(plainView);
                //av1.LinkedResources.Add(logo);
                //av1.LinkedResources.Add(underlogo);
                //mail.Headers.Add("Content-Type", "content=text/html; charset=\"UTF-8\"");
                //mail.AlternateViews.Add(av1);
                //Portal4Set PortalConfig = new Portal4Set();
                mailer.Host = PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpServer);
                mailer.Credentials = new System.Net.NetworkCredential(PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpUser), PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpPassword));
                //mailer.Send("from@address.net", "to@address.net", "Subject line", "Main email text body");
                mailer.Send(mail);
            }
            catch (Exception e)
            {

            }
        }
        public static void SendMailEmbedImg(MailMessage mail)
        {
            try
            {
                Portal4Set PortalConfig = new Portal4Set();

                //SmtpClient smtp = new SmtpClient(Portal4Set.Settings.SmtpServer, port);
                SmtpClient mailer = new SmtpClient();
                string contentId = "image1";
                PRT_ElementiComuni comune = new PRT_ElementiComuni();

                string PathPrefix = comune.server_mapPath();

                string pathLogo = PathPrefix + "\\static\\img\\title.jpg";
                //string pathLogo = System.Web.HttpContext.Current.Server.MapPath("~/static/img/title.jpg"); // my logo is placed in images folder
                //try
                //{
                LinkedResource logo = new LinkedResource(pathLogo);
                logo.ContentId = "companylogo";
                //}
                //catch (Exception e) { 

                //}
                string pathUnderlogo = PathPrefix + "\\static\\img\\thin-horizontal-shadow.jpg"; // my logo is placed in images folder
                                                                                                 //string pathUnderlogo = System.Web.HttpContext.Current.Server.MapPath("~/static/img/thin-horizontal-shadow.jpg"); // my logo is placed in images folder
                LinkedResource underlogo = new LinkedResource(pathUnderlogo);
                underlogo.ContentId = "underlogo";
                AlternateView av1 = AlternateView.CreateAlternateViewFromString(mail.Body, null, MediaTypeNames.Text.Html);
                av1.LinkedResources.Add(logo);
                av1.LinkedResources.Add(underlogo);
                mail.AlternateViews.Add(av1);
                //Portal4Set PortalConfig = new Portal4Set();
                mailer.Host = PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpServer);
                mailer.Credentials = new System.Net.NetworkCredential(PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpUser), PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpPassword));
                //mailer.Send("from@address.net", "to@address.net", "Subject line", "Main email text body");
                mailer.Send(mail);
            }
            catch (Exception e)
            {

            }
        }
        public static void SendMailEmbedImgV2(MailMessage mail)
        {
            //try
            //{

            Portal4Set PortalConfig = new Portal4Set();


            //SmtpClient smtp = new SmtpClient(Portal4Set.Settings.SmtpServer, port);
            SmtpClient mailer = new SmtpClient();

            //string contentId = "image1";
            PRT_ElementiComuni comune = new PRT_ElementiComuni();

            string PathPrefix = comune.server_mapPath();

            //string pathLogo = PathPrefix + "\\static\\img\\title.jpg";
            //string pathLogo = System.Web.HttpContext.Current.Server.MapPath("~/static/img/title.jpg"); // my logo is placed in images folder
            //try
            //{
            //LinkedResource logo = new LinkedResource(pathLogo, System.Net.Mime.MediaTypeNames.Image.Jpeg);
            //logo.ContentId = "companylogo";
            //}
            //catch (Exception e) { 

            //}
            //string pathUnderlogo = PathPrefix + "\\static\\img\\thin-horizontal-shadow.jpg"; // my logo is placed in images folder
            //string pathUnderlogo = System.Web.HttpContext.Current.Server.MapPath("~/static/img/thin-horizontal-shadow.jpg"); // my logo is placed in images folder
            //LinkedResource underlogo = new LinkedResource(pathUnderlogo, System.Net.Mime.MediaTypeNames.Image.Jpeg);
            //underlogo.ContentId = "underlogo";
            //AlternateView av1 = AlternateView.CreateAlternateViewFromString(mail.Body.ToString(), null, System.Net.Mime.MediaTypeNames.Text.Html);

            //AlternateView av1 = AlternateView.CreateAlternateViewFromString(mail.Body, null, MediaTypeNames.Text.Html);

            //av1.LinkedResources.Add(logo);
            //av1.LinkedResources.Add(underlogo);
            //mail.AlternateViews.Add(av1);
            //Portal4Set PortalConfig = new Portal4Set();

            ////test locali
            //mailer.Host = "authsmtp.info4u.it";
            //mailer.Credentials = new System.Net.NetworkCredential("smtp@info4u.it", "Smtp_2014");

            //produzione
            mailer.Host = PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpServer);
            mailer.Credentials = new System.Net.NetworkCredential(PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpUser), PortalConfig.GetConfigurationValue(Portal4Set.Settings.SmtpPassword));
            //mailer.Send("from@address.net", "to@address.net", "Subject line", "Main email text body");

            try
            {
                mailer.Send(mail);
            }
            catch (SmtpFailedRecipientsException ex)
            {
                for (int i = 0; i < ex.InnerExceptions.Length; i++)
                {
                    SmtpStatusCode status = ex.InnerExceptions[i].StatusCode;
                    if (status == SmtpStatusCode.MailboxBusy ||
                        status == SmtpStatusCode.MailboxUnavailable)
                    {
                        Console.WriteLine("Delivery failed - retrying in 5 seconds.");
                        System.Threading.Thread.Sleep(5000);
                        mailer.Send(mail);
                    }
                    else
                    {
                        Console.WriteLine("Failed to deliver message to {0}",
                            ex.InnerExceptions[i].FailedRecipient);
                    }
                }
            }
            //catch (SmtpFailedRecipientException ex)
            //{
            //    // ex.FailedRecipient and ex.GetBaseException() should give you enough info.
            //    string filePath = @"~/Error.txt";
            //    // string ex = "test";
            //    using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePath), true))
            //    {
            //        writer.WriteLine("Errore invio mail :" + ex.FailedRecipient + " </br>" + ex.GetBaseException() + "</br>" + DateTime.Today );
            //        writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
            //    }
            //}

            //}
            //catch (Exception e)
            //{

            //}
        }
        //build a mail message
        private static MailMessage BuildMessageWith(string fromAddress, string toAddress, string subject, string body)
        {
            MailMessage message = new MailMessage
            {
                Sender = new MailAddress(fromAddress), // on Behave of When From differs
                From = new MailAddress(fromAddress),
                Subject = subject,
                //SubjectEncoding = System.Text.Encoding.GetEncoding("iso-8859-1"),
                SubjectEncoding = System.Text.Encoding.GetEncoding("UTF-8"),
                Body = body,
                BodyEncoding = System.Text.Encoding.GetEncoding("UTF-8"),
                //BodyEncoding = System.Text.Encoding.GetEncoding("Windows-1252"),
                IsBodyHtml = true,

            };

            string[] tos = toAddress.Split(';');

            foreach (string to in tos)
            {

                message.To.Add(new MailAddress(to));
            }

            return message;
        }
        // read the text in template file and return it as a string
        private static string ReadFileFrom(string templateName)
        {
            //PathPrefix

            //string filePath = System.Web.HttpContext.Current.Server.MapPath("~/MailTemplates/" + templateName);
            //System.Web.HttpServerUtility.
            //s
            PRT_ElementiComuni comune = new PRT_ElementiComuni();

            string PathPrefix = comune.server_mapPath();
            //string filePath = System.Web.HttpRuntime.AppDomainAppPath.ToString()+"/MailTemplates/" + templateName;
            string filePath = PathPrefix + "\\MailTemplates\\" + templateName;

            string body = File.ReadAllText(filePath);

            return body;
        }
        // get the template body, cache it and return the text
        private static string GetMailBodyOfTemplate(string templateName)
        {
            string cacheKey = string.Concat("mailTemplate:", templateName);
            string body;
            //body = (string)System.Web.HttpContext.Current.Cache[cacheKey];
            body = (string)System.Web.HttpRuntime.Cache[cacheKey];
            if (string.IsNullOrEmpty(body))
            {
                //read template file text
                body = ReadFileFrom(templateName);

                if (!string.IsNullOrEmpty(body))
                {

                    System.Web.HttpRuntime.Cache.Insert(cacheKey, body, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration);
                    //System.Web.HttpContext.Current.Cache.Insert(cacheKey, body, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration);
                }
            }
            //body = info4lab.FunzioniGenerali.ReplaceSpecialChar(body);
            return body;
        }
        // replace the tokens in template body with corresponding values
        public static string PrepareMailBodyWith(string templateName, params string[] pairs)
        {
            string body = GetMailBodyOfTemplate(templateName);
            string bodyHtml = string.Empty;
            for (var i = 0; i < pairs.Length; i += 2)
            {
                body = body.Replace("<%={0}%>".FormatWith(pairs[i]), pairs[i + 1]);
            }
            return body;
        }
        public static string FormatWith(this string target, params object[] args)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("it-IT", false);
            return string.Format(Constants.CurrentCulture, target, args);
        }
        public static string FormatWith(this string format, IFormatProvider provider, object source)
        {
            if (format == null)
                throw new ArgumentNullException("format");

            Regex r = new Regex(@"(?<start>\{)+(?<property>[\w\.\[\]]+)(?<format>:[^}]+)?(?<end>\})+",
              RegexOptions.Compiled | RegexOptions.CultureInvariant | RegexOptions.IgnoreCase);

            List<object> values = new List<object>();
            string rewrittenFormat = r.Replace(format, delegate (Match m)
            {
                Group startGroup = m.Groups["start"];
                Group propertyGroup = m.Groups["property"];
                Group formatGroup = m.Groups["format"];
                Group endGroup = m.Groups["end"];

                values.Add((propertyGroup.Value == "0")
                  ? source
                  : DataBinder.Eval(source, propertyGroup.Value));

                return new string('{', startGroup.Captures.Count) + (values.Count - 1) + formatGroup.Value
                  + new string('}', endGroup.Captures.Count);
            }
            );

            return string.Format(provider, rewrittenFormat, values.ToArray());
        }
        public static class Constants
        {
            //culture info
            public static CultureInfo CurrentCulture
            {
                get
                {
                    return CultureInfo.CurrentCulture;
                }
            }
        }
    }
}