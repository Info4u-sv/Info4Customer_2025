using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;

namespace INTRA.SuperAdmin
{
    public partial class Configurazione_Intranet : System.Web.UI.Page
    {
        public Dictionary<string, Color> rootColors
        {
            get
            {
                if (Session["rootColors"] == null)
                {
                    Session["rootColors"] = new Dictionary<string, Color>();
                }

                return Session["rootColors"] as Dictionary<string, Color>;
            }
        }

        public List<string> importantKeys
        {
            get
            {
                if (Session["ImportantColors"] == null)
                {
                    Session["ImportantColors"] = new List<string>();
                }

                return Session["ImportantColors"] as List<string>;
            }
        }
        protected string SubmissionID
        {
            get
            {
                return HfFile_Articolo.Get("SubmissionID").ToString();
            }
            set
            {
                HfFile_Articolo.Set("SubmissionID", value);
            }
        }

        UploadedFilesStorage_V1 UploadedFilesStorage2
        { get { return UploadControlHelper_V1.GetUploadedFilesStorageByKey(SubmissionID); } }

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            try
            {
                UploadControlHelper_V1.RemoveOldStorages();
            }
            catch
            {
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InizializzaColori();
                SubmissionID = UploadControlHelper_V1.GenerateUploadedFilesStorageKey();
                UploadControlHelper_V1.AddUploadedFilesStorage(SubmissionID);
                InizializzaNomeFile();
            }

            //CreateModelloAvvio();
            CreateColorEdit(ColorContainer_Pnl);
        }

