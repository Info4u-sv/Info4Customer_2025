using DevExpress.Web;
using DevExpress.Web.ASPxHtmlEditor;
using INTRA.AppCode;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;

namespace INTRA.Controls
{
    public partial class InserimentoProspect : System.Web.UI.UserControl
    {
        /*  Come gestire il passaggio dei callback all'ascx.
            L'inserimento è gestito da una stringa composta dai nomi dei callback separati dal carattere '|'
            Ci sono due proprietà booleane:
            -IsMultiCallback = per definire se il callback è più di uno 
            -LastIsDbCallback  = per indicare se l'ultimo callback è utilizzato per gestire il passaggio dei dati al database */

        public string PaginaRchiamante { get; set; }

        public bool ShowLastPopUp { get; set; }

        public bool HasCallback { get; set; }

        public string CallBackClientIstansName { get; set; } = null;

        public bool IsMultiCallback { get; set; }

        public bool LastIsDbCallback { get; set; }

        public string GridToRefresh { get; set; }

        protected string SubmissionID
        {
            get { return HfFile.Get("SubmissionID").ToString(); }
            set { HfFile.Set("SubmissionID", value); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PIva_text.JSProperties["cp_ValidazionePiva"] = "0";
                Session["NomeProspectSess"] = string.Empty;
                if (!HasCallback)
                {
                    ProspectDuplicato_CallbackPnl.JSProperties["cp_Callbacks"] = "NoUse"; //used to set permanently the SelectProspect_Btn not visible from the client side if we don't have inserted callbacks in the ascx
                    CodDoc_div.Visible = false;
                }
                try
                {
                    GridName_txt.Text = GridToRefresh;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                }
                //InserimentoArticolo_Popup.HeaderText = (int)Session["IsProspect"] == 1 ? "Inserimento Prospect" : "Inserimento Cliente";
            }
        }

        protected void Page_PreLoad(object sender, EventArgs e)
        {
        }

        protected void Salvataggio_Callback_Callback(object source, CallbackEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            CRM4U_Prospect_Customer_CRUD ObjCRM4U = new CRM4U_Prospect_Customer_CRUD();
            ObjCRM4U.Denom = Denom_text.Text;
            ObjCRM4U.Ind = Indirizzo_Txt.Text;
            ObjCRM4U.Prov = Provincia_Combobox.SelectedItem.Text.ToString();
            ObjCRM4U.Loc = Local_Txt.Text;
            ObjCRM4U.Tel = string.IsNullOrEmpty(Tel_text.Text) ? null : Tel_text.Text;
            ObjCRM4U.PIva = string.IsNullOrEmpty(PIva_text.Text) ? null : PIva_text.Text;
            ObjCRM4U.Cap = Cap_text.Text;
            ObjCRM4U.Referente = string.IsNullOrEmpty(Referente_txt.Text) ? null : Referente_txt.Text;
            ObjCRM4U.U_CodAge = CodAge_Combox.SelectedItem.Value.ToString();
            ObjCRM4U.CF = CF_Txt.Text;

            ObjCRM4U.Email = EMail_text.Text;
            ObjCRM4U.CodNaz = Nazione_Combox.SelectedItem.Value.ToString();
            ObjCRM4U.IsProspect = isPropect_txt.Text == "Prospect";
            HttpCookie myCookie = new HttpCookie("NuovoProspect");
            string IDNuovoProspect = string.Empty;

            IDNuovoProspect = ObjCRM4U.CRM4U_Prospect_Insert(ObjCRM4U).ToString();

            myCookie.Value = IDNuovoProspect;
            myCookie.Expires = DateTime.Now.AddDays(360d);
            HttpContext.Current.Response.Cookies.Add(myCookie);

            FormsAuthentication.SetAuthCookie(UserLog.UserName, false);
            Session["IdProspectInserito_Sess"] = IDNuovoProspect;
            Session["NomeProspectSess"] = Denom_text.Text;
            if (HasCallback)
            {
                e.Result = "Show";
            }
            else
            {
                e.Result = "Hide";
            }
        }

        protected void ProspectInserito_Callbackpnl_Callback(object sender, CallbackEventArgsBase e)
        { Prospect_Lbl.Text = Session["NomeProspectSess"].ToString(); }


        protected void Commerciale_Combobox_DataBound(object sender, EventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            bool CommercialeCheck = Roles.IsUserInRole(UserLog.UserName, "Commerciale");
            var Combobox = (ASPxComboBox)sender;

            if (CommercialeCheck)
            {
                Combobox.ClientEnabled = false;

                for (int i = 0; i < Combobox.Items.Count; i++)
                {
                    if (Combobox.Items[i].GetFieldValue("UtenteIntranet").ToString().ToUpper() ==
                        UserLog.UserName.ToUpper())
                    {
                        Combobox.Items[i].Selected = true;
                    }
                }
            }
        }

