////////////////////////////////////Disclaimer////////////////////////////////////////////
//         This library has been wrote by Mohammed Imtiyaz								//	
//////////////////////////////////////////////////////////////////////////////////////////

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for DataControl
/// </summary>
//public class DataControl
//{
//    public DataControl()
//    {
//        //
//        // TODO: Add constructor logic here
//        //
//    }
//    public string IsHtml { get; set; }

//    #region Morris Graph Class
//    public class GraphData
//    {
//        public string value { get; set; }
//        public string label { get; set; }
//    }
//    public class GraphDataList
//    {
//        public List<GraphData> ListOfGraphData { get; set; }
//    }

//    #endregion
//    IEnumerable<Control> FindRecursive(Control c, Func<Control, bool> predicate)
//    {
//        if (predicate(c))
//            yield return c;

//        foreach (var child in c.Controls)
//        {
//            if (predicate((Control)child))
//            {
//                yield return (Control)child;
//            }
//        }

//        foreach (var child in c.Controls)
//            foreach (var match in FindRecursive((Control)child, predicate))
//                yield return match;
//    }
//    public void EnableButton(Page currentPage)
//    {
//        bool IsEdit = false, IsInsert = false, ISDelete = false;

//        MembershipUser UserLog = Membership.GetUser();
//        if (UserLog.UserName != null)
//        {


//            DataTable dtPrivilege = new DataTable();

//            string strPage = currentPage.AppRelativeVirtualPath;
//            strPage = strPage.Replace("~", "");
//            string strPrivileges = "EXEC sp_um_getUserPrivileges_ByUrl '" + UserLog.UserName + "' , '" + strPage + "' ";
//            DataSet dsPrv = DataControl.GetDataSet(strPrivileges);
//            if (dsPrv.Tables[0].Rows.Count > 0)
//            {
//                for (int i = 0; i < dsPrv.Tables[0].Rows.Count; i++)
//                {
//                    IsInsert = bool.Parse(dsPrv.Tables[0].Rows[i]["add_permission"].ToString());
//                    ISDelete = bool.Parse(dsPrv.Tables[0].Rows[i]["delete_permission"].ToString());
//                    IsEdit = bool.Parse(dsPrv.Tables[0].Rows[i]["modify_permission"].ToString());
//                }
//                foreach (Control c in FindRecursive(currentPage, c => ((c is Button) && ((Button)c).Attributes["IsType"] != null) || ((c is LinkButton) && ((LinkButton)c).Attributes["IsType"] != null) || ((c is HtmlAnchor) && ((HtmlAnchor)c).Attributes["IsType"] != null)))
//                {
//                    if ((c is Button))
//                    {
//                        if (((Button)c).Attributes["IsType"] == "Edit")
//                        {
//                            c.Visible = IsEdit;


//                        }
//                        if (((Button)c).Attributes["IsType"] == "Delete")
//                        {
//                            c.Visible = ISDelete;
//                        }
//                        if (((Button)c).Attributes["IsType"] == "Insert")
//                        {
//                            c.Visible = IsInsert;
//                        }
//                    }
//                    if ((c is LinkButton))
//                    {
//                        if (((LinkButton)c).Attributes["IsType"] == "Edit")
//                        {
//                            c.Visible = IsEdit;


//                        }
//                        if (((LinkButton)c).Attributes["IsType"] == "Delete")
//                        {
//                            c.Visible = ISDelete;
//                        }
//                        if (((LinkButton)c).Attributes["IsType"] == "Insert")
//                        {
//                            c.Visible = IsInsert;
//                        }
//                    }


//                    if ((c is HtmlAnchor))
//                    {
//                        if (((HtmlAnchor)c).Attributes["IsType"] == "Edit")
//                        {
//                            IsHtml = ",\"visible\": false";
//                        }
//                        if (((HtmlAnchor)c).Attributes["IsType"] == "Delete")
//                        {
//                            IsHtml = ",\"visible\": false";
//                        }
//                        if (((HtmlAnchor)c).Attributes["IsType"] == "Insert")
//                        {
//                            IsHtml = ",\"visible\": false";
//                        }
//                    }
//                }
//            }
//        }
//    }

