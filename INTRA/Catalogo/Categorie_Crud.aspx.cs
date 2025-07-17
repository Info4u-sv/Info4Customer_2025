using DevExpress.CodeParser;
using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
//using DevExpress.XtraSpreadsheet.Utils.Trees;
using Info4U.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.WebControls;
using static INTRA.AppCode.UploadedFile_DX;

namespace INTRA.Catalogo
{
    public partial class Categorie_Crud : System.Web.UI.Page
    {
        private readonly string UploadDirectory = "/PUBLIC/CategoCatalogo/";


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
                Session["PictureIDSess"] = null;
                Session["IsPadre"] = null;
                Session["ParentID"] = null;
            }
        }
        protected void TreeListMenu_NodeInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            if (Session["ParentID"] == null || Session["ParentID"].ToString() == "0")
            {
                e.NewValues["ParentCategoryID"] = 0;
                e.NewValues["LevelCategory"] = 0;
            }
            else
            {
                e.NewValues["ParentCategoryID"] = Session["ParentID"];
                e.NewValues["LevelCategory"] = 1;
            }

            ASPxTokenBox UploadedFilesTokenBox = (ASPxTokenBox)TreeListMenu.FindEditFormTemplateControl("UploadedFilesTokenBox");
            if (UploadedFilesTokenBox != null)
            {
                foreach (string fileName in UploadedFilesTokenBox.Tokens)
                {
                    UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                    if (demoFileInfo != null)
                    {
                        if (!File.Exists(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString())))
                        {
                            File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                            e.NewValues["PathImmagine"] = Session["PathImmagineSess"].ToString();
                            AppoggioImg_Sql.InsertParameters["PathImmagine"].DefaultValue = Session["PathImmagineSess"].ToString();
                            _ = AppoggioImg_Sql.Insert();
                            e.NewValues["PictureID"] = Session["PictureIDSess"];
                            UploadControlHelper.RemoveUploadedFilesStorage(SubmissionID);
                        }
                    }
                }
            }

        }

        protected void TreeListMenu_CommandColumnButtonInitialize(object sender, DevExpress.Web.ASPxTreeList.TreeListCommandColumnButtonEventArgs e)
        {
            ASPxTreeList tl = sender as ASPxTreeList;
            if (e.NodeKey != null)
            {
                TreeListNode node = tl.FindNodeByKeyValue(e.NodeKey);
                if (node.Level == 2)
                {
                    if (e.ButtonType == DevExpress.Web.ASPxTreeList.TreeListCommandColumnButtonType.New )
                    {
                        e.Visible = DevExpress.Utils.DefaultBoolean.False;
                    }

                    if (e.CustomButtonIndex >= 0)
                    {
                        e.Visible = DevExpress.Utils.DefaultBoolean.False;
                    }
                }

            }

        }

        protected void TreeListMenu_StartNodeEditing(object sender, TreeListNodeEditingEventArgs e)
        {

            //SubmissionID = UploadControlHelper.GenerateUploadedFilesStorageKey();
            //UploadControlHelper.AddUploadedFilesStorage(SubmissionID);
            Session["PathImmagineSess"] = string.Empty;
            Session["PictureIDSess"] = null;

            //ASPxTreeList tl = sender as ASPxTreeList;
            //if (e.NodeKey != null)
            //{
            //    TreeListNode node = tl.FindNodeByKeyValue(e.NodeKey);
            //    if (node.Level < 2)
            //    {
            //        tl.Columns["CodRicambio"].Visible = false;
            //        tl.Columns["DescrizioneRidotta"].Visible = false;
            //        tl.Columns["DescrizioneRicambio"].Visible = false;
            //        tl.Columns["UM"].Visible = false;
            //    }
            //}
            //ASPxTreeList aSPxTreeList = sender as ASPxTreeList;
            //if (aSPxTreeList.IsNewNodeEditing)
            //{
            //    //ASPxComboBox comboBoxCat = aSPxTreeList.FindEditFormTemplateControl("CatM_Cmb") as ASPxComboBox;
            //    ASPxTextBox textCat = aSPxTreeList.FindEditFormTemplateControl("CatM_Txt") as ASPxTextBox;
            //    if (aSPxTreeList.FocusedNode != null && aSPxTreeList.FocusedNode.ParentNode != null)
            //    {
            //        textCat.Text = "000";
            //        textCat.ClientEnabled = false;
            //        //    if (comboBoxCat != null)
            //        //    {
            //        //        comboBoxCat.Items.Add("000", "-");
            //        //        comboBoxCat.Value = "000";
            //        //        comboBoxCat.ClientEnabled = false;
            //        //    }
            //    }
            //}
        }

        protected void TreeListMenu_CellEditorInitialize(object sender, TreeListColumnEditorEventArgs e)
        {
        }

        protected void Generic_SqlDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            //Session["IDNuovaRigaInserita"] = Convert.ToInt32(e.Command.Parameters["@ReturnID"].Value);
        }

        protected void TreeListMenu_DataBound(object sender, EventArgs e)
        {

            //bool defaultNodes = (Session[treeList.UniqueID + "_Sort"] == null);
            //ICollection<TreeListNode> allNodes = treeList.GetAllNodes();

            //if (defaultNodes)
            //{
            //    Dictionary<string, int> nodeOrder = new Dictionary<string, int>();
            //    foreach (TreeListNode node in allNodes)
            //    {
            //        string parentKey = (node.ParentNode == null) ? String.Empty : node.ParentNode.Key;
            //        int order = 0;
            //        if (nodeOrder.ContainsKey(parentKey))
            //            order = ++nodeOrder[parentKey];
            //        else
            //            nodeOrder[parentKey] = order;
            //        node.SetValue("DisplayOrder", order);
            //    }

            //    Dictionary<string, int> SortIndex = new Dictionary<string, int>();
            //    foreach (TreeListNode node in allNodes)
            //    {
            //        SortIndex.Add(node.Key, (int)node.GetValue("DisplayOrder"));
            //    }
            //    Session[treeList.UniqueID + "_Sort"] = SortIndex;
            //}
            //else
            //{
            //    Dictionary<string, int> SortIndex = Session[treeList.UniqueID + "_Sort"] as Dictionary<string, int>;
            //    foreach (TreeListNode node in allNodes)
            //    {
            //        node.SetValue("DisplayOrder", SortIndex[node.Key]);
            //    }
            //}

            //treeList.SortBy(treeList.Columns["DisplayOrder"] as TreeListDataColumn, ColumnSortOrder.Ascending);
        }

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UploadControlHelper.RemoveOldStorages();
            }
        }

        private UploadedFilesStorage_1 UploadedFilesStorage => UploadControlHelper.GetUploadedFilesStorageByKey(SubmissionID);
        protected void DocumentsUploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            if (UploadedFilesStorage == null)
            {
                UploadControlHelper.AddUploadedFilesStorage(SubmissionID);
            }
            string fileName = NormalizeFilename(e.UploadedFile.FileName.Replace(".tif", ".jpg"));
            UploadedFileInfo_1 tempFileInfo = UploadControlHelper.AddUploadedFileInfo(SubmissionID, fileName);
            
            ASPxUploadControl DocumentsUploadControl = sender as ASPxUploadControl;
            e.UploadedFile.SaveAs(tempFileInfo.FilePath);
            Random rnd = new Random();
            int number = rnd.Next(1, 99999);
            if (e.IsValid)
            {
                string fileNameNorm = e.UploadedFile.FileName;
                e.CallbackData = fileName;
                DocumentsUploadControl.JSProperties["cpPathImmagine"] = tempFileInfo.FilePath;
                Session["PathImmagineSess"] = UploadDirectory + number + "_" + fileName;
            }

        }
        protected string NormalizeFilename(string file)
        {
            string normalizeFilename = Regex.Replace(file, @"[^\w.-]+", "_");
            return normalizeFilename.Trim().ToLower();
        }
        protected void TreeListMenu_NodeUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxTokenBox UploadedFilesTokenBox = (ASPxTokenBox)TreeListMenu.FindEditFormTemplateControl("UploadedFilesTokenBox");
            if (UploadedFilesTokenBox != null)
            {

                foreach (string fileName in UploadedFilesTokenBox.Tokens)
                {
                    UploadedFileInfo_1 demoFileInfo = UploadControlHelper.GetDemoFileInfo(SubmissionID, fileName);
                    if (demoFileInfo != null)
                    {
                        _ = HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString());
                        if (!File.Exists(HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString())))
                        {
                            File.Move(demoFileInfo.FilePath, HttpContext.Current.Server.MapPath(Session["PathImmagineSess"].ToString()));
                            e.NewValues["PathImmagine"] = Session["PathImmagineSess"].ToString();
                            AppoggioImg_Sql.InsertParameters["PathImmagine"].DefaultValue = Session["PathImmagineSess"].ToString();
                            _ = AppoggioImg_Sql.Insert();
                            e.NewValues["PictureID"] = Session["PictureIDSess"];
                            UploadControlHelper.RemoveUploadedFilesStorage(SubmissionID);
                        }
                    }
                }
            }
            if (e.NewValues["PathImmagine"] != null && e.NewValues["PathImmagine"].ToString() != string.Empty)
            {
                if (e.NewValues["PathImmagine"].ToString() == string.Empty && UploadedFilesTokenBox.Tokens.Count == 0)
                {
                    e.NewValues["PictureID"] = 0;
                    AppoggioImg_Sql.DeleteParameters["PictureID"].DefaultValue = e.OldValues["PictureID"].ToString();
                    _ = AppoggioImg_Sql.Delete();
                }

            }

            //e.NewValues["NameRw"] = FunzioniGenerali.RewriteString(e.NewValues["DisplayName"].ToString());

        }

        protected void AppoggioImg_Sql_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            Session["PictureIDSess"] = Convert.ToInt32(e.Command.Parameters["@IDImmagine"].Value);
        }

        protected void TreeListMenu_CustomJSProperties(object sender, TreeListCustomJSPropertiesEventArgs e)
        {
            ASPxTreeList Treelist = sender as ASPxTreeList;
            UpdateTreeListButtons(Treelist);
        }

        private void UpdateTreeListButtons(ASPxTreeList treeList)
        {
            if (treeList.FocusedNode != null)
            {
                TreeListNodeCollection siblingNodes = (treeList.FocusedNode.ParentNode == null) ? treeList.Nodes : treeList.FocusedNode.ParentNode.ChildNodes;
                treeList.JSProperties["cpbtMoveUp_Enabled"] = !((int)treeList.FocusedNode.GetValue("DisplayOrder") == 0);
                treeList.JSProperties["cpbtMoveDown_Enabled"] = !((int)treeList.FocusedNode.GetValue("DisplayOrder") == (siblingNodes.Count - 1));
            }
        }

        protected void TreeListMenu_Load(object sender, EventArgs e)
        {
            UpdateTreeListButtons(sender as ASPxTreeList);
        }

        protected void TreeListMenu_DataBinding(object sender, EventArgs e)
        {
            ASPxTreeList treeList = sender as ASPxTreeList;
            if (treeList.DataSource is DataTable)
            {
                // This code adds a dummy column to the TreeList's data source to store sort order values of nodes
                // You can avoid using it if you have a persistent column in your data source
                //if (!data.Columns.Contains("DisplayOrder"))
                //    data.Columns.Add("DisplayOrder", typeof(int));

                //if (treeList.Columns["DisplayOrder"] == null)
                //{
                //    TreeListTextColumn sortIndex = new TreeListTextColumn();
                //    sortIndex.FieldName = "DisplayOrder";
                //    sortIndex.Visible = false;
                //    treeList.Columns.Add(sortIndex);
                //}
            }
        }

        protected void TreeListMenu_HtmlRowPrepared(object sender, TreeListHtmlRowEventArgs e)
        {
            ASPxTreeList treeList = sender as ASPxTreeList;
            if (e.RowKind == TreeListRowKind.Data)
            {
                TreeListNode parent = treeList.FindNodeByKeyValue(e.NodeKey).ParentNode;
                e.Row.Attributes.Add("nodeParent", (parent == null) ? string.Empty : parent.Key);
            }
        }

        protected void TreeListMenu_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            TreeListNodeCollection siblingNodes;
            ASPxTreeList treeList = sender as ASPxTreeList;
            Dictionary<string, int> SortIndex = Session[treeList.UniqueID + "_Sort"] as Dictionary<string, int>;

            if (e.Argument == "MOVEUP" || e.Argument == "MOVEDOWN")
            {
                siblingNodes = (treeList.FocusedNode.ParentNode == null) ? treeList.Nodes : treeList.FocusedNode.ParentNode.ChildNodes;
                int siblingCount = siblingNodes.Count;

                int Index = SortIndex[treeList.FocusedNode.Key];
                int NewIndex = Index;
                _ = Convert.ToInt32(treeList.FocusedNode.Key);

                if (e.Argument == "MOVEUP")
                {
                    NewIndex = (Index == 0) ? Index : Index - 1;
                }
                if (e.Argument == "MOVEDOWN")
                {
                    NewIndex = (Index == (siblingCount - 1)) ? Index : Index + 1;
                }

                foreach (TreeListNode node in siblingNodes)
                {
                    if (SortIndex[node.Key] == NewIndex)
                    {
                        SortIndex[treeList.FocusedNode.Key] = NewIndex;
                        SortIndex[node.Key] = Index;
                        break;
                    }
                }
                string[] swapKeys = e.Argument.Remove(0, 8).Split('|');
                TreeListNode draggingNode = treeList.FindNodeByKeyValue(swapKeys[0]);
                TreeListNode targetNode = treeList.FindNodeByKeyValue(swapKeys[1]);
                if ((draggingNode != null) && (targetNode != null))
                {
                    UpdateSortIndex(SortIndex[draggingNode.Key], NewIndex);
                    UpdateSortIndex(SortIndex[targetNode.Key], Index);
                }

            }

            if (e.Argument.Contains("DRAGNODE"))
            {
                string[] swapKeys = e.Argument.Remove(0, 8).Split('|');
                TreeListNode draggingNode = treeList.FindNodeByKeyValue(swapKeys[0]);
                TreeListNode targetNode = treeList.FindNodeByKeyValue(swapKeys[1]);
                if ((draggingNode != null) && (targetNode != null))
                {
                    _ = (targetNode.ParentNode == null) ? treeList.Nodes : targetNode.ParentNode.ChildNodes;

                    int targetIndex = Convert.ToInt32(targetNode.GetValue("DisplayOrder"));
                    int draggingIndex = Convert.ToInt32(draggingNode.GetValue("DisplayOrder"));
                    _ = (targetIndex < draggingIndex) ? 1 : -1;

                    //foreach (TreeListNode node in siblingNodes)
                    //{
                    //    if ((Convert.ToInt32(node.GetValue("DisplayOrder")) > Math.Min(targetIndex, draggingIndex)) && (Convert.ToInt32(node.GetValue("DisplayOrder")) < Math.Max(targetIndex, draggingIndex)))
                    //    {
                    //        SortIndex[node.Key] += draggingDirection;
                    //    }
                    //}
                    UpdateSortIndex(Convert.ToInt32(draggingNode.Key), targetIndex);
                    UpdateSortIndex(Convert.ToInt32(targetNode.Key), draggingIndex);
                    //SortIndex[draggingNode.Key] = targetIndex;
                    //SortIndex[targetNode.Key] = targetIndex + draggingDirection;

                }

            }

            treeList.DataBind();
            UpdateTreeListButtons(treeList);

        }

        private void UpdateSortIndex(int rowKey, int sortIndex)
        {
            DisplayOrder_Dts.UpdateParameters["Id"].DefaultValue = rowKey.ToString();
            DisplayOrder_Dts.UpdateParameters["DisplayOrder"].DefaultValue = sortIndex.ToString();
            _ = DisplayOrder_Dts.Update();
        }


        protected void TreeListMenu_InitNewNode(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            //ASPxTreeList tree = (ASPxTreeList)sender;
            
            //string s;
            //s = "000";
            //TreeListNode node = tree.FocusedNode;
            //s = node.Key;
            //TreeListNode parent = tree.FindNodeByKeyValue(node.Key).ParentNode;
            //if (node != null)
            //{
            //    if(node.ParentNode == null)
            //    {
            //        s = "1";
            //    }
            //    else
            //    {
            //        s = "2";
            //    }
            //}
        }

        protected void CreaSession_cb_Callback(object source, CallbackEventArgs e)
        {
            string[] Params = e.Parameter.Split('|');

            Session[Params[0]] = Params[1];

            e.Result = Params[2];
        }

        protected void Anteprima_CallbackPnl_Callback(object sender, CallbackEventArgsBase e)
        {
            SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT U_SHP_Picture.PictureUrl FROM U_SHP_Category INNER JOIN U_SHP_Picture ON U_SHP_Category.PictureID = U_SHP_Picture.PictureID WHERE (U_SHP_Category.CategoryID = @ID)", new SqlParameter { ParameterName = "@ID", Value = e.Parameter });
            if (reader.Read())
            {
                Cat_Img.ImageUrl = reader["PictureUrl"] as string;
            }
        }
    }
}