using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM
{
    public partial class Lista_Fatture : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string username = User.Identity.Name;
                string codCli = username.Split('-')[0];

                Fatture_dts.SelectParameters["CodCli"].DefaultValue = codCli;
            }
        }
    }
}