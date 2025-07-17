using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;
using System.Xml;

namespace INTRA.SuperAdmin
{
    public partial class VersioneIntranet_Tbl_CRUD : System.Web.UI.Page
    {
        //SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationTable"].ConnectionString.ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                binddetailview();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable("APP_Versioni");
            if (Button1.Text == "Update")
            {
                int datakeys = Convert.ToInt32(DetailsView1.DataKey["Id"].ToString());
                int lblid = Convert.ToInt32(ViewState["LblId"].ToString());
                XmlDocument xmldoc = new XmlDocument();
                xmldoc.Load(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"));
                XmlNodeList nodes = xmldoc.SelectNodes("NewDataSet/APP_Versioni[Id=" + lblid + "]");
                foreach (XmlNode node in nodes)
                {
                    XmlNodeList childnodes = node.ChildNodes;
                    foreach (XmlNode childnode in childnodes)
                    {
                        switch (childnode.Name)
                        {
                            case "TitVers":
                                childnode.InnerText = TextBox1.Text;
                                break;
                            case "NewFeatures":
                                childnode.InnerText = TextBox2.Text;
                                break;
                            case "BugFix":
                                childnode.InnerText = TextBox3.Text;
                                break;
                            case "NumeroLic":
                                childnode.InnerText = TextBox4.Text;
                                break;
                        }
                    }
                    childnodes = null;
                    break;
                }
                xmldoc.Save(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"));
                DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
                DetailsView1.DefaultMode = DetailsViewMode.ReadOnly;
                binddetailview();
                // here Write Remaining Code from XMLGENERATE FILE
            }
            else
            {
                if (File.Exists(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml")))
                {
                    XmlDocument xdoc = new XmlDocument();
                    xdoc.Load(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"));
                    XmlTextReader xreader = new XmlTextReader(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"));
                    ds.ReadXml(xreader);
                    DataTable dt1 = new DataTable();
                    DataTableReader dtreader = new DataTableReader(ds.Tables["APP_Versioni"]);
                    dt1.Load(dtreader);
                    DataRow dtr = dt1.NewRow();
                    dtr["TitVers"] = TextBox1.Text;
                    dtr["NewFeatures"] = TextBox2.Text;
                    dtr["BugFix"] = TextBox3.Text;
                    dtr["NumeroLic"] = TextBox4.Text;
                    dt1.Rows.Add(dtr);
                    xreader.Close();
                    dt1.AcceptChanges();
                    dt1.WriteXml(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"), XmlWriteMode.WriteSchema);
                }
                else
                {
                    DataColumn dtc = new DataColumn("Id", typeof(System.Int32));
                    DataColumn dtc1 = new DataColumn("TitVers", typeof(System.String));
                    DataColumn dtc2 = new DataColumn("NewFeatures", typeof(System.String));
                    DataColumn dtc3 = new DataColumn("BugFix", typeof(System.String));
                    DataColumn dtc4 = new DataColumn("NumeroLic", typeof(System.String));
                    DataColumn dtc5 = new DataColumn("RagSoc", typeof(System.String));
                    dtc.AutoIncrement = true;
                    dtc.AutoIncrementSeed = 1;
                    dtc.AutoIncrementStep = 1;
                    dtc.ReadOnly = true;
                    dt.Columns.Add(dtc);
                    dt.Columns.Add(dtc1);
                    dt.Columns.Add(dtc2);
                    dt.Columns.Add(dtc3);
                    dt.Columns.Add(dtc4);
                    dt.Columns.Add(dtc5);
                    DataRow dtr = dt.NewRow();
                    dtr["TitVers"] = TextBox1.Text;
                    dtr["NewFeatures"] = TextBox2.Text;
                    dtr["BugFix"] = TextBox3.Text;
                    dtr["NumeroLic"] = TextBox4.Text;
                    dtr["RagSoc"] = TextBox5.Text;

                    dt.Rows.Add(dtr);
                    ds.Tables.Add(dt);
                    dt.WriteXml(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"), XmlWriteMode.WriteSchema);
                }
            }
            binddetailview();
        }
        protected void binddetailview()
        {
            if (File.Exists(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml")))
            {
                XmlDocument xdoc = new XmlDocument();
                xdoc.Load(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"));
                XmlTextReader xreader = new XmlTextReader(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"));
                DataTable ds = new DataTable();
                ds.ReadXml(xreader);
                xreader.Close();
                DetailsView1.DataSource = ds;
                DetailsView1.DataBind();
            }
            if (DetailsView1.DefaultMode != DetailsViewMode.Edit)
            {
                TextBox1.Text = string.Empty;
                TextBox2.Text = string.Empty;
                TextBox3.Text = string.Empty;
                TextBox4.Text = string.Empty;
                TextBox5.Text = string.Empty;
                Button1.Text = "Insert";
                Button1.Enabled = false;
            }
        }
        protected void DetailsView1_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
        {
            DetailsView1.PageIndex = e.NewPageIndex;
            binddetailview();
        }
        protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                Label lblId = (Label)DetailsView1.FindControl("Label2");
                Label lblname = (Label)DetailsView1.FindControl("Label3");
                Label lbladdress = (Label)DetailsView1.FindControl("Label4");
                Label lblemail = (Label)DetailsView1.FindControl("Label5");
                Label lblNumeroLic = (Label)DetailsView1.FindControl("Label6");
                Label lblRagSoc = (Label)DetailsView1.FindControl("Label7");
                TextBox1.Text = lblname.Text;
                TextBox2.Text = lbladdress.Text;
                TextBox3.Text = lblemail.Text;
                TextBox4.Text = lblNumeroLic.Text;
                TextBox5.Text = lblRagSoc.Text;
                Button1.Text = "Update";
                Button1.Enabled = true;
                ViewState["LblId"] = lblId.Text.ToString();
            }
        }
        protected void DetailsView1_ItemDeleting(object sender, DetailsViewDeleteEventArgs e)
        {
            DataSet ds = new DataSet();
            ds.ReadXml(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"));
            ds.Tables["APP_Versioni"].Rows.RemoveAt(e.RowIndex);
            DataTable dt = ds.Tables["APP_Versioni"];
            dt.WriteXml(Server.MapPath("/App_Data/VersioneIntranet_2023_Tbl.xml"), XmlWriteMode.WriteSchema);
            binddetailview();
        }
        protected void DetailsView1_PageIndexChanging1(object sender, DetailsViewPageEventArgs e)
        {
            DetailsView1.PageIndex = e.NewPageIndex;
            binddetailview();
        }
        protected void DetailsView1_ModeChanging(object sender, DetailsViewModeEventArgs e)
        {
            if (e.NewMode == DetailsViewMode.Edit)
            {
                DetailsView1.ChangeMode(DetailsViewMode.Edit);
                DetailsView1.DefaultMode = (DetailsViewMode.Edit);
                binddetailview();
            }
        }
        protected void Button5_Click(object sender, EventArgs e)
        {
            DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
            DetailsView1.DefaultMode = DetailsViewMode.ReadOnly;
            binddetailview();
        }
    }
}