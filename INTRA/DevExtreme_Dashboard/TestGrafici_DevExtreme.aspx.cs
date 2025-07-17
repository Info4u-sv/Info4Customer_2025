using System;
using System.Collections;
using System.Web.Script.Serialization;

namespace INTRA.DevExtreme_Dashboard
{
    public partial class TestGrafici_DevExtreme : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterScriptObjectFromDataObject(GetDataObject());
        }

        private IEnumerable GetDataObject()
        {
            return new DataHelper().GetItems();
        }
        private void RegisterScriptObjectFromDataObject(IEnumerable dataObject)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string jsonData = serializer.Serialize(dataObject);

            ClientScript.RegisterStartupScript(this.GetType(), "ANY_KEY", string.Format("var chartData = {0};", jsonData), true);
        }
    }
}