//    public static DataSet GetDataSet(string strSQL)
//    {
//        SqlConnection objConn = new SqlConnection();
//        objConn.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
//        if (objConn.State != ConnectionState.Open)
//        {
//            objConn.Open();
//        }
//        SqlDataAdapter objDataAdapter = new SqlDataAdapter(strSQL, objConn);
//        DataSet objDataset = new DataSet();
//        objDataAdapter.Fill(objDataset);
//        objDataset.Dispose();
//        objConn.Close();
//        return objDataset;
//    }

//    public static bool ExecuteNonQuery(string strSQL)
//    {
//        SqlConnection objConn = new SqlConnection(ConfigurationManager.AppSettings["CONN"]);
//        bool IsSuccess = false;

//        if (objConn.State != ConnectionState.Open)
//        {
//            objConn.Open();
//        }
//        SqlCommand objCmd = new SqlCommand(strSQL, objConn);
//        objCmd.CommandType = CommandType.Text;
//        int intResult = objCmd.ExecuteNonQuery();
//        if (intResult >= 1)
//        {
//            IsSuccess = true;
//        }
//        else
//        {
//            IsSuccess = false;
//        }
//        objConn.Close();
//        objCmd.Dispose();
//        return IsSuccess;
//    }

//    public static string Encrypt(string clearText)
//    {
//        try
//        {
//            string EncryptionKey = "MAKV2SPBNI99212";
//            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
//            using (Aes encryptor = Aes.Create())
//            {
//                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
//                encryptor.Key = pdb.GetBytes(32);
//                encryptor.IV = pdb.GetBytes(16);
//                using (MemoryStream ms = new MemoryStream())
//                {
//                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
//                    {
//                        cs.Write(clearBytes, 0, clearBytes.Length);
//                        cs.Close();
//                    }
//                    clearText = Convert.ToBase64String(ms.ToArray());
//                }
//            }
//            return clearText;
//        }
//        catch (Exception ex)
//        {
//            return "0";
//        }
//    }

//    public static string Decrypt(string cipherText)
//    {
//        try
//        {
//            string EncryptionKey = "MAKV2SPBNI99212";

//            cipherText = cipherText.Replace(" ", "+");
//            byte[] cipherBytes = Convert.FromBase64String(cipherText);
//            using (Aes encryptor = Aes.Create())
//            {
//                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
//                encryptor.Key = pdb.GetBytes(32);
//                encryptor.IV = pdb.GetBytes(16);
//                using (MemoryStream ms = new MemoryStream())
//                {
//                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
//                    {
//                        cs.Write(cipherBytes, 0, cipherBytes.Length);
//                        cs.Close();
//                    }
//                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
//                }
//            }
//            return cipherText;
//        }
//        catch (Exception ex)
//        {
//            return "0";
//        }
//    }
//}


public class DataControl
{
    public DataControl()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string IsHtml { get; set; }

    #region Morris Graph Class
    public class GraphData
    {
        public string Value { get; set; }
        public string Label { get; set; }
    }
    public class GraphDataList
    {
        public List<GraphData> ListOfGraphData { get; set; }
    }

