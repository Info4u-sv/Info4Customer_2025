using INTRA.Ticket.AppCode;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Ticket
{
    public partial class ViewDoc_EmptyAllegati : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DocViewer.Document = Server.MapPath(AllegatiTck_Gridview.GetRowValues(0, "PathFolder").ToString());

        }
    }
}