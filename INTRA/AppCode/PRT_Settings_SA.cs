using System.Data.SqlClient;
using System.Data;
using info4lab;
using System.Data.Common;
using INTRA.AppCode.Portal;
using INTRA.AppCode;

/// <summary>
/// 
/// Descrizione di riepilogo per PRT_Settings
/// </summary>
/// 
namespace info4lab
{
    namespace Portal
    {
        public class Portal4Set
        {
            public enum Settings
            {
                SiteName = 1,
                Company = 2,
                CompanyAddress = 3,
                CompanyCity = 4,
                CompanyProvince = 5,
                CompanyPIva = 6,
                CompanyTel = 7,
                CompanyFax = 8,
                CompanyMail = 9,
                PRTMail = 10,
                SmtpServer = 11,
                SmtpUser = 12,
                SmtpPassword = 13,
                MapGoogleLat = 14,
                MapGoogleLong = 15,
                CompanyCap = 16,
                googleAnalytics = 40,
                SpeseTrasporto = 17,
                MetaTitleGlobal = 18,
                MetaDescrGlobal = 19,
                MetaKeywordsGlobal = 20,
                CodiceCat = 21,
                MailNewsLetter = 22,
                NameFromNewsletter = 23,
                NewsLetterSsl = 24,
                NewsLetterObject = 25,
                SiteUrl = 26,
                privacyReport = 29,
                Version = 30
            }
            public string GetConfigurationValue(Settings setting)
            {
                DataTable dt = GetData();
                string expression;
                Settings SelectEnum = setting;
                int SelectedValue = (int)SelectEnum;

                expression = "SettingID = " + (int)setting;
                DataRow[] foundRows;
                foundRows = dt.Select(expression);
                string skey = "";
                skey = foundRows[0][2].ToString();
                //skey = "";
                return skey;
                //SqlConnection myCnn;
                //SqlCommand myCmd;
                //SqlDataReader myReader;

                //String sSQL = "select * from PRT_Setting where SettingID=" + setting ;
                //myCnn = Sql4Helper.Getinfo4Connection();
                //myCmd = new SqlCommand(sSQL, myCnn);
                //myCnn.Open();
                //myReader = myCmd.ExecuteReader();
                //myReader.Read();
                //sSQL = myReader["Value"].ToString();
                //myCnn.Close();
                //return sSQL;

            }

            //protected DataTable GetData_old()
            //{
            //    DataTable dt = null;
            //    dt = HttpContext.Current.Cache["TabellaInCache"] as DataTable;
            //    //dt = (DataTable)Cache["TabellaInCache"];
            //    if (dt == null)
            //    {
            //        dt = new DataTable();
            //        string strConnection = Sql4Helper.Getinfo4StringConnection();
            //        DbProviderFactory f = DbProviderFactories.GetFactory("System.Data.SqlClient");
            //        using (DbConnection conn = f.CreateConnection())
            //        {
            //            conn.ConnectionString = strConnection;
            //            conn.Open();
            //            DbCommand command = f.CreateCommand();
            //            command.CommandText = "Select * from PRT_Setting";
            //            command.Connection = conn;
            //            IDataReader reader = command.ExecuteReader();
            //            dt.Load(reader);
            //            reader.Close();
            //            conn.Close();
            //        }
            //    }
            //    HttpContext.Current.Cache["TabellaInCache"] = dt;
            //    return dt;
            //}

            protected DataTable GetData()
            {
                string CacheTable = "PRT_Setting";
                if (!INTRA.AppCode.Portal.CacheHelper.ItemExists(CacheTable))
                {
                    DataTable dt = null;
                    //dt = HttpContext.Current.Cache["TabellaInCache"] as DataTable;
                    //dt = (DataTable)Cache["TabellaInCache"];
                    if (dt == null)
                    {
                        dt = new DataTable();
                        string strConnection = Sql4Helper.Getinfo4StringConnection();
                        DbProviderFactory f = DbProviderFactories.GetFactory("System.Data.SqlClient");
                        using (DbConnection conn = f.CreateConnection())
                        {
                            conn.ConnectionString = strConnection;
                            conn.Open();
                            DbCommand command = f.CreateCommand();
                            command.CommandText = "Select * from PRT_Setting";
                            command.Connection = conn;
                            IDataReader reader = command.ExecuteReader();
                            dt.Load(reader);
                            reader.Close();
                            conn.Close();
                        }
                    }
                    CacheHelper.Insert(CacheTable, dt);

                }
                return CacheHelper.Retrieve<DataTable>(CacheTable);
            }//public string GetConfigurationValue()
            //{
            //    throw new NotImplementedException();
            //}
        }

    }
}
/// 



    public class PRT_setting_Manage
    {
        public PRT_setting_Manage()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }


        private int _ReturnID;
        public int ReturnID
        {
            get { return _ReturnID; }
            set { _ReturnID = value; }
        }

        private string _Name;
        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        private string _Value;
        public string Value
        {
            get { return _Value; }
            set { _Value = value; }
        }

        private string _Description;
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        private int _DisplayOrder;
        public int DisplayOrder
        {
            get { return _DisplayOrder; }
            set { _DisplayOrder = value; }
        }

        private bool _SystemParameter;
        public bool SystemParameter
        {
            get { return _SystemParameter; }
            set { _SystemParameter = value; }
        }


        public int InsertPRT_Setting(PRT_setting_Manage setting)
        {

            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[5];

            objParams[0] = new SqlParameter("@Name", setting.Name);
            objParams[1] = new SqlParameter("@Value", setting.Value);
            objParams[2] = new SqlParameter("@Description", setting.Description);
            objParams[3] = new SqlParameter("@DisplayOrder", setting.DisplayOrder);
            objParams[4] = new SqlParameter("@SystemParameter", setting.SystemParameter);

            int LastId = objSqlHelper.ExecuteNonQueryForNews("PRT_Setting_Insert", objParams);
            return LastId;
        }


        public void UpdatePRT_Setting(PRT_setting_Manage setting)
        {

            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[6];

            objParams[0] = new SqlParameter("@Name", setting.Name);
            objParams[1] = new SqlParameter("@Value", setting.Value);
            objParams[2] = new SqlParameter("@Description", setting.Description);
            objParams[3] = new SqlParameter("@DisplayOrder", setting.DisplayOrder);
            objParams[4] = new SqlParameter("@SystemParameter", setting.SystemParameter);
            objParams[5] = new SqlParameter("@ReturnId", setting.ReturnID);

            objSqlHelper.ExecuteNonQueryForNews("PRT_Setting_Edit", objParams);
        }
    }
