using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest
{
    public partial class Brand_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Generic_gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            e.NewValues["CreatedUser"] = HttpContext.Current.User.Identity.Name;
        }

        protected void Generic_gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            e.NewValues["EditUser"] = HttpContext.Current.User.Identity.Name;
        }
        protected void Generic_Image_CustomCallback(object sender, CallbackEventArgsBase e)
        {
            string imgBase64 = e.Parameter;

            ASPxBinaryImage image = (ASPxBinaryImage)sender;

            string xxx = imgBase64.Replace("data:image/jpeg;base64,", " ");
            byte[] imgByte = Convert.FromBase64String(xxx);

            image.Value = imgByte;

        }
    }
}