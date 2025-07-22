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
    public partial class domini_gest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void EmailAssociate_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            STD_Email aggiorna = new STD_Email();
            aggiorna.Email = e.NewValues["Email"].ToString();
            aggiorna.NomeUtente = e.NewValues["NomeUtente"].ToString(); ;
            aggiorna.Password = e.NewValues["Password"].ToString();
            aggiorna.Nome = e.NewValues["Nome"].ToString();
            aggiorna.Cognome = e.NewValues["Cognome"].ToString();
            aggiorna.Ruolo = e.NewValues["Ruolo"].ToString();
            aggiorna.Telefono = e.NewValues["Telefono"].ToString();
            aggiorna.IdEmail = Convert.ToInt32(e.Keys["IdEmail"]);
            MembershipUser insUsr = Membership.GetUser();
            aggiorna.EditUser = insUsr.UserName;
            aggiorna.UpdateSTD_Email(aggiorna);
        }
        protected void EmailAssociate_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string varIdDom = Request.QueryString["idDom"];
            STD_Email inserisci = new STD_Email();

            inserisci.Email = e.NewValues["Email"].ToString();
            inserisci.NomeUtente = e.NewValues["NomeUtente"].ToString();
            inserisci.Password = e.NewValues["Password"].ToString();
            inserisci.Nome = e.NewValues["Nome"].ToString();
            inserisci.Cognome = e.NewValues["Cognome"].ToString();
            inserisci.Ruolo = e.NewValues["Ruolo"].ToString();
            inserisci.Telefono = e.NewValues["Telefono"].ToString();
            inserisci.KeyName = "dominio";
            inserisci.KeyId = Convert.ToInt32(varIdDom);
            MembershipUser insUsr = Membership.GetUser();
            inserisci.EditUser = insUsr.UserName;
            inserisci.InsertSTD_Email(inserisci);
        }
        protected void EliminaMail_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            STD_Email IstanzaSTD_Email = new STD_Email();
            IstanzaSTD_Email.IdEmail = Convert.ToInt32(EmailAssociate_Gridview.GetRowValues(Convert.ToInt32(e.Parameter), "IdEmail"));
            IstanzaSTD_Email.DeleteSTD_Email(IstanzaSTD_Email);
        }
        protected void EliminaServizi_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            DomVsService servizioDaEliminare = new DomVsService();
            servizioDaEliminare.IdServizio = Convert.ToInt32(ServiziAssociati_Gridview.GetRowValues(Convert.ToInt32(e.Parameter), "IdServizio"));
            servizioDaEliminare.DeleteSTD_Servizi(servizioDaEliminare.IdServizio);
        }
        protected void Generic_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter == "0")
            {
                EmailAssociate_Gridview.ClientVisible = true;
                ServiziAssociati_Gridview.ClientVisible = false;
                EmailAssociate_Gridview.DataBind();
            }
            else if (e.Parameter == "1")
            {
                EmailAssociate_Gridview.ClientVisible = false;
                ServiziAssociati_Gridview.ClientVisible = true;
                ServiziAssociati_Gridview.DataBind();
            }

        }
        protected string GetPreviewText(string text)
        {
            return text.Replace(Environment.NewLine, "<br />");
        }
        protected void ServiziAssociati_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            DomVsService aggiorna = new DomVsService();
            aggiorna.NomeServizio = e.NewValues["NomeServizio"].ToString();
            aggiorna.DataAtt = e.NewValues["DataAtt"].ToString();
            aggiorna.DataScad = e.NewValues["DataScad"].ToString();
            aggiorna.Descrizione = e.NewValues["Descrizione"].ToString();
            aggiorna.Prezzo = Convert.ToDecimal(e.NewValues["Prezzo"].ToString());
            aggiorna.IdTipoServizio = "2";
            MembershipUser insUsr = Membership.GetUser();
            aggiorna.EditUser = insUsr.UserName;
            aggiorna.UpdatedOn = DateTime.Now.ToString();
            aggiorna.DeletedOn = DateTime.Now.ToString();
            aggiorna.KeyId = Convert.ToInt32(Request.QueryString["idDom"]);
            aggiorna.KeyName = "dominio";
            aggiorna.IdServizio = Convert.ToInt32(e.Keys["IdServizio"]);
            aggiorna.UpdateSTD_Servizi(aggiorna);
        }
        protected void ServiziAssociati_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            DomVsService inserisci = new DomVsService();
            inserisci.NomeServizio = e.NewValues["NomeServizio"].ToString();
            inserisci.DataAtt = e.NewValues["DataAtt"].ToString();
            inserisci.DataScad = e.NewValues["DataScad"].ToString();
            inserisci.Descrizione = e.NewValues["Descrizione"].ToString();
            inserisci.Prezzo = Convert.ToDecimal(e.NewValues["Prezzo"].ToString());
            inserisci.IdTipoServizio = "2";
            MembershipUser insUsr = Membership.GetUser();
            inserisci.EditUser = insUsr.UserName;
            inserisci.CreatedOn = DateTime.Now.ToString();
            inserisci.UpdatedOn = DateTime.Now.ToString();
            inserisci.DeletedOn = DateTime.Now.ToString();
            inserisci.KeyId = Convert.ToInt32(Request.QueryString["idDom"]);
            inserisci.KeyName = "dominio";
            inserisci.InsertSTD_Servizi(inserisci);
        }
        protected void ServiziAssociati_Gridview_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {

            ASPxGridView GridEdit = sender as ASPxGridView;
            if (GridEdit.IsNewRowEditing)
            {
                if (e.Column.FieldName == "Prezzo")
                {
                    ASPxTextBox Prezzo = e.Editor as ASPxTextBox;
                    Prezzo.Text = "0";
                }
                if (e.Column.FieldName == "DataAtt")
                {

                    ASPxDateEdit DataAtt = e.Editor as ASPxDateEdit;
                    DataAtt.Value = DateTime.Now;
                }
                if (e.Column.FieldName == "DataScad")
                {

                    ASPxDateEdit DataScad = e.Editor as ASPxDateEdit;
                    DataScad.Value = DateTime.Now.AddYears(1);
                }

            }
        }
    }
}