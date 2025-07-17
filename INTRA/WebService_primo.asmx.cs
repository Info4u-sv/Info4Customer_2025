using Info4U.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using WebService4u.Models;

namespace WebService4u
{
    /// <summary>
    /// Descrizione di riepilogo per WebService_primo
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Per consentire la chiamata di questo servizio Web dallo script utilizzando ASP.NET AJAX, rimuovere il commento dalla riga seguente. 
    [System.Web.Script.Services.ScriptService]
    public class WebService_primo : System.Web.Services.WebService
    {

        public static string TIMESTAMP_FORMAT = "yyyy-MM-ddTHH:mm:ss.fffZ";
        public static string TIMESTAMP_FORMAT_APP = "yyyy-MM-ddTHH:mm:ss.fffK";
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
        public void GetOfferteKingStat(int anno, string DocType)
        {
            //List<JsonOfferteKingStat> OfferteKingStats_List = JsonOfferteKingStat.GetJsonOfferteKingStats_List();
            //Dictionary<string, List<JsonOfferteKingStat>> OfferteKingStats_List = JsonOfferteKingStat.GetJsonOfferteKingStats_Dictionary();
            //List< JsonOfferteKingStat> OfferteKingStats_List = JsonOfferteKingStat.GetJsonOfferteKingStats_List();
            List<JsonOfferteKingStat> OfferteKingStats_List = JsonOfferteKingStat.GetStatsByYear(anno, DocType);
            this.Context.Response.Clear();
            this.Context.Response.ContentType = "application/json";
            this.Context.Response.Write(new JavaScriptSerializer().Serialize((object)OfferteKingStats_List));
            //foreach (JsonOfferteKingStat t in OfferteKingStats_List)
            //{
            //    this.Context.Response.ContentType = "application/json";
            //    this.Context.Response.Write(new JavaScriptSerializer().Serialize((object)t.ToString()));
            //}
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
        public void GetOfferteKingStat_Grouped(int Anno, string DocType)
        {

            //List<JsonOfferteKingStat> OfferteKingStats_List = JsonOfferteKingStat.GetJsonOfferteKingStats_List();
            //Dictionary<string, List<JsonOfferteKingStat>> OfferteKingStats_List = JsonOfferteKingStat.GetJsonOfferteKingStats_Dictionary();
            List<JSONOfferteKingStat_Group_AnnoMese> OfferteKingStats_List = JSONOfferteKingStat_Group_AnnoMese.GetGroupedList_AnnoMese(Anno, DocType);
            this.Context.Response.Clear();
            this.Context.Response.ContentType = "application/json";
            this.Context.Response.Write(new JavaScriptSerializer().Serialize((object)OfferteKingStats_List));
            //foreach (JsonOfferteKingStat t in OfferteKingStats_List)
            //{
            //    this.Context.Response.ContentType = "application/json";
            //    this.Context.Response.Write(new JavaScriptSerializer().Serialize((object)t.ToString()));
            //}
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public void GetStatsForDashboard(int Anno, string StatsType)
        {
            object Json = null;
            switch (StatsType)
            {
                case "Offerta":
                    Json = JsonOfferteBoxStats.GetOfferteStats(Anno);
                    break;
                case "Clienti":
                    Json = JsonClientiBoxStats.GetClientiStats();
                    break;
                case "Prospect":
                    Json = JsonProspectBoxStats.GetProspectStats();
                    break;
                case "Ordini":
                    Json = JsonOrdiniBoxStats.GetOrdiniStats(Anno);
                    break;
            }

            this.Context.Response.Clear();
            this.Context.Response.ContentType = "application/json";
            this.Context.Response.Write(new JavaScriptSerializer().Serialize((object)Json));
        }
        [WebMethod]
        public int converttodaysweb(int day, int month, int year)
        {
            DateTime dt = new DateTime(year, month, day);
            int datetodays = DateTime.Now.Subtract(dt).Days;
            return datetodays;

        }
        [WebMethod]
        public int Multiplication(int a, int b)
        {
            return (a * b);
        }
        [WebMethod]

        public int addTckCustomer(
          string CodCli,
          string OggettoTCK,
          string MotivoChiamata,
          int TCK_TipoRichiesta,
          int TCK_AreaCompetenza,
          int TCK_StatusChiamata,
          int TCK_PrioritaRichiesta,
          string NomePersonaRiferimento,
          string TelPersonaRiferimento,
          string MailPersonaRiferimento,
          string UserName
       )

        {
            int lastIdRapp = -1;
            try
            {
                TCK_Ticket_WS _rapportini = new TCK_Ticket_WS();
                TCK_ClienteDett _TCK_ClienteDett = new TCK_ClienteDett();
                _TCK_ClienteDett = _TCK_ClienteDett.TCK_ClienteDet_Get(CodCli);
                var appSettings = ConfigurationManager.AppSettings;

                _rapportini.Società = _TCK_ClienteDett.Denom;
                _rapportini.CodCliente = CodCli;
                _rapportini.Indirizzo = _TCK_ClienteDett.Ind;
                _rapportini.Cap = _TCK_ClienteDett.Cap;
                _rapportini.Località = _TCK_ClienteDett.Loc;
                _rapportini.Provincia = _TCK_ClienteDett.Prov;
                _rapportini.PIva = _TCK_ClienteDett.PIva;
                _rapportini.Telefono = _TCK_ClienteDett.Tel;
                _rapportini.Fax = _TCK_ClienteDett.Fax;
                _rapportini.Email = _TCK_ClienteDett.EMail;
                _rapportini.PersonaDaContattare = NomePersonaRiferimento;
                _rapportini.TCK_TipoRichiesta = TCK_TipoRichiesta;
                _rapportini.TCK_AreaCompetenza = TCK_AreaCompetenza;

                int TCK_TipoEsecuzionePresuntaDefault = Convert.ToInt32(appSettings["TCK_TipoEsecuzionePresuntaDefault"].ToString());

                _rapportini.TCK_TipoEsecuzionePresunta = TCK_TipoEsecuzionePresuntaDefault;
                _rapportini.TCK_TipoEsecuzione = TCK_TipoEsecuzionePresuntaDefault;
                _rapportini.TCK_StatusChiamata = 1;
                _rapportini.TCK_PrioritaRichiesta = TCK_PrioritaRichiesta;
                _rapportini.MotivoChiamata = MotivoChiamata;
                _rapportini.NomePersonaRiferimento = NomePersonaRiferimento;
                _rapportini.TelPersonaRiferimento = TelPersonaRiferimento;
                _rapportini.MailPersonaRiferimento = MailPersonaRiferimento;

                _rapportini.TCK_PrioritaRichiesta_etichetta = "";
                _rapportini.TCK_AreaCompetenza_etichetta = "";
                _rapportini.TCK_TipoRichiesta_etichetta = "";
                _rapportini.TCK_TipoEsecuzionePresunta_etichetta = "";
                _rapportini.TCK_TipoEsecuzione_etichetta = "";
                _rapportini.TCK_StatusChiamataChiusura = 1;
                _rapportini.TCK_StatusChiamataChiusura_Etichetta = "";
                _rapportini.InterventoChiuso = false;
                _rapportini.NoteTecnico = "";
                _rapportini.EditUser = UserName;
                _rapportini.InterventoPresso = "";
                _rapportini.OggettoTCK = OggettoTCK;
                lastIdRapp = _rapportini.InsertCOL_Rapportini(_rapportini);

            }
            catch (Exception ex)
            {
                lastIdRapp = -1;
                PRT_ErrorGest.ErrorLogSave(ex.ToString());

            }
            // SendMailAim(lastIdRapp, MailPersonaRiferimento);
            return lastIdRapp;
        }



        //[WebMethod]
        //// SendMail versione Ticket rimaneggiata per gestione tutte le tipologie di invii 25/05/2020 Simone
        //public void SendMailAimXtype(
        //    string from,
        //    string to,
        //    int CodRapportino,
        //    int TicketStatus_Template,
        //    string UserCrudTemplate,
        //    string MailTecnicoTemplate,
        //    string NomeTecnicoTemplate,
        //    int Attachments)
        //{
        //    TCK_Ticket_WS Rapportino = new TCK_Ticket_WS();
        //    Rapportino = Rapportino.DatiTestataTicket_Get(CodRapportino);
        //    TCK_Ticket_WS EtichetteRapportino = new TCK_Ticket_WS();
        //    EtichetteRapportino = EtichetteRapportino.EtichetteTicket_Get(CodRapportino);
        //    Rapportino.TCK_PrioritaRichiesta_etichetta = EtichetteRapportino.TCK_PrioritaRichiesta_etichetta;
        //    Rapportino.TCK_TipoRichiesta_etichetta = EtichetteRapportino.TCK_TipoRichiesta_etichetta;
        //    Rapportino.TCK_AreaCompetenza_etichetta = EtichetteRapportino.TCK_AreaCompetenza_etichetta;
        //    Rapportino.TCK_TipoEsecuzione_etichetta = EtichetteRapportino.TCK_TipoEsecuzione_etichetta;


        //    WEBS_MailGest GetMailTemplate = new WEBS_MailGest();
        //    GetMailTemplate = GetMailTemplate.MailTemplateCreate(Rapportino.CodRapportino, TicketStatus_Template, Rapportino.EditUser, Rapportino, MailTecnicoTemplate, NomeTecnicoTemplate, "internal");
        //    WEBS_MailGest.SendMailAimCore(from, to, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, "NoAttach", "Null");
        //}




        //// SendMail versione Ticket rimaneggiata per gestione tutte le tipologie di invii 25/05/2020 Simone
        //[WebMethod]
        //[ScriptMethod(UseHttpGet = false)]
        //public void SendMailDBTemplate(JsonEmail _jsonMail, string[] _ArrayParamList)
        //{
        //    string LogoMailwidth = ConfigurationManager.AppSettings["LogoMailwidth"];
        //    Portal4Set PortalConfig = new Portal4Set();
        //    string MailBody = PRT_Parameter.GetTemplateMail(_jsonMail.CodParametroTemplate);
        //    string MailFooter;
        //    string Company = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
        //    string CompanyPIva = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyPIva);
        //    string CompanyAddress = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyAddress);
        //    string CompanyCity = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyCity);
        //    string CompanyProvince = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyProvince);
        //    string Companymail = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyMail);
        //    string CompanyTel = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyTel);
        //    string SiteUrl = PortalConfig.GetConfigurationValue(Portal4Set.Settings.SiteUrl);


        //    string MailLogoTagTemplate = "<img src='{0}/img/logo-email.jpg' class='logo' title = '{1}' alt = '{2}' style='max-height: 140px; !important' width='{3}' /> ";
        //    string MailLogoM = string.Format(MailLogoTagTemplate, SiteUrl, Company, Company, LogoMailwidth);
        //    string URlBase = SiteUrl;
        //    MailFooter = string.Format("{0} - {1} - {2} ({3})", Company, CompanyAddress, CompanyCity, CompanyProvince);

        //    //var listparam = ((IEnumerable<JsonEmailArrayParam>)ArrayParam).ToList();
        //    //int i = 0;
        //    //foreach (JsonEmailArrayParam Param in listparam)
        //    //{
        //    //    MailBody = MailBody.Replace("{" + i + "}", Param.ArrayParam);
        //    //    i++;
        //    //}

        //    for (int i = 0; i < _ArrayParamList.Length; i++)
        //    {
        //        MailBody = MailBody.Replace("{" + i + "}", _ArrayParamList[i]);
        //    }

        //    string bodyConTemplate = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
        //                 "MailLogo", MailLogoM,
        //                "MailBody", MailBody,
        //                "MailFooter", MailFooter);


        //    WEBS_MailGest.SendMailAimCore(_jsonMail.from, _jsonMail.to, _jsonMail.OggettoMail, bodyConTemplate, "NoAttach", "Null");
        //    //return 1;
        //}



        [WebMethod]
        public void SendTicketMailAim(JsonEmail _jsonMail)
        {
            ////int status = -1;
            //try
            //{
            //    //PRT_ErrorGest.ErrorLogSave(IdAllegato);
            //    WEBS_MailGest.SendTicketMail(TicketId, TicketStatus, UserCrud, rapportini, MailTecnico, NomeTecnico, Responsabili, TipoAllegato, IdAllegato);
            //    //status = 1;
            //} catch (Exception ex)
            //{
            //    PRT_ErrorGest.ErrorLogSave(ex.ToString());
            //}
            ////return status;

        }


        //[WebMethod]
        //public void SendTicketMailAim1(int TicketId, int TicketStatus, string UserCrud, TCK_Ticket_WS rapportini, string MailTecnico, string NomeTecnico, bool Responsabili, string TipoAllegato, string IdAllegato)
        //{
        //    //int status = -1;
        //    try
        //    {
        //        //PRT_ErrorGest.ErrorLogSave(IdAllegato);
        //        WEBS_MailGest.SendTicketMail(TicketId, TicketStatus, UserCrud, rapportini, MailTecnico, NomeTecnico, Responsabili, TipoAllegato, IdAllegato);
        //        //status = 1;
        //    }
        //    catch (Exception ex)
        //    {
        //        PRT_ErrorGest.ErrorLogSave(ex.ToString());
        //    }
        //    //return status;

        //}



        // questa funzione non viene utilizzata
        //private void SendMailAim(int IdTck, string EmailCustomer, WEBS_MailGest GetMailTemplate)
        //{

        //    var mailMessage = new MimeMailMessage();
        //    string mailAddress = "web-help@info4u.it";
        //    string userTo = EmailCustomer;
        //    string subject = GetMailTemplate.MailSubject;
        //    string message = GetMailTemplate.MailBody;
        //    string host = "out.postassl.it";
        //    string userName = "web-help@info4usrl.it";
        //    string password = "1Nfo4you_1nf";
        //    mailMessage.From = new MimeMailAddress(mailAddress);
        //    mailMessage.To.Add(userTo);
        //    mailMessage.Subject = subject;
        //    mailMessage.Body = message;
        //    mailMessage.IsBodyHtml = true;
        //    //mailMessage.Attachments = 
        //    //Create Smtp Client
        //    var mailer = new MimeMailer(host, 465);
        //    mailer.User = userName;
        //    mailer.Password = password;
        //    mailer.SslType = SslMode.Ssl;
        //    mailer.AuthenticationMode = AuthenticationType.Base64;

        //    //Set a delegate function for call back
        //    mailer.SendCompleted += compEvent;
        //    mailer.SendMailAsync(mailMessage);

        //}
        private static void compEvent(object sender, AsyncCompletedEventArgs e)
        {
            if (e.UserState != null)
                Console.Out.WriteLine(e.UserState.ToString());

            Console.Out.WriteLine("is it canceled? " + e.Cancelled);

            if (e.Error != null)
                Console.Out.WriteLine("Error : " + e.Error.Message);
        }

        ////private void AllegatiTicketEdInvioMail(string from, string to, string subject, string body, TCK_Ticket GetTCK)
        ////{
        ////    ////List<UploadedFileInfo_1> resultFileInfos = new List<UploadedFileInfo_1>();
        ////    ////string description = "";
        ////    ////bool allFilesExist = true;

        ////    ////if (UploadedFilesStorage == null)
        ////    ////    UploadedFilesTokenBox.Tokens = new TokenCollection();

        ////    ////foreach (string fileName in UploadedFilesTokenBox.Tokens)
        ////    ////{
        ////    ////    UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
        ////    ////    FileInfo fileInfo = new FileInfo(demoFileInfo.FilePath);

        ////    ////    if (fileInfo.Exists)
        ////    ////    {
        ////    ////        demoFileInfo.FileSize = FormatSize(fileInfo.Length);
        ////    ////        resultFileInfos.Add(demoFileInfo);
        ////    ////    }
        ////    ////    else
        ////    ////        allFilesExist = false;
        ////    ////}

        ////    string FileAllegati = "/Public/AllegatiTCK/" + GetTCK.CodRapportino;
        ////    MembershipUser UserLog = Membership.GetUser();
        ////    Directory.CreateDirectory(Server.MapPath(FileAllegati));

        ////    MailMessage mail = new MailMessage();
        ////    mail = WEBS_MailGest.BuildMessageWith(from, to, subject, body);

        ////    int NumeroFile = 0;
        ////    foreach (UploadedFileInfo_1 fileInfo in resultFileInfos)
        ////    {
        ////        NumeroFile += 1;
        ////        string filename = fileInfo.OriginalFileName;
        ////        string[] EstensioneFile = filename.Split('.');
        ////        filename = filename.Replace("." + EstensioneFile[1], "") + "_" + NumeroFile + "." + EstensioneFile[1];
        ////        string path = FileAllegati + "/" + filename;

        ////        if (!File.Exists(Server.MapPath(path)))
        ////            File.Copy(fileInfo.FilePath, Server.MapPath(path));
        ////        PRT_Documenti InsertDoc = new PRT_Documenti();
        ////        InsertDoc.CodCli = GetTCK.CodCli;
        ////        InsertDoc.IDTicket = GetTCK.CodRapportino;
        ////        InsertDoc.DisplayName = filename;
        ////        InsertDoc.Description = GetTCK.OggettoTCK; //descrizione del ticket;

        ////        InsertDoc.FileName = filename.Replace("." + EstensioneFile[1], "");
        ////        InsertDoc.FileExtension = "." + EstensioneFile[1];
        ////        InsertDoc.CreatedUser = UserLog.UserName;
        ////        InsertDoc.PathFolder = path;
        ////        InsertDoc.PRT_DocumentiTCK_Insert(InsertDoc);
        ////        mail.Attachments.Add(new System.Net.Mail.Attachment(Server.MapPath(path), MimeMapping.GetMimeMapping(fileInfo.OriginalFileName)));


        ////    }

        ////    EmailUtility.SendMailEmbedImgV2(mail);

        ////    //ASPxEdit.ClearEditorsInContainer(FormLayout, true);
        ////}

    }
}
