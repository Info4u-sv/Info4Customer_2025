using Info4U.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Depositi
{
    public partial class Inventario_Crud : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = @"SELECT        Clienti.Denom, U_I_Ind, U_I_Prov, U_I_Loc, U_I_Cap, Descrizione
                                FROM            TabDep INNER JOIN
                                Clienti ON TabDep.CodCli = Clienti.CodCli
                                WHERE CodDep = '" + Request.QueryString["CodDep"] + "'";
                SqlDataReader reader = new Sql4Gestionale().ExecuteReader(query);
                if (reader.Read())
                {
                    string indirizzo = string.Format("{0} {1} {2} {3}", reader["U_I_Ind"], reader["U_I_Prov"], reader["U_I_Loc"], reader["U_I_Cap"]);
                    Dep_lbl.Text = "DEPOSITO: " + Request.QueryString["CodDep"] + " " + reader["Descrizione"];
                    Ind_lbl.Text = "INDIRIZZO DEPOSITO: " + indirizzo;
                    Cliente_lbl.Text = "SOCIETÀ: " + reader["Denom"] as string;

                }
            }
        }

        protected void Insert_CallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            Articoli_Gridview.AutoFilterByColumn(Articoli_Gridview.Columns["Categoria"], "");
            string s = Categoria_Cmb.Value as string;
            string query = @"SELECT Descrizione FROM TabCatM WHERE CodCat = @CodCat";
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader(query, new SqlParameter { ParameterName = "@CodCat", Value = s });
            if (reader.Read())
            {
                Articoli_Gridview.AutoFilterByColumn(Articoli_Gridview.Columns["Categoria"], reader["Descrizione"] as string);
            }
        }

        protected void Insert_Edit_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string codArt = e.Parameter as string;
            int qta = Convert.ToInt32(Qta_Spin.Value);
            string _DaFatturare = string.Empty;
            _DaFatturare = DaFatturare_rBList.SelectedItem.Value.ToString();
            Sql4Gestionale objSqlHelper = new Sql4Gestionale();
            SqlParameter[] objParams = new SqlParameter[4];
            objParams[0] = new SqlParameter("@CodArt", codArt);
            objParams[1] = new SqlParameter("@Qta", qta);

            objParams[2] = new SqlParameter("@CodDep", Request.QueryString["CodDep"]);
            objParams[3] = new SqlParameter("@DaFatturare", _DaFatturare);

            objSqlHelper.ExecuteNonQuery("U_Insert_Edit_Inventario", objParams);
        }
    }
}