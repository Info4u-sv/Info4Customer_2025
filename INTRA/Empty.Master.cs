using System;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace INTRA
{
    public partial class Empty : System.Web.UI.MasterPage
    {
        public string NomePagina { get; set; }
        public string MasterRefreshLink { get; set; }
        // fine 
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;
        private static readonly bool isAddPermission = false, isDeletePermission = false, isModifyPermission = false, isReadPermission = false;
        protected void Page_Init(object sender, EventArgs e)
        {

            // The code below helps to protect against XSRF attacks
            HttpCookie requestCookie = Request.Cookies[AntiXsrfTokenKey];
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out Guid requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                HttpCookie responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += Master_Page_PreLoad;
        }

        protected void Master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? string.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? string.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void SignOut_LinkBt_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            try
            {
                Session.Abandon();
                FormsAuthentication.SignOut();
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Buffer = true;
                Response.ExpiresAbsolute = DateTime.Now.AddDays(-1d);
                Response.Expires = -1000;
                Response.CacheControl = "no-cache";
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string xmlfile = Server.MapPath(@"~\App_Data\VersioneIntranet_Tbl.xml");
            if (!IsPostBack)
            {
                string LanguageVar = "it-IT";
                if (Request.Cookies["LanguageGomsilIntra"] != null)
                {
                    LanguageVar = Server.HtmlEncode(Request.Cookies["LanguageGomsilIntra"].Value);
                }
                else
                {
                    HttpCookie cookie = new HttpCookie("LanguageGomsilIntra")
                    {
                        Expires = DateTime.Now.AddDays(10000),
                        Value = LanguageVar
                    };
                    Response.Cookies.Add(cookie);
                }
                Thread.CurrentThread.CurrentCulture = new CultureInfo(LanguageVar);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(LanguageVar);
            }
            XDocument doc = XDocument.Load(xmlfile);
            if (doc.Descendants("TitVers").Last() != null)
            {
                _ = doc.Descendants("TitVers").Last();
            }
            else
            {
            }

            _ = Membership.GetUser();
            _ = HttpContext.Current.Profile;
        }

        protected void SideBarMenu_MenuItemDataBound(object sender, MenuEventArgs e)
        {
            if (e.Item.DataItem is SiteMapNode node && !string.IsNullOrEmpty(node["imageUrl"]))
            {
                e.Item.ImageUrl = node["imageUrl"];
            }

            if (!string.IsNullOrEmpty(e.Item.NavigateUrl) && Request.Url.AbsolutePath.ToLower().Contains(Page.ResolveUrl(e.Item.NavigateUrl.ToLower().Replace(".aspx", string.Empty))))
            {
                e.Item.Selected = true;
            }
        }
        public static void ShowToastr(Page page, string message, string title, string type = "info", bool clearToast = false, string pos = "toast-top-right", bool Sticky = false)
        {
            string toastrScript = string.Format("Notify('{0}','{1}','{2}', '{3}', '{4}', '{5}');", message, title, type, clearToast, pos, Sticky);
            ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "script", toastrScript, true);
        }
    }
}