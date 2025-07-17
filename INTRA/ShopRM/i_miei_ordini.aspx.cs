using DevExpress.Web;
using System;
using System.Web.Security;

namespace INTRA.ShopRM
{
    public partial class i_miei_ordini : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.Header.DataBind();
            if (!IsPostBack)
            {
                Session["User_Session"] = Membership.GetUser()?.UserName ?? "";
            }
        }

        //protected void ListaOrdini_LinqDts_Selecting(object sender, DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs e)
        //{
        //    MembershipUser UserLog = Membership.GetUser();
        //    var userRoles = Roles.GetRolesForUser(UserLog.UserName);

        //    dynamic MyProfile = (ProfileBase)ProfileBase.Create(UserLog.UserName, true);
        //    string CodCLi = MyProfile.CodCli;
        //    ListaOrdini_LINQDataContext db = new ListaOrdini_LINQDataContext();
        //    e.KeyExpression = "OrdNum";
        //    e.DefaultSorting = "OrdDat desc; FlagStampa; FlagEvaso ; OrdNum desc";
        //    e.QueryableSource = from View_LINQDataSourceOrdini in db.View_LINQDataSourceOrdini.Where(x => x.CodCli == CodCLi)
        //                        select new
        //                        {
        //                            View_LINQDataSourceOrdini.ID,
        //                            View_LINQDataSourceOrdini.OrdNum,
        //                            View_LINQDataSourceOrdini.CodCli,
        //                            View_LINQDataSourceOrdini.OrdDat,
        //                            View_LINQDataSourceOrdini.Denom,
        //                            View_LINQDataSourceOrdini.U_User_Web,
        //                            View_LINQDataSourceOrdini.Descrizione,
        //                            View_LINQDataSourceOrdini.Url,
        //                            View_LINQDataSourceOrdini.FlagEvaso,
        //                            View_LINQDataSourceOrdini.U_Portale,
        //                            View_LINQDataSourceOrdini.DescrAgente,
        //                            View_LINQDataSourceOrdini.FlagStampa

        //                        };
        //}

        protected void ListaOrdini_Grw_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            //if (e.RowType != DevExpress.Web.GridViewRowType.Data)
            //{
            //    return;

            //}
            //else
            //{
            //    string Descrizione = e.GetValue("Descrizione").ToString();
            //    bool FlagStampaBool = Convert.ToBoolean(e.GetValue("FlagStampa"));
            //    if (Descrizione == "INSERITO")
            //    {
            //        e.Row.BackColor = System.Drawing.Color.FromName("#feb0bc");
            //    }
            //    else if (Descrizione == "PARZIALMENTE EVASO")
            //    {
            //        e.Row.BackColor = System.Drawing.Color.FromName("#f2f28f");
            //    }
            //    else if (Descrizione == "EVASO" || Descrizione == "CHIUSO")
            //    {
            //        e.Row.BackColor = System.Drawing.Color.FromName("#a4e6a4");
            //    }
            //    if (!FlagStampaBool)
            //    {
            //        e.Row.BackColor = System.Drawing.Color.FromName("#ff0000");
            //        e.Row.ForeColor = System.Drawing.Color.FromName("#fff");
            //    }

            //}

        }

        protected void Dettaglio_Ordine_Grw_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["IdOrdine_Session"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }
    }
}