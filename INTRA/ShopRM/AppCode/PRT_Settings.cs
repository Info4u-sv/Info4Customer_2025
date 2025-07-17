using INTRA.AppCode.Portal;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace INTRA.ShopRM.AppCode
{
    public class SHP_PRT_Setting
    {
        public SHP_PRT_Setting()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }
        protected DataTable GetData()
        {
            string CacheTable = "SHP_PRT_Setting";
            if (!CacheHelper_23.ItemExists(CacheTable))
            {
                DataTable dt = null;

                if (dt == null)
                {
                    dt = new DataTable();
                    using (SqlConnection myConnection = new SqlConnection())
                    {
                        myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                        SqlCommand myCommand = new SqlCommand
                        {
                            Connection = myConnection,
                            CommandText = "Select * from SHP_PRT_Setting"
                        };
                        myConnection.Open();
                        IDataReader reader = myCommand.ExecuteReader();
                        dt.Load(reader);
                        reader.Close();
                        myConnection.Close();
                    }
                }
                CacheHelper_23.Insert(CacheTable, dt);

            }
            return CacheHelper_23.Retrieve<DataTable>(CacheTable);
        }

        public string GetConfigurationValue(Settings setting)
        {
            DataTable dt = GetData();
            string expression;
            expression = "SettingID = " + (int)setting;
            DataRow[] foundRows;
            foundRows = dt.Select(expression);
            string skey = foundRows[0][2].ToString();
            return skey;

        }

        public enum Settings
        {
            SiteName = 2,
            Company = 3,
            CompanyAddress = 5,
            CompanyCity = 6,
            CompanyProvince = 7,
            CompanyPIva = 8,
            CompanyTel = 9,
            CompanyFax = 10,
            CompanyMail = 11,
            PRTMail = 12,
            SmtpServer = 13,
            SmtpUser = 14,
            SmtpPassword = 15,
            MapGoogleLat = 16,
            MapGoogleLong = 17,
            CompanyCap = 18,
            googleAnalytics = 19,
            SpeseTrasporto = 20,
            MetaTitleGlobal = 21,
            MetaDescrGlobal = 22,
            MetaKeywordsGlobal = 23,
            CodiceCat = 24,
            MailNewsLetter = 25,
            NameFromNewsletter = 26,
            NewsLetterSsl = 27,
            NewsLetterObject = 28,
            SiteUrl = 29,
            SogliaSpeseTrasp = 30,
            SpeseTraspOltreSoglia = 31,
            GestioneSpeseTrasp = 32,
            AlertStatsDate = 33,
            AlertStatsRange = 34,
            MailStats = 35,
            MailAssistenza = 36,
            Denom = 37,
            Orari = 38,
            AbilitaMsgConsegna = 39,
            MsgConsegna = 40,
            AbilitaFacebook = 41,
            FacebookLink = 42,
            AbilitaTwitter = 43,
            TwitterLink = 44,
            AbilitaLinkMenuMeno2 = 45,
            LinkMenuMeno2 = 46,
            MsgRitiroPremio = 47,
            DescrCatMeno2 = 48,
            DescrCatMeno1 = 49,
            ECommerce = 50,
            MacroCategoRBList = 51


        }
    }
}