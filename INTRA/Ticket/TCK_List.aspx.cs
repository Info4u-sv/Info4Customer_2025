using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ticket
{
    public partial class TCK_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = User.Identity.Name;
            string codCli = username.Split('-')[0];
            Generic_Sql.SelectParameters["CodCli"].DefaultValue = codCli;
            Generic_Sql.DataBind();
        }
    }
}