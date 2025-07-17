using DevExpress.Web;
using Info4U.Models;
using System;
using System.Data.SqlClient;
using System.Web.Security;

namespace INTRA.Parametri_Cliente_Frontend
{
    public partial class Workflow_Email_Frontend : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView gridview = sender as ASPxGridView;
            Sql4Helper sql4Helper = new Sql4Helper();
            ASPxTokenBox tokenBox = gridview.FindEditFormTemplateControl("Email_Token") as ASPxTokenBox;
            ASPxTextBox Descrizione = gridview.FindEditFormTemplateControl("Descrizione_Txt") as ASPxTextBox;
            if (tokenBox != null)
            {
                foreach (string email in tokenBox.Text.Split(','))
                {
                    if (controllaEmail(email) == string.Empty)
                    {
                        string query = string.Format("INSERT INTO U_Workflow_Email_Ana VALUES (@Email)", email.ToLower());
                        sql4Helper.ExecuteNonQuery(query, new SqlParameter() { ParameterName = "@Email", Value = email.ToLower() });
                    }
                }
                MembershipUser UserLog = Membership.GetUser();
                if (UserLog.UserName != null)
                {
                    Generic_Dts.UpdateParameters["EditUser"].DefaultValue = UserLog.UserName;

                }
                Generic_Dts.UpdateParameters["Email"].DefaultValue = tokenBox.Text.ToLower();
                Generic_Dts.UpdateParameters["Descrizione"].DefaultValue = Descrizione.Text;
                Generic_Dts.DataBind();
            }
        }

        public string controllaEmail(string email)
        {
            string query = string.Format("SELECT Email FROM U_Workflow_Email_Ana WHERE Email = (@Email)", email.ToLower());
            SqlDataReader reader = new Sql4Helper().ExecuteReader(query, new SqlParameter() { ParameterName = "@Email", Value = email.ToLower() });
            if (reader.Read())
            {
                return reader["Email"] as string;
            }
            else
            {
                return string.Empty;
            }
        }
    }
}