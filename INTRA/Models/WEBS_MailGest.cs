using System.Net.Mail;
using System.Web;
using info4lab.Portal;
using Info4U.Models;
using System.Configuration;
using System.ComponentModel;
using System;
using System.Data.SqlClient;
using Info4U;
using AegisImplicitMail;

namespace WebService4u.Models
{
    public class WEBS_MailGest
    {
        public string MailBody { get; set; }
        public string MailSubject { get; set; }
        public static MailMessage BuildMessageWith(string fromAddress, string toAddress, string subject, string body)
        {
            MailMessage message = new MailMessage
            {
                Sender = new MailAddress(fromAddress), // on Behave of When From differs
                From = new MailAddress(fromAddress),
                Subject = subject,
                SubjectEncoding = System.Text.Encoding.GetEncoding("UTF-8"),
                Body = body,
                BodyEncoding = System.Text.Encoding.GetEncoding("UTF-8"),
                IsBodyHtml = true,

            };

            string[] tos = toAddress.Split(';');

            foreach (string to in tos)
            {
                if (!string.IsNullOrEmpty(to))
                    message.To.Add(new MailAddress(to));
            }

            return message;
        }
        public WEBS_MailGest MailTemplateCreate(int TicketId, int TicketStatus, string UserCrud, TCK_Ticket_WS rapportino, string MailTecnico, string NomeTecnico, string TipoMail)
        {
            bool GestisciTicketBool = true;
            bool IntervetoPressoBool = true;
            bool NoteTecnicoBool = true;
            bool CustomerBool = false;
            switch (TipoMail)
            {
                case "customer":
                    {
                        GestisciTicketBool = false;
                        IntervetoPressoBool = false;
                        NoteTecnicoBool = false;
                        CustomerBool = true;
                        break;
                    }
                case "internal":
                    {
                        break;
                    }
                default:
                    {
                        break;
                    }
            }
            WEBS_MailGest _RetObj = new WEBS_MailGest();
            string LogoMailwidth = ConfigurationManager.AppSettings["LogoMailwidth"];
            //creo la mail da inviare ai resposabili
            Portal4Set PortalConfig = new Portal4Set();
            string MailFooter;
            string Company = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
            string CompanyPIva = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyPIva);
            string CompanyAddress = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyAddress);
            string CompanyCity = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyCity);
            string CompanyProvince = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyProvince);
            string Companymail = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyMail);
            string CompanyTel = PortalConfig.GetConfigurationValue(Portal4Set.Settings.CompanyTel);
            string SiteUrl = PortalConfig.GetConfigurationValue(Portal4Set.Settings.SiteUrl);


            string MailLogoTagTemplate = "<img src='{0}/img/logo-email.jpg' class='logo' title = '{1}' alt = '{2}' style='max-height: 140px; !important' width='{3}' /> ";
            string MailLogoM = string.Format(MailLogoTagTemplate, SiteUrl, Company, Company, LogoMailwidth);
            string URlBase = SiteUrl;
            MailFooter = string.Format("{0} - {1} - {2} ({3})", Company, CompanyAddress, CompanyCity, CompanyProvince);


            //ottengo il nome dei responsabili dell'area a cui appartiene l'intervento appena inserito e invio loro la mail         
            string currentRespEmail = "";
            string ColorTit = "Green";
            switch (rapportino.TCK_PrioritaRichiesta)
            {
                case 1:
                    ColorTit = "Green";
                    break;
                case 2:
                    ColorTit = "Orange";
                    break;
                case 3:
                    ColorTit = "Red";
                    break;
                default:
                    ColorTit = "Green";
                    break;
            }
            // Template Stringhe 
            string DivT = "<div style='font-size: {0}px; {1}' class='{2}'>{3}</div>";
            string DivTEmpty = "<div style='font-size: 20px;' >&nbsp;</div>";
            string ButtonT = " <div><a href = '{0}' class='myButton {1}'>{2}</a></div>";
            string ButtonTComp = @"<div><!--[if mso]><v:roundrect xmlns:v = ""urn:schemas-microsoft-com:vml"" xmlns: w = ""urn:schemas-microsoft-com:office:word"" href = ""{0}"" style = ""height:36px;v-text-anchor:middle;width:250px;"" arcsize = ""5%"" strokecolor = ""#EB7035"" fillcolor = ""#EB7035""><w:anchorlock/><center style = ""color:#ffffff;font-family:Helvetica, Arial,sans-serif;font-size:16px;"" > {1} &nbsp;&rarr;</center></v:roundrect><![endif]--><a href = ""{0}"" style = ""background-color:#EB7035;border:1px solid #EB7035;border-radius:3px;color:#ffffff;display:inline-block;font-family:sans-serif;font-size:16px;line-height:44px;text-align:center;text-decoration:none;width:250px;-webkit-text-size-adjust:none;mso-hide:all;"" > {1} &nbsp;&rarr;</a></div>";
            string ButtonTComp1 = @"<div><!--[if mso]><v:roundrect xmlns:v = ""urn:schemas-microsoft-com:vml"" xmlns: w = ""urn:schemas-microsoft-com:office:word"" href = ""{0}"" style = ""height:36px;v-text-anchor:middle;width:250px;"" arcsize = ""5%"" strokecolor = ""#35b0eb"" fillcolor = ""#35b0eb""><w:anchorlock/><center style = ""color:#ffffff;font-family:Helvetica, Arial,sans-serif;font-size:16px;"" > {1} &nbsp;&rarr;</center></v:roundrect><![endif]--><a href = ""{0}"" style = ""background-color:#35b0eb;border:1px solid #35b0eb;border-radius:3px;color:#ffffff;display:inline-block;font-family:sans-serif;font-size:16px;line-height:44px;text-align:center;text-decoration:none;width:250px;-webkit-text-size-adjust:none;mso-hide:all;"" > {1} &nbsp;&rarr;</a></div>";

            string BodyM = string.Empty;
            // Template Stringhe Fine

            //Testata Richiesta
            if (!CustomerBool)
            {
                BodyM += string.Format(DivT, 25, "", "red", "<b>Inserito da: </b>" + UserCrud);
                BodyM += string.Format(DivT, 20, "", "sky", "<b>Cliente: </b>" + rapportino.Società);
            }
            else
            {
                BodyM += string.Format(DivT, 25, "", "green", "<b>CHIAMATA APERTA DA: </b>" + UserCrud);
                BodyM += string.Format(DivT, 25, "", "green", "<b>per conto del Cliente: </b>" + rapportino.Società);
                BodyM += string.Format(DivT, 25, "", "green", "<hr>");
            }

            BodyM += string.Format(DivT, 15, "color:" + ColorTit + ";", "", "<b>Priorità: </b>" + rapportino.TCK_PrioritaRichiesta_etichetta);
            BodyM += string.Format(DivT, 15, "", "darkorange", "<b>Tipo Richiesta: </b>" + rapportino.TCK_TipoRichiesta_etichetta);
            BodyM += string.Format(DivT, 15, "", "sky", "<b>Area: </b>" + rapportino.TCK_AreaCompetenza_etichetta);
            if (!CustomerBool)
            {
                BodyM += string.Format(DivT, 15, "", "darkorange", "<b>Tipo Esecuzione: </b>" + rapportino.TCK_TipoEsecuzione_etichetta);
            }
            else
            {

            }
            string TestataBody = BodyM;
            //Testata Richiesta Fine

            // Oggetto Chiamata
            if (!string.IsNullOrEmpty(rapportino.OggettoTCK) && rapportino.OggettoTCK.ToString() != "")
            {
                BodyM += DivTEmpty;
                BodyM += string.Format(DivT, 20, "", "darkorange", "<b>Oggetto della chiamata:</b>");
                BodyM += string.Format(DivT, 15, "", "", rapportino.OggettoTCK);
            }
            //Corpo  Richiesta
            //BodyM += DivTEmpty;
            BodyM += string.Format(DivT, 20, "", "darkorange", "<b>Motivo della chiamata:</b>");
            BodyM += string.Format(DivT, 15, "", "", rapportino.MotivoChiamata);
            if (NoteTecnicoBool)
            {
                BodyM += string.Format(DivT, 20, "", "darkorange", "<b>Note Tecnico:</b>");
                BodyM += string.Format(DivT, 15, "", "", rapportino.NoteTecnico);
            }
            if (CustomerBool)
            {
                var AllegatiVar = rapportino.Allegati.Split(';');

                BodyM += string.Format(DivT, 20, "", "darkorange", "<b>Allegati:</b>");

                for (int i = 0; i < AllegatiVar.Length; i++)
                {
                    BodyM += string.Format(DivT, 15, "", "", AllegatiVar[i]);
                }

            }

            //Corpo  Richiesta Fine

            // Società Richiedente 
            BodyM += DivTEmpty;
            string InterventoPresso = rapportino.InterventoPresso;
            BodyM += string.Format(DivT, 20, "font-weight: bold;", "sky", "Richiedente: ");
            //BodyM += string.Format(DivT, 15, "font-weight: bold;", "", rapportini.Società + "<br/>" + rapportini.Telefono + "<br/>" + rapportini.Indirizzo + ", " + rapportini.Località + ", (" + rapportini.Cap + ")");
            BodyM += string.Format(DivT, 15, "font-weight: bold;", "", rapportino.Società + "<br/>");
            if (IntervetoPressoBool)
            {
                BodyM += string.Format(DivT, 20, "font-weight: bold;", "sky", "Intervento Presso: ");
                BodyM += string.Format(DivT, 15, "font-weight: bold;", "", InterventoPresso);
                BodyM += string.Format(ButtonTComp, "http://maps.google.com/?q=" + InterventoPresso, "Naviga");
            }

            // Contatto Società
            BodyM += DivTEmpty;
            string NomeRef = rapportino.NomePersonaRiferimento;
            string TelRef = rapportino.TelPersonaRiferimento;
            string MailRef = rapportino.MailPersonaRiferimento;
            if (string.IsNullOrEmpty(NomeRef)) { NomeRef = ""; }
            BodyM += string.Format(DivT, 20, "font-weight: bold;", "sky", "Contattare: " + NomeRef);
            //BodyM += string.Format(DivT, 15, "font-weight: bold;", "", rapportini.Società + "<br/>" + rapportini.Telefono + "<br/>" + rapportini.Indirizzo + ", " + rapportini.Località + ", (" + rapportini.Cap + ")");
            if ((string.IsNullOrEmpty(TelRef) || TelRef == ""))
            {
                TelRef = rapportino.Telefono;
                BodyM += string.Format(ButtonTComp1, "Tel:" + TelRef, "Chiama: " + TelRef);
            }
            else
            {
                //TelRef = rapportini.Telefono;
                BodyM += string.Format(ButtonTComp1, "Tel:" + TelRef, "Chiama: " + TelRef);
            }
            if (!CustomerBool)
            {
                if (!(string.IsNullOrEmpty(MailRef) || MailRef == ""))
                {
                    MailRef = rapportino.Email;
                    BodyM += string.Format(ButtonTComp, "mailto:" + MailRef, MailRef);
                }
            }
            else
            {
                MailRef = rapportino.Email;
                BodyM += string.Format(ButtonTComp, "mailto:" + MailRef, MailRef);
            }
            // Contatto Società Fine

            // Gestisci Richiesta
            string LinkRichiesta = URlBase + "Ticket/Ticket_view.aspx?IdTicket=" + TicketId;
            if (GestisciTicketBool)
            {
                BodyM += string.Format(ButtonTComp1, LinkRichiesta, "Gestisci Ticket");
            }
            // Gestisci Richiesta Fine         

            string body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                           "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);

            string MailSubject = "[TCK] # " + rapportino.CodRapportino + " " + rapportino.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;

            //string BodyChiusura = string.Format(DivT, 20, "", "sky", "<b>Conferma Chiusura Ticket: </b> <b>ticket # " + rapportino.CodRapportino + "</b>");
            string BodyChiusura = "";

            BodyChiusura += string.Format(DivT, 20, "", "blue", "<b>Cliente: </b>" + rapportino.Società);
            BodyChiusura += string.Format(DivT, 15, "", "darkorange", "<b>Status Ticket: </b> <b>" + rapportino.TCK_StatusChiamataChiusura_Etichetta + "</b>");

            BodyChiusura += string.Format(DivT, 15, "font-weight: bold;", "", "Trova in allegato copia del rapportino.<br/>");

            //BodyChiusura = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
            //             "MailBody", BodyChiusura,
            //             "MailFooter", MailFooter);
            string FileAbsolutePathTckPreview = HttpContext.Current.Server.MapPath(rapportino.LinkTckPdf);
            string TitoloAssegna = "";
            string NoteTecnico = string.Empty;
            switch (TicketStatus)
            {
                // qui definisco il template della mail
                case 1: //Aperto
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " " + rapportino.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha inserito il <b>ticket # " + rapportino.CodRapportino + "</b>");
                    BodyM = TitoloAssegna + BodyM;
                    break;
                case 2: //Assegnato

                    //TitoloAssegna = string.Format(DivT, 20, "", "sky", "Ciao <b>" + NomeTecnico + "</b>, <b>" + UserCrud + "</b> ti ha assegnato il <b>ticket # " + rapportini.CodRapportino + "</b>");
                    if (rapportino.AssegnatoCalendTecnico)
                        TitoloAssegna = string.Format(DivT, 20, "", "sky", "Ciao <b>" + NomeTecnico + "</b>, <b>" + UserCrud + "</b> ti ha assegnato il <b>ticket # " + rapportino.CodRapportino + "</b> <br/><br/> Inserito appuntamento su Exchange per il giorno <b>" + rapportino.DataIntervento + "</b> dalle <b>" + rapportino.InizioIntervento + "</b> alle <b>" + rapportino.FineIntervento + "</b>");
                    else
                        TitoloAssegna = string.Format(DivT, 20, "", "sky", "Ciao <b>" + NomeTecnico + "</b>, <b>" + UserCrud + "</b> ti ha assegnato il <b>ticket # " + rapportino.CodRapportino + "</b>");

                    //TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha inserito il <b>ticket # " + rapportino.CodRapportino + " assegnato a " + NomeTecnico + "</b>");

                    NoteTecnico = string.Format(DivT, 20, "font-weight: bold;", "sky", "Note Tecnico: ");
                    NoteTecnico += string.Format(DivT, 15, "font-weight: bold;", "", rapportino.NoteTecnico + "<br/>");
                    BodyM = TitoloAssegna + NoteTecnicoBool + BodyM;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                        "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " Assegnato a " + NomeTecnico + " " + rapportino.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;
                    // invio la mail al tecnico
                    //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, MailSubject, body);
                    break;
                case 3: //In lavorazione
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " in Lavorazione" + rapportino.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;

                    break;
                case 4: //Chiuso

                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " Status: " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;

                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportino.CodRapportino + "</b>");

                    BodyM = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);

                    //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);
                    break;
                case 5: //Chiuso necessario nuovo intervento
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " Status: " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportino.CodRapportino + "</b>");

                    BodyM = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                        "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);
                    //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);

                    break;
                case 6: //Annullato
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " Status: " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportino.CodRapportino + "</b>");

                    BodyM = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);
                    break;
                case 7: //Inviato 
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " Status: " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportino.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportino.CodRapportino + "</b>");

                    BodyM = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);
                    //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);
                    break;

                case 8: //Capo area
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " " + rapportino.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;

                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha inserito il <b>ticket # " + rapportino.CodRapportino + "</b>");
                    if (!string.IsNullOrEmpty(NomeTecnico))
                    {
                        if (rapportino.AssegnatoCalendTecnico)
                            TitoloAssegna = string.Format(DivT, 20, "", "blue", "<b>" + UserCrud + "</b> ha inserito il <b>ticket # " + rapportino.CodRapportino + " assegnato a " + NomeTecnico + "</b>  <br/><br/> Inserito appuntamento su Exchange per il giorno <b>" + rapportino.DataIntervento + "</b> dalle <b>" + rapportino.InizioIntervento + "</b> alle <b>" + rapportino.FineIntervento + "</b>");
                        else
                            TitoloAssegna = string.Format(DivT, 20, "", "blue", "<b>" + UserCrud + "</b> ha inserito il <b>ticket # " + rapportino.CodRapportino + " assegnato a " + NomeTecnico + "</b>");

                    }

                    BodyM = TitoloAssegna + BodyM;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                       "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);
                    break;
                case 9: //Modifica Note Tecnico

                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "Ciao <b>" + NomeTecnico + "</b>, <b>" + UserCrud + "</b> ha modificato le note per il tecnico del <b>ticket # " + rapportino.CodRapportino + "</b>");

                    string NoteTecnico2 = string.Format(DivT, 20, "font-weight: bold;", "sky", "Note Tecnico: ");
                    NoteTecnico2 += string.Format(DivT, 15, "font-weight: bold;", "", rapportino.NoteTecnico + "<br/>");
                    BodyM = TitoloAssegna + NoteTecnico2 + BodyM;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailLogo", MailLogoM,
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);
                    MailSubject = "[TCK] # " + rapportino.CodRapportino + " Assegnato a " + NomeTecnico + " " + rapportino.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportino.Società + " Area: " + rapportino.TCK_AreaCompetenza_etichetta;
                    // invio la mail al tecnico
                    //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, MailSubject, body);
                    break;


            }

            _RetObj.MailBody = body;
            _RetObj.MailSubject = MailSubject;


            return _RetObj;
        }

        //internal static void SendMailAimCore(object p, string emailCustomer, string mailSubject, string mailBody, string v)
        //{
        //    throw new NotImplementedException();
        //}

        public static void SendTicketMail(int TicketId, int TicketStatus, string UserCrud, TCK_Ticket_WS rapportino, string MailDestinatario, string NomeTecnico, bool Responsabili, string TipoAllegato, string IdAllegato)
        {
            try
            {
                WEBS_MailGest GetMailTemplate = new WEBS_MailGest();
                if (rapportino.Customer)
                {
                    if (TicketStatus == 8)
                    {
                        GetMailTemplate = GetMailTemplate.MailTemplateCreate(TicketId, TicketStatus, UserCrud, rapportino, MailDestinatario, NomeTecnico, "customer");
                    }
                    else
                    {
                        GetMailTemplate = GetMailTemplate.MailTemplateCreate(TicketId, TicketStatus, UserCrud, rapportino, MailDestinatario, NomeTecnico, "customer");
                    }
                }
                else
                {

                    if (TicketStatus == 8)
                    {
                        GetMailTemplate = GetMailTemplate.MailTemplateCreate(TicketId, TicketStatus, UserCrud, rapportino, MailDestinatario, NomeTecnico, "internal");
                    }
                    else
                    {
                        GetMailTemplate = GetMailTemplate.MailTemplateCreate(TicketId, TicketStatus, UserCrud, rapportino, MailDestinatario, NomeTecnico, "internal");
                    }
                }
                //creo la mail da inviare ai resposabili
                Portal4Set PortalConfig = new Portal4Set();
                string FileAbsolutePathTckPreview = HttpContext.Current.Server.MapPath(rapportino.LinkTckPdf);
                string currentRespEmail = "";
                switch (TicketStatus)
                {
                    // qui definisco il template della mail
                    case 1: //Aperto

                        break;
                    case 2: //Assegnato

                        // invio la mail al tecnico
                        //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                        SendMailAimCore(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailDestinatario, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, TipoAllegato, IdAllegato);

                        break;
                    case 3: //In lavorazione

                        break;
                    case 4: //Chiuso



                        //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);
                        break;
                    case 5: //Chiuso necessario nuovo intervento

                        //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);

                        break;
                    case 6: //Annullato

                        break;
                    case 7: //Inviato 

                        // EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, FileAbsolutePathTckPreview);
                        SendMailAimCore(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailDestinatario, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, "Url", IdAllegato);
                        break;
                    case 8: //invio Capo Area 
                        TicketStatus = rapportino.TCK_StatusChiamata;

                        break;
                    case 9:
                        //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);

                        SendMailAimCore(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailDestinatario, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, TipoAllegato, IdAllegato);

                        //SendMailAimCore(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);

                        break;
                }


                // qui ciclo per invio della mail ai responsabili area per status
                if (Responsabili)
                {
                    string queryString = "SELECT * FROM [TCK_EmailInvioStatusAreaTicket] where [IdAreaAss] = {0} and [IdStatus] = {1}";
                    queryString = string.Format(queryString, rapportino.TCK_AreaCompetenza, TicketStatus);
                    string connectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ToString();
                    using (SqlConnection connection = new SqlConnection(
                               connectionString))
                    {
                        SqlCommand command = new SqlCommand(
                            queryString, connection);
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        try
                        {
                            while (reader.Read())
                            {
                                currentRespEmail = reader["Email"].ToString();
                                if (TicketStatus >= 4)
                                {
                                    //  EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, FileAbsolutePathTckPreview);
                                    SendMailAimCore(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, "Url", IdAllegato);
                                }
                                else
                                {
                                    //  EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                                    SendMailAimCore(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, TipoAllegato, IdAllegato);


                                }
                                // EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);

                            }
                        }
                        catch (ArgumentOutOfRangeException ex)
                        {
                            PRT_ErrorGest.ErrorLogSave(ex.ToString());
                        }
                        catch (Exception ex)
                        {
                            PRT_ErrorGest.ErrorLogSave(ex.ToString());
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                PRT_ErrorGest.ErrorLogSave(ex.ToString());
            }
        }

        // invio mail nuova procedura gestisce anche gli allegati tramite il campo SessionID 03/06/2020
        public static void SendMailAimCore(string fromAddress, string toAddress, string subject, string body, string TipoAllegato, string IdAllegato)
        {
            try
            {
                // funzione globale per l'invio delle mail al più basso livello 
                // va utilizzata per tutti gli invii 
                var mailMessage = new MimeMailMessage();
                string mailAddress = fromAddress;
                string userTo = toAddress;
                string subjectAim = subject;
                string message = body;
                // dati server SMTP
                string AIM_Host = PRT_Parameter.GetTemplateMail("AIMEX_Host");
                string AIM_Username = PRT_Parameter.GetTemplateMail("AIMEX_Username");
                string AIM_Password = PRT_Parameter.GetTemplateMail("AIMEX_Password");
                int AIM_PortSmtp = Convert.ToInt32(PRT_Parameter.GetTemplateMail("AIMEX_PortSmtp"));
                int AIMEX_SslMode = Convert.ToInt32(PRT_Parameter.GetTemplateMail("AIMEX_SslMode"));
                bool AIMEX_EnableImplicitSsl =Convert.ToBoolean(PRT_Parameter.GetTemplateMail("AIMEX_EnableImplicitSsl"));
                // Fine dati server SMTP
                mailMessage.From = new MimeMailAddress(mailAddress);
                mailMessage.To.Add(userTo);
                mailMessage.Subject = subjectAim;
                mailMessage.Body = message;
                mailMessage.IsBodyHtml = true;
                string SessionID = "";

                string AttachUrl = "";
                string Where_Sql = " 1 = 2";
                switch (TipoAllegato)
                {
                    case "NoAttach":

                        break;
                    case "IdTicket":
                        Where_Sql = "[IDTicket] = " + IdAllegato;
                        break;
                    case "IdSession":
                        Where_Sql = "[SessionID] = '" + IdAllegato + "'";
                        break;
                    case "Url":
                        PRT_ErrorGest.ErrorLogSave(ConfigurationManager.AppSettings["PathAssolutoIntranet"] + IdAllegato);
                        mailMessage.Attachments.Add(new MimeAttachment(ConfigurationManager.AppSettings["PathAssolutoIntranet"] + IdAllegato));
                       
                        
                        
                        //mailMessage.Attachments.Add(new MimeAttachment(IdAllegato));

                        break;
                    default:
                        AttachUrl = IdAllegato;
                        break;
                }



                if (TipoAllegato != "NoAttach")
                // gestire se è session o link diretto etc etc
                {
                    // allora bisogna allegare i File 
                    using (SqlConnection sqlConnection = WebUtils.GetSqlConnection())
                    {
                        sqlConnection.Open();
                        using (SqlCommand sqlCommand = new SqlCommand("\r\n SELECT * \r\n FROM [PRT_DocumentiTCK] \r\n  where " + Where_Sql, sqlConnection))
                        {

                            using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
                            {
                                while (sqlDataReader.Read())
                                {
                                    mailMessage.Attachments.Add(new MimeAttachment(ConfigurationManager.AppSettings["PathAssolutoIntranet"] + sqlDataReader["PathFolder"].ToString()));
                                }
                                sqlDataReader.Close();
                            }
                            sqlConnection.Close();
                        }
                    }

                }

                //mailMessage.Attachments = 
                //Create Smtp Client
                var mailer = new MimeMailer(AIM_Host, AIM_PortSmtp);
               
                mailer.User = AIM_Username;
                mailer.Password = AIM_Password;
                mailer.EnableImplicitSsl = true;
                mailer.SslType = (SslMode)AIMEX_SslMode;               
                mailer.AuthenticationMode = AuthenticationType.Base64;
                //Set a delegate function for call back

                mailer.SendCompleted += compEvent;
                mailer.SendMailAsync(mailMessage);
            }
            catch (Exception ex)
            {
                PRT_ErrorGest.ErrorLogSave(ex.ToString());
            }
        }
        private static void compEvent(object sender, AsyncCompletedEventArgs e)
        {
            if (e.UserState != null)
                Console.Out.WriteLine(e.UserState.ToString());

            Console.Out.WriteLine("is it canceled? " + e.Cancelled);


            if (e.Error != null)
            {
                Console.Out.WriteLine("Error : " + e.Error.Message);
                PRT_ErrorGest.ErrorLogSave("Error : " + e.Error.Message.ToString());
            }
        }
    }

}