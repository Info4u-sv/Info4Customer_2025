using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Web;

namespace INTRA.ShopRM.TecZone
{
    public partial class ClientiTec : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["CodTecnicoCat"] = HttpContext.Current.User.Identity.Name;
        }

        protected void GeneraCookieCli_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {


            HttpCookie CodCLi_cookie = HttpContext.Current.Request.Cookies["CodCli"];
            //HttpCookie CodCLiDett_cookie = HttpContext.Current.Request.Cookies["CodCliDet"];
            string[] DatiCliente = e.Parameter.Split(';')[0].Split('|');
            string action = e.Parameter.Split(';')[1];
            if (CodCLi_cookie != null /*&& CodCLiDett_cookie != null*/)
            {
                PRT_Cookie_Crud_23.RewriteCoockies("CodCli", DatiCliente[0], "Denom", DatiCliente[1]);
            }
            else
            {
                CodCLi_cookie = new HttpCookie("CodCli");
                CodCLi_cookie.Values.Add("CodCli", DatiCliente[0]);
                CodCLi_cookie.Expires = DateTime.MaxValue;
                Response.Cookies.Add(CodCLi_cookie);

                CodCLi_cookie = new HttpCookie("Denom");
                CodCLi_cookie.Values.Add("Denom", DatiCliente[1]);
                CodCLi_cookie.Expires = DateTime.MaxValue;
                Response.Cookies.Add(CodCLi_cookie);
            }

            if (action == "Edit")
            {
                PRT_Cookie_Crud_23.CreateCookie("IsCliente", "true");
                ASPxWebControl.RedirectOnCallback("/ShopRM/TecZone/EditClienteTec.aspx");
            }
            else
            {
                PRT_Cookie_Crud_23.CreateCookie("IsCliente", "false");
                ASPxWebControl.RedirectOnCallback("/ShopRM/default.aspx");
            }
        }


    }
}