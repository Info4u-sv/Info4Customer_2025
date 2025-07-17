using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.SuperAdmin.Parametri
{
    public partial class Parametri_WebConfig : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (var key in ConfigurationManager.AppSettings.AllKeys)
            {
                WebConfig_Combobox.Items.Add(new DevExpress.Web.ListEditItem(key, ConfigurationManager.AppSettings[key]));
            }
        }

        protected void WebConfig_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string key = WebConfig_Combobox.SelectedItem.Text.ToString();
            string value = WebConfig_Textbox.Text;
            System.Configuration.Configuration configFile = null;
            if (System.Web.HttpContext.Current != null)
            {
                configFile =
                    System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");
            }
            else
            {
                configFile =
                    ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            }
            var settings = configFile.AppSettings.Settings;
            if (settings[key] == null)
            {
                settings.Add(key, value);
            }
            else
            {
                settings[key].Value = value;
            }
            configFile.Save(ConfigurationSaveMode.Modified);
            ConfigurationManager.RefreshSection(configFile.AppSettings.SectionInformation.Name);
        }

        //public string ReadSetting(string key)
        //{
        //    var appSettings = ConfigurationManager.AppSettings;
        //    return appSettings[key] ?? string.Empty;
        //}
    }
}