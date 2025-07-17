using System;
using System.Data.SqlClient;


namespace INTRA.AppCode
{
    public class SHP_Articoli
    {
        public string CodArt { get; set; }
        public int ProductID { get; set; }
        public decimal Price { get; set; }
        public decimal QuotaRidotta { get; set; }
        public string ScontoApplicato { get; set; }
        public decimal PercentualeSconto { get; set; }
        public string TokenAttributi { get; set; }
        public bool EnableEditQta { get; set; }
        public string CategoScontoQuotaRidotta { get; set; }
        public string Stagione { get; set; }
        public bool GiorniRichiestiFlag { get; set; }
        public int GiorniRichiesti { get; set; }
        public string TokenTipoAttributi { get; set; }
        public int CategoryID { get; set; }
        public string UM { get; set; }
        public string U_Confez_Intra { get; set; }
        public decimal u_pz_lordo { get; set; }
        public string NumDec { get; set; }
        public string RifIva { get; set; }
        public decimal U_Sc2 { get; set; }
        public decimal U_Sc1 { get; set; }

        public string PictureUrl { get; set; }
        public bool Ges_confezione { get; set; }
        public float QtaXConf { get; set; }

        public int SHP_ArticoliCheck(string CodiceArticolo)
        {
            // controlla se nel database esiste già un prodotto con lo stesso codice.
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];

            objParams[0] = new SqlParameter("@CodArt", CodiceArticolo);

            int Controllo = objSqlHelper.ExecuteNonQueryForNews("SHP_ArticoliCheck", objParams);
            return Controllo;
        }

        public static SHP_Articoli GetDettaglioSHP_Articolo(int ProductID, int CategoryID)
        {


            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];

            objParams[0] = new SqlParameter("@ProductID", ProductID);
            objParams[1] = new SqlParameter("@CategoryID", CategoryID);


