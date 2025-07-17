using INTRA.AppCode;
using System;
using System.Data.SqlClient;

namespace INTRA.Models
{
    public class JsonGetPorbFatturato
    {
        public decimal? TotaleValoreOff { get; set; }
        public decimal? TotaleProbValOff { get; set; }
        public decimal? ProbPercOfferte { get; set; }

        public static JsonGetPorbFatturato GetStats(int anno)
        {
            string storedName = "U_Calcolo_Probabilità_Fatturato";
            JsonGetPorbFatturato retval = new JsonGetPorbFatturato();
            Sql4Gestionale sqlHelper = new Sql4Gestionale();
            SqlParameter param = new SqlParameter("@Anno", anno);
            SqlDataReader Reader = sqlHelper.ExecuteReader(storedName, param);
            while (Reader.Read())
            {
                if (Reader.HasRows)
                {
                    try
                    {
                        retval.TotaleValoreOff = Convert.ToDecimal(Reader["TotAnno"]);
                        retval.ProbPercOfferte = Convert.ToDecimal(Reader["PercFinaleFat"]);
                        retval.TotaleProbValOff = Convert.ToDecimal(Reader["TotPercValAnno"]);
                    }
                    catch
                    {
                        retval.TotaleValoreOff = null;
                        retval.ProbPercOfferte = null;
                        retval.TotaleProbValOff = null;
                    }
                }
            }
            return retval;
        }
    }
}