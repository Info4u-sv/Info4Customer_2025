using info4lab.Portal;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class ECOM_Giacenze_wish
    {
        public ECOM_Giacenze_wish()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }

        private List<SHP_Product_Responsive> SottoScortaList(int _ValMax)
        {
            _ = new DataTable();

            //if (!CacheHelper_23.ItemExists(CacheTable))
            //{
            //    //int CategoryID = GetCategoryIdByNameRW(NameRw);

            List<SHP_Product_Responsive> _SottoScortaList = new List<SHP_Product_Responsive>();
            _ = new PRT_Ecommerce();
            _ = new SqlCommand();
            _ = new PRT_Ecommerce();
            using (SqlConnection connection = new SqlConnection(Sql4Helper.Getinfo4StringConnection()))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT [ProductId],[ProductCod], [DisplayName], [ProductIdLocal], [Fittizio] , [Giacenza] FROM [SHP_Product] WHERE [Giacenza] <= " + _ValMax, connection))
                {
                    cmd.CommandType = CommandType.Text;
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        SHP_Product_Responsive SHPProduct = new SHP_Product_Responsive();
                        if ((int)reader["Fittizio"] == 1)
                        {
                            SHPProduct.ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"));
                            SHPProduct.ProductIdLocal = reader.GetInt32(reader.GetOrdinal("ProductIdLocal"));
                            SHPProduct.ProductCod = reader.GetString(reader.GetOrdinal("ProductCod"));
                            SHPProduct.DisplayName = reader.GetString(reader.GetOrdinal("DisplayName"));
                            SHPProduct.Giacenza = reader.GetInt32(reader.GetOrdinal("Giacenza"));
                        }
                        else
                        {
                            SHP_Product_Responsive _SHP_Product_Responsive = new SHP_Product_Responsive();

                            // ProductIdLocal è l'id del contatore ProductId del DATABASE REMOTO
                            SHPProduct = _SHP_Product_Responsive.ProdottoReomotoGet(reader.GetInt32(reader.GetOrdinal("ProductId")));
                            // assegno il productid del DATABAE LOCALE
                            SHPProduct.ProductId = reader.GetInt32(reader.GetOrdinal("ProductId"));
                            SHPProduct.Giacenza = reader.GetInt32(reader.GetOrdinal("Giacenza"));

                        }
                        if (SHPProduct.Published)
                        {
                            _SottoScortaList.Add(SHPProduct);
                        }
                    }
                    reader.Close();

                }
                return _SottoScortaList;

            }
        }

        public void AggiornaGiacenzaProdottiOridnati(int OrderID)
        {
            _ = new List<ECOM_Giacenze_wish>();
            using (SqlConnection myConnection = new SqlConnection())
            {

                string SqlString = "SELECT SHP_Product.Giacenza, ESK_OrderDetails.Quantity, ESK_OrderDetails.ProductID FROM SHP_Product INNER JOIN  ESK_OrderDetails ON SHP_Product.ProductId = ESK_OrderDetails.ProductID WHERE (OrderID = " + OrderID + ")";
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = SqlString
                };
                myConnection.Open();
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                {
                }
                else
                {
                    while (myReader.Read())
                    {
                        ECOM_Giacenze_wish GetDati = new ECOM_Giacenze_wish
                        {
                            Quantity = Convert.ToInt32(myReader["Quantity"].ToString()),
                            ProductID = Convert.ToInt32(myReader["ProductID"].ToString()),
                            Giacenza = Convert.ToInt32(myReader["Giacenza"].ToString())
                        };
                        //GetDatiOrdine.Add(GetDati);
                        int Risultato = GetDati.Giacenza - GetDati.Quantity;
                        UpdateGiacenze(Risultato, GetDati.ProductID);
                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            //return GetDatiOrdine;
        }

        public int GiacenzaGet(int _ProductID)
        {
            _ = new SqlCommand();
            int ProdIDVar = 0;
            if (_ProductID > 0)
            {
                using (SqlConnection connection = new SqlConnection(Sql4Helper.Getinfo4StringConnection()))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT [giacenza] FROM [SHP_Product] WHERE [ProductID] = " + _ProductID, connection))
                    {
                        connection.Open();
                        ProdIDVar = (int)cmd.ExecuteScalar();
                    }
                }
            }
            return ProdIDVar;
        }
        public DataTable SottoScortaDataTblGet(int _ValMax)
        {
            _ = new List<SHP_Product_Responsive>();
            List<SHP_Product_Responsive> SHPProductLst = SottoScortaList(_ValMax);
            DataTable table = INTRA.AppCode.CollectionHelper.ConvertTo<SHP_Product_Responsive>(SHPProductLst);
            return table;
        }

        public void UpdateGiacenze(int Val, int Cod)
        {
            _ = new Portal4Set_SA();

            string updateCommand = "UPDATE [SHP_Product] set [Giacenza]= " + Val + " WHERE ProductId =  " + Cod;
            using (SqlConnection connection =
                   new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(updateCommand, connection);
                command.Connection.Open();
                _ = command.ExecuteNonQuery();
            }
        }

        #region Property
        public int Quantity { get; set; }

        public int ProductID { get; set; }

        public int Giacenza { get; set; }

        #endregion




    }
}