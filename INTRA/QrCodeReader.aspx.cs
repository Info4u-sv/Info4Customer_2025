using DevExpress.Web;
using info4lab;
using INTRA.AppCode;
using INTRA.SuperAdmin.AppCode;
using System;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;

namespace INTRA
{
    public partial class QrCodeReader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //string Username = User.Identity.Name;
                //string DefaultPage = PRT_DefaultPage_SA.GetIntraDefaultPageByUser(Username);
                //UrlHome.HRef = "~" + DefaultPage;
            }

        }

        protected void Accesso_Callbackpnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = HttpContext.Current.Profile;
            string Parametro = e.Parameter as string;
            string pattern = @"^[A-Z]\d{3}$";
            Regex regex = new Regex(pattern);
            if (regex.IsMatch(Parametro))
            {
                KING_CRUD insert = new KING_CRUD
                {
                    CodDep = Parametro,
                    UtenteApertura = UserLog.UserName,
                };
                insert.CodDep = Parametro;
                insert.UtenteApertura = UserLog.UserName;

                SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT TabDep.U_Token, Clienti.Denom, TabDep.U_UltimoControllo_Inventario FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = insert.CodDep });
                if (reader.Read())
                {
                    HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
                    if (CodDep_cookie != null /*&& CodCLiDett_cookie != null*/)
                    {
                        PRT_Cookie_Crud_23.RewriteCoockies("CodDep", insert.CodDep, "Dep_Denom", reader["Denom"] as string, "U_Token", reader["U_Token"] != null ? reader["U_Token"].ToString() : null, "Action_Giornata", null);
                    }
                    else
                    {
                        CodDep_cookie = new HttpCookie("CodDep");
                        CodDep_cookie.Values.Add("CodDep", insert.CodDep);
                        CodDep_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(CodDep_cookie);

                        CodDep_cookie = new HttpCookie("Dep_Denom");
                        CodDep_cookie.Values.Add("Dep_Denom", reader["Denom"] as string);
                        CodDep_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(CodDep_cookie);

                        string s = reader["U_Token"] != null ? reader["U_Token"].ToString() : null;
                        CodDep_cookie = new HttpCookie("U_Token");
                        CodDep_cookie.Values.Add("U_Token", s);
                        CodDep_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(CodDep_cookie);

                        CodDep_cookie = new HttpCookie("Action_Giornata");
                        CodDep_cookie.Values.Add("Action_Giornata", null);
                        CodDep_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(CodDep_cookie);
                    }
                    HttpCookie DataCens_cookie = HttpContext.Current.Request.Cookies["DataCensimento"];
                    DateTime data = reader["U_UltimoControllo_Inventario"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(reader["U_UltimoControllo_Inventario"]);
                    if (DataCens_cookie != null /*&& CodCLiDett_cookie != null*/)
                    {
                        PRT_Cookie_Crud_23.RewriteCoockies("DataCensimento", data.Date.ToString());
                    }
                    else
                    {
                        DataCens_cookie = new HttpCookie("DataCensimento");
                        DataCens_cookie.Values.Add("DataCensimento", data.Date.ToString());
                        DataCens_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(DataCens_cookie);
                    }
                    ASPxWebControl.RedirectOnCallback("/ShopRM/Deposito/Deposito_Dett.aspx?CodDep=" + reader["U_Token"]);
                }
            }
            else
            {
                Errore_Lbl.Text = "Codice deposito non valido.";
                Errore_Lbl.ForeColor = System.Drawing.Color.Red;
            }
        }

    }
}