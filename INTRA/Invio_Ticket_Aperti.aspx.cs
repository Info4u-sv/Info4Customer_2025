using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA
{
    public partial class Invio_Ticket_Aperti : System.Web.UI.Page
    {
        private Dictionary<int, string> areaIdToName = new Dictionary<int, string>
        {
            {1, "Sistemistica"},
            {2, "Gestionale"},
            {3, "Sviluppo"},
            {4, "Office Automation"},
            {5, "Laboratorio"}
        };

        private Dictionary<int, string> statoDescriptions = new Dictionary<int, string>
        {
            {1, "Aperto"},
            {2, "Assegnato"},
            {3, "In lavorazione"},
            {4, "Chiuso"},
            {5, "Chiuso con riserva"},
            {6, "Annullato"},
            {7, "Inviato"}
        };

        private string GetLabelStyle(int statoId)
        {
            switch (statoId)
            {
                case 1:
                    return "background-color:#df5138; color:white; ";
                case 2:
                    return "background-color:#ffce55; color:white; ";
                case 3:
                    return "background-color:#5db2ff; color:white; ";
                default:
                    return "background-color:white; color:black; display:inline-block;";
            }
        }

        private string GetAreaLabelStyleByArea(string areaAss)
        {
            switch (areaAss)
            {
                case "Sistemistica": return "style='color: #74c476; font-weight: bold;'";
                case "Gestionale": return "style='color: #ff9800; font-weight: bold;'";
                case "Sviluppo": return "style='color: #5db2ff; font-weight: bold;'";
                case "Office Automation": return "style='color: #ffce55; font-weight: bold;'";
                case "Laboratorio": return "style='color: #808080; font-weight: bold;'";
                default: return "style='color: black; font-weight: bold;'";
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PRT_Parameter param = new PRT_Parameter();

                bool MailClienteInvioAbilita = false;
                bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"], out MailClienteInvioAbilita);

                string baseUrl = param.GetPRT_ParameterStringByCode("UrlTicketAdmin");
                string mailbodyTemplate = param.GetPRT_ParameterStringByCode("TemplateListaTicketAperti");
                string imgTemplate = param.GetPRT_ParameterStringByCode("UrlDominioPerImgEmail");
                string footer = param.GetPRT_ParameterStringByCode("FooterEmail");
                string fromEmail = param.GetPRT_ParameterStringByCode("RmMailShop");
                string oggettoMail = "Elenco Ticket Aperti";

                // 1. Recupera ticket aperti, assegnato e in lavorazione
                var tickets = new List<(string CodRapportino, string DescrizioneArea, string Società, string OggettoTCK, string Tecnico, DateTime CreatedOn, int StatoId, string Stato)>();

                string queryTickets = @"
                    SELECT CodRapportino, AreaAss AS DescrizioneArea, Società, MotivoChiamata AS OggettoTCK, Tecnico, DataIns AS CreatedOn, idStatus AS StatoId, Descrizione AS Stato
                    FROM ListaTicket_View
                    WHERE idStatus IN (1,2,3)
                    ORDER BY AreaAss ASC, Descrizione ASC, DataIns DESC, CodRapportino DESC";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(queryTickets, conn))
                {
                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            tickets.Add((
                                reader["CodRapportino"].ToString(),
                                reader["DescrizioneArea"].ToString(),
                                reader["Società"].ToString(),
                                reader["OggettoTCK"].ToString(),
                                reader["Tecnico"].ToString(),
                                Convert.ToDateTime(reader["CreatedOn"]),
                                Convert.ToInt32(reader["StatoId"]),
                                reader["Stato"].ToString()
                            ));
                        }
                    }
                }

                if (tickets.Count == 0) return;

                // 2. Recupera email per area (ignora stato)
                var emailAreaDict = new Dictionary<string, List<string>>();

                string queryEmails = @"
                    SELECT DISTINCT IdAreaAss, Email
                    FROM TCK_EmailInvioStatusAreaTicket
                    WHERE Email IS NOT NULL AND LEN(Email) > 0";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(queryEmails, conn))
                {
                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int areaId = Convert.ToInt32(reader["IdAreaAss"]);
                            string areaName = areaIdToName.ContainsKey(areaId) ? areaIdToName[areaId] : null;
                            if (areaName == null) continue;

                            string emailList = reader["Email"].ToString();
                            var emails = emailList.Split(new[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries)
                                                  .Select(email => email.Trim())
                                                  .Distinct()
                                                  .ToList();

                            if (!emailAreaDict.ContainsKey(areaName))
                                emailAreaDict[areaName] = new List<string>();

                            emailAreaDict[areaName].AddRange(emails);
                            emailAreaDict[areaName] = emailAreaDict[areaName].Distinct().ToList();
                        }
                    }
                }

                // 3. Setup webservice e check connessione
                Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");
                string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");
                if (!string.IsNullOrEmpty(erroreConnessione))
                {
                    return;
                }

                // 4. Per ogni area, raggruppa ticket per stato e crea sezioni multiple
                foreach (var areaEntry in emailAreaDict)
                {
                    string area = areaEntry.Key;
                    List<string> destinatari = areaEntry.Value;

                    var ticketsPerStato = tickets
                        .Where(t => t.DescrizioneArea == area)
                        .GroupBy(t => t.StatoId)
                        .OrderBy(g => g.Key);

                    if (!ticketsPerStato.Any()) continue;

                    string listaTicketString = "";

                    foreach (var gruppo in ticketsPerStato)
                    {
                        int stato = gruppo.Key;
                        string nomeStato = statoDescriptions.ContainsKey(stato) ? statoDescriptions[stato] : $"Stato {stato}";

                        listaTicketString += $"<h3 {GetAreaLabelStyleByArea(area)}>Area {area} - Stato {nomeStato}</h3>";
                        listaTicketString += "<table border='1' cellpadding='5' cellspacing='0' style='border-collapse:collapse; width:100%;'>";
                        listaTicketString += "<thead><tr style='background-color:#f2f2f2;'>";
                        listaTicketString += "<th>Ticket</th><th>Cliente</th><th>Oggetto</th><th>Inserito</th><th>Stato</th><th>Tecnico</th></tr></thead><tbody>";

                        foreach (var ticket in gruppo)
                        {
                            listaTicketString += "<tr>";
                            listaTicketString += $"<td><a href='{baseUrl}{ticket.CodRapportino}'>{ticket.CodRapportino}</a></td>";
                            listaTicketString += $"<td>{ticket.Società}</td>";
                            listaTicketString += $"<td>{ticket.OggettoTCK}</td>";
                            listaTicketString += $"<td>{ticket.CreatedOn:dd/MM/yyyy}</td>";
                            listaTicketString += $"<td style='{GetLabelStyle(ticket.StatoId)}'>{ticket.Stato}</td>";
                            listaTicketString += $"<td>{ticket.Tecnico}</td>";
                            listaTicketString += "</tr>";
                        }

                        listaTicketString += "</tbody></table><br/><br/>";
                    }

                    string mailbody = string.Format(mailbodyTemplate, listaTicketString);
                    string body = EmailUtility.PrepareMailBodyWith(
                        "MasterEmailV2.html", "MailTitle", oggettoMail, "MailBody", mailbody, "MailFooter", footer, "UrlSite", imgTemplate, "Company", " ");

                    foreach (var emailDest in destinatari)
                    {
                        if (MailClienteInvioAbilita)
                        {
                            Ws.TestSendEmai(fromEmail, emailDest, body, oggettoMail);
                        }
                    }
                }
            }
        }
    }
}