﻿using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ticket
{
    public partial class Ticket_List : System.Web.UI.Page
    {
        string StChiam = "1";
        string Sts = "NON ASSEGNATI";
        string StChius;
        int Priorita;
        string xmlstring = "/TicketStatus.xml";

        public string VarStatusDescr { get; set; }

        public string VarStatusColor { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            ProfileBase MyProfile = ProfileBase.Create(UserLog.UserName, true);

            if (!IsPostBack)
            {
                string stChiamQuery = Request.QueryString["StChiam"];
                string stsQuery = Request.QueryString["Sts"];

                Session["StatusDa"] = null;
                Session["StatusA"] = null;
                Session["StatusChiamataSession"] = null;

                if (!string.IsNullOrEmpty(stChiamQuery))
                {
                    StChiam = stChiamQuery;

                    Session["StatusDa"] = StChiam;
                    Session["StatusA"] = StChiam;
                    Session["StatusChiamataSession"] = StChiam;

                    if (int.TryParse(StChiam, out int stChiamInt))
                    {
                        if (stChiamInt <= 3 && stsQuery == "TUTTI")
                        {
                            Session["StatusDa"] = 1;
                            Session["StatusA"] = 3;
                        }
                        else if (stChiamInt > 3)
                        {
                            Session["StatusDa"] = 7;
                            Session["StatusA"] = 7;
                            Session["StatusChiamataSession"] = 4;
                        }
                    }
                }

                if (Session["StatusChiamataSession"] == null)
                    Session["StatusChiamataSession"] = StChiam;

                using (var ctx = new ListaTicket_LINQDataContext())
                {
                    var anni = ctx.ListaTicket_View
              .Where(t => t.DataIns.HasValue)
              .Select(t => t.DataIns.Value.Year)
              .Distinct()
              .OrderByDescending(y => y)
              .ToList();

                    tokenAnni.Items.Clear();
                    foreach (var anno in anni)
                    {
                        tokenAnni.Items.Add(new ListEditItem(anno.ToString(), anno));
                    }

                    var currentYear = DateTime.Now.Year;
                    var defaultYearsString = $"{currentYear},{currentYear - 1}";

                    tokenAnni.Value = defaultYearsString;

                    // Salva anche in sessione
                    Session["AnniTicket"] = new List<int> { currentYear, currentYear - 1 };

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadGrid",
                        "Generic_CallbackPnl.PerformCallback();", true);
                }
            }
        }

        protected void Generic_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            MembershipUser UserLog = Membership.GetUser();
            ProfileBase MyProfile = ProfileBase.Create(UserLog.UserName, true);

            // Filtro per area competenza
            Generic_Grw.FilterExpression = string.Empty;
            GridViewColumn CollonnaAreaAss = Generic_Grw.Columns["TCK_AreaCompetenza"];
            if (MyProfile["AreaCompetenza"] != null)
            {
                if (!string.IsNullOrEmpty(MyProfile["AreaCompetenza"].ToString()))
                {
                    if (MyProfile["AreaCompetenza"].ToString() != "0")
                        Generic_Grw.AutoFilterByColumn(CollonnaAreaAss, MyProfile["AreaCompetenza"].ToString());
                }
            }

            if (!string.IsNullOrEmpty(e.Parameter))
            {
                // Split su virgola e parse degli anni
                var parts = e.Parameter.Split(',');
                var anni = parts
                            .Select(x => int.TryParse(x, out int y) ? y : 0)
                            .Where(y => y >= 1900)
                            .ToList();

                if (anni.Any())
                {
                    Session["AnniTicket"] = anni;
                }
                else
                {
                    // Se non sono anni validi
                    if (int.TryParse(e.Parameter, out int paramInt))
                    {
                        switch (paramInt)
                        {
                            case 0:
                                Session["StatusDa"] = 1;
                                Session["StatusA"] = 1;
                                Session["StatusChiamataSession"] = 1;
                                break;
                            case 1:
                                Session["StatusDa"] = 2;
                                Session["StatusA"] = 2;
                                Session["StatusChiamataSession"] = 2;
                                break;
                            case 2:
                                Session["StatusDa"] = 3;
                                Session["StatusA"] = 3;
                                Session["StatusChiamataSession"] = 3;
                                break;
                            case 3:
                                Session["StatusDa"] = 4;
                                Session["StatusA"] = 7;
                                Session["StatusChiamataSession"] = 4;
                                break;
                            case 4:
                                Session["StatusChiamataSession"] = null;
                                break;
                        }
                    }
                }
            }

            Generic_Grw.DataBind();
        }

        protected void Generic_Grw_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.DataColumn.FieldName == "MotivoChiamata")
                if (e.CellValue != null)
                    e.Cell.ToolTip = e.CellValue.ToString();
        }

        protected void Generic_Linq_Selecting(object sender, DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs e)
        {
            ListaTicket_LINQDataContext db = new ListaTicket_LINQDataContext();
            ListaTicket_View_Status_7DataContext db2 = new ListaTicket_View_Status_7DataContext();
            e.KeyExpression = "CodRapportino";

            List<int> anniSelezionati = new List<int> { DateTime.Now.Year }; // default
            if (Session["AnniTicket"] != null)
            {
                var sessionList = Session["AnniTicket"] as List<int>;
                if (sessionList != null && sessionList.Any())
                    anniSelezionati = sessionList;
            }

            int statusChiamataSession = 0;
            int statusDa = 0;
            int statusA = 0;

            if (Session["StatusChiamataSession"] != null)
                int.TryParse(Session["StatusChiamataSession"].ToString(), out statusChiamataSession);
            if (Session["StatusDa"] != null)
                int.TryParse(Session["StatusDa"].ToString(), out statusDa);
            if (Session["StatusA"] != null)
                int.TryParse(Session["StatusA"].ToString(), out statusA);

            if (statusChiamataSession == 0)
            {
                e.QueryableSource = from t in db.ListaTicket_View
                                    where t.DataIns.HasValue && anniSelezionati.Contains(t.DataIns.Value.Year)
                                    select new
                                    {
                                        t.TipoChiamata,
                                        t.AreaAss,
                                        t.PrioritaDescr,
                                        t.MotivoChiamata,
                                        t.Tecnico,
                                        t.StatusControlloRegistrazione,
                                        t.StatusControlloFatturazioneFinale,
                                        t.DataIns,
                                        t.Indirizzo,
                                        t.CodRapportino,
                                        t.Cap,
                                        t.Colore,
                                        t.ColoreArea,
                                        t.PrioritaColore,
                                        t.Provincia,
                                        t.TipoEsecColore,
                                        t.Località,
                                        t.Società,
                                        t.TipoEsecDescr,
                                        t.Descrizione,
                                        t.LabelClass,
                                        t.idStatus,
                                        t.TCK_AreaCompetenza,
                                        t.TCK_TipoRichiesta,
                                        t.TCK_PrioritaRichiesta,
                                        t.Note,
                                        t.NoteTecnico,
                                        t.InsertUser
                                    };
            }
            else if (statusChiamataSession < 4)
            {
                e.QueryableSource = from t in db.ListaTicket_View
                                    where t.TCK_StatusChiamata == statusA
                                          && t.DataIns.HasValue
                                          && anniSelezionati.Contains(t.DataIns.Value.Year)
                                    select new
                                    {
                                        t.TipoChiamata,
                                        t.AreaAss,
                                        t.PrioritaDescr,
                                        t.MotivoChiamata,
                                        t.Tecnico,
                                        t.StatusControlloRegistrazione,
                                        t.StatusControlloFatturazioneFinale,
                                        t.DataIns,
                                        t.Indirizzo,
                                        t.CodRapportino,
                                        t.Cap,
                                        t.Colore,
                                        t.ColoreArea,
                                        t.PrioritaColore,
                                        t.Provincia,
                                        t.TipoEsecColore,
                                        t.Località,
                                        t.Società,
                                        t.TipoEsecDescr,
                                        t.Descrizione,
                                        t.LabelClass,
                                        t.idStatus,
                                        t.TCK_AreaCompetenza,
                                        t.TCK_TipoRichiesta,
                                        t.TCK_PrioritaRichiesta,
                                        t.Note,
                                        t.NoteTecnico,
                                        t.InsertUser
                                    };
            }
            else if (statusChiamataSession == 4)
            {
                e.QueryableSource = from t in db2.ListaTicket_View_Status_7
                                    where t.TCK_StatusChiamata == statusA
                                          && t.DataIns.HasValue
                                          && anniSelezionati.Contains(t.DataIns.Value.Year)
                                    select new
                                    {
                                        t.TipoChiamata,
                                        t.AreaAss,
                                        t.PrioritaDescr,
                                        t.MotivoChiamata,
                                        t.Tecnico,
                                        t.StatusControlloRegistrazione,
                                        t.StatusControlloFatturazioneFinale,
                                        t.DataIns,
                                        t.Indirizzo,
                                        t.CodRapportino,
                                        t.Cap,
                                        t.Colore,
                                        t.ColoreArea,
                                        t.PrioritaColore,
                                        t.Provincia,
                                        t.TipoEsecColore,
                                        t.Località,
                                        t.Società,
                                        t.TipoEsecDescr,
                                        t.Descrizione,
                                        t.LabelClass,
                                        t.idStatus,
                                        t.TCK_AreaCompetenza,
                                        t.TCK_TipoRichiesta,
                                        t.TCK_PrioritaRichiesta,
                                        t.Note,
                                        t.NoteTecnico,
                                        t.InsertUser
                                    };
            }
        }


        protected void label_DataBound(object sender, EventArgs e)
        {
            ASPxLabel label = sender as ASPxLabel;
            label.Text = HighlightSearchText(label.Text, Generic_Grw.SearchPanelFilter);
        }
        public static string HighlightSearchText(string source, string searchText)
        {
            if (string.IsNullOrWhiteSpace(searchText))
                return source;
            var regex = new Regex(Regex.Escape(searchText), RegexOptions.IgnoreCase);
            if (regex.IsMatch(source))
                return string.Format("<span>{0}</span>", regex.Replace(source, "<span class='dxgvHL'>$0</span>"));
            return source;
        }

        protected void ASPxTabControl1_TabDataBound(object source, TabControlEventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["Sts"]))
            {
                Sts = Request.QueryString["Sts"];
            }

            ASPxTabControl1.ActiveTab = ASPxTabControl1.Tabs.FindByText(Sts.ToUpper());
        }
        public string GetImgUtente(object NomeAgente)
        {
            var returnImg = string.Empty;
            if (NomeAgente != null)
            {

                var Array = NomeAgente.ToString().Split('-');
                string converted = "";
                for (int i = 0; i < Array.Count(); i++)
                {
                    if (!string.IsNullOrEmpty(Array[i]))
                    {
                        ProfileBase MyProfile = ProfileBase.Create(Array[i], true);

                        returnImg += "<a href='#' data-toggle='tooltip' data-placement='top' data-original-title='" + Array[i] + "'> <img src='" + MyProfile["ImgTecnico"] + "' class='user-avatar ImmaginiProfili' style='height: 45px;' alt='" + Array[i] + "'/></a>";
                    }
                }

                if (string.IsNullOrEmpty(returnImg))
                {
                    returnImg = Convert.ToString("data:image/png;base64,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");
                }

            }
            return returnImg;
        }

        public string UnioneBase64(string args)
        {
            string finalString = args;
            string converted = finalString.Replace('-', '+');
            converted = converted.Replace('_', '/');
            converted = converted.Replace("data:image/png;base64,", "");
            converted = converted.Replace("data:image/jpeg;base64,", "");
            byte[] encodedByte = Convert.FromBase64String(converted);
            finalString = Encoding.Default.GetString(encodedByte).Replace(">", " ");
            return finalString;
        }

        protected void Generic_Grw_Init(object sender, EventArgs e)
        {

        }

        protected void Generic_Grw_DataBound(object sender, EventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();

            ProfileBase MyProfile = ProfileBase.Create(UserLog.UserName, true);
            if (!IsPostBack)
            {
                Session["StatusDa"] = null;
                Session["StatusA"] = null;
                Session["StatusChiamataSession"] = null;
                Session["StatusDa"] = StChiam;
                Session["StatusA"] = StChiam;
                if (Request.QueryString.Keys.Count > 0)
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["StChiam"]))
                    {
                        StChiam = Request.QueryString["StChiam"];
                    }
                    Session["StatusDa"] = StChiam;
                    Session["StatusA"] = StChiam;
                    Session["StatusChiamataSession"] = StChiam;
                    //if (!string.IsNullOrEmpty(Request.QueryString["StChius"]))
                    //{
                    //    StChius = Request.QueryString["StChius"];
                    //}
                    if (Convert.ToInt32(StChiam) <= 3 && Request.QueryString["Sts"] == "TUTTI")
                    {
                        Session["StatusDa"] = 1;
                        Session["StatusA"] = 3;
                        //GridViewColumn CollonnaIDStatus = Generic_Grw.Columns["idStatus"];
                        //Generic_Grw.DataColumns["idStatus"].Settings.AutoFilterCondition = AutoFilterCondition.LessOrEqual;
                        //Generic_Grw.AutoFilterByColumn(CollonnaIDStatus, "3");

                    }

                    if (!string.IsNullOrEmpty(Request.QueryString["Priorita"]))
                    {

                        //Priorita = Convert.ToInt32(Request.QueryString["Priorita"]);
                        // TCK_Ticket GetPrior = new TCK_Ticket();
                        //string DescrPrior = GetPrior.Priorita_Get(Priorita);
                        GridViewColumn ColonnaUrgenza = Generic_Grw.Columns["TCK_PrioritaRichiesta"];
                        Generic_Grw.AutoFilterByColumn(ColonnaUrgenza, Request.QueryString["Priorita"]);


                        //Generic_Grw.FilterExpression = "[PrioritaDescr] = '" + DescrPrior + "'";
                    }

                    if (Convert.ToInt32(StChiam) > 3)
                    {
                        Session["StatusDa"] = 7;
                        Session["StatusA"] = 7;
                        Session["StatusChiamataSession"] = 4;
                        TCK_Ticket StatusGet = new TCK_Ticket();
                        GridViewColumn ColonnaStatus = Generic_Grw.Columns["idStatus"];
                        Generic_Grw.AutoFilterByColumn(ColonnaStatus, StChiam);

                    }

                }
                if (Session["StatusChiamataSession"] == null)
                    Session["StatusChiamataSession"] = StChiam;
                GridViewColumn CollonnaArea = Generic_Grw.Columns["TCK_AreaCompetenza"];
                if (MyProfile["AreaCompetenza"] != null)
                {
                    if (!string.IsNullOrEmpty(MyProfile["AreaCompetenza"].ToString()))
                    {
                        if (MyProfile["AreaCompetenza"].ToString() != "0")
                            Generic_Grw.AutoFilterByColumn(CollonnaArea, MyProfile["AreaCompetenza"].ToString());
                    }
                }
            }

        }
    }
}