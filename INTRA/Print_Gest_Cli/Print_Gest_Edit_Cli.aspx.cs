using DevExpress.Web;
using DevExpress.XtraExport.Helpers;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using info4lab;
using DevExpress.Utils;

namespace INTRA.Print_Gest_Cli
{
    public partial class Print_Gest_Edit_Cli : System.Web.UI.Page
    {
        public int ID_Edit { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            ID_Edit = Convert.ToInt32(Request.QueryString["ID"]);

        }


        protected void Update_FormLayout_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string Codice_cliente = Printer_Cod_Cliente_Edit.SelectedItem.Value.ToString();
            //DateTime DavaVerifica = Printer_Data_Verifica_Edit.Date;
            //int ID_Status = Convert.ToInt32(Printer_Id_Status_Edit.SelectedItem.Value);
            string Matricola = Printer_Matricola_Edit.Text;
            DateTime Data_Prima_Install = Printer_Data_Prima_installazione_Edit.Date;
            string Rif_Contratto_King = IDContratto_Txt.Text;
            int BN_Comprese = Convert.ToInt32(Printer_N_CopieBN_Comprese_Edit.Text);
            int Colori_Comprese = Convert.ToInt32(Printer_N_CopieCol_Comprese_edit.Text);
            string CodCli_Riassegno = Printer_Cod_Cli_Riassegno_Edit.Text;
            string Ubicazione_Printer = Printer_Ubicazione_Edit.Text;
            string Lettura = Printer_Lettura_TB.Text;
            string Mese = Printer_Mese_Lettura_TB.Text;
            string vendita = Vendita_Edit.Text;
            int Anni_Noleggio = Convert.ToInt32(Totale_Anni_Noleggio_SE.Text);


            Printer_Edit_Dts.UpdateParameters["Cod_Cliente"].DefaultValue = Codice_cliente;
            Printer_Edit_Dts.UpdateParameters["Matricola"].DefaultValue = Matricola; ;
            Printer_Edit_Dts.UpdateParameters["Data_Prima_Installazione"].DefaultValue = Data_Prima_Install.ToString();
            Printer_Edit_Dts.UpdateParameters["Rif_Contratto_King"].DefaultValue = Rif_Contratto_King;
            Printer_Edit_Dts.UpdateParameters["N_Copie_Bn_Comprese"].DefaultValue = BN_Comprese.ToString();
            Printer_Edit_Dts.UpdateParameters["N_Copie_Col_Comprese"].DefaultValue = Colori_Comprese.ToString();
            Printer_Edit_Dts.UpdateParameters["Cod_Cli_Riassegno"].DefaultValue = CodCli_Riassegno;
            Printer_Edit_Dts.UpdateParameters["Ubicazione_Printer"].DefaultValue = Ubicazione_Printer;
            Printer_Edit_Dts.UpdateParameters["Lettura"].DefaultValue = Lettura;
            Printer_Edit_Dts.UpdateParameters["Mese_Lettura"].DefaultValue = Mese;
            Printer_Edit_Dts.UpdateParameters["Vendita"].DefaultValue = vendita;
            Printer_Edit_Dts.UpdateParameters["Totale_Anni_Noleggio"].DefaultValue = Anni_Noleggio.ToString();



            // Esegui l'aggiornamento
            Printer_Edit_Dts.Update();
            ////Printer_Edit_Form.DataBind();

        }

        protected void Update_Scandenze_Copie_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            int id = ID_Edit;
            SqlParameter[] objParams = new SqlParameter[1];
            objParams[0] = new SqlParameter("@ID", id);

