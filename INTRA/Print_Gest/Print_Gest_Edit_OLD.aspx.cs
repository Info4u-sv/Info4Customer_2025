using DevExpress.Web;
using DevExpress.Web.ASPxScheduler.Internal;
using DevExpress.XtraExport.Helpers;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest
{
    public partial class Print_Gest_Edit_OLD : System.Web.UI.Page
    {
        public int ID_Edit { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if(!IsPostBack)
            {
                ID_Edit = Convert.ToInt32(Request.QueryString["ID"]);
                Printer_Mese_Lettura_TB.ClientEnabled = false;
            }

        }


        protected void Update_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {


            string modello = Printer_Morello_Edit.Text;
            int ID_Tipologia = Convert.ToInt32(Printer_Id_Tipologia_Edit.SelectedItem.Value);
            string Codice_cliente = Printer_Cod_Cliente_Edit.SelectedItem.Value.ToString();
            //DateTime DavaVerifica = Printer_Data_Verifica_Edit.Date;
            //int ID_Status = Convert.ToInt32(Printer_Id_Status_Edit.SelectedItem.Value);
            string Matricola = Printer_Matricola_Edit.Text;
            DateTime Data_Prima_Install = Printer_Data_Prima_installazione_Edit.Date;
            int NColori = Convert.ToInt32(Printer_N_Colori_Edit_Spin.Text);
            string Rif_Contratto_King = Printer_Rif_Contratto_King_Dts.Text;
            int BN_Comprese = Convert.ToInt32(Printer_N_CopieBN_Comprese_Edit.Text);
            int Colori_Comprese = Convert.ToInt32(Printer_N_CopieCol_Comprese_edit.Text);
            //string StatusPrinter = Convert.ToString(Printer_Status_Stampante_Edit.SelectedItem.Value);
            string CodCli_Riassegno = Printer_Cod_Cli_Riassegno_Edit.Text;
            string Ubicazione_Printer = Printer_Ubicazione_Edit.Text;
            string Lettura = Printer_Lettura_TB.Text;
            string Mese = Printer_Mese_Lettura_TB.Text;
            string vendita = Vendita_Edit.Text;


            Printer_Edit_Dts.UpdateParameters["Modello"].DefaultValue = modello;
            Printer_Edit_Dts.UpdateParameters["ID_Tipologia"].DefaultValue = ID_Tipologia.ToString();
            Printer_Edit_Dts.UpdateParameters["Cod_Cliente"].DefaultValue = Codice_cliente;
            //Printer_Edit_Dts.UpdateParameters["Data_Verifica"].DefaultValue = DavaVerifica.ToString();
            //Printer_Edit_Dts.UpdateParameters["ID_Status"].DefaultValue = ID_Status.ToString();
            Printer_Edit_Dts.UpdateParameters["Matricola"].DefaultValue = Matricola; ;
            Printer_Edit_Dts.UpdateParameters["Data_Prima_Installazione"].DefaultValue = Data_Prima_Install.ToString();
            Printer_Edit_Dts.UpdateParameters["N_Colori"].DefaultValue = NColori.ToString();
            Printer_Edit_Dts.UpdateParameters["Rif_Contratto_King"].DefaultValue = Rif_Contratto_King;
            Printer_Edit_Dts.UpdateParameters["N_Copie_Bn_Comprese"].DefaultValue = BN_Comprese.ToString();
            Printer_Edit_Dts.UpdateParameters["N_Copie_Col_Comprese"].DefaultValue = Colori_Comprese.ToString();
            //Printer_Edit_Dts.UpdateParameters["Status_Printer"].DefaultValue = StatusPrinter;
            Printer_Edit_Dts.UpdateParameters["Cod_Cli_Riassegno"].DefaultValue = CodCli_Riassegno;
            Printer_Edit_Dts.UpdateParameters["Ubicazione_Printer"].DefaultValue = Ubicazione_Printer;
            Printer_Edit_Dts.UpdateParameters["Lettura"].DefaultValue = Lettura;
            Printer_Edit_Dts.UpdateParameters["Mese_Lettura"].DefaultValue = Mese;
            Printer_Edit_Dts.UpdateParameters["Vendita"].DefaultValue = vendita;



            // Esegui l'aggiornamento
            Printer_Edit_Dts.Update();

        }

        protected void Edit_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            Printer_Edit_Form.DataBind();
            //Printer_Rilevamento_Copie_GW.DataBind();

        }


        //protected void Printer_Rilevamento_Copie_GW_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        //{
        //    int BN_Comprese = Convert.ToInt32(Printer_N_CopieBN_Comprese_Edit.Text);
        //    int Colori_Comprese = Convert.ToInt32(Printer_N_CopieCol_Comprese_edit.Text);

        //    int BN_Rilevate = Convert.ToInt32(e.NewValues["N_Copie_Bn"]);
        //    int Colori_Rilevate = Convert.ToInt32(e.NewValues["N_Copie_Colori"]);



        //    string primo = e.NewValues["N_Copie_Bn_Eccedenti"].ToString();
        //    string secondo = e.NewValues["N_Copie_Col_Eccedenti"].ToString();


        //}

        //protected void Printer_Rilevamento_Copie_GW_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        //{
        //    int BN_Comprese = Convert.ToInt32(Printer_N_CopieBN_Comprese_Edit.Text);
        //    int Colori_Comprese = Convert.ToInt32(Printer_N_CopieCol_Comprese_edit.Text);

        //    int BN_Rilevate = Convert.ToInt32(e.NewValues["N_Copie_Bn"]);
        //    int Colori_Rilevate = Convert.ToInt32(e.NewValues["N_Copie_Colori"]);

        //    e.NewValues["N_Copie_Bn_Eccedenti"] = BN_Rilevate - BN_Comprese;
        //    e.NewValues["N_Copie_Col_Eccedenti"] = Colori_Rilevate - Colori_Comprese;


        //}
    }
}