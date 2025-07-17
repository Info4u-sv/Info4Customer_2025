using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using DevExpress;
using DevExpress.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using info4lab.Portal;
using info4lab;
using System.Text;
using INTRA.Age_Ordini.AppCode;


namespace INTRA.Age_Ordini.BR_Ordini
{
    public partial class Inserimento_Ordini_view_v4 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            int NumeroOrdine = Convert.ToInt32(Request.QueryString["NOrd"]);

            if (Session["NumeroRigaGrigliaInseriti"] == null)
            {
                Session["NumeroRigaGrigliaInseriti"] = 0;
            }

            string CodCli = Request.QueryString["CodCli"];
            bool IsEdit = false;
            if (!IsPostBack)
            {
                TitoloPagina_Lbl.Text = "Nuovo Ordine";

                Session.Clear();
                Session["CodCliDataSource"] = "";
                Session["CodArtSession"] = "";
                Session["CodLisSession"] = "";
                Session["DescrArtSession"] = "";

                Session["RowGrid"] = null;
                Session["CodArt"] = null;
                Session["OrdineConfermato"] = "VERO";
            }

            if (NumeroOrdine != 0)
            { IsEdit = true; }
            MembershipUser UserLog = Membership.GetUser();
            switch (IsEdit)
            {
                //INSERT MODE
                case false:
                    StatusOrdine_Img.Visible = false;
                    ConfermaOrdine_Btn.Visible = true;
                    InviaMail_Btn.Visible = false;
                    InviaEmailAlCliente_Btn.Visible = false;
                    if (grid.VisibleRowCount == 0 || Cliente_Ddl.SelectedIndex == -1)
                    {
                        ConfermaOrdine_Btn.Visible = false;
                        InviaMail_Btn.Visible = false;
                        InviaEmailAlCliente_Btn.Visible = false;
                    }
                    else
                    {
                        ConfermaOrdine_Btn.Visible = true;
                        InviaMail_Btn.Visible = false;
                        InviaEmailAlCliente_Btn.Visible = false;
                    }

                    //Da rivedere l'inserimento della query per tirar fuori i clienti
                    if (!IsPostBack)
                    {
                        string Name = UserLog.UserName.ToUpper();
                        if (Name.Contains("AGE_"))
                        {

                        }
                        else
                        {
                            Cliente_Dts.SelectCommand = "SELECT Clienti.CodCli, Clienti.Denom, TabAge.U_User_Web FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge ";
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
                        grid.ClientVisible = true;
                        Session["CodCliDataSource"] = Cliente_Ddl.SelectedItem.Value.ToString();
                        //if (string.IsNullOrEmpty(PrezzoTrasporto_Txt.Text) && TrasportoCliente_Txt != null)
                        //{
                        //    //PrezzoTrasporto_Txt.Text = Convert.ToString(U_TrasportoGet(Cliente_Ddl.SelectedItem.Value.ToString()));
                        //    PrezzoTrasporto_Txt.Text = TrasportoCliente_Txt.Text;
                        //}

                        TitoloPagina_Lbl.Text = "Nuovo Ordine per <strong style='color:red'>" + Cliente_Ddl.SelectedItem.Text + "</strong>";

                        //if (Session["RowGrid"] != null)
                        //{
                        //    grid.DataSource = Session["RowGrid"];
                        //    grid.DataBind();
                        //}

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
                        Indietro_Btn.Visible = false;
                        PageControl.ClientVisible = false;
                        grid.ClientVisible = false;
                    }
                    break;
                //Edit Mode
                case true:

                    //if (ClasseTasti == "0" || ClasseTasti == "1" || ClasseTasti == "2" || ClasseTasti == "3")
                    //{
                    PageControl.TabPages[2].Visible = false;
                    ArticoliDescrSrch_Txt.Enabled = false;
                    ArticoliCodArtSrch_Txt.Enabled = false;
                    Ricerca_Btn.Enabled = false;
                    Articoli_DxGW.Visible = false;
                    ListaArticoliERicercaArticoli_Pnl.Visible = false;
                    ConfermaOrdine_Btn.Visible = false;
                    FlagTrasporto_CkbxL.Enabled = false;
                    grid.Enabled = false;
                    DataOrdine_Txt.Enabled = false;
                    DataConsegna_Txt.Enabled = false;
                    //CondizioniPagamento_Ddl.Enabled = false;
                    NOte_Txt.Enabled = false;

                    string ClasseTasti = "";
                    ClasseTasti = StatusOffertaGet();
                    PageControl.ActiveTabIndex = 1;


                    ClasseTastiStatus(ClasseTasti);
                    PanelCostotrasporto_Pnl.ClientVisible = true;
                    Ordini_Crud_v2 DatiOrdine = new Ordini_Crud_v2();
                    DatiOrdine = DatiOrdine.U_OrdCliTest_Get(NumeroOrdine, CodCli);
                    CondizioniPagamento_lbl.Text = DatiOrdine.DescrizioneCondPag;
                    InviaMail_Btn.Visible = true;
                    InviaEmailAlCliente_Btn.Visible = true;
                    SelezionaCliente_Pnl.Visible = false;
                    Indietro_Btn.Visible = true;
                    PageControl.ClientVisible = true;
                    grid.ClientVisible = true;
                    //PrezzoTrasporto_Txt.Text = Convert.ToString(U_TrasportoGet(CodCli));
                    Session["CodCliDataSource"] = CodCli;
                    TitoloPagina_Lbl.Text = "Modifica Ordine N° <strong style='Color:red'>" + DatiOrdine.OrdNum + " </strong>";
                    CostoTrasportoForzato_Txt.Text = Convert.ToString(DatiOrdine.CostoTrasportoString);
                    if (DatiOrdine.FlagTrasporto == true)
                    {
                        PanelCostotrasporto_Pnl.Visible = true;
                        FlagTrasporto_CkbxL.SelectedIndex = 0;
                    }
                    else
                    {
                        PanelCostotrasporto_Pnl.Visible = true;
                        FlagTrasporto_CkbxL.SelectedIndex = 1;
                    }
                    DataOrdine_Txt.Date = DatiOrdine.OrdDat;
                    DataConsegna_Txt.Date = DatiOrdine.PrevCons;
                    NOte_Txt.Text = DatiOrdine.Note.Replace("\n", "<br /> ");
                    //Valuta_Lbl.Text = Convert.ToString(DatiOrdine.Valuta);
                    //createnewrowEDITMODE();
                    Session["CodCli"] = CodCli;

                    //if (Session["RowGrid"] != null)
                    //{
                    //    grid.DataSource = Session["RowGrid"];
                    //    grid.DataBind();
                    //}

                    break;
            }

        }

