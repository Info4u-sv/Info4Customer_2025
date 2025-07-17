using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Depositi
{
    public partial class Depositi_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlDataReader reader = new Sql4Helper().ExecuteReader("SELECT Value FROM PRT_Parameter WHERE CodParam = 'Tempo_Cens_Dep'");
                if (reader.Read())
                {
                    Session["Giorni_Cens_Session"] = Convert.ToInt32(reader["Value"]);
                }
                reader.Close();
            }
        }

    }
}