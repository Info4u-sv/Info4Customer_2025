using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Bolle
{
    public partial class DettaglioBolla : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int IdTestata = (!string.IsNullOrEmpty(Request.QueryString["IdTestata"])) ? Convert.ToInt32(Request.QueryString["IdTestata"]) : 0;
            if (IdTestata != 0)
            {
                if (!IsPostBack)
                {
                    string sql = $"SELECT BolleTest.NumDoc, Clienti.Denom as Cliente FROM BolleTest LEFT OUTER JOIN Clienti ON BolleTest.Cliente = Clienti.CodCli WHERE Id = {IdTestata}";
                    Sql4Gestionale helper = new Sql4Gestionale();
                    SqlDataReader reader = helper.ExecuteReader(sql);
                    if (reader.Read())
                    {
                        TitoloPagina_Lbl.Text = $"Bolla N° <strong style='Color:#0055A6'>{reader["NumDoc"]}</strong> Cliente: <strong style='Color:#0055A6'>{reader["Cliente"]}</strong>";
                    }
                    reader.Close();
                    sql = $"SELECT BolleTest.ID, ISNULL(BolleTest.TotDocum,0) AS TotDocum, U_I_OrdCliTest.U_NumBollaCliente, U_I_OrdCliTest.U_NumBolla, BolleTest.NumDoc FROM BolleTest INNER JOIN U_I_OrdCliTest ON BolleTest.NumDoc = U_I_OrdCliTest.U_NumBollaCliente OR BolleTest.NumDoc = U_I_OrdCliTest.U_NumBolla WHERE (BolleTest.ID = {IdTestata})";
                    reader = helper.ExecuteReader(sql);
                    if (reader.Read())
                    {
                        string tipo = reader["U_NumBolla"] as string == reader["NumDoc"] as string ? "Da Contratto" : reader["U_NumBollaCliente"] as string == reader["NumDoc"] as string ? "Da Fatturare" : "";
                        if (Tipo_Lbl != null)
                        {
                            Tipo_Lbl.Text = $"Tipologia bolla: {tipo}";
                            if (tipo == "") Tipo_Lbl.ClientVisible = false;
                        }
                        if (TotIva != null)
                        {
                            TotIva.Text = $"Totale con IVA: {Convert.ToDecimal(reader["TotDocum"]).ToString("C2", CultureInfo.CreateSpecificCulture("it-IT"))}";
                            if (Convert.ToDecimal(reader["TotDocum"]) == 0) TotIva.ClientVisible = false;
                        }
                    }
                }
            }
        }
    }
}