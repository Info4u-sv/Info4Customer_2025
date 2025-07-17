using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;

namespace INTRA.ShopRM
{
    public partial class Catalogo : System.Web.UI.MasterPage
    {
        public int NumGiorni
        {
            get
            {
                if (Session["NumGiorni"] == null)
                {
                    SqlDataReader reader = new Sql4Helper().ExecuteReader("SELECT Value FROM PRT_Parameter WHERE CodParam = 'Tempo_Cens_Dep'");
                    if (reader.Read())
                    {
                        Session["NumGiorni"] = Convert.ToInt32(reader["Value"]);
                    }
                }
                return (int)Session["NumGiorni"];
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {



            if (!IsPostBack)
            {
                //string privactText = PRT_Parameter_23.GetPRT_ParameterValueByCodParam("PrivacyMiele");

                //SuperAdminMiele.AppCode.CAT CatDettaglio = new SuperAdminMiele.AppCode.CAT_CRUD()[HttpContext.Current.User.Identity.Name];

                //privactText = FillPrivacyText(privactText, "{RagSoc}", CatDettaglio.RagSoc, "{SedeLeg}", CatDettaglio.SedeLeg, "{Cap}", CatDettaglio.Cap, "{Local}", CatDettaglio.Local, "{Prov}", CatDettaglio.Prov, "{Email}", CatDettaglio.EMail);

                //PrivacyText_lbl.Text = privactText;
                _ = Request.Cookies["MyToken"];
                _ = ConfigurationManager.AppSettings;
                string TokenQryString = Request.QueryString["Token"];
                if (!string.IsNullOrEmpty(TokenQryString))
                {
                    DateTime now = DateTime.Now;
                    HttpCookie myCookie = new HttpCookie("MyToken")
                    {
                        Value = TokenQryString,
                        Expires = now.AddYears(50)
                    };
                    Response.Cookies.Add(myCookie);

                }
                
                //PRT_Cookie_Crud_23.CreateCookie("privactText", privactText);
                //if (_MyToken == null)
                //{
                //    try
                //    {
                //        if (appSettings["Token"].ToString() != Request.QueryString["Token"].ToString())
                //        {
                //            Response.Redirect("empty.aspx");
                //        }
                //        else
                //        {
                //            DateTime now = DateTime.Now;
                //            HttpCookie myCookie = new HttpCookie("MyToken");
                //            myCookie.Value = appSettings["Token"].ToString();
                //            myCookie.Expires = now.AddYears(50);
                //            Response.Cookies.Add(myCookie);
                //        }
                //    }
                //    catch
                //    {
                //        Response.Redirect("empty.aspx");
                //    }
                //}
                //else
                //{
                //    try
                //    {
                //        if (appSettings["Token"].ToString() != _MyToken.Value.ToString())
                //        {
                //            if (appSettings["Token"].ToString() != Request.QueryString["Token"].ToString())
                //            {
                //                Response.Redirect("empty.aspx");
                //            }
                //            else
                //            {
                //                DateTime now = DateTime.Now;
                //                HttpCookie myCookie = new HttpCookie("MyToken");
                //                myCookie.Value = appSettings["Token"].ToString();
                //                myCookie.Expires = now.AddYears(50);
                //                Response.Cookies.Add(myCookie);
                //            }
                //        }
                //        else
                //        {

                //        }
                //    }
                //    catch
                //    {
                //        Response.Redirect("empty.aspx");
                //    }
                //}
            }
        }

        protected void PrivacyText_lbl_DataBound(object sender, EventArgs e)
        {
        }

        protected void AccettaPrivacy_Callback_Callback(object source, CallbackEventArgs e)
        {
            string UserName = HttpContext.Current.User.Identity.Name;

            string sql = $"UPDATE VIO_Utenti SET PrivacyConfermata = 1,PrivacyDataConferma = GETDATE() WHERE UtenteIntranet = '{UserName}'";
            _ = new Sql4Helper().ExecuteNonQuery(sql);

            PRT_Cookie_Crud_23.RewriteCoockies("ShowPrivacyPopUp", "false");
        }


        protected string FillPrivacyText(string StringToFill, params string[] pairs)
        {
            for (int i = 0; i < pairs.Length; i++)
            {
                if (i % 2 != 0)
                {
                    continue;
                }
                else
                {
                    StringToFill = StringToFill.Replace(pairs[i], pairs[i + 1]);
                }
            }

            return StringToFill;
        }
    }
}