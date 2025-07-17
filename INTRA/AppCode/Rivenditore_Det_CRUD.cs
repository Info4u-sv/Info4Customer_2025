using System;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class Rivenditore_Det_CRUD
    {
        /*
          Per prelevare il dettaglio del rivenditore in base al nome utente 
          Esempio di richiamo:
                Rivenditore_Det_CRUD Obj = new Rivenditore_Det_CRUD()[NomeUtente];
          In questo modo quando si crea l'istanza dell'oggetto si valorizzano già tutti i campi.
         */
        public Rivenditore_Det_CRUD this[string utente]
        {
            get
            {
                return GetDettaglioRivenditore(utente);
            }
        }
        public int ID_VIO_Utenti { get; set; }
        public decimal MarginePercent { get; set; }
        public string Denom { get; set; }
        public string Ind { get; set; }
        public string Prov { get; set; }
        public string Loc { get; set; }
        public string Tel { get; set; }
        public string PIva { get; set; }
        public string CodNaz { get; set; }
        public string DsNaz { get; set; }
        public string EMail { get; set; }
        public string Cap { get; set; }
        public string SitoWeb { get; set; }

        public int DetRivenditore_Insert(Rivenditore_Det_CRUD dettaglio)
        {
            Sql4Gestionale helper = new Sql4Gestionale();
            SqlParameter[] parameters = new SqlParameter[12];
            parameters[0] = new SqlParameter("@ID_VIO_Utenti", dettaglio.ID_VIO_Utenti);
            parameters[1] = new SqlParameter("@MarginePercent", dettaglio.MarginePercent);
            parameters[2] = new SqlParameter("@Denom", dettaglio.Denom);
            parameters[3] = new SqlParameter("@Ind", dettaglio.Ind);
            parameters[4] = new SqlParameter("@Prov", dettaglio.Prov);
            parameters[5] = new SqlParameter("@Loc", dettaglio.Loc);
            parameters[6] = new SqlParameter("@Tel", dettaglio.Tel);
            parameters[7] = new SqlParameter("@PIva", dettaglio.PIva);
            parameters[8] = new SqlParameter("@CodNaz", dettaglio.CodNaz);
            parameters[9] = new SqlParameter("@EMail", dettaglio.EMail);
            parameters[10] = new SqlParameter("@Cap", dettaglio.Cap);
            parameters[11] = new SqlParameter("@SitoWeb", dettaglio.SitoWeb);

            return helper.ExecuteNonQuery("ITAL_Det_Rivenditore_Insert", parameters);
        }

        public int DetRivenditore_Update(Rivenditore_Det_CRUD dettaglio)
        {
            Sql4Gestionale helper = new Sql4Gestionale();
            SqlParameter[] parameters = new SqlParameter[12];
            parameters[0] = new SqlParameter("@ID_VIO_Utenti", dettaglio.ID_VIO_Utenti);
            parameters[1] = new SqlParameter("@MarginePercent", dettaglio.MarginePercent);
            parameters[2] = new SqlParameter("@Denom", dettaglio.Denom);
            parameters[3] = new SqlParameter("@Ind", dettaglio.Ind);
            parameters[4] = new SqlParameter("@Prov", dettaglio.Prov);
            parameters[5] = new SqlParameter("@Loc", dettaglio.Loc);
            parameters[6] = new SqlParameter("@Tel", dettaglio.Tel);
            parameters[7] = new SqlParameter("@PIva", dettaglio.PIva);
            parameters[8] = new SqlParameter("@CodNaz", dettaglio.CodNaz);
            parameters[9] = new SqlParameter("@EMail", dettaglio.EMail);
            parameters[10] = new SqlParameter("@Cap", dettaglio.Cap);
            parameters[11] = new SqlParameter("@SitoWeb", dettaglio.SitoWeb);

            return helper.ExecuteNonQuery("ITAL_Det_Rivenditore_Update", parameters);
        }

        private Rivenditore_Det_CRUD GetDettaglioRivenditore(string Utente)
        {
            int IdUtente = GetIdUtente(Utente);
            string sql = $"SELECT MarginePercent,Denom,Ind,Prov,Loc,Tel,PIva,CodNaz,DsNaz,EMail,Cap,SitoWeb FROM ITAL_Det_Rivenditore WHERE  ID_VIO_Utenti = {IdUtente}";
            Rivenditore_Det_CRUD retval = new Rivenditore_Det_CRUD();
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader(sql);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    retval.MarginePercent = (decimal)reader["MarginePercent"];
                    retval.Denom = reader["Denom"].ToString();
                    retval.Ind = reader["Ind"].ToString();
                    retval.Prov = reader["Prov"].ToString();
                    retval.Loc = reader["Loc"].ToString();
                    retval.Tel = reader["Tel"].ToString();
                    retval.PIva = reader["PIva"].ToString();
                    retval.CodNaz = reader["CodNaz"].ToString();
                    retval.DsNaz = reader["DsNaz"].ToString();
                    retval.EMail = reader["EMail"].ToString();
                    retval.Cap = reader["Cap"].ToString();
                    retval.SitoWeb = reader["SitoWeb"].ToString();
                }
            }
            return retval;
        }


        public int GetIdUtente(string Utente)
        {
            int retval = 0;
            string sql = $"SELECT ID FROM VIO_Utenti WHERE UtenteIntranet = '{Utente}'";
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader(sql);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    retval = (int)reader["ID"];
                }
            }

            return retval;
        }
    }
}