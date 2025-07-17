using DevExpress.Web;
using info4lab.Portal;
using Info4U.Models;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM.Controls
{

    public partial class _16SHP_CartView : System.Web.UI.UserControl
    {
        public string TitCartView { get; set; }

        private readonly string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value.Replace("CodDep=", string.Empty);
        public Order __MyOrder { get; set; }
        public List<CartItem> __MyCartItems { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            //CodCli = "C999-1";

            Object_totali.SelectParameters["CodDep"].DefaultValue = CodDep;
            StoredShoppingCartObjectDS.SelectParameters["CodDep"].DefaultValue = CodDep;

            //TitoloCartView.InnerHtml = TitCartView;

            MembershipUser UserLog = Membership.GetUser();
            _ = ProfileBase.Create(UserLog.UserName, true);
            string __CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value.Replace("CodDep=", "");
            List<CartItem> cartItems = (List<CartItem>)StoredShoppingCartObjectDS.Select();
            TotalPanel.Visible = cartItems.Count > 0;

        }

        private void LoadControl()
        {
            _ = (INTRA.ShopRM.Controls._21Plusheader)Page.FindControl("Plusheader");
            //xxx.BuildControlBasedOnData();
        }

        protected void StoredShoppingCartListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            Label MenuItemID = (Label)e.Item.FindControl("ItemNameLabel");

            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;//HttpContext.Current.Session["CodCli"].ToString();
            CodDep = CodDep.Replace("CodDep=", string.Empty);

            string ProductId = MenuItemID.Text.ToString();
            _ = (Label)e.Item.FindControl("LabelErrorQuantity_Lbl");

            //int IdContattoRM = Convert.ToInt32(StoredShoppingCartListView.DataKeys[dataItem1.DisplayIndex]["IdContattoRM"].ToString());
            if (e.CommandName == "Aggiorna")
            {
                _ = new List<CartItem>();
                _ = StoredShoppingCart.ReadItems(CodDep);
                TextBox QuantityTextBox = (TextBox)e.Item.FindControl("QuantityTextBox");

                //Label QtaXConfLbl = (Label)e.Item.FindControl("QtaXConfLbl");
                float QtaXConf = 1;
                string qtasel = QuantityTextBox.Text;
                float Quantita = (float)Convert.ToDecimal(qtasel);
                string RisultatoDivisione = (Quantita / QtaXConf).ToString();
                if (int.TryParse(RisultatoDivisione, out _) && RisultatoDivisione != "0")
                {
                    decimal qtaselVal = string.IsNullOrEmpty(qtasel) || qtasel.Equals("0") ? 1 : Convert.ToDecimal(qtasel.Replace(".", ","));
                    _ = StoredShoppingCart.UpdateItem(ProductId, qtaselVal);
                    Response.Redirect(Request.ApplicationPath.TrimEnd('/') + "/ShopRm/carrello.aspx");
                }
                else
                {
                    QuantityTextBox.Text = QtaXConf.ToString();
                    MyMessageBox1.ShowError("Il dato non è corretto!");
                }

            }
        }


        protected void TotalRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }
        protected void TotalRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ConfermaCarrello")
            {
                string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;//HttpContext.Current.Session["CodCli"].ToString();
                CodDep = CodDep.Replace("CodDep=", string.Empty);
                List<CartItem> MyCartItems = StoredShoppingCart.ReadItems(CodDep);
                if (MyCartItems.Count > 0)
                {
                    ConfermaOrdineOttimizzato(MyCartItems);
                }
                else
                {
                    MyMessageBox1.ShowError("Sì è verificato un errore!");

                }
            }
        }
        protected string _TipoPagina;
        public string TipoPagina
        {
            get => _TipoPagina;
            set => _TipoPagina = value;
        }

        // creata Andrea Bugfix 11/05/2023 vottmizzazione inserimento ordine 
        protected bool ConfermaOrdineOttimizzato(List<CartItem> MyCartItems)
        {
            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);
            //List<CartItem> MyCartItems = new List<CartItem>();
            //MyCartItems = StoredShoppingCart.ReadItems();

            //for (int i = 0; i < MyCartItems.Count; i++)
            //{
            //    ESK_ShoppingCart.ESK_ControlloVariazionePrezzoArt_Upd(MyCartItems[i].MenuItemID, MyProfile.CodCli, 1);
            //}
            //ESK_ShoppingCart.ESK_ShoppingCart_VariazionePrezziArt_Update(MyProfile.CodCli);


            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value;//HttpContext.Current.Session["CodCli"].ToString();
            CodDep = CodDep.Replace("CodDep=", string.Empty);
            SqlDataReader reader = new Info4U.Models.Sql4Gestionale().ExecuteReader("SELECT CustomerID FROM U_ESK_ShoppingCart WHERE U_CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });

            string CodCli = "";
            if (reader.Read())
            {
                CodCli = reader["CustomerID"] as string;
            }
            reader.Close();
            AppoggioCart_Sql.SelectParameters["CodCLi"].DefaultValue = CodCli;
            DataView dv2 = (DataView)AppoggioCart_Sql.Select(DataSourceSelectArguments.Empty);
            DataTable dt2 = dv2.ToTable();

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

            ASPxMemo NoteOrdine_Memo = TotalRepeater.Items[0].FindControl("NoteOrdine_Memo") as ASPxMemo;

            if (NoteOrdine_Memo.Text == string.Empty)
            {
                InserimentoTest.Note = string.Empty;
            }
            else
            {
                InserimentoTest.Note = NoteOrdine_Memo.Text;
            }

            InserimentoTest.CodDiv = string.Empty;

            InserimentoTest.CodSpe1 = string.Empty;

            InserimentoTest.CodSpe2 = string.Empty;
            InserimentoTest.CodPor = string.Empty;
            //string OrdNum = string.Empty;
            //OrdNum = "O" + UpdateLastIdProtocollo();

            //InserimentoTest.OrdNum = OrdNum;
            InserimentoTest.CostoTrasporto = 0;
            InserimentoTest.FlagTrasporto = false;

            InserimentoTest.U_IdBozza = 0;

            int LastIdOrdine = InserimentoTest.U_I_OrdCliTest_Insert(InserimentoTest);
            Session["LastIdOrdine"] = LastIdOrdine;

            decimal TotaleQuantita = 0;
            float TotaleImporto = 0;
            float TotaleImportoConSconti = 0;
#pragma warning disable CS0219 // La variabile 'RowCount' è assegnata, ma il suo valore non viene mai usato
            int RowCount = 0;
#pragma warning restore CS0219 // La variabile 'RowCount' è assegnata, ma il suo valore non viene mai usato
            Ordini_Crud_v2 InserimentoDett = new Ordini_Crud_v2();
            DataTable mytable = new DataTable();
            Ordini_Crud_v2 SaldiMagUpd = new Ordini_Crud_v2();
            float ScontoIncondizionato = 0;
            float TotaleImportoSenzaSconti = 0;
            float TotaleSconto = 0;
            string RifIvaCliente = Order.GetRifIva_V2(CodCli);

            Ordini_Crud_v2.U_OrdCliDett_CarrelloInsert(MyCartItems, LastIdOrdine, RifIvaCliente, CodDep);

            for (int i = 0; i <= MyCartItems.Count - 1; i++)
            {
                TotaleQuantita = TotaleQuantita + Convert.ToDecimal(MyCartItems[i].Quantity);
                TotaleImporto = TotaleImporto + ((float)Convert.ToDouble(MyCartItems[i].ItemPrice) * (float)Convert.ToDouble(MyCartItems[i].Quantity));
                TotaleImportoSenzaSconti += ((float)Convert.ToDouble(MyCartItems[i].ItemPrice) * (float)Convert.ToDouble(MyCartItems[i].Quantity));
            }
            Ordini_Crud_v2 UpdateQta = new Ordini_Crud_v2();
            UpdateQta.TotQta = (float)Convert.ToDouble(TotaleQuantita);
            UpdateQta.TotImp = TotaleImporto;
            UpdateQta.IdTestata = LastIdOrdine;
            UpdateQta.U_OrdCliTestQta_Update(UpdateQta);

            //List<Ordini_Crud_v2> ListGet = new List<Ordini_Crud_v2>();
            //Ordini_Crud_v2 GetDefSpese = new Ordini_Crud_v2();
            //ListGet = GetDefSpese.U_DefSpese_GET();
            //TotaleSconto = TotaleImportoSenzaSconti - TotaleImportoConSconti;
            //Ordini_Crud_v2 InsertOrdCSpese = new Ordini_Crud_v2();
            //for (int j = 0; j < ListGet.Count; j++)
            //{
            //    //InsertOrdCSpese.IdTestata = LastIdOrdine;
            //    InsertOrdCSpese.Tipo = "OC";
            //    InsertOrdCSpese.Nriga = ListGet[j].IdSpesa;
            //    InsertOrdCSpese.Percent = 0;
            //    InsertOrdCSpese.Importo = 0;
            //    InsertOrdCSpese.CodIva = ListGet[j].CodIva;
            //    //InsertOrdCSpese.U_OrdCSpese_Insert_v2(InsertOrdCSpese);
            //}


            MyMessageBox1.Visible = true;
            //VariazionePrezzi_Msg.Visible = false;
            MyMessageBox1.Show(MyMessageBox.MessageType.Success, "L'ordine è stato inoltrato.");
            SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();

            MembershipUser u = Membership.GetUser(Context.User.Identity.Name);
            string OrdNum = "";
            reader = new Info4U.Models.Sql4Gestionale().ExecuteReader("select OrdNum from U_I_OrdCliTest where ID = @ID", new SqlParameter { ParameterName = "@ID", Value = LastIdOrdine });
            if (reader.Read())
            {
                OrdNum = reader["OrdNum"] as string;
            }
            reader.Close();
            INTRA.AppCode.PRT_Parameter _objPrt = new INTRA.AppCode.PRT_Parameter();
            string msg = MailBodyCreate(OrdNum);
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
            //string query = "SELECT Email FROM U_Workflow_Email WHERE CodParam = (@CodParam)";
            //reader = new Info4U.Models.Sql4Helper().ExecuteReader(query, new SqlParameter() { ParameterName = "@CodParam", Value = "EmailAmministrativa" });
            //if (reader.Read())
            //{
            //    foreach (string Email in reader["Email"].ToString().Split(','))
            //    {
            //        body = EmailUtility.PrepareMailBodyWith("MasterEmailV2.html", "MailTitle", "Ordine Confermato", "MailBody", "<span><b>Riepilogo Odine:</b></span><br>" + msg, "MailFooter", CompanyFooter, "UrlSite", "https://demo3.info4lab.it/", "Company", " ");
            //        Ws.TestSendEmai(Email, u.Email, body, "Conferma Ordine");
            //    }
            //}

            StoredShoppingCartObjectDS.DataBind();
            StoredShoppingCartListView.Visible = false;
            TotalPanel.Visible = false;
            ESK_ShoppingCart.CartDeleteLocal(CodDep);
            return true;
        }


        protected void StoredShoppingCartListView_ItemCreated(object sender, ListViewItemEventArgs e)
        {

        }

        protected void CatReturn_Click(object sender, EventArgs e)
        {
            //string url = Session["UrlReferrer"].ToString();
            //Session["UrlReferrer"] = string.Empty;
            string url = "default.aspx";

            Response.Redirect(url);
        }

        protected Tuple<string, string> PayPalIntestazione(int OrderId)
        {
            _ = new List<Order>();
            List<Order> MyOrder = Order.GetOrders_IDorder_testata(OrderId);
            string _TitOrdine = "Ordine Num: " + MyOrder[0].OrderID.ToString();
            string _TotaleOrdine = MyOrder[0].TotalAmount.ToString();
            return Tuple.Create(_TitOrdine, _TotaleOrdine);
        }
        private string UpdateLastIdProtocollo()
        {
            string SqlString = " SELECT  Ultimo FROM  Protocolli  WHERE TipoDoc = 'OC' AND Protocollo = 'O' ";
#pragma warning restore CS0219 // La variabile 'UMFinale' è assegnata, ma il suo valore non viene mai usato
            int LastID = 0;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = SqlString
                };
                myConnection.Open();


                SqlDataReader myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    LastID = Convert.ToInt32(myReader["Ultimo"].ToString());

                }

                myReader.Close();
                myConnection.Close();
            }

            _ = new Portal4Set_SA();
            LastID++;
            string updateCommand = " UPDATE [Protocolli] set [Ultimo] = " + LastID + " WHERE TipoDoc = 'OC' AND Protocollo = 'O' ";
            string LastIDString = Convert.ToString(LastID);
            using (SqlConnection connection =
                   new SqlConnection(ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(updateCommand, connection);
                command.Connection.Open();
                _ = command.ExecuteNonQuery();

            }
            return LastIDString;
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

        protected void ItemGest_Callback_Callback1(object sender, CallbackEventArgsBase e)
        {
            string[] parameters = e.Parameter.Split('|');
            string Case = parameters[0].ToLower();
            string ProductId = parameters[1];
            string CodDep = this.CodDep;

            switch (Case)
            {
                case "delete":
                    ESK_ShoppingCart.ItemsDeleteLocal(ProductId, CodDep);
                    break;
                case "aggiorna":
                    //ESK_ShoppingCart.ItemsUpdateQtaLocal(ProductId, ,CustomerId);
                    break;
            }

            List<CartItem> cartItems = (List<CartItem>)StoredShoppingCartObjectDS.Select();

            StoredShoppingCartListView.DataBind();

            TotalRepeater.Visible = cartItems.Count > 0;
        }

        protected string MailBodyCreate(string OrdNum)
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
                         Articoli ON U_I_OrdCliDett.CodArt =  SUBSTRING(Articoli.CodArt, CHARINDEX('-', Articoli.CodArt) + 1, LEN(Articoli.CodArt))
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
    }
}