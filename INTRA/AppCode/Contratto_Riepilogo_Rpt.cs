using DevExpress.XtraReports.UI;

/// <summary>
/// Summary description for Contratto_Riepilogo_Rpt
/// </summary>
public class Contratto_Riepilogo_Rpt : DevExpress.XtraReports.UI.XtraReport
{
    private TopMarginBand TopMargin;
    private BottomMarginBand BottomMargin;
    private DetailBand Detail;
    private DevExpress.DataAccess.Sql.SqlDataSource sqlDataSource1;
    private XRSubreport xrSubreport1;
    private DevExpress.XtraReports.Parameters.Parameter CodCliParam;
    private DevExpress.XtraReports.Parameters.Parameter IDcontrattoParam;
    private DevExpress.XtraReports.Parameters.Parameter FromParam;
    private DevExpress.XtraReports.Parameters.Parameter ToParam;
    private PageHeaderBand PageHeader;
    private XRLabel xrLabel1;
    private XRLabel xrLabel2;
    private XRLabel xrLabel3;
    private XRLabel xrLabel4;
    private XRLabel xrLabel5;
    private XRLabel xrLabel6;
    private XRLabel xrLabel7;
    private XRLabel xrLabel8;
    private XRLabel xrLabel9;
    private XRLabel xrLabel10;
    private XRLabel xrLabel11;
    private XRLine xrLine1;
    private XRLine xrLine2;
    private XRLabel xrLabel12;
    private XRLabel xrLabel13;

    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    public Contratto_Riepilogo_Rpt()
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
        string resourceFileName = "Contratto_Riepilogo_Rpt.resx";
        System.Resources.ResourceManager resources = global::Resources.Contratto_Riepilogo_Rpt.ResourceManager;
        this.components = new System.ComponentModel.Container();
        DevExpress.DataAccess.Sql.CustomSqlQuery customSqlQuery1 = new DevExpress.DataAccess.Sql.CustomSqlQuery();
        DevExpress.DataAccess.Sql.QueryParameter queryParameter1 = new DevExpress.DataAccess.Sql.QueryParameter();
        DevExpress.DataAccess.Sql.QueryParameter queryParameter2 = new DevExpress.DataAccess.Sql.QueryParameter();
        this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
        this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
        this.Detail = new DevExpress.XtraReports.UI.DetailBand();
        this.xrSubreport1 = new DevExpress.XtraReports.UI.XRSubreport();
        this.CodCliParam = new DevExpress.XtraReports.Parameters.Parameter();
        this.IDcontrattoParam = new DevExpress.XtraReports.Parameters.Parameter();
        this.FromParam = new DevExpress.XtraReports.Parameters.Parameter();
        this.ToParam = new DevExpress.XtraReports.Parameters.Parameter();
        this.sqlDataSource1 = new DevExpress.DataAccess.Sql.SqlDataSource(this.components);
        this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
        this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel6 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel7 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel8 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel9 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel10 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel11 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLine1 = new DevExpress.XtraReports.UI.XRLine();
        this.xrLine2 = new DevExpress.XtraReports.UI.XRLine();
        this.xrLabel12 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel13 = new DevExpress.XtraReports.UI.XRLabel();
        ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
        // 
        // TopMargin
        // 
        this.TopMargin.HeightF = 23.95833F;
        this.TopMargin.Name = "TopMargin";
        // 
        // BottomMargin
        // 
        this.BottomMargin.HeightF = 16.0834F;
        this.BottomMargin.Name = "BottomMargin";
        // 
        // Detail
        // 
        this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrSubreport1});
        this.Detail.HeightF = 23F;
        this.Detail.Name = "Detail";
        // 
        // xrSubreport1
        // 
        this.xrSubreport1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
        this.xrSubreport1.Name = "xrSubreport1";
        this.xrSubreport1.ParameterBindings.Add(new DevExpress.XtraReports.UI.ParameterBinding("CodCliPar", this.CodCliParam));
        this.xrSubreport1.ParameterBindings.Add(new DevExpress.XtraReports.UI.ParameterBinding("IdContrattoPar", this.IDcontrattoParam));
        this.xrSubreport1.ReportSource = new Contratto_Riepilogo_Det_Rpt();
        this.xrSubreport1.SizeF = new System.Drawing.SizeF(100F, 23F);
        // 
        // CodCliParam
        // 
        this.CodCliParam.Description = "CodCliParam";
        this.CodCliParam.Name = "CodCliParam";
        this.CodCliParam.ValueInfo = "0";
        this.CodCliParam.Visible = false;
        // 
        // IDcontrattoParam
        // 
        this.IDcontrattoParam.Description = "IDcontrattoParam";
        this.IDcontrattoParam.Name = "IDcontrattoParam";
        this.IDcontrattoParam.Visible = false;
        // 
        // FromParam
        // 
        this.FromParam.Description = "FromParam";
        this.FromParam.Name = "FromParam";
        this.FromParam.ValueInfo = "18/01/2021";
        this.FromParam.Visible = false;
        // 
        // ToParam
        // 
        this.ToParam.Description = "ToParam";
        this.ToParam.Name = "ToParam";
        this.ToParam.ValueInfo = "18/01/2021";
        this.ToParam.Visible = false;
        // 
        // sqlDataSource1
        // 
        this.sqlDataSource1.ConnectionName = "GestionaleConnectionString";
        this.sqlDataSource1.Name = "sqlDataSource1";
        customSqlQuery1.Name = "U_Carnet_Contratti_View_Intra";
        queryParameter1.Name = "IDcontrattoParam";
        queryParameter1.Type = typeof(DevExpress.DataAccess.Expression);
        queryParameter1.Value = new DevExpress.DataAccess.Expression("?IDcontrattoParam", typeof(string));
        queryParameter2.Name = "CodCliParam";
        queryParameter2.Type = typeof(DevExpress.DataAccess.Expression);
        queryParameter2.Value = new DevExpress.DataAccess.Expression("?CodCliParam", typeof(string));
        customSqlQuery1.Parameters.Add(queryParameter1);
        customSqlQuery1.Parameters.Add(queryParameter2);
        customSqlQuery1.Sql = resources.GetString("customSqlQuery1.Sql");
        this.sqlDataSource1.Queries.AddRange(new DevExpress.DataAccess.Sql.SqlQuery[] {
            customSqlQuery1});
        this.sqlDataSource1.ResultSchemaSerializable = resources.GetString("sqlDataSource1.ResultSchemaSerializable");
        // 
        // PageHeader
        // 
        this.PageHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel1,
            this.xrLabel2,
            this.xrLabel3,
            this.xrLabel4,
            this.xrLabel5,
            this.xrLabel6,
            this.xrLabel7,
            this.xrLabel8,
            this.xrLabel9,
            this.xrLabel10,
            this.xrLabel11,
            this.xrLine1,
            this.xrLine2,
            this.xrLabel12,
            this.xrLabel13});
        this.PageHeader.HeightF = 134.8333F;
        this.PageHeader.Name = "PageHeader";
        // 
        // xrLabel1
        // 
        this.xrLabel1.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[IdProdotto]")});
        this.xrLabel1.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(143.3336F, 0F);
        this.xrLabel1.Multiline = true;
        this.xrLabel1.Name = "xrLabel1";
        this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel1.SizeF = new System.Drawing.SizeF(233.3333F, 23F);
        this.xrLabel1.StylePriority.UseFont = false;
        this.xrLabel1.Text = "xrLabel1";
        // 
        // xrLabel2
        // 
        this.xrLabel2.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Totale]")});
        this.xrLabel2.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(115.625F, 37.08334F);
        this.xrLabel2.Multiline = true;
        this.xrLabel2.Name = "xrLabel2";
        this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel2.SizeF = new System.Drawing.SizeF(100F, 23F);
        this.xrLabel2.StylePriority.UseFont = false;
        this.xrLabel2.Text = "xrLabel2";
        this.xrLabel2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
        // 
        // xrLabel3
        // 
        this.xrLabel3.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
        this.xrLabel3.Multiline = true;
        this.xrLabel3.Name = "xrLabel3";
        this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel3.SizeF = new System.Drawing.SizeF(133.3333F, 23F);
        this.xrLabel3.StylePriority.UseFont = false;
        this.xrLabel3.StylePriority.UseTextAlignment = false;
        this.xrLabel3.Text = "Cod Contratto:";
        this.xrLabel3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
        // 
        // xrLabel4
        // 
        this.xrLabel4.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(386.667F, 0F);
        this.xrLabel4.Multiline = true;
        this.xrLabel4.Name = "xrLabel4";
        this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel4.SizeF = new System.Drawing.SizeF(100F, 23F);
        this.xrLabel4.StylePriority.UseFont = false;
        this.xrLabel4.Text = "Del:";
        // 
        // xrLabel5
        // 
        this.xrLabel5.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[DataCar]")});
        this.xrLabel5.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(500.6252F, 0F);
        this.xrLabel5.Multiline = true;
        this.xrLabel5.Name = "xrLabel5";
        this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel5.SizeF = new System.Drawing.SizeF(100F, 23F);
        this.xrLabel5.StylePriority.UseFont = false;
        this.xrLabel5.Text = "xrLabel5";
        this.xrLabel5.TextFormatString = "{0:d}";
        // 
        // xrLabel6
        // 
        this.xrLabel6.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel6.LocationFloat = new DevExpress.Utils.PointFloat(0F, 37.08334F);
        this.xrLabel6.Multiline = true;
        this.xrLabel6.Name = "xrLabel6";
        this.xrLabel6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel6.SizeF = new System.Drawing.SizeF(100F, 23F);
        this.xrLabel6.StylePriority.UseFont = false;
        this.xrLabel6.StylePriority.UseTextAlignment = false;
        this.xrLabel6.Text = "N° Ore:";
        this.xrLabel6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
        // 
        // xrLabel7
        // 
        this.xrLabel7.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel7.LocationFloat = new DevExpress.Utils.PointFloat(240.2085F, 37.08334F);
        this.xrLabel7.Multiline = true;
        this.xrLabel7.Name = "xrLabel7";
        this.xrLabel7.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel7.SizeF = new System.Drawing.SizeF(136.4584F, 23F);
        this.xrLabel7.StylePriority.UseFont = false;
        this.xrLabel7.StylePriority.UseTextAlignment = false;
        this.xrLabel7.Text = "N° Ore Residue:";
        this.xrLabel7.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
        // 
        // xrLabel8
        // 
        this.xrLabel8.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[ResiduoOre]")});
        this.xrLabel8.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Bold);
        this.xrLabel8.LocationFloat = new DevExpress.Utils.PointFloat(390.625F, 37.08334F);
        this.xrLabel8.Multiline = true;
        this.xrLabel8.Name = "xrLabel8";
        this.xrLabel8.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel8.SizeF = new System.Drawing.SizeF(100F, 23F);
        this.xrLabel8.StylePriority.UseFont = false;
        this.xrLabel8.Text = "xrLabel8";
        this.xrLabel8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
        // 
        // xrLabel9
        // 
        this.xrLabel9.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Denom]")});
        this.xrLabel9.Font = new System.Drawing.Font("Arial", 20F);
        this.xrLabel9.LocationFloat = new DevExpress.Utils.PointFloat(241.6667F, 78.04163F);
        this.xrLabel9.Multiline = true;
        this.xrLabel9.Name = "xrLabel9";
        this.xrLabel9.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel9.SizeF = new System.Drawing.SizeF(598.9583F, 46.95835F);
        this.xrLabel9.StylePriority.UseFont = false;
        this.xrLabel9.Text = "xrLabel9";
        // 
        // xrLabel10
        // 
        this.xrLabel10.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[CodCli]")});
        this.xrLabel10.Font = new System.Drawing.Font("Arial", 20F);
        this.xrLabel10.LocationFloat = new DevExpress.Utils.PointFloat(114.5833F, 78.04163F);
        this.xrLabel10.Multiline = true;
        this.xrLabel10.Name = "xrLabel10";
        this.xrLabel10.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel10.SizeF = new System.Drawing.SizeF(100F, 46.95835F);
        this.xrLabel10.StylePriority.UseFont = false;
        this.xrLabel10.Text = "xrLabel10";
        // 
        // xrLabel11
        // 
        this.xrLabel11.Font = new System.Drawing.Font("Arial", 20F);
        this.xrLabel11.LocationFloat = new DevExpress.Utils.PointFloat(0F, 78.04163F);
        this.xrLabel11.Multiline = true;
        this.xrLabel11.Name = "xrLabel11";
        this.xrLabel11.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel11.SizeF = new System.Drawing.SizeF(100F, 46.95835F);
        this.xrLabel11.StylePriority.UseFont = false;
        this.xrLabel11.StylePriority.UseTextAlignment = false;
        this.xrLabel11.Text = "Cliente:";
        this.xrLabel11.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
        // 
        // xrLine1
        // 
        this.xrLine1.LocationFloat = new DevExpress.Utils.PointFloat(7.124996F, 71.24999F);
        this.xrLine1.Name = "xrLine1";
        this.xrLine1.SizeF = new System.Drawing.SizeF(1064.583F, 2F);
        // 
        // xrLine2
        // 
        this.xrLine2.LocationFloat = new DevExpress.Utils.PointFloat(10.00001F, 132.8333F);
        this.xrLine2.Name = "xrLine2";
        this.xrLine2.SizeF = new System.Drawing.SizeF(1064.583F, 2F);
        // 
        // xrLabel12
        // 
        this.xrLabel12.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?FromParam")});
        this.xrLabel12.LocationFloat = new DevExpress.Utils.PointFloat(564.4166F, 37.08334F);
        this.xrLabel12.Multiline = true;
        this.xrLabel12.Name = "xrLabel12";
        this.xrLabel12.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel12.SizeF = new System.Drawing.SizeF(100F, 23F);
        this.xrLabel12.Text = "xrLabel12";
        this.xrLabel12.TextFormatString = "{0:d}";
        // 
        // xrLabel13
        // 
        this.xrLabel13.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "?ToParam")});
        this.xrLabel13.LocationFloat = new DevExpress.Utils.PointFloat(715.4583F, 37.08334F);
        this.xrLabel13.Multiline = true;
        this.xrLabel13.Name = "xrLabel13";
        this.xrLabel13.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel13.SizeF = new System.Drawing.SizeF(100F, 23F);
        this.xrLabel13.Text = "xrLabel13";
        this.xrLabel13.TextFormatString = "{0:d}";
        // 
        // Contratto_Riepilogo_Rpt
        // 
        this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.TopMargin,
            this.BottomMargin,
            this.Detail,
            this.PageHeader});
        this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.sqlDataSource1});
        this.DataMember = "U_Carnet_Contratti_View_Intra";
        this.DataSource = this.sqlDataSource1;
        this.Font = new System.Drawing.Font("Arial", 9.75F);
        this.Landscape = true;
        this.Margins = new System.Drawing.Printing.Margins(21, 20, 24, 16);
        this.PageHeight = 827;
        this.PageWidth = 1169;
        this.PaperKind = (DevExpress.Drawing.Printing.DXPaperKind)System.Drawing.Printing.PaperKind.A4;
        this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.CodCliParam,
            this.IDcontrattoParam,
            this.FromParam,
            this.ToParam});
        this.Version = "19.2";
        ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

    }

    #endregion
}
