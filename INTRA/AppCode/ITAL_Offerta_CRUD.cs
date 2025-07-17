using info4lab;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class ITAL_Offerta_CRUD
    {

        public static int ITAL_Offerta_Insert(int IdClienteProspect, string CodAge, string EditUser, bool AgenteEsterno)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[4];

            objParams[0] = new SqlParameter("@IdClienteProspect", IdClienteProspect);
            objParams[1] = new SqlParameter("@CodAge", CodAge);
            objParams[2] = new SqlParameter("@EditUser", EditUser);
            objParams[3] = new SqlParameter("@AgenteEsterno", AgenteEsterno);

            int LastId = objSqlHelper.ExecuteNonQueryForNews("ITAL_Offerta_Insert", objParams);
            return LastId;
        }
    }
}