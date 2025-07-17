using System;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class KING_CRUD
    {
        public string DescrLog { get; set; }
        public string TabellaLog { get; set; }
        public string UserLog { get; set; }

        #region Deposito
        public string AreaCompetenza { get; set; }
        public string UtenteApertura { get; set; }

        public string CodDep { get; set; }
        #endregion

        #region Giornata
        public int IdGiornata { get; set; }
        public int Status { get; set; }
        public DateTime DataAvvio { get; set; }
        public DateTime DataFine { get; set; }
        public int IdAreaCompetenza { get; set; }
        public int IdTipoRichiesta { get; set; }
        public string NotaTecnica { get; set; }
        public string NoteRiserva { get; set; }
        public string UtenteAperturaGiornata { get; set; }
        public string UtenteChiusuraGiornata { get; set; }

        #endregion

        public void U_KI_ErrorLog_Insert(KING_CRUD setting)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[3];

            objParams[0] = new SqlParameter("@DescrLog", setting.DescrLog);
            objParams[1] = new SqlParameter("@TabellaLog", setting.TabellaLog);
            objParams[2] = new SqlParameter("@UserLog", setting.UserLog);

            objSqlHelper.ExecuteNonQueryForNews("U_KI_ErrorLog_Insert", objParams);

        }

        public void U_Import_B2B()
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[0];

            objSqlHelper.ExecuteNonQueryForNews("U_Import_B2B", objParams);

        }

        public bool EsecuzioneAllineamentXFatturazioneElettronica()
        {

            string SqlString = "SELECT top 1 [CLCCLI] FROM[PRT_DocCategoryVsFolder] where CLCCLI = '' and levelcategory = 0";
            //SqlString = string.Format(SqlString, NuovoIdIntervento);

            bool Exist = false;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
#pragma warning disable CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                bool retVal = false;
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {
                        if (myReader["CLCCLI"] != null)
                        {
                            Exist = true;
                        }
                        //lastIdMacchina = Convert.ToInt32(myReader["IdMacchina"].ToString());

                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            return Exist;
        }

        public bool ObbligatorietaDocumento(string NomeTabella)
        {

            string SqlString = "SELECT obbligatorio FROM [U_KI_APPOGGIO] where NomeTabella = '" + NomeTabella + "'";
            //SqlString = string.Format(SqlString, NuovoIdIntervento);

            bool Obbligatorio = true;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
#pragma warning disable CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                bool retVal = false;
#pragma warning restore CS0219 // La variabile 'retVal' è assegnata, ma il suo valore non viene mai usato
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {
                        if (!Convert.ToBoolean(myReader["obbligatorio"]))
                        {
                            Obbligatorio = false;
                        }
                        //lastIdMacchina = Convert.ToInt32(myReader["IdMacchina"].ToString());

                    }

                }
                myReader.Close();
                myConnection.Close();
            }
            return Obbligatorio;
        }

        public void AllineamentoClientiKING()
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[0];
            // questa store serve per allineare i nuovi clienti inseriti nel gestionale
            objSqlHelper.ExecuteNonQueryForNews("AllineamentoClientiKING", objParams);

        }

        public int U_Giornata_Testata_QRCode_Check(KING_CRUD setting)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@Utente", setting.UtenteAperturaGiornata);
            int ID = objSqlHelper.ExecuteNonQueryForNews("U_Giornata_Testata_QRCode_Check", objParams);
            return ID;
        }

        public int U_Giornata_Testata_Chiudi(KING_CRUD setting)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@Utente", setting.UtenteAperturaGiornata);
            objParams[1] = new SqlParameter("@CodDep", setting.CodDep);
            int ID = objSqlHelper.ExecuteNonQueryForNews("U_Giornata_Testata_Chiudi", objParams);
            return ID;
        }

        public int U_Giornata_Testata_Ins(KING_CRUD setting)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@UtenteApertura", setting.UtenteAperturaGiornata);
            objParams[1] = new SqlParameter("@CodDep", setting.CodDep);
            int ID = objSqlHelper.ExecuteNonQueryForNews("U_Giornata_Testata_Ins", objParams);
            return ID;
        }
    }
}