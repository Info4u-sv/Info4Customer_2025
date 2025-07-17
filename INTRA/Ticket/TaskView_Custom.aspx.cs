using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ticket
{
    public partial class TaskView_Custom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int i = 2;
            string username = User.Identity.Name;
            string codCli = username.Split('-')[0];
            Generic_Sql.SelectParameters["CodCli"].DefaultValue = codCli;
            Generic_Sql.DataBind();
        }

        public string HiddenEmailChar(object Value)
        {
            string pattern = @"(?<=[\w]{1})[\w-\._\+%]*(?=[\w]{1})";
            string ReturnValue = Regex.Replace(Value.ToString(), pattern, m => new string('*', m.Length));
            return ReturnValue;
        }
        public string HiddenTelChar(object Value)
        {
            string pattern = @"(?<=[\w]{0})[\w-\._\+%]*(?=[\w]{3})";
            string ReturnValue = Regex.Replace(Value.ToString(), pattern, m => new string('*', m.Length));
            return ReturnValue;
        }

        protected void DocumentiView_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            if(e.Parameter == "0")
            {
                iframe1.Src = Allegati_grw.GetRowValues(0, "PathFolder").ToString();
            }
            else
            {
                iframe1.Src = Allegati_grw.GetRowValues(Allegati_grw.FindVisibleIndexByKeyValue(e.Parameter), "PathFolder").ToString();
            }
            
        }
    }
}