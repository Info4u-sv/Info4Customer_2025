using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA
{
    public partial class Invio_Controllo_Fatturazione_Finale : System.Web.UI.Page
    {
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
        private string GetLabelStyle(string status)
        {
            switch (status)
            {
                case "Da Contratto":
                    return "background-color:#8cc474; color:white; ";
                case "Da Commessa":
                    return "background-color:#808080; color:white; ";
                case "Da Carnet":
                    return "background-color:#fb6e52; color:white; ";
                case "Da Definire":
                    return "background-color:#808080; color:white; ";
                case "Da Fatturare":
                    return "background-color:#df5138; color:white; ";
                case "In Garanzia":
                    return "background-color:#808080; color:white; ";
                case "Non Addebitabile":
                    return "background-color:#808080; color:white; ";
                case "Da Fatturare Parzialmente":
                    return "background-color:#5db2ff; color:white; ";
                case "Non Definito":
                    return "background-color:#2dc3e8; color:white; ";
                default:
                    return "background-color:white; color:black; display:inline-block;";
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MembershipUser User = Membership.GetUser(Context.User.Identity.Name);

                WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();
                PRT_Parameter parametersGest = new PRT_Parameter();

                string strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
                string strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "/");

                bool MailClienteInvioAbilita = false;
                bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"], out MailClienteInvioAbilita);

                _JsonEmail.from = parametersGest.GetPRT_ParameterStringByCode("RmMailShop");
                _JsonEmail.OggettoMail = "Controllo Fatturazione Finale";
                _JsonEmail.CodParametroTemplate = "TemplateListaFatturazioniNonControllate";
                string baseUrl = parametersGest.GetPRT_ParameterStringByCode("UrlFatturazioneNonControllate");

                string mailbodyTemplate = parametersGest.GetPRT_ParameterStringByCode(_JsonEmail.CodParametroTemplate);
                string imgTemplate = parametersGest.GetPRT_ParameterStringByCode("UrlDominioPerImgEmail");
                string footer = parametersGest.GetPRT_ParameterStringByCode("FooterEmail");

                string queryFatturazione = @"
SELECT DISTINCT TCK_TestataTicket.CodRapportino, TCK_TestataTicket.LinkTckPdf, TCK_TestataTicket.Società, TCK_TestataTicket.CodCli, TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura, TCK_TestataTicket.TotTecnici, TCK_TestataTicket.TempoInterventoTotale, TCK_TestataTicket.StatusCotrolloFatt, TCK_TestataTicket.LavoroEseguito, TCK_TestataTicket.DataIntervento, TCK_AreaCompetenza.LabelClass, TCK_AreaCompetenza.Descrizione, TCK_TecniciVsTicket_View.NameValues AS Utente, TCK_TipoChiusuraChiamata_1.Descrizione AS StatusFatt, TCK_TipoChiusuraChiamata_1.LabelClass AS Colore, TCK_StatusCotrolloFatt.LabelClass AS ColoreStatFatt, TCK_StatusCotrolloFatt.Descrizione AS DescrizioneStatusContrFatt, Tck_StatusControlloRegistrazione.Descrizione AS DescStatusRegistrazione, 0 AS CheckStatus, TCK_TestataTicket.NoteFatturazioneFinale, TCK_StatusCotrolloFatt.Id AS StatusFinaleFattura, TCK_TestataTicket.StatusControlloFatturazioneFinale, TCK_TestataTicket.UM, TCK_TestataTicket.TCK_AreaCompetenza, TCK_TipoEsecuzione.Descrizione AS TipoEsecuzione, TCK_TestataTicket.TCK_TipoEsecuzione, TCK_TestataTicket.TCK_StatusChiamataChiusura, CASE WHEN MaterialiUtilizzati.TotMateriali IS NULL THEN 0 ELSE MaterialiUtilizzati.TotMateriali END AS TotMateriali, TCK_TestataTicket.Note, (SELECT TCK_TipoChiusuraChiamata.Descrizione + CASE WHEN derivedtbl_1.IdProdotto IS NULL THEN '' ELSE ' - ' + derivedtbl_1.IdProdotto END + CASE WHEN CAST(ResiduoOre AS nvarchar) IS NULL THEN '' ELSE ' - ' + CAST(ResiduoOre AS nvarchar) END AS Expr1 FROM TCK_TipoChiusuraChiamata LEFT OUTER JOIN (SELECT Denom, CodCliente, IdProdotto, Totale, Totinterventi, ResiduoOre, U_CC, DataCar, U_Tipo_Assistenza FROM U_CarnetAttivi_KING_View WHERE (IdProdotto = TCK_TestataTicket.IDContrattoAssistenza) AND (U_CC = 0) AND (CodCliente = TCK_TestataTicket.CodCli)) AS derivedtbl_1 ON TCK_TipoChiusuraChiamata.TipoAssistenzaKING = derivedtbl_1.U_Tipo_Assistenza WHERE (TCK_TipoChiusuraChiamata.Id = TCK_StatusCotrolloFatt.Id)) AS StatusFattFinaleInfo,CAST(TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura AS NVARCHAR(10)) + CASE WHEN ISNULL(TCK_TestataTicket.IDContrattoAssistenza,'') <> '' THEN '-' + TCK_TestataTicket.IDContrattoAssistenza ELSE '' END AS IdTipologia FROM TCK_TestataTicket INNER JOIN TCK_AreaCompetenza ON TCK_TestataTicket.TCK_AreaCompetenza = TCK_AreaCompetenza.IdAreaAss INNER JOIN TCK_TecniciVsTicket_View ON TCK_TestataTicket.CodRapportino = TCK_TecniciVsTicket_View.CodRapportino INNER JOIN TCK_TipoChiusuraChiamata AS TCK_TipoChiusuraChiamata_1 ON TCK_TestataTicket.TCK_TipoChiusuraChiamataFattura = TCK_TipoChiusuraChiamata_1.Id INNER JOIN TCK_StatusCotrolloFatt ON TCK_TestataTicket.StatusCotrolloFatt = TCK_StatusCotrolloFatt.Id INNER JOIN Tck_StatusControlloRegistrazione ON TCK_TestataTicket.StatusControlloRegistrazione = Tck_StatusControlloRegistrazione.StatusControlloRegistrazione INNER JOIN TCK_TipoEsecuzione ON TCK_TestataTicket.TCK_TipoEsecuzione = TCK_TipoEsecuzione.Id LEFT OUTER JOIN (SELECT COUNT(CodRapportino) AS TotMateriali, CodRapportino FROM TCK_DettRicambiTicket GROUP BY CodRapportino) AS MaterialiUtilizzati ON TCK_TestataTicket.CodRapportino = MaterialiUtilizzati.CodRapportino WHERE (TCK_TestataTicket.StatusControlloFatturazioneFinale = 1) AND (TCK_TestataTicket.TCK_StatusChiamata = 4 OR TCK_TestataTicket.TCK_StatusChiamata = 5 OR TCK_TestataTicket.TCK_StatusChiamata = 7) AND (TCK_TestataTicket.TCK_StatusChiamataChiusura <> 6) AND (TCK_TestataTicket.CodCli <> 'C0000') AND (TCK_TestataTicket.CodCli <> 'C0312') ORDER BY TCK_TestataTicket.CodRapportino
";

                var listaFatturazioneFinale = new List<FatturazioneFinale>();
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(queryFatturazione, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var fatturazione = new FatturazioneFinale
                            {
                                CodRapportino = reader["CodRapportino"].ToString(),
                                DescrizioneArea = reader["Descrizione"].ToString(),
                                Società = reader["Società"].ToString(),
                                OggettoTCK = TruncateText(reader["LavoroEseguito"].ToString(), 500),
                                Tecnico = reader["Utente"].ToString(),
                                CreatedOn = Convert.ToDateTime(reader["DataIntervento"]),
                                Stato = reader["StatusFatt"].ToString(),
                                TempoTotale = reader["TempoInterventoTotale"].ToString(),
                                UM = reader["UM"].ToString()
                            };

                            listaFatturazioneFinale.Add(fatturazione);
                        }
                    }
                }

                if (listaFatturazioneFinale.Count == 0)
                    return;

                var emailAreaDict = new Dictionary<string, List<string>>();

                string queryEmails = @"
            SELECT DISTINCT IdAreaAss, Email
            FROM INFO4U_INTRA_2021.dbo.TCK_EmailInvioStatusAreaTicket
            WHERE Email IS NOT NULL AND LEN(Email) > 0 AND IdStatus = 8";

                using (SqlConnection conn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                using (SqlCommand cmd2 = new SqlCommand(queryEmails, conn2))
                {
                    conn2.Open();
                    using (SqlDataReader reader2 = cmd2.ExecuteReader())
                    {
                        while (reader2.Read())
                        {
                            int areaId = Convert.ToInt32(reader2["IdAreaAss"]);
                            string areaName = null;
                            if (areaId == 1) areaName = "Sistemistica";
                            else if (areaId == 2) areaName = "Gestionale";
                            else if (areaId == 3) areaName = "Sviluppo";
                            else if (areaId == 4) areaName = "Office Automation";
                            else if (areaId == 5) areaName = "Laboratorio";

                            if (areaName == null)
                                continue;

                            string emailList = reader2["Email"].ToString();
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

                Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap"); string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");
                if (!string.IsNullOrEmpty(erroreConnessione))
                {
                    return;
                }

                foreach (var areaEntry in emailAreaDict)
                {
                    string area = areaEntry.Key;
                    List<string> destinatari = areaEntry.Value;

                    var fatturazioniPerArea = listaFatturazioneFinale
                        .Where(t => t.DescrizioneArea == area)
                        .OrderBy(t => t.CreatedOn);

                    if (!fatturazioniPerArea.Any())
                        continue;

                    string listaFatturazioneString = "";

                    listaFatturazioneString += string.Format("<h3 {0}>Area {1}</h3>", GetAreaLabelStyleByArea(area), area);
                    listaFatturazioneString += "<table border='1' cellpadding='5' cellspacing='0' style='border-collapse:collapse; width:100%;'>";
                    listaFatturazioneString += "<thead><tr style='background-color:#f2f2f2;'>";
                    listaFatturazioneString += "<th style='text-align:left; font-weight:bold;'><strong>Cod</strong></th>";
                    listaFatturazioneString += "<th style='text-align:left;'>Cliente</th>";
                    listaFatturazioneString += "<th style='text-align:left;'>Oggetto</th>";
                    listaFatturazioneString += "<th style='text-align:left;'>Inserito</th>";
                    listaFatturazioneString += "<th style='text-align:left;'>Status Fatt</th>";
                    listaFatturazioneString += "<th style='text-align:left;'>Tecnico</th>";
                    listaFatturazioneString += "<th style='text-align:left;'>Tempo Totale</th>";
                    listaFatturazioneString += "</tr></thead><tbody>";

                    foreach (var fatturazione in fatturazioniPerArea)
                    {
                        listaFatturazioneString += "<tr>";
                        listaFatturazioneString += string.Format("<td><a href='{0}{1}'>{1}</a></td>", baseUrl, fatturazione.CodRapportino);
                        listaFatturazioneString += string.Format("<td>{0}</td>", fatturazione.Società);
                        listaFatturazioneString += string.Format("<td>{0}</td>", fatturazione.OggettoTCK);
                        listaFatturazioneString += string.Format("<td>{0:dd/MM/yyyy}</td>", fatturazione.CreatedOn);
                        listaFatturazioneString += string.Format("<td style='{0}'>{1}</td>", GetLabelStyle(fatturazione.Stato), fatturazione.Stato);
                        listaFatturazioneString += string.Format("<td>{0}</td>", fatturazione.Tecnico);
                        listaFatturazioneString += string.Format("<td>{0} {1}</td>", fatturazione.TempoTotale, fatturazione.UM);
                        listaFatturazioneString += "</tr>";
                    }

                    listaFatturazioneString += "</tbody></table><br/><br/>";

                    string mailbody = string.Format(mailbodyTemplate, listaFatturazioneString);

                    string body = EmailUtility.PrepareMailBodyWith(
                        "MasterEmailV2.html", "MailTitle", _JsonEmail.OggettoMail, "MailBody", mailbody, "MailFooter", footer, "UrlSite", imgTemplate, "Company", " ");

                    foreach (var emailDest in destinatari)
                    {
                        if (MailClienteInvioAbilita)
                        {
                            Ws.TestSendEmai(_JsonEmail.from, emailDest, body, _JsonEmail.OggettoMail);
                        }
                    }
                }
            }
        }
        private string TruncateText(string input, int maxLength)
        {
            if (string.IsNullOrEmpty(input)) return input;
            return input.Length > maxLength ? input.Substring(0, maxLength) + "..." : input;
        }
    }
}