        protected void DescrizioneProspect_Html_Load(object sender, EventArgs e)
        {
            ASPxHtmlEditor HtmlEditor = sender as ASPxHtmlEditor;
            HtmlEditor.Toolbars.Add(CreateDemoCustomToolbar("CustomToolbar"));
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
                new ToolbarBoldButton(),
                new ToolbarPasteButton(),
                new ToolbarPasteFromWordButton()).CreateDefaultItems();
        }

        protected void PIva_Txt_Validation(object sender, ValidationEventArgs e)
        {
        }

        protected void Piva_Callbackpnl_Callback(object sender, CallbackEventArgsBase e)
        {
            string Esiste = info4lab.FunzioniGenerali
                .ValidazioneCampo(
                    "PIva",
                    " PIva = '" + PIva_text.Text + "' and Eliminato = 0 ",
                    "CRM4U_Prospect_Clienti");

            if (PIva_text.Text != string.Empty)
            {
                if (Esiste == "1")
                {
                    PIva_text.JSProperties["cp_ValidazionePiva"] = "0";
                }
                else
                {
                    if (PIva_text.Text != string.Empty)
                    {
                        PIva_text.JSProperties["cp_ValidazionePiva"] = "1";
                    }
                    else
                    {
                        PIva_text.JSProperties["cp_ValidazionePiva"] = "0";
                    }
                }
            }
            else
            {
                PIva_text.JSProperties["cp_ValidazionePiva"] = "0";
            }


            //PIva_Txt.JSProperties["cp_ValidazionePiva"] = "1";
        }

        protected void UploadDoc_UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            //string PathDirectory = "/CRM4U/Prospect/BDV/" + Request.QueryString["ID"];
            //Directory.CreateDirectory(Server.MapPath(PathDirectory));
            //int NumeroRandom = RandomNumber();
            //string path = PathDirectory + "/" + NumeroRandom + "_" + "_" + e.UploadedFile.FileName;

            //using (var fileStream = File.Create(Server.MapPath(path)))
            //{
            //    e.UploadedFile.FileContent.Seek(0, SeekOrigin.Begin);
            //    e.UploadedFile.FileContent.CopyTo(fileStream);
            //}

            //DocDaAllegareOfferta_Dts.InsertParameters["Path"].DefaultValue = e.UploadedFile.FileContent;
            //DocDaAllegareOfferta_Dts.InsertParameters["NomeFile"].DefaultValue = e.UploadedFile.FileName;
            //DocDaAllegareOfferta_Dts.InsertParameters["IDOfferta"].DefaultValue = Request.QueryString["ID"];
            //DocDaAllegareOfferta_Dts.InsertParameters["UserLog"].DefaultValue = UserLog.UserName;
            //DocDaAllegareOfferta_Dts.Insert();

            CRM4U_Prospect_Customer_CRUD getAge = new CRM4U_Prospect_Customer_CRUD();
            MembershipUser UserLog = Membership.GetUser();


            byte[] myFile = new byte[e.UploadedFile.FileContent.Length + 1];
            e.UploadedFile.FileContent.Read(myFile, 0, Convert.ToInt32(e.UploadedFile.FileContent.Length));
            //Image newImage;
            //using (var ms = new MemoryStream(myFile))
            //{
            //    newImage = Image.FromStream(ms);
            //}

            string strcon = System.Configuration.ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(strcon);
            connection.Open();
            SqlCommand cmd = new SqlCommand(
                "INSERT INTO CRM4U_Prospect_Clienti(Prospect, U_ImgBigliettoVisita2, U_CodAge, DataUltAgg) VALUES(0, @ImgBigliettoVisita, @CodAge, GETDATE())",
                connection);
            cmd.Parameters.Add("@CodAge", SqlDbType.NVarChar, 20).Value = getAge.CRM4U_CodAge_Get(UserLog.UserName);
            cmd.Parameters.Add("@ImgBigliettoVisita", SqlDbType.Image).Value = myFile;
            cmd.ExecuteNonQuery();
            connection.Close();
            //string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            //string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
            //string resultFileUrl = PathDirectory + resultFileName;
            //string resultFilePath = MapPath(resultFileUrl);
            //e.UploadedFile.SaveAs(resultFilePath);

            //UploadingUtils.RemoveFileWithDelay(resultFileName, resultFilePath, 5);

