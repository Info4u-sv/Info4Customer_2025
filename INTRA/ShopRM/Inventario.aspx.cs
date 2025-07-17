using DevExpress.DataAccess.Native.Sql;
using DevExpress.DataAccess.Sql;
using DevExpress.Web;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.ComponentModel;
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
using System.Windows.Forms;

namespace INTRA.ShopRM
{
    public partial class Inventario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void Aggiungi_Invetario_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
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
                ProductCod = ShopList1.GetCardValues(VisibleIndex, "CodArt").ToString();
                UM = ShopList1.GetCardValues(VisibleIndex, "Misura").ToString();
                for (int j = 0; j < ShopList1.VisibleCardCount; j++)
                {
                    if (ShopList1.GetCardValues(j, "CodArt").ToString() == ProductCod)
                    {
                        VisibleIndex = j;
                    }
                }
            }

            string descrizione = ShopList1.GetCardValues(VisibleIndex, "Descrizione").ToString();

            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
            CodDep = CodDep.Replace("CodDep=", string.Empty);

            int verificacart = Controllo(ProductCod, CodDep);

            if (verificacart == -1)
            {
                Insert(CodDep, Qta, ProductCod, descrizione, UM);
            }
            else
            {
                Update(CodDep, Qta, ProductCod);
            }
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
        protected static int Controllo(string MenuItemID, string CodDep)
        {
            //Verifico se nel carrello è già presente l'articolo e in tal caso ritorno la Q.tà
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

        protected void Invio_Email_Callback_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser u = Membership.GetUser(Context.User.Identity.Name);
            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;
            CodDep = CodDep.Replace("CodDep=", string.Empty);
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
            insertMovMag(CodDep);
            new Sql4Gestionale().ExecuteNonQuery("DELETE FROM U_ESK_Inventario WHERE U_CodDep = @CodDep", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            new Sql4Gestionale().ExecuteNonQuery("UPDATE TabDep SET U_UltimoControllo_Inventario = GETDATE() WHERE CodDep = @CodDep", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            HttpCookie DataCens_cookie = HttpContext.Current.Request.Cookies["DataCensimento"];
            if (DataCens_cookie != null /*&& CodCLiDett_cookie != null*/)
            {
                PRT_Cookie_Crud_23.RewriteCoockies("DataCensimento", DateTime.Now.ToString());
            }
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
                Ind_Dep = string.Format("{0} {1} {2} {3} {4}, {5}", reader["U_I_Ind"], reader["U_I_Loc"], reader["U_I_Prov"], reader["U_I_Cap"], reader["U_I_DsNaz"], reader["U_I_NotePosizione"]);
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
        protected void insertMovMag(string CodDep)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CodDep", CodDep);
            objSqlHelper.ExecuteNonQuery("U_I_King_Inventario_Insert", objParams);
        }

    }
}