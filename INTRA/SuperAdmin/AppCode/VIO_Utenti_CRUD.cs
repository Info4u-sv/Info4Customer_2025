using DevExpress.XtraLayout.Filtering.Templates;
using info4lab;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{

    public class VIO_Utenti_CRUD
    {
        public string ID { get; set; }
        public string UtenteIntranet { get; set; }
        public string EmailContatto { get; set; }
        public Date DataBlocco { get; set; }
        public string Tipologia { get; set; }
        public bool Scaduto { get; set; }
        public string Azienda { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public string CodAge { get; set; }
        public string TipoAge { get; set; }

        public void VIO_Utenti_Update(VIO_Utenti_CRUD _obj)
        {
            Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
            SqlParameter[] objParams = new SqlParameter[4];
            objParams[0] = new SqlParameter("@Nome", _obj.Nome);
            objParams[1] = new SqlParameter("@Cognome", _obj.Cognome);
            objParams[2] = new SqlParameter("@EmailContatto", _obj.EmailContatto);
            objParams[3] = new SqlParameter("@UtenteIntranet", _obj.UtenteIntranet);
            objSqlHelper.ExecuteNonQueryForNews("VIO_Utenti_Update", objParams);
        }

        public static VIO_Utenti_CRUD GetVIO_Utenti_Det(string UserName)
        {
            string SqlString = "Select * FROM [dbo].[VIO_Utenti] where [UtenteIntranet] ='" + UserName + "'";
            VIO_Utenti_CRUD _retObj = new VIO_Utenti_CRUD();
            SqlDataReader reader = new Sql4Helper().ExecuteReader(SqlString);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    _retObj.Tipologia = reader["Tipologia"].ToString();
                    _retObj.CodAge = reader["CodAge"].ToString();
                    _retObj.TipoAge = reader["TipoAge"].ToString();
                }
            }
            return _retObj;
        }

    }
}