        protected void grid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            int index = -1;
            if (int.TryParse(e.Parameters, out index))
                grid.SettingsEditing.Mode = (GridViewEditingMode)index;
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

        public void createnewrow(int Visibleindex)
        {
            int Rowid = Visibleindex;
            GridViewDataColumn CNote = Articoli_DxGW.Columns[8] as GridViewDataColumn;
            GridViewDataColumn CQta = Articoli_DxGW.Columns[4] as GridViewDataColumn;
            ASPxTextBox NoteArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(Rowid, CNote, "NoteArticolo_Txt") as ASPxTextBox;
            ASPxSpinEdit QtaArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(Rowid, CQta, "QtaArticolo_Txt") as ASPxSpinEdit;
            decimal ImportoTotale = Convert.ToDecimal(Articoli_DxGW.GetRowValues(Rowid, "Prezzo"));
            ImportoTotale = ImportoTotale * Convert.ToDecimal(QtaArticolo_Txt.Text.ToString());
            decimal Prezzo = Convert.ToDecimal(Articoli_DxGW.GetRowValues(Rowid, "Prezzo"));
            string UMValue = "";
            string Confezione = Articoli_DxGW.GetRowValues(Rowid, "U_Confez").ToString();
            object ControllNull = Articoli_DxGW.GetRowValues(Rowid, "Misura");
            if (ControllNull != null)
            {
                UMValue = Articoli_DxGW.GetRowValues(Rowid, "Misura").ToString();
            }
            string Note = NoteArticolo_Txt.Text;
            string QtaTot = QtaArticolo_Txt.Text;
            try
            {
                Session["NumeroRigaGrigliaInseriti"] = Convert.ToInt32(Session["NumeroRigaGrigliaInseriti"].ToString()) + 1;
                DataTable mytable = new DataTable();
                if (Session["RowGrid"] != null)
                {
                    mytable = (DataTable)Session["RowGrid"];
                    DataRow dr = null;
                    if (mytable.Rows.Count > 0)
                    {
                        dr = mytable.NewRow();
                        dr["CodArt"] = Session["CodiceArticolo"].ToString();
                        dr["Descrizione"] = Session["DescrizioneArticolo"].ToString();
                        dr["UM"] = UMValue;
                        dr["U_Confez"] = Confezione;
                        dr["Prezzo"] = Prezzo;
                        dr["TotQta"] = QtaTot;
                        dr["TotImp"] = ImportoTotale;
                        dr["Note"] = Note;
                        dr["NRiga"] = Convert.ToInt32(Session["NumeroRigaGrigliaInseriti"].ToString());
                        mytable.Rows.Add(dr);
                        Session["RowGrid"] = mytable;
                    }
                }
                else
                {
                    mytable.Columns.Add(new DataColumn("CodArt", typeof(string)));
                    mytable.Columns.Add(new DataColumn("Descrizione", typeof(string)));
                    mytable.Columns.Add(new DataColumn("UM", typeof(string)));
                    mytable.Columns.Add(new DataColumn("U_Confez", typeof(string)));
                    mytable.Columns.Add(new DataColumn("Prezzo", typeof(float)));
                    mytable.Columns.Add(new DataColumn("TotQta", typeof(float)));
                    mytable.Columns.Add(new DataColumn("TotImp", typeof(float)));
                    mytable.Columns.Add(new DataColumn("Note", typeof(string)));
                    mytable.Columns.Add(new DataColumn("NRiga", typeof(int)));
                    DataRow dr1 = mytable.NewRow();
                    dr1["CodArt"] = Session["CodiceArticolo"].ToString();
                    dr1["Descrizione"] = Session["DescrizioneArticolo"].ToString();
                    dr1["UM"] = UMValue;
                    dr1["U_Confez"] = Confezione;
                    dr1["Prezzo"] = Prezzo;
                    dr1["TotQta"] = QtaTot;
                    dr1["TotImp"] = ImportoTotale;
                    dr1["Note"] = Note;
                    dr1["NRiga"] = Convert.ToInt32(Session["NumeroRigaGrigliaInseriti"].ToString());
                    mytable.Rows.Add(dr1);
                    Session["RowGrid"] = mytable;
                }
                grid.DataSource = Session["RowGrid"];
                //grid.DataBind();
                NoteArticolo_Txt.Text = "";
                QtaArticolo_Txt.Text = "0";
                //Articoli_DxGW.DataBind();
                // SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);
            }
            catch (Exception ex)
            {
                SiteMaster.ShowToastr(Page, "Operazione non Eseguita! L'articolo è già presente, si prega di modificarlo dalla lista oppure di sceglierne un altro.", "Annullamento", "Error", false, "toast-top-right", false);
            }

        }
        protected void ConfermaOrdine_Btn_Click(object sender, EventArgs e)
        {

        }

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

