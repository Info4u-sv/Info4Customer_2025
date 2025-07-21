using DevExpress.Web;
using info4lab;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.SuperAdmin
{
    public partial class Ticket_Workflow_Status : System.Web.UI.Page
    {
        //// in questo modo istanzio le chiamate di Javscript e Jquery presenti nella classe BeyondFunzioniGenerali

        //BeyondFunzioniGenerali Helper = new BeyondFunzioniGenerali();

        ////-----------------------------------
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //inizializza i radiobutton           
                rbtAreaAss.SelectedIndex = 0;            }
            else { System.Threading.Thread.Sleep(1000); }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            // non è necessario registrare gli script lo faccio tramite javascript
        }

        protected void InserisciEmail_Lbt_Click(object sender, EventArgs e)
        {
            TCK_EmailInvioStatusAreaTicket ObjMail = new TCK_EmailInvioStatusAreaTicket();
            // prendo il nome dell'utente che sta inserendo o modificando i dati
            MembershipUser VUser = Membership.GetUser();
            ObjMail.CrudUser = VUser.ToString();
            ObjMail.IdAreaAss = Convert.ToInt32(rbtAreaAss.SelectedValue);
            ObjMail.EmailInvioStatusAreaTicket_Insert(ObjMail);
            BeyondFunzioniGenerali.Notify1_Success(this);
        }


        protected void ListViewGeneric_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            TCK_EmailInvioStatusAreaTicket MAilObj = new TCK_EmailInvioStatusAreaTicket();


            switch (e.CommandName)
            {
                case "Elimina":
                    BeyondFunzioniGenerali.Notify1_Success(this);
                    break;
                case "Modifica":
                    break;
            }
        }



        protected void MailAssociata_ListW_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            TCK_EmailInvioStatusAreaTicket MAilObj = new TCK_EmailInvioStatusAreaTicket();
            MembershipUser VUser = Membership.GetUser();
            switch (e.CommandName)
            {
                case "Associa":

                    MAilObj.CrudUser = VUser.ToString();
                    MAilObj.IdAreaAss = Convert.ToInt32(rbtAreaAss.SelectedValue);
                    MAilObj.EmailInvioStatusAreaTicket_Insert(MAilObj);
                    BeyondFunzioniGenerali.Notify1_Success(this);
                    break;
                case "Modifica":
                    break;
            }
        }

        protected void btnAssegnaTecnico_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script2", "<script type='text/javascript'>$('#myModalAssegnaTecnico').modal('show');</script>", false);

        }

        protected void btnConfAssegnaTecnico_Click(object sender, EventArgs e)
        {

        }

        protected void btnDismiss_Click(object sender, EventArgs e)
        {

        }
    }
}