using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM
{
    public partial class Categorie_Merceologiche : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["CodCli"] = HttpContext.Current.User.Identity.Name.ToUpper();

                dynamic MyProfile = ProfileBase.Create(HttpContext.Current.User.Identity.Name.ToUpper(), true);


                MyProfile.CodCli = HttpContext.Current.User.Identity.Name.ToUpper();

                MyProfile.Save();
                _ = Request.Cookies["MyToken"];
                _ = ConfigurationManager.AppSettings;
            }

        }
    }
}