        public void InizializzaColori()
        {
            string path = Server.MapPath(@"\assets\css\RootColor.css");
            List<string> lines = new List<string>();

            if (!File.Exists(path))
            {
                lines.Add("File non trovato");
            }
            else
            {
                rootColors.Clear();
                lines = File.ReadAllLines(path).ToList();
                lines.Remove(lines.First());
                lines.Remove(lines.Last());
                ColorConverter converter = new ColorConverter();

                foreach (string line in lines)
                {
                    string editabline = line;
                    string key = editabline.Split(':')[0].Trim();
                    if (editabline.Contains("!important"))
                    {
                        importantKeys.Add(key);
                        editabline = editabline.Replace("!important", string.Empty);
                    }
                    string col = editabline.Split(':')[1].Trim();

                    //Color color = Color.FromName(col);
                    try
                    {
                        Color color = (Color)converter.ConvertFromString(col.Remove(col.Length - 1));
                        rootColors.Add(key, color);
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.Message);
                    }
                    //Color color = (Color)converter.ConvertFromString(col);


                }
            }
        }


        public void CreateColorEdit(object ObjContainer)
        {
            ASPxCallbackPanel conteiner = (ASPxCallbackPanel)ObjContainer;
            Dictionary<string, Color>.KeyCollection keys = rootColors.Keys;
            //int count = 0;
            foreach (string key in keys)
            {
                ASPxColorEdit colorEdit = new ASPxColorEdit();
                Color color = rootColors[key];
                colorEdit.ID = key.Replace("-", "_");
                colorEdit.ClientInstanceName = key.Replace("-", "_");
                colorEdit.Caption = key;
                colorEdit.Color = color;
                //colorEdit.ClientSideEvents.ColorChanged = "OnColorchanged";
                conteiner.Controls.Add(colorEdit);
            }

        }


        protected void ColorContainer_Pnl_Callback(object sender, CallbackEventArgsBase e)
        {
            ASPxCallbackPanel container = (ASPxCallbackPanel)sender;
            string path = Server.MapPath(@"\assets\css\RootColor.css");
            StreamWriter sw = new StreamWriter(path);

            sw.WriteLine(":root {");

            foreach (string key in rootColors.Keys)
            {
                string ID = key.Replace("-", "_");
                ASPxColorEdit colorEdit = (ASPxColorEdit)container.FindControl(ID);

                if (colorEdit != null)
                {
                    ColorConverter converter = new ColorConverter();
                    string color = colorEdit.Text;
                    string important = importantKeys.Contains(key) ? "!important" : string.Empty;
                    sw.WriteLine($"{key} : {color} {important};");
                }
            }

            sw.Write("}");
            sw.Close();

        }

        protected void ArticoloImg_UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string fileName = e.UploadedFile.FileName.ToString();
            bool submissionExpire = false;
            if (UploadedFilesStorage2 == null)
            {
                submissionExpire = true;
                UploadControlHelper_V1.AddUploadedFilesStorage(SubmissionID);
            }
            UploadedFileInfo_V1 fileInfoTemp = UploadControlHelper_V1.AddUploadedFileInfo(SubmissionID, fileName.Replace(".tif", ".jpg"));
            string xxx = fileInfoTemp.FilePath;
            string yyy = fileInfoTemp.UniqueFileName;
            e.UploadedFile.SaveAs(fileInfoTemp.FilePath);

            if (e.IsValid)
            {
                e.CallbackData = fileName + "|" + submissionExpire + "|ArticoloImg_Token";
            }
        }

        protected void uploadCallBackPanel_Callback(object sender, EventArgs e)
        {
            string UploadDirectory = "/assets/img_customer/";
            List<UploadedFileInfo_V1> resultFileInfos = new List<UploadedFileInfo_V1>();
            foreach (string fileName in ArticoloImg_Token.Tokens)
            {
                string nomeFile;
                UploadedFileInfo_V1 demoFileInfo = UploadControlHelper_V1.GetDemoFileInfo(SubmissionID, fileName);
                //FileInfo fileInfo = new FileInfo(demoFileInfo.FilePath); 
                if (!string.IsNullOrEmpty(Nome_File_Cb.Value as string))
                {
                    nomeFile = Nome_File_Cb.Value.ToString();
                }
                else
                {
                    nomeFile = fileName;
                }
                string path = Server.MapPath(UploadDirectory + nomeFile);

                if (File.Exists(path))
                {
                    //File.Delete(path);
                    //File.Copy(demoFileInfo.FilePath, path);
                    File.Replace(demoFileInfo.FilePath, path, Server.MapPath("\\assets\\img_customer_backup\\" + nomeFile));
                }
                else
                {
                    File.Copy(demoFileInfo.FilePath, path);
                }


                //if (fileInfo.Exists)
                //{
                //    demoFileInfo.FileSize = Utils.FormatSize(fileInfo.Length);
                //    resultFileInfos.Add(demoFileInfo);
                //}

            }

            //if(resultFileInfos.Count > 0)
            //{
            //    UploadControlHelper_V1.RemoveUploadedFilesStorage(SubmissionID);
            //}
        }

        //public void CreateModelloAvvio()
        //{
        //    string queryString = "SELECT Value, CodParam FROM LFT_Parameter WHERE CodParam = 'Check4uModel'";
        //    string connectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ToString();
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        SqlCommand command = new SqlCommand(queryString, connection);
        //        connection.Open();
        //        SqlDataReader reader = command.ExecuteReader();
        //        try
        //        {
        //            while (reader.Read())
        //            {
        //                if (reader["CodParam"].ToString() == "Check4uModel")
        //                {
        //                    string s = reader["Value"].ToString();
        //                    cambiaPulsantiModelloAvvio(s);
        //                }
        //            }
        //        }
        //        catch { }
        //    }
        //}

        //protected void ModelloAvvio_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        //{
        //    TypeCustomGrid.AutoFilterByColumn(TypeCustomGrid.Columns[2], "");
        //    string s = e.Parameter.ToString();
        //    cambiaPulsantiModelloAvvio(s);
        //    Sql4PortalHelper objSqlHelper = new Sql4PortalHelper();
        //    SqlParameter[] objParams = new SqlParameter[2];
        //    objParams[0] = new SqlParameter("@CodParam", "Check4uModel");
        //    objParams[1] = new SqlParameter("@Value", s);
        //    objSqlHelper.ExecuteNonQueryForNews("LFT_Parameter_Update", objParams);

        //    for (int i = 0; i < TypeCustomGrid.VisibleRowCount; i++)
        //    {
        //        string[] fields = { "Tipo", "Parametro", "Valore" };
        //        object[] values = TypeCustomGrid.GetRowValues(i, fields) as object[];
        //        if ((string)values[0] == s)
        //        {
        //            objParams[0] = new SqlParameter("@CodParam", (string)values[1]);
        //            objParams[1] = new SqlParameter("@Value", (string)values[2]);
        //            objSqlHelper.ExecuteNonQueryForNews("LFT_Parameter_Update", objParams);
        //        }
        //    }
        //    TypeCustomGrid.AutoFilterByColumn(TypeCustomGrid.Columns[2], s);
        //}

        //public void cambiaPulsantiModelloAvvio(string s)
        //{
        //    switch (s)
        //    {
        //        case "Clienti":
        //            {
        //                ModAvvioClientiBtn.ClientEnabled = false;
        //                ModAvvioImpiantiBtn.ClientEnabled = true;
        //                ModAvvioImpiantiAscensoristiBtn.ClientEnabled = true;
        //            }
        //            break;
        //        case "Impianti":
        //            {
        //                ModAvvioClientiBtn.ClientEnabled = true;
        //                ModAvvioImpiantiBtn.ClientEnabled = false;
        //                ModAvvioImpiantiAscensoristiBtn.ClientEnabled = true;
        //            }
        //            break;
        //        case "Ascensoristi":
        //            {
        //                ModAvvioClientiBtn.ClientEnabled = true;
        //                ModAvvioImpiantiBtn.ClientEnabled = true;
        //                ModAvvioImpiantiAscensoristiBtn.ClientEnabled = false;
        //            }
        //            break;
        //        default:
        //            {
        //                ModAvvioClientiBtn.ClientEnabled = true;
        //                ModAvvioImpiantiBtn.ClientEnabled = true;
        //                ModAvvioImpiantiAscensoristiBtn.ClientEnabled = true;
        //            }
        //            break;
        //    }
        //}
        public void InizializzaNomeFile()
        {
            List<string> fileItems = new List<string>();

            //fileItems.Add("brand-logo-report.jpg");
            string folderPath = @"\\192.168.156.78\inetpub\CHECK4U_CURTI_VITALE_SRL\CHECK4U_CURTI_INTRA_V3_1_DX_22_1_5\INTRA\assets\img_customer\";

            string[] fileNames = Directory.GetFiles(folderPath);
            foreach (string fileName in fileNames)
            {
                string fileExtension = Path.GetExtension(fileName).ToLower();
                if (fileExtension == ".jpg" || fileExtension == ".png")
                {
                    string name = Path.GetFileName(fileName);
                    fileItems.Add(name);
                }
            }

            Nome_File_Cb.DataSource = fileItems;
            Nome_File_Cb.DataBind();
        }
    }
}