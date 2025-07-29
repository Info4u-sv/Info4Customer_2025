using DevExpress.XtraReports.UI;

/// <summary>
/// Summary description for Contratto_Riepilogo_Det_Rpt
/// </summary>
public class Contratto_Riepilogo_Det_Rpt : DevExpress.XtraReports.UI.XtraReport
{
    private TopMarginBand TopMargin;
    private BottomMarginBand BottomMargin;
    private DetailBand Detail;
    private XRTable xrTable1;
    private XRTableRow xrTableRow1;
    private XRTableCell xrTableCell1;
    private XRTableCell xrTableCell2;
    private XRTableCell xrTableCell3;
    private XRTableCell xrTableCell4;
    private DevExpress.DataAccess.Sql.SqlDataSource sqlDataSource1;
    private XRTable xrTable2;
    private XRTableRow xrTableRow2;
    private XRTableCell xrTableCell5;
    private XRTableCell xrTableCell6;
    private XRTableCell xrTableCell7;
    private XRTableCell xrTableCell8;
    private DevExpress.XtraReports.Parameters.Parameter CodCliPar;
    private DevExpress.XtraReports.Parameters.Parameter IdContrattoPar;
    private ReportHeaderBand ReportHeader;
    private XRTableCell xrTableCell9;
    private XRTableCell xrTableCell10;

    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    public Contratto_Riepilogo_Det_Rpt()
    {
        InitializeComponent();
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary> 
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
        if (disposing && (components != null))
        {
            components.Dispose();
        }
        base.Dispose(disposing);
    }

