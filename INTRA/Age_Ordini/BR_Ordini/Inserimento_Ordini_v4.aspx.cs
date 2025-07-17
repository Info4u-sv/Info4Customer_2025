using DevExpress.Web;
using info4lab.Portal;
using INTRA.Age_Ordini.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Age_Ordini.BR_Ordini
{
    public partial class Inserimento_Ordini_v4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxLabel NomeCLi_Lbl = (ASPxLabel)DetCli_Fw.FindControl("NomeCLi_Lbl");
            int IdOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);
            bool IsEdit = false;

            int visibleRow = gridArticoliInseriti.VisibleRowCount;
            if (visibleRow > 0)
            { ConfermaOrdine_Btn.ClientVisible = true; }
            else
            { ConfermaOrdine_Btn.ClientVisible = false; }


            if (!IsPostBack)
            {

                // disabilitato Simone, riabilitato Alessio
                Session.Clear();
                Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
                SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
                int timeout = (int)section.Timeout.TotalMinutes * 1000 * 60;
                ClientScript.RegisterStartupScript(this.GetType(), "SessionAlert", "SessionExpireAlert(" + timeout + ");", true);
            }

            if (IdOrdineBozza != 0)
            { IsEdit = true; }
            MembershipUser UserLog = Membership.GetUser();
            switch (IsEdit)
            {
                //INSERT MODE
                case false:
                    InviaEmailAlCliente_Btn.Visible = false;
                    AnnullaOrdine.Visible = false;
                    StatusOrdine_Img.Visible = false;

                    //ConfermaOrdine_Btn.Visible = false;
                    //InviaMail_Btn.Visible = false;
                    //InviaEmailAlCliente_Btn.Visible = false;
                    //Da rivedere l'inserimento della query per tirar fuori i clienti
                    if (!IsPostBack)
                    {
                        ModificaOrdine_Btn.Visible = false;
                        TitoloPagina_Lbl.Text = "Nuova bozza ordine";
                        string Name = UserLog.UserName.ToUpper();
                        if (Name.Contains("AGE_"))
                        {
                        }
                        else
                        {
                            Cliente_Dts.SelectCommand = "SELECT U_Intra_Clienti_View.CodCli, U_Intra_Clienti_View.Denom, TabAge.U_User_Web FROM U_Intra_Clienti_View INNER JOIN CliFatt3 ON U_Intra_Clienti_View.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge ";
                            //Cliente_Dts.DataBind();
                        }
                    }
                    // fine query
                    if (string.IsNullOrEmpty(Convert.ToString(DataOrdine_Txt.Date)))
                    {
                        DataConsegna_Txt.MinDate = DataOrdine_Txt.Date;
                    }
                    else
                    {
                        DataConsegna_Txt.MinDate = Convert.ToDateTime(DateTime.Now.ToString("d/M/yyyy"));
                    }

                    if (IsPostBack && Cliente_Ddl.SelectedIndex != -1)
                    {

                        PageControl.ClientVisible = true;
                        gridArticoliInseriti.ClientVisible = true;
                        //Session["CodCliDataSource"] = Cliente_Ddl.SelectedItem.Value.ToString();

                        TitoloPagina_Lbl.Text = "Nuovo Ordine per <strong style='color:red'>" + Cliente_Ddl.SelectedItem.Text + "</strong>";

                        if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
                        {
                            PanelCostotrasporto_Pnl.ClientVisible = true;
                        }
                        else
                        {
                            PanelCostotrasporto_Pnl.ClientVisible = false;
                        }
                    }
                    else
                    {
                        DataOrdine_Txt.Date = Convert.ToDateTime(DateTime.Now.ToString("d/M/yyyy"));
                        DataConsegna_Txt.Date = Convert.ToDateTime(DateTime.Now.ToString("d/M/yyyy"));
                        SelezionaCliente_Pnl.Visible = true;

                        PageControl.ClientVisible = false;
                        gridArticoliInseriti.ClientVisible = false;
                    }
                    break;
                //Edit Mode
                case true:
                    HiddenField ScontoIncondizionato_HFld = (HiddenField)DetCli_Fw.FindControl("ScontoIncondizionato_HFld");
                    ScontoIncondizionato_lbl.Text = Convert.ToString(Convert.ToDecimal(ScontoIncondizionato_HFld.Value) / 100);
                    DetCli_Fw_Load();
                    if (!IsPostBack)
                    {

                        Ordini_Crud_v2 DatiOrdineBozza = new Ordini_Crud_v2();
                        DatiOrdineBozza = DatiOrdineBozza.U_OrdCliTestBozza_Get(IdOrdineBozza);
                        //if (grid.VisibleRowCount > 0)
                        //{
                        //    ConfermaOrdine_Btn.Visible = true;
                        //}
                        //else
                        //{
                        //    ConfermaOrdine_Btn.Visible = false;
                        //}
                        InviaEmailAlCliente_Btn.Visible = true;
                        CreaBozza_Btn.Visible = false;
                        //string ClasseTasti = "";
                        //ClasseTasti = StatusOffertaGet();
                        PageControl.ActiveTabIndex = 3;
                        //ClasseTastiStatus(ClasseTasti);
                        PanelCostotrasporto_Pnl.ClientVisible = true;

                        //InviaMail_Btn.Visible = false;
                        //InviaEmailAlCliente_Btn.Visible = false;
                        AnnullaOrdine.Visible = true;
                        SelezionaCliente_Pnl.Visible = false;
                        //Indietro_Btn.Visible = true;
                        PageControl.ClientVisible = true;
                        gridArticoliInseriti.ClientVisible = true;
                        Session["CodLisSession"] = DatiOrdineBozza.CodLis;
                        //Session["CodCliDataSource"] = DatiOrdineBozza.CodCli;
                        if (DatiOrdineBozza.FlagTrasporto == true)
                        {
                            PanelCostotrasporto_Pnl.ClientVisible = true;
                            FlagTrasporto_CkbxL.SelectedIndex = 0;
                        }
                        else
                        {
                            PanelCostotrasporto_Pnl.ClientVisible = false;
                            FlagTrasporto_CkbxL.SelectedIndex = 1;
                        }
                        DataOrdine_Txt.Date = DatiOrdineBozza.OrdDat;
                        DataConsegna_Txt.Date = DatiOrdineBozza.PrevCons;
                        NOte_Txt.Text = DatiOrdineBozza.Note;
                        //Session["CodCli"] = DatiOrdineBozza.CodCli;
                        CostoTrasportoForzato_Txt.Text = DatiOrdineBozza.CostoTrasportoString.ToString();
                    }
                    if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
                    {
                        PanelCostotrasporto_Pnl.ClientVisible = true;

                    }
                    else
                    {
                        PanelCostotrasporto_Pnl.ClientVisible = false;
                    }
                    break;
            }

        }

        protected void grid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            int index = -1;
            if (int.TryParse(e.Parameters, out index))
                gridArticoliInseriti.SettingsEditing.Mode = (GridViewEditingMode)index;
        }

        protected void ASPxGridView1_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {

        }

        public decimal GetPrezzoArticolo_BYCodLis(int CodLis, string CodiceArticolo)
        {
            string SqlString = " SELECT Prezzo From LISTINO Where CODLIS = " + CodLis + " AND CodArt = '" + CodiceArticolo + "'";
            decimal prezzo = 0;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;

                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {

                        prezzo = Convert.ToDecimal(myReader["prezzo"].ToString());

                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return prezzo;
        }

        //public void createnewrow(int Visibleindex)
        //{
        //    int Rowid = Visibleindex;
        //    GridViewDataColumn CNote = Articoli_DxGW.Columns[8] as GridViewDataColumn;
        //    GridViewDataColumn CQta = Articoli_DxGW.Columns[0] as GridViewDataColumn;
        //    ASPxTextBox NoteArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(Rowid, CNote, "NoteArticolo_Txt") as ASPxTextBox;
        //    ASPxSpinEdit QtaArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(Rowid, CQta, "QtaArticolo_Txt") as ASPxSpinEdit;
        //    decimal ImportoTotale = Convert.ToDecimal(Articoli_DxGW.GetRowValues(Rowid, "Prezzo"));
        //    ImportoTotale = ImportoTotale * Convert.ToDecimal(QtaArticolo_Txt.Text.ToString());
        //    decimal Prezzo = Convert.ToDecimal(Articoli_DxGW.GetRowValues(Rowid, "Prezzo"));
        //    string UMValue = "";
        //    string Confezione = Articoli_DxGW.GetRowValues(Rowid, "U_Confez").ToString();
        //    object ControllNull = Articoli_DxGW.GetRowValues(Rowid, "Misura");
        //    if (ControllNull != null)
        //    {
        //        UMValue = Articoli_DxGW.GetRowValues(Rowid, "Misura").ToString();
        //    }
        //    string Note = NoteArticolo_Txt.Text;
        //    string QtaTot = QtaArticolo_Txt.Text;
        //    try
        //    {
        //        Session["NumeroRigaGrigliaInseriti"] = Convert.ToInt32(Session["NumeroRigaGrigliaInseriti"].ToString()) + 1;
        //        DataTable mytable = new DataTable();
        //        if (Session["RowGrid"] != null)
        //        {
        //            mytable = (DataTable)Session["RowGrid"];
        //            DataRow dr = null;
        //            if (mytable.Rows.Count > 0)
        //            {
        //                dr = mytable.NewRow();
        //                dr["CodArt"] = Session["CodiceArticolo"].ToString();
        //                dr["Descrizione"] = Session["DescrizioneArticolo"].ToString();
        //                dr["UM"] = UMValue;
        //                dr["U_Confez"] = Confezione;
        //                dr["Prezzo"] = Prezzo;
        //                dr["TotQta"] = QtaTot;
        //                dr["TotImp"] = ImportoTotale;
        //                dr["Note"] = Note;
        //                dr["NRiga"] = Convert.ToInt32(Session["NumeroRigaGrigliaInseriti"].ToString());
        //                mytable.Rows.Add(dr);
        //                Session["RowGrid"] = mytable;
        //            }
        //        }
        //        else
        //        {
        //            mytable.Columns.Add(new DataColumn("CodArt", typeof(string)));
        //            mytable.Columns.Add(new DataColumn("Descrizione", typeof(string)));
        //            mytable.Columns.Add(new DataColumn("UM", typeof(string)));
        //            mytable.Columns.Add(new DataColumn("U_Confez", typeof(string)));
        //            mytable.Columns.Add(new DataColumn("Prezzo", typeof(float)));
        //            mytable.Columns.Add(new DataColumn("TotQta", typeof(float)));
        //            mytable.Columns.Add(new DataColumn("TotImp", typeof(float)));
        //            mytable.Columns.Add(new DataColumn("Note", typeof(string)));
        //            mytable.Columns.Add(new DataColumn("NRiga", typeof(int)));
        //            DataRow dr1 = mytable.NewRow();
        //            dr1["CodArt"] = Session["CodiceArticolo"].ToString();
        //            dr1["Descrizione"] = Session["DescrizioneArticolo"].ToString();
        //            dr1["UM"] = UMValue;
        //            dr1["U_Confez"] = Confezione;
        //            dr1["Prezzo"] = Prezzo;
        //            dr1["TotQta"] = QtaTot;
        //            dr1["TotImp"] = ImportoTotale;
        //            dr1["Note"] = Note;
        //            dr1["NRiga"] = Convert.ToInt32(Session["NumeroRigaGrigliaInseriti"].ToString());
        //            mytable.Rows.Add(dr1);
        //            Session["RowGrid"] = mytable;
        //        }
        //        gridArticoliInseriti.DataSource = Session["RowGrid"];
        //        //grid.DataBind();
        //        NoteArticolo_Txt.Text = "";
        //        QtaArticolo_Txt.Text = "0";
        //        //Articoli_DxGW.DataBind();
        //        // SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);
        //    }
        //    catch (Exception ex)
        //    {
        //        SiteMaster.ShowToastr(Page, "Operazione non Eseguita! L'articolo è già presente, si prega di modificarlo dalla lista oppure di sceglierne un altro.", "Annullamento", "Error", false, "toast-top-right", false);
        //    }

        //}
        //protected void ConfermaOrdine_Btn_Click(object sender, EventArgs e)
        //{

        //}

        public bool GetUMFromArticoli(string CodiceArticolo, string UM)
        {
            string SqlString = " SELECT TabUm.CodUm, TabUm.Descrizione FROM TabUm INNER JOIN ArtUM ON TabUm.CodUm = ArtUM.CodUm WHERE (ArtUM.CodArt = '" + CodiceArticolo + "')";
            bool UMFinale = true;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;

                SqlDataReader myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    string UMArticoli = myReader["Descrizione"].ToString();

                    if (UMArticoli == UM)
                    {
                        UMFinale = true;
                    }
                    else { UMFinale = false; }

                }


                myReader.Close();
                myConnection.Close();
            }
            return UMFinale;
        }

        public float GetFattConversione_FromARTUM(string CodiceArticolo)
        {
            string SqlString = " SELECT  FattConv FROM  ARTUM Where  CodArt = '" + CodiceArticolo + "'";
            float UMFinale = 0;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;

                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {
                        UMFinale = (float)Convert.ToDouble(myReader["FattConv"].ToString());

                    }


                }
                myReader.Close();
                myConnection.Close();
            }
            return UMFinale;
        }

        private string UpdateLastIdProtocollo()
        {
            string SqlString = " SELECT  Ultimo FROM  Protocolli  WHERE TipoDoc = 'OC' AND Protocollo = 'O' ";
            float UMFinale = 0;
            int LastID = 0;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();


                SqlDataReader myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    LastID = Convert.ToInt32(myReader["Ultimo"].ToString());

                }

                myReader.Close();
                myConnection.Close();
            }

            Portal4Set PortalConfig = new Portal4Set();
            LastID = LastID + 1;
            string updateCommand = " UPDATE [Protocolli] set [Ultimo] = " + LastID + " WHERE TipoDoc = 'OC' AND Protocollo = 'O' ";
            string LastIDString = Convert.ToString(LastID);
            using (SqlConnection connection =
                   new SqlConnection(ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(updateCommand, connection);
                command.Connection.Open();
                command.ExecuteNonQuery();

            }
            return LastIDString;
        }

        protected void Cliente_Ddl_SelectedIndexChanged(object sender, EventArgs e)
        {

            //Session["CodCli"] = Cliente_Ddl.SelectedItem.Value.ToString();
            //Session["CodCliDataSource"] = Cliente_Ddl.SelectedItem.Value.ToString();
            //string QueryXDatiCliente = " SELECT  Denom, Ind, Cap, Prov, Loc, Tel, PIva, CF, DsNaz FROM  dbo.U_Intra_Clienti_View where CodCLi = '" + Cliente_Ddl.SelectedItem.Value.ToString() + "'";
            //CondizioniPagamento_Ddl.Items.Clear();

            PageControl.ClientVisible = true;
            gridArticoliInseriti.ClientVisible = true;

            Ordini_Crud_v2 DatiOrdine = new Ordini_Crud_v2();
            DatiOrdine = DatiOrdine.U_DatiCliente_Get(Cliente_Ddl.SelectedItem.Value.ToString());
            //Valuta_Lbl.Text = Convert.ToString(DatiOrdine.Valuta);
        }


        //public void createnewrowEDITMODE()
        //{
        //    DataTable mytable = ((DataView)ArticoliOrdine_Dts.Select(DataSourceSelectArguments.Empty)).Table;
        //    Session["RowGrid"] = mytable;
        //    gridArticoliInseriti.DataSourceID = "";
        //    gridArticoliInseriti.DataSource = Session["RowGrid"];
        //    gridArticoliInseriti.DataBind();
        //}

        protected void grid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int NumeroOrdine = Convert.ToInt32(Request.QueryString["IdOrd"]);
            decimal TotQta = Convert.ToDecimal(e.NewValues["TotQta"].ToString());
            decimal TotImp = Convert.ToDecimal(e.NewValues["TotImp"].ToString());
            decimal Prezzo = Convert.ToDecimal(e.NewValues["Prezzo"].ToString());
            decimal TotaleCostoArticoli = (TotQta * Prezzo);

            HiddenField ScontoIncondizionato_HFld = (HiddenField)DetCli_Fw.FindControl("ScontoIncondizionato_HFld");
            float ScontoIncondizionato = (float)Convert.ToDouble(Convert.ToDecimal(ScontoIncondizionato_HFld.Value.ToString()));
            if (ScontoIncondizionato > 0)
            {
                Prezzo = (Prezzo * (100 - Convert.ToDecimal(ScontoIncondizionato))) / 100;
                TotaleCostoArticoli = (TotQta * Prezzo);
            }

            Ordini_Crud_v2 UpdateOrdiniBozza = new Ordini_Crud_v2();
            UpdateOrdiniBozza.CodArt = e.NewValues["CodArt"].ToString();
            UpdateOrdiniBozza.QtaOrdBozze = Convert.ToDecimal(e.NewValues["TotQta"].ToString());
            UpdateOrdiniBozza.QtaAnagBozze = Convert.ToDecimal(e.NewValues["TotQta"].ToString());
            UpdateOrdiniBozza.Importo = (float)Convert.ToDouble(TotaleCostoArticoli);
            UpdateOrdiniBozza.Note = e.NewValues["Note"].ToString();
            UpdateOrdiniBozza.U_OrdCliDettBozze_Update(UpdateOrdiniBozza, NumeroOrdine);
            gridArticoliInseriti.CancelEdit();
            e.Cancel = true;
            //grid.DataBind();
            SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);

        }

        protected void grid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int IdOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);
            Ordini_Crud_v2 Elimina = new Ordini_Crud_v2();
            Elimina.U_EliminaArticolo(e.Values["CodArt"].ToString(), IdOrdineBozza);
            gridArticoliInseriti.CancelEdit();
            e.Cancel = true;
            if (gridArticoliInseriti.VisibleRowCount == 0)
            {
                //ConfermaOrdine_Btn.Visible = false;
                //InviaMail_Btn.Visible = false;
                //InviaEmailAlCliente_Btn.Visible = false;
            }
            else
            {
                //ConfermaOrdine_Btn.Visible = true;
                //InviaMail_Btn.Visible = true;
                //InviaEmailAlCliente_Btn.Visible = true;
            }
            SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);
        }


        private string CodiceAgente_Get(string CodiceCliente, int Get)
        {
            string IDAge = "";
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();
            if (Get == 0)
            {
                if (Name.Contains("AGE_"))
                {
                    string SqlString = "SELECT CodAge FROM TabAge WHERE (U_User_Web = '" + UserLog.UserName + "') ";
                    using (SqlConnection myConnection = new SqlConnection())
                    {
                        myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                        SqlCommand myCommand = new SqlCommand();
                        myCommand.Connection = myConnection;
                        myCommand.CommandText = SqlString;
                        myConnection.Open();

                        SqlDataReader myReader = myCommand.ExecuteReader();
                        while (myReader.Read())
                        {
                            IDAge = myReader["CodAge"].ToString();
                        }
                        myReader.Close();
                        myConnection.Close();
                    }
                }
                else
                {
                    string SqlString = "SELECT TabAge.Descrizione, TabAge.CodAge, TabAge.U_User_Web FROM CliFatt3 INNER JOIN U_Intra_Clienti_View ON CliFatt3.CodCli = U_Intra_Clienti_View.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (CliFatt3.CodCli = '" + CodiceCliente + "')";
                    using (SqlConnection myConnection = new SqlConnection())
                    {
                        myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                        SqlCommand myCommand = new SqlCommand();
                        myCommand.Connection = myConnection;
                        myCommand.CommandText = SqlString;
                        myConnection.Open();

                        SqlDataReader myReader = myCommand.ExecuteReader();
                        while (myReader.Read())
                        {
                            IDAge = myReader["CodAge"].ToString();
                        }
                        myReader.Close();
                        myConnection.Close();
                    }
                }

            }
            else
            {
                if (Name.Contains("AGE_"))
                {
                    string SqlString = "SELECT Descrizione FROM TabAge WHERE (U_User_Web = '" + UserLog.UserName + "') ";
                    using (SqlConnection myConnection = new SqlConnection())
                    {
                        myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                        SqlCommand myCommand = new SqlCommand();
                        myCommand.Connection = myConnection;
                        myCommand.CommandText = SqlString;
                        myConnection.Open();

                        SqlDataReader myReader = myCommand.ExecuteReader();
                        while (myReader.Read())
                        {
                            IDAge = myReader["Descrizione"].ToString();
                        }
                        myReader.Close();
                        myConnection.Close();
                    }
                }
                else
                {
                    IDAge = Name;
                }
            }
            if (Get == 100)
            {
                string SqlString = "SELECT TabAge.Descrizione, TabAge.CodAge, TabAge.U_User_Web FROM CliFatt3 INNER JOIN U_Intra_Clienti_View ON CliFatt3.CodCli = U_Intra_Clienti_View.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (CliFatt3.CodCli = '" + CodiceCliente + "')";
                using (SqlConnection myConnection = new SqlConnection())
                {
                    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = SqlString;
                    myConnection.Open();

                    SqlDataReader myReader = myCommand.ExecuteReader();
                    while (myReader.Read())
                    {
                        IDAge = myReader["Descrizione"].ToString();
                    }
                    myReader.Close();
                    myConnection.Close();
                }

            }
            return IDAge;
        }

        private decimal U_TrasportoGet(string CodiceCliente)
        {
            decimal SpeseTrasporto = 0;
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();

            string SqlString = "SELECT U_Trasporto FROM U_Intra_Clienti_View WHERE (Codcli = '" + CodiceCliente + "') ";
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();

                SqlDataReader myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    SpeseTrasporto = Convert.ToDecimal(myReader["U_Trasporto"].ToString());
                }
                myReader.Close();
                myConnection.Close();
            }

            return SpeseTrasporto;
        }

        protected void Cliente_Ddl_ItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();
            if (Name.Contains("AGE_"))
            {
                Cliente_Dts.SelectCommand = @"  SELECT  CodCli, Denom,NumeroRiga from (SELECT U_Intra_Clienti_View.CodCli, U_Intra_Clienti_View.Denom, TabAge.U_User_Web , row_number() over(order by U_Intra_Clienti_View.CodCli) as NumeroRiga 
           FROM U_Intra_Clienti_View INNER JOIN CliFatt3 ON U_Intra_Clienti_View.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (TabAge.U_User_Web = '" + UserLog.UserName + "') and (Denom LIKE @filter) )  as st  WHERE   st.NumeroRiga between @startIndex and @endIndex ORDER BY CodCli asc";
            }
            else
            {
                Cliente_Dts.SelectCommand = @"  SELECT  CodCli, Denom,NumeroRiga from (SELECT U_Intra_Clienti_View.CodCli, U_Intra_Clienti_View.Denom, TabAge.U_User_Web , row_number() over(order by U_Intra_Clienti_View.CodCli) as NumeroRiga 
           FROM U_Intra_Clienti_View INNER JOIN CliFatt3 ON U_Intra_Clienti_View.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE ( Denom LIKE @filter) )  as st  WHERE  st.NumeroRiga between @startIndex and @endIndex ORDER BY CodCli asc";
            }
            Cliente_Dts.SelectParameters.Clear();
            Cliente_Dts.SelectParameters.Add("filter", TypeCode.String, string.Format("%{0}%", e.Filter));
            Cliente_Dts.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString());
            Cliente_Dts.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString());
            Cliente_Ddl.DataSource = Cliente_Dts;
            Cliente_Ddl.DataBind();
        }

        protected void Cliente_Ddl_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();
            if (Name.Contains("AGE_"))
            {
                Cliente_Dts.SelectCommand = @" SELECT  CodCli, Denom,NumeroRiga from (SELECT U_Intra_Clienti_View.CodCli, U_Intra_Clienti_View.Denom, TabAge.U_User_Web , row_number() over(order by U_Intra_Clienti_View.CodCli) as NumeroRiga 
           FROM U_Intra_Clienti_View INNER JOIN CliFatt3 ON U_Intra_Clienti_View.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (TabAge.U_User_Web = '" + UserLog.UserName + "'))  as st   ORDER BY CodCli asc";

            }
            else
            {
                Cliente_Dts.SelectCommand = @" SELECT  CodCli, Denom,NumeroRiga from (SELECT U_Intra_Clienti_View.CodCli, U_Intra_Clienti_View.Denom, TabAge.U_User_Web , row_number() over(order by U_Intra_Clienti_View.CodCli) as NumeroRiga 
           FROM U_Intra_Clienti_View INNER JOIN CliFatt3 ON U_Intra_Clienti_View.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge )  as st   ORDER BY CodCli asc";
            }
            Cliente_Ddl.DataSource = Cliente_Dts;
            Cliente_Ddl.DataBind();
        }

        protected void Callback_Callback(object source, CallbackEventArgs e)
        {
            int LastIdOrdine = 0;
            if (Cliente_Ddl.SelectedIndex != -1)
            {
                SelezionaCliente_Pnl.Visible = false;
                //Session["CodCliDataSource"] = Cliente_Ddl.SelectedItem.Value.ToString();
                //Session["CodCli"] = Cliente_Ddl.SelectedItem.Value.ToString();
                PageControl.ClientVisible = true;
                gridArticoliInseriti.ClientVisible = true;
                //CondizioniPagamento_Dts.DataBind();
                CondizioniPagamento_Ddl.DataBind();
                DetCli_Fw.DataBind();
                Ordini_Crud_v2 DatiOrdine = new Ordini_Crud_v2();
                DatiOrdine = DatiOrdine.U_DatiCliente_Get(Cliente_Ddl.SelectedItem.Value.ToString());
                try
                {
                    Ordini_Crud_v2 InserimentoTestBozza = new Ordini_Crud_v2();
                    InserimentoTestBozza.OrdDat = DataOrdine_Txt.Date;
                    InserimentoTestBozza.PrevCons = DataConsegna_Txt.Date;
                    InserimentoTestBozza.CodCli = Cliente_Ddl.SelectedItem.Value.ToString();
                    string CodCli = Cliente_Ddl.SelectedItem.Value.ToString();
                    InserimentoTestBozza.CodPag = CondizioniDiPagamento_Get(CodCli);
                    //if (CondizioniPagamento_Ddl != null && CondizioniPagamento_Ddl.SelectedIndex >= 0)
                    //{
                    //    InserimentoTestBozza.CodPag = CondizioniPagamento_Ddl.SelectedItem.Value;
                    //}
                    //else
                    //{
                    //    InserimentoTestBozza.CodPag = "";
                    //}
                    InserimentoTestBozza.CodBan = "";
                    InserimentoTestBozza.BanCli = GetBancli_BYCodCli(Cliente_Ddl.SelectedItem.Value.ToString());
                    InserimentoTestBozza.NumOrdCli = "";
                    InserimentoTestBozza.DataOrdCli = DataOrdine_Txt.Date;
                    InserimentoTestBozza.CodVal = "";
                    MembershipUser UserLog = Membership.GetUser();
                    InserimentoTestBozza.Agente = DatiOrdine.Agente;
                    InserimentoTestBozza.Deposito = "01";
                    InserimentoTestBozza.Sconto1 = 0;
                    InserimentoTestBozza.Sconto2 = 0;
                    InserimentoTestBozza.CodLis = DatiOrdine.CodLis;
                    //}
                    if (NOte_Txt != null)
                    {
                        InserimentoTestBozza.Note = NOte_Txt.Text;
                    }
                    else
                    {
                        InserimentoTestBozza.Note = "";
                    }

                    InserimentoTestBozza.CodDiv = "";

                    InserimentoTestBozza.CodSpe1 = "";

                    InserimentoTestBozza.CodSpe2 = "";
                    InserimentoTestBozza.CodPor = "";
                    //}
                    //string OrdNum = "O0" + UpdateLastIdProtocollo();
                    string OrdNum = "";
                    InserimentoTestBozza.OrdNum = OrdNum;
                    if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
                    {
                        InserimentoTestBozza.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
                        InserimentoTestBozza.FlagTrasporto = true;
                    }
                    else
                    {
                        InserimentoTestBozza.CostoTrasporto = Convert.ToDecimal(DatiOrdine.CostoTrasporto);
                        InserimentoTestBozza.FlagTrasporto = false;
                    }
                    LastIdOrdine = InserimentoTestBozza.U_OrdCliTestBozza_Insert(InserimentoTestBozza);
                    ASPxWebControl.RedirectOnCallback("Inserimento_Ordini_v4.aspx?IdOrd=" + LastIdOrdine);
                }
                catch (Exception ex)
                {

                    string filePath = @"~/Error.txt";
                    using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePath), true))
                    {
                        writer.WriteLine("Errore inserimento bozza" + DateTime.Today);
                        writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                    }
                    SiteMaster.ShowToastr(Page, "Operazione Non Eseguita!", "Annullata", "Error", false, "toast-top-right", false);
                }
            }
        }

        public void ClasseTastiStatus(string Status)
        {
            if (Status == "0")
            {
                StatusOrdine_Img.ImageUrl = "~/img/ImgStatus/Inserito.png";
                StatusOrdine_Img.ToolTip = "Ordine Inserito";
            }
            else if (Status == "1")
            {
                StatusOrdine_Img.ImageUrl = "~/img/ImgStatus/Status-semi.png";
                StatusOrdine_Img.ToolTip = "Ordine Parzialmente Evaso";
            }
            else if (Status == "2")
            {
                StatusOrdine_Img.ImageUrl = "~/img/ImgStatus/Completo.png";
                StatusOrdine_Img.ToolTip = "Ordine Completato";
            }
            else if (Status == "3")
            {
                StatusOrdine_Img.ImageUrl = "~/img/ImgStatus/Completo.png";
                StatusOrdine_Img.ToolTip = "Ordine Completato";
            }
        }

        public void StatusOffertaUpdate(int Status)
        {
            int OrdNum = Convert.ToInt32(Request.QueryString["NOrd"]);
            string updateCommand = " UPDATE  OrdCliTest set [FlagEvaso] = " + Status + " WHERE ID = " + OrdNum;

            using (SqlConnection connection =
                   new SqlConnection(ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(updateCommand, connection);
                command.Connection.Open();
                command.ExecuteNonQuery();

            }

        }

        public string StatusOffertaGet()
        {
            int OrdNum = Convert.ToInt32(Request.QueryString["NOrd"]);
            string SqlString = " Select FlagEvaso from  OrdCliTest WHERE ID = " + OrdNum;
            string Classe = "";
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;

                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {

                        Classe = myReader["FlagEvaso"].ToString();

                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return Classe;
        }

        protected void FlagTrasporto_CkbxL_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
            {
                PanelCostotrasporto_Pnl.Visible = true;
            }
            else
            {
                PanelCostotrasporto_Pnl.Visible = false;
            }
        }


        protected void StoricoOrdiniPerAgeCli_LINQ_Selecting(object sender, DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs e)
        {
            int IdOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);
            Ordini_Crud_v2 DatiOrdineBozza = new Ordini_Crud_v2();
            DatiOrdineBozza = DatiOrdineBozza.U_OrdCliTestBozza_Get(IdOrdineBozza);
            string CodCli = DatiOrdineBozza.CodCli;
            if (string.IsNullOrEmpty(CodCli))
            {
                if (Cliente_Ddl.SelectedIndex != -1)
                {
                    CodCli = Cliente_Ddl.SelectedItem.Value.ToString();
                }

            }
            if (!string.IsNullOrEmpty(CodCli))
            {
                string CodAge = CodiceAgente_Get(CodCli, 0);
                U_StoricoVenditeArticoloPerAgentePerCliente_LINQDataContext db = new U_StoricoVenditeArticoloPerAgentePerCliente_LINQDataContext();
                e.KeyExpression = "IdRow";
                e.QueryableSource = from U_StoricoVenditeArticoloPerAgentePerCliente_VIew in db.U_StoricoVenditeArticoloPerAgentePerCliente_VIew.Where(x => x.CodArt == Session["CodArtPopUp"].ToString() && x.Agente == CodAge && x.CodCli == CodCli).OrderBy(z => z.IdRow)
                                    select new
                                    {
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.IdRow,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.Prezzo,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.Sconto,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.Sconto2,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.Descrizione,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.CodArt,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.DataOrdCli,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.CodCli,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.Agente,
                                        U_StoricoVenditeArticoloPerAgentePerCliente_VIew.QtaOrd
                                    };
            }

        }

        protected void CallbackPerPopup_Clbk_Callback(object source, CallbackEventArgs e)
        {
            Session["CodArtPopUp"] = null;
            Session["CodArtPopUp"] = gridArticoliInseriti.GetRowValues(Convert.ToInt32(e.Parameter), "CodArt");
            PopupControl.HeaderText = "STORICO VENDITE ARTICOLO: " + Session["CodArtPopUp"].ToString();
            Storico_Grw.DataBind();
        }

     
        protected TCK_Ticket_v2 GetDisplayTicket()
        {
            ASPxLabel NomeCLi_Lbl = (ASPxLabel)DetCli_Fw.FindControl("NomeCLi_Lbl");
            ASPxLabel NumeroTelCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("NumeroTelCli_Lbl");
            ASPxLabel IndirizzoCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("IndirizzoCli_Lbl");
            ASPxLabel CapCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("CapCli_Lbl");
            ASPxLabel CittaCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("CittaCli_Lbl");
            ASPxLabel ProvinciaCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("ProvinciaCli_Lbl");
            ASPxLabel NazioneCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("NazioneCli_Lbl");
            ASPxLabel PIvaCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("PIvaCli_Lbl");
            ASPxLabel CFiscaleCli_Lbl = (ASPxLabel)DetCli_Fw.FindControl("CFiscaleCli_Lbl");
            ASPxLabel CodCli_Label = (ASPxLabel)DetCli_Fw.FindControl("CodCli_Label");
            string NumeroOrdine = Request.QueryString["NOrd"];
            string varCodCli = CodCli_Label.Text;

            TCK_Ticket_v2 rapportini = new TCK_Ticket_v2();
            rapportini.Società = NomeCLi_Lbl.Text;
            rapportini.CodCliente = varCodCli;
            rapportini.Indirizzo = IndirizzoCli_Lbl.Text;
            rapportini.Cap = CapCli_Lbl.Text;
            rapportini.Località = CittaCli_Lbl.Text;
            rapportini.Provincia = ProvinciaCli_Lbl.Text;
            rapportini.PIva = PIvaCli_Lbl.Text;
            rapportini.Telefono = NumeroTelCli_Lbl.Text;
            rapportini.DataIns = DateTime.Today.ToString("dd/MM/yyyy");
            rapportini.TCK_StatusChiamata = 0;
            rapportini.Note = NOte_Txt.Text;
            if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
            {
                rapportini.PrezzoDa = Convert.ToDecimal(PrezzoTrasporto_Txt.Text);
                rapportini.PrezzoA = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
                rapportini.FlagPrezzoA = true;
            }
            else
            {
                rapportini.PrezzoDa = Convert.ToDecimal(PrezzoTrasporto_Txt.Text);
                rapportini.PrezzoA = 0;
                rapportini.FlagPrezzoA = false;
            }

            ASPxLabel CodAgeCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodAgeCliente_Txt");
            string NomeAgente = CodiceAgente_Get(varCodCli, 100);
            rapportini.EditUser = CodAgeCliente_Txt.Text + " - " + NomeAgente;
            return rapportini;
        }

        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            HiddenField ScontoIncondizionato_HFld = (HiddenField)DetCli_Fw.FindControl("ScontoIncondizionato_HFld");

            TCK_Ticket_v2 GetTicket = new TCK_Ticket_v2();
            GetTicket = GetDisplayTicket();
            GetTicket.CodRapportino = Request.QueryString["IdOrd"];
            GetTicket.TckInviatoA = EmailCliente_Txt.Text;
            GetTicket.EmailTecnicoPerCliente = UserLog.Email;
            GetTicket.ScontoIncondizionato = Convert.ToDecimal(ScontoIncondizionato_HFld.Value);
            ASPxLabel CodAgeCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodAgeCliente_Txt");

            try
            {
                //TCK_EmailGest_BozzaOrdine_v2.SendTicketMail(Convert.ToInt32(Request.QueryString["IdOrd"]), 0, "Caglio Bozza Ordine", GetTicket, UserLog.Email, CodAgeCliente_Txt.Text);
            }
            catch (Exception ex)
            {

            }

        }

        protected void GridviewArticoli_CallBkPnl_Callback(object sender, CallbackEventArgsBase e)
        {

            if (!string.IsNullOrEmpty(ArticoliCodArtSrch_Txt.Text) || !string.IsNullOrEmpty(ArticoliDescrSrch_Txt.Text))
            {
                int IdOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);
                Ordini_Crud_v2 DatiOrdineBozza = new Ordini_Crud_v2();
                DatiOrdineBozza = DatiOrdineBozza.U_OrdCliTestBozza_Get(IdOrdineBozza);
                Session["CodLisSession"] = DatiOrdineBozza.CodLis;
                string CodLis = Session["CodLisSession"].ToString();
                string CodArt = ArticoliCodArtSrch_Txt.Text;
                string DescrizioneArticolo = ArticoliDescrSrch_Txt.Text;
                if (!string.IsNullOrEmpty(CodArt))
                {
                    Session["CodArtSession"] = CodArt;
                }
                else
                {
                    Session["CodArtSession"] = "%";
                }
                if (!string.IsNullOrEmpty(DescrizioneArticolo))
                {
                    Session["DescrArtSession"] = DescrizioneArticolo;
                }
                else
                {
                    Session["DescrArtSession"] = "%";
                }
                Session["CodLisSession"] = CodLis;

            }
            Articoli_DxGW.DataBind();
        }
        protected void DetCli_Fw_Load()
        {
            ASPxLabel NomeCLi_Lbl = (ASPxLabel)DetCli_Fw.FindControl("NomeCLi_Lbl");
            int IdOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();
            ASPxLabel TrasportoCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("TrasportoCliente_Txt");
            ASPxLabel CodAgeCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodAgeCliente_Txt");
            if (string.IsNullOrEmpty(PrezzoTrasporto_Txt.Text) && TrasportoCliente_Txt != null)
            {
                //PrezzoTrasporto_Txt.Text = Convert.ToString(U_TrasportoGet(Cliente_Ddl.SelectedItem.Value.ToString()));
                PrezzoTrasporto_Txt.Text = TrasportoCliente_Txt.Text;

            }
            if (CodAgeCliente_Txt != null)
            {
                if (Name.Contains("AGE_"))
                {
                    Name = Name.Replace("AGE_", "");
                    CodAgeCliente_Txt.Text = Name;
                }
            }
            if (NomeCLi_Lbl != null && IdOrdineBozza != 0)
            {
                TitoloPagina_Lbl.Text = "Modifica Bozza N° <strong style='Color:red'>" + IdOrdineBozza + " </strong> per: <strong style='Color:red'>" + NomeCLi_Lbl.Text + "</strong> ";
            }

        }

        protected void DetCli_Fw_DataBound(object sender, EventArgs e)
        {
            ASPxLabel NomeCLi_Lbl = (ASPxLabel)DetCli_Fw.FindControl("NomeCLi_Lbl");
            int IdOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();
            ASPxLabel TrasportoCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("TrasportoCliente_Txt");
            ASPxLabel CodAgeCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodAgeCliente_Txt");
            if (string.IsNullOrEmpty(PrezzoTrasporto_Txt.Text) && TrasportoCliente_Txt != null)
            {
                //PrezzoTrasporto_Txt.Text = Convert.ToString(U_TrasportoGet(Cliente_Ddl.SelectedItem.Value.ToString()));
                PrezzoTrasporto_Txt.Text = TrasportoCliente_Txt.Text;

            }
            if (CodAgeCliente_Txt != null)
            {
                if (Name.Contains("AGE_"))
                {
                    Name = Name.Replace("AGE_", "");
                    CodAgeCliente_Txt.Text = Name;
                }
            }
            if (NomeCLi_Lbl != null && IdOrdineBozza != 0)
            {
                TitoloPagina_Lbl.Text = "Modifica Bozza N° <strong style='Color:red'>" + IdOrdineBozza + " </strong> per: <strong style='Color:red'>" + NomeCLi_Lbl.Text + "</strong> ";
            }

        }

        //protected void GrigliaArticoli_Clbk_Callback(object source, CallbackEventArgs e)
        //{
        //    //inserimento riga dettaglio bozza ordine


        //    //int NumeroOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);

        //    int VisibleIndex = Convert.ToInt32(e.Parameter);
        //    GridViewDataColumn CQta = Articoli_DxGW.Columns[0] as GridViewDataColumn;
        //    ASPxSpinEdit QtaArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(VisibleIndex, CQta, "QtaArticolo_Txt") as ASPxSpinEdit;
        //    GridViewDataColumn CNote = Articoli_DxGW.Columns[8] as GridViewDataColumn;
        //    ASPxTextBox NoteArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(VisibleIndex, CNote, "NoteArticolo_Txt") as ASPxTextBox;
        //    Ordini_Crud_v2 InserimentoDettBozza = new Ordini_Crud_v2();

        //    InserimentoDettBozza.QtaAnag = (float)Convert.ToDouble(QtaArticolo_Txt.Value);

        //    InserimentoDettBozza.CodArt = Articoli_DxGW.GetRowValues(VisibleIndex, "CodArt").ToString();
        //    InserimentoDettBozza.UM = Articoli_DxGW.GetRowValues(VisibleIndex, "Misura").ToString();
        //    //TotaleQuantita = TotaleQuantita + Convert.ToDecimal(mytable.Rows[i]["TotQta"].ToString());
        //    //TotaleImporto = TotaleImporto + (float)Convert.ToDouble(mytable.Rows[i]["TotImp"].ToString());
        //    InserimentoDettBozza.QtaOrd = (float)Convert.ToDouble(QtaArticolo_Txt.Value);
        //    InserimentoDettBozza.Prezzo = (float)Convert.ToDouble(Articoli_DxGW.GetRowValues(VisibleIndex, "Prezzo"));

        //    float Importo = 0;
        //    Importo = (float)Convert.ToDouble(Convert.ToDecimal(QtaArticolo_Txt.Value) * Convert.ToDecimal(Articoli_DxGW.GetRowValues(VisibleIndex, "Prezzo")));
        //    HiddenField ScontoIncondizionato_HFld = (HiddenField)DetCli_Fw.FindControl("ScontoIncondizionato_HFld");
        //    float ScontoIncondizionato = (float)Convert.ToDouble(Convert.ToDecimal(ScontoIncondizionato_HFld.Value.ToString()));
        //    if (ScontoIncondizionato > 0)
        //    {
        //        //Commentato da Alessio in data 03/04/2018 vedi documento word MODIFICA SCONTO INCONDIZIONATO INSERIMENTO ORDINE
        //        //Importo = (Importo * (100 - ScontoIncondizionato)) / 100;
        //        //InserimentoDettBozza.Sconto = ScontoIncondizionato;
        //    }

        //    InserimentoDettBozza.Importo = Importo;
        //    InserimentoDettBozza.Note = NoteArticolo_Txt.Text;
        //    InserimentoDettBozza.IdTestata = Convert.ToInt32(Request.QueryString["IdOrd"]);
        //    InserimentoDettBozza.NRiga = gridArticoliInseriti.VisibleRowCount + 1;
        //    InserimentoDettBozza.U_Confez_Intra = Articoli_DxGW.GetRowValues(VisibleIndex, "U_Confez").ToString();
        //    InserimentoDettBozza.U_OrdCliDettBozza_Insert_v3(InserimentoDettBozza);

        //    //if (gridArticoliInseriti.VisibleRowCount == 0 || Cliente_Ddl.SelectedIndex == -1)
        //    //{
        //    //    ConfermaOrdine_Btn.Visible = false;
        //    //    //InviaMail_Btn.Visible = false;
        //    //    //InviaEmailAlCliente_Btn.Visible = false;
        //    //}
        //    //else
        //    //{
        //    //    ConfermaOrdine_Btn.Visible = true;
        //    //}
        //    //gridArticoliInseriti.DataBind();
        //}

        protected void Articoli_DxGW_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            GridViewDataColumn InPromoCell = Articoli_DxGW.Columns[6] as GridViewDataColumn;

            string InPromo = Convert.ToString(Articoli_DxGW.GetRowValues(e.VisibleIndex, "InPromo"));
            if (InPromo == "In Promo")
            {
                InPromoCell.CellStyle.CssClass = "InPromoClass";
            }

        }

        protected void ConfermaOrdine_Clbk_Callback(object source, CallbackEventArgs e)
        {
            string filePathError = @"~/Error.txt";
            int LastIdOrdine = 0;

            ASPxLabel CondizioniDiPagamentoFw_Label = (ASPxLabel)DetCli_Fw.FindControl("CondizioniDiPagamentoFw_Label");
            int IdOrdineBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);
            Ordini_Crud_v2 DatiOrdineBozza = new Ordini_Crud_v2();
            DatiOrdineBozza = DatiOrdineBozza.U_OrdCliTestBozza_Get(IdOrdineBozza);
            string CodCli = DatiOrdineBozza.CodCli;
            ASPxLabel CodAgeCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodAgeCliente_Txt");
            ASPxLabel CodLisCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodLisCliente_Txt");
            int ExistId = GetIdBozza_OrdCliTest(IdOrdineBozza);
            if (ExistId == 0)
            {

                Ordini_Crud_v2 InserimentoTest = new Ordini_Crud_v2();
                InserimentoTest.OrdDat = DataOrdine_Txt.Date;
                InserimentoTest.PrevCons = DataConsegna_Txt.Date;
                InserimentoTest.CodCli = CodCli;
                InserimentoTest.CodPag = CondizioniDiPagamentoFw_Label.Text;
                //if (CondizioniPagamento_Ddl != null && CondizioniPagamento_Ddl.SelectedIndex >= 0)
                //{
                //    InserimentoTest.CodPag = CondizioniPagamento_Ddl.SelectedItem.Value;
                //}
                //else
                //{

                //    using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePathError), true))
                //    {
                //        writer.WriteLine("Errore condizione di pagamento vuoto per il cliente - " + CodCli + "   " + DateTime.Today);
                //        writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                //    }
                //    InserimentoTest.CodPag = "";
                //}
                InserimentoTest.CodBan = "";

                InserimentoTest.BanCli = GetBancli_BYCodCli(CodCli);

                InserimentoTest.NumOrdCli = "";
                InserimentoTest.DataOrdCli = DataOrdine_Txt.Date;
                InserimentoTest.CodVal = "";
                MembershipUser UserLog = Membership.GetUser();
                InserimentoTest.Agente = CodAgeCliente_Txt.Text;
                InserimentoTest.Deposito = "01";
                InserimentoTest.Sconto1 = 0;
                InserimentoTest.Sconto2 = 0;
                //Ordini_Crud_v2 DatiCliente = new Ordini_Crud_v2();
                //DatiCliente = DatiCliente.U_DatiCliente_Get(Cliente_Ddl.SelectedItem.Value.ToString());
                InserimentoTest.CodLis = CodLisCliente_Txt.Text;
                //}
                if (NOte_Txt != null)
                {
                    InserimentoTest.Note = NOte_Txt.Text;
                }
                else
                {
                    InserimentoTest.Note = "";
                }

                InserimentoTest.CodDiv = "";

                InserimentoTest.CodSpe1 = "";

                InserimentoTest.CodSpe2 = "";
                InserimentoTest.CodPor = "";
                //}
                string OrdNum = "";
                //try
                //{
                OrdNum = "O" + UpdateLastIdProtocollo();
                //}
                //catch (Exception Ex)
                //{
                //    using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePathError), true))
                //    {
                //        writer.WriteLine("Errore UpdateLastIdProtocollo - " + Ex + "    " + CodCli + "   " + DateTime.Today);
                //        writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                //    }
                //}


                InserimentoTest.OrdNum = OrdNum;
                InserimentoTest.OrdNum = OrdNum;
                // modifica 04/10/2018
                if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
                {
                    InserimentoTest.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
                    // controllo per annullare le spese trasporto sul king
                    if (InserimentoTest.CostoTrasporto == 0)
                    {
                        InserimentoTest.FlagTrasporto = true;
                    }
                    else
                    {
                        InserimentoTest.FlagTrasporto = false;
                    }

                    //InserimentoTest.FlagTrasporto = true;
                }
                else
                {
                    InserimentoTest.CostoTrasporto = Convert.ToDecimal(PrezzoTrasporto_Txt.Text);
                    InserimentoTest.FlagTrasporto = false;
                }

                // Fine modifica 04/10/2018
                InserimentoTest.U_IdBozza = Convert.ToInt32(Request.QueryString["IdOrd"]);

                //try
                //{
                LastIdOrdine = InserimentoTest.U_OrdCliTest_Insert(InserimentoTest);
                Session["LastIdOrdine"] = LastIdOrdine;
                //}
                //catch (Exception Ex)
                //{
                //    using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePathError), true))
                //    {
                //        writer.WriteLine("Errore U_OrdCliTest_Insert - " + Ex + "    " + CodCli + "   " + DateTime.Today);
                //        writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                //    }
                //}

                decimal TotaleQuantita = 0;
                float TotaleImporto = 0;
                float TotaleImportoConSconti = 0;
                int RowCount = 0;
                Ordini_Crud_v2 InserimentoDett = new Ordini_Crud_v2();
                DataTable mytable = new DataTable();
                Ordini_Crud_v2 SaldiMagUpd = new Ordini_Crud_v2();
                HiddenField ScontoIncondizionato_HFld = (HiddenField)DetCli_Fw.FindControl("ScontoIncondizionato_HFld");
                float ScontoIncondizionato = (float)Convert.ToDouble(Convert.ToDecimal(ScontoIncondizionato_HFld.Value.ToString()));
                float TotaleImportoSenzaSconti = 0;
                float TotaleSconto = 0;
                for (int i = 0; i < gridArticoliInseriti.VisibleRowCount; i++)
                {
                    //try
                    //{


                    // Procedura per aggiornamento saldimag
                    SaldiMagUpd.CodArt = gridArticoliInseriti.GetRowValues(i, "CodArt").ToString();
                    SaldiMagUpd.QtaOrd = (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "TotQta"));
                    SaldiMagUpd.U_SaldiMagOrd_Update_v2(SaldiMagUpd);
                    // Fine procedura SaldiMag
                    TotaleImportoConSconti = TotaleImportoConSconti + ((float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "TotImp")) * (100 - ScontoIncondizionato) / 100);
                    InserimentoDett.QtaAnag = (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "TotQta"));
                    InserimentoDett.CodArt = gridArticoliInseriti.GetRowValues(i, "CodArt").ToString();
                    InserimentoDett.UM = gridArticoliInseriti.GetRowValues(i, "UM").ToString();
                    TotaleQuantita = TotaleQuantita + Convert.ToDecimal(gridArticoliInseriti.GetRowValues(i, "TotQta"));
                    TotaleImporto = TotaleImporto + (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "TotImp"));
                    InserimentoDett.QtaOrd = (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "TotQta"));
                    InserimentoDett.Prezzo = (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "Prezzo"));

                    if (gridArticoliInseriti.GetRowValues(i, "Sconto") != null)
                    {
                        InserimentoDett.Sconto = (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "Sconto"));
                    }
                    else
                    {
                        InserimentoDett.Sconto = 0;
                    }

                    InserimentoDett.Importo = (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "TotImp"));
                    InserimentoDett.Note = gridArticoliInseriti.GetRowValues(i, "Note").ToString();
                    InserimentoDett.IdTestata = LastIdOrdine;
                    InserimentoDett.NRiga = i + 1;
                    InserimentoDett.PrevCons = DataOrdine_Txt.Date;
                    InserimentoDett.U_Confez_Intra = gridArticoliInseriti.GetRowValues(i, "U_Confez").ToString();
                    InserimentoDett.RifIva = gridArticoliInseriti.GetRowValues(i, "CodIva").ToString();
                    InserimentoDett.NumDec = gridArticoliInseriti.GetRowValues(i, "NumDec").ToString();
                    InserimentoDett.u_pz_lordo = Convert.ToDecimal(gridArticoliInseriti.GetRowValues(i, "U_Pz_Lordo").ToString());
                    InserimentoDett.U_Sc2 = Convert.ToDecimal(gridArticoliInseriti.GetRowValues(i, "U_Sc2").ToString());
                    InserimentoDett.U_Sc1 = Convert.ToDecimal(gridArticoliInseriti.GetRowValues(i, "U_Sc1").ToString());
                    InserimentoDett.U_OrdCliDett_Insert_v3(InserimentoDett);
                    TotaleImportoSenzaSconti += (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "TotQta")) * (float)Convert.ToDouble(gridArticoliInseriti.GetRowValues(i, "Prezzo"));
                    //    }
                    //    catch (Exception Ex)
                    //    {
                    //        using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePathError), true))
                    //        {
                    //            writer.WriteLine("Errore U_OrdCliDett_Insert_v3 - " + Ex + "    " + CodCli + "   " + DateTime.Today);
                    //            writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                    //        }
                    //    }
                }
                //try
                //{
                Ordini_Crud_v2 UpdateQta = new Ordini_Crud_v2();
                UpdateQta.TotQta = (float)Convert.ToDouble(TotaleQuantita);
                UpdateQta.TotImp = TotaleImporto;
                UpdateQta.IdTestata = LastIdOrdine;
                UpdateQta.U_OrdCliTestQta_Update(UpdateQta);

                //}
                //catch (Exception Ex)
                //{
                //    using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath(filePathError), true))
                //    {
                //        writer.WriteLine("Errore U_OrdCliTestQta_Update - " + Ex + "    " + CodCli + "   " + DateTime.Today);
                //        writer.WriteLine(Environment.NewLine + "-----------------------------------------------------------------------------" + Environment.NewLine);
                //    }
                //}

                ASPxLabel SpeBan_Lbl = (ASPxLabel)DetCli_Fw.FindControl("SpeBan_Lbl");
                ASPxLabel ScontoIncondizionato_Lbl = (ASPxLabel)DetCli_Fw.FindControl("ScontoIncondizionato_Lbl");

                //try
                //{
                //Procedura che server per aggiornare la tabella OrdCSpese. Segue documentazione scritta da Davide il 28/03/2018
                List<Ordini_Crud_v2> ListGet = new List<Ordini_Crud_v2>();
                Ordini_Crud_v2 GetDefSpese = new Ordini_Crud_v2();
                ListGet = GetDefSpese.U_DefSpese_GET();
                TotaleSconto = TotaleImportoSenzaSconti - TotaleImportoConSconti;
                Ordini_Crud_v2 InsertOrdCSpese = new Ordini_Crud_v2();
                for (int j = 0; j < ListGet.Count; j++)
                {
                    InsertOrdCSpese.IdTestata = LastIdOrdine;
                    InsertOrdCSpese.Tipo = "OC";
                    InsertOrdCSpese.Nriga = ListGet[j].IdSpesa;
                    if (ListGet[j].IdSpesa == 1001)
                    {
                        if (ScontoIncondizionato_Lbl.Text != "0" || ScontoIncondizionato_Lbl.Text != "0,00")
                        {
                            InsertOrdCSpese.Percent = Convert.ToDecimal(ScontoIncondizionato_Lbl.Text.Replace(" %", ""));
                            InsertOrdCSpese.Importo = TotaleSconto; //inserire il valore calcolato dello sconto
                        }
                        else
                        {
                            InsertOrdCSpese.Percent = 0;
                            InsertOrdCSpese.Importo = 0;
                        }
                    }
                    else
                    {
                        InsertOrdCSpese.Percent = 0;
                        if (ListGet[j].IdSpesa == 998)
                        {
                            InsertOrdCSpese.Importo = (float)Convert.ToDouble(SpeBan_Lbl.Text);
                        }
                        else
                        {
                            InsertOrdCSpese.Importo = 0;
                        }
                    }
                    InsertOrdCSpese.CodIva = ListGet[j].CodIva;
                    InsertOrdCSpese.U_OrdCSpese_Insert_v2(InsertOrdCSpese);
                }
             
                TCK_Ticket_v2 GetTicket = new TCK_Ticket_v2();
                GetTicket = GetDisplayTicket();
                GetTicket.CodRapportino = OrdNum;

                //TCK_EmailGest_v2.SendTicketMail(LastIdOrdine, 0, UserLog.UserName, GetTicket, UserLog.Email, DatiOrdineBozza.Agente);
                int NumeroOrdine = Convert.ToInt32(Request.QueryString["IdOrd"]);
                Ordini_Crud_v2 Delete = new Ordini_Crud_v2();
                Delete.U_OrdCliTestBozze_Delete(NumeroOrdine);
               
                ASPxWebControl.RedirectOnCallback("/Brico_Ordini/inserimento_ordini_view_v3.aspx?NOrd=" + LastIdOrdine + "&CodCli=" + DatiOrdineBozza.CodCli);
             
            }
        }


        protected void AnnullaOrdine_Click(object sender, EventArgs e)
        {
            int NumeroOrdine = Convert.ToInt32(Request.QueryString["IdOrd"]);
            Ordini_Crud_v2 Delete = new Ordini_Crud_v2();
            Delete.U_OrdCliTestBozze_Delete(NumeroOrdine);
            Response.Redirect("/Brico_Ordini/Inserimento_Ordini_v3.aspx");
        }

        public int GetBancli_BYCodCli(string CodCli)
        {
            //string Sql = "SELECT TabPag.Tipo FROM TabPag INNER JOIN CliFatt1 ON TabPag.CodCPag = CliFatt1.CodPag WHERE(CliFatt1.CodCli = '" + CodArt + "')";
            //string Tipo = "";
            int CodBan = 0;
            //using (SqlConnection myConnection = new SqlConnection())
            //{
            //    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
            //    SqlCommand myCommand = new SqlCommand();
            //    myCommand.Connection = myConnection;
            //    myCommand.CommandText = Sql;
            //    myConnection.Open();
            //    bool retVal = false;

            //    SqlDataReader myReader = myCommand.ExecuteReader();
            //    if (!myReader.HasRows)
            //    { retVal = false; }

            //    else
            //    {
            //        while (myReader.Read())
            //        {
            //Tipo = myReader["Tipo"].ToString();
            //if (Tipo == "RB")
            //{
            string SqlString = "SELECT IDBan FROM BancheCli  WHERE CodCli = '" + CodCli + "' AND Preferenziale <> 0";
            using (SqlConnection myConnection2 = new SqlConnection())
            {
                myConnection2.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand2 = new SqlCommand();
                myCommand2.Connection = myConnection2;
                myCommand2.CommandText = SqlString;
                myConnection2.Open();
                bool retVal2 = false;

                SqlDataReader myReader2 = myCommand2.ExecuteReader();
                if (!myReader2.HasRows)
                { retVal2 = false; }

                else
                {
                    while (myReader2.Read())
                    {

                        CodBan = Convert.ToInt32(myReader2["IDBan"].ToString());

                    }
                }
                myReader2.Close();
                myConnection2.Close();
            }
            //}

            //        }
            //    }
            //    myReader.Close();
            //    myConnection.Close();
            //}
            return CodBan;
        }

        protected void SalvaBozza_CLBK_Callback(object source, CallbackEventArgs e)
        {
            int NumeroOrdine = Convert.ToInt32(Request.QueryString["IdOrd"]);
            Ordini_Crud_v2 UpdateBozza = new Ordini_Crud_v2();
            UpdateBozza.DataOrdCli = DataOrdine_Txt.Date;
            UpdateBozza.PrevCons = DataConsegna_Txt.Date;
            if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
            {
                //UpdateBozza.FlagTrasporto = true;
                UpdateBozza.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
                UpdateBozza.U_Flag_Edit_Trasp = true;
                // controllo per annullare le spese trasporto sul king
                if (UpdateBozza.CostoTrasporto == 0)
                {
                    UpdateBozza.FlagTrasporto = true;
                }
                else
                {
                    UpdateBozza.FlagTrasporto = false;
                }
            }
            else
            {
                UpdateBozza.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
                UpdateBozza.U_Flag_Edit_Trasp = false;
                UpdateBozza.FlagTrasporto = false;
            }
            //UpdateBozza.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
            UpdateBozza.Note = NOte_Txt.Text;
            UpdateBozza.U_OrdCliTestBozze_Update(UpdateBozza, NumeroOrdine);
            SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);
        }
        //protected void SalvaBozza_CLBK_Callback(object source, CallbackEventArgs e)
        //{
        //    int NumeroOrdine = Convert.ToInt32(Request.QueryString["IdOrd"]);
        //    Ordini_Crud_v2 UpdateBozza = new Ordini_Crud_v2();
        //    UpdateBozza.DataOrdCli = DataOrdine_Txt.Date;
        //    UpdateBozza.PrevCons = DataConsegna_Txt.Date;
        //    if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
        //    {
        //        UpdateBozza.FlagTrasporto = true;
        //    }
        //    else
        //    {
        //        UpdateBozza.FlagTrasporto = false;
        //    }
        //    UpdateBozza.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
        //    UpdateBozza.Note = NOte_Txt.Text;
        //    UpdateBozza.U_OrdCliTestBozze_Update(UpdateBozza, NumeroOrdine);
        //    SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);
        //}

        protected void GrigliaArticoliInseriti_CallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            //inserimento riga dettaglio bozza ordine

            int VisibleIndex = Convert.ToInt32(e.Parameter);
            GridViewDataColumn CQta = Articoli_DxGW.Columns[0] as GridViewDataColumn;
            ASPxSpinEdit QtaArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(VisibleIndex, CQta, "QtaArticolo_Txt") as ASPxSpinEdit;
            GridViewDataColumn CNote = Articoli_DxGW.Columns[7] as GridViewDataColumn;
            ASPxTextBox NoteArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(VisibleIndex, CNote, "NoteArticolo_Txt") as ASPxTextBox;
            Ordini_Crud_v2 InserimentoDettBozza = new Ordini_Crud_v2();

            InserimentoDettBozza.QtaAnag = (float)Convert.ToDouble(QtaArticolo_Txt.Value);

            InserimentoDettBozza.CodArt = Articoli_DxGW.GetRowValues(VisibleIndex, "CodArt").ToString();
            InserimentoDettBozza.UM = Articoli_DxGW.GetRowValues(VisibleIndex, "Misura").ToString();
            //TotaleQuantita = TotaleQuantita + Convert.ToDecimal(mytable.Rows[i]["TotQta"].ToString());
            //TotaleImporto = TotaleImporto + (float)Convert.ToDouble(mytable.Rows[i]["TotImp"].ToString());
            InserimentoDettBozza.QtaOrd = (float)Convert.ToDouble(QtaArticolo_Txt.Value);
            InserimentoDettBozza.Prezzo = (float)Convert.ToDouble(Articoli_DxGW.GetRowValues(VisibleIndex, "Prezzo"));

            float Importo = 0;
            Importo = (float)Convert.ToDouble(Convert.ToDecimal(QtaArticolo_Txt.Value) * Convert.ToDecimal(Articoli_DxGW.GetRowValues(VisibleIndex, "Prezzo")));
            HiddenField ScontoIncondizionato_HFld = (HiddenField)DetCli_Fw.FindControl("ScontoIncondizionato_HFld");
            float ScontoIncondizionato = (float)Convert.ToDouble(Convert.ToDecimal(ScontoIncondizionato_HFld.Value.ToString()));
            //if (ScontoIncondizionato > 0)
            //{
            //    //Commentato da Alessio in data 03/04/2018 vedi documento word MODIFICA SCONTO INCONDIZIONATO INSERIMENTO ORDINE
            //    //Importo = (Importo * (100 - ScontoIncondizionato)) / 100;
            //    //InserimentoDettBozza.Sconto = ScontoIncondizionato;
            //}
            InserimentoDettBozza.RifIva = Articoli_DxGW.GetRowValues(VisibleIndex, "RifIva").ToString();
            InserimentoDettBozza.NumDec = "2" + Articoli_DxGW.GetRowValues(VisibleIndex, "DecQta").ToString() + Articoli_DxGW.GetRowValues(VisibleIndex, "DecQta").ToString() + (Convert.ToInt32(Articoli_DxGW.GetRowValues(VisibleIndex, "DecPrz")) + 2).ToString() + (Convert.ToInt32(Articoli_DxGW.GetRowValues(VisibleIndex, "DecPrz")) + 2).ToString();
            InserimentoDettBozza.Importo = Importo;
            InserimentoDettBozza.Note = NoteArticolo_Txt.Text;
            InserimentoDettBozza.IdTestata = Convert.ToInt32(Request.QueryString["IdOrd"]);
            InserimentoDettBozza.NRiga = gridArticoliInseriti.VisibleRowCount + 1;
            InserimentoDettBozza.U_Confez_Intra = Articoli_DxGW.GetRowValues(VisibleIndex, "U_Confez").ToString();
            InserimentoDettBozza.u_pz_lordo = Convert.ToDecimal(Articoli_DxGW.GetRowValues(VisibleIndex, "U_Pz_Lordo").ToString());
            InserimentoDettBozza.U_Sc1 = Convert.ToDecimal(Articoli_DxGW.GetRowValues(VisibleIndex, "U_Sconto1").ToString());
            InserimentoDettBozza.U_Sc2 = Convert.ToDecimal(Articoli_DxGW.GetRowValues(VisibleIndex, "U_Sconto2").ToString());
            InserimentoDettBozza.U_OrdCliDettBozza_Insert_v3(InserimentoDettBozza);

            gridArticoliInseriti.DataBind();
        }

        protected void GrigliaArticoliInseriti_CallbackPanel_CustomJSProperties(object sender, CustomJSPropertiesEventArgs e)
        {
            int visibleRow = gridArticoliInseriti.VisibleRowCount;
            if (visibleRow > 0)
            {
                e.Properties.Add("cpGeneraOrdineVisible", true);
            }
            else
            {
                e.Properties.Add("cpGeneraOrdineVisible", false);
            }
        }

        protected void gridArticoliInseriti_CustomJSProperties(object sender, ASPxGridViewClientJSPropertiesEventArgs e)
        {
            int visibleRow = gridArticoliInseriti.VisibleRowCount;
            if (visibleRow > 0)
            {
                e.Properties.Add("cpGeneraOrdineVisible", true);
            }
            else
            {
                e.Properties.Add("cpGeneraOrdineVisible", false);
            }
        }

        public int GetIdBozza_OrdCliTest(int U_IdBozza)
        {

            int Idreturn = 0;

            string SqlString = "SELECT U_IdBozza FROM OrdcliTest  WHERE U_IdBozza = " + U_IdBozza;
            using (SqlConnection myConnection2 = new SqlConnection())
            {
                myConnection2.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand2 = new SqlCommand();
                myCommand2.Connection = myConnection2;
                myCommand2.CommandText = SqlString;
                myConnection2.Open();
                bool retVal2 = false;

                SqlDataReader myReader2 = myCommand2.ExecuteReader();
                if (!myReader2.HasRows)
                { retVal2 = false; }

                else
                {
                    while (myReader2.Read())
                    {

                        Idreturn = Convert.ToInt32(myReader2["U_IdBozza"].ToString());

                    }
                }
                myReader2.Close();
                myConnection2.Close();
            }
            return Idreturn;
        }

        protected void ResetSession_Callback_Callback(object source, CallbackEventArgs e)
        {
            int NumeroOrdine = Convert.ToInt32(Request.QueryString["IdOrd"]);
            Ordini_Crud_v2 UpdateBozza = new Ordini_Crud_v2();
            UpdateBozza.DataOrdCli = DataOrdine_Txt.Date;
            UpdateBozza.PrevCons = DataConsegna_Txt.Date;
            if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
            {
                UpdateBozza.FlagTrasporto = true;
            }
            else
            {
                UpdateBozza.FlagTrasporto = false;
            }
            UpdateBozza.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
            UpdateBozza.Note = NOte_Txt.Text;
            UpdateBozza.U_OrdCliTestBozze_Update(UpdateBozza, NumeroOrdine);
            ASPxWebControl.RedirectOnCallback("Inserimento_Ordini_v3.aspx?IdOrd=" + Request.QueryString["IdOrd"]);
        }
        public string CondizioniDiPagamento_Get(string CodCli)
        {
            int OrdNum = Convert.ToInt32(Request.QueryString["NOrd"]);
            string SqlString = "SELECT TabPag.CodCPag FROM TabPag INNER JOIN CliFatt1 ON TabPag.CodCPag = CliFatt1.CodPag WHERE (CliFatt1.CodCli = '" + CodCli + "')";
            string CodCPag = "";
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
                bool retVal = false;

                SqlDataReader myReader = myCommand.ExecuteReader();
                if (!myReader.HasRows)
                { retVal = false; }

                else
                {
                    while (myReader.Read())
                    {

                        CodCPag = myReader["CodCPag"].ToString();

                    }
                }
                myReader.Close();
                myConnection.Close();
            }
            return CodCPag;
        }
    }
}