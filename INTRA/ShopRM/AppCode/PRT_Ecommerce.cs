using info4lab.Portal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace INTRA.ShopRM.AppCode
{
    public class PRT_Ecommerce
    {
        public PRT_Ecommerce()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }

        private static void LogWrite(string ex)
        {
            string message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            message += Environment.NewLine;
            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            message += string.Format("Message: {0}", ex);
            message += Environment.NewLine;
            message += string.Format("StackTrace: {0}", ex);
            message += Environment.NewLine;
            message += string.Format("Source: {0}", ex);
            message += Environment.NewLine;
            message += string.Format("TargetSite: {0}", ex.ToString());
            message += Environment.NewLine;
            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            string path = HttpContext.Current.Server.MapPath("~/ErrorLog.txt");
            using (StreamWriter writer = new StreamWriter(path, true))
            {
                writer.WriteLine(message);
                writer.Close();
            }
        }

        protected string MailBodyCreatePaypal(int OrderId, string _StatusOrder, string _subjectPrefix)
        {

            //List<Order> MyOrder = new List<Order>();
            //MyOrder = Order.GetOrders_IDorder_testata(OrderId);
            //int i = 0;

            //List<OrderItem> MyOrderItems = new List<OrderItem>();
            //MyOrderItems = Order.GetOrderItems(OrderId);

            //string EmailBody = string.Empty;
            //string VarCustomerID = MyOrder[0].CustomerID;
            ////EmailBody += "Conferma Ordine No.  " + MyOrder[0].OrderID + "";
            ////EmailBody += "<br/><br/>";
            //ProfileBase Profile = ProfileBase.Create(VarCustomerID);
            //EmailBody += "Data: " + DateTime.Now.ToString() + "<br/>";
            //EmailBody += _subjectPrefix + MyOrder[0].OrderID + "<br/></b>";
            //EmailBody += "<br/>";
            //EmailBody += "<span ><b>Dati destinazione beni</b></span>";
            //EmailBody += "<br/>";
            //EmailBody += "_______________________________________________________________";
            //EmailBody += "<br />";
            //EmailBody += "<b>Nome: </b>" + (string)Profile["nome"] + " <br/>";
            //EmailBody += "<b>Cognome: </b>" + (string)Profile["cognome"] + "<br/>";
            //EmailBody += "<b>Indirizzo: </b>" + (string)Profile["Indirizzo"] + " <br/>";
            //EmailBody += "<b>Tel. </b>" + (string)Profile["Telefono"] + " <br/>";
            //EmailBody += "<b>Fax: </b>" + (string)Profile["fax"] + " <br/>";
            //EmailBody += "<b>citta: </b>" + (string)Profile["citta"] + " <br/>";
            //EmailBody += "<b>Provincia: </b>" + (string)Profile["Provincia"] + " <br/>";
            //EmailBody += "<b>Cap: </b>" + (string)Profile["Cap"] + " <br/>";
            //EmailBody += "<b>E-mail: </b>" + (string)Profile["email"] + " <br/>";
            //EmailBody += "_______________________________________________________________";
            //EmailBody += "<br/>";
            ////EmailBody += "<br><br>";
            //EmailBody += "<br><br><span ><b>Dettaglio Ordine</b></span>";
            //EmailBody += "<table border='1' cellpadding='3'";
            //EmailBody += "style='border-collapse:collapse'>";
            //EmailBody += "<tr style='background-color:#F0F0F0'>";
            //EmailBody += "  <th>codice</th>";
            //EmailBody += "  <th>descrizione</th>";
            //EmailBody += "  <th>Qta</th>";
            //EmailBody += "  <th>prezzo</th>";
            //EmailBody += "  <th>subtotale</th>";
            //EmailBody += "</tr>";
            //Thread.CurrentThread.CurrentCulture = new CultureInfo("it-IT", false);
            //decimal OrderAmount = 0;
            //i = 0;
            //for (i = 0; i <= MyOrderItems.Count - 1; i++)
            //{

            //    OrderAmount += MyOrderItems[i].TotCost;
            //    EmailBody += "<tr>";
            //    EmailBody += "  <td>" + MyOrderItems[i].ProductID + "</td>";
            //    EmailBody += "  <td>" + MyOrderItems[i].ProductName + "</td>";
            //    EmailBody += "  <td style='text-align:right'>" + MyOrderItems[i].Quantity + "  </td>";
            //    EmailBody += "  <td style='text-align:right'>" + (Math.Round(MyOrderItems[i].UnitCost * 100) / 100).ToString("C", CultureInfo.CurrentUICulture).ToString() + "  </td>";
            //    EmailBody += "  <td style='text-align:right'>" + (Math.Round(MyOrderItems[i].TotCost * 100) / 100).ToString("C", CultureInfo.CurrentCulture).ToString() + " </td>";
            //    EmailBody += "  </td>";
            //    EmailBody += "</tr>";
            //}
            //EmailBody += "<tr>";
            //EmailBody += "	<td colspan='4' style='text-align:right'>" + "Sub totale" + "</td>";
            //EmailBody += "	<td style='text-align:right'>" + (Math.Round(OrderAmount * 100) / 100).ToString("C", CultureInfo.CurrentCulture).ToString() + "</td>";
            //EmailBody += "</tr>";
            //EmailBody += "<tr>";
            //EmailBody += "	<td colspan='4' style='text-align:right'>" + "Trasporto" + "</td>";
            //EmailBody += "	<td style='text-align:right'>" + MyOrder[0].Trasporto.ToString("C", CultureInfo.CurrentCulture).ToString() + "</td>";
            //EmailBody += "</tr>";
            //EmailBody += "<tr>";
            //EmailBody += "	<td colspan='4' style='text-align:right'>" + "Iva" + "</td>";
            //EmailBody += "	<td style='text-align:right'>" + MyOrder[0].iva.ToString("C", CultureInfo.CurrentCulture).ToString() + "</td>";
            //EmailBody += "</tr>";
            //EmailBody += "<tr>";
            //EmailBody += "	<td colspan='4' style='text-align:right'>" + "Totale" + "</td>";
            //EmailBody += "	<td style='text-align:right'>" + MyOrder[0].TotalAmount.ToString("C", CultureInfo.CurrentCulture).ToString() + "</td>";
            //EmailBody += "</tr>";
            ////EmailBody += "<tr>";
            ////EmailBody += "	<td style='align:right'>" + "Punteggio totalizzato:" + "</td>";
            ////EmailBody += "	<td style='align:right'>" + Profile.GetProfile(VarCustomerID).punteggio + "</td>";
            ////EmailBody += "</tr>";
            //EmailBody += "</table>";
            //EmailBody += "";
            //string CompanyFooter = "";
            //PRT_Settings PortalConfig = new PRT_Settings();
            ////CompanyFooter = "New Service srl - P.I. 029444469274 - Via Friuli Venezia Giulia, 4 - Cazzago di Pianiga (VE)";

            //string Company = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.Company);
            //string CompanyPIva = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.CompanyPIva);
            //string CompanyAddress = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.CompanyAddress);
            //string CompanyCity = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.CompanyCity);
            //string CompanyProvince = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.CompanyProvince);
            //string Companymail = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.CompanyMail);
            //string CompanyTel = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.CompanyTel);
            //string CompanyOrari = PortalConfig.GetConfigurationValue(PRT_Settings.Settings.Orari);
            //CompanyFooter = "{0} - P.I. {1} - {2} - {4} ({5})";
            //CompanyFooter = string.Format("{0} - P.I. {1} - {2} - {3} ({4})", Company, CompanyPIva, CompanyAddress, CompanyCity, CompanyProvince);
            //string MsgConsegna = PortalConfig.GetConfigurationValue(INTRA.ShopRM.AppCode.PRT_Settings.Settings.MsgConsegna).ToString();
            //if (!Convert.ToBoolean(PortalConfig.GetConfigurationValue(INTRA.ShopRM.AppCode.PRT_Settings.Settings.AbilitaMsgConsegna)))
            //{
            //    MsgConsegna = "";
            //}
            //EComm_Ana_CRUD GetDatiEcommerce = new EComm_Ana_CRUD();
            //GetDatiEcommerce = GetDatiEcommerce.Get_Ana_Ecommerce(1);
            //string DescrizioneCorriere = GetDatiEcommerce.RiservaCorriereDescr.Replace("\"", "\\\"");
            //if (_StatusOrder == order_settings.PaypalDaEvadere.ToString())
            //{
            //    EmailBody += "</br><br><span Style='color:green'><b> Pagamento ricevuto da paypal </b></span>";
            //    EmailBody += DescrizioneCorriere;
            //}
            //else
            //{
            //    if (_StatusOrder == order_settings.PaypalAnnullato.ToString())
            //    {
            //        EmailBody += "</br><br><span Style='color:red'><b> Pagamento annullato da paypal </b></span>";
            //    }
            //}



            //EmailBody += "<br><br>Se ha domande sull'ordine, è pregato di inviare una e-mail all'indirizzo <a href='mailto:";
            //EmailBody += Companymail + "' >" + Companymail + "</a> riportando il numero d'ordine di cui sopra.<br><br>Nei prossimi giorni riceverà direttamente via e-mail la fattura. ";
            //EmailBody += "<br><br> Per info chiamare " + CompanyTel + " da " + CompanyOrari + "</p>";
            //EmailBody += "<p>Grazie per la fiducia accordataci. <br>";
            //EmailBody += "<p>Staff " + Company + " <br>";

            //EmailBody += "</br>" + CompanyFooter;
            string EmailBody = string.Empty;
            return EmailBody;
        }
        //protected void Conferma_O_AnnullaOrdineConPaypal(int OrderId, bool Conferma)
        //{

        //    List<Order> MyOrder = new List<Order>();
        //    MyOrder = Order.GetOrders_IDorder_testata(OrderId);
        //    int i = 0;

        //    List<OrderItem> MyOrderItems = new List<OrderItem>();
        //    MyOrderItems = Order.GetOrderItems(OrderId);

        //    string totcartStr = null;

        //    decimal totcart = MyOrder[0].TotalAmount;




        //    SHP_OrderBodyMail Get = new SHP_OrderBodyMail();

        //    WebReference4u.WebService_primo _WebS_primo = new WebReference4u.WebService_primo();
        //    WebReference4u.JsonEmail _JsonEmail = new WebReference4u.JsonEmail();


        //    INTRA.AppCode.PRT_Parameter _objPrt = new INTRA.AppCode.PRT_Parameter();
        //    string mailfrom = _objPrt.GetPRT_ParameterStringByCode("RmMailShop");
        //    string UrlDomino = _objPrt.GetPRT_ParameterStringByCode("RmUrlDominio");
        //    _JsonEmail.from = mailfrom;
        //    MembershipUser u = Membership.GetUser(MyOrder[0].CustomerID);

        //    _JsonEmail.to = u.Email;
        //    if (Conferma)
        //    {
        //        _JsonEmail.OggettoMail = "Conferma pagamento ordine N." + MyOrder[0].OrderID;
        //        _JsonEmail.CodParametroTemplate = "RmMailPPOrdConfermato";
        //    }
        //    else
        //    {
        //        _JsonEmail.OggettoMail = "Conferma annullamento ordine N." + MyOrder[0].OrderID;
        //        _JsonEmail.CodParametroTemplate = "RmMailPPOrdCancellato";
        //    }
        //    string[] ArrayParam = {u.Email, UrlDomino, MyOrder[0].OrderID.ToString(), Get.CreaOrdineBodyMail(Convert.ToInt32(MyOrder[0].OrderID)) };


        //    _WebS_primo.SendMailDBTemplate(_JsonEmail, ArrayParam);

        //   if(ConfigurationManager.AppSettings["AbilitaOrdiniInviaMailBackoffice"].ToString() == "true") { }

        //    //EmailUtility.SendMail(PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.PRTMail), u.Email + "," + PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.PRTMail), subject, body);

        //    ShoppingCart_wish cart = (ShoppingCart_wish)StoredShoppingCart_wish.Read();
        //    cart.Items.Clear();
        //    ShoppingCart_wish cartTestata = (ShoppingCart_wish)HttpContext.Current.Session["Cart"];
        //    cartTestata = null;

        //}
        public bool AggiornaOrdineConPaypal(int OrderId, string _StatusOrder, string _payment_status)
        {
            try
            {
                List<Order> MyOrder = new List<Order>();
                MyOrder = Order.GetOrders_IDorder_testata(OrderId);
#pragma warning disable CS0219 // La variabile 'i' è assegnata, ma il suo valore non viene mai usato
                int i = 0;
#pragma warning restore CS0219 // La variabile 'i' è assegnata, ma il suo valore non viene mai usato

                List<OrderItem> MyOrderItems = new List<OrderItem>();
                MyOrderItems = Order.GetOrderItems(OrderId);


                string _subjectPrefix = "Conferma ordine n. " + MyOrder[0].OrderID;
                //string corpo = MailBodyCreatePaypal(MyOrder[0].OrderID, _StatusOrder, _subjectPrefix);

                if (_payment_status == "Completed" || _payment_status == "Processed" || _payment_status == "Processed")
                {

                    UpdateStatusOrdine(MyOrder[0].OrderID, SHP_Order_Settings.PaypalDaEvadere.ToString());
                    //Conferma_O_AnnullaOrdineConPaypal(MyOrder[0].OrderID, true);
                    //corpo = MailBodyCreatePaypal(MyOrder[0].OrderID, SHP_Order_Settings.PaypalDaEvadere.ToString(), _subjectPrefix);

                }
                else
                {
                    ////_subjectPrefix = "Annullato ordine n. " + MyOrder[0].OrderID;
                    UpdateStatusOrdine(MyOrder[0].OrderID, SHP_Order_Settings.PaypalAnnullato.ToString());
                    //Conferma_O_AnnullaOrdineConPaypal(MyOrder[0].OrderID, false);
                    //corpo = MailBodyCreatePaypal(MyOrder[0].OrderID, SHP_Order_Settings.PaypalAnnullato.ToString(), _subjectPrefix);

                }





            }
            catch (Exception ex)
            {
                PRT_LogErrorGest.LogError(ex);
            }
            return true;
        }
        public PRT_Ecommerce EcommerceMetodiPagamentoGet()
        {
            PRT_Ecommerce _obj = new PRT_Ecommerce();
            _ = new SqlCommand();
            using (SqlConnection connection =
                     new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT[Bonifico], [Paypal] , [BonificoDescr] FROM [EComm_Ana] WHERE[ID] = 1", connection))
                {
                    cmd.CommandType = CommandType.Text;
                    connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        _obj.Bonifico_Chk = (bool)dr["Bonifico"];
                        _obj.Paypal_Chk = (bool)dr["Paypal"];
                        _obj.BonificoDescr = (string)dr["BonificoDescr"];

                    }
                    connection.Close();
                }
            }
            return _obj;
        }
        public Tuple<bool, string> GiagenzaGet(int _ProductId)
        {
            int _Giacenza = 0;
            string _Giacenza_Txt = "<br/><br/> Disponibilità: <div class='current'> {0} </div> {1}";
            SqlCommand cmd1 = new SqlCommand();
            using (SqlConnection connection =
                     new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                cmd1.Connection = connection;
                cmd1.CommandText = "SELECT [Giacenza] FROM [SHP_Product] WHERE [ProductId] = " + _ProductId;
                connection.Open();
                object result = cmd1.ExecuteScalar();
                _Giacenza = Convert.ToInt32(result);
                connection.Close();
            }
            bool _disponibile;
            if (_Giacenza >= MinScortaGet())
            {
                _disponibile = true;
                _Giacenza_Txt = string.Format(_Giacenza_Txt, _Giacenza, "unità");
                //_Giacenza_Txt = string.Format(_Giacenza_Txt, "Il prodotto non è disponibile", "");
            }
            else
            {
                _disponibile = false;
                _Giacenza_Txt = "<br><br>" + ProdottoEsauritoDescrGet();
                _Giacenza_Txt = string.Format(_Giacenza_Txt, "Il prodotto non è disponibile", string.Empty);
            }

            return Tuple.Create(_disponibile, _Giacenza_Txt);

        }
        public int MinScortaGet()
        {
            int _MinScorta = 0;
            SqlCommand cmd1 = new SqlCommand();
            using (SqlConnection connection =
                     new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                cmd1.Connection = connection;
                cmd1.CommandText = "SELECT [MinScorta] FROM [EComm_Ana] WHERE [ID] = 1";
                connection.Open();
                object result = cmd1.ExecuteScalar();
                _MinScorta = Convert.ToInt32(result);
                connection.Close();
            }
            return _MinScorta;

        }
        public string ProdottoEsauritoDescrGet()
        {
            string _ReturnVar = string.Empty;
            SqlCommand cmd1 = new SqlCommand();
            using (SqlConnection connection =
                     new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                cmd1.Connection = connection;
                cmd1.CommandText = "SELECT [ProdottoEsaurito] FROM [EComm_Ana] WHERE [ID] = 1";
                connection.Open();
                object result = cmd1.ExecuteScalar();
                _ReturnVar = result.ToString();
                connection.Close();

            }
            return _ReturnVar;

        }

        public void UpdateStatusOrdine(int _OrderID, string _esito)
        {
            string updateCommand = "UPDATE ESK_Orders SET esito = '{0}' WHERE (OrderID = {1})";
            updateCommand = string.Format(updateCommand, _esito, _OrderID);
            LogWrite(updateCommand);
            _ = new Portal4Set_SA();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                {
                    SqlCommand command = new SqlCommand(updateCommand, connection);
                    command.Connection.Open();

                    _ = command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                PRT_LogErrorGest.LogError(ex);
            }
        }

        #region Property

        public int ProductId { get; set; }
        public int Giacenza { get; set; }
        public bool Bonifico_Chk { get; set; }
        public bool Paypal_Chk { get; set; }
        public string BonificoDescr { get; set; }
        #endregion
    }
}