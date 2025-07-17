using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class PRT_Privilege_SA
    {
        public int prv_id_pk { get; set; }
        public int form_id_fk { get; set; }
        public string Rules_id_fk { get; set; }
        public bool add_permission { get; set; }
        public bool delete_permission { get; set; }
        public bool modify_permission { get; set; }
        public bool read_permission { get; set; }

        public void PRT_Privilege_Rule_SET(PRT_Privilege_SA _obj)
        {

            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[6];
            objParams[0] = new SqlParameter("@form_id_fk", _obj.form_id_fk);
            objParams[1] = new SqlParameter("@Rules_id_fk", _obj.Rules_id_fk);
            objParams[2] = new SqlParameter("@add_permission", _obj.add_permission);
            objParams[3] = new SqlParameter("@delete_permission", _obj.delete_permission);
            objParams[4] = new SqlParameter("@modify_permission", _obj.modify_permission);
            objParams[5] = new SqlParameter("@read_permission", _obj.read_permission);


            _ = objSqlHelper.ExecuteNonQueryForNews("PRT_Privilege_RulesSetPrivileges", objParams);

        }
        public void tbl_um_privilege_By_UserVsRoles_SET(string @UserName)
        {

            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@UserName", @UserName);
            _ = objSqlHelper.ExecuteNonQueryForNews("tbl_um_privilege_SET_By_UserVsRoles", objParams);

        }
        public void sp_um_DeleteUserPrivileges(string @UserName)
        {

            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@user_id_fk", @UserName);
            _ = objSqlHelper.ExecuteNonQueryForNews("sp_um_DeleteUserPrivileges", objParams);
        }

        public void PRT_Privileges_DELETE_ByFormId(int form_id_fk)
        {

            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@form_id_fk", form_id_fk);
            _ = objSqlHelper.ExecuteNonQueryForNews("PRT_Privileges_DELETE_ByFormId", objParams);
        }

        public static void RM_sp_um_addUserPrivilegesByRuolo(string RoleName, string UserName)
        {
            // aggiunge i privilegi all'utente inserito massivamente 
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@RoleName", RoleName);
            objParams[1] = new SqlParameter("@UserName", UserName);
            _ = objSqlHelper.ExecuteNonQueryForNews("RM_sp_um_addUserPrivilegesByRuolo", objParams);
        }
    }
}