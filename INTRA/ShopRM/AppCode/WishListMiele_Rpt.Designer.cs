
namespace INTRA.ShopRM.AppCode
{
    partial class WishListMiele_Rpt
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(WishListMiele_Rpt));
            DevExpress.DataAccess.Sql.StoredProcQuery storedProcQuery1 = new DevExpress.DataAccess.Sql.StoredProcQuery();
            DevExpress.DataAccess.Sql.QueryParameter queryParameter1 = new DevExpress.DataAccess.Sql.QueryParameter();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.PriceNoPromo = new DevExpress.XtraReports.UI.XRLabel();
            this.InPromo_xrLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
            this.ShortDescriptionxr_RichText = new DevExpress.XtraReports.UI.XRRichText();
            this.xrLine1 = new DevExpress.XtraReports.UI.XRLine();
            this.FullDescription_xrRichText = new DevExpress.XtraReports.UI.XRRichText();
            this.Price_xrLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.xrPictureBox1 = new DevExpress.XtraReports.UI.XRPictureBox();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.xrLine2 = new DevExpress.XtraReports.UI.XRLine();
            this.xrPictureBox2 = new DevExpress.XtraReports.UI.XRPictureBox();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.virtualServerModeSource1 = new DevExpress.Data.VirtualServerModeSource(this.components);
            this.sqlDataSource2 = new DevExpress.DataAccess.Sql.SqlDataSource(this.components);
            this.ListProductCod = new DevExpress.XtraReports.Parameters.Parameter();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.xrPageInfo1 = new DevExpress.XtraReports.UI.XRPageInfo();
            ((System.ComponentModel.ISupportInitialize)(this.ShortDescriptionxr_RichText)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.FullDescription_xrRichText)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.virtualServerModeSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.PriceNoPromo,
            this.InPromo_xrLabel,
            this.xrLabel2,
            this.ShortDescriptionxr_RichText,
            this.xrLine1,
            this.FullDescription_xrRichText,
            this.Price_xrLabel,
            this.xrPictureBox1,
            this.xrLabel1});
            this.Detail.HeightF = 188F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // PriceNoPromo
            // 
            this.PriceNoPromo.BorderColor = System.Drawing.Color.DarkGray;
            this.PriceNoPromo.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Price]")});
            this.PriceNoPromo.Font = new DevExpress.Drawing.DXFont("Arial", 12F, ((DevExpress.Drawing.DXFontStyle)((DevExpress.Drawing.DXFontStyle.Bold | DevExpress.Drawing.DXFontStyle.Strikeout))));
            this.PriceNoPromo.ForeColor = System.Drawing.Color.DarkGray;
            this.PriceNoPromo.LocationFloat = new DevExpress.Utils.PointFloat(645.8333F, 91.99996F);
            this.PriceNoPromo.Multiline = true;
            this.PriceNoPromo.Name = "PriceNoPromo";
            this.PriceNoPromo.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.PriceNoPromo.SizeF = new System.Drawing.SizeF(100F, 23.00002F);
            this.PriceNoPromo.StylePriority.UseBorderColor = false;
            this.PriceNoPromo.StylePriority.UseFont = false;
            this.PriceNoPromo.StylePriority.UseForeColor = false;
            this.PriceNoPromo.StylePriority.UseTextAlignment = false;
            this.PriceNoPromo.Text = "Price_xrLabel";
            this.PriceNoPromo.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            this.PriceNoPromo.TextFormatString = "{0:€0.00}";
            // 
            // InPromo_xrLabel
            // 
            this.InPromo_xrLabel.Font = new DevExpress.Drawing.DXFont("Arial", 12F, DevExpress.Drawing.DXFontStyle.Bold);
            this.InPromo_xrLabel.ForeColor = System.Drawing.Color.Maroon;
            this.InPromo_xrLabel.LocationFloat = new DevExpress.Utils.PointFloat(534.375F, 68.99998F);
            this.InPromo_xrLabel.Multiline = true;
            this.InPromo_xrLabel.Name = "InPromo_xrLabel";
            this.InPromo_xrLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.InPromo_xrLabel.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.InPromo_xrLabel.StylePriority.UseFont = false;
            this.InPromo_xrLabel.StylePriority.UseForeColor = false;
            this.InPromo_xrLabel.StylePriority.UseTextAlignment = false;
            this.InPromo_xrLabel.Text = "IN PROMO";
            this.InPromo_xrLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            this.InPromo_xrLabel.BeforePrint += new DevExpress.XtraReports.UI.BeforePrintEventHandler(this.InPromo_xrLabel_BeforePrint);
            // 
            // xrLabel2
            // 
            this.xrLabel2.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[PromoPrice]")});
            this.xrLabel2.Font = new DevExpress.Drawing.DXFont("Arial", 12F, DevExpress.Drawing.DXFontStyle.Bold);
            this.xrLabel2.ForeColor = System.Drawing.Color.Maroon;
            this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(645.8333F, 68.99998F);
            this.xrLabel2.Multiline = true;
            this.xrLabel2.Name = "xrLabel2";
            this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel2.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel2.StylePriority.UseFont = false;
            this.xrLabel2.StylePriority.UseForeColor = false;
            this.xrLabel2.Text = "xrLabel2";
            this.xrLabel2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            this.xrLabel2.TextFormatString = "{0:€0.00}";
            // 
            // ShortDescriptionxr_RichText
            // 
            this.ShortDescriptionxr_RichText.CanShrink = true;
            this.ShortDescriptionxr_RichText.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "[ShortDescription]")});
            this.ShortDescriptionxr_RichText.Font = new DevExpress.Drawing.DXFont("Times New Roman", 9.75F);
            this.ShortDescriptionxr_RichText.LocationFloat = new DevExpress.Utils.PointFloat(162.5F, 23.00003F);
            this.ShortDescriptionxr_RichText.Name = "ShortDescriptionxr_RichText";
            this.ShortDescriptionxr_RichText.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.ShortDescriptionxr_RichText.SerializableRtfString = resources.GetString("ShortDescriptionxr_RichText.SerializableRtfString");
            this.ShortDescriptionxr_RichText.SizeF = new System.Drawing.SizeF(584.5F, 22.99998F);
            this.ShortDescriptionxr_RichText.StylePriority.UseFont = false;
            this.ShortDescriptionxr_RichText.BeforePrint += new DevExpress.XtraReports.UI.BeforePrintEventHandler(this.ShortDescriptionxr_RichText_BeforePrint);
            // 
            // xrLine1
            // 
            this.xrLine1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 165F);
            this.xrLine1.Name = "xrLine1";
            this.xrLine1.SizeF = new System.Drawing.SizeF(747F, 23F);
            // 
            // FullDescription_xrRichText
            // 
            this.FullDescription_xrRichText.CanShrink = true;
            this.FullDescription_xrRichText.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Html", "[FullDescription]")});
            this.FullDescription_xrRichText.Font = new DevExpress.Drawing.DXFont("Times New Roman", 9.75F);
            this.FullDescription_xrRichText.LocationFloat = new DevExpress.Utils.PointFloat(162.5F, 45.99999F);
            this.FullDescription_xrRichText.Name = "FullDescription_xrRichText";
            this.FullDescription_xrRichText.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.FullDescription_xrRichText.SerializableRtfString = resources.GetString("FullDescription_xrRichText.SerializableRtfString");
            this.FullDescription_xrRichText.SizeF = new System.Drawing.SizeF(584.5F, 22.99999F);
            this.FullDescription_xrRichText.StylePriority.UseFont = false;
            this.FullDescription_xrRichText.BeforePrint += new DevExpress.XtraReports.UI.BeforePrintEventHandler(this.FullDescription_xrRichText_BeforePrint);
            // 
            // Price_xrLabel
            // 
            this.Price_xrLabel.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Price]")});
            this.Price_xrLabel.Font = new DevExpress.Drawing.DXFont("Arial", 12F, DevExpress.Drawing.DXFontStyle.Bold);
            this.Price_xrLabel.LocationFloat = new DevExpress.Utils.PointFloat(634.3749F, 68.99998F);
            this.Price_xrLabel.Multiline = true;
            this.Price_xrLabel.Name = "Price_xrLabel";
            this.Price_xrLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.Price_xrLabel.SizeF = new System.Drawing.SizeF(111.4583F, 23F);
            this.Price_xrLabel.StylePriority.UseFont = false;
            this.Price_xrLabel.StylePriority.UseTextAlignment = false;
            this.Price_xrLabel.Text = "Price_xrLabel";
            this.Price_xrLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            this.Price_xrLabel.TextFormatString = "{0:€0.00}";
            this.Price_xrLabel.BeforePrint += new DevExpress.XtraReports.UI.BeforePrintEventHandler(this.xrLabel4_BeforePrint);
            // 
            // xrPictureBox1
            // 
            this.xrPictureBox1.ImageAlignment = DevExpress.XtraPrinting.ImageAlignment.TopLeft;
            this.xrPictureBox1.ImageUrl = "E:\\Users\\SimoneDB\\Download\\noimage.jpg";
            this.xrPictureBox1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrPictureBox1.Name = "xrPictureBox1";
            this.xrPictureBox1.SizeF = new System.Drawing.SizeF(147.9167F, 165F);
            this.xrPictureBox1.Sizing = DevExpress.XtraPrinting.ImageSizeMode.Squeeze;
            this.xrPictureBox1.BeforePrint += new DevExpress.XtraReports.UI.BeforePrintEventHandler(this.xrPictureBox1_BeforePrint);
            // 
            // xrLabel1
            // 
            this.xrLabel1.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[DisplayName]")});
            this.xrLabel1.Font = new DevExpress.Drawing.DXFont("Arial", 9.75F, DevExpress.Drawing.DXFontStyle.Bold);
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(162.5F, 0F);
            this.xrLabel1.Multiline = true;
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(584.5F, 23F);
            this.xrLabel1.StylePriority.UseFont = false;
            this.xrLabel1.Text = "xrLabel1";
            // 
            // TopMargin
            // 
            this.TopMargin.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLine2,
            this.xrPictureBox2});
            this.TopMargin.HeightF = 64.66667F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.StylePriority.UseTextAlignment = false;
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLine2
            // 
            this.xrLine2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 41.66667F);
            this.xrLine2.Name = "xrLine2";
            this.xrLine2.SizeF = new System.Drawing.SizeF(747F, 23F);
            // 
            // xrPictureBox2
            // 
            this.xrPictureBox2.ImageSource = new DevExpress.XtraPrinting.Drawing.ImageSource("svg", resources.GetString("xrPictureBox2.ImageSource"));
            this.xrPictureBox2.LocationFloat = new DevExpress.Utils.PointFloat(321.4166F, 0F);
            this.xrPictureBox2.Name = "xrPictureBox2";
            this.xrPictureBox2.SizeF = new System.Drawing.SizeF(104.1667F, 41.66667F);
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 0F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // sqlDataSource2
            // 
            this.sqlDataSource2.ConnectionName = "info4portaleConnectionString";
            this.sqlDataSource2.Name = "sqlDataSource2";
            storedProcQuery1.Name = "SHP_GetWishListMiele";
            queryParameter1.Name = "@ListProductCod";
            queryParameter1.Type = typeof(DevExpress.DataAccess.Expression);
            queryParameter1.Value = new DevExpress.DataAccess.Expression("?ListProductCod", typeof(string));
            storedProcQuery1.Parameters.AddRange(new DevExpress.DataAccess.Sql.QueryParameter[] {
            queryParameter1});
            storedProcQuery1.StoredProcName = "SHP_GetWishListMiele";
            this.sqlDataSource2.Queries.AddRange(new DevExpress.DataAccess.Sql.SqlQuery[] {
            storedProcQuery1});
            this.sqlDataSource2.ResultSchemaSerializable = resources.GetString("sqlDataSource2.ResultSchemaSerializable");
            // 
            // ListProductCod
            // 
            this.ListProductCod.Description = "ListProductCod";
            this.ListProductCod.Name = "ListProductCod";
            this.ListProductCod.ValueInfo = " where ProductCod IN (\'10123250\')";
            this.ListProductCod.Visible = false;
            // 
            // PageFooter
            // 
            this.PageFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrPageInfo1});
            this.PageFooter.HeightF = 26.5F;
            this.PageFooter.Name = "PageFooter";
            // 
            // xrPageInfo1
            // 
            this.xrPageInfo1.Font = new DevExpress.Drawing.DXFont("Arial", 11F, DevExpress.Drawing.DXFontStyle.Bold);
            this.xrPageInfo1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrPageInfo1.Name = "xrPageInfo1";
            this.xrPageInfo1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrPageInfo1.SizeF = new System.Drawing.SizeF(747F, 23F);
            this.xrPageInfo1.StylePriority.UseFont = false;
            this.xrPageInfo1.StylePriority.UseTextAlignment = false;
            this.xrPageInfo1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // WishListMiele_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.PageFooter});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.virtualServerModeSource1,
            this.sqlDataSource2});
            this.DataMember = "SHP_GetWishListMiele";
            this.DataSource = this.sqlDataSource2;
            this.Margins = new DevExpress.Drawing.DXMargins(44F, 59F, 64.66667F, 0F);
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.ListProductCod});
            this.Version = "23.1";
            ((System.ComponentModel.ISupportInitialize)(this.ShortDescriptionxr_RichText)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.FullDescription_xrRichText)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.virtualServerModeSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.XRLabel xrLabel1;
        private DevExpress.XtraReports.UI.XRPictureBox xrPictureBox1;
        private DevExpress.Data.VirtualServerModeSource virtualServerModeSource1;
        private DevExpress.XtraReports.UI.XRLabel Price_xrLabel;
        private DevExpress.XtraReports.UI.XRRichText FullDescription_xrRichText;
        private DevExpress.XtraReports.UI.XRLine xrLine1;
        private DevExpress.DataAccess.Sql.SqlDataSource sqlDataSource2;
        private DevExpress.XtraReports.Parameters.Parameter ListProductCod;
        private DevExpress.XtraReports.UI.XRPictureBox xrPictureBox2;
        private DevExpress.XtraReports.UI.XRRichText ShortDescriptionxr_RichText;
        private DevExpress.XtraReports.UI.XRLabel xrLabel2;
        private DevExpress.XtraReports.UI.XRLine xrLine2;
        private DevExpress.XtraReports.UI.XRLabel InPromo_xrLabel;
        private DevExpress.XtraReports.UI.XRLabel PriceNoPromo;
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
        private DevExpress.XtraReports.UI.XRPageInfo xrPageInfo1;
    }
}
