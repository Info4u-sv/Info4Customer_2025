using DevExpress.Web;
using System;
using System.Drawing;
using System.IO;
using System.Web.UI;

namespace INTRA.SuperAdmin.PRT_CRUD
{
    public partial class PRT_DropDown_Elementi : System.Web.UI.Page
    {
        private readonly string IconPathFolder = "~/img/PortalButtons/";

        #region /*gestione move up move down*/
        protected void Generic_Gridview_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == GridViewRowType.Data)
            {
                object rowOrder = e.GetValue("DisplayOrder");
                if (rowOrder != null)
                {
                    e.Row.Attributes.Add("sortOrder", rowOrder.ToString());
                }
            }
        }

        private int GetGridViewKeyByVisibleIndex(ASPxGridView gridView, int visibleIndex)
        {
            return (int)gridView.GetRowValues(visibleIndex, gridView.KeyFieldName);
        }
        private int GetKeyIDBySortIndex(ASPxGridView gridView, int sortIndex)
        {
            dsHelper.SelectParameters["DisplayOrder"].DefaultValue = sortIndex.ToString();
            int rowKey = (int)(dsHelper.Select(DataSourceSelectArguments.Empty) as System.Data.DataView)[0][gridView.KeyFieldName];
            return rowKey;
        }
        private void UpdateSortIndex(int rowKey, int sortIndex)
        {
            dsHelper.UpdateParameters["ID"].DefaultValue = rowKey.ToString();
            dsHelper.UpdateParameters["DisplayOrder"].DefaultValue = sortIndex.ToString();
            _ = dsHelper.Update();
        }
        protected void Generic_Gridview_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            ASPxGridView gridView = sender as ASPxGridView;
            string[] parameters = e.Parameters.Split('|');
            string command = parameters[0];
            if (command == "MOVEUP" || command == "MOVEDOWN")
            {
                int focusedRowKey = GetGridViewKeyByVisibleIndex(gridView, gridView.FocusedRowIndex);
                int index = (int)gridView.GetRowValues(gridView.FocusedRowIndex, "DisplayOrder");
                int newIndex = index;
                if (command == "MOVEUP")
                {
                    newIndex = (index == 0) ? index : index - 1;
                }
                if (command == "MOVEDOWN")
                {
                    newIndex = (index == gridView.VisibleRowCount) ? index : index + 1;
                }
                int rowKey = GetKeyIDBySortIndex(gridView, newIndex);
                UpdateSortIndex(focusedRowKey, newIndex);
                UpdateSortIndex(rowKey, index);
                gridView.FocusedRowIndex = gridView.FindVisibleIndexByKeyValue(rowKey);
            }
            if (command == "DRAGROW")
            {
                int draggingIndex = int.Parse(parameters[1]);
                int targetIndex = int.Parse(parameters[2]);
                int draggingRowKey = GetKeyIDBySortIndex(gridView, draggingIndex);
                int targetRowKey = GetKeyIDBySortIndex(gridView, targetIndex);
                int draggingDirection = (targetIndex < draggingIndex) ? 1 : -1;
                for (int rowIndex = 0; rowIndex < gridView.VisibleRowCount; rowIndex++)
                {
                    int rowKey = GetGridViewKeyByVisibleIndex(gridView, rowIndex);
                    int index = (int)gridView.GetRowValuesByKeyValue(rowKey, "DisplayOrder");
                    if ((index > Math.Min(targetIndex, draggingIndex)) && (index < Math.Max(targetIndex, draggingIndex)))
                    {
                        UpdateSortIndex(rowKey, index + draggingDirection);
                    }
                }
                UpdateSortIndex(draggingRowKey, targetIndex);
                UpdateSortIndex(targetRowKey, targetIndex + draggingDirection);
            }
            gridView.DataBind();
        }

        private void UpdateGridViewButtons(ASPxGridView gridView)
        {
            gridView.JSProperties["cpbtMoveUp_Enabled"] = gridView.FocusedRowIndex > 0;
            gridView.JSProperties["cpbtMoveDown_Enabled"] = gridView.FocusedRowIndex < (gridView.VisibleRowCount - 1);
        }
        protected void Generic_Gridview_CustomJSProperties(object sender, DevExpress.Web.ASPxGridViewClientJSPropertiesEventArgs e)
        {
            ASPxGridView gridView = sender as ASPxGridView;
            UpdateGridViewButtons(gridView);
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Clear();
                Session["FileUploadComplete"] = "false";
                Session["IconPathImg"] = "#";
            }
        }
        //public List<MySavedObjects> FileList
        //{
        //    get
        //    {
        //        List<MySavedObjects> list = Session["list"] as List<MySavedObjects>;
        //        if (list == null)
        //        {
        //            list = new List<MySavedObjects>();
        //            for (int i = 0; i < Generic_Gridview.VisibleRowCount; i++)
        //            {
        //                list.Add(new MySavedObjects() { RowNumber = i });
        //            }
        //            Session["list"] = list;
        //        }
        //        return list;
        //    }
        //}
        protected void ASPxUploadControl1_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            GridViewDataComboBoxColumn ComboboxFamigliaColumn = (GridViewDataComboBoxColumn)Generic_Gridview.Columns["DropDown_Famiglia"];
            ASPxComboBox ComboboxFamiglia = (ASPxComboBox)Generic_Gridview.FindEditRowCellTemplateControl(ComboboxFamigliaColumn, "ComboboxFamiglia");

            GridViewDataTextColumn COL_ASPxUploadControl1 = (GridViewDataTextColumn)Generic_Gridview.Columns["ASPxUploadControl1"];
            _ = (ASPxUploadControl)Generic_Gridview.FindEditRowCellTemplateControl(COL_ASPxUploadControl1, "ASPxUploadControl1");
            ASPxImage IconPathImg_Edit = (ASPxImage)Generic_Gridview.FindEditRowCellTemplateControl(COL_ASPxUploadControl1, "IconPathImg_Edit");
            if (e.IsValid)
            {
                string NomeFamiglia = ComboboxFamiglia.SelectedItem.Value.ToString();
                //string path = "~/Documents/";
                string fileName = NomeFamiglia + "_" + e.UploadedFile.FileName;
                string IconPathImg = IconPathFolder + fileName;
                e.UploadedFile.SaveAs(Server.MapPath(IconPathImg), true);
                Session["IconPathImg"] = IconPathImg;

                string url = ResolveClientUrl(IconPathImg);
                e.CallbackData = url;

                // e.CallbackData = fileName;
                IconPathImg_Edit.ImageUrl = IconPathImg;
                Session["FileUploadComplete"] = "true";
            }
            else { Session["FileUploadComplete"] = "false"; }
        }

        //protected void ASPxHyperLink_Load(object sender, EventArgs e)
        //{
        //    ASPxHyperLink hpl = (ASPxHyperLink)sender;
        //    GridViewDataItemTemplateContainer c = (GridViewDataItemTemplateContainer)hpl.NamingContainer;
        //    //if (!String.IsNullOrWhiteSpace(FileList[c.VisibleIndex].FileName) && !String.IsNullOrWhiteSpace(FileList[c.VisibleIndex].IconPath))
        //    //{
        //    //    hpl.Text = FileList[c.VisibleIndex].FileName;
        //    //    hpl.NavigateUrl = FileList[c.VisibleIndex].IconPath;
        //    //}
        //}

        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            string fileName = e.Parameter;
            File.Delete(Server.MapPath(IconPathFolder + fileName));
            e.Result = "ok";
            Session["FileUploadComplete"] = "false";
        }

        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            e.NewValues["IconPath"] = Session["IconPathImg"].ToString();
            e.NewValues["DisplayOrder"] = Generic_Gridview.VisibleRowCount + 1;

            GridViewDataComboBoxColumn ComboboxFamigliaColumn = (GridViewDataComboBoxColumn)Generic_Gridview.Columns["DropDown_Famiglia"];
            ASPxComboBox ComboboxFamiglia = (ASPxComboBox)Generic_Gridview.FindEditRowCellTemplateControl(ComboboxFamigliaColumn, "ComboboxFamiglia");

            object _Selected = e.NewValues["Selected"];
            if (_Selected == null)
            {
                e.NewValues["Selected"] = 0;
            }

            e.NewValues["DropDown_Famiglia"] = ComboboxFamiglia.SelectedItem.Value;
            e.NewValues["Color"] = GetColor();
        }


        protected void Generic_Gridview_CustomErrorText(object sender, ASPxGridViewCustomErrorTextEventArgs e)
        {
            if (e.Exception is INTRA.SuperAdmin.AppCode.CustomExceptions_SA.MyException)
            {
                e.ErrorText = e.Exception.Message;
            }
        }

        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            if (Session["FileUploadComplete"].ToString() == "true")
            {
                string IconPath = e.OldValues["IconPath"].ToString();
                File.Delete(Server.MapPath(IconPath));
                e.NewValues["IconPath"] = Session["IconPathImg"].ToString();
                Session["FileUploadComplete"] = "false";
            }
            GridViewDataComboBoxColumn ComboboxFamigliaColumn = (GridViewDataComboBoxColumn)Generic_Gridview.Columns["DropDown_Famiglia"];
            ASPxComboBox ComboboxFamiglia = (ASPxComboBox)Generic_Gridview.FindEditRowCellTemplateControl(ComboboxFamigliaColumn, "ComboboxFamiglia");

            e.NewValues["DropDown_Famiglia"] = ComboboxFamiglia.SelectedItem.Value;

            object _Selected = e.NewValues["Selected"];
            if (_Selected == null)
            {
                e.NewValues["Selected"] = 0;
            }
            e.NewValues["Color"] = GetColor();
        }

        protected void Generic_Gridview_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            string IconPath = e.Values["IconPath"].ToString();
            File.Delete(Server.MapPath(IconPath));
        }

        protected void Generic_Gridview_CancelRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            if (Session["FileUploadComplete"].ToString() == "true")
            {
                string IconPath = Session["IconPathImg"].ToString();
                File.Delete(Server.MapPath(IconPath));
            }
        }

        protected Color GetColor(object container)
        {
            try
            {
                int ColorDec = Convert.ToInt32(container.ToString().Replace("#", string.Empty).ToString(), 16);
                Color color = Color.FromArgb(ColorDec);
                return color;
            }
            catch (Exception)
            {
                return Color.Red;
            }
        }

        private string GetColor()
        {
            //GridViewDataTextColumn col = grid.Columns["DxColor"] as GridViewDataTextColumn;
            ASPxColorEdit colorEdit = Generic_Gridview.FindEditRowCellTemplateControl(Generic_Gridview.Columns["Color"] as GridViewDataColumn, "ColorEditHeaderBackColor") as ASPxColorEdit;

            //ASPxColorEdit colorEdit = grid.FindEditRowCellTemplateControl(col, "colorEdit") as ASPxColorEdit;
            Color color = colorEdit.Color;
            string colorex = color.Name.ToString();
            return "#" + colorex.Remove(0, 2);
            //return color.ToArgb().ToString();
        }



        protected void ComboboxFamiglia_DataBound(object sender, EventArgs e)
        {
            //GridViewDataComboBoxColumn ComboboxFamigliaColumn = (GridViewDataComboBoxColumn)(Generic_Gridview.Columns["DropDown_Famiglia"]);
            //ASPxComboBox ComboboxFamiglia = (ASPxComboBox)Generic_Gridview.FindEditRowCellTemplateControl(ComboboxFamigliaColumn, "ComboboxFamiglia");

            //var xxxxx = Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "DropDown_Famiglia");
            //ComboboxFamiglia.SelectedItem.SetFieldValue("ID",Generic_Gridview.GetRowValues(Generic_Gridview.EditingRowVisibleIndex, "DropDown_Famiglia"));
        }
        //protected void dd_Validation(object sender, ValidationEventArgs e)
        //{
        //   // e.IsValid = false;
        //}

    }
}