using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest
{


    public partial class Status_Print_Edit : System.Web.UI.Page
    {
        public int ID_Edit { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ID_Edit = Convert.ToInt32(Request.QueryString["ID"]);
        }


        protected void Update_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            //passo i parametri dell AspBox
            String status_Versione = Edit_Versione.Text;
            String Semaforo_Versione = Edit_Semaforo.Text;
            int id = ID_Edit;


            //imposto i parametri di aggiornamento dell'sqldatasource
            Edit_Dts.UpdateParameters["Status"].DefaultValue = status_Versione;
            Edit_Dts.UpdateParameters["ID_Semaforo"].DefaultValue = Semaforo_Versione;

            //esegui l'aggiornamento
            Edit_Dts.Update();
        }

        protected void Edit_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            Edit_Form.DataBind();
        }


    }
}