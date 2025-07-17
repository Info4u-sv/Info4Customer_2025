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
    public class BollaTest
    {
        public string NumeroBolla { get; set; }
        public string ClienteAssociato { get; set; }
    }
    public partial class DDT_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int IdTestata = (!string.IsNullOrEmpty(Request.QueryString["IdTestata"])) ? Convert.ToInt32(Request.QueryString["IdTestata"]) : 0;
            if(IdTestata != 0)
            {
                if (!IsPostBack)
                {
                    BollaTest bolla = getLableText(IdTestata);
                    TitoloPagina_Lbl.Text = $"Bolla N° <strong style='Color:red'>{bolla.NumeroBolla}</strong> Cliente: <strong style='Color:red'>{bolla.ClienteAssociato}</strong>";
                }
            }
        }

        public BollaTest getLableText(int idTestata)
        {
            string sql = $"SELECT        BolleTest.NumDoc, Clienti.Denom as Cliente FROM BolleTest LEFT OUTER JOIN Clienti ON BolleTest.Cliente = Clienti.CodCli WHERE Id = {idTestata}";
            Sql4Gestionale helper = new Sql4Gestionale();
            BollaTest retval = new BollaTest();
            SqlDataReader reader = helper.ExecuteReader(sql);

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    retval.NumeroBolla = reader["NumDoc"].ToString();
                    retval.ClienteAssociato = reader["Cliente"].ToString();
                }
            }

            return retval;
        }
    }
}