using System.Data.SqlClient;

namespace INTRA.AppCode
{
    public class GestioneStatusOfferta
    {
        public int ID { get; set; }
        public int PercentualeChiusura { get; set; }
        public int IdChiusura { get; set; }
        public string U_Motivazione { get; set; } = null;
        public string NoteMotivazione { get; set; } = null;
        public int UpdateStatusOfferta(GestioneStatusOfferta settings)
        {
            Sql4Gestionale sqlHelper = new Sql4Gestionale();
            SqlParameter[] parameters = new SqlParameter[5];

            parameters[0] = new SqlParameter("@ID", settings.ID);
            parameters[1] = new SqlParameter("@PercentualeChiusura", settings.PercentualeChiusura);
            parameters[2] = new SqlParameter("@U_Motivazione", settings.U_Motivazione);
            parameters[3] = new SqlParameter("@U_NoteMotivazione", settings.NoteMotivazione);
            parameters[4] = new SqlParameter("@Id_Chiusura", settings.IdChiusura);

            return sqlHelper.ExecuteNonQuery("U_CRM4U_OfferteStatus_Update", parameters);
        }
    }
}