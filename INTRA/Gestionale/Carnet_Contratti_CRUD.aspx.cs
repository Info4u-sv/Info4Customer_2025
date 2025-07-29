using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA.Gestionale
{
    public partial class Carnet_Contratti_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Generic_Gridview.FilterExpression = String.Empty;
                GridViewColumn U_CC = Generic_Gridview.Columns["U_CC"];
                Generic_Gridview.AutoFilterByColumn(U_CC, "false");
            }
        }
        protected void AggiungiSerivizio_Callback_Callback(object source, CallbackEventArgs e)
        {
            Servizi_Crud.InsertParameters["DataCar"].DefaultValue = DataCoperturaCarnet_Date.Date.ToShortDateString();
            Servizi_Crud.InsertParameters["CodCliente"].DefaultValue = Cliente_Combobox.SelectedItem.Value.ToString();
            Servizi_Crud.InsertParameters["U_TotOreContratto"].DefaultValue = Ore_SpinEdit.Number.ToString();

            string Ore = "";

            if (Ore_SpinEdit.Number.ToString().Length < 3)
            {
                Ore = "0" + Ore_SpinEdit.Number.ToString();
            }
            else
            {
                Ore = Ore_SpinEdit.Number.ToString();
            }

            Servizi_Crud.InsertParameters["U_Tipo_Assistenza"].DefaultValue = Tipologia_Combobox.SelectedItem.Value.ToString();

            Servizi_Crud.InsertParameters["IdProdotto"].DefaultValue = SiglaServizio(Tipologia_Combobox.SelectedItem.Text.ToString()) + Ore + "-" + DataCoperturaCarnet_Date.Date.ToString("yyyy/MM/dd");
            Servizi_Crud.Insert();
        }
        public string SiglaServizio(string Servizio)
        {
            string Sigla = Servizio.Substring(0, 3).ToUpper();


            return Sigla;
        }

        protected void DataCoperturaCarnet_Date_Init(object sender, EventArgs e)
        {
            DataCoperturaCarnet_Date.Date = DateTime.Now;
        }
    }
}