using info4lab;
using INTRA.AppCode.Portal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class PRT_Parameter
    {
        #region Proprieta
        public int ID { get; set; }
        public string CodParam { get; set; }
        public string Value { get; set; }
        public string Type { get; set; }
        public string Descrizione { get; set; }
        public bool Cookie { get; set; }

        #endregion

        public List<PRT_Parameter> GetPRT_Parameter()
        {
            DataTable dt = new DataTable();
            string CacheTable = "CacheGetPRT_Parameter";
            List<PRT_Parameter> LocalList = new List<PRT_Parameter>();
            string SqlString = "SELECT * FROM [PRT_Parameter]";
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {
                        PRT_Parameter _objLocal = new PRT_Parameter();
                        _objLocal.ID = Convert.ToInt32(myReader["ID"].ToString());
                        _objLocal.CodParam = Convert.ToString(myReader["CodParam"].ToString());


                        //if (HttpContext.Current.Request.Cookies[myReader["CodParam"].ToString()] == null)
                        //{
                        //    HttpCookie myCookie = new HttpCookie(myReader["CodParam"].ToString());
                        //    myCookie[myReader["CodParam"].ToString()] = myReader["Value"].ToString();
                        //    myCookie.Expires = DateTime.Now.AddDays(300d);
                        //    HttpContext.Current.Response.Cookies.Add(myCookie);
                        //    //HttpContext.Current.Cache.Insert(myReader["CodParam"].ToString(), myReader["Value"].ToString());
                        //}
                        _objLocal.Value = Convert.ToString(myReader["Value"].ToString());
                        _objLocal.Type = Convert.ToString(myReader["Type"].ToString());
                        _objLocal.Descrizione = Convert.ToString(myReader["Descrizione"].ToString());
                        LocalList.Add(_objLocal);
                    }
                }
                myReader.Close();
                myConnection.Close();
                CacheHelper.Insert(CacheTable, LocalList);
            }
            return CacheHelper.Retrieve<List<PRT_Parameter>>(CacheTable);
        }
        public PRT_Parameter GetPRT_ParameterClassByCode(string CodParam)
        {
            List<PRT_Parameter> _return = new List<PRT_Parameter>();
            List<PRT_Parameter> _Selectreturn = new List<PRT_Parameter>();
            _Selectreturn = GetPRT_Parameter();
            _return = _Selectreturn.Where(_Selectreturn1 => _Selectreturn1.CodParam == CodParam).ToList();
            return _return[0];
        }
        public string GetPRT_ParameterStringByCode(string CodParam)
        {
            string _ReturnVal = string.Empty;
            PRT_Parameter _obj = new PRT_Parameter();
            _obj = GetPRT_ParameterClassByCode(CodParam);
            _ReturnVal = _obj.Value;
            return _ReturnVal;
        }
        public static string GetPRT_ParameterValueByCodParam(string CodParam)
        {
            string RetVal = GetRowPRT_ParameterByCodParam(CodParam).Value.ToString();
            return RetVal;
        }
        public static PRT_Parameter GetRowPRT_ParameterByCodParam(string CodParam)
        {
            List<PRT_Parameter> _objListFilterd = new List<PRT_Parameter>();
            _objListFilterd = PRT_Parameter.GetLFT_ParameterPeriodiche_List().Where(x => x.CodParam == CodParam).ToList();
            PRT_Parameter _objReturn = new PRT_Parameter();
            _objReturn = _objListFilterd[0];
            return _objReturn;
        }

        public static List<PRT_Parameter> GetLFT_ParameterPeriodiche_List()
        {
            DataTable dt = new DataTable();
            string CacheTable = "CacheGetPRT_Parameter_List";
            if (!CacheHelper.ItemExists(CacheTable) || 1 == 1)
            {
                List<PRT_Parameter> LocalList = new List<PRT_Parameter>();
                string SqlString = "SELECT *  FROM [PRT_Parameter]";
                using (SqlConnection myConnection = new SqlConnection())
                {
                    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = SqlString;
                    myConnection.Open();
                    SqlDataReader myReader = myCommand.ExecuteReader();
                    if (myReader.HasRows)
                    {
                        while (myReader.Read())
                        {
                            PRT_Parameter _objLocal = new PRT_Parameter();
                            _objLocal.ID = Convert.ToInt32(myReader["ID"].ToString());
                            _objLocal.CodParam = myReader["CodParam"].ToString();
                            _objLocal.Value = myReader["Value"].ToString();
                            _objLocal.Type = myReader["Type"].ToString();
                            _objLocal.Descrizione = myReader["Descrizione"].ToString();
                            _objLocal.Cookie = Convert.ToBoolean(myReader["Cookie"].ToString());
                            LocalList.Add(_objLocal);
                        }
                    }
                    myReader.Close();
                    myConnection.Close();
                    CacheHelper.Insert(CacheTable, LocalList);
                }
            }
            return CacheHelper.Retrieve<List<PRT_Parameter>>(CacheTable);
        }
        public static void SetPathAssolutoIntranet()
        {
            string PathAssolutoIntranet = FunzioniGenerali.GetAbsolutePathIntrant();
            //string s = ConfigurationManager.AppSettings["EnableUpdatePathAssolutoIntranet"];
            //if (!String.IsNullOrEmpty(s) && s == "true")
            //{
            // Key exists
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@Value", PathAssolutoIntranet);
            objParams[1] = new SqlParameter("@CodParam", "PathAssolutoIntranet");
            objSqlHelper.ExecuteNonQueryForNews("PRT_Parameter_PathAssolutoIntranet_Set", objParams);
            //}
        }
    }
}