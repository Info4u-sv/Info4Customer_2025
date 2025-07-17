using info4lab.Portal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Descrizione di riepilogo per TCK_EmailGest_BozzaOrdine_v2
/// </summary>
/// 
namespace INTRA.Age_Ordini.AppCode
{

    public class TCK_EmailGest_BozzaOrdine_v2
    {
        public string MailBody { get; set; }
        public string MailSubject { get; set; }
        public TCK_EmailGest_BozzaOrdine_v2()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }
        public static void SendTicketMail(int TicketId, int TicketStatus, string UserCrud, TCK_Ticket_v2 rapportini, string MailTecnico, string NomeTecnico)
        {
            string EmailaCuiInviareVar = "";
            try
            {
                TCK_EmailGest_BozzaOrdine_v2 GetMailTemplate = new TCK_EmailGest_BozzaOrdine_v2();
                //if (TicketStatus == 8)
                //{
                //    GetMailTemplate = GetMailTemplate.MailTemplateCreate(TicketId, 2, UserCrud, rapportini, MailTecnico, NomeTecnico);
                //}
                //else
                //{

                GetMailTemplate = GetMailTemplate.MailTemplateCreate(TicketId, TicketStatus, UserCrud, rapportini, MailTecnico, NomeTecnico);
                //}

                //creo la mail da inviare ai resposabili
                Portal4Set PortalConfig = new Portal4Set();
                string FileAbsolutePathTckPreview = HttpContext.Current.Server.MapPath(rapportini.LinkTckPdf);
                string currentRespEmail = "";
                //switch (TicketStatus)
                //{
                //    // qui definisco il template della mail
                //    case 1: //Aperto

                //        break;
                //    case 2: //Assegnato

                //        // invio la mail al tecnico
                //        EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                //        break;
                //    case 3: //In lavorazione

                //        break;
                //    case 4: //Chiuso



                //        //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);
                //        break;
                //    case 5: //Chiuso necessario nuovo intervento

                //        //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);

                //        break;
                //    case 6: //Annullato

                //        break;
                //    case 7: //Inviato 

                //        EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, FileAbsolutePathTckPreview);
                //        break;
                //    case 8: //invio Capo Area 
                //        TicketStatus = rapportini.TCK_StatusChiamata;
                //        break;
                //    case 9:
                //        EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                //        break;
                //}



                if (string.IsNullOrEmpty(rapportini.TckInviatoA))
                { // qui ciclo per invio della mail 
                  //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), "alessio.d@info4u.it", GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                    string queryString = "SELECT * FROM [U_EmailInvioStatusAreaTicket] where [IdAreaAss] = {0} and [IdStatus] = {1}";
                    queryString = string.Format(queryString, rapportini.TCK_AreaCompetenza, TicketStatus);
                    string connectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ToString();
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
                                EmailaCuiInviareVar = "Amministrazione";
                                currentRespEmail = reader["Email"].ToString();
                                //if (TicketStatus >= 4)
                                //{
                                //    EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody, FileAbsolutePathTckPreview);
                                //}
                                //else
                                //{
                                EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), currentRespEmail, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                                //}
                            }
                        }
                        catch (ArgumentOutOfRangeException ex)
                        {
                            //show error message
                        }
                        catch (Exception ex)
                        {
                            //show error message
                        }
                    }
                }
                else
                {
                    if (!string.IsNullOrEmpty(rapportini.EmailTecnicoPerCliente))
                    {
                        EmailUtility.SendMail(rapportini.EmailTecnicoPerCliente, rapportini.TckInviatoA, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                    }
                    else
                    {
                        EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, GetMailTemplate.MailSubject, GetMailTemplate.MailBody);
                    }
                }

            }

            catch (Exception ex)
            {
                string filePath = @"~/Error.txt";
                // string ex = "test";
                using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePath), true))
                {
                    writer.WriteLine("Errore :" + ex.ToString() + " Ticket: " + TicketId + "Date :" + DateTime.Now.ToString() + " " + Environment.NewLine);
                    writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                }
            }
        }
        public TCK_EmailGest_BozzaOrdine_v2 MailTemplateCreate(int TicketId, int TicketStatus, string UserCrud, TCK_Ticket_v2 rapportini, string MailTecnico, string NomeTecnico)
        {
            TCK_EmailGest_BozzaOrdine_v2 _RetObj = new TCK_EmailGest_BozzaOrdine_v2();

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
            string URlBase = PortalConfig.GetConfigurationValue(Portal4Set.Settings.SiteUrl);
            MailFooter = string.Format("{0} - {1} - {2} ({3})", Company, CompanyAddress, CompanyCity, CompanyProvince);


            //ottengo il nome dei responsabili dell'area a cui appartiene l'intervento appena inserito e invio loro la mail         
            string currentRespEmail = "";
            string ColorTit = "Green";
            switch (rapportini.TCK_PrioritaRichiesta)
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
            Ordini_Crud_v2 MyOrder = new Ordini_Crud_v2();
            List<Ordini_Crud_v2> MyOrderItems = new List<Ordini_Crud_v2>();
            MyOrderItems = MyOrder.U_ArticoliOrdiniBozze_Get(rapportini.CodRapportino);
            //Testata Richiesta
            BodyM += string.Format(DivT, 25, "", "blue", "<b>Ordine Bozza Numero: </b>" + rapportini.CodRapportino);
            BodyM += string.Format(DivT, 20, "", "blue", "<b>Agente: </b>" + rapportini.EditUser);
            BodyM += string.Format(DivT, 20, "", "blue", "<b>Cliente: </b>" + rapportini.Società);
            BodyM += string.Format(DivT, 20, "", "blue", "<b>In data: </b>" + rapportini.DataIns);
            BodyM += string.Format(DivT, 15, "", "blue", "<b>Note: </b>" + rapportini.Note.Replace("\n", "<br /> "));
            if (!string.IsNullOrEmpty(rapportini.TckInviatoA))
            {

                BodyM += "<br />";
                BodyM += "<br /><span >Dettaglio Bozza Ordine</span><br />";
                BodyM += "<table border='1' cellpadding='3'";
                BodyM += "style='border-collapse:collapse'>";
                BodyM += "<tr style='background-color:#F0F0F0'>";
                BodyM += "  <th>codice</th>";
                BodyM += "  <th>descrizione</th>";
                BodyM += "  <th>note</th>";
                BodyM += "  <th>Qta</th>";
                BodyM += "  <th>prezzo</th>";
                BodyM += "  <th>subtotale</th>";
                BodyM += "</tr>";
                decimal OrderAmount = 0;
                //i = 0;
                for (int i = 0; i <= MyOrderItems.Count - 1; i++)
                {
                    OrderAmount = OrderAmount + Convert.ToDecimal(Math.Round(MyOrderItems[i].Importo * 100) / 100);
                    BodyM += "<tr>";
                    BodyM += "  <td>" + MyOrderItems[i].CodArt + "</td>";
                    BodyM += "  <td>" + MyOrderItems[i].DescrizioneArticolo + "</td>";
                    BodyM += "  <td>" + MyOrderItems[i].Note + "</td>";
                    BodyM += "  <td style='text-align:right'>" + MyOrderItems[i].QtaOrdVar + "  </td>";
                    BodyM += "  <td style='text-align:right'>" + (Math.Round(MyOrderItems[i].Prezzo * 100) / 100).ToString("C", CultureInfo.CurrentCulture) + "  </td>";
                    BodyM += "  <td style='text-align:right'>" + (Math.Round(MyOrderItems[i].Importo * 100) / 100).ToString("C", CultureInfo.CurrentCulture) + " </td>";
                    BodyM += "</tr>";
                }
               //BodyM += "<tr>";
               //BodyM += "	<td colspan='4' style='text-align:right'>" + "Sub totale" + "</td>";
               //BodyM += "	<td style='text-align:right'>" + (Math.Round(OrderAmount * 100) / 100).ToString("C", CultureInfo.CurrentCulture) + "</td>";
               //BodyM += "</tr>";
               //BodyM += "<tr>";
               //BodyM += "	<td colspan='4' style='text-align:right'>" + "Trasporto" + "</td>";
               //BodyM += "	<td style='text-align:right'>" + MyOrder[0].Trasporto.ToString("C", CultureInfo.CurrentCulture) + "</td>";
               //BodyM += "</tr>";
               //BodyM += "<tr>";
               //BodyM += "	<td colspan='4' style='text-align:right'>" + "Iva" + "</td>";
               //BodyM += "	<td style='text-align:right'>" + MyOrder[0].iva.ToString("C", CultureInfo.CurrentCulture) + "</td>";
               //BodyM += "</tr>";
               //BodyM += "<tr>";
               //BodyM += "	<td colspan='4' style='text-align:right'>" + "Totale" + "</td>";
               //BodyM += "	<td style='text-align:right'>" + MyOrder[0].TotalAmount.ToString("C", CultureInfo.CurrentCulture) + "</td>";
               //BodyM += "</tr>";
                BodyM += "</table>";
                BodyM += string.Format(DivT, 20, "", "black", "</br><b>Il totale dell'ordine è di €" + OrderAmount + " </b></br></br>");

                if (rapportini.PrezzoA != 0)
                {
                    BodyM += string.Format(DivT, 15, "", "red", "<b>Il prezzo di trasporto è variato da €" + rapportini.PrezzoDa + " a €" + rapportini.PrezzoA + " </b>");
                }
                else
                {
                    if (rapportini.FlagPrezzoA)
                    {
                        BodyM += string.Format(DivT, 15, "", "red", "<b>Il prezzo di trasporto è di €" + rapportini.PrezzoA + "</b>");
                    }
                    else
                    {
                        BodyM += string.Format(DivT, 15, "", "red", "<b>Il prezzo di trasporto è di €" + rapportini.PrezzoDa + "</b>");
                    }
                }
                //if(rapportini.ScontoIncondizionato != 0)
                //{
                //    BodyM += string.Format(DivT, 15, "", "red", "<b>Lo sconto a voi riservato è del " + rapportini.ScontoIncondizionato + "%</b>");
                //}
            }
            //BodyM += string.Format(DivT, 15, "color:" + ColorTit + ";", "", "<b>Priorità: </b>" + rapportini.TCK_PrioritaRichiesta_etichetta);
            //BodyM += string.Format(DivT, 15, "", "darkorange", "<b>Tipo Richiesta: </b>" + rapportini.TCK_TipoRichiesta_etichetta);
            //BodyM += string.Format(DivT, 15, "", "sky", "<b>Area: </b>" + rapportini.TCK_AreaCompetenza_etichetta);
            //BodyM += string.Format(DivT, 15, "", "darkorange", "<b>Tipo Esecuzione: </b>" + rapportini.TCK_TipoEsecuzione_etichetta);
            string TestataBody = BodyM;
            //Testata Richiesta Fine

            //Corpo  Richiesta
            //BodyM += DivTEmpty;
            //BodyM += string.Format(DivT, 20, "", "darkorange", "<b>Motivo della chiamata:</b>");
            //BodyM += string.Format(DivT, 15, "", "", rapportini.MotivoChiamata);
            //BodyM += string.Format(DivT, 20, "", "darkorange", "<b>Note Tecnico:</b>");
            //BodyM += string.Format(DivT, 15, "", "", rapportini.NoteTecnico);
            //Corpo  Richiesta Fine

            // Società Richiedente 
            //BodyM += DivTEmpty;
            //string InterventoPresso = rapportini.InterventoPresso;
            //BodyM += string.Format(DivT, 20, "font-weight: bold;", "sky", "Richiedente: ");
            //BodyM += string.Format(DivT, 15, "font-weight: bold;", "", rapportini.Società + "<br/>" + rapportini.Telefono + "<br/>" + rapportini.Indirizzo + ", " + rapportini.Località + ", (" + rapportini.Cap + ")");
            //BodyM += string.Format(DivT, 20, "font-weight: bold;", "sky", "Intervento Presso: ");
            //BodyM += string.Format(DivT, 15, "font-weight: bold;", "", InterventoPresso);

            ////<div>< a href = '{0}' class='myButton {1}'>{2}</a></div>


            //BodyM += string.Format(ButtonTComp, "http://maps.google.com/?q=" + InterventoPresso, "Naviga");

            //BodyM += string.Format(ButtonTComp, "http://maps.google.com/?q=" + rapportini.Indirizzo + " " + rapportini.Località + " " + rapportini.Cap, "Naviga");
            // Società Richiedente Fine

            // Contatto Società
            BodyM += DivTEmpty;
            string NomeRef = rapportini.NomePersonaRiferimento;
            string TelRef = rapportini.TelPersonaRiferimento;
            string MailRef = rapportini.MailPersonaRiferimento;
            if (string.IsNullOrEmpty(NomeRef)) { NomeRef = ""; }
            //BodyM += string.Format(DivT, 20, "font-weight: bold;", "sky", "Contattare: " + NomeRef);
            ////BodyM += string.Format(DivT, 15, "font-weight: bold;", "", rapportini.Società + "<br/>" + rapportini.Telefono + "<br/>" + rapportini.Indirizzo + ", " + rapportini.Località + ", (" + rapportini.Cap + ")");
            //if (!(string.IsNullOrEmpty(TelRef) || TelRef == ""))

            //{
            //    TelRef = rapportini.Telefono;
            //    BodyM += string.Format(ButtonTComp1, "Tel:" + TelRef, "Chiama: " + TelRef);
            //}

            //if (!(string.IsNullOrEmpty(MailRef) || MailRef == ""))
            //{
            //    MailRef = rapportini.Email;
            //    BodyM += string.Format(ButtonTComp, "mailto:" + MailRef, MailRef);
            //}

            // Contatto Società Fine

            // Gestisci Richiesta

            //string LinkRichiesta = URlBase + "Brico_Ordini/Inserimento_Ordini.aspx?NOrd=" + TicketId + "&CodCli=" + rapportini.CodCli ;

            //BodyM += string.Format(ButtonTComp1, LinkRichiesta, "Gestisci Ordine");
            //// Gestisci Richiesta Fine         

            string body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                          "MailBody", BodyM,
                          "MailFooter", MailFooter);

            string MailSubject = "[Ordine Bozza] # " + rapportini.CodRapportino + "  INSERITO - Cli: " + rapportini.Società;

            string BodyChiusura = string.Format(DivT, 20, "", "sky", "<b>Conferma Chiusura Ticket: </b> <b>ticket # " + rapportini.CodRapportino + "</b>");
            BodyChiusura += string.Format(DivT, 15, "", "darkorange", "<b>Status Ticket: </b> <b>" + rapportini.TCK_StatusChiamataChiusura_Etichetta + "</b>");

            BodyChiusura += string.Format(DivT, 15, "font-weight: bold;", "", "Trova in allegato copia del rapportino.<br/>");

            //BodyChiusura = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
            //             "MailBody", BodyChiusura,
            //             "MailFooter", MailFooter);
            string FileAbsolutePathTckPreview = HttpContext.Current.Server.MapPath(rapportini.LinkTckPdf);
            string TitoloAssegna = "";

            switch (TicketStatus)
            {
                // qui definisco il template della mail
                case 1: //Aperto
                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " " + rapportini.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha inserito il <b>ticket # " + rapportini.CodRapportino + "</b>");
                    BodyM = TitoloAssegna + BodyM;
                    break;
                case 2: //Assegnato

                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "Ciao <b>" + NomeTecnico + "</b>, <b>" + UserCrud + "</b> ti ha assegnato il <b>ticket # " + rapportini.CodRapportino + "</b>");

                    string NoteTecnico = string.Format(DivT, 20, "font-weight: bold;", "sky", "Note Tecnico: ");
                    NoteTecnico += string.Format(DivT, 15, "font-weight: bold;", "", rapportini.NoteTecnico + "<br/>");
                    BodyM = TitoloAssegna + NoteTecnico + BodyM;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailBody", BodyM,
                         "MailFooter", MailFooter);
                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " Assegnato a " + NomeTecnico + " " + rapportini.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;
                    // invio la mail al tecnico
                    //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, MailSubject, body);
                    break;
                case 3: //In lavorazione
                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " in Lavorazione" + rapportini.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;

                    break;
                case 4: //Chiuso

                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " Status: " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;

                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportini.CodRapportino + "</b>");

                    body = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailBody", body,
                         "MailFooter", MailFooter);

                    //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);
                    break;
                case 5: //Chiuso necessario nuovo intervento
                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " Status: " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportini.CodRapportino + "</b>");

                    body = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailBody", body,
                         "MailFooter", MailFooter);
                    //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);

                    break;
                case 6: //Annullato
                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " Status: " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportini.CodRapportino + "</b>");

                    body = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailBody", body,
                         "MailFooter", MailFooter);
                    break;
                case 7: //Inviato 
                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " Status: " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;
                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "<b>" + UserCrud + "</b> ha " + rapportini.TCK_StatusChiamataChiusura_Etichetta + " il <b>ticket # " + rapportini.CodRapportino + "</b>");

                    body = TitoloAssegna + BodyChiusura;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailBody", body,
                         "MailFooter", MailFooter);
                    //EmailUtility.SendMailAttach(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), rapportini.TckInviatoA, MailSubject, body, FileAbsolutePathTckPreview);
                    break;
                case 9: //Modifica Note Tecnico

                    TitoloAssegna = string.Format(DivT, 20, "", "sky", "Ciao <b>" + NomeTecnico + "</b>, <b>" + UserCrud + "</b> ha modificato le note per il tecnico del <b>ticket # " + rapportini.CodRapportino + "</b>");

                    string NoteTecnico2 = string.Format(DivT, 20, "font-weight: bold;", "sky", "Note Tecnico: ");
                    NoteTecnico2 += string.Format(DivT, 15, "font-weight: bold;", "", rapportini.NoteTecnico + "<br/>");
                    BodyM = TitoloAssegna + NoteTecnico2 + BodyM;
                    body = EmailUtility.PrepareMailBodyWith("ResponsiveEmailTemplate.html",
                         "MailBody", BodyM,
                         "MailFooter", MailFooter);
                    MailSubject = "[TCK] # " + rapportini.CodRapportino + " Assegnato a " + NomeTecnico + " " + rapportini.TCK_PrioritaRichiesta_etichetta + " - Cli: " + rapportini.Società + " Area: " + rapportini.TCK_AreaCompetenza_etichetta;
                    // invio la mail al tecnico
                    //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(Portal4Set.Settings.PRTMail), MailTecnico, MailSubject, body);
                    break;


            }

            _RetObj.MailBody = body;
            _RetObj.MailSubject = MailSubject;


            return _RetObj;
        }

    }
}