            //string name = e.UploadedFile.FileName;
            //string url = ResolveClientUrl(resultFileUrl);
            //long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
            //string sizeText = sizeInKilobytes.ToString() + " KB";
            //e.CallbackData = name + "|" + url + "|" + sizeText;
        }

        //public Image byteArrayToImage(byte[] byteArrayIn)
        //{
        //    try
        //    {
        //        MemoryStream ms = new MemoryStream(byteArrayIn, 0, byteArrayIn.Length);
        //        ms.Write(byteArrayIn, 0, byteArrayIn.Length);
        //        returnImage = Image.FromStream(ms, true);//Exception occurs here
        //    }
        //    catch { }
        //    return returnImage;
        //}
        protected void UploadBigliettoDaVisita_Callbackpnl_Callback(object sender, CallbackEventArgsBase e)
        {
        }

        protected void ProspectGiaInserito_Grw_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        { ProspectGiaInserito_Grw.DataBind(); }

        protected void ProspectDuplicato_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            string IdProspect = string.Empty;
            string CodNaz = string.Empty;
            string result = string.Empty;
            switch (e.Parameter)
            {
                case "ButtonPressed":
                    int index = ProspectGiaInserito_Grw.FocusedRowIndex;
                    IdProspect = ProspectGiaInserito_Grw.GetRowValues(index, "IDProspect").ToString();
                    CodNaz = ProspectGiaInserito_Grw.GetRowValues(index, "CodNaz").ToString();
                    result = IdProspect + "|" + CodNaz;
                    GetCallBacks(IsMultiCallback, result);
                    break;

                case "Go":
                    ProspectDuplicato_CallbackPnl.JSProperties["cp_Callbacks"] = string.Empty;
                    break;
                case "Insert":
                    COB_King_ControlliGenerali controls = new COB_King_ControlliGenerali();
                    CodNaz = controls.GetCodNazProspect(Convert.ToInt32(Session["IdProspectInserito_Sess"]));
                    result = Session["IdProspectInserito_Sess"] + "|" + CodNaz;
                    GetCallBacks(IsMultiCallback, result);
                    break;

                default:
                    Session["NomeProspectSess"] = e.Parameter;
                    break;
            }
        }


        protected void GetCodDoc_Callback_Callback(object source, CallbackEventArgs e)
        {
            COB_King_ControlliGenerali GetCodDoc = new COB_King_ControlliGenerali();
            string CodDoc = GetCodDoc.GetCodDocFromNazione(e.Parameter, "Offerta");
            e.Result = CodDoc;
        }

        protected void SelectedProspect_Callback_Callback(object source, CallbackEventArgs e)
        {
            int index = ProspectGiaInserito_Grw.FocusedRowIndex;
            string IdProspect = ProspectGiaInserito_Grw.GetRowValues(index, "IDProspect").ToString();
            string CodNaz = ProspectGiaInserito_Grw.GetRowValues(index, "CodNaz").ToString();
            string result = IdProspect + "|" + CodNaz;
        }

        protected void GetCallBacks(bool isMultiCallback, string parameter)
        {
            string callbaks = string.Empty;
            string showLastPopUp = string.Empty;
            if (HasCallback)
            {
                if (ShowLastPopUp)
                {
                    showLastPopUp = "y";
                }
                else
                {
                    showLastPopUp = "n";
                }
                ProspectInserito_Callbackpnl.JSProperties["cp_show"] = showLastPopUp;
                if (isMultiCallback)
                {
                    if (LastIsDbCallback)
                    {
                        callbaks = "M|" + CallBackClientIstansName + "|P|" + parameter + "|S";
                        ProspectDuplicato_CallbackPnl.JSProperties["cp_Callbacks"] = callbaks;
                    }
                    else
                    {
                        callbaks = "M|" + CallBackClientIstansName + "|P|" + parameter + "|N";
                        ProspectDuplicato_CallbackPnl.JSProperties["cp_Callbacks"] = callbaks;
                    }
                }
                else
                {
                    callbaks = "S|" + CallBackClientIstansName + "|P|" + parameter;
                    ProspectDuplicato_CallbackPnl.JSProperties["cp_Callbacks"] = callbaks;
                }
            }
            else
            {
                ProspectDuplicato_CallbackPnl.JSProperties["cp_Callbacks"] = "NoCallbacks";
            }
        }

        protected void ProspectGiaInserito_Grw_CustomJSProperties(
            object sender,
            ASPxGridViewClientJSPropertiesEventArgs e)
        { e.Properties["cp_RowCount"] = ((ASPxGridView)sender).VisibleRowCount; }


    }
}