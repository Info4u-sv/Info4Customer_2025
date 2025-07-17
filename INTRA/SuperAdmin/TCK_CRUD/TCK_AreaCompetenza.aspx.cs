using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Drawing;

namespace INTRA.SuperAdmin.TCK_CRUD
{
    public partial class TCK_AreaCompetenza : System.Web.UI.Page
    {
        #region /*gestione move up move down*/
        protected void Generic_Gridview_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == GridViewRowType.Data)
            {
                object rowOrder = e.GetValue("DisplayOrder");
                if (rowOrder != null)
                    e.Row.Attributes.Add("sortOrder", rowOrder.ToString());
            }
        }
        int GetGridViewKeyByVisibleIndex(ASPxGridView gridView, int visibleIndex)
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
            dsHelper.UpdateParameters["IdAreaAss"].DefaultValue = rowKey.ToString();
            dsHelper.UpdateParameters["DisplayOrder"].DefaultValue = sortIndex.ToString();
            dsHelper.Update();
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
        void UpdateGridViewButtons(ASPxGridView gridView)
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

        }

        protected void Generic_Gridview_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            e.NewValues["DisplayOrder"] = Generic_Gridview.VisibleRowCount + 1;
            e.NewValues["Color"] = GetColor();
        }
        protected void Generic_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            e.NewValues["Color"] = GetColor();
        }

        #region /*Gestione campo colore*/
        protected System.Drawing.Color GetColor(object container)
        {
            try
            {
                int ColorDec = Convert.ToInt32(container.ToString(), 16);
                Color color = Color.FromArgb(ColorDec);
                return color;
            }
            catch (Exception)
            {
                return Color.Red;
            }
        }
        private object GetColor()
        {
            GridViewDataTextColumn col = Generic_Gridview.Columns["Color"] as GridViewDataTextColumn;
            ASPxColorEdit colorEdit = Generic_Gridview.FindEditRowCellTemplateControl(col, "colorEdit") as ASPxColorEdit;
            Color color = colorEdit.Color;
            return color.ToArgb().ToString();
        }
        protected void Generic_Gridview_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.DataColumn.FieldName != "Color") return;
            e.Cell.Text = string.Empty;
            try
            {
                if (e.CellValue is DBNull)
                    e.Cell.BackColor = Color.Black;
                else
                    e.Cell.BackColor = Color.FromArgb(Convert.ToInt32(e.CellValue));
            }
            catch (Exception)
            {
                e.Cell.BackColor = Color.Red;
            }
        }
        #endregion
    }
}