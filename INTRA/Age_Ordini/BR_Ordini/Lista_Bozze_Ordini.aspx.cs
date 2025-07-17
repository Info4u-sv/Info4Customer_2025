using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace INTRA.Age_Ordini.BR_Ordini
{
    public partial class Lista_Bozze_Ordini : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void ListaOrdini_LinqDts_Selecting(object sender, DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            var userRoles = Roles.GetRolesForUser(UserLog.UserName);
            bool Agente = false;
            bool Amministratore = false;
            foreach (string role in userRoles)
            {
                if (role.ToUpper() == "ADMINISTRATOR" || role.ToUpper() == "SUPERADMIN")
                {
                    Amministratore = true;
                }

                if (role.ToUpper() == "USERS")
                {
                    Agente = true;
                }
            }

            if (Amministratore)
            {
                U_ViewBozzeOrdini_ViewDataContext db = new U_ViewBozzeOrdini_ViewDataContext();
                e.KeyExpression = "ID";
                e.DefaultSorting = "FlagStampa; FlagEvaso ; ID desc";
                e.QueryableSource = from U_ViewBozzeOrdini_View in db.U_ViewBozzeOrdini_View.Where(x => x.U_Portale == "P")
                                        //  orderby View_LINQDataSourceOrdini.FlagStampa ascending, View_LINQDataSourceOrdini.FlagEvaso descending, View_LINQDataSourceOrdini.OrdNum descending, View_LINQDataSourceOrdini.OrdDat
                                    select new
                                    {
                                        U_ViewBozzeOrdini_View.ID,
                                        U_ViewBozzeOrdini_View.CodCli,
                                        U_ViewBozzeOrdini_View.OrdDat,
                                        U_ViewBozzeOrdini_View.Denom,
                                        U_ViewBozzeOrdini_View.U_User_Web,
                                        U_ViewBozzeOrdini_View.Descrizione,
                                        U_ViewBozzeOrdini_View.Url,
                                        U_ViewBozzeOrdini_View.FlagEvaso,
                                        U_ViewBozzeOrdini_View.U_Portale,
                                        U_ViewBozzeOrdini_View.DescrAgente,
                                        U_ViewBozzeOrdini_View.FlagStampa
                                    };
            }
            else if (Agente)
            {
                if (UserLog.UserName.ToUpper().Contains("AGE_"))
                {

                    U_ViewBozzeOrdini_ViewDataContext db = new U_ViewBozzeOrdini_ViewDataContext();
                    e.KeyExpression = "ID";
                    e.DefaultSorting = "FlagStampa; FlagEvaso ; ID desc";
                    e.QueryableSource = from U_ViewBozzeOrdini_View in db.U_ViewBozzeOrdini_View.Where(x => x.U_User_Web == UserLog.UserName && x.U_Portale == "P")
                                        select new
                                        {
                                            U_ViewBozzeOrdini_View.ID,
                                            U_ViewBozzeOrdini_View.CodCli,
                                            U_ViewBozzeOrdini_View.OrdDat,
                                            U_ViewBozzeOrdini_View.Denom,
                                            U_ViewBozzeOrdini_View.U_User_Web,
                                            U_ViewBozzeOrdini_View.Descrizione,
                                            U_ViewBozzeOrdini_View.Url,
                                            U_ViewBozzeOrdini_View.FlagEvaso,
                                            U_ViewBozzeOrdini_View.U_Portale,
                                            U_ViewBozzeOrdini_View.DescrAgente,
                                            U_ViewBozzeOrdini_View.FlagStampa
                                        };
                }
            }
            else if (!Agente && !Amministratore)
            {
                Response.Redirect("~/AccessDenied.aspx");
            }



        }
    }
}