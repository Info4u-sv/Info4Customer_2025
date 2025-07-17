using DevExpress.Charts.Native;
using DevExpress.Utils;
using DevExpress.Web;
using DevExpress.XtraExport.Helpers;
using info4lab;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.ShopRM
{
    public partial class Dettaglio_Macchinari_Cliente : System.Web.UI.Page
    {
        public string Token_Edit { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            Token_Edit = Request.QueryString["Token"];
            if (!IsPostBack)
            {
                DataView dv = (DataView)Printer_Edit_Dts_Cli.Select(DataSourceSelectArguments.Empty);

                if (dv != null && dv.Count > 0)
                {
                    DataRowView row = dv[0];

                    ModelloLabel.Text = row["Modello"].ToString();
                    Printer_CodiceProdotto_Edit.Text = row["CodiceProdotto"].ToString();
                    ID_Tipologia.Text = row["Tipologia"].ToString();
                    ASPxSpinEdit1.Text = row["N_Colori"].ToString();
                }
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
        protected string GetBase64Image(object imgObj)
        {
            if (imgObj == DBNull.Value || imgObj == null)
                return "noimage.jpg";
            byte[] bytes = (byte[])imgObj;
            string base64 = Convert.ToBase64String(bytes);
            return "data:image/jpeg;base64," + base64;
        }
        protected void AggiungiAlCarrello_Callback_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = ProfileBase.Create(UserLog.UserName, true);

            string[] Parametri = e.Parameter.Split(';');
            int VisibleIndex = Convert.ToInt32(Parametri[0]);
            decimal Qta = Convert.ToDecimal(Parametri[1].ToString().Replace(".", ","));
            string TipoGriglia = Parametri.Length > 2 ? Parametri[2] : "desktop";

            string ProductCod = string.Empty;

            if (TipoGriglia == "desktop")
                ProductCod = ShopList1.GetCardValues(VisibleIndex, "CProdotto").ToString();
            else
                ProductCod = ASPxCardView1.GetCardValues(VisibleIndex, "CProdotto").ToString();

            string DisplayName = (TipoGriglia == "desktop")
                ? ShopList1.GetCardValues(VisibleIndex, "CProdotto").ToString()
                : ASPxCardView1.GetCardValues(VisibleIndex, "CProdotto").ToString();

            string descrizioneConsumabili = string.Empty;


            using (SqlDataReader readerDescrizione = new Sql4Gestionale().ExecuteReader(
                @"SELECT LEFT(Ricambi_Consumabili.Descrizione, 200) AS Descrizione,
             Colori_Print.Descrizione AS Colore
      FROM [INFO4U_INTRA_2021].[dbo].[Ricambi_Consumabili]
      INNER JOIN [INFO4U_INTRA_2021].[dbo].[Colori_Print]
      ON Ricambi_Consumabili.ColoreID = Colori_Print.ID
      WHERE Ricambi_Consumabili.CodiceProdotto = @CodiceProdotto",
                new SqlParameter() { ParameterName = "@CodiceProdotto", Value = ProductCod }))
            {
                if (readerDescrizione.Read())
                {
                    string desc = readerDescrizione["Descrizione"].ToString();
                    string colore = readerDescrizione["Colore"].ToString();

                    descrizioneConsumabili = colore + "<br />" + desc;
                }
                else
                {
                    descrizioneConsumabili = ProductCod;
                }
            }

            decimal ItemPrice = 0;
            string descrizione = DisplayName;

            string CodDep = HttpContext.Current.Request.Cookies["CodDep"].Value.Replace("CodDep=", string.Empty);
            decimal verificacart = StoredShoppingCart.VerificaItemStatic(ProductCod, CodDep);
            decimal qtasel = Qta;

            string NomeContattoRM = MyProfile.Name + " " + MyProfile.cognome;

            int CategoryId = 0;
            //string Categoria = (TipoGriglia == "desktop")
            //    ? ShopList1.GetCardValues(VisibleIndex, "Categoria").ToString()
            //    : ASPxCardView1.GetCardValues(VisibleIndex, "Categoria").ToString();

            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CategoryId FROM U_SHP_Category WHERE DisplayName = @DisplayName", new SqlParameter() { ParameterName = "@DisplayName", Value = "" });

            if (reader.Read())
            {
                CategoryId = Convert.ToInt32(reader["CategoryId"]);
            }

            SHP_Articoli _ArticoloSelect = SHP_Articoli.U_GetDettaglioSHP_Articolo(ProductCod, CategoryId);

            if (verificacart == -1)
            {
                string UM = "PZ";
                int CategoryID = 0;
                string MenuItemID = ProductCod;
                string ItemName = descrizioneConsumabili;

                _ = StoredShoppingCart.InsertItem(MenuItemID, ItemName, qtasel, qtasel, CategoryID, UM);
            }
            else
            {
                qtasel = verificacart + qtasel;
                _ = StoredShoppingCart.UpdateItem(ProductCod, qtasel);
            }
        }

    }
}