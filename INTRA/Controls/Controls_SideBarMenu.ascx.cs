using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace INTRA.Controls
{
    public partial class Controls_SideBarMenu : System.Web.UI.UserControl
    {
        public string _CategoId { get; set; }
        public string _SubCategoId { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                PopulateMenu();
                //try
                //{
                //    MembershipUser UserLog = Membership.GetUser();
                //    var MyProfile = HttpContext.Current.Profile;

                //}
                //catch { }
            }
        }

        public Tuple<string, string> CreateMenuStyle(string NomeCartella)
        {
            PRT_Menu_SA _obj = new PRT_Menu_SA();
            _obj = PRT_Menu_SA.GetPrt_Menu_detByNomeCartella(NomeCartella);
            return new Tuple<string, string>(_obj.material_icons, _obj.Color);
        }


        private void PopulateMenu()
        {
            // oggi voce di menù è contenuta in un "li" se la voece di menù ha un 
            // sottomenu bisogna Creare un "ul" che contenga le voci di sottomenù

            // controllare se la sessione altrimenti la crea e se esiste 
            HtmlGenericControl li_contenitore;

            if (Session["li_contenitore_Menu"] == null)
            {
                //li.Attributes.Remove("class"
                //li.Attributes.Add("class", "nav sidebar-menu");
                //li.Attributes.Add("id", "nav");
                li_contenitore = new HtmlGenericControl("li");
                IList<PRT_ItemMenu_SA> Items = new List<PRT_ItemMenu_SA>();
                PRT_ItemMenu_SA _obj = new PRT_ItemMenu_SA();
                try
                {
                    System.Web.Security.MembershipUser edtUsr = Membership.GetUser();
                    Items = _obj.GetItemMenu(edtUsr.UserName);
                }
                catch { }

                // Cerco Le voci Padre
                foreach (PRT_ItemMenu_SA i in Items.Where(x => x.ParentId == 0))
                {
                    {
                        HtmlGenericControl a_Parent = new HtmlGenericControl("a");
                        HtmlGenericControl P_ParentColor_Box = new HtmlGenericControl("P");
                        HtmlGenericControl P_Parent_Tit = new HtmlGenericControl("P");
                        HtmlGenericControl i_Parent = new HtmlGenericControl("i");
                        HtmlGenericControl i_MenuExpanded = new HtmlGenericControl("P");
                        HtmlGenericControl b_SubMenuCaret = new HtmlGenericControl("b");
                        b_SubMenuCaret.Attributes.Add("class", "caret"); // freccia espandi menu
                        HtmlGenericControl li_Parent = new HtmlGenericControl("li");

                        // Span e i
                        var Tuple = CreateMenuStyle(i.Title);
                        //< li class="active">
                        //    <a href = "./dashboard.html" >
                        //        < i class="material-icons">dashboard</i>
                        //        <p>Dashboard</p>
                        //    </a>
                        //</li>
                        i_Parent.Attributes.Add("class", Tuple.Item1); //< i class="material-icons"></i>
                        i_Parent.Attributes.Add("style", "color:" + Tuple.Item2);
                        //i_Parent.InnerText = Tuple.Item2; //< i class="material-icons">apps</i>                  
                        P_Parent_Tit.InnerText = i.Title;
                        a_Parent.Attributes["href"] = i.Url;      //    <a href = "./dashboard.html" >
                        a_Parent.Controls.Add(i_Parent);         //        < i class="material-icons">dashboard</i>
                                                                 //        <p>Dashboard</p>

                        // verifico se la categoria ha dei sotto menu'
                        IList<PRT_ItemMenu_SA> Children = Items.Where(x => x.ParentId == i.CategoryId).ToList();
                        if (Children.Count > 0)
                        {
                            b_SubMenuCaret.Attributes.Add("class", "caret"); // freccia espandi menu
                            P_Parent_Tit.Controls.Add(b_SubMenuCaret);
                            a_Parent.Controls.Add(P_Parent_Tit);
                            //<a data-toggle="collapse" href="#pagesExamples">
                            //    <i class="material-icons">image</i>
                            //    <p>Pages
                            //        <b class="caret"></b>
                            //    </p>
                            //</a>
                            a_Parent.Attributes.Add("data-toggle", "collapse");

                            a_Parent.Attributes.Add("class", " accordion-toggle");

                            a_Parent.Attributes.Add("href", "#");
                            a_Parent.Attributes.Add("data-target", "#Catego" + i.CategoryId.ToString());
                            a_Parent.Attributes.Add("data-parent", "#accordion");
                            //a_Parent.Controls.Add(b_SubMenuCaret);
                            //i_MenuExpanded.Attributes.Add("class", "menu-expand");
                            //a_Parent.Controls.Add(i_MenuExpanded);                  

                        }
                        else { a_Parent.Controls.Add(P_Parent_Tit); }

                        a_Parent.Controls.Add(i_MenuExpanded); // se ha un sottomenu   
                        li_Parent.Controls.Add(a_Parent);

                        // find children of the current node
                        if (Children.Count > 0)
                        {
                            li_Parent.Controls.Add(AddChildItem(i.CategoryId, li_Parent, Items, 10));
                        }
                        li_contenitore.Controls.Add(li_Parent);

                    }
                }

                Session["li_contenitore_Menu"] = li_contenitore;

            }
            else
            {
                li_contenitore = Session["li_contenitore_Menu"] as HtmlGenericControl;
            }

            accordion.Controls.Add(li_contenitore);
        }
        private HtmlGenericControl AddChildItem(int childItem, HtmlGenericControl pLi, IList<PRT_ItemMenu_SA> AllMenuItems, int LeftMargin)
        {

            HtmlGenericControl b_SubMenuCaret = new HtmlGenericControl("b");
            b_SubMenuCaret.Attributes.Add("class", "caret"); // freccia espandi menu
            string idCatego = "0";
            if (!string.IsNullOrEmpty(Request.QueryString["CategoId"]))
            {
                idCatego = Request.QueryString["CategoId"];
            }
            string varCodCli = Request.QueryString["codCli"];
            List<PRT_ItemMenu_SA> childItems = (from a in AllMenuItems where a.ParentId == childItem select a).ToList();
            HtmlGenericControl Div_Contenitore_SubMenu = new HtmlGenericControl("div");
            Div_Contenitore_SubMenu.Attributes.Add("class", "collapse");
            Div_Contenitore_SubMenu.Attributes.Add("id", "Catego" + childItem);
            HtmlGenericControl ul_Contenitore_SubMenu = new HtmlGenericControl("ul");
            ul_Contenitore_SubMenu.Attributes.Add("class", "nav");
            foreach (PRT_ItemMenu_SA j in childItems)
            {
                var Tuple = CreateMenuStyle(j.Title);
                HtmlGenericControl li_Child = new HtmlGenericControl("li");
                HtmlGenericControl a_Child = new HtmlGenericControl("a");
                HtmlGenericControl P_Child_Tit = new HtmlGenericControl("P");
                HtmlGenericControl i_MenuExpanded = new HtmlGenericControl("i");
                HtmlGenericControl b_MenuExpanded = new HtmlGenericControl("b");
                HtmlGenericControl P_MenuExpanded = new HtmlGenericControl("P");
                HtmlGenericControl i_Child = new HtmlGenericControl("i");

                //P_Child_Tit.Attributes["class"] = "menu-text"; // <span class="menu-text">Super Admin</span>
                P_Child_Tit.InnerText = j.Title;
                P_Child_Tit.Attributes.Add("class", "tit-menu");

                a_Child.Attributes["href"] = j.Url;
                i_Child.Attributes.Add("class", Tuple.Item1); //< i class="material-icons"></i>
                //i_Child.Attributes.Add("style", "color:" + Tuple.Item2);
                i_Child.Attributes.Add("style", "margin-left:" + LeftMargin + "px; font-size:18px;" + "color:" + Tuple.Item2 + ";");
                //i_Child.InnerText = Tuple.Item2; //< i class="material-icons">apps</i>     
                a_Child.Controls.Add(i_Child);
                List<PRT_ItemMenu_SA> subChilds = (from a in AllMenuItems where a.ParentId == j.CategoryId select a).ToList();
                if (subChilds.Count > 0)
                {

                    b_MenuExpanded.Attributes.Add("class", "caret"); // freccia espandi menu
                    P_Child_Tit.Controls.Add(b_MenuExpanded);
                }
                a_Child.Controls.Add(P_Child_Tit);

                if (subChilds.Count > 0)
                {
                    //b_SubMenuCaret.Attributes.Add("class", "caret"); // freccia espandi menu
                    //P_Child_Tit.Controls.Add(b_SubMenuCaret);

                    //a_Child.Controls.Add(P_Child_Tit);
                    //<a data-toggle="collapse" href="#pagesExamples">
                    //    <i class="material-icons">image</i>
                    //    <p>Pages
                    //        <b class="caret"></b>
                    //    </p>
                    //</a>
                    a_Child.Attributes.Add("data-toggle", "collapse");
                    //a_Child.Attributes.Add("href", "#Catego" + j.CategoryId.ToString());
                    a_Child.Attributes.Add("href", "#");
                    a_Child.Attributes.Add("class", " accordion-toggle");
                    a_Child.Attributes.Add("data-target", "#Catego" + j.CategoryId.ToString());
                    a_Child.Attributes.Add("data-parent", "#Catego" + childItem);

                    ////a_Parent.Controls.Add(b_SubMenuCaret);
                    ////i_MenuExpanded.Attributes.Add("class", "menu-expand");
                    ////a_Parent.Controls.Add(i_MenuExpanded);                  
                    //i_MenuExpanded.Attributes.Add("class", "menu-expand");
                    //a_Child.Controls.Add(i_MenuExpanded);
                    //a_Child.Attributes.Add("class", "menu-dropdown");
                    //P_MenuExpanded.Attributes.Add("class", "caret caret-custom");
                    //P_MenuExpanded.Attributes.Add("class", " caret-custom ");
                    a_Child.Controls.Add(P_MenuExpanded); // se ha un sottomenu   
                    li_Child.Controls.Add(a_Child);
                }
                else
                {
                    //P_Child_Tit.Controls.Add(b_SubMenuCaret);
                    a_Child.Controls.Add(P_Child_Tit);
                }
                //i_MenuExpanded.Attributes.Add("class", "caret");
                a_Child.Controls.Add(i_MenuExpanded); // se ha un sottomenu   
                li_Child.Controls.Add(a_Child);
                // questa chiamata forse è sbagliata perchè sevo noctrollare se il sotto sotto menù ha figli
                if (subChilds.Count > 0)
                {
                    li_Child.Controls.Add(AddChildItem(j.CategoryId, li_Child, AllMenuItems, LeftMargin + 10));
                }
                ul_Contenitore_SubMenu.Controls.Add(li_Child);
                Div_Contenitore_SubMenu.Controls.Add(ul_Contenitore_SubMenu);



            }
            return Div_Contenitore_SubMenu;
        }

        protected void SignOut_LinkBt_Click(object sender, EventArgs e)
        {

            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Current.Response.Cache.SetNoStore();

            try
            {
                HttpContext.Current.Session.Abandon();
                FormsAuthentication.SignOut();
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1d);
                HttpContext.Current.Response.Expires = -1000;
                HttpContext.Current.Response.CacheControl = "no-cache";
                //Response.Redirect("login.aspx", true);
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write(ex.Message);
            }
            FormsAuthentication.RedirectToLoginPage();
            //// Response.Redirect("~/Login.aspx");
        }

    }

}