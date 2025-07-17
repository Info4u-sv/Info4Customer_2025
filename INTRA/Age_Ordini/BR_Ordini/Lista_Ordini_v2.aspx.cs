using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Age_Ordini.BR_Ordini
{
    public partial class Lista_Ordini_v2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MembershipUser UserLog = Membership.GetUser();
                bool SuperAdminCheck = Roles.IsUserInRole(UserLog.UserName, "SuperAdmin");
                bool administratorCheck = Roles.IsUserInRole(UserLog.UserName, "Administrator");
                bool UsersCheck = Roles.IsUserInRole(UserLog.UserName, "Users");

                if (!UsersCheck && !administratorCheck && !SuperAdminCheck)
                {
                    NuovoOrdine_Btn.Visible = false;
                }
            }
        }


        protected void ListaOrdini_LinqDts_Selecting(object sender, DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            bool SuperAdminCheck = Roles.IsUserInRole(UserLog.UserName, "SuperAdmin");
            bool administratorCheck = Roles.IsUserInRole(UserLog.UserName, "Administrator");
            bool UsersCheck = Roles.IsUserInRole(UserLog.UserName, "Users");

            if (administratorCheck || SuperAdminCheck)
            {
                ListaOrdini_LINQDataContext db = new ListaOrdini_LINQDataContext();
                e.KeyExpression = "OrdNum";
                e.DefaultSorting = "FlagStampa; FlagEvaso ; OrdNum desc";
                e.QueryableSource = from View_LINQDataSourceOrdini in db.View_LINQDataSourceOrdini.Where(x => x.U_Portale == "P" || x.U_Portale == "A")
                                        //  orderby View_LINQDataSourceOrdini.FlagStampa ascending, View_LINQDataSourceOrdini.FlagEvaso descending, View_LINQDataSourceOrdini.OrdNum descending, View_LINQDataSourceOrdini.OrdDat
                                    select new
                                    {
                                        View_LINQDataSourceOrdini.ID,
                                        View_LINQDataSourceOrdini.OrdNum,
                                        View_LINQDataSourceOrdini.CodCli,
                                        View_LINQDataSourceOrdini.OrdDat,
                                        View_LINQDataSourceOrdini.Denom,
                                        View_LINQDataSourceOrdini.U_User_Web,
                                        View_LINQDataSourceOrdini.Descrizione,
                                        View_LINQDataSourceOrdini.Url,
                                        View_LINQDataSourceOrdini.FlagEvaso,
                                        View_LINQDataSourceOrdini.U_Portale,
                                        View_LINQDataSourceOrdini.DescrAgente,
                                        View_LINQDataSourceOrdini.FlagStampa

                                    };
            }
            else if (UsersCheck)
            {
                if (UserLog.UserName.ToUpper().Contains("AGE_"))
                {
                    ListaOrdini_LINQDataContext db = new ListaOrdini_LINQDataContext();
                    e.KeyExpression = "OrdNum";
                    e.DefaultSorting = "FlagStampa; FlagEvaso ; OrdNum desc";
                    e.QueryableSource = from View_LINQDataSourceOrdini in db.View_LINQDataSourceOrdini.Where(x => x.U_User_Web == UserLog.UserName && (x.U_Portale == "P" || x.U_Portale == "A"))
                                        select new
                                        {
                                            View_LINQDataSourceOrdini.ID,
                                            View_LINQDataSourceOrdini.OrdNum,
                                            View_LINQDataSourceOrdini.CodCli,
                                            View_LINQDataSourceOrdini.OrdDat,
                                            View_LINQDataSourceOrdini.Denom,
                                            View_LINQDataSourceOrdini.U_User_Web,
                                            View_LINQDataSourceOrdini.Descrizione,
                                            View_LINQDataSourceOrdini.Url,
                                            View_LINQDataSourceOrdini.FlagEvaso,
                                            View_LINQDataSourceOrdini.U_Portale,
                                            View_LINQDataSourceOrdini.DescrAgente,
                                            View_LINQDataSourceOrdini.FlagStampa

                                        };
                }
            }
            else if (!UsersCheck && !administratorCheck && !SuperAdminCheck)
            {
                Response.Redirect("~/AccessDenied.aspx");
            }
        }

        protected void ListaOrdini_Grw_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != DevExpress.Web.GridViewRowType.Data)
            {
                return;

            }
            else
            {
                string Descrizione = e.GetValue("Descrizione").ToString();
                bool FlagStampaBool = Convert.ToBoolean(e.GetValue("FlagStampa"));
                if (Descrizione == "INSERITO")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#feb0bc");
                }
                else if (Descrizione == "PARZIALMENTE EVASO")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#f2f28f");
                }
                else if (Descrizione == "EVASO" || Descrizione == "CHIUSO")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#a4e6a4");
                }
                if (!FlagStampaBool)
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#ff0000");
                    e.Row.ForeColor = System.Drawing.Color.FromName("#fff");
                }

            }

        }
    }
}