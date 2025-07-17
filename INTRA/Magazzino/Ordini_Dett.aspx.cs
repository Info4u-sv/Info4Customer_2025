using DevExpress.DataProcessing;
using DevExpress.Web;
using DevExpress.XtraRichEdit.Import.Html;
using info4lab;
using Info4U.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Magazziniere
{
    public partial class Ordini_Dett : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request["OrdNum"] != null)
                {
                    SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT ID FROM U_I_OrdCliTest WHERE OrdNum = (@OrdNum)", new SqlParameter() { ParameterName = "@OrdNum", Value = Request.QueryString["OrdNum"] });
                    if (reader.Read())
                    {
                        new Sql4Gestionale().ExecuteNonQuery("UPDATE U_I_OrdCliDett SET U_DaEvadere = 0 WHERE IDTestata = @ID", new SqlParameter { ParameterName = "@ID", Value = reader["ID"] });
                    }
                    reader.Close();
                }
            }
        }

        protected void GeneraBolla_Callback_Callback(object source, CallbackEventArgs e)
        {
            int daFatt = Convert.ToInt32(e.Parameter);
            int daEvadere = 0;

            var gridView = daFatt == 1 ? Ord_Dett_Gridview : Ord_Dett_Contratto;
            for (int i = 0; i < gridView.VisibleRowCount; i++)
            {
                daEvadere += Convert.ToInt32(gridView.GetRowValues(i, "U_DaEvadere"));
            }

            if (daEvadere > 0)
            {
                SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT ID FROM U_I_OrdCliTest WHERE OrdNum = (@OrdNum)", new SqlParameter() { ParameterName = "@OrdNum", Value = Request.QueryString["OrdNum"] });
                if (reader.Read())
                {
                    int IdTestata = Convert.ToInt32(reader["ID"]);
                    MembershipUser UserLog = Membership.GetUser();
                    Sql4Gestionale objSqlHelper = new Sql4Gestionale();
                    SqlParameter[] objParams = new SqlParameter[3];
                    objParams[0] = new SqlParameter("@IdOrdineTest", IdTestata);
                    objParams[1] = new SqlParameter("@Utente", UserLog.UserName);
                    objParams[2] = new SqlParameter("@DaFatt", daFatt);
                    int idTest = objSqlHelper.ExecuteNonQueryForNews("U_I_King_BollaDaOrdine_Insert", objParams);
                    GeneraBolla_Callback.JSProperties["cpIdTest"] = idTest;
                }
                reader.Close();
            }
            GeneraBolla_Callback.JSProperties["cpDaEvadere"] = daEvadere;
            GeneraBolla_Callback.JSProperties["cpDaFatt"] = daFatt;
        }

        protected void Ord_Dett_Contratto_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT U_I_OrdCliTest.ID, U_I_OrdCliDett.QtaOrd, U_I_OrdCliDett.QtaEva, U_I_OrdCliDett.Importo FROM U_I_OrdCliTest INNER JOIN U_I_OrdCliDett ON U_I_OrdCliTest.ID = U_I_OrdCliDett.IDTestata WHERE (U_I_OrdCliTest.OrdNum = @OrdNum)", new SqlParameter() { ParameterName = "@OrdNum", Value = Request.QueryString["OrdNum"] });
            int qta = 0, qtaEva = 0;
            decimal imp = 0;
            while (reader.Read())
            {
                qta += Convert.ToInt32(reader["QtaOrd"]);
                qtaEva += Convert.ToInt32(reader["QtaEva"]);
                imp += Convert.ToDecimal(reader["Importo"]);
            }
            reader.Close();
            int flagEvaso = qtaEva <= 0 ? 1 : 2;
            if (qta <= qtaEva) flagEvaso = 3;
            _ = new Sql4Gestionale().ExecuteNonQuery("UPDATE U_I_OrdCliTest SET TotQta = @Qta, TotImp = @Imp, FlagEvaso = @Flag WHERE OrdNum = @OrdNum", new SqlParameter() { ParameterName = "@Qta", Value = qta }
            , new SqlParameter() { ParameterName = "@Imp", Value = imp }, new SqlParameter() { ParameterName = "@OrdNum", Value = Request.QueryString["OrdNum"] }
            , new SqlParameter() { ParameterName = "@Flag", Value = flagEvaso });
        }

        protected void Ord_Dett_Contratto_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int id = Convert.ToInt32(e.NewValues["ID"]);
            int qtaOrd = Convert.ToInt32(e.NewValues["QtaOrd"]);
            int qtaEva = Convert.ToInt32(e.NewValues["QtaEva"]);
            int daFatturare = Convert.ToInt32(e.NewValues["U_DaFatturare"]);
            string codArt = Convert.ToString(e.NewValues["CodArt"]);

            if (daFatturare == 1)
            {
                SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT PVendPub FROM Articoli WHERE CodArt = @CodArt", new SqlParameter { ParameterName = "@CodArt", Value = e.NewValues["CodArt"] });
                if (reader.Read())
                {
                    decimal prezzo = Convert.ToDecimal(reader["PVendPub"]);
                    _ = new Sql4Gestionale().ExecuteNonQuery("UPDATE U_I_OrdCliDett SET Importo = QtaOrd * @Prezzo, Prezzo = @Prezzo WHERE ID = @ID", new SqlParameter { ParameterName = "@Prezzo", Value = prezzo }
                    , new SqlParameter { ParameterName = "@ID", Value = id });
                }
                reader.Close();
            }
            int flagEvaso = qtaEva == 0 ? 1 :
                qtaOrd <= qtaEva ? 3 : 2;

            _ = new Sql4Gestionale().ExecuteNonQuery(
                "UPDATE U_I_OrdCliDett SET FlagEvaso = @Flag WHERE ID = @ID",
                new SqlParameter("@Flag", flagEvaso),
                new SqlParameter("@ID", id)
            );
        }

        protected void Ord_Dett_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int ID = Convert.ToInt32(e.NewValues["ID"]);
            if (Convert.ToInt32(e.NewValues["U_DaFatturare"]) == 0)
            {
                decimal prezzo = Convert.ToDecimal(0);
                new Sql4Gestionale().ExecuteNonQuery("UPDATE U_I_OrdCliDett SET Importo = @Prezzo, Prezzo = @Prezzo WHERE ID = @ID", new SqlParameter { ParameterName = "@Prezzo", Value = prezzo },
                    new SqlParameter { ParameterName = "@ID", Value = ID });
            }
            if (Convert.ToInt32(e.NewValues["QtaOrd"]) <= Convert.ToInt32(e.NewValues["QtaEva"]))
            {
                new Sql4Gestionale().ExecuteNonQuery("UPDATE U_I_OrdCliDett SET FlagEvaso = 3 WHERE ID = @ID", new SqlParameter { ParameterName = "@ID", Value = ID });
            }
        }

        protected void Evadi_Callback_Callback(object source, CallbackEventArgs e)
        {
            Evadi_Callback.JSProperties["cpError"] = false;

            string[] Params = e.Parameter.Split('|');
            if (Params.Length < 3)
            {
                Evadi_Callback.JSProperties["cpError"] = true;
                return;
            }

            string grid = Params[0];
            int index = Convert.ToInt32(Params[1]);
            int qta = Convert.ToInt32(Params[2]);

            ASPxGridView gridView = null;
            switch (grid)
            {
                case "Ord_Dett_Contratto":
                    gridView = Ord_Dett_Contratto;
                    break;
                case "Ord_Dett_Gridview":
                    gridView = Ord_Dett_Gridview;
                    break;
                default:
                    gridView = null;
                    break;
            }

            if (gridView != null)
            {
                int qtaOrd = Convert.ToInt32(gridView.GetRowValues(index, "QtaOrd"));
                int qtaEva = Convert.ToInt32(gridView.GetRowValues(index, "QtaEva"));
                int id = Convert.ToInt32(gridView.GetRowValues(index, "ID"));

                if (qtaOrd - qtaEva >= qta)
                {
                    new Sql4Gestionale().ExecuteNonQuery(
                        "UPDATE U_I_OrdCliDett SET U_DaEvadere = @Qta WHERE ID = @ID",
                        new SqlParameter("@Qta", qta),
                        new SqlParameter("@ID", id)
                    );
                }
                else
                {
                    Evadi_Callback.JSProperties["cpError"] = true;
                }
            }
            else
            {
                Evadi_Callback.JSProperties["cpError"] = true;
            }
        }

        protected void Ord_Dett_Gridview_CustomButtonInitialize(object sender, ASPxGridViewCustomButtonEventArgs e)
        {
            if (e.ButtonID == "EvadiParzialeFatt")
            {
                int qtaOrd = Convert.ToInt32(Ord_Dett_Gridview.GetRowValues(e.VisibleIndex, "QtaOrd"));
                int qtaEva = Convert.ToInt32(Ord_Dett_Gridview.GetRowValues(e.VisibleIndex, "QtaEva"));
                if (qtaEva >= qtaOrd)
                {
                    e.Visible = DevExpress.Utils.DefaultBoolean.False;
                }
            }
        }

        protected void Ord_Dett_Contratto_CustomButtonInitialize(object sender, ASPxGridViewCustomButtonEventArgs e)
        {
            if (e.ButtonID == "EvadiParziale")
            {
                int qtaOrd = Convert.ToInt32(Ord_Dett_Contratto.GetRowValues(e.VisibleIndex, "QtaOrd"));
                int qtaEva = Convert.ToInt32(Ord_Dett_Contratto.GetRowValues(e.VisibleIndex, "QtaEva"));
                if (qtaEva >= qtaOrd)
                {
                    e.Visible = DevExpress.Utils.DefaultBoolean.False;
                }
            }
        }

        protected void QtaDaEvadere_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            string[] Params = e.Parameter.Split('|');
            QtaDaEvadere_Spin.Value = 1;
            QtaDaEvadere_Spin.MinValue = 1;

            if (Params[0] == "0" && Params.Length > 2 && int.TryParse(Params[2], out int keyContratto))
            {
                int qtaOrd = Convert.ToInt32(Ord_Dett_Contratto.GetRowValuesByKeyValue(keyContratto, "QtaOrd"));
                int qtaEva = Convert.ToInt32(Ord_Dett_Contratto.GetRowValuesByKeyValue(keyContratto, "QtaEva"));
                QtaDaEvadere_Spin.MaxValue = qtaOrd - qtaEva;
            }
            else if (Params[0] == "1" && Params.Length > 1 && int.TryParse(Params[1], out int keyFatt))
            {
                int qtaOrd = Convert.ToInt32(Ord_Dett_Gridview.GetRowValuesByKeyValue(keyFatt, "QtaOrd"));
                int qtaEva = Convert.ToInt32(Ord_Dett_Gridview.GetRowValuesByKeyValue(keyFatt, "QtaEva"));
                QtaDaEvadere_Spin.MaxValue = qtaOrd - qtaEva;
            }
        }
    }
}