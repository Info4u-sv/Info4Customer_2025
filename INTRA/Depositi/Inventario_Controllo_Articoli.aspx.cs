using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Depositi
{
    public partial class Inventario_Controllo_Articoli : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = @"SELECT        Clienti.Denom, U_I_Ind, U_I_Prov, U_I_Loc, U_I_Cap, Descrizione, U_UltimoControllo_Inventario
                                FROM            TabDep INNER JOIN
                                Clienti ON TabDep.CodCli = Clienti.CodCli
                                WHERE CodDep = '" + Request.QueryString["CodDep"] + "'";
                SqlDataReader reader = new Sql4Gestionale().ExecuteReader(query);
                if (reader.Read())
                {
                    string indirizzo = string.Format("{0} {1} {2} {3}", reader["U_I_Ind"], reader["U_I_Prov"], reader["U_I_Loc"], reader["U_I_Cap"]);
                    Dep_lbl.Text = "DEPOSITO: " + Request.QueryString["CodDep"] + " " + reader["Descrizione"];
                    Ind_lbl.Text = "INDIRIZZO DEPOSITO: " + indirizzo;
                    Cliente_lbl.Text = "SOCIETÀ: " + reader["Denom"] as string;
                    UltimoControllo_lbl.Text = reader["U_UltimoControllo_Inventario"] == DBNull.Value ? "ULTIMO CONTROLLO: ND" : "ULTIMO CONTROLLO: " + Convert.ToDateTime(reader["U_UltimoControllo_Inventario"]).ToString("g");
                }
                reader.Close();

                reader = new Sql4Gestionale().ExecuteReader("SELECT ISNULL(SUM(Qta),0) AS Qta FROM U_Ordine_Temp WHERE CodDep = @CodDep", new SqlParameter("@CodDep", Request["CodDep"]));
                int qtaOrd = 0;
                if (reader.Read())
                {
                    qtaOrd = Convert.ToInt32(reader["Qta"]);
                }
                Conferma_Ordine_Btn.ClientEnabled = qtaOrd > 0;
                Cancella_Ordine_Btn.ClientEnabled = qtaOrd > 0;
                Visualizza_Ordine_Btn.ClientEnabled = qtaOrd > 0;
                QtaOrd_Lbl.Text = "Quantità Ordine: " + qtaOrd;
                //_ = new Sql4Gestionale().ExecuteNonQuery("DELETE FROM U_Ordine_Temp");
            }
        }

        protected void Aggiungi_Inventario_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
            int VisibleIndex = 0;
            int Qta = 0;
            string[] Parametri = e.Parameter.Split(';');
            string ProductCod = string.Empty;
            string UM = string.Empty;

            if (Parametri.Count() > 1)
            {
                VisibleIndex = Convert.ToInt32(Parametri[0]);
                Qta = Convert.ToInt32(Parametri[1].ToString().Replace(".", ","));
                ProductCod = Lista_Articoli_Cv.GetCardValues(VisibleIndex, "CodArt").ToString();
                UM = Lista_Articoli_Cv.GetCardValues(VisibleIndex, "Misura").ToString();
                for (int j = 0; j < Lista_Articoli_Cv.VisibleCardCount; j++)
                {
                    if (Lista_Articoli_Cv.GetCardValues(j, "CodArt").ToString() == ProductCod)
                    {
                        VisibleIndex = j;
                    }
                }
            }

            string descrizione = Lista_Articoli_Cv.GetCardValues(VisibleIndex, "Descrizione").ToString();

            string CodDep = HttpContext.Current.Request["CodDep"];

            int verifica = Controllo(ProductCod, CodDep);

            if (verifica == -1)
            {
                Insert(CodDep, Qta, ProductCod, descrizione, UM);
            }
            else
            {
                Update(CodDep, Qta, ProductCod);
            }
        }

        protected static int Controllo(string MenuItemID, string CodDep)
        {
            //Verifico se nella tabella dell'invetario è già presente l'articolo e in tal caso ritorno la Q.tà
            int RetVal = -1;
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            string QueryTxt = @"SELECT Quantity      
                              FROM [U_ESK_Inventario]
                              where [ProductID] = '{0}' and U_CodDep = '{1}'";
            QueryTxt = string.Format(QueryTxt, MenuItemID, CodDep);
            SqlDataReader myReader = objSqlHelper.ExecuteReader(QueryTxt, objParams);
            if (myReader.HasRows)
            {
                while (myReader.Read())
                {
                    RetVal = Convert.ToInt32(myReader["Quantity"]);
                }
            }
            else { RetVal = -1; }
            myReader.Close();
            return RetVal;
        }

        protected void Insert(string CodDep, int Quantity, string MenuItemID, string ItemName, string UM)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[7];
            objParams[0] = new SqlParameter("@U_CodDep", CodDep);
            objParams[1] = new SqlParameter("@Quantity", Quantity);
            objParams[2] = new SqlParameter("@ProductID", MenuItemID);
            objParams[3] = new SqlParameter("@ProductName", ItemName);

            objParams[4] = new SqlParameter("@UM", UM);

            objParams[5] = new SqlParameter("@PrevCons", DateTime.Now.Date);

            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CodCli FROM TabDep WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            if (reader.Read())
            {
                objParams[6] = new SqlParameter("@CustomerID", reader["CodCli"]);
            }

            _ = objSqlHelper.ExecuteNonQuery("U_ESK_Inventario_Insert", objParams);
        }
        protected void Update(string CodDep, int Quantity, string MenuItemID)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@U_CodDep", CodDep);
            objParams[1] = new SqlParameter("@Quantity", Quantity);
            objParams[2] = new SqlParameter("@ProductID", MenuItemID);
            _ = objSqlHelper.ExecuteNonQuery("U_ESK_Inventario_Update", objParams);
        }

        protected void Invio_Email_Callback_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser u = Membership.GetUser(Context.User.Identity.Name);
            string CodDep = HttpContext.Current.Request["CodDep"];
            string msg = MailBodyCreate(CodDep);
            INTRA.AppCode.PRT_Parameter _objPrt = new INTRA.AppCode.PRT_Parameter();
            string footer = _objPrt.GetPRT_ParameterStringByCode("FooterEmail");
            string body = EmailUtility.PrepareMailBodyWith("MasterEmailV2.html", "MailTitle", "Conferma Inventario", "MailBody", "Utente: " + u.UserName + "<br/>" + msg, "MailFooter", footer, "UrlSite", "https://task4u.info4lab.it/", "Company", " ");
            //body.Replace("../static", UrlAssoluto);
            string mailfrom = u.Email;
            //string UrlDomino = _objPrt.GetPRT_ParameterStringByCode("RmUrlDominio");
            bool MailClienteInvioAbilita = false;
            bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"], out MailClienteInvioAbilita);
            Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");
            string query = string.Format("SELECT Email FROM U_Workflow_Email WHERE CodParam = (@CodParam)", "ConfermaInventario");
            SqlDataReader reader = new Info4U.Models.Sql4Helper().ExecuteReader(query, new SqlParameter() { ParameterName = "@CodParam", Value = "ConfermaInventario" });
            if (reader.Read())
            {
                foreach (string EmailCliente in reader["Email"].ToString().Split(','))
                {

                    string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");
                    string errorMessage = string.Empty;
                    if (string.IsNullOrEmpty(erroreConnessione))
                    {
                        //errorMessage = Ws.SendMailNoTemplateAttachByDb(mailfrom, EmailCliente, "", "", "Oggetto", "Messaggio", ArrayParam2, new byte[1], "1" + ".pdf", _objPrt.GetPRT_ParameterStringByCode("AIMEX_Username"), _objPrt.GetPRT_ParameterStringByCode("AIMEX_Password"));
                        if (MailClienteInvioAbilita)
                        {
                            Ws.TestSendEmai(mailfrom, EmailCliente, body, "Conferma Inventario");
                        }
                    }
                }
            }
            reader.Close();
            insertMovMag(CodDep);
            new Sql4Gestionale().ExecuteNonQuery("DELETE FROM U_ESK_Inventario WHERE U_CodDep = @CodDep", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            new Sql4Gestionale().ExecuteNonQuery("UPDATE TabDep SET U_UltimoControllo_Inventario = GETDATE() WHERE CodDep = @CodDep", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            reader = new Sql4Gestionale().ExecuteReader("SELECT U_UltimoControllo_Inventario FROM TabDep WHERE CodDep = @CodDep", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            if (reader.Read())
            {
                Invio_Email_Callback.JSProperties["cpDataControllo"] = Convert.ToDateTime(reader["U_UltimoControllo_Inventario"]).ToString("g");
            }
            reader.Close();
        }
        protected string MailBodyCreate(string CodDep)
        {
            _ = new List<Order>();
            string Cliente = "", CodArt, Descrizione, Ind_Dep = "", UM;
            int IdTestata = 0, Qta = 0;
            string query = string.Format(@"SELECT        TabDep.CodDep, TabDep.CodCli, TabDep.U_I_NotePosizione, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_I_DsNaz, Clienti.Denom
FROM            TabDep INNER JOIN
                         Clienti ON TabDep.CodCli = Clienti.CodCli
						 WHERE (CodDep = @CodDep)", CodDep);
            SqlDataReader reader = new Info4U.Models.Sql4Gestionale().ExecuteReader(query, new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            if (reader.Read())
            {
                Cliente = reader["Denom"] as string;
                CodDep = reader["CodDep"] as string;
                Ind_Dep = string.Format("{0} {1} {2} {3} {4} {5}", reader["U_I_Ind"], reader["U_I_Loc"], reader["U_I_Prov"], reader["U_I_Cap"], reader["U_I_DsNaz"], reader["U_I_NotePosizione"]);
            }
            _ = new List<OrderItem>();

            string EmailBody = string.Empty;
            _ = Cliente;
            //EmailBody += "Conferma Ordine No.  " + MyOrder[0].OrderID + "";
            //EmailBody += "<br/><br/>";
            EmailBody += "Data: " + DateTime.Now.ToString("D") + "<br/>";
            EmailBody += "Cliente: " + Cliente + "<br/></b>";
            EmailBody += "Deposito: " + CodDep + "<br/></b>";
            EmailBody += "Indirizzo Deposito: " + Ind_Dep + "<br/></b>";
            EmailBody += "<br />";
            EmailBody += "<span ><b>Inventario</b></span>";
            EmailBody += "<table border='1' cellpadding='3'";
            EmailBody += "style='border-collapse:collapse'>";
            EmailBody += "<tr style='background-color:#F0F0F0'>";
            EmailBody += "  <th>CodArt</th>";
            EmailBody += "  <th>Descrizione</th>";
            EmailBody += "  <th>Quantità Minima</th>";
            EmailBody += "  <th>Quantita Effettiva</th>";
            EmailBody += "  <th>Unità di misura</th>";
            EmailBody += "</tr>";
            Thread.CurrentThread.CurrentCulture = new CultureInfo("it-IT", false);
            query = string.Format(@"SELECT   DISTINCT     Articoli.Descrizione, U_ESK_Inventario.Quantity, U_ESK_Inventario.UM, Articoli.CodArt, U_Inventario_Deposito.Qta_Min
FROM            Articoli INNER JOIN
                         U_ESK_Inventario ON Articoli.CodArt = U_ESK_Inventario.ProductID LEFT OUTER JOIN
                         U_Inventario_Deposito ON Articoli.CodArt = U_Inventario_Deposito.CodArt
WHERE        (U_ESK_Inventario.U_CodDep = @CodDep)", CodDep);
            reader = new Info4U.Models.Sql4Gestionale().ExecuteReader(query, new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            while (reader.Read())
            {
                CodArt = reader["CodArt"] as string;
                Qta = Convert.ToInt32(reader["Quantity"]);
                UM = reader["UM"] as string;
                int Qta_Min = Convert.ToInt32(reader["Qta_Min"]);
                Descrizione = reader["Descrizione"] as string;
                EmailBody += "<tr>";
                EmailBody += "  <td>" + CodArt + "</td>";
                EmailBody += "  <td>" + Descrizione + "</td>";
                EmailBody += "  <td style='text-align:right'>" + Qta_Min + "</td>";
                EmailBody += "  <td style='text-align:right'>" + Qta + "</td>";
                EmailBody += "  <td>" + UM + "  </td>";
                EmailBody += "  </td>";
                EmailBody += "</tr>";
            }
            EmailBody += "</tr>";
            EmailBody += "</table>";
            EmailBody += string.Empty;
            SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();

            return EmailBody;
        }

        protected string MailBodyCreateOrdine(string OrdNum)
        {
            _ = new List<Order>();
            string CodCli = "", CodArt, UM, Descrizione, Deposito = "", Ind_Dep = "";
            int IdTestata = 0, Qta = 0;
            string query = string.Format(@"SELECT        U_I_OrdCliTest.CodCli, U_I_OrdCliTest.ID, U_I_OrdCliTest.Deposito, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_I_NotePosizione, TabDep.U_I_DsNaz
FROM            U_I_OrdCliTest LEFT OUTER JOIN
                         TabDep ON U_I_OrdCliTest.Deposito = TabDep.CodDep
WHERE        (U_I_OrdCliTest.OrdNum = @OrdNum)", OrdNum);
            SqlDataReader reader = new Info4U.Models.Sql4Gestionale().ExecuteReader(query, new SqlParameter() { ParameterName = "@OrdNum", Value = OrdNum });
            if (reader.Read())
            {
                CodCli = reader["CodCli"] as string;
                IdTestata = Convert.ToInt32(reader["ID"]);
                Deposito = reader["Deposito"] as string;
                Ind_Dep = string.Format("{0} {1} {2} {3} {4}, {5}", reader["U_I_Ind"], reader["U_I_Loc"], reader["U_I_Prov"], reader["U_I_Cap"], reader["U_I_DsNaz"], reader["U_I_NotePosizione"]);
            }
            _ = new List<OrderItem>();
            MembershipUser UserLog = Membership.GetUser();
            string EmailBody = string.Empty;
            _ = CodCli;
            //EmailBody += "Conferma Ordine No.  " + MyOrder[0].OrderID + "";
            //EmailBody += "<br/><br/>";
            EmailBody += "Data: " + DateTime.Now.ToString("D") + "<br/>";
            EmailBody += "Deposito: " + Deposito + "<br/></b>";
            EmailBody += "Indirizzo Deposito: " + Ind_Dep + "<br/></b>";
            EmailBody += "<br />";
            EmailBody += "<span ><b>Dettaglio Ordine</b></span>";
            EmailBody += "<table border='1' cellpadding='3'";
            EmailBody += "style='border-collapse:collapse'>";
            EmailBody += "<tr style='background-color:#F0F0F0'>";
            EmailBody += "  <th>CodArt</th>";
            EmailBody += "  <th>Descrizione</th>";
            EmailBody += "  <th>Unità di misura</th>";
            EmailBody += "  <th>Qta</th>";
            EmailBody += "</tr>";
            Thread.CurrentThread.CurrentCulture = new CultureInfo("it-IT", false);
            query = string.Format(@"SELECT        U_I_OrdCliDett.CodArt, U_I_OrdCliDett.UM, U_I_OrdCliDett.QtaAnag, Articoli.Descrizione
FROM            U_I_OrdCliDett LEFT OUTER JOIN
                         Articoli ON U_I_OrdCliDett.CodArt =  Articoli.CodArt
WHERE        (U_I_OrdCliDett.IDTestata = @IdTestata)", IdTestata);
            reader = new Info4U.Models.Sql4Gestionale().ExecuteReader(query, new SqlParameter() { ParameterName = "@IdTestata", Value = IdTestata });
            while (reader.Read())
            {
                CodArt = reader["CodArt"] as string;
                UM = reader["UM"] as string;
                Qta = Convert.ToInt32(reader["QtaAnag"]);
                Descrizione = reader["Descrizione"] as string;
                EmailBody += "<tr>";
                EmailBody += "  <td>" + CodArt + "</td>";
                EmailBody += "  <td>" + Descrizione + "</td>";
                EmailBody += "  <td>" + UM + "</td>";
                EmailBody += "  <td style='text-align:right'>" + Qta + "  </td>";
                EmailBody += "  </td>";
                EmailBody += "</tr>";
            }
            EmailBody += "</tr>";
            EmailBody += "</table>";
            EmailBody += string.Empty;
            SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();

            return EmailBody;
        }
        protected void insertMovMag(string CodDep)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CodDep", CodDep);
            objSqlHelper.ExecuteNonQuery("U_I_King_Inventario_Insert", objParams);
        }

        protected void AggiornaGiacenza_Callback_Callback(object source, CallbackEventArgs e)
        {
            string[] Parametri = e.Parameter.Split(';');

            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
            int VisibleIndex = 0;
            decimal Qta = 0;
            string ProductCod = string.Empty;
            string UM = string.Empty;

            if (Parametri.Count() > 1)
            {
                VisibleIndex = Convert.ToInt32(Parametri[0]);
                Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
                ProductCod = Articoli_Cv.GetCardValues(VisibleIndex, "CodArt").ToString();
                UM = Articoli_Cv.GetCardValues(VisibleIndex, "Misura").ToString();

                for (int j = 0; j < Articoli_Cv.VisibleCardCount; j++)
                {
                    if (Articoli_Cv.GetCardValues(j, "CodArt").ToString() == ProductCod)
                    {
                        VisibleIndex = j;
                    }
                }
            }
            int Giacenza = Convert.ToInt32(Articoli_Cv.GetCardValues(VisibleIndex, "Giacenza"));

            if ((Giacenza - Qta) >= 0)
            {
                string CodDep = HttpContext.Current.Request["CodDep"];

                Sql4Gestionale objSqlHelper = new Sql4Gestionale();
                SqlParameter[] objParams = new SqlParameter[4];
                objParams[0] = new SqlParameter("@CodDep", CodDep);
                objParams[1] = new SqlParameter("@Qta", Qta);
                objParams[2] = new SqlParameter("@CodArt", ProductCod);
                objParams[3] = new SqlParameter("@UM", UM);
                objSqlHelper.ExecuteNonQuery("U_I_King_Scarico_Prodotti_Finiti", objParams);
                AggiornaGiacenza_Callback.JSProperties["cpError"] = false;
            }
            else
            {
                AggiornaGiacenza_Callback.JSProperties["cpError"] = true;
            }
            Inventario_Dts.DataBind();
        }

        protected void Ordina_Callback_Callback(object source, CallbackEventArgs e)
        {
            string[] Parametri = e.Parameter.Split(';');

            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
            int VisibleIndex = 0;
            decimal Qta = 0;
            string ProductCod = string.Empty;
            string UM = string.Empty;

            if (Parametri.Count() > 1)
            {
                VisibleIndex = Convert.ToInt32(Parametri[0]);
                Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
                ProductCod = Articoli_Cv.GetCardValues(VisibleIndex, "CodArt").ToString();
                UM = Articoli_Cv.GetCardValues(VisibleIndex, "Misura").ToString();
            }

            string CodDep = HttpContext.Current.Request["CodDep"];
            string CodCli = string.Empty;
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CodCli FROM TabDep WHERE CodDep = @CodDep", new SqlParameter("@CodDep", CodDep));
            if (reader.Read())
            {
                CodCli = reader["CodCli"].ToString();
            }
            reader.Close();

            reader = new Sql4Gestionale().ExecuteReader("SELECT Qta FROM U_Ordine_Temp WHERE CodArt = @CodArt AND CodDep = @CodDep", new SqlParameter("@CodDep", CodDep),
                new SqlParameter("@CodArt", ProductCod));
            if (reader.Read())
            {
                Qta += Convert.ToInt32(reader["Qta"]);
                _ = new Sql4Gestionale().ExecuteNonQuery("UPDATE U_Ordine_Temp SET Qta = @Qta WHERE CodArt = @CodArt AND CodDep = @CodDep", new SqlParameter("@CodDep", CodDep),
                new SqlParameter("@CodArt", ProductCod), new SqlParameter("@Qta", Qta));
            }
            else
            {
                _ = new Sql4Gestionale().ExecuteNonQuery("INSERT INTO U_Ordine_Temp (CodArt,Qta,CodDep,CodCli) VALUES (@CodArt,@Qta,@CodDep,@CodCli)", new SqlParameter("@CodDep", CodDep),
                new SqlParameter("@CodArt", ProductCod), new SqlParameter("@Qta", Qta), new SqlParameter("@CodCli", CodCli));
            }
            reader.Close();
            reader = new Sql4Gestionale().ExecuteReader("SELECT SUM(Qta) AS Qta FROM U_Ordine_Temp WHERE CodDep = @CodDep", new SqlParameter("@CodDep", CodDep));
            if (reader.Read())
            {
                Qta = Convert.ToInt32(reader["Qta"]);
            }
            reader.Close();
            Ordina_Callback.JSProperties["cpQtaOrd"] = Qta;
        }

        protected void Conferma_Callback_Callback(object source, CallbackEventArgs e)
        {
            string CodDep = HttpContext.Current.Request["CodDep"];
            string CodCli = string.Empty;
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CodCli FROM TabDep WHERE CodDep = @CodDep", new SqlParameter("@CodDep", CodDep));
            if (reader.Read())
            {
                CodCli = reader["CodCli"].ToString();
            }
            reader.Close();

            Ordini_Crud_v2 InserimentoTest = new Ordini_Crud_v2();
            InserimentoTest.OrdDat = DateTime.Now;
            InserimentoTest.PrevCons = DateTime.Now;
            InserimentoTest.CodCli = CodCli;
            InserimentoTest.CodPag = string.Empty;
            InserimentoTest.CodBan = string.Empty;
            InserimentoTest.BanCli = GetBancli_BYCodCli(CodCli);
            InserimentoTest.NumOrdCli = string.Empty;
            InserimentoTest.DataOrdCli = DateTime.Now;
            InserimentoTest.CodVal = string.Empty;
            InserimentoTest.Agente = string.Empty;
            InserimentoTest.Deposito = CodDep;
            InserimentoTest.Sconto1 = 0;
            InserimentoTest.Sconto2 = 0;
            InserimentoTest.CodLis = "00";
            InserimentoTest.Note = string.Empty;
            InserimentoTest.CodDiv = string.Empty;
            InserimentoTest.CodSpe1 = string.Empty;
            InserimentoTest.CodSpe2 = string.Empty;
            InserimentoTest.CodPor = string.Empty;
            InserimentoTest.CostoTrasporto = 0;
            InserimentoTest.FlagTrasporto = false;
            InserimentoTest.U_IdBozza = 0;

            int LastIdOrdine = InserimentoTest.U_I_OrdCliTest_Insert(InserimentoTest);

            decimal TotaleQuantita = 0;
            decimal TotaleImporto = 0;
            string RifIvaCliente = Order.GetRifIva_V2(CodCli);

            Dictionary<string, int> Ordine = new Dictionary<string, int>();
            reader = new Sql4Gestionale().ExecuteReader("SELECT CodArt,Qta FROM U_Ordine_Temp WHERE CodDep = @CodDep AND CodCli = @CodCli",
                new SqlParameter("@CodDep", CodDep), new SqlParameter("@CodCli", CodCli));
            while (reader.Read())
            {
                Ordine.Add(reader["CodArt"].ToString(), Convert.ToInt32(reader["Qta"]));
            }
            reader.Close();

            int rowCounter = 0;
            foreach (var item in Ordine)
            {
                string UM = string.Empty;
                reader = new Sql4Gestionale().ExecuteReader("SELECT Misura FROM Articoli WHERE CodArt = @CodArt",
                    new SqlParameter("@CodArt", item.Key));
                if (reader.Read())
                {
                    UM = reader["Misura"].ToString();
                }
                reader.Close();

                rowCounter++;
                SqlParameter[] Params = new SqlParameter[]
                {
                    new SqlParameter("@CodArt",item.Key),
                    new SqlParameter("@UM",UM),
                    new SqlParameter("@QtaOrd",item.Value),
                    new SqlParameter("@Prezzo","0"),
                    new SqlParameter("@Importo","0"),
                    new SqlParameter("@IdTestata", LastIdOrdine),
                    new SqlParameter("@NRiga",rowCounter),
                    new SqlParameter("@QtaAnag",item.Value),
                    new SqlParameter("@PrevCons", DateTime.Now),
                    new SqlParameter("@RifIva",string.IsNullOrEmpty(RifIvaCliente) ? "22" : RifIvaCliente),
                    new SqlParameter("@CodDep",CodDep)
                };

                _ = new Sql4Gestionale().ExecuteNonQuery("U_I_OrdCliDett_Insert_Tmp", Params);
            }

            reader = new Sql4Gestionale().ExecuteReader("SELECT SUM(QtaOrd) AS Qta, SUM(Importo) AS Importo FROM U_I_OrdCliDett WHERE IDTestata = @ID", new SqlParameter("@ID", LastIdOrdine));
            if (reader.Read())
            {
                TotaleQuantita = Convert.ToDecimal(reader["Qta"]);
                TotaleImporto = Convert.ToDecimal(reader["Importo"]);
            }
            reader.Close();

            Ordini_Crud_v2 UpdateQta = new Ordini_Crud_v2();
            UpdateQta.TotQta = (float)Convert.ToDouble(TotaleQuantita);
            UpdateQta.TotImp = (float)Convert.ToDouble(TotaleImporto);
            UpdateQta.IdTestata = LastIdOrdine;
            UpdateQta.U_OrdCliTestQta_Update(UpdateQta);

            MembershipUser u = Membership.GetUser(Context.User.Identity.Name);
            string OrdNum = "";
            reader = new Info4U.Models.Sql4Gestionale().ExecuteReader("select OrdNum from U_I_OrdCliTest where ID = @ID", new SqlParameter { ParameterName = "@ID", Value = LastIdOrdine });
            if (reader.Read())
            {
                OrdNum = reader["OrdNum"] as string;
            }
            reader.Close();
            INTRA.AppCode.PRT_Parameter _objPrt = new INTRA.AppCode.PRT_Parameter();
            string msg = MailBodyCreateOrdine(OrdNum);
            string footer = _objPrt.GetPRT_ParameterStringByCode("FooterEmail");
            string body = EmailUtility.PrepareMailBodyWith("MasterEmailV2.html", "MailTitle", "Ordine No.: " + OrdNum, "MailBody", "Utente: " + u.UserName + "<br/>" + msg, "MailFooter", footer, "UrlSite", "https://task4u.info4lab.it/", "Company", " ");
            //body.Replace("../static", UrlAssoluto);
            string mailfrom = u.Email;
            //string UrlDomino = _objPrt.GetPRT_ParameterStringByCode("RmUrlDominio");
            bool MailClienteInvioAbilita = false;
            bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"], out MailClienteInvioAbilita);
            Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");
            string query = "SELECT Email FROM U_Workflow_Email WHERE CodParam = (@CodParam)";
            reader = new Info4U.Models.Sql4Helper().ExecuteReader(query, new SqlParameter() { ParameterName = "@CodParam", Value = "ConfermaOrdine" });
            if (reader.Read())
            {
                foreach (string EmailCliente in reader["Email"].ToString().Split(','))
                {

                    string erroreConnessione = Ws.CheckHostStatus("AIMEX_Host", "AIMEX_Username", "AIMEX_Password", "AIMEX_PortSmtp", "AIMEX_SslMode", "AIMEX_EnableImplicitSsl");
                    string errorMessage = string.Empty;
                    if (string.IsNullOrEmpty(erroreConnessione))
                    {
                        //errorMessage = Ws.SendMailNoTemplateAttachByDb(mailfrom, EmailCliente, "", "", "Oggetto", "Messaggio", ArrayParam2, new byte[1], "1" + ".pdf", _objPrt.GetPRT_ParameterStringByCode("AIMEX_Username"), _objPrt.GetPRT_ParameterStringByCode("AIMEX_Password"));
                        if (MailClienteInvioAbilita)
                        {
                            Ws.TestSendEmai(mailfrom, EmailCliente, body, "Nuovo Ordine");
                        }
                    }
                }
            }
            reader.Close();

            _ = new Sql4Gestionale().ExecuteNonQuery("DELETE FROM U_Ordine_Temp WHERE CodDep = @CodDep", new SqlParameter("@CodDep", Request["CodDep"]));
            Conferma_Callback.JSProperties["cpOrdNum"] = OrdNum;
        }
        public int GetBancli_BYCodCli(string CodCli)
        {
            int CodBan = 0;
            string SqlString = "SELECT IDBan FROM BancheCli  WHERE CodCli = '" + CodCli + "' AND Preferenziale <> 0";
            using (SqlConnection myConnection2 = new SqlConnection())
            {
                myConnection2.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand2 = new SqlCommand
                {
                    Connection = myConnection2,
                    CommandText = SqlString
                };
                myConnection2.Open();
#pragma warning disable CS0219 // La variabile 'retVal2' è assegnata, ma il suo valore non viene mai usato
                bool retVal2 = false;
#pragma warning restore CS0219 // La variabile 'retVal2' è assegnata, ma il suo valore non viene mai usato

                SqlDataReader myReader2 = myCommand2.ExecuteReader();
                if (!myReader2.HasRows)
                { retVal2 = false; }

                else
                {
                    while (myReader2.Read())
                    {

                        CodBan = Convert.ToInt32(myReader2["IDBan"].ToString());

                    }
                }
                myReader2.Close();
                myConnection2.Close();
            }
            return CodBan;
        }

        protected void Ordine_Grw_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT ISNULL(SUM(Qta),0) AS Qta FROM U_Ordine_Temp WHERE CodDep = @CodDep", new SqlParameter("@CodDep", Request["CodDep"]));
            if (reader.Read())
            {
                Ordine_Grw.JSProperties["cpQtaOrd"] = Convert.ToInt32(reader["Qta"]);
            }
            reader.Close();
        }

        protected void Ordine_Grw_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
        {
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT ISNULL(SUM(Qta),0) AS Qta FROM U_Ordine_Temp WHERE CodDep = @CodDep", new SqlParameter("@CodDep", Request["CodDep"]));
            if (reader.Read())
            {
                Ordine_Grw.JSProperties["cpQtaOrd"] = Convert.ToInt32(reader["Qta"]);
            }
            reader.Close();
        }

        protected void Cancella_Ordine_Callback_Callback(object source, CallbackEventArgs e)
        {
            _ = new Sql4Gestionale().ExecuteNonQuery("DELETE FROM U_Ordine_Temp WHERE CodDep = @CodDep", new SqlParameter("@CodDep", Request["CodDep"]));
        }
    }
}