            SqlDataReader myReader;
            myReader = objSqlHelper.ExecuteReader("GetDettaglioSHP_Articolo", objParams);
            SHP_Articoli _retObj = new SHP_Articoli();
            while (myReader.Read())
            {

                _retObj.CodArt = myReader["ProductCod"].ToString();
                _retObj.Price = Convert.ToDecimal(myReader["Price"].ToString());
                _retObj.QuotaRidotta = Convert.ToDecimal(myReader["QuotaRidotta"].ToString());
                _retObj.PercentualeSconto = Convert.ToDecimal(myReader["PercentualeSconto"].ToString());
                _retObj.TokenAttributi = myReader["TokenAttributi"].ToString();
                _retObj.EnableEditQta = Convert.ToBoolean(myReader["EnableEditQta"].ToString());
                _retObj.CategoScontoQuotaRidotta = myReader["CategoScontoQuotaRidotta"].ToString();
                _retObj.Stagione = myReader["Stagione"].ToString();
                _retObj.GiorniRichiestiFlag = Convert.ToBoolean(myReader["GiorniRichiestiFlag"].ToString());
                _retObj.GiorniRichiesti = _retObj.GiorniRichiestiFlag ? Convert.ToInt32(myReader["GiorniRichiesti"].ToString()) : 0;

                _retObj.TokenTipoAttributi = myReader["TokenTipoAttributi"].ToString();
                _retObj.CategoryID = Convert.ToInt32(CategoryID);

            }
            myReader.Close();
            return _retObj;
        }

        public static int RM_AbilitaSezione_DaVincolo(int IDContatto, string CodVincolo)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];

            objParams[0] = new SqlParameter("@IDContatto", IDContatto);
            objParams[1] = new SqlParameter("@CodVincolo", CodVincolo);

            int AbilitaArea = objSqlHelper.ExecuteNonQueryForNews("RM_AbilitaSezione_DaVincolo", objParams);

            return AbilitaArea;
        }
        public static SHP_Articoli Caglio_GetDettaglioSHP_Articolo(string ProductID, int CategoryID, string CodLis)
        {


            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];

            objParams[0] = new SqlParameter("@ProductID", ProductID);
            objParams[1] = new SqlParameter("@CodLis", CodLis);
            SqlDataReader myReader;
            myReader = objSqlHelper.ExecuteReader("Caglio_GetDettaglioSHP_Articolo_v2", objParams);
            SHP_Articoli _retObj = new SHP_Articoli();
            while (myReader.Read())
            {
                _retObj.CodArt = myReader["ProductCod"].ToString();
                _retObj.Price = Convert.ToDecimal(myReader["Price"].ToString());
                _retObj.QuotaRidotta = 0;
                _retObj.PercentualeSconto = Convert.ToDecimal(myReader["PercentualeSconto"].ToString());
                _retObj.TokenAttributi = myReader["TokenAttributi"].ToString();
                _retObj.CategoScontoQuotaRidotta = myReader["CategoScontoQuotaRidotta"].ToString();
                _retObj.GiorniRichiestiFlag = false;
                _retObj.UM = myReader["units"].ToString();
                _retObj.U_Confez_Intra = myReader["U_Confez_Intra"].ToString();
                _retObj.u_pz_lordo = Convert.ToDecimal(myReader["u_pz_lordo"].ToString());
                _retObj.NumDec = myReader["NumDec"].ToString();
                _retObj.RifIva = myReader["RifIva"].ToString();
                _retObj.U_Sc2 = 0;
                _retObj.U_Sc1 = 0;

                _retObj.PictureUrl = myReader["PictureUrl"].ToString();
                _retObj.TokenTipoAttributi = myReader["TokenTipoAttributi"].ToString();
                _retObj.CategoryID = Convert.ToInt32(CategoryID);
                float _QtaXConf = 1;
                _retObj.QtaXConf = _QtaXConf;
                _retObj.Ges_confezione = false;
            }
            myReader.Close();
            return _retObj;
        }
        public static SHP_Articoli U_GetDettaglioSHP_Articolo(string ProductID, int CategoryID)
        {


            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];

            objParams[0] = new SqlParameter("@ProductID", ProductID);

            SqlDataReader myReader;
            myReader = objSqlHelper.ExecuteReader("U_GetDettaglioSHP_Articolo", objParams);
            SHP_Articoli _retObj = new SHP_Articoli();
            while (myReader.Read())
            {
                _retObj.CodArt = myReader["CodArt"].ToString();
                //_retObj.Price = Convert.ToDecimal(myReader["Price"].ToString());
                //_retObj.QuotaRidotta = 0;
                //_retObj.PercentualeSconto = Convert.ToDecimal(myReader["PercentualeSconto"].ToString());
                //_retObj.TokenAttributi = myReader["TokenAttributi"].ToString();
                //_retObj.CategoScontoQuotaRidotta = myReader["CategoScontoQuotaRidotta"].ToString();
                //_retObj.GiorniRichiestiFlag = false;
                _retObj.UM = myReader["Misura"].ToString();
                //_retObj.U_Confez_Intra = myReader["U_Confez_Intra"].ToString();
                //_retObj.u_pz_lordo = Convert.ToDecimal(myReader["u_pz_lordo"].ToString());
                //_retObj.NumDec = myReader["NumDec"].ToString();
                //_retObj.RifIva = myReader["RifIva"].ToString();
                //_retObj.U_Sc2 = 0;
                //_retObj.U_Sc1 = 0;

                //_retObj.PictureUrl = myReader["PictureUrl"].ToString();
                //_retObj.TokenTipoAttributi = myReader["TokenTipoAttributi"].ToString();
                _retObj.CategoryID = Convert.ToInt32(CategoryID);
                //_retObj.QtaXConf = _QtaXConf;
                _retObj.Ges_confezione = false;
            }
            myReader.Close();
            return _retObj;
        }

    }
}


