using System;
using System.Configuration;
using System.Data.SqlClient;

namespace INTRA.AppCode
{


    public class CRM4U_Prospect_Customer_CRUD
    {
        #region Proprietà
        public string CodCliGestionale { get; set; }
        public int IdProspect { get; set; }
        public bool Prospect { get; set; }
        public string Societa { get; set; }
        public string Denom { get; set; }
        public string Ind { get; set; }
        public string Prov { get; set; }
        public string Loc { get; set; }
        public string Tel { get; set; }
        public string Fax { get; set; }
        public string Telex { get; set; }
        public string Modem { get; set; }
        public string PIva { get; set; }
        public string Riferim { get; set; }
        public string Cellulare { get; set; }
        public string Zona { get; set; }
        public string U_SitoWeb { get; set; }
        public byte[] U_ImgBigliettoVisita { get; set; }
        public string U_CodAge { get; set; }
        public string Note { get; set; }
        public string Cap { get; set; }
        public string CF { get; set; }
        public string U_Tags { get; set; }
        public bool U_Visitato { get; set; }
        public string U_TipologiaAzienda { get; set; }
        public string Email { get; set; }

        public string CodNaz { get; set; }

        public int CanaleAcquisizione { get; set; }

        public bool IsProspect { get; set; }

        public int Id { get; set; }

        public string Referente { get; set; }
        #endregion

        //public int CRM4U_Prospect_Insert_VAL(CRM4U_Prospect_Customer_CRUD setting)
        //{
        //    int IdReturn = 0;
        //    Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
        //    SqlParameter[] objParams = new SqlParameter[18];

        //    objParams[0] = new SqlParameter("@Denom", setting.Denom);
        //    objParams[1] = new SqlParameter("@Ind", setting.Ind);
        //    objParams[2] = new SqlParameter("@Prov", setting.Prov);
        //    objParams[3] = new SqlParameter("@Loc", setting.Loc);
        //    objParams[4] = new SqlParameter("@Tel", setting.Tel);
        //    objParams[5] = new SqlParameter("@PIva", setting.PIva);
        //    objParams[6] = new SqlParameter("@Note", setting.Note);
        //    objParams[7] = new SqlParameter("@Cap", setting.Cap);
        //    objParams[8] = new SqlParameter("@U_SitoWeb", setting.U_SitoWeb);
        //    objParams[9] = new SqlParameter("@U_ImgBigliettoVisita", setting.U_ImgBigliettoVisita);
        //    objParams[10] = new SqlParameter("@U_CodAge", setting.U_CodAge);
        //    objParams[11] = new SqlParameter("@U_Tags", setting.U_Tags);
        //    objParams[12] = new SqlParameter("@U_Visitato", setting.U_Visitato);
        //    objParams[13] = new SqlParameter("@U_TipologiaAzienda", setting.U_TipologiaAzienda);
        //    objParams[14] = new SqlParameter("@Email", setting.Email);
        //    objParams[15] = new SqlParameter("@CanaleAcquisizione", setting.CanaleAcquisizione);
        //    objParams[16] = new SqlParameter("@CodNaz", setting.CodNaz);
        //    objParams[17] = new SqlParameter("@CondizioniPagamento", setting.CondizioniPagamento);

        //    IdReturn = objSqlHelper.ExecuteNonQueryForNews("CRM4U_Prospect_Insert_1_7_3", objParams);
        //    return IdReturn;
        //}

        public int CRM4U_Prospect_Insert(CRM4U_Prospect_Customer_CRUD setting)
        {
            int IdReturn = 0;
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[14];

            objParams[0] = new SqlParameter("@Denom", setting.Denom);
            objParams[1] = new SqlParameter("@Ind", setting.Ind);
            objParams[2] = new SqlParameter("@Prov", setting.Prov);
            objParams[3] = new SqlParameter("@Loc", setting.Loc);
            objParams[4] = new SqlParameter("@Tel", setting.Tel);
            objParams[5] = new SqlParameter("@PIva", setting.PIva);
            objParams[6] = new SqlParameter("@Note", setting.Note);
            objParams[7] = new SqlParameter("@Cap", setting.Cap);
            objParams[8] = new SqlParameter("@Email", setting.Email);
            objParams[9] = new SqlParameter("@CF", setting.CF);
            objParams[10] = new SqlParameter("@CodNaz", setting.CodNaz);
            objParams[11] = new SqlParameter("@isProspect", setting.IsProspect);
            objParams[12] = new SqlParameter("@U_CodAge", setting.U_CodAge);
            objParams[13] = new SqlParameter("@Referente", setting.Referente);

            IdReturn = objSqlHelper.ExecuteNonQueryForNews("CRM4U_Prospect_Clienti_Insert", objParams);
            return IdReturn;
        }


        public string CRM4U_CodAge_Get(string UtenteIntranet)
        {
            string CodAge = string.Empty;
            string SqlString = "SELECT  [CodAge] FROM  [CRM4U_Agenti] where [UsernameIntra] = '" + @UtenteIntranet + "'";
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
                {
                    retVal = false;
                }
                else
                {
                    while (myReader.Read())
                    {
                        CodAge = myReader["CodAge"].ToString();
                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return CodAge;
        }

        public int GenerateClientFromProsp(int IdProspect)
        {
            Sql4Gestionale connection = new Sql4Gestionale();
            SqlParameter parameter = new SqlParameter("@IdProspect", IdProspect);
            return connection.ExecuteNonQueryForNews("U_INTRA_Genera_Cliente_da_Prospect", parameter);
        }
        public int EliminaProspect(int IdProspect)
        {
            string sql = "DELETE CRM4U_Prospect_Clienti WHERE IDProspect = " + IdProspect;
            return new Sql4Gestionale().ExecuteNonQuery(sql);
        }
        public int CRM4U_Prospect_Edit(CRM4U_Prospect_Customer_CRUD setting)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[12];
            objParams[0] = new SqlParameter("@ID", setting.Id);
            objParams[1] = new SqlParameter("@Denom", setting.Denom);
            objParams[2] = new SqlParameter("@Ind", setting.Ind);
            objParams[3] = new SqlParameter("@Prov", setting.Prov);
            objParams[4] = new SqlParameter("@Loc", setting.Loc);
            objParams[5] = new SqlParameter("@Tel", setting.Tel);
            objParams[6] = new SqlParameter("@PIva", setting.PIva);
            objParams[7] = new SqlParameter("@Cap", setting.Cap);
            objParams[8] = new SqlParameter("@Email", setting.Email);
            objParams[9] = new SqlParameter("@CodNaz", setting.CodNaz);
            objParams[10] = new SqlParameter("@U_CodAge", setting.U_CodAge);
            objParams[11] = new SqlParameter("@Referente", setting.Referente);
            return objSqlHelper.ExecuteNonQuery("U_CRM4U_Prospect_Cliente_Update", objParams);
        }
    }
}