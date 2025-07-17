using DevExpress.Web;
using INTRA.Age_Ordini.AppCode;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace INTRA.Age_Ordini.BR_Documenti
{
    public partial class Default_2 : System.Web.UI.Page
    {
        const string UploadDirectory = "~/Brico_Documenti/UploadedDoc/";
        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            int IdDoc = 0;
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = e.UploadedFile.FileName.Replace(resultExtension, "");
            string resultFileUrl = UploadDirectory + e.UploadedFile.FileName;
            string resultFilePath = MapPath(resultFileUrl);
            e.UploadedFile.SaveAs(resultFilePath);
            //UploadingUtils.RemoveFileWithDelay(resultFileName, resultFilePath, 5);
            string name = e.UploadedFile.FileName;
            string url = ResolveClientUrl(resultFileUrl);
            long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
            string sizeText = sizeInKilobytes.ToString() + " KB";
            e.CallbackData = name + "|" + url + "|" + sizeText;
            PRT_Documenti Doc = new PRT_Documenti();
            Doc.CLCCLI = "INTERNI";
            Doc.PathFolder = resultFileUrl;
            if (string.IsNullOrEmpty(TitoloDoc_Txt.Text)) { Doc.DisplayName = name; } else { Doc.DisplayName = TitoloDoc_Txt.Text; }
            if (string.IsNullOrEmpty(DescrizioneDoc_HtmlEdit.Html)) { Doc.Description = ""; } else { Doc.Description = DescrizioneDoc_HtmlEdit.Html; }
            Doc.CategoryId = 2;
            Doc.Tags = "";
            Doc.CreatedUser = UserLog.UserName;
            Doc.ITBook = false;
            Doc.ITBK_Description = "";
            Doc.ITBK_DisplayName = "";
            IdDoc = Doc.PRT_Documenti_Insert(Doc);
            SiteMaster.ShowToastr(Page, "Operazione Eseguita!", "Conferma", "Success", false, "toast-top-right", false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            MembershipUser UserLog = Membership.GetUser();
            string Name = UserLog.UserName.ToUpper();
            if (Name.Contains("AGE_"))
            {
                ASPxGridView1.Visible = true;
                Panel1.Visible = false;
            }
            else
            {
                ASPxGridView1.Visible = false;
                Panel1.Visible = true;
            }
        }

    }
}