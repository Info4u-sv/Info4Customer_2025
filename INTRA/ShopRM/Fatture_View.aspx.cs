using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM
{
    public partial class Fatture_View : System.Web.UI.Page
    {
        public class FatturaTest
        {
            public string NumeroFattura { get; set; }
            public string ClienteAssociato { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            int IdTestata = (!string.IsNullOrEmpty(Request.QueryString["IdTestata"])) ? Convert.ToInt32(Request.QueryString["IdTestata"]) : 0;
            if (IdTestata != 0)
            {
                if (!IsPostBack)
                {
                    FatturaTest bolla = getLableText(IdTestata);
                    TitoloPagina_Lbl.Text = $"Fattura N° <strong style='Color:red'>{bolla.NumeroFattura}</strong> Cliente: <strong style='Color:red'>{bolla.ClienteAssociato}</strong>";
                }
            }

        }

        public FatturaTest getLableText(int idTestata)
        {
            string sql = $"SELECT        FattTest.NumDoc, Clienti.Denom as Cliente FROM FattTest LEFT OUTER JOIN Clienti ON FattTest.Cliente = Clienti.CodCli WHERE Id = {idTestata}";
            Sql4Gestionale helper = new Sql4Gestionale();
            FatturaTest retval = new FatturaTest();
            SqlDataReader reader = helper.ExecuteReader(sql);

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    retval.NumeroFattura = reader["NumDoc"].ToString();
                    retval.ClienteAssociato = reader["Cliente"].ToString();
                }
            }

            return retval;
        }

    }
}