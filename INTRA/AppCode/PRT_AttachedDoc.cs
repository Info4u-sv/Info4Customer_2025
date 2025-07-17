using info4lab;
using System;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class PRT_AttachedDoc
    {
        public int attachedDocID { get; set; }
        public int DocumentoID { get; set; }
        public string CLCCLI { get; set; }
        public string DisplayName { get; set; }
        public string Description { get; set; }
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


        public void PRTAttachedDoc_Insert(PRT_AttachedDoc setting)
        {

            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[9];

            objParams[0] = new SqlParameter("@CLCCLI", setting.CLCCLI);
            objParams[1] = new SqlParameter("@DisplayName", setting.DisplayName);
            objParams[2] = new SqlParameter("@Description", setting.Description);
            objParams[3] = new SqlParameter("@PathFolder", setting.PathFolder);
            objParams[4] = new SqlParameter("@FileName", setting.FileName);
            objParams[5] = new SqlParameter("@FileExtension", setting.FileExtension);
            objParams[6] = new SqlParameter("@Tags", setting.Tags);
            objParams[7] = new SqlParameter("@CreatedUser", setting.CreatedUser);
            objParams[8] = new SqlParameter("@DocumentoID", setting.DocumentoID);
            objSqlHelper.ExecuteNonQueryForNews("PRT_AttachedDoc_Insert", objParams);

        }


        public void PRT_AttachedDoc_Delete(PRT_AttachedDoc setting)
        {

            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[2];

            objParams[0] = new SqlParameter("@DocumentoID", setting.DocumentoID);
            objParams[1] = new SqlParameter("@attachedDocID", setting.attachedDocID);

            objSqlHelper.ExecuteNonQueryForNews("PRT_AttachedDoc_Delete", objParams);
        }

    }
}
