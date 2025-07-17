using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.ShopRM.AppCode
{
    public class ESK_ShoppingCart
    {
        public static int ItemIndexLocal(string MenuItemID, decimal qtasel, string CodDep)
        {

            int RetVal = -1;
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            string QueryTxt = @"SELECT IDX      
                              FROM [U_ESK_ShoppingCart]
                              where [ProductID] = '{0}' and Quantity = {1} and U_CodDep = '{2}'";
            QueryTxt = string.Format(QueryTxt, MenuItemID, qtasel.ToString().Replace(",", "."), CodDep);
            SqlDataReader myReader = objSqlHelper.ExecuteReader(QueryTxt, objParams);
            if (myReader.HasRows)
            {
                while (myReader.Read())
                {
                    RetVal = Convert.ToInt32(myReader["IDX"]);
                }
            }
            myReader.Close();
            return RetVal;
        }

        public static decimal ControlloLocal(string MenuItemID, string CodDep)
        {
            //Verifico se nel carrello è già presente l'articolo e in tal caso ritorno la Q.tà
            decimal RetVal = -1;
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[0];
            //objParams[0] = new SqlParameter("@ParentCategoryID", ParentCategoryID);
            string QueryTxt = @"SELECT Quantity      
                              FROM [U_ESK_ShoppingCart]
                              where [ProductID] = '{0}' and U_CodDep = '{1}'";
            QueryTxt = string.Format(QueryTxt, MenuItemID, CodDep);
            SqlDataReader myReader = objSqlHelper.ExecuteReader(QueryTxt, objParams);
            if (myReader.HasRows)
            {
                while (myReader.Read())
                {
                    RetVal = Convert.ToDecimal(myReader["Quantity"]);
                }
            }
            else { RetVal = -1; }
            myReader.Close();
            return RetVal;
        }
        public static void ItemsAddLocal(CartItem NewItem, string CodDep)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[7];
            objParams[0] = new SqlParameter("@U_CodDep", CodDep);
            objParams[1] = new SqlParameter("@Quantity", NewItem.Quantity);
            objParams[2] = new SqlParameter("@ProductID", NewItem.MenuItemID);
            objParams[3] = new SqlParameter("@ProductName", NewItem.ItemName);

            objParams[4] = new SqlParameter("@UM", NewItem.UM);

            objParams[5] = new SqlParameter("@PrevCons", DateTime.Now.Date);

            Sql4Gestionale sql4Gestionale = new Sql4Gestionale();
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CodCli FROM TabDep WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            if (reader.Read())
            {
                objParams[6] = new SqlParameter("@CustomerID", reader["CodCli"]);
            }
            
            _ = objSqlHelper.ExecuteNonQuery("U_ESK_ShoppingCartItem_Insert", objParams);

        }

        public static void ItemsUpdateQtaLocal(string MenuItemID, decimal Quantity, string CodDep)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@U_CodDep", CodDep);
            objParams[1] = new SqlParameter("@Quantity", Quantity);
            objParams[2] = new SqlParameter("@ProductID", MenuItemID);
            _ = objSqlHelper.ExecuteNonQuery("U_ESK_ShoppingCartItem_Update", objParams);

        }


        public static void ItemsDeleteLocal(string MenuItemID, string CodDep)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@U_CodDep", CodDep);
            objParams[1] = new SqlParameter("@ProductID", MenuItemID);

            _ = objSqlHelper.ExecuteNonQuery("U_ESK_ShoppingCartItem_Delete", objParams);

        }

        public static void CartDeleteLocal(string CodDep)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CodDep", CodDep);
            _ = objSqlHelper.ExecuteNonQuery("U_ESK_ShoppingEmptyCart_Delete", objParams);

        }

        public static decimal SubTotalLocal(string CodDep)
        {
            decimal RetVal = 0;

            List<CartItem> _CartList = new List<CartItem>();
            _CartList = FetchCartLocal(CodDep);
            //RetVal = _CartList.Sum(item => item.LineValue);

            return RetVal;
        }

        public static List<CartItem> ReadTotaliLocal(string CodDep)
        {
            List<CartItem> ListLocal = new List<CartItem>();
            try
            {
                CodDep = CodDep.Replace("CodDep=", string.Empty);
                CartItem _objLocal = new CartItem
                {
                    Total = SubTotalLocal(CodDep)
                };
                ListLocal.Add(_objLocal);
            }
            catch (Exception) { }

            return ListLocal;
        }

        public static List<CartItem> FetchCartLocal(string CodDep)
        {
            List<CartItem> ListLocal = new List<CartItem>();

            string QueryTxt = @"SELECT DISTINCT 
                         IDX, CustomerID, U_CodDep, UM, Quantity, ProductID, ProductName, UnitCost, QtaXConf, CreatedOn, Annullato, UnitCostAggiornato, U_Confez_Intra, Sconto, PrevCons, RifIva, NumDec, U_Pz_Lordo, U_Sc1, U_Sc2, 
                         PrezzoPrecedente, CodLis, PictureUrl
FROM            U_ESK_ShoppingCart
WHERE        (U_CodDep = '{0}')";

            //string formatParam = string.IsNullOrEmpty(tecnico) ? CodCli: tecnico;
            QueryTxt = string.Format(QueryTxt, CodDep);
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = QueryTxt
                };
                myConnection.Open();
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {
                        CartItem _objLocal = new CartItem
                        {
                            MenuItemID = Convert.ToString(myReader["ProductID"].ToString()),
                            Quantity = Convert.ToDecimal(myReader["Quantity"].ToString()),
                            ItemName = Convert.ToString(myReader["ProductName"].ToString()),
                            ItemPrice = 0,
                            QtaXConf = 0,
                            UM = Convert.ToString(myReader["UM"].ToString())
                        };
                        decimal LineValue = _objLocal.ItemPrice * _objLocal.Quantity;
                        _objLocal.LineValue = LineValue;
                        ListLocal.Add(_objLocal);

                    }
                }

                return ListLocal;
            }
        }


        public static decimal ESK_ControlloVariazionePrezzoArt_Upd(string CodArt, string customerID, int AggiornaPrezzi)
        {
            decimal NuovoPrezzo = 0;
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();

            SqlParameter[] objParams = new SqlParameter[3];
            objParams[0] = new SqlParameter("@CustomerID", customerID);
            objParams[1] = new SqlParameter("@CodArt", CodArt);
            objParams[2] = new SqlParameter("@AggiornaPrezzi", AggiornaPrezzi);
            SqlDataReader reader = objSqlHelper.ExecuteReader("ESK_ControlloVariazionePrezzoArt_Upd", objParams);
            _ = new List<Order>();
            while (reader.Read())
            {
                NuovoPrezzo = reader["VecchioPrezzo"] is DBNull ? 0 : Convert.ToDecimal(reader["VecchioPrezzo"]);
            }
            reader.Close();
            return NuovoPrezzo;
        }


        public static int ESK_ShoppingCart_VariazionePrezziArt_Update(string customerID)
        {
            PLS_SHPSql4Helper objSqlHelper = new PLS_SHPSql4Helper();

            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@CustomerID", customerID);

            int NuovoPrezzoCount = objSqlHelper.ExecuteNonQueryForNews("ESK_ShoppingCart_VariazionePrezziArt_Update", objParams);

            return NuovoPrezzoCount;
        }
    }
}