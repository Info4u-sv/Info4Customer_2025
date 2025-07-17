using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using static INTRA.AppCode.UploadedFile_DX;

namespace INTRA.Catalogo
{
    public partial class Articoli_Crud : System.Web.UI.Page
    {
        private readonly string UploadDirectory = "/PUBLIC/Catalogo/";


        protected string SubmissionID
        {
            get => HfFile.Get("SubmissionID").ToString();
            set => HfFile.Set("SubmissionID", value);
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                SubmissionID = UploadControlHelper.GenerateUploadedFilesStorageKey();
                UploadControlHelper.AddUploadedFilesStorage(SubmissionID);
                Session["PathImmagineSess"] = string.Empty;
                Session["ParentIDSess"] = null;


                if (Request.QueryString["Cod"] != null)
                {
                    //ImmagineCaricata_Img.ClientVisible = true;
                    Salva_Btn.Visible = false;
                    SalvaUpd_Btn.ClientVisible = true;
                    CodArt1_Txt.ClientEnabled = false;
                }
            }
        }


        protected void Page_PreLoad(object sender, EventArgs e)
        {
            UploadControlHelper.RemoveOldStorages();
        }

        private UploadedFilesStorage_1 UploadedFilesStorage => UploadControlHelper.GetUploadedFilesStorageByKey(SubmissionID);
        protected void DocumentsUploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            if (UploadedFilesStorage == null)
            {
                UploadControlHelper.AddUploadedFilesStorage(SubmissionID);
            }
            UploadedFileInfo_1 tempFileInfo = UploadControlHelper.AddUploadedFileInfo(SubmissionID, e.UploadedFile.FileName.Replace(".tif", ".jpg"));

