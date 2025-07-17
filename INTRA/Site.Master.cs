using INTRA.SuperAdmin.AppCode;
using System;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace INTRA
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        MembershipUser UserLog = Membership.GetUser();
        public string NomePagina { get; set; }
        public string MasterRefreshLink { get; set; }
        // fine 
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;
        //static bool isAddPermission = false, isDeletePermission = false, isModifyPermission = false, isReadPermission = false;
        protected void Page_Init(object sender, EventArgs e)
        {


            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
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

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
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


                MembershipUser UserLog = Membership.GetUser();
                //bool CommercialeCheck = Roles.IsUserInRole(UserLog.UserName, "Commerciale");


                //HttpCookie myCookie = new HttpCookie("FiltroUtente");
                //string Filtroutente = "%%";

                //if (CommercialeCheck)
                //{
                //    Filtroutente = "%" + UserLog.UserName + "%";
                //}

                //myCookie.Value = Filtroutente;
                //myCookie.Expires = DateTime.Now.AddDays(360d);
                //HttpContext.Current.Response.Cookies.Add(myCookie);

                //FormsAuthentication.SetAuthCookie(UserLog.UserName, false);

                //FiltroUtente_Lbl.Text = Filtroutente;
            }
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
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
                //Response.Redirect("login.aspx", true);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            FormsAuthentication.RedirectToLoginPage();
            //// Response.Redirect("~/Login.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            var MyProfile = HttpContext.Current.Profile;
            string xmlfile = Server.MapPath(@"~\App_Data\VersioneIntranet_2023_Tbl.xml");

            if (!IsPostBack)
            {

                string DefaultPage = PRT_DefaultPage_SA.GetIntraDefaultPageByUser(UserLog.UserName);
                UrlHome.HRef = "~" + DefaultPage;
                UrlHome1.HRef = "~" + DefaultPage;
                A1.HRef = "~" + DefaultPage;


                var doc = XDocument.Load(xmlfile);
                if (doc.Descendants("TitVers").Last() != null)
                {
                    var lastPost = doc.Descendants("TitVers").Last();
                    VersioneIntranet_Lbl.Text = "<strong>" + lastPost.ToString() + " - Lic. N°: " + doc.Descendants("NumeroLic").Last().ToString() + " - " + doc.Descendants("RagSoc").Last().ToString() + "</strong>";
                }
                else
                {
                    VersioneIntranet_Lbl.Text = "Intranet";


                }

                ImgTecnico.Src = MyProfile.GetPropertyValue("ImgTecnico").ToString();
                if (HttpContext.Current.User.IsInRole("Operatore"))
                {
                    Response.Redirect("/ShopRm/default.aspx");
                }
            }
            // ImgAvatar.Src = MyProfile.GetPropertyValue("ImgTecnico").ToString();

        }

        //protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        //{
        //    Context.GetOwinContext().Authentication.SignOut();
        //}

        protected void SideBarMenu_MenuItemDataBound(object sender, MenuEventArgs e)
        {
            var node = e.Item.DataItem as SiteMapNode;

            if (node != null && !string.IsNullOrEmpty(node["imageUrl"]))
                e.Item.ImageUrl = node["imageUrl"];

            if (!string.IsNullOrEmpty(e.Item.NavigateUrl) && Request.Url.AbsolutePath.ToLower().Contains(Page.ResolveUrl(e.Item.NavigateUrl.ToLower().Replace(".aspx", string.Empty))))
            {
                e.Item.Selected = true;
            }

        }


        public static void ShowToastr(Page page, string message, string title, string type = "info", bool clearToast = false, string pos = "toast-top-right", bool Sticky = false)
        {
            string toastrScript = String.Format("Notify('{0}','{1}','{2}', '{3}', '{4}', '{5}');", message, title, type, clearToast, pos, Sticky);
            ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "script", toastrScript, true);
        }

        void SetIsEnableButton()
        {
            //DataControl ObjDataControl = new DataControl();

            //ObjDataControl = ObjDataControl.IsEnableButton(this.Page);
            hfIsEnableButton["IsInsert"] = true;
            hfIsEnableButton["IsEdit"] = true;
            hfIsEnableButton["IsDelete"] = true;
        }

        protected void hfIsEnableButton_Init(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetIsEnableButton();
            }
        }



        public string SetLinkManuale()
        {
            string Url = string.Empty;
            //var CheckRuolo = Roles.GetRolesForUser(UserLog.UserName);
            //Istanze_Generiche GetValue = new Istanze_Generiche();
            //string[] NomeCampi = new string[1];
            //NomeCampi[0] = "ID";
            //string filtro = " UtenteIntranet like '%" + UserLog.UserName + "%'";
            //string NomeTabella = "VIO_Utenti";
            //string[] ValoriReturn;
            //ValoriReturn = GetValue.GetValue_Generic(NomeCampi, filtro, NomeTabella);
            //for (int i = 0; i < CheckRuolo.Count(); i++)
            //{
            //    if (CheckRuolo[i] == "Commerciale")
            //    {
            //        Url = "/VIO_Manuale/Commerciale/Manuale-Violet.pdf";
            //    }
            //    else if (CheckRuolo[i] == "Cliente")
            //    {
            //        Url = "/VIO_Manuale/Cliente/Manuale-Violet.pdf";
            //    }
            //    else if(CheckRuolo[i] != "Commerciale" && CheckRuolo[i] != "Cliente")
            //    {
            //        Url = "/VIO_Manuale/Manuale-Violet.pdf";
            //    }
            //}
            return Url;
        }
    }
}