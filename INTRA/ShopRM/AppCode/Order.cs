using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class Order
    {
        private decimal decTrasporto;
#pragma warning disable CS0169 // Il campo 'Order.datapartenza' non viene mai usato
        private readonly DateTime datapartenza;
#pragma warning restore CS0169 // Il campo 'Order.datapartenza' non viene mai usato
#pragma warning disable CS0169 // Il campo 'Order.datafine' non viene mai usato
        private readonly DateTime datafine;
#pragma warning restore CS0169 // Il campo 'Order.datafine' non viene mai usato
        public string EmailAgente { get; set; }
        public string Azienda { get; set; }

        public string EmailCliente { get; set; }

        // -------------

        public int OrderID { get; set; }
        // aggiungo esito , iva, trasporto --------------------------------------
        public string esito { get; set; }
        public decimal iva { get; set; }
        public decimal Trasporto
        {
            get => decTrasporto;
            set => decTrasporto = value;
        }
        // ho aggiunto Esito , iva, trasporto ---------------------------------

        // aggiungo i campi per la gestione del referer------------------------
        public string referer { get; set; }
        public int aff { get; set; }
        public int aff_story { get; set; }
        // ho aggiunto i campi per la gestione del referer ---------------------------------

        public string CustomerID { get; set; }

        public DateTime OrderDate { get; set; }

        public decimal TotalAmount { get; set; }

        public string NoteCustomer { get; set; }

        public string Giorni { get; set; }

        public decimal TotalAmountNoSconto { get; set; }

        public static List<Order> GetOrders(string customerID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();

            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CustomerID", customerID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrders", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    CustomerID = reader.GetString(reader.GetOrdinal("CustomerID")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    TotalAmount = Convert.ToDecimal(objSqlHelper.ExecuteScalar("ESK_GetOrderAmount", new SqlParameter("@orderid", reader.GetInt32(reader.GetOrdinal("OrderID")))))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }
        public static List<Order> GetOrders_search(string esito, DateTime datapartenza, DateTime datafine)
        {
            // gli devo passare data inizio data fine
            // 
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@esito", esito);
            objParams[1] = new SqlParameter("@datapartenza", datapartenza);
            objParams[2] = new SqlParameter("@datafine", datafine);

            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrders_search", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    CustomerID = reader.GetString(reader.GetOrdinal("CustomerID")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    // o.esito = reader.GetString(reader.GetOrdinal("esito"))
                    esito = reader.IsDBNull(reader.GetOrdinal("esito")) ? "Null" : reader.GetString(reader.GetOrdinal("esito")),
                    aff = reader.IsDBNull(reader.GetOrdinal("aff")) ? 0 : reader.GetInt32(reader.GetOrdinal("aff")),
                    aff_story = reader.IsDBNull(reader.GetOrdinal("aff_story")) ? 0 : reader.GetInt32(reader.GetOrdinal("aff_story")),
                    referer = reader.IsDBNull(reader.GetOrdinal("referer")) ? "Link Diretto" : reader.GetString(reader.GetOrdinal("referer")),
                    // o.aff = reader.GetInt32(reader.GetOrdinal("aff"))
                    // o.aff_story = reader.GetInt32(reader.GetOrdinal("aff_story"))
                    // o.referer = reader.GetString(reader.GetOrdinal("referer"))
                    TotalAmount = Convert.ToDecimal(objSqlHelper.ExecuteScalar("ESK_GetOrderAmount", new SqlParameter("@orderid", reader.GetInt32(reader.GetOrdinal("OrderID")))))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }
        public static List<Order> GetOrders_esito(string customerID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CustomerID", customerID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrders", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    CustomerID = reader.GetString(reader.GetOrdinal("CustomerID")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    esito = reader.IsDBNull(reader.GetOrdinal("esito")) ? "KO" : reader.GetString(reader.GetOrdinal("esito")),
                    TotalAmount = Convert.ToDecimal(objSqlHelper.ExecuteScalar("ESK_GetOrderAmount", new SqlParameter("@orderid", reader.GetInt32(reader.GetOrdinal("OrderID")))))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }
        public static List<Order> GetOrders_top(string customerID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CustomerID", customerID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrders_top", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    CustomerID = reader.GetString(reader.GetOrdinal("CustomerID")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    esito = reader.IsDBNull(reader.GetOrdinal("esito")) ? "KO" : reader.GetString(reader.GetOrdinal("esito")),
                    aff = reader.GetInt32(reader.GetOrdinal("aff")),
                    TotalAmount = Convert.ToDecimal(objSqlHelper.ExecuteScalar("ESK_GetOrderAmount", new SqlParameter("@orderid", reader.GetInt32(reader.GetOrdinal("OrderID")))))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }
        // creo questa funzione per tirar fuori l'ordine appena inserito
        public static List<Order> GetOrders_IDorder(int OrderID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@orderID", OrderID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrders_id", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    CustomerID = reader.GetString(reader.GetOrdinal("CustomerID")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    // pesco l'esito
                    // o.esito = reader.GetString(reader.GetOrdinal("esito"))
                    TotalAmount = Convert.ToDecimal(reader.GetOrdinal("TOTAL")),
                    TotalAmountNoSconto = Convert.ToDecimal(reader.GetOrdinal("TOTALSENZASCONTO")),
                    Giorni = reader.GetString(reader.GetOrdinal("CustomerID"))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }

        // creo questa funzione per tirar fuori l'ordine appena inserito
        public static List<Order> GetOrders_IDorder_testata(int OrderID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@orderID", OrderID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrders_id_testata", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    CustomerID = reader.GetString(reader.GetOrdinal("CustomerID")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    iva = reader.GetDecimal(reader.GetOrdinal("iva")),
                    Trasporto = reader.GetDecimal(reader.GetOrdinal("trasporto"))
                };
                // pesco l'esito
                // o.esito = reader.GetString(reader.GetOrdinal("esito"))
                o.TotalAmount = Convert.ToDecimal(objSqlHelper.ExecuteScalar("ESK_GetOrderAmount", new SqlParameter("@orderid", reader.GetInt32(reader.GetOrdinal("OrderID"))))) + o.Trasporto;
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }

        public static List<OrderItem> GetOrderItems(int orderID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@OrderID", orderID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrderItems", objParams);
            List<OrderItem> objList = new List<OrderItem>();
            while (reader.Read())
            {
                OrderItem o = new OrderItem
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    ProductID = reader.GetString(reader.GetOrdinal("ProductID")),
                    ProductName = reader.GetString(reader.GetOrdinal("ProductName")),
                    Quantity = reader.GetInt32(reader.GetOrdinal("Quantity")),
                    UnitCost = reader.GetDecimal(reader.GetOrdinal("UnitCost")),
                    TotCost = reader.GetDecimal(reader.GetOrdinal("TotCost")),
                    IdContattoRM = reader.GetInt32(reader.GetOrdinal("IdContattoRM")),
                    NomeContattoRM = reader.GetString(reader.GetOrdinal("NomeContattoRM")),
                    Quota = reader.GetDecimal(reader.GetOrdinal("Quota")),
                    QuotaRidotta = reader.GetDecimal(reader.GetOrdinal("QuotaRidotta")),
                    ScontoApplicato = reader.GetString(reader.GetOrdinal("ScontoApplicato")),
                    PercentualeSconto = reader.GetDecimal(reader.GetOrdinal("PercentualeSconto")),
                    TokenAttributi = reader.GetString(reader.GetOrdinal("TokenAttributi")),
                    Giorni = reader.GetString(reader.GetOrdinal("TokenAttributi")),
                    Stagione = reader.GetString(reader.GetOrdinal("Stagione")),
                    RM_VicoliRegistrazioneAnaDescr = reader.GetString(reader.GetOrdinal("RM_VicoliRegistrazioneAnaDescr")),
                    Misura = reader.GetString(reader.GetOrdinal("Misura"))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }

        public static int PlaceOrder(Order o, List<OrderItem> listOI)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[9];
            objParams[0] = new SqlParameter("@CustomerID", o.CustomerID);
            objParams[1] = new SqlParameter("@OrderDate", o.OrderDate);
            objParams[2] = new SqlParameter("@iva", o.iva);
            objParams[3] = new SqlParameter("@trasporto", o.Trasporto);
            objParams[4] = new SqlParameter("@referer", o.referer);
            objParams[5] = new SqlParameter("@aff", o.aff);
            objParams[6] = new SqlParameter("@aff_story", o.aff_story);
            objParams[7] = new SqlParameter("@esito", o.esito);
            objParams[8] = new SqlParameter("@note_customer", o.NoteCustomer);

            o.OrderID = Convert.ToInt32(objSqlHelper.ExecuteScalar("ESK_InsertOrder", objParams).ToString());
            foreach (OrderItem item in listOI)
            {
                SqlParameter[] objParams2 = new SqlParameter[14];
                objParams2[0] = new SqlParameter("@OrderID", o.OrderID);
                objParams2[1] = new SqlParameter("@ProductID", item.ProductID);
                objParams2[2] = new SqlParameter("@ProductName", item.ProductName);
                objParams2[3] = new SqlParameter("@Quantity", item.Quantity);
                objParams2[4] = new SqlParameter("@UnitCost", item.UnitCost);
                objParams2[5] = new SqlParameter("@NomeContattoRM", item.NomeContattoRM);
                objParams2[6] = new SqlParameter("@IdContattoRM", item.IdContattoRM);

                objParams2[7] = new SqlParameter("@Quota", item.Quota);
                objParams2[8] = new SqlParameter("@QuotaRidotta", item.QuotaRidotta);
                objParams2[9] = new SqlParameter("@ScontoApplicato", item.ScontoApplicato);
                objParams2[10] = new SqlParameter("@PercentualeSconto", item.PercentualeSconto);
                objParams2[11] = new SqlParameter("@TokenAttributi", item.TokenAttributi);
                objParams2[12] = new SqlParameter("@Stagione", item.Stagione);

                objParams2[13] = new SqlParameter("@Vincoli", string.Empty);
                // MsgBox(item.UnitCost)
                _ = objSqlHelper.ExecuteNonQuery("ESK_InsertOrderItem", objParams2);
            }
            return o.OrderID;
        }
        public static int UpdateOrder(int orderID, string esito)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@OrderID", orderID);
            objParams[1] = new SqlParameter("@esito", esito);
            _ = objSqlHelper.ExecuteNonQuery("ESK_UpdateOrders", objParams);
            return 1;
        }
        public static List<Order> GetOrdersAmount_stat(int OrderID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@orderID", OrderID);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_GetOrders_id_testata", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    OrderID = reader.GetInt32(reader.GetOrdinal("OrderID")),
                    CustomerID = reader.GetString(reader.GetOrdinal("CustomerID")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    iva = reader.GetDecimal(reader.GetOrdinal("iva")),
                    // pesco l'esito
                    // o.esito = reader.GetString(reader.GetOrdinal("esito"))
                    TotalAmount = Convert.ToDecimal(objSqlHelper.ExecuteScalar("ESK_GetOrderAmount", new SqlParameter("@orderid", reader.GetInt32(reader.GetOrdinal("OrderID")))))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }
        public static bool GetSeRMScontoFamiglia(int IDContatto)
        {

            bool _RetVal = false;

            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];

            objParams[0] = new SqlParameter("@IDContatto", IDContatto);

            if (objSqlHelper.ExecuteNonQueryReturnValue("GetSeRMScontoFamiglia", objParams) == 1)
            {
                _RetVal = true;
            }
            return _RetVal;
        }
        public static List<Order> ClientieAgente_Get(string CodCli)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CodCli", CodCli);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ClientieAgente_Get", objParams);
            List<Order> objList = new List<Order>();
            while (reader.Read())
            {
                Order o = new Order
                {
                    Azienda = reader.GetString(reader.GetOrdinal("Azienda")),
                    EmailAgente = reader.GetString(reader.GetOrdinal("EmailAgente")),
                    EmailCliente = reader.GetString(reader.GetOrdinal("EmailCliente"))
                };
                objList.Add(o);
            }
            reader.Close();
            return objList;
        }
        public static string GetRifIva_V2(string Customer)
        {
            string retval = string.Empty;
            string sqlSelect = @"SELECT        CliFatt1.CodIva
                                 FROM          CliFatt1 INNER JOIN
                                               TabIva ON CliFatt1.CodIva = TabIva.CodIva
                                 WHERE        (TabIva.Aliquota = 0) AND (CodCli = @CodCli)";

            Sql4Gestionale helper = new Sql4Gestionale();
            SqlParameter param = new SqlParameter("@CodCli", Customer);
            SqlDataReader reader = helper.ExecuteReader(sqlSelect, param);

            if (reader.Read())
            {
                retval = string.IsNullOrEmpty(reader["CodIva"] as string) ? retval : reader["CodIva"] as string;
            }

            return retval;
        }


    }
}