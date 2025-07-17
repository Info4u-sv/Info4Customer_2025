using info4lab;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.Age_Ordini.AppCode
{
    public class PRT_Documenti
    {
        public int CategoryId { get; set; }
        public int DocumentoID { get; set; }
        public string CLCCLI { get; set; }
        public string DisplayName { get; set; }
        public string Description { get; set; }
        public string ITBK_DisplayName { get; set; }
        public string ITBK_Description { get; set; }
        public string PathFolder { get; set; }
        public string FileName { get; set; }
        public string FileExtension { get; set; }
        public DateTime LastSync { get; set; }
        public string Tags { get; set; }
        public string CreatedUser { get; set; }
        public string EditUser { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime UpdatedOn { get; set; }
        public DateTime DeletedOn { get; set; }
        public bool ITBook { get; set; }

        public int PRT_Documenti_Insert(PRT_Documenti setting)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[10];

            objParams[0] = new SqlParameter("@CLCCLI", setting.CLCCLI);
            objParams[1] = new SqlParameter("@DisplayName", setting.DisplayName);
            objParams[2] = new SqlParameter("@Description", setting.Description);
            objParams[3] = new SqlParameter("@Tags", setting.Tags);
            objParams[4] = new SqlParameter("@CreatedUser", setting.CreatedUser);
            objParams[5] = new SqlParameter("@ITBK_DisplayName", setting.ITBK_DisplayName);
            objParams[6] = new SqlParameter("@ITBK_Description", setting.ITBK_Description);
            objParams[7] = new SqlParameter("@CategoryID", setting.CategoryId);
            objParams[8] = new SqlParameter("@PathFolder", setting.PathFolder);
            objParams[9] = new SqlParameter("@ITBook", setting.ITBook);
            int LastId = objSqlHelper.ExecuteNonQueryForNews("PRT_Documenti_Insert", objParams);
            return LastId;
        }


        public void PRT_Documenti_And_Attached_Edit(PRT_Documenti setting)
        {

            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[4];

            objParams[0] = new SqlParameter("@DocumentoID", setting.DocumentoID);
            objParams[1] = new SqlParameter("@CategoryId", setting.CategoryId);
            objParams[2] = new SqlParameter("@EditUser", setting.EditUser);
            objParams[3] = new SqlParameter("@PathFolder", setting.PathFolder);
            objSqlHelper.ExecuteNonQueryForNews("PRT_Documenti_And_Attached_Edit", objParams);
        }
        public void PRT_Documenti_Update(PRT_Documenti setting)
        {

            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[8];

            objParams[0] = new SqlParameter("@DocumentoID", setting.DocumentoID);
            objParams[1] = new SqlParameter("@CLCCLI", setting.CLCCLI);
            objParams[2] = new SqlParameter("@DisplayName", setting.DisplayName);
            objParams[3] = new SqlParameter("@Description", setting.Description);
            objParams[4] = new SqlParameter("@ITBK_DisplayName", setting.ITBK_DisplayName);
            objParams[5] = new SqlParameter("@ITBK_Description", setting.ITBK_Description);
            objParams[6] = new SqlParameter("@EditUser", setting.EditUser);
            objParams[7] = new SqlParameter("@ITBook", setting.ITBook);
            objSqlHelper.ExecuteNonQueryForNews("PRT_Documenti_Update", objParams);
        }
    }
}

