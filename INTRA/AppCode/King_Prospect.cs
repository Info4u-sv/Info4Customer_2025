using info4lab;
using System.Data;
using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class King_Prospect
    {

        public void AllineaProspectSulKing(int id, string denom)
        {
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[2];
            //nomeClasse.attributo 
            //NomeClasse.metodo()
            objParams[0] = new SqlParameter("@ID", id);
            objParams[1] = new SqlParameter("@Denom", denom);
            objSqlHelper.ExecuteNonQueryForNews("U_INTRA_AllineaProspectSulKing_1_7_3", objParams);



        }
        public void ImportaProspectDaKing(string denom)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@Denom", denom);
            objSqlHelper.ExecuteNonQueryForNews("KING_ImportaProspectDaKing_1_7_3", objParams);
        }

        public SqlDbType ID { get; private set; }

    }
}