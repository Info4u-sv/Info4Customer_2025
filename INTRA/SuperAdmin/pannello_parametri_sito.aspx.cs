using DevExpress.Web;
using System;
using System.Collections;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;

namespace INTRA.SuperAdmin
{
    public partial class pannello_parametri_sito : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            PRT_setting_Manage_SA setting = new PRT_setting_Manage_SA();
            setting.Name = e.NewValues["Name"].ToString();
            setting.Description = e.NewValues["Description"].ToString();
            setting.Value = e.NewValues["Value"].ToString();
            setting.DisplayOrder = Convert.ToInt32(e.NewValues["DisplayOrder"].ToString());
            setting.SystemParameter = Convert.ToBoolean(e.NewValues["SystemParameter"].ToString());
            setting.ReturnID = Convert.ToInt32(e.NewValues["SettingID"].ToString());
            try
            {
                setting.UpdatePRT_Setting(setting);
            }
            catch (Exception ex)
            {
                string PathIntranetAssoluto = WebConfigurationManager.AppSettings["FolderPath_Intranet_Assoluto"];
                LogFile Errore = new LogFile();
                System.Web.Security.MembershipUser edtUsr = Membership.GetUser();
                Errore.ErrorLog(PathIntranetAssoluto + "\\Error_LogFile\\LogFile", "Errore: " + "  -  " + edtUsr.UserName + "  -  " + ex);
                ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=0");
            }
            ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=1");
        }

        protected void ASPxGridView1_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            PRT_setting_Manage_SA setting = new PRT_setting_Manage_SA();
            setting.Name = e.NewValues["Name"].ToString();
            setting.Description = e.NewValues["Description"].ToString();
            setting.Value = e.NewValues["Value"].ToString();
            setting.DisplayOrder = Convert.ToInt32(e.NewValues["DisplayOrder"].ToString());
            setting.SystemParameter = Convert.ToBoolean(e.NewValues["SystemParameter"].ToString());
            try
            {
                int lastIdSetting = setting.InsertPRT_Setting(setting);
            }
            catch (Exception ex)
            {
                string PathIntranetAssoluto = WebConfigurationManager.AppSettings["FolderPath_Intranet_Assoluto"];
                LogFile Errore = new LogFile();
                System.Web.Security.MembershipUser edtUsr = Membership.GetUser();
                Errore.ErrorLog(PathIntranetAssoluto + "\\Error_LogFile\\LogFile", "Errore: " + "  -  " + edtUsr.UserName + "  -  " + ex);
                ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=0");
            }
            ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=1");
        }
        protected void btnDeleteCache_Click(object sender, EventArgs e)
        {
            foreach (DictionaryEntry de in HttpContext.Current.Cache)
            {
                HttpContext.Current.Cache.Remove((string)de.Key);
            }
            Response.Redirect("pannello_parametri_sito.aspx?Msg=1");
        }
    }
}