            e.UploadedFile.SaveAs(tempFileInfo.FilePath);
            Random rnd = new Random();
            int number = rnd.Next(1, 99999);
            if (e.IsValid)
            {
                FileInfo fi = new FileInfo(e.UploadedFile.FileName);
                string fileNameNorm = e.UploadedFile.FileName;
                string strFile = PRT_FunzioniGenerali_23.RewriteString(Path.GetFileNameWithoutExtension(fi.Name));
                string extFile = fi.Extension;


                //fileNameNorm = strFile+ extFile;
                e.CallbackData = fileNameNorm;
                DocumentsUploadControl.JSProperties["cpPathImmagine"] = tempFileInfo.FilePath;
                Session["PathImmagineSess"] = UploadDirectory + number + "_" + strFile + extFile;
            }

        }
        //protected void CaricaDocumenti_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        //{
        //    List<UploadedFileInfo_1> resultFileInfos = new List<UploadedFileInfo_1>();

        //    //Categorie_Dts.DeleteParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"].ToString();
        //    //Categorie_Dts.Delete();



        //    //var nodes = TreeListMenu.GetSelectedNodes();
        //    //List<string> values = new List<string>();
        //    //foreach (TreeListNode node in nodes)
        //    //{
        //    //    Categorie_Dts.InsertParameters["IDCategoria"].DefaultValue = node.GetValue("CategoryID").ToString();
        //    //    Categorie_Dts.InsertParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"].ToString();
        //    //    Categorie_Dts.Insert();
        //    //}


        //    if (Request.QueryString["Cod"] != null)
        //    {
        //        Artiolo_Dts.UpdateParameters["ProductCod"].DefaultValue = CodArt1_Txt.Text;
        //        Artiolo_Dts.UpdateParameters["DisplayName"].DefaultValue = Titolo_txt.Text;
        //        Artiolo_Dts.UpdateParameters["ShortDescription"].DefaultValue = DescrizioneBreve_Memo.Html.ToString();
        //        Artiolo_Dts.UpdateParameters["FullDescription"].DefaultValue = Descrizione_Memo.Html.ToString();
        //        Artiolo_Dts.UpdateParameters["BrandId"].DefaultValue = Marchio_Combobox.SelectedItem.Value.ToString();
        //        Artiolo_Dts.UpdateParameters["units"].DefaultValue = UM_Txt.Text;
        //        Artiolo_Dts.UpdateParameters["quantity"].DefaultValue = Qta_Txt.Number.ToString();
        //        Artiolo_Dts.UpdateParameters["Price"].DefaultValue = PrezzoDiListino_SpinEdit.Number.ToString();
        //        Artiolo_Dts.UpdateParameters["Published"].DefaultValue = Pubblica_Checkbox.Checked.ToString();
        //        Artiolo_Dts.UpdateParameters["UrlImmagine"].DefaultValue = Session["PathImmagineSess"].ToString();
        //        Artiolo_Dts.Update();

        //        foreach (string fileName in UploadedFilesTokenBox.Tokens)
        //        {
        //            UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
        //            if(demoFileInfo != null)
        //            {


        //            if (File.Exists(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString())))
        //            {
        //                File.Delete(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
        //                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
        //            }
        //            else
        //            {
        //                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
        //                }
        //            }
        //            else
        //            {
        //                return;
        //            }
        //        }
        //        //ImmagineCaricata_Img.ImageUrl = Session["PathImmagineSess"].ToString();
        //        AggiornaCategorie(Request.QueryString["Cod"]);
        //    }
        //    else
        //    {
        //        Artiolo_Dts.InsertParameters["ProductCod"].DefaultValue = CodArt1_Txt.Text;
        //        Artiolo_Dts.InsertParameters["DisplayName"].DefaultValue = Titolo_txt.Text;
        //        Artiolo_Dts.InsertParameters["ShortDescription"].DefaultValue = DescrizioneBreve_Memo.Html.ToString();
        //        Artiolo_Dts.InsertParameters["FullDescription"].DefaultValue = Descrizione_Memo.Html.ToString();
        //        Artiolo_Dts.InsertParameters["BrandId"].DefaultValue = Marchio_Combobox.SelectedItem.Value.ToString();
        //        Artiolo_Dts.InsertParameters["units"].DefaultValue = UM_Txt.Text;
        //        Artiolo_Dts.InsertParameters["quantity"].DefaultValue = Qta_Txt.Number.ToString();
        //        Artiolo_Dts.InsertParameters["Price"].DefaultValue = PrezzoDiListino_SpinEdit.Number.ToString();
        //        Artiolo_Dts.InsertParameters["Published"].DefaultValue = Pubblica_Checkbox.Checked.ToString();
        //        Artiolo_Dts.InsertParameters["UrlImmagine"].DefaultValue = Session["PathImmagineSess"].ToString();
        //        Artiolo_Dts.Insert();

        //        foreach (string fileName in UploadedFilesTokenBox.Tokens)
        //        {
        //            UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
        //            if (File.Exists(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString())))
        //            {
        //                File.Delete(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
        //                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
        //            }
        //            else
        //            {
        //                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
        //            }
        //        }
        //        AggiornaCategorie(CodArt1_Txt.Text);
        //        ASPxWebControl.RedirectOnCallback("/Catalogo/Articoli_Crud.aspx?Cod=" + CodArt1_Txt.Text);
        //    }




        //    UploadControlHelper.RemoveUploadedFilesStorage(SubmissionID);
        //    ASPxEdit.ClearEditorsInContainer(FormLayout, true);
        //}

        protected void InserimentoArt_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            InserimentoArticolo_FormLy.DataBind();
        }

        protected void ControlloCodiceArticolo_Callback_Callback(object source, CallbackEventArgs e)
        {
            SHP_Articoli CheckCodArt = new SHP_Articoli();

            ControlloCodiceArticolo_Callback.JSProperties["cpExistCodArt"] = CheckCodArt.SHP_ArticoliCheck(e.Parameter);
        }

        protected void ImmagineCaricata_Img_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    //ImmagineCaricata_Img.ImageUrl = dvSql[i]["PictureUrl"].ToString();
                }
            }
        }

        private List<string> nodeKeys;

        private void ProcessNodes(TreeListNode startNode)
        {
            if (startNode == null)
            {
                return;
            }

            TreeListNodeIterator iterator = new TreeListNodeIterator(startNode);
            nodeKeys = new List<string>();
            while (iterator.Current != null)
            {
                if (Convert.ToInt32(iterator.Current.GetValue("Flag")) > 0)
                {
                    iterator.Current.Selected = true;
                }

                _ = iterator.GetNext();
            }
        }

        protected void TreeListMenu_DataBound(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                if (!IsPostBack)
                {
                    try
                    {

                        ASPxTreeList list = sender as ASPxTreeList;
                        for (int i = 0; i < list.TotalNodeCount; i++)
                        {

                            ProcessNodes(list.Nodes[i]);
                        }
                    }
                    catch
                    {

                    }


                }
            }
        }

        protected void UploadedFilesTokenBox_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    UploadedFilesTokenBox.Tokens.Add(dvSql[i]["PictureUrl"].ToString());
                }
            }

        }

        protected void Descrizione_Memo_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    Descrizione_Memo.Html = dvSql[i]["FullDescription"].ToString();
                }
            }
        }

        protected void DescrizioneBreve_Memo_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    DescrizioneBreve_Memo.Html = dvSql[i]["ShortDescription"].ToString();
                }
            }
        }

        protected void CaricaDocumentiLocal_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {

            string PictureID = "0";
            string Tipologiarichiesta = "0";
            string FileName = string.Empty;
            if (e.Parameter != string.Empty)
            {
                string[] Parametri = e.Parameter.Split(';');
                PictureID = Parametri[0];
                Tipologiarichiesta = Parametri[1];
                FileName = Parametri[2];
            }
            if (PictureID != "0")
            {
                if (Tipologiarichiesta == "1")
                {
                    SHP_Picture_Slider.UpdateParameters["CodArt"].DefaultValue = Request.QueryString["Cod"].ToString();
                    SHP_Picture_Slider.UpdateParameters["PictureID"].DefaultValue = PictureID;
                    _ = SHP_Picture_Slider.Update();
                    CaricaDocumentiLocal_CallbackPnl.JSProperties["cpImmaginePrincipale"] = 1; // non toccare
                    cardView_Aperti.DataBind();
                }
                if (Tipologiarichiesta == "-1")
                {
                    //delete
                    CaricaDocumentiLocal_CallbackPnl.JSProperties["cpImmaginePrincipale"] = 1; // non toccare
                    SHP_Picture_Slider.DeleteParameters["PictureID"].DefaultValue = PictureID;
                    _ = SHP_Picture_Slider.Delete();
                    SHP_Picture_DeleteImgFisica(FileName);
                    cardView_Aperti.DataBind();

                }
            }
            else
            {

                CaricaDocumentiLocal_CallbackPnl.JSProperties["cpImmaginePrincipale"] = 0; // non toccare
                _ = new List<UploadedFileInfo_1>();



                if (Request.QueryString["Cod"] != null)
                {
                    //Categorie_Dts.DeleteParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"].ToString();
                    //Categorie_Dts.Delete();



                    //var nodes = TreeListMenu.GetSelectedNodes();
                    //List<string> values = new List<string>();
                    //foreach (TreeListNode node in nodes)
                    //{
                    //    Categorie_Dts.InsertParameters["IDCategoria"].DefaultValue = node.GetValue("CategoryID").ToString();
                    //    Categorie_Dts.InsertParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"].ToString();
                    //    Categorie_Dts.Insert();
                    //}


                    Artiolo_Dts.UpdateParameters["Confezione"].DefaultValue = Confezione_Html.Html;
                    Artiolo_Dts.UpdateParameters["ProductCod"].DefaultValue = CodArt1_Txt.Text;
                    Artiolo_Dts.UpdateParameters["DisplayName"].DefaultValue = Titolo_txt.Text;
                    Artiolo_Dts.UpdateParameters["AttributesList"].DefaultValue = AttributesList_Memo.Html.ToString();
                    Artiolo_Dts.UpdateParameters["ShortDescription"].DefaultValue = DescrizioneBreve_Memo.Html.ToString();
                    Artiolo_Dts.UpdateParameters["FullDescription"].DefaultValue = Descrizione_Memo.Html.ToString();
                    Artiolo_Dts.UpdateParameters["BrandId"].DefaultValue = "1";
                    Artiolo_Dts.UpdateParameters["units"].DefaultValue = UM_Combobox.SelectedItem.Text.ToString();
                    Artiolo_Dts.UpdateParameters["quantity"].DefaultValue = Qta_Txt.Number.ToString();
                    Artiolo_Dts.UpdateParameters["Price"].DefaultValue = PrezzoDiListino_SpinEdit.Number.ToString();
                    Artiolo_Dts.UpdateParameters["PuntiInPercentuale"].DefaultValue = PercentualPerPunti_spin.Number.ToString();

                    Artiolo_Dts.UpdateParameters["Published"].DefaultValue = Pubblica_Checkbox.Checked.ToString();
                    Artiolo_Dts.UpdateParameters["UrlImmagine"].DefaultValue = string.Empty;

                    Artiolo_Dts.UpdateParameters["GiorniRichiestiFlag"].DefaultValue = "false";
                    Artiolo_Dts.UpdateParameters["TokenAttributi"].DefaultValue = string.Empty;
                    Artiolo_Dts.UpdateParameters["GiorniRichiesti"].DefaultValue = string.Empty;
                    Artiolo_Dts.UpdateParameters["TokenTipoAttributi"].DefaultValue = "RmShopGiorniGest";

                    foreach (string fileName in UploadedFilesTokenBox.Tokens)
                    {
                        UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                        if (demoFileInfo != null)
                        {


                            if (File.Exists(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString())))
                            {
                                Artiolo_Dts.UpdateParameters["UrlImmagine"].DefaultValue = Session["PathImmagineSess"].ToString();
                                File.Delete(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                            }
                            else
                            {
                                Artiolo_Dts.UpdateParameters["UrlImmagine"].DefaultValue = Session["PathImmagineSess"].ToString();
                                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                            }
                        }
                        else
                        {
                            return;
                        }
                    }


                    foreach (string fileName in SHPPictureSlideUno_Token.Tokens)
                    {
                        UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                        if (demoFileInfo != null)
                        {


                            if (File.Exists(HttpContext.Current.Server.MapPath(Session["SHPPictureSlideUnoSess"].ToString())))
                            {
                                Artiolo_Dts.UpdateParameters["UrlImmagineSlide"].DefaultValue = Session["SHPPictureSlideUnoSess"].ToString();
                                File.Delete(HttpContext.Current.Server.MapPath(Session["SHPPictureSlideUnoSess"].ToString()));
                                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["SHPPictureSlideUnoSess"].ToString()));
                            }
                            else
                            {
                                Artiolo_Dts.UpdateParameters["UrlImmagineSlide"].DefaultValue = Session["SHPPictureSlideUnoSess"].ToString();
                                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["SHPPictureSlideUnoSess"].ToString()));
                            }
                        }
                        else
                        {
                            return;
                        }
                    }


                    _ = Artiolo_Dts.Update();
                    AggiornaCategorie(Request.QueryString["Cod"]);
                    //ImmagineCaricata_Img.ImageUrl = Session["PathImmagineSess"].ToString();

                }
                else
                {
                    Artiolo_Dts.InsertParameters["AttributesList"].DefaultValue = AttributesList_Memo.Html.ToString();
                    Artiolo_Dts.InsertParameters["Confezione"].DefaultValue = Confezione_Html.Html;
                    Artiolo_Dts.InsertParameters["ProductCod"].DefaultValue = CodArt1_Txt.Text;
                    Artiolo_Dts.InsertParameters["DisplayName"].DefaultValue = Titolo_txt.Text;
                    Artiolo_Dts.InsertParameters["ShortDescription"].DefaultValue = DescrizioneBreve_Memo.Html.ToString();
                    Artiolo_Dts.InsertParameters["FullDescription"].DefaultValue = Descrizione_Memo.Html.ToString();
                    Artiolo_Dts.InsertParameters["BrandId"].DefaultValue = "1";
                    Artiolo_Dts.InsertParameters["units"].DefaultValue = UM_Combobox.SelectedItem.Text.ToString();
                    Artiolo_Dts.InsertParameters["quantity"].DefaultValue = Qta_Txt.Number.ToString();
                    Artiolo_Dts.InsertParameters["Price"].DefaultValue = PrezzoDiListino_SpinEdit.Number.ToString();
                    Artiolo_Dts.InsertParameters["PuntiInPercentuale"].DefaultValue = PercentualPerPunti_spin.Number.ToString();

                    Artiolo_Dts.InsertParameters["Published"].DefaultValue = Pubblica_Checkbox.Checked.ToString();

                    Artiolo_Dts.InsertParameters["UrlImmagineSlide"].DefaultValue = Session["SHPPictureSlideUnoSess"] != null ? Session["SHPPictureSlideUnoSess"].ToString() : string.Empty;



                    Artiolo_Dts.InsertParameters["UrlImmagine"].DefaultValue = Session["PathImmagineSess"] != null ? Session["PathImmagineSess"].ToString() : string.Empty;


                    Artiolo_Dts.InsertParameters["GiorniRichiestiFlag"].DefaultValue = "false";

                    Artiolo_Dts.InsertParameters["TokenAttributi"].DefaultValue = string.Empty;
                    Artiolo_Dts.InsertParameters["GiorniRichiesti"].DefaultValue = string.Empty;
                    Artiolo_Dts.InsertParameters["TokenTipoAttributi"].DefaultValue = "RmShopGiorniGest";

                    _ = Artiolo_Dts.Insert();

                    foreach (string fileName in UploadedFilesTokenBox.Tokens)
                    {
                        UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                        if (File.Exists(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString())))
                        {
                            File.Delete(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                            File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                        }
                        else
                        {
                            File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                        }
                    }


                    foreach (string fileName in SHPPictureSlideUno_Token.Tokens)
                    {
                        UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                        if (demoFileInfo != null)
                        {
                            if (File.Exists(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString())))
                            {
                                File.Delete(HttpContext.Current.Server.MapPath(Session["SHPPictureSlideUnoSess"].ToString()));
                                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["SHPPictureSlideUnoSess"].ToString()));
                            }
                            else
                            {
                                File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["SHPPictureSlideUnoSess"].ToString()));
                            }
                        }
                        else
                        {
                            return;
                        }
                    }

                    AggiornaCategorie(CodArt1_Txt.Text);
                    ASPxWebControl.RedirectOnCallback("/Catalogo/Articoli_Crud.aspx?Cod=" + CodArt1_Txt.Text);
                }


                UploadControlHelper.RemoveUploadedFilesStorage(SubmissionID);
                ASPxEdit.ClearEditorsInContainer(FormLayout, true);
            }
        }




        public static void SHP_Picture_DeleteImgFisica(string Path)
        {

            if (File.Exists(HttpContext.Current.Server.MapPath(Path)))
            {
                File.Delete(HttpContext.Current.Server.MapPath(Path));
            }

        }
        private void AggiornaCategorie(string ProductCod)
        {
            Categorie_Dts.DeleteParameters["ProductCod"].DefaultValue = ProductCod;
            _ = Categorie_Dts.Delete();



            List<TreeListNode> nodes = TreeListMenu.GetSelectedNodes();
            _ = new List<string>();
            foreach (TreeListNode node in nodes)
            {
                Categorie_Dts.InsertParameters["IDCategoria"].DefaultValue = node.GetValue("CategoryID").ToString();
                Categorie_Dts.InsertParameters["ProductCod"].DefaultValue = ProductCod;
                _ = Categorie_Dts.Insert();
            }
        }

        protected void AttributesList_Memo_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    AttributesList_Memo.Html = dvSql[i]["AttributesList"].ToString();
                }
            }
        }

        protected void SHPPictureSlideUno_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            string PictureID = "0";
            string Tipologiarichiesta = "0";
            string FileName = string.Empty;
            if (e.Parameter != string.Empty)
            {
                string[] Parametri = e.Parameter.Split(';');
                PictureID = Parametri[0];
                Tipologiarichiesta = Parametri[1];
                FileName = Parametri[2];
            }
            if (PictureID != "0")
            {
                if (Tipologiarichiesta == "1")
                {

                    SHPPictureSlideUno_Dts.UpdateParameters["CodArt"].DefaultValue = Request.QueryString["Cod"].ToString();
                    SHPPictureSlideUno_Dts.UpdateParameters["PictureID"].DefaultValue = PictureID;
                    _ = SHPPictureSlideUno_Dts.Update();
                    SHPPictureSlideUno_Cardview.DataBind();
                }
                if (Tipologiarichiesta == "-1")
                {
                    //delete
                    SHPPictureSlideUno_Dts.DeleteParameters["PictureID"].DefaultValue = PictureID;
                    _ = SHPPictureSlideUno_Dts.Delete();
                    SHP_Picture_DeleteImgFisica(FileName);
                    SHPPictureSlideUno_Cardview.DataBind();
                }
            }
        }

        protected void SHPPictureSlideUno_UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            if (UploadedFilesStorage == null)
            {
                UploadControlHelper.AddUploadedFilesStorage(SubmissionID);
            }
            UploadedFileInfo_1 tempFileInfo = UploadControlHelper.AddUploadedFileInfo(SubmissionID, e.UploadedFile.FileName.Replace(".tif", ".jpg"));
            tempFileInfo.UniqueFileName = NormalizeFileName(tempFileInfo.UniqueFileName);
            e.UploadedFile.SaveAs(tempFileInfo.FilePath);
            Random rnd = new Random();
            int number = rnd.Next(1, 99999);
            if (e.IsValid)
            {
                string fileNameNorm = NormalizeFileName(e.UploadedFile.FileName);
                e.CallbackData = fileNameNorm;
                Session["SHPPictureSlideUnoSess"] = UploadDirectory + number + "_" + fileNameNorm;
            }
        }

        protected void SHPPictureSlideDue_UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {

        }

        protected void Confezione_Html_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    Confezione_Html.Html = dvSql[i]["Confezione"].ToString();
                }
            }
        }



        protected void StopDate_Lbl_Load(object sender, EventArgs e)
        {

        }

        protected void StartDate_Lbl_Load(object sender, EventArgs e)
        {

        }

        protected void PromoPrice_Lbl_Load(object sender, EventArgs e)
        {

        }

        protected void PromoPrice_Lbl_DataBinding(object sender, EventArgs e)
        {
            ASPxLabel label = (ASPxLabel)sender;
            if (Request.QueryString["Cod"] != null)
            {
                if (label.Text != string.Empty)
                {
                    label.Text = decimal.Round(Convert.ToDecimal(label.Text), 2, MidpointRounding.AwayFromZero).ToString();
                }

            }
        }

        protected void StartDate_Lbl_DataBinding(object sender, EventArgs e)
        {
            ASPxLabel label = (ASPxLabel)sender;

            if (Request.QueryString["Cod"] != null)
            {
                if (label.Text != string.Empty)
                {
                    label.Text = DateTime.Parse(label.Text).ToShortDateString();
                }
            }
        }

        protected void StopDate_Lbl_DataBinding(object sender, EventArgs e)
        {
            ASPxLabel label = (ASPxLabel)sender;
            if (Request.QueryString["Cod"] != null)
            {
                if (label.Text != string.Empty)
                {

                    label.Text = DateTime.Parse(label.Text).ToShortDateString();
                }
            }
        }

        protected void Qta_Txt_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    Qta_Txt.Number = Convert.ToInt32(dvSql[i]["quantity"]);
                }
            }
        }

        protected void PrezzoDiListino_SpinEdit_DataBinding(object sender, EventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    PrezzoDiListino_SpinEdit.Number = Convert.ToDecimal(dvSql[i]["Price"]);
                }
            }
        }

        protected void Elimina_CallbackPnl_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                string ProductID = dvSql[0]["ProductID"].ToString();
                AppoggioEliminazione_Sql.DeleteParameters["ProductID"].DefaultValue = ProductID;
                _ = AppoggioEliminazione_Sql.Delete();

                ASPxWebControl.RedirectOnCallback("Lista_Articoli.aspx");
            }
        }

        protected void ControlTreeList_Callback_Callback(object source, CallbackEventArgs e)
        {

            List<TreeListNode> nodes = TreeListMenu.GetSelectedNodes();
            ControlTreeList_Callback.JSProperties["cpCategoriaSelezionata"] = nodes.Count > 0 ? 1 + "|" + e.Parameter : (object)(0 + "|" + e.Parameter);
        }


        protected string NormalizeFileName(string fileName)
        {
            string[] CharactesNotWanted = { "(", ")", " ", " \\ ", "/" };
            for (int i = 0; i < CharactesNotWanted.Length; i++)
            {
                if (fileName.Contains(CharactesNotWanted[i]))
                {
                    fileName = fileName.Replace(CharactesNotWanted[i], "_");
                }
            }
            return fileName;
        }

        protected void Clone_Callback_Callback(object source, CallbackEventArgs e)
        {
            Sql4Helper objSqlHelper = new Sql4Helper();
            SqlParameter[] objParams = new SqlParameter[2];
            objParams[0] = new SqlParameter("@ProductCodDaClonare", CodArt1_Txt.Text);
            objParams[1] = new SqlParameter("@NuovoProductCod", NuovoCodice_Clona.Text);
            int NewIDProduct = objSqlHelper.ExecuteNonQueryForNews("SHP_ArticoloClona", objParams);

            // chiamo la funzione per duplicare le immagini prodotto e slider passando il NuovoCodice_Clona.Text
            // sono 2 chiamate una per il prodotto e una per lo slider
            U_Shp_Gestione_img img_Gest = new U_Shp_Gestione_img();
            img_Gest.CloneImages(NewIDProduct, CodArt1_Txt.Text.ToString(), "prodotti");
            img_Gest.CloneImages(NewIDProduct, CodArt1_Txt.Text.ToString(), "slide");
            //Response.Redirect("Articoli_Crud.aspx?Cod=" + NuovoCodice_Clona.Text);
            (source as ASPxCallback).JSProperties["cpRedirect"] = "Articoli_Crud.aspx?Cod=" + NuovoCodice_Clona.Text;
        }

        protected void PercentualPerPunti_spin_DataBinding(object sender, EventArgs e)
        {
            ASPxSpinEdit spin = (ASPxSpinEdit)sender;
            if (Request.QueryString["Cod"] != null)
            {
                Artiolo_Dts.SelectParameters["ProductCod"].DefaultValue = Request.QueryString["Cod"];
                DataView dvSql = (DataView)Artiolo_Dts.Select(DataSourceSelectArguments.Empty);
                for (int i = 0; i < dvSql.Count; i++)
                {
                    spin.Number = dvSql[i]["PuntiInPercentuale"] is DBNull ? 2 : Convert.ToInt32(dvSql[i]["PuntiInPercentuale"]);
                }
            }
        }
    }
}