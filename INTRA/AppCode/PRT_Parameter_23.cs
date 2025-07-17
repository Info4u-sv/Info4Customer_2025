using INTRA.AppCode.Portal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class PRT_Parameter_23
    {
        #region Proprieta
        public int ID { get; set; }
        public string CodParam { get; set; }
        public string Value { get; set; }
        public string Type { get; set; }
        public string Descrizione { get; set; }
        public bool Cookie { get; set; }

        #endregion

        public List<PRT_Parameter_23> GetPRT_Parameter()
        {
            _ = new DataTable();
            string CacheTable = "CacheGetPRT_Parameter";
            List<PRT_Parameter_23> LocalList = new List<PRT_Parameter_23>();
            string SqlString = "SELECT * FROM [PRT_Parameter]";
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = SqlString
                };
                myConnection.Open();
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {
                        PRT_Parameter_23 _objLocal = new PRT_Parameter_23
                        {
                            ID = Convert.ToInt32(myReader["ID"].ToString()),
                            CodParam = Convert.ToString(myReader["CodParam"].ToString()),


                            //if (HttpContext.Current.Request.Cookies[myReader["CodParam"].ToString()] == null)
                            //{
                            //    HttpCookie myCookie = new HttpCookie(myReader["CodParam"].ToString());
                            //    myCookie[myReader["CodParam"].ToString()] = myReader["Value"].ToString();
                            //    myCookie.Expires = DateTime.Now.AddDays(300d);
                            //    HttpContext.Current.Response.Cookies.Add(myCookie);
                            //    //HttpContext.Current.Cache.Insert(myReader["CodParam"].ToString(), myReader["Value"].ToString());
                            //}
                            Value = Convert.ToString(myReader["Value"].ToString()),
                            Type = Convert.ToString(myReader["Type"].ToString()),
                            Descrizione = Convert.ToString(myReader["Descrizione"].ToString())
                        };
                        LocalList.Add(_objLocal);
                    }
                }
                myReader.Close();
                myConnection.Close();
                CacheHelper_23.Insert(CacheTable, LocalList);
            }
            return CacheHelper_23.Retrieve<List<PRT_Parameter_23>>(CacheTable);
        }
        public PRT_Parameter_23 GetPRT_ParameterClassByCode(string CodParam)
        {
            List<PRT_Parameter_23> _return = new List<PRT_Parameter_23>();
            List<PRT_Parameter_23> _Selectreturn = new List<PRT_Parameter_23>();
            _Selectreturn = GetPRT_Parameter();
            _return = _Selectreturn.Where(_Selectreturn1 => _Selectreturn1.CodParam == CodParam).ToList();
            return _return[0];
        }
        public string GetPRT_ParameterStringByCode(string CodParam)
        {
            _ = new PRT_Parameter_23();
            PRT_Parameter_23 _obj = GetPRT_ParameterClassByCode(CodParam);
            string _ReturnVal = _obj.Value;
            return _ReturnVal;
        }
        public static string GetPRT_ParameterValueByCodParam(string CodParam)
        {
            string RetVal = GetRowPRT_ParameterByCodParam(CodParam).Value.ToString();
            return RetVal;
        }
        public static PRT_Parameter_23 GetRowPRT_ParameterByCodParam(string CodParam)
        {
            List<PRT_Parameter_23> _objListFilterd = new List<PRT_Parameter_23>();
            _objListFilterd = PRT_Parameter_23.GetLFT_ParameterPeriodiche_List().Where(x => x.CodParam == CodParam).ToList();
            PRT_Parameter_23 _objReturn = new PRT_Parameter_23();
            _objReturn = _objListFilterd[0];
            return _objReturn;
        }

        public static List<PRT_Parameter_23> GetLFT_ParameterPeriodiche_List()
        {
            _ = new DataTable();
            string CacheTable = "CacheGetPRT_Parameter_List";
            if (!CacheHelper_23.ItemExists(CacheTable) || 1 == 1)
            {
                List<PRT_Parameter_23> LocalList = new List<PRT_Parameter_23>();
                string SqlString = "SELECT *  FROM [PRT_Parameter]";
                using (SqlConnection myConnection = new SqlConnection())
                {
                    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                    SqlCommand myCommand = new SqlCommand
                    {
                        Connection = myConnection,
                        CommandText = SqlString
                    };
                    myConnection.Open();
                    SqlDataReader myReader = myCommand.ExecuteReader();
                    if (myReader.HasRows)
                    {
                        while (myReader.Read())
                        {
                            PRT_Parameter_23 _objLocal = new PRT_Parameter_23
                            {
                                ID = Convert.ToInt32(myReader["ID"].ToString()),
                                CodParam = myReader["CodParam"].ToString(),
                                Value = myReader["Value"].ToString(),
                                Type = myReader["Type"].ToString(),
                                Descrizione = myReader["Descrizione"].ToString(),
                                Cookie = Convert.ToBoolean(myReader["Cookie"].ToString())
                            };
                            LocalList.Add(_objLocal);
                        }
                    }
                    myReader.Close();
                    myConnection.Close();
                    CacheHelper_23.Insert(CacheTable, LocalList);
                }
            }
            return CacheHelper_23.Retrieve<List<PRT_Parameter_23>>(CacheTable);
        }
        public static void SetPathAssolutoIntranet()
        {
            string PathAssolutoIntranet = PRT_FunzioniGenerali_23.GetAbsolutePathIntrant();
            //string s = ConfigurationManager.AppSettings["EnableUpdatePathAssolutoIntranet"];
            //if (!String.IsNullOrEmpty(s) && s == "true")
            //{
            // Key exists
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@Value", PathAssolutoIntranet);
            objParams[1] = new SqlParameter("@CodParam", "PathAssolutoIntranet");
            _ = objSqlHelper.ExecuteNonQueryForNews("PRT_Parameter_PathAssolutoIntranet_Set", objParams);
            //}
        }
    }
}