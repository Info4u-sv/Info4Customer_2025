using DevExpress.Web;
using DevExpress.Web.ASPxHtmlEditor;
using info4lab;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.SessionState;
using WebService4u.Models;

namespace INTRA.Ticket
{
    public class UploadedFilesStorage_1
    {
        public string Path { get; set; }
        public string Key { get; set; }
        public DateTime LastUsageTime { get; set; }

        public IList<UploadedFileInfo_1> Files { get; set; }
    }
    public class UploadedFileInfo_1
    {
        public string UniqueFileName { get; set; }
        public string OriginalFileName { get; set; }
        public string FilePath { get; set; }
        public string FileSize { get; set; }
    }
    public static class UploadControlHelper
    {
        const int DisposeTimeout = 5;
        const string FolderKey = "UploadDirectory";
        const string TempDirectory = "~/UploadControl/Temp/";
        static readonly object storageListLocker = new object();

        static HttpContext Context { get { return HttpContext.Current; } }
        static string RootDirectory { get { return Context.Request.MapPath(TempDirectory); } }

        static IList<UploadedFilesStorage_1> uploadedFilesStorageList;
        static IList<UploadedFilesStorage_1> UploadedFilesStorageList
        {
            get
            {
                return uploadedFilesStorageList;
            }
        }

        static UploadControlHelper()
        {
            uploadedFilesStorageList = new List<UploadedFilesStorage_1>();
        }

        static string CreateTempDirectoryCore()
        {
            string uploadDirectory = Path.Combine(RootDirectory, Path.GetRandomFileName());
            Directory.CreateDirectory(uploadDirectory);

            return uploadDirectory;
        }
        public static UploadedFilesStorage_1 GetUploadedFilesStorageByKey(string key)
        {
            lock (storageListLocker)
            {
                return GetUploadedFilesStorageByKeyUnsafe(key);
            }
        }
        static UploadedFilesStorage_1 GetUploadedFilesStorageByKeyUnsafe(string key)
        {
            UploadedFilesStorage_1 storage = UploadedFilesStorageList.Where(i => i.Key == key).SingleOrDefault();
            if (storage != null)
                storage.LastUsageTime = DateTime.Now;
            return storage;
        }
        public static string GenerateUploadedFilesStorageKey()
        {
            return Guid.NewGuid().ToString("N");
        }
        public static void AddUploadedFilesStorage(string key)
        {
            lock (storageListLocker)
            {
                UploadedFilesStorage_1 storage = new UploadedFilesStorage_1
                {
                    Key = key,
                    Path = CreateTempDirectoryCore(),
                    LastUsageTime = DateTime.Now,
                    Files = new List<UploadedFileInfo_1>()
                };
                UploadedFilesStorageList.Add(storage);
            }
        }

