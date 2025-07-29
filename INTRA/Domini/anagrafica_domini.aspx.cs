using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Domini
{
    public partial class anagrafica_domini : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void VisualizzaDettagli_Btn_Click(object sender, EventArgs e)
        {
            ASPxButton VisualizzaBtn = sender as ASPxButton;

            Response.Redirect("domini_gest.aspx?idDom=" + VisualizzaBtn.CommandArgument + "&keyName=dominio");
        }

        protected void EliminaDominio_Callback_Callback(object source, CallbackEventArgs e)
        {

            WEB_Domini WEB_DominiDelete = new WEB_Domini();
            string IdDominio = Generic_Gridview.GetRowValues(Convert.ToInt32(e.Parameter), "IdDominio").ToString();

            WEB_DominiDelete.IdDominio = IdDominio.ToString();
            WEB_DominiDelete.DeleteWEB_Domini(WEB_DominiDelete);
        }

        protected void VisualizzaDettaglio_Callback_Callback(object source, CallbackEventArgs e)
        {
            string IdDominio = Generic_Gridview.GetRowValues(Convert.ToInt32(e.Parameter), "IdDominio").ToString();
            ASPxWebControl.RedirectOnCallback("domini_gest.aspx?idDom=" + IdDominio + "&keyName=dominio");
        }

        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            WEB_Domini aggiorna = new WEB_Domini();

            //passaggio parametri
            aggiorna.URL = e.NewValues["URL"].ToString();
            aggiorna.DataAttivazione = Convert.ToDateTime(e.NewValues["DataAttivazione"]);
            aggiorna.DataScadenza = Convert.ToDateTime(e.NewValues["DataScadenza"]);
            aggiorna.Provider = e.NewValues["Provider"].ToString();
            aggiorna.IdDominio = e.Keys["IdDominio"].ToString();
            MembershipUser edtUsr = Membership.GetUser();
            aggiorna.EditUser = edtUsr.UserName;

            aggiorna.UpdateWEB_Domini(aggiorna);
        }

        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            WEB_Domini inserisci = new WEB_Domini();
            inserisci.URL = e.NewValues["URL"].ToString();
            inserisci.DataAttivazione = Convert.ToDateTime(e.NewValues["DataAttivazione"]);
            inserisci.DataScadenza = Convert.ToDateTime(e.NewValues["DataScadenza"]);
            inserisci.Provider = e.NewValues["Provider"].ToString();
            MembershipUser edtUsr = Membership.GetUser();
            inserisci.EditUser = edtUsr.UserName;
            inserisci.KeyName = "";
            inserisci.CodCli = "0";
            inserisci.InsertWEB_Domini(inserisci);
        }

        protected void Generic_Gridview_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
            ASPxGridView GridEdit = sender as ASPxGridView;
            if (GridEdit.IsNewRowEditing)
            {
                if (e.Column.FieldName == "DataAttivazione")
                {

                    ASPxDateEdit DataAttivazione = e.Editor as ASPxDateEdit;
                    DataAttivazione.Value = DateTime.Now;
                }
                if (e.Column.FieldName == "DataScadenza")
                {

                    ASPxDateEdit DataScadenza = e.Editor as ASPxDateEdit;
                    DataScadenza.Value = DateTime.Now.AddYears(1);
                }

            }
        }
    }
}