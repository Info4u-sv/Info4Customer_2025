using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class PRT_Menu_SA
    {
        public int MenuId { get; set; }
        public int ParentMenuId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Url { get; set; }
        public int DisplayOrder { get; set; }
        public bool IsVisible { get; set; }
        public string material_icons { get; set; }

        public string Color { get; set; }
        public static string GetCurretMenuTitle()
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            List<PRT_Menu_SA> _GetPrt_Menu_det = new List<PRT_Menu_SA>();
            _GetPrt_Menu_det = GetPrt_Menu_det();
            List<PRT_Menu_SA> ReturnRow = _GetPrt_Menu_det.Where(item => item.Url == path + ".aspx").ToList();
            string RetunTxt = string.Empty;
            if (ReturnRow.Count > 0)
            {
                RetunTxt = ReturnRow[0].Title;
            }
            return RetunTxt;
        }
        public static List<PRT_Menu_SA> GetPrt_Menu_det()
        {
            DataTable dt = new DataTable();
            //string CacheTable = "CacheGetPrt_Menu_det";
            List<PRT_Menu_SA> LocalList = new List<PRT_Menu_SA>();
            //if (!CacheHelper.ItemExists(CacheTable))
            if (1 == 1)
            {

                string SqlString = "SELECT * FROM [PRT_Menus]";
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
                            PRT_Menu_SA _objLocal = new PRT_Menu_SA();
                            _objLocal.MenuId = Convert.ToInt32(myReader["MenuId"].ToString());
                            _objLocal.ParentMenuId = Convert.ToInt32(myReader["ParentMenuId"].ToString());
                            _objLocal.Title = Convert.ToString(myReader["Title"].ToString());
                            _objLocal.Description = Convert.ToString(myReader["Description"].ToString());
                            _objLocal.Url = Convert.ToString(myReader["Url"].ToString());
                            _objLocal.DisplayOrder = Convert.ToInt32(myReader["DisplayOrder"].ToString());
                            _objLocal.IsVisible = Convert.ToBoolean(myReader["IsVisible"].ToString());
                            _objLocal.material_icons = Convert.ToString(myReader["material_icons"].ToString());
                            _objLocal.Color = "#" + Convert.ToString(myReader["Color"].ToString());

                            LocalList.Add(_objLocal);
                        }
                    }
                    myReader.Close();
                    myConnection.Close();
                    // CacheHelper.Insert(CacheTable, LocalList);
                }
            }

            return LocalList;
            //return CacheHelper.Retrieve<List<PRT_Menu>>(CacheTable);
        }

        public static PRT_Menu_SA GetPrt_Menu_detByNomeCartella(string NomeCartella)
        {
            List<PRT_Menu_SA> _objListFilterd = new List<PRT_Menu_SA>();
            _objListFilterd = PRT_Menu_SA.GetPrt_Menu_det().Where(x => x.Title == NomeCartella).ToList();
            return _objListFilterd[0];

        }
        public static string GetDefaultPage()
        {
            string UrlReturn = string.Empty;
            DataTable dt = new DataTable();
            //string CacheTable = "CachGetDefaultPage";
            //if (!CacheHelper.ItemExists(CacheTable))
            List<PRT_Menu_SA> LocalList = new List<PRT_Menu_SA>();
            if (1 == 1)
            {
                string SqlString = "SELECT * FROM [PRT_Menus] where [DefaultPage] = 1";
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
                            PRT_Menu_SA _objLocal = new PRT_Menu_SA();
                            _objLocal.MenuId = Convert.ToInt32(myReader["MenuId"].ToString());
                            _objLocal.ParentMenuId = Convert.ToInt32(myReader["ParentMenuId"].ToString());
                            _objLocal.Title = Convert.ToString(myReader["Title"].ToString());
                            _objLocal.Description = Convert.ToString(myReader["Description"].ToString());
                            _objLocal.Url = Convert.ToString(myReader["Url"].ToString());
                            _objLocal.DisplayOrder = Convert.ToInt32(myReader["DisplayOrder"].ToString());
                            bool IsVisible = false;
                            if (!string.IsNullOrEmpty(myReader["IsVisible"].ToString())) { IsVisible = Convert.ToBoolean(myReader["IsVisible"].ToString()); }
                            _objLocal.IsVisible = Convert.ToBoolean(IsVisible);
                            _objLocal.material_icons = Convert.ToString(myReader["material_icons"].ToString());
                            LocalList.Add(_objLocal);
                        }
                    }
                    myReader.Close();
                    myConnection.Close();
                    // CacheHelper.Insert(CacheTable, LocalList);
                }
            }
            List<PRT_Menu_SA> LocalListAppoggio = new List<PRT_Menu_SA>();
            LocalListAppoggio = LocalList;
            if (LocalListAppoggio.Count > 0)
            {
                UrlReturn = "~" + LocalListAppoggio[0].Url;
            }
            else
            {
                UrlReturn = "~/Default.aspx";
            }
            return UrlReturn;
        }

    }

}