    #region Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        string resourceFileName = "Contratto_Riepilogo_Det_Rpt.resx";
        System.Resources.ResourceManager resources = global::Resources.Contratto_Riepilogo_Det_Rpt.ResourceManager;
        this.components = new System.ComponentModel.Container();
        DevExpress.DataAccess.Sql.CustomSqlQuery customSqlQuery1 = new DevExpress.DataAccess.Sql.CustomSqlQuery();
        DevExpress.DataAccess.Sql.QueryParameter queryParameter1 = new DevExpress.DataAccess.Sql.QueryParameter();
        DevExpress.DataAccess.Sql.QueryParameter queryParameter2 = new DevExpress.DataAccess.Sql.QueryParameter();
        this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
        this.xrTable2 = new DevExpress.XtraReports.UI.XRTable();
        this.xrTableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
        this.xrTableCell5 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell6 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell7 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell8 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell9 = new DevExpress.XtraReports.UI.XRTableCell();
        this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
        this.Detail = new DevExpress.XtraReports.UI.DetailBand();
        this.xrTable1 = new DevExpress.XtraReports.UI.XRTable();
        this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
        this.xrTableCell1 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell2 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell3 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell4 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell10 = new DevExpress.XtraReports.UI.XRTableCell();
        this.sqlDataSource1 = new DevExpress.DataAccess.Sql.SqlDataSource(this.components);
        this.CodCliPar = new DevExpress.XtraReports.Parameters.Parameter();
        this.IdContrattoPar = new DevExpress.XtraReports.Parameters.Parameter();
        this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
        ((System.ComponentModel.ISupportInitialize)(this.xrTable2)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
        // 
        // TopMargin
        // 
        this.TopMargin.HeightF = 0F;
        this.TopMargin.Name = "TopMargin";
        // 
        // xrTable2
        // 
        this.xrTable2.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold);
        this.xrTable2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
        this.xrTable2.Name = "xrTable2";
        this.xrTable2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96F);
        this.xrTable2.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow2});
        this.xrTable2.SizeF = new System.Drawing.SizeF(1066.472F, 25F);
        this.xrTable2.StylePriority.UseFont = false;
        // 
        // xrTableRow2
        // 
        this.xrTableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell5,
            this.xrTableCell6,
            this.xrTableCell7,
            this.xrTableCell8,
            this.xrTableCell9});
        this.xrTableRow2.Name = "xrTableRow2";
        this.xrTableRow2.Weight = 1D;
        // 
        // xrTableCell5
        // 
        this.xrTableCell5.Multiline = true;
        this.xrTableCell5.Name = "xrTableCell5";
        this.xrTableCell5.Text = "DATA";
        this.xrTableCell5.Weight = 1D;
        // 
        // xrTableCell6
        // 
        this.xrTableCell6.Multiline = true;
        this.xrTableCell6.Name = "xrTableCell6";
        this.xrTableCell6.Text = "Cod. Intervento";
        this.xrTableCell6.Weight = 1D;
        // 
        // xrTableCell7
        // 
        this.xrTableCell7.Multiline = true;
        this.xrTableCell7.Name = "xrTableCell7";
        this.xrTableCell7.Text = "Lavoro Eseguito";
        this.xrTableCell7.Weight = 7.1388898326659058D;
        // 
        // xrTableCell8
        // 
        this.xrTableCell8.Multiline = true;
        this.xrTableCell8.Name = "xrTableCell8";
        this.xrTableCell8.Text = "Q.tà";
        this.xrTableCell8.Weight = 0.82657455315853134D;
        // 
        // xrTableCell9
        // 
        this.xrTableCell9.Multiline = true;
        this.xrTableCell9.Name = "xrTableCell9";
        this.xrTableCell9.Text = "UM";
        this.xrTableCell9.Weight = 0.69925850719186977D;
        // 
        // BottomMargin
        // 
        this.BottomMargin.HeightF = 0F;
        this.BottomMargin.Name = "BottomMargin";
        // 
        // Detail
        // 
        this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTable1});
        this.Detail.HeightF = 25F;
        this.Detail.Name = "Detail";
        // 
        // xrTable1
        // 
        this.xrTable1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
        this.xrTable1.Name = "xrTable1";
        this.xrTable1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 96F);
        this.xrTable1.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow1});
        this.xrTable1.SizeF = new System.Drawing.SizeF(1066.472F, 25F);
        // 
        // xrTableRow1
        // 
        this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell1,
            this.xrTableCell2,
            this.xrTableCell3,
            this.xrTableCell4,
            this.xrTableCell10});
        this.xrTableRow1.Name = "xrTableRow1";
        this.xrTableRow1.Weight = 1D;
        // 
        // xrTableCell1
        // 
        this.xrTableCell1.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[DataIntervento]")});
        this.xrTableCell1.Multiline = true;
        this.xrTableCell1.Name = "xrTableCell1";
        this.xrTableCell1.Text = "xrTableCell1";
        this.xrTableCell1.TextFormatString = "{0:dd/MM/yyyy}";
        this.xrTableCell1.Weight = 1D;
        // 
        // xrTableCell2
        // 
        this.xrTableCell2.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[CodRapportino]")});
        this.xrTableCell2.Multiline = true;
        this.xrTableCell2.Name = "xrTableCell2";
        this.xrTableCell2.Text = "xrTableCell2";
        this.xrTableCell2.Weight = 1D;
        // 
        // xrTableCell3
        // 
        this.xrTableCell3.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[LavoroEseguito]")});
        this.xrTableCell3.Multiline = true;
        this.xrTableCell3.Name = "xrTableCell3";
        this.xrTableCell3.Text = "xrTableCell3";
        this.xrTableCell3.Weight = 7.1388898326659058D;
        // 
        // xrTableCell4
        // 
        this.xrTableCell4.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[TempoInterventoTotale]")});
        this.xrTableCell4.Multiline = true;
        this.xrTableCell4.Name = "xrTableCell4";
        this.xrTableCell4.Text = "xrTableCell4";
        this.xrTableCell4.Weight = 0.82657455315853134D;
        // 
        // xrTableCell10
        // 
        this.xrTableCell10.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[UM]")});
        this.xrTableCell10.Multiline = true;
        this.xrTableCell10.Name = "xrTableCell10";
        this.xrTableCell10.Weight = 0.69925850719186977D;
        // 
        // sqlDataSource1
        // 
        this.sqlDataSource1.ConnectionName = "info4portaleConnectionString";
        this.sqlDataSource1.Name = "sqlDataSource1";
        customSqlQuery1.Name = "Query";
        queryParameter1.Name = "CodCliPar";
        queryParameter1.Type = typeof(DevExpress.DataAccess.Expression);
        queryParameter1.Value = new DevExpress.DataAccess.Expression("?CodCliPar", typeof(string));
        queryParameter2.Name = "IdContrattoPar";
        queryParameter2.Type = typeof(DevExpress.DataAccess.Expression);
        queryParameter2.Value = new DevExpress.DataAccess.Expression("?IdContrattoPar", typeof(string));
        customSqlQuery1.Parameters.Add(queryParameter1);
        customSqlQuery1.Parameters.Add(queryParameter2);
        customSqlQuery1.Sql = resources.GetString("customSqlQuery1.Sql");
        this.sqlDataSource1.Queries.AddRange(new DevExpress.DataAccess.Sql.SqlQuery[] {
            customSqlQuery1});
        this.sqlDataSource1.ResultSchemaSerializable = resources.GetString("sqlDataSource1.ResultSchemaSerializable");
        // 
        // CodCliPar
        // 
        this.CodCliPar.Description = "CodCliPar";
        this.CodCliPar.Name = "CodCliPar";
        // 
        // IdContrattoPar
        // 
        this.IdContrattoPar.Description = "IdContrattoPar";
        this.IdContrattoPar.Name = "IdContrattoPar";
        // 
        // ReportHeader
        // 
        this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTable2});
        this.ReportHeader.HeightF = 25F;
        this.ReportHeader.Name = "ReportHeader";
        // 
        // Contratto_Riepilogo_Det_Rpt
        // 
        this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.TopMargin,
            this.BottomMargin,
            this.Detail,
            this.ReportHeader});
        this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.sqlDataSource1});
        this.DataMember = "Query";
        this.DataSource = this.sqlDataSource1;
        this.Font = new System.Drawing.Font("Arial", 9.75F);
        this.Landscape = true;
        this.Margins = new System.Drawing.Printing.Margins(0, 0, 0, 0);
        this.PageHeight = 1276;
        this.PageWidth = 1169;
        this.PaperKind = (DevExpress.Drawing.Printing.DXPaperKind)System.Drawing.Printing.PaperKind.Custom;
        this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.CodCliPar,
            this.IdContrattoPar});
        this.Version = "19.2";
        ((System.ComponentModel.ISupportInitialize)(this.xrTable2)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

    }

    #endregion
}