            // per eseguire una stored procedure in SQL Server
            Sql4Helper helper = new Sql4Helper();
            helper.ExecuteNonQuery("Inserimento_Mese_Anno", objParams);

        }


        protected void Edit_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            //aggiornamento del del modulo assicurando che tutti i campi abbiano dati recenti
            //Printer_Edit_Form è il nome dell'ID del formLayout
            int id = 0;
            if (!int.TryParse(Request.QueryString["ID"], out id))
                return;
            Printer_Edit_Form.DataBind();
            Printer_Edit_Form_Cli.DataBind();


        }


        protected void Printer_Rilevamento_Copie_GW_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            var chiavi = e.Keys;
            int id = Convert.ToInt32(chiavi[0]);

            SqlParameter[] objParams = new SqlParameter[8];
            objParams[0] = new SqlParameter("@ID", id);
            objParams[1] = new SqlParameter("@DataRilevamento", e.NewValues["DataRilevamento"]);
            objParams[2] = new SqlParameter("@N_Copie_Bn", e.NewValues["N_Copie_Bn"]);
            objParams[3] = new SqlParameter("@N_Copie_Colori", e.NewValues["N_Copie_Colori"]);
            objParams[4] = new SqlParameter("@N_Copie_Bn_Eccedenti", e.NewValues["N_Copie_Bn_Eccedenti"]);
            objParams[5] = new SqlParameter("@N_Copie_Col_Eccedenti", e.NewValues["N_Copie_Col_Eccedenti"]);
            objParams[6] = new SqlParameter("@Mese_Competenza", e.NewValues["Mese_Competenza"]);
            objParams[7] = new SqlParameter("@Azione", "update");

            Sql4Helper helper = new Sql4Helper();
            helper.ExecuteNonQuery("Rilevamento_Copie_CRUD", objParams);
        }

        protected void Printer_Rilevamento_Copie_GW_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            SqlParameter[] objParams = new SqlParameter[8];
            objParams[0] = new SqlParameter("@ID_Printer", Request["ID"]);
            objParams[1] = new SqlParameter("@DataRilevamento", e.NewValues["DataRilevamento"]);
            objParams[2] = new SqlParameter("@N_Copie_Bn", e.NewValues["N_Copie_Bn"]);
            objParams[3] = new SqlParameter("@N_Copie_Colori", e.NewValues["N_Copie_Colori"]);
            objParams[4] = new SqlParameter("@N_Copie_Bn_Eccedenti", e.NewValues["N_Copie_Bn_Eccedenti"]);
            objParams[5] = new SqlParameter("@N_Copie_Col_Eccedenti", e.NewValues["N_Copie_Col_Eccedenti"]);
            objParams[6] = new SqlParameter("@Mese_Competenza", e.NewValues["Mese_Competenza"]);
            objParams[7] = new SqlParameter("@Azione", "insert");

            Sql4Helper helper = new Sql4Helper();
            helper.ExecuteNonQuery("Rilevamento_Copie_CRUD", objParams);
        }

        protected void Gestione_Copie_Delete_Callback_Callback(object source, CallbackEventArgs e)
        {
            int id = Convert.ToInt32(e.Parameter);

            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ID", id);
            objParams[1] = new SqlParameter("@Azione", "delete");

            Sql4Helper helper = new Sql4Helper();
            helper.ExecuteNonQuery("Rilevamento_Copie_CRUD", objParams);
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
        protected string GetColorDotAndName(int coloreID)
        {
            var colori = new Dictionary<int, (string descr, string hex)>()
    {
        { 1, ("Nero", "#000000") },
        { 2, ("Giallo", "#FFFF00") },
        { 3, ("Magenta", "#FF00FF") },
        { 4, ("Ciano", "#00FFFF") },
        { 5, ("Waste", "#FFFFFF") },
        { 7, ("Nessuno", "#FFFFFF") },
        { 9, ("CMYK", "#FFFFFF") },
    };

            if (!colori.ContainsKey(coloreID))
                return "<div>Sconosciuto</div>";

            var (descr, hex) = colori[coloreID];

            return $"<div style='display:flex; align-items:center; gap:6px;'>"
                 + $"<div style='width:16px; height:16px; background-color:{hex}; border-radius:3px; border:1px solid #ccc;'></div>"
                 + $"<span>{descr}</span>"
                 + $"</div>";
        }
    }
}