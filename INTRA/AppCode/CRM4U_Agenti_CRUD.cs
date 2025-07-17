using info4lab;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class CRM4U_Agenti_CRUD
    {
        public string ID { get; set; }
        public string CodAge { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public string UsernameIntra { get; set; }


        public void CRM4U_Agenti_Update(CRM4U_Agenti_CRUD _obj)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[3];

            objParams[0] = new SqlParameter("@Nome", _obj.Nome);
            objParams[1] = new SqlParameter("@Cognome", _obj.Cognome);
            objParams[2] = new SqlParameter("@UsernameIntra", _obj.UsernameIntra);
            objSqlHelper.ExecuteNonQueryForNews("CRM4U_Agenti_Update", objParams);


        }
    }

}