            Session["CodCli"] = Cliente_Ddl.SelectedItem.Value.ToString();
            Session["CodCliDataSource"] = Cliente_Ddl.SelectedItem.Value.ToString();

            PageControl.ClientVisible = true;
            grid.ClientVisible = true;

            Ordini_Crud_v2 DatiOrdine = new Ordini_Crud_v2();
            DatiOrdine = DatiOrdine.U_DatiCliente_Get(Cliente_Ddl.SelectedItem.Value.ToString());
        }


        public void createnewrowEDITMODE()
        {
            DataTable mytable = ((DataView)ArticoliOrdine_Dts.Select(DataSourceSelectArguments.Empty)).Table;
            Session["RowGrid"] = mytable;
            grid.DataSourceID = "";
            grid.DataSource = Session["RowGrid"];
            grid.DataBind();
        }

        protected void grid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int NumeroOrdine = Convert.ToInt32(Request.QueryString["NOrd"]);
            decimal TotQta = Convert.ToDecimal(e.NewValues["TotQta"].ToString());
            decimal TotImp = Convert.ToDecimal(e.NewValues["TotImp"].ToString());
            decimal Prezzo = Convert.ToDecimal(e.NewValues["Prezzo"].ToString());
            decimal TotaleCostoArticoli = (TotQta * Prezzo);

            DataTable MyTable = new DataTable();
            MyTable = (DataTable)Session["RowGrid"];
            DataRow row = MyTable.Select("CodArt='" + e.NewValues["CodArt"].ToString() + "'").FirstOrDefault();
            row["UM"] = e.NewValues["UM"].ToString();

            row["CodArt"] = e.NewValues["CodArt"].ToString();
            row["TotQta"] = Convert.ToDecimal(e.NewValues["TotQta"].ToString());
            row["Prezzo"] = Convert.ToDecimal(e.NewValues["Prezzo"].ToString());
            row["TotImp"] = Convert.ToDecimal(TotaleCostoArticoli);
            row["Descrizione"] = e.NewValues["Descrizione"].ToString();
            row["Note"] = e.NewValues["Note"].ToString();
            Session["RowGrid"] = MyTable;
            grid.DataSource = Session["RowGrid"];
            grid.CancelEdit();
            e.Cancel = true;
            //grid.DataBind();
            SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);

        }

        protected void grid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {

            Session["NumeroRigaGrigliaInseriti"] = Convert.ToInt32(Session["NumeroRigaGrigliaInseriti"].ToString()) - 1;
            DataTable MyTable = new DataTable();
            MyTable = (DataTable)Session["RowGrid"];
            DataRow row = MyTable.Select("CodArt='" + e.Values["CodArt"].ToString() + "'").FirstOrDefault();
            row.Delete();
            Session["RowGrid"] = MyTable;
            grid.DataSource = Session["RowGrid"];
            if (grid.VisibleRowCount == 0)
            {
                Session["RowGrid"] = null;
             
            }
            grid.CancelEdit();
            e.Cancel = true;

            //for (int i = 0; i == grid.VisibleRowCount; i++)
            //{
            //    Session["RowGrid"] = null;
            //}
            string NOrdine = Request.QueryString["NOrd"];
            if (grid.VisibleRowCount == 0)
            {
                ConfermaOrdine_Btn.Visible = false;
                InviaMail_Btn.Visible = false;
                InviaEmailAlCliente_Btn.Visible = false;
            }
            else
            {
                if (NOrdine != "")
                {
                    ConfermaOrdine_Btn.Visible = false;
                    InviaMail_Btn.Visible = true;
                    InviaEmailAlCliente_Btn.Visible = true;
                }
                else
                {
                    InviaEmailAlCliente_Btn.Visible = false;
                    InviaMail_Btn.Visible = false;
                    ConfermaOrdine_Btn.Visible = true;
                }
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
                    string SqlString = "SELECT TabAge.Descrizione, TabAge.CodAge, TabAge.U_User_Web FROM CliFatt3 INNER JOIN Clienti ON CliFatt3.CodCli = Clienti.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (CliFatt3.CodCli = '" + CodiceCliente + "')";
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
                string SqlString = "SELECT TabAge.Descrizione, TabAge.CodAge, TabAge.U_User_Web FROM CliFatt3 INNER JOIN Clienti ON CliFatt3.CodCli = Clienti.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (CliFatt3.CodCli = '" + CodiceCliente + "')";
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

            string SqlString = "SELECT U_Trasporto FROM Clienti WHERE (Codcli = '" + CodiceCliente + "') ";
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
                Cliente_Dts.SelectCommand = @"  SELECT  CodCli, Denom,NumeroRiga from (SELECT Clienti.CodCli, Clienti.Denom, TabAge.U_User_Web , row_number() over(order by Clienti.CodCli) as NumeroRiga 
           FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (TabAge.U_User_Web = '" + UserLog.UserName + "') and (Denom LIKE @filter) )  as st  WHERE   st.NumeroRiga between @startIndex and @endIndex ORDER BY CodCli asc";
            }
            else
            {
                Cliente_Dts.SelectCommand = @"  SELECT  CodCli, Denom,NumeroRiga from (SELECT Clienti.CodCli, Clienti.Denom, TabAge.U_User_Web , row_number() over(order by Clienti.CodCli) as NumeroRiga 
           FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE ( Denom LIKE @filter) )  as st  WHERE  st.NumeroRiga between @startIndex and @endIndex ORDER BY CodCli asc";
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
                Cliente_Dts.SelectCommand = @" SELECT  CodCli, Denom,NumeroRiga from (SELECT Clienti.CodCli, Clienti.Denom, TabAge.U_User_Web , row_number() over(order by Clienti.CodCli) as NumeroRiga 
           FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge WHERE (TabAge.U_User_Web = '" + UserLog.UserName + "'))  as st   ORDER BY CodCli asc";

            }
            else
            {
                Cliente_Dts.SelectCommand = @" SELECT  CodCli, Denom,NumeroRiga from (SELECT Clienti.CodCli, Clienti.Denom, TabAge.U_User_Web , row_number() over(order by Clienti.CodCli) as NumeroRiga 
           FROM Clienti INNER JOIN CliFatt3 ON Clienti.CodCli = CliFatt3.CodCli INNER JOIN TabAge ON CliFatt3.CodAge = TabAge.CodAge )  as st   ORDER BY CodCli asc";
            }
            Cliente_Ddl.DataSource = Cliente_Dts;
            Cliente_Ddl.DataBind();
        }

        protected void Callback_Callback(object source, CallbackEventArgs e)
        {
            if (Cliente_Ddl.SelectedIndex != -1)
            {
                SelezionaCliente_Pnl.Visible = false;
                Session["CodCliDataSource"] = Cliente_Ddl.SelectedItem.Value.ToString();
                Session["CodCli"] = Cliente_Ddl.SelectedItem.Value.ToString();
                PageControl.ClientVisible = true;
                grid.ClientVisible = true;
                //CondizioniPagamento_Dts.DataBind();
                //CondizioniPagamento_Ddl.DataBind();
                DetCli_Fw.DataBind();
                Ordini_Crud_v2 DatiOrdine = new Ordini_Crud_v2();
                DatiOrdine = DatiOrdine.U_DatiCliente_Get(Cliente_Ddl.SelectedItem.Value.ToString());
                //Valuta_Lbl.Text = Convert.ToString(DatiOrdine.Valuta);
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
            string CodCli = Request.QueryString["CodCli"];
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
                e.QueryableSource = from U_StoricoVenditeArticoloPerAgentePerCliente_VIew in db.U_StoricoVenditeArticoloPerAgentePerCliente_VIew.Where(x => x.CodArt == Session["CodArtPopUp"].ToString() && x.Agente == CodAge && x.CodCli == CodCli)
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
            Session["CodArtPopUp"] = grid.GetRowValues(Convert.ToInt32(e.Parameter), "CodArt");
            PopupControl.HeaderText = "STORICO VENDITE ARTICOLO: " + Session["CodArtPopUp"].ToString();
            Storico_Grw.DataBind();
        }

        protected void grid_HtmlRowCreated(object sender, ASPxGridViewTableRowEventArgs e)
        {
            string NumeroOrdine = Request.QueryString["NOrd"];
            if (grid.VisibleRowCount > 0)
            {
                if (string.IsNullOrEmpty(NumeroOrdine))
                {
                    ConfermaOrdine_Btn.Visible = true;
                    InviaMail_Btn.Visible = false;
                    InviaEmailAlCliente_Btn.Visible = false;
                }
                else
                {
                    InviaMail_Btn.Visible = true;
                    InviaEmailAlCliente_Btn.Visible = true;
                }
            }


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
            string NumeroOrdine = Request.QueryString["NOrd"];
            string varCodCli = "";
            if (string.IsNullOrEmpty(NumeroOrdine))
            {
                varCodCli = Cliente_Ddl.SelectedItem.Value.ToString();
            }
            else
            {
                varCodCli = Request.QueryString["CodCli"];
            }
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

            // Modifica 05/10/2018
            rapportini.PrezzoDa = Convert.ToDecimal(PrezzoTrasporto_Txt.Text);
            rapportini.PrezzoA = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
            if (rapportini.PrezzoDa != rapportini.PrezzoA)
            {
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
            Ordini_Crud_v2 DatiOrdine = new Ordini_Crud_v2();
            DatiOrdine = DatiOrdine.U_OrdCliTest_Get(Convert.ToInt32(Request.QueryString["NOrd"]), Request.QueryString["CodCli"]);
            HiddenField ScontoIncondizionato_HFld = (HiddenField)DetCli_Fw.FindControl("ScontoIncondizionato_HFld");

            TCK_Ticket_v2 GetTicket = new TCK_Ticket_v2();
            GetTicket = GetDisplayTicket();
            GetTicket.CodRapportino = DatiOrdine.OrdNum;
            GetTicket.TckInviatoA = EmailCliente_Txt.Text;
            GetTicket.EmailTecnicoPerCliente = UserLog.Email;
            GetTicket.ScontoIncondizionato = Convert.ToDecimal(ScontoIncondizionato_HFld.Value);
            ASPxLabel CodAgeCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodAgeCliente_Txt");

            try
            {
                //TCK_EmailGest_v2.SendTicketMail(Convert.ToInt32(Request.QueryString["NOrd"]), 0, "Caglio Ordine", GetTicket, UserLog.Email, CodAgeCliente_Txt.Text);
            }
            catch (Exception ex)
            {
            }

        }

        protected void GridviewArticoli_CallBkPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            ASPxLabel CodLisCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodLisCliente_Txt");
            if (!string.IsNullOrEmpty(ArticoliCodArtSrch_Txt.Text) || !string.IsNullOrEmpty(ArticoliDescrSrch_Txt.Text))
            {
                int NumOrd = Convert.ToInt32(Request.QueryString["NOrd"]);
                string CodLis = "";
                string CodCli = Request.QueryString["CodCli"];
                //Ordini_Crud_v2 DatiCliente = new Ordini_Crud_v2();
                if (NumOrd == 0)
                {
                    if (Cliente_Ddl.SelectedIndex != -1)
                    {
                        CodLis = CodLisCliente_Txt.Text;
                    }
                }
                else
                {
                    CodLis = CodLisCliente_Txt.Text;
                }
                string CodArt = ArticoliCodArtSrch_Txt.Text;
                string DescrizioneArticolo = ArticoliDescrSrch_Txt.Text;
                if (!string.IsNullOrEmpty(CodArt))
                {
                    Session["CodArtSession"] = CodArt;
                }
                else
                {
                    Session["CodArtSession"] = string.Empty;
                }
                if (!string.IsNullOrEmpty(DescrizioneArticolo))
                {
                    Session["DescrArtSession"] = DescrizioneArticolo;
                }
                else
                {
                    Session["DescrArtSession"] = string.Empty;
                }
                Session["CodLisSession"] = CodLis;
                Articoli_DxGW.DataBind();
            }

        }


        protected void DetCli_Fw_DataBound(object sender, EventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();
            ASPxLabel TrasportoCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("TrasportoCliente_Txt");
            ASPxLabel NomeCLi_Lbl = (ASPxLabel)DetCli_Fw.FindControl("NomeCLi_Lbl");
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
            if (NomeCLi_Lbl != null)
            {
                TitoloPagina_Lbl.Text = TitoloPagina_Lbl.Text + " per: <strong style='color:red;'>" + NomeCLi_Lbl.Text + "</strong>";
            }

        }

        protected void GrigliaArticoli_Clbk_Callback(object source, CallbackEventArgs e)
        {
            GridViewDataColumn CQta = Articoli_DxGW.Columns[4] as GridViewDataColumn;
            ASPxSpinEdit QtaArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(Convert.ToInt32(e.Parameter), CQta, "QtaArticolo_Txt") as ASPxSpinEdit;
            decimal QtaArtSelezionato = 0;
            if (!string.IsNullOrEmpty(QtaArticolo_Txt.Text.ToString()))
            {
                QtaArtSelezionato = Convert.ToDecimal(QtaArticolo_Txt.Text.ToString());
            }

            if (QtaArtSelezionato == 0)
            {
                QtaArticolo_Txt.IsValid = false;
                QtaArticolo_Txt.ErrorText = "Inserire una quantità superiore a 0";
            }
            else
            {
                QtaArticolo_Txt.IsValid = true;
                ArticoliCodArtSrch_Txt.Text = "";

                Session["CodArt"] = Articoli_DxGW.GetRowValues(Convert.ToInt32(e.Parameter), "CodArt").ToString();
                Session["CodiceArticolo"] = Articoli_DxGW.GetRowValues(Convert.ToInt32(e.Parameter), "CodArt").ToString();
                Session["DescrizioneArticolo"] = Articoli_DxGW.GetRowValues(Convert.ToInt32(e.Parameter), "DescrizioneArticolo").ToString();
                Session["ControlloCodiceArticoloIf"] = Articoli_DxGW.GetRowValues(Convert.ToInt32(e.Parameter), "CodArt").ToString();

                if (Session["RowGrid"] != null)
                {
                    if (Session["CodArt"] == null || string.IsNullOrEmpty(Session["CodArt"].ToString()))
                    {
                        SiteMaster.ShowToastr(Page, "Operazione non Eseguita! Non è stato inserito nessun articolo.", "Annullamento", "Error", false, "toast-top-right", false);
                        Session["CodArt"] = null;
                    }
                    else
                    {
                        DataTable MyTable = new DataTable();
                        MyTable = (DataTable)Session["RowGrid"];

                        int Row = MyTable.Select("CodArt='" + Session["CodiceArticolo"].ToString() + "'").Length;
                        if (Row == 0)
                        {
                            createnewrow(Convert.ToInt32(e.Parameter));
                            Session["CodArt"] = null;
                        }
                        else
                        {
                            SiteMaster.ShowToastr(Page, "Operazione non Eseguita! L\\'articolo è già presente, si prega di modificarlo dalla lista oppure di sceglierne un altro.", "Annullamento", "Error", false, "toast-top-right", false);
                            Session["CodArt"] = null;
                        }
                    }
                }
                else
                {
                    if (Session["CodArt"] != null || !string.IsNullOrEmpty(Session["CodArt"].ToString()))
                    {
                        createnewrow(Convert.ToInt32(e.Parameter));
                        Session["CodArt"] = null;
                    }

                }

                if (grid.VisibleRowCount == 0 || Cliente_Ddl.SelectedIndex == -1)
                {
                    ConfermaOrdine_Btn.Visible = false;
                    InviaMail_Btn.Visible = false;
                    InviaEmailAlCliente_Btn.Visible = false;
                }
                else
                {
                    ConfermaOrdine_Btn.Visible = true;
                }

            }
        }

        protected void Articoli_DxGW_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {

            DataTable mytable = new DataTable();
            if (Session["RowGrid"] != null)
            {
                mytable = (DataTable)Session["RowGrid"];

            }

            for (int i = 0; i < mytable.Rows.Count; i++)
            {

                string CodArtInseriti = mytable.Rows[i]["CodArt"].ToString();
                string CodArtDaInserire = "";
                if (e.VisibleIndex > -1)
                {
                    CodArtDaInserire = Articoli_DxGW.GetRowValues(e.VisibleIndex, "CodArt").ToString();
                }

                if (CodArtDaInserire == CodArtInseriti)
                {
                    GridViewDataColumn CNote = Articoli_DxGW.Columns[8] as GridViewDataColumn;
                    GridViewDataColumn CQta = Articoli_DxGW.Columns[4] as GridViewDataColumn;
                    ASPxTextBox NoteArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(e.VisibleIndex, CNote, "NoteArticolo_Txt") as ASPxTextBox;
                    ASPxSpinEdit QtaArticolo_Txt = Articoli_DxGW.FindRowCellTemplateControl(e.VisibleIndex, CQta, "QtaArticolo_Txt") as ASPxSpinEdit;
                    QtaArticolo_Txt.Value = Articoli_DxGW.GetRowValues(e.VisibleIndex, "U_Confez");
                    NoteArticolo_Txt.Text = "";
                    e.Row.BackColor = System.Drawing.Color.PaleGreen;
                }
            }
        }

        protected void ConfermaOrdine_Clbk_Callback(object source, CallbackEventArgs e)
        {
            ASPxLabel CodAgeCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodAgeCliente_Txt");
            ASPxLabel CodLisCliente_Txt = (ASPxLabel)DetCli_Fw.FindControl("CodLisCliente_Txt");
            try
            {
                Ordini_Crud_v2 InserimentoTest = new Ordini_Crud_v2();
                InserimentoTest.OrdDat = DataOrdine_Txt.Date;
                InserimentoTest.PrevCons = DataConsegna_Txt.Date;
                InserimentoTest.CodCli = Cliente_Ddl.SelectedItem.Value.ToString();
                string CodCli = Cliente_Ddl.SelectedItem.Value.ToString();
               
                InserimentoTest.CodBan = "";
                InserimentoTest.BanCli = 0;
                InserimentoTest.NumOrdCli = "";
                InserimentoTest.DataOrdCli = DataOrdine_Txt.Date;
                InserimentoTest.CodVal = "";
                MembershipUser UserLog = Membership.GetUser();
                InserimentoTest.Agente = CodAgeCliente_Txt.Text;
                InserimentoTest.Deposito = "01";
                InserimentoTest.Sconto1 = 0;
                InserimentoTest.Sconto2 = 0;
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
                string OrdNum = "O" + UpdateLastIdProtocollo();
                InserimentoTest.OrdNum = OrdNum;
                if (FlagTrasporto_CkbxL.SelectedItem.Value.ToString() == "1")
                {
                    InserimentoTest.CostoTrasporto = Convert.ToDecimal(CostoTrasportoForzato_Txt.Text);
                    InserimentoTest.FlagTrasporto = true;
                }
                else
                {
                    InserimentoTest.CostoTrasporto = Convert.ToDecimal(PrezzoTrasporto_Txt.Text);
                    InserimentoTest.FlagTrasporto = false;
                }

                Session["LastIdOrdine"] = InserimentoTest.U_OrdCliTest_Insert(InserimentoTest);

                decimal TotaleQuantita = 0;
                float TotaleImporto = 0;
                int RowCount = 0;
                Ordini_Crud_v2 InserimentoDett = new Ordini_Crud_v2();
                DataTable mytable = new DataTable();
                if (Session["RowGrid"] != null)
                {
                    mytable = (DataTable)Session["RowGrid"];

                }
                for (int i = 0; i < mytable.Rows.Count; i++)
                {

                }
                Ordini_Crud_v2 UpdateQta = new Ordini_Crud_v2();
                UpdateQta.TotQta = (float)Convert.ToDouble(TotaleQuantita);
                UpdateQta.TotImp = TotaleImporto;
                UpdateQta.IdTestata = Convert.ToInt32(Session["LastIdOrdine"].ToString());
                UpdateQta.U_OrdCliTestQta_Update(UpdateQta);


                TCK_Ticket_v2 GetTicket = new TCK_Ticket_v2();
                GetTicket = GetDisplayTicket();
                GetTicket.CodRapportino = OrdNum;
                //TCK_EmailGest_v2.SendTicketMail(Convert.ToInt32(Session["LastIdOrdine"].ToString()), 0, UserLog.UserName, GetTicket, UserLog.Email, CodAgeCliente_Txt.Text);

                ASPxWebControl.RedirectOnCallback("/Brico_Ordini/Inserimento_Ordini_v2.aspx?NOrd=" + Convert.ToInt32(Session["LastIdOrdine"].ToString()) + "&CodCli=" + Cliente_Ddl.SelectedItem.Value.ToString());

            }
            catch (Exception ex)
            {
                SiteMaster.ShowToastr(Page, "Operazione Non Eseguita!", "Annullata", "Error", false, "toast-top-right", false);
            }
        }

        protected void Articoli_DxGW_Load(object sender, EventArgs e)
        {
            Articoli_DxGW.DataSourceID = "Articoli_Dts";
            Articoli_DxGW.DataBind();
        }
    }
}