        public static void RemoveOldStorages()
        {
            if (!Directory.Exists(RootDirectory))
                Directory.CreateDirectory(RootDirectory);

            lock (storageListLocker)
            {
                string[] existingDirectories = Directory.GetDirectories(RootDirectory);
                foreach (string directoryPath in existingDirectories)
                {
                    UploadedFilesStorage_1 storage = UploadedFilesStorageList.Where(i => i.Path == directoryPath).SingleOrDefault();
                    if (storage == null || (DateTime.Now - storage.LastUsageTime).TotalMinutes > DisposeTimeout)
                    {
                        Directory.Delete(directoryPath, true);
                        if (storage != null)
                            UploadedFilesStorageList.Remove(storage);
                    }
                }
            }
        }
        public static UploadedFileInfo_1 AddUploadedFileInfo(string key, string originalFileName)
        {
            UploadedFilesStorage_1 currentStorage = GetUploadedFilesStorageByKey(key);
            UploadedFileInfo_1 fileInfo = new UploadedFileInfo_1
            {
                FilePath = Path.Combine(currentStorage.Path, Path.GetRandomFileName()),
                OriginalFileName = originalFileName,
                UniqueFileName = GetUniqueFileName(currentStorage, originalFileName)
            };
            currentStorage.Files.Add(fileInfo);

            return fileInfo;
        }
        public static UploadedFileInfo_1 GetDemoFileInfo(string key, string fileName)
        {
            UploadedFilesStorage_1 currentStorage = GetUploadedFilesStorageByKey(key);
            return currentStorage.Files.Where(i => i.UniqueFileName == fileName).SingleOrDefault();
        }
        public static string GetUniqueFileName(UploadedFilesStorage_1 currentStorage, string fileName)
        {
            string baseName = Path.GetFileNameWithoutExtension(fileName);
            string ext = Path.GetExtension(fileName);
            int index = 1;

            while (currentStorage.Files.Any(i => i.UniqueFileName == fileName))
                fileName = string.Format("{0} ({1}){2}", baseName, index++, ext);

            return fileName;
        }
    }
    public partial class TCK_Insert : System.Web.UI.Page
    {

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            UploadControlHelper.RemoveOldStorages();
        }
        UploadedFilesStorage_1 UploadedFilesStorage
        {
            get { return UploadControlHelper.GetUploadedFilesStorageByKey(SubmissionID); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                //MotivoChiamata_Html.Toolbars.Add(CreateDemoCustomToolbar("CustomToolbar"));
                //MotivoChiamata_Html.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                //MotivoChiamata_Html.Toolbars["StandardToolbar1"].Visible = false;
                //MotivoChiamata_Html.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar2());
                //MotivoChiamata_Html.Toolbars["StandardToolbar2"].Visible = false;

                ASPxFormLayout ASPxFormLayout3 = (ASPxFormLayout)formlayout.FindControl("ASPxFormLayout3");
                ASPxUploadControl DocumentsUploadControl = (ASPxUploadControl)ASPxFormLayout3.FindControl("DocumentsUploadControl");
                ASPxLabel NoteUploader_lbl = (ASPxLabel)ASPxFormLayout3.FindControl("NoteUploader_lbl");
                var FileExtension = ".jpeg,.jpg,.png,.gif,.pdf";
                string LabelText = "{0} - {1} - {2}";
                LabelText = string.Format(LabelText, "Estensioni file consentite: " + FileExtension, "Dimensione massiva del file: " + DocumentsUploadControl.ValidationSettings.MaxFileSize, "Numero massimo di allegati: " + DocumentsUploadControl.ValidationSettings.MaxFileCount);
                NoteUploader_lbl.Text = LabelText;
                if (string.IsNullOrEmpty(FileExtension))
                {
                    FileExtension = ".jpeg,.jpg,.png,.gif,.pdf";
                }
                var Estensioni = FileExtension.Split(',');
                string[] EstensioniAmmesse = new string[Estensioni.Count()];


                for (int i = 0; i < Estensioni.Count(); i++)
                {
                    EstensioniAmmesse[i] = Estensioni[i];
                }

                Estensioni = new string[0];

                DocumentsUploadControl.ValidationSettings.AllowedFileExtensions = EstensioniAmmesse;
                SessionIDManager manager = new SessionIDManager();
                string newID = manager.CreateSessionID(Context);
                bool redirected = false;
                bool isAdded = false;
                manager.SaveSessionID(Context, newID, out redirected, out isAdded);


                Istanze_Generiche Get = new Istanze_Generiche();
                MembershipUser UserLog = Membership.GetUser();
                dynamic MyProfile = (ProfileBase)ProfileBase.Create(UserLog.UserName, true);

                Contatto_Txt_DX.Text = MyProfile.nome + " " + MyProfile.cognome;
                Telefono_Txt_DX.Text = MyProfile.Telefono;
                string[] NomeCampo = new string[1];
                NomeCampo[0] = "EmailContatto";
                string filtro = " UtenteIntranet = '" + UserLog.UserName + "'";
                string Tabella = "VIO_Utenti";
                string[] Email = Get.GetValue_Generic(NomeCampo, filtro, Tabella);
                Email_Txt_DX.Text = Email[0];
                DatiContatto_HF["Nome"] = MyProfile.nome + " " + MyProfile.cognome;
                DatiContatto_HF["Email"] = MyProfile.email;
                DatiContatto_HF["Telefono"] = MyProfile.Telefono;
                SubmissionID = UploadControlHelper.GenerateUploadedFilesStorageKey();
                UploadControlHelper.AddUploadedFilesStorage(SubmissionID);
            }
        }

