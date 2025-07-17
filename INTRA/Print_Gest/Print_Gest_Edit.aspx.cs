using DevExpress.Utils;
using DevExpress.Web;
using DevExpress.XtraExport.Helpers;
using info4lab;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Print_Gest
{
    public partial class Print_Gest_Edit : System.Web.UI.Page
    {
        public int ID_Edit { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int ID_Edit;
                if (int.TryParse(Request.QueryString["ID"], out ID_Edit))
                {
                    string connString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();

                        string sqlBrand = "SELECT BrandId FROM Multifunzione_ANA WHERE ID = @ID";
                        using (SqlCommand cmdBrand = new SqlCommand(sqlBrand, conn))
                        {
                            cmdBrand.Parameters.AddWithValue("@ID", ID_Edit);
                            object brandResult = cmdBrand.ExecuteScalar();
                            if (brandResult != null && brandResult != DBNull.Value)
                            {
                                int brandId = Convert.ToInt32(brandResult);
                                Session["BrandId"] = brandId;
                            }
                        }
                    }
                }
            }
        }
        protected void Printer_Edit_Dts_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            var imageControl = Printer_PhotoBytes_Edit;

            if (imageControl.Value != null)
            {
                e.Command.Parameters["@PhotoBytes"].Value = imageControl.Value;
            }
            else
            {
                e.Command.Parameters["@PhotoBytes"].Value = DBNull.Value;
            }
        }
        protected void Printer_Elenco_Codici_Consumabili_Dts_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            // Prendo ID dalla query string o da dove ti serve
            int idMultifunzione = int.Parse(Request.QueryString["ID"]);

            // Setto il parametro
            e.Command.Parameters["@ID_Multifunzione"].Value = idMultifunzione;
        }
        protected void Printer_Elenco_Codici_Consumabili_GW_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            int ID_Edit = 0;
            if (Request.QueryString["ID"] != null)
                ID_Edit = Convert.ToInt32(Request.QueryString["ID"]);

            e.NewValues["ID_Multifunzione"] = ID_Edit;
        }

        protected void Update_FormLayout_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            try
            {
                string modello = Printer_Morello_Edit.Text;
                string codiceProdotto = Printer_CodiceProdotto_Edit.Text;
                int brandId = Convert.ToInt32(Printer_BrandId_Edit.SelectedItem.Value);
                int ID_Tipologia = Convert.ToInt32(Printer_Id_Tipologia_Edit.SelectedItem.Value);
                int NColori = Convert.ToInt32(Printer_N_Colori_Edit_Spin.Text);
                string id = Request.QueryString["ID"];

                Printer_Edit_Dts.UpdateParameters["Modello"].DefaultValue = modello;
                Printer_Edit_Dts.UpdateParameters["ID_Tipologia"].DefaultValue = ID_Tipologia.ToString();
                Printer_Edit_Dts.UpdateParameters["BrandId"].DefaultValue = brandId.ToString();
                Printer_Edit_Dts.UpdateParameters["CodiceProdotto"].DefaultValue = codiceProdotto;
                Printer_Edit_Dts.UpdateParameters["N_Colori"].DefaultValue = NColori.ToString();
                Printer_Edit_Dts.UpdateParameters["ID"].DefaultValue = id;

                Printer_Edit_Dts.Update();
            }
            catch (Exception ex)
            {
                // Logga l’errore, opzionalmente puoi passare un messaggio via `e.Result`
                System.Diagnostics.Debug.WriteLine("Errore durante l'update: " + ex.Message);
                e.Result = "Errore: " + ex.Message;
            }
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
            int id = 0;
            if (!int.TryParse(Request.QueryString["ID"], out id))
                return;

            Printer_Edit_Form.DataBind();
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
        protected void Insert_Consumabile_Callback_Callback(object sender, DevExpress.Web.CallbackEventArgs e)
        {
            var callback = sender as DevExpress.Web.ASPxCallback;

            try
            {
                if (string.IsNullOrEmpty(e.Parameter) || !e.Parameter.Contains("|"))
                {
                    callback.JSProperties["cpResult"] = "error|Parametri non validi";
                    return;
                }

                string[] args = e.Parameter.Split('|');
                if (args.Length != 2)
                {
                    callback.JSProperties["cpResult"] = "error|Numero parametri non corretto";
                    return;
                }

                int idMultifunzione;
                int idConsumabile;

                if (!int.TryParse(args[0], out idMultifunzione) || !int.TryParse(args[1], out idConsumabile))
                {
                    callback.JSProperties["cpResult"] = "error|Parametri non interi";
                    return;
                }

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString))
                {
                    conn.Open();

                    string checkSql = @"
            SELECT COUNT(*) 
            FROM Elenco_codici_consumabili_vs_printer 
            WHERE ID_Multifunzione = @ID_Multifunzione AND ID_Consumabile = @ID_Consumabile";

                    using (SqlCommand cmdCheck = new SqlCommand(checkSql, conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@ID_Multifunzione", idMultifunzione);
                        cmdCheck.Parameters.AddWithValue("@ID_Consumabile", idConsumabile);

                        int count = (int)cmdCheck.ExecuteScalar();

                        if (count > 0)
                        {
                            callback.JSProperties["cpResult"] = "exists";
                            return;
                        }
                    }

                    string insertSql = @"
            INSERT INTO Elenco_codici_consumabili_vs_printer (ID_Multifunzione, ID_Consumabile)
            VALUES (@ID_Multifunzione, @ID_Consumabile)";

                    using (SqlCommand cmdInsert = new SqlCommand(insertSql, conn))
                    {
                        cmdInsert.Parameters.AddWithValue("@ID_Multifunzione", idMultifunzione);
                        cmdInsert.Parameters.AddWithValue("@ID_Consumabile", idConsumabile);

                        cmdInsert.ExecuteNonQuery();
                    }

                    callback.JSProperties["cpResult"] = "refresh";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERRORE Insert_Consumabile_Callback_Callback: " + ex.Message);
                callback.JSProperties["cpResult"] = "error|" + ex.Message;
            }
        }






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
        protected void Generic_Image_CustomCallback(object sender, CallbackEventArgsBase e)
        {
            string imgBase64 = e.Parameter;

            ASPxBinaryImage image = (ASPxBinaryImage)sender;

            string xxx = imgBase64.Replace("data:image/jpeg;base64,", " ");
            byte[] imgByte = Convert.FromBase64String(xxx);

            image.Value = imgByte;

        }
    }
}