    #endregion
    IEnumerable<Control> FindRecursive(Control c, Func<Control, bool> predicate)
    {
        if (predicate(c))
            yield return c;

        foreach (var child in c.Controls)
        {
            if (predicate((Control)child))
            {
                yield return (Control)child;
            }
        }

        foreach (var child in c.Controls)
            foreach (var match in FindRecursive((Control)child, predicate))
                yield return match;
    }
    public void EnableButton(Page currentPage)
    {
        bool IsEdit = false, IsInsert = false, ISDelete = false;

        MembershipUser UserLog = Membership.GetUser();
        if (UserLog.UserName != null)
        {


            DataTable dtPrivilege = new DataTable();

            string strPage = currentPage.AppRelativeVirtualPath;
            strPage = strPage.Replace("~", string.Empty);
            string strPrivileges = "EXEC sp_um_getUserPrivileges_ByUrl '" + UserLog.UserName + "' , '" + strPage + "' ";
            DataSet dsPrv = DataControl.GetDataSet(strPrivileges);
            if (dsPrv.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsPrv.Tables[0].Rows.Count; i++)
                {
                    IsInsert = bool.Parse(dsPrv.Tables[0].Rows[i]["add_permission"].ToString());
                    ISDelete = bool.Parse(dsPrv.Tables[0].Rows[i]["delete_permission"].ToString());
                    IsEdit = bool.Parse(dsPrv.Tables[0].Rows[i]["modify_permission"].ToString());
                }
                foreach (Control c in FindRecursive(currentPage, c => ((c is Button) && ((Button)c).Attributes["IsType"] != null) || ((c is LinkButton) && ((LinkButton)c).Attributes["IsType"] != null) || ((c is HtmlAnchor) && ((HtmlAnchor)c).Attributes["IsType"] != null)))
                {
                    if ((c is Button))
                    {
                        if (((Button)c).Attributes["IsType"] == "Edit")
                        {
                            c.Visible = IsEdit;


                        }
                        if (((Button)c).Attributes["IsType"] == "Delete")
                        {
                            c.Visible = ISDelete;
                        }
                        if (((Button)c).Attributes["IsType"] == "Insert")
                        {
                            c.Visible = IsInsert;
                        }
                    }
                    if ((c is LinkButton))
                    {
                        if (((LinkButton)c).Attributes["IsType"] == "Edit")
                        {
                            c.Visible = IsEdit;


                        }
                        if (((LinkButton)c).Attributes["IsType"] == "Delete")
                        {
                            c.Visible = ISDelete;
                        }
                        if (((LinkButton)c).Attributes["IsType"] == "Insert")
                        {
                            c.Visible = IsInsert;
                        }
                    }


                    if ((c is HtmlAnchor))
                    {
                        if (((HtmlAnchor)c).Attributes["IsType"] == "Edit")
                        {
                            IsHtml = ",\"visible\": false";
                        }
                        if (((HtmlAnchor)c).Attributes["IsType"] == "Delete")
                        {
                            IsHtml = ",\"visible\": false";
                        }
                        if (((HtmlAnchor)c).Attributes["IsType"] == "Insert")
                        {
                            IsHtml = ",\"visible\": false";
                        }
                    }
                }
            }
        }
    }

    public static DataSet GetDataSet(string strSQL)
    {
        SqlConnection objConn = new SqlConnection
        {
            ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString
        };
        if (objConn.State != ConnectionState.Open)
        {
            objConn.Open();
        }
        SqlDataAdapter objDataAdapter = new SqlDataAdapter(strSQL, objConn);
        DataSet objDataset = new DataSet();
        objDataAdapter.Fill(objDataset);
        objDataset.Dispose();
        objConn.Close();
        return objDataset;
    }

    public static bool ExecuteNonQuery(string strSQL)
    {
        SqlConnection objConn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString);
        bool IsSuccess = false;

        if (objConn.State != ConnectionState.Open)
        {
            objConn.Open();
        }
        SqlCommand objCmd = new SqlCommand(strSQL, objConn)
        {
            CommandType = CommandType.Text
        };
        int intResult = objCmd.ExecuteNonQuery();
        if (intResult >= 1)
        {
            IsSuccess = true;
        }
        else
        {
            IsSuccess = false;
        }
        objConn.Close();
        objCmd.Dispose();
        return IsSuccess;
    }

    public static string Encrypt(string clearText)
    {
#pragma warning disable CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
        try
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }
        catch (Exception ex)
        {
            return "0";
        }
#pragma warning restore CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
    }

    public static string Decrypt(string cipherText)
    {
#pragma warning disable CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
        try
        {
            string EncryptionKey = "MAKV2SPBNI99212";

            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
        catch (Exception ex)
        {
            return "0";
        }
#pragma warning restore CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
    }
}