        protected string SubmissionID
        {
            get
            {
                //nel page load c'è un submissionid che viene valorizzato, se non lo si mette darà questo errore
                //"La chiave specificata non era presente nel dizionario." Alessio
                return HfFile.Get("SubmissionID").ToString();
            }
            set
            {
                HfFile.Set("SubmissionID", value);
            }
        }

        protected void ASPxCallbackPanel1_Callback(object sender, CallbackEventArgsBase e)
        {
            if (Session["Ex"] != null)
                eRrore_Lbl.Text = Session["Ex"].ToString();
        }

        protected void AreaAss_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            //MembershipUser UserLog = Membership.GetUser();            
            //ProfileCommon MyProfile = (ProfileCommon)ProfileCommon.Create(UserLog.UserName, true);
            //if (MyProfile.AreaCompetenza != "0")
            //    rbtAreaAss.Value = MyProfile.AreaCompetenza;
            ////else
            ////    rbtAreaAss.SelectedIndex = 0;
        }
        protected void MotivoChiamata_CallbackPnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            //Portal4Set PortalConfig = new Portal4Set();

            //if ((Rbl_TCK_TipoEsecuzione.SelectedIndex == 0) || Convert.ToInt32(Rbl_TCK_TipoEsecuzione.SelectedItem.Value) == 1 || Convert.ToInt32(Rbl_TCK_TipoEsecuzione.SelectedItem.Value) == 5)
            //{
            //    if (ClientiComboBox.SelectedItem != null)
            //        InterventoPreso_Txt.Text = ClientiComboBox.SelectedItem.GetFieldValue("Denom").ToString() + " - " + ClientiComboBox.SelectedItem.GetFieldValue("Loc").ToString() + " - " + ClientiComboBox.SelectedItem.GetFieldValue("Ind").ToString();
            //    else
            //        InterventoPreso_Txt.Text = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
            //}
            //else
            //{

            //    InterventoPreso_Txt.Text = PortalConfig.GetConfigurationValue(Portal4Set.Settings.Company);
            //}
        }


        protected void DocumentsUploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            bool isSubmissionExpired = false;
            if (UploadedFilesStorage == null)
            {
                isSubmissionExpired = true;
                UploadControlHelper.AddUploadedFilesStorage(SubmissionID);
            }

            UploadedFileInfo_1 tempFileInfo = UploadControlHelper.AddUploadedFileInfo(SubmissionID, e.UploadedFile.FileName);

            e.UploadedFile.SaveAs(tempFileInfo.FilePath);

            if (e.IsValid)
                e.CallbackData = tempFileInfo.UniqueFileName + "|" + isSubmissionExpired;
        }


        protected void InserimentoTicket_Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            Webservice_primo_online.TCK_Ticket_WS TicketIstanza = new Webservice_primo_online.TCK_Ticket_WS();
            bool MailClienteInvioAbilita = false;
            bool.TryParse(ConfigurationManager.AppSettings["MailClienteInvioAbilita"], out MailClienteInvioAbilita);
            TicketIstanza.Società = ClientiComboBox.SelectedItem.GetFieldValue("Denom").ToString();
            TicketIstanza.CodCliente = ClientiComboBox.SelectedItem.GetFieldValue("CodCli").ToString();
            TicketIstanza.Indirizzo = "";
            TicketIstanza.Cap = "";
            TicketIstanza.Località = "";
            TicketIstanza.Provincia = "";
            TicketIstanza.PIva = "";
            TicketIstanza.Telefono = ClientiComboBox.SelectedItem.GetFieldValue("Tel").ToString();
            TicketIstanza.Fax = "";
            TicketIstanza.Email = Email_Txt_DX.Text;
            TicketIstanza.PersonaDaContattare = "";
            TicketIstanza.Allegati = FunzioniGenerali.MakeValidFileName(UploadedFilesTokenBox.Text);
            TicketIstanza.TCK_TipoRichiesta = 1;
            TicketIstanza.TCK_AreaCompetenza = Convert.ToInt32(rbtAreaAss.SelectedItem.Value);
            TicketIstanza.TCK_TipoEsecuzionePresunta = 5;
            TicketIstanza.TCK_TipoEsecuzione = 5;
            TicketIstanza.TCK_StatusChiamata = 1;
            TicketIstanza.TCK_PrioritaRichiesta = 1;
            TicketIstanza.MotivoChiamata = Motivo_Chiamata_Txt_DX.Text;

            //rapportini.MotivoChiamata = MotivoChiamata_Html.Html;
            TicketIstanza.NomePersonaRiferimento = Contatto_Txt_DX.Text;
            TicketIstanza.TelPersonaRiferimento = Telefono_Txt_DX.Text;
            TicketIstanza.MailPersonaRiferimento = Email_Txt_DX.Text;
            TicketIstanza.TCK_PrioritaRichiesta_etichetta = "STANDARD";
            TicketIstanza.TCK_AreaCompetenza_etichetta = rbtAreaAss.Text;
            TicketIstanza.TCK_TipoRichiesta_etichetta = "INTERVENTO";
            TicketIstanza.TCK_TipoEsecuzionePresunta_etichetta = "NON DEFINITO";
            TicketIstanza.TCK_TipoEsecuzione_etichetta = "NON DEFINITO";
            TicketIstanza.TCK_StatusChiamataChiusura = 1;
            TicketIstanza.TCK_StatusChiamataChiusura_Etichetta = "APERTO";
            TicketIstanza.InterventoChiuso = false;
            //if (!string.IsNullOrEmpty(txtDataIntervento.Text))
            //    rapportini.DataIntervento = txtDataIntervento.Text;
            //if (string.IsNullOrEmpty(txtNoteTecnico.Text))
            //{
            TicketIstanza.NoteTecnico = "";
            //}
            //else
            //{
            //    rapportini.NoteTecnico = txtNoteTecnico.Text;
            //}
            MembershipUser edtUsr = Membership.GetUser();
            TicketIstanza.EditUser = edtUsr.UserName;
            TicketIstanza.InterventoPresso = "";
            TicketIstanza.OggettoTCK = OggettoTck_Memo.Text;

            string SessionID = HttpContext.Current.Session.SessionID;
            AllegatiTck(TicketIstanza, SessionID);

            //WebReference4u.WebService_primo _WebS_primo = new WebReference4u.WebService_primo();
            Webservice_primo_online.WebService_primoSoapClient Ws = new Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");


            if (MailClienteInvioAbilita)
            {
                //questa procedura presente nel webservice inserisce il ticket ed invia la mail 
                int lastIdRapp = Ws.addTckCustomerArray(TicketIstanza, SessionID);

                TCK_Ticket FatturazioneFinale = new TCK_Ticket();
                FatturazioneFinale.CodRapportino = lastIdRapp;
                FatturazioneFinale.StatusControlloFatt = 9;
                FatturazioneFinale.NoteFatturazioneFinale = "";
                FatturazioneFinale.StatusControlloFatturazioneFinale = 1;
                FatturazioneFinale.ApprovatoDa = "";
                FatturazioneFinale.StatusControlloFatture_Update(FatturazioneFinale);

                TCK_Ticket Registrazione = new TCK_Ticket();
                Registrazione.CodRapportino = lastIdRapp;
                Registrazione.StatusControlloRegistrazione = 1;
                Registrazione.StatusControlloRegistrazione_Update(Registrazione);

                Session["lastIdRapp"] = lastIdRapp;
                Session["UltimoTecnicoAllegati"] = 1;
                TicketIstanza.CodRapportino = lastIdRapp;



                string NomeCampo = "PathFolder";
                string filtro = " [SessionID] = '" + SessionID + "'";
                string Tabella = "PRT_DocumentiTCK";
                try
                {
                    Istanze_Generiche Get = new Istanze_Generiche();
                    string[] Path = Get.GetValue_Generic_2(NomeCampo, filtro, Tabella);
                    Directory.CreateDirectory(Server.MapPath("/Public/AllegatiTCK/" + lastIdRapp));
                    var Paths = new DirectoryInfo(Server.MapPath("/Public/AllegatiTCK/" + SessionID));

                    for (int i = 0; i < Path.Count(); i++)
                    {
                        Directory.Move(Server.MapPath(Path[i]), Server.MapPath(Path[i].Replace(SessionID, lastIdRapp.ToString())));
                    }
                    Paths.Delete(true);






                    Istanze_Generiche Upd = new Istanze_Generiche();
                    string QueryAggiornamento = " PathFolder = REPLACE(PathFolder,'" + SessionID + "','" + lastIdRapp + "'), IdTicket = " + lastIdRapp + ", SessionID = '' ";
                    string NomeTabella = "PRT_DocumentiTCK";
                    string Filtro = " [SessionID] = '" + SessionID + "'";
                    Upd.UpdateDynamic(QueryAggiornamento, NomeTabella, Filtro);
                }
                catch (Exception ex)
                {
                    PRT_ErrorGest.ErrorLogSave(ex.ToString());
                }


                ASPxWebControl.RedirectOnCallback("/Ticket/TaskView_Custom.Aspx?IdTicket=" + lastIdRapp);
            }
        }

        protected void CancellazioneFile_Callback_Callback(object source, CallbackEventArgs e)
        {
            List<UploadedFileInfo_1> resultFileInfos = new List<UploadedFileInfo_1>();
            string description = "";
            bool allFilesExist = true;

            if (UploadedFilesStorage == null)
                UploadedFilesTokenBox.Tokens = new TokenCollection();

            foreach (string fileName in UploadedFilesTokenBox.Tokens)
            {
                UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                FileInfo fileInfo = new FileInfo(demoFileInfo.FilePath);

                if (fileInfo.Exists)
                {
                    demoFileInfo.FileSize = FormatSize(fileInfo.Length);
                    resultFileInfos.Add(demoFileInfo);
                }
                else
                    allFilesExist = false;
            }

            int NumeroFile = 0;
            foreach (UploadedFileInfo_1 fileInfo in resultFileInfos)
            {
                File.Delete(fileInfo.FilePath);
            }

            ASPxWebControl.RedirectOnCallback("/Ticket/TaskView_Custom.aspx?IdTicket=" + Session["lastIdRapp"]);
        }

        public static string FormatSize(object value)
        {
            double amount = Convert.ToDouble(value);
            string unit = "KB";
            if (amount != 0)
            {
                if (amount <= 1024)
                    amount = 1;
                else
                    amount /= 1024;

                if (amount > 1024)
                {
                    amount /= 1024;
                    unit = "MB";
                }
                if (amount > 1024)
                {
                    amount /= 1024;
                    unit = "GB";
                }
            }
            return String.Format("{0:#,0} {1}", Math.Round(amount, MidpointRounding.AwayFromZero), unit);
        }

        protected void ClientiComboBox_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (!HttpContext.Current.User.IsInRole("Administrator") && !HttpContext.Current.User.IsInRole("Info4u"))
                {
                    string username = User.Identity.Name;
                    string codCli = username.Split('-')[0];
                    ClientiComboBox.SelectedIndex = ClientiComboBox.Items.FindByValue(codCli).Index;
                    ClientiComboBox.ClientEnabled = false;
                }
                else
                {
                    ClientiComboBox.ClientEnabled = true;
                }
            }
            catch (Exception ex)
            {
                //Response.Redirect("_App_Offline");
            }

        }


        public void AllegatiTck(Webservice_primo_online.TCK_Ticket_WS GetTCK, string SessionID)
        {
            List<UploadedFileInfo_1> resultFileInfos = new List<UploadedFileInfo_1>();
            string description = "";
            bool allFilesExist = true;

            if (UploadedFilesStorage == null)
                UploadedFilesTokenBox.Tokens = new TokenCollection();

            foreach (string fileName in UploadedFilesTokenBox.Tokens)
            {
                UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                FileInfo fileInfo = new FileInfo(demoFileInfo.FilePath);

                if (fileInfo.Exists)
                {
                    demoFileInfo.FileSize = FormatSize(fileInfo.Length);
                    resultFileInfos.Add(demoFileInfo);
                }
                else
                    allFilesExist = false;
            }

            string FileAllegati = "/Public/AllegatiTCK/" + SessionID;
            MembershipUser UserLog = Membership.GetUser();
            Directory.CreateDirectory(Server.MapPath(FileAllegati));
            string pathfisico = Server.MapPath("/Public/AllegatiTCK/" + SessionID);
            Directory.CreateDirectory(pathfisico);

            int NumeroFile = 0;
            var rand = new Random();
            foreach (UploadedFileInfo_1 fileInfo in resultFileInfos)
            {
                NumeroFile += 1;
                string filename = fileInfo.OriginalFileName;
                string[] EstensioneFile = filename.Split('.');
                filename = NumeroFile.ToString() + "_" + rand.Next(1000) + "_" + FunzioniGenerali.MakeValidFileName(filename);
                string path = FileAllegati + "/" + filename;

                if (!File.Exists(Server.MapPath(path)))
                    File.Copy(fileInfo.FilePath, Server.MapPath(path));
                else
                {

                }

                //pathfisico = ConfigurationManager.AppSettings["PathAssolutoIntranet"] + "Public/AllegatiTCK/" + SessionID;
                //pathfisico = pathfisico + "/" + filename;
                //if (!File.Exists(pathfisico))
                //    File.Copy(fileInfo.FilePath, pathfisico);


                PRT_Documenti InsertDoc = new PRT_Documenti();
                InsertDoc.CodCli = GetTCK.CodCli;
                InsertDoc.SessionID = SessionID;
                InsertDoc.DisplayName = filename;
                InsertDoc.Description = GetTCK.OggettoTCK; //descrizione del ticket;

                InsertDoc.FileName = filename.Replace("." + EstensioneFile[1], "");
                InsertDoc.FileExtension = "." + EstensioneFile[1];
                InsertDoc.CreatedUser = UserLog.UserName;
                InsertDoc.PathFolder = path;
                InsertDoc.PRT_DocumentiTCK_Insert(InsertDoc);
            }

        }

        protected void DocumentsUploadControl_Init(object sender, EventArgs e)
        {

        }

        protected HtmlEditorToolbar CreateDemoCustomToolbar(string name)
        {
            return new HtmlEditorToolbar(
                name,
                new ToolbarFontNameEdit(),
                new ToolbarFontSizeEdit(),
                new ToolbarJustifyLeftButton(true),
                new ToolbarJustifyCenterButton(),
                new ToolbarJustifyRightButton(),
                new ToolbarJustifyFullButton(),
                new ToolbarUnderlineButton(),
                new ToolbarBoldButton()
            ).CreateDefaultItems();
        }
    }
}