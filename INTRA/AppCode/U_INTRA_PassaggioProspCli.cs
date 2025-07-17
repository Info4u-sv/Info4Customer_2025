using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class U_INTRA_PassaggioProspCli
    {
        public int ID { get; set; }
        public string PIva { get; set; }
        public string B2B_Portale { get; set; }
        public string CtoCol { get; set; }
        public string IvaAbituale { get; set; }
        public string CodPag { get; set; }

        public int PassaACliente(U_INTRA_PassaggioProspCli parameters)
        {
            Sql4Gestionale sqlHelper = new Sql4Gestionale();
            SqlParameter[] sqlParameters = new SqlParameter[6];
            sqlParameters[0] = new SqlParameter("@ID", parameters.ID);
            sqlParameters[1] = new SqlParameter("@Piva", parameters.PIva);
            sqlParameters[2] = new SqlParameter("@B2B_Portale", parameters.B2B_Portale);
            sqlParameters[3] = new SqlParameter("@CtoColl", parameters.CtoCol);
            sqlParameters[4] = new SqlParameter("@IvaAbituale", parameters.IvaAbituale);
            sqlParameters[5] = new SqlParameter("@CodPag", parameters.CodPag);

            return sqlHelper.ExecuteNonQuery("U_I_Clienti_Insert", sqlParameters);
        }
    }
}