using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections;
using info4lab;
using DevExpress.Web;
using DevExpress;

public partial class AdminPanel_controls_ParametriSitoInsert : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //messaggio successo
           

        }
    }

    protected void ListViewGeneric_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            //MsgBox.Visible = false;
        }

        if (e.CommandName == "Insert")
        {
            TextBox txtCodice = (TextBox)e.Item.FindControl("txtCodice");
            TextBox txtDesc = (TextBox)e.Item.FindControl("txtDesc");
            TextBox txtParameter = (TextBox)e.Item.FindControl("txtParameter");
            TextBox txtOrder = (TextBox)e.Item.FindControl("txtOrder");
            HtmlInputCheckBox DefParamCkBx = (HtmlInputCheckBox)e.Item.FindControl("DefParamCkBx");
            //raccolta dati

            PRT_setting_Manage_SA setting = new PRT_setting_Manage_SA();
            setting.Name = txtCodice.Text;
            setting.Description = txtDesc.Text;
            setting.Value = txtParameter.Text;
            setting.DisplayOrder = Convert.ToInt32(txtOrder.Text);
            setting.SystemParameter = DefParamCkBx.Checked;

            try
            {
                int lastIdSetting = setting.InsertPRT_Setting(setting);
            }
            catch (Exception ex)
            {
                Response.Redirect("pannello_parametri_sito.aspx?Msg=0");
            }

            Response.Redirect("pannello_parametri_sito.aspx?Msg=1");

        }
        else if (e.CommandName == "Update")
        {
            //    ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            //    string VarIDEdit = ListViewGeneric.DataKeys[dataItem.DisplayIndex].Values["SettingID"].ToString();
            //    TextBox edit_txtCodice = (TextBox)e.Item.FindControl("edit_txtCodice");
            //    TextBox edit_txtDesc = (TextBox)e.Item.FindControl("edit_txtDesc");
            //    TextBox edit_txtParameter = (TextBox)e.Item.FindControl("edit_txtParameter");
            //    TextBox edit_txtOrder = (TextBox)e.Item.FindControl("edit_txtOrder");
            //    HtmlInputCheckBox edit_DefParamCkBx = (HtmlInputCheckBox)e.Item.FindControl("edit_DefParamCkBx");

            //    //raccolta dati
            //    PRT_setting_Manage setting = new PRT_setting_Manage();

            //    setting.Name = edit_txtCodice.Text;
            //    setting.Description = edit_txtDesc.Text;
            //    setting.Value = edit_txtParameter.Text;
            //    setting.DisplayOrder = Convert.ToInt32(edit_txtOrder.Text);
            //    setting.SystemParameter = edit_DefParamCkBx.Checked;
            //    setting.ReturnID = Convert.ToInt32(VarIDEdit);

            //    try
            //    {
            //        setting.UpdatePRT_Setting(setting);
            //    }
            //    catch (Exception ex)
            //    {
            //        Response.Redirect("pannello_parametri_sito.aspx?Msg=0");
            //    }

            //    Response.Redirect("pannello_parametri_sito.aspx?Msg=1");

            //}
            //else if (e.CommandName == "Delete")
            //{

            //}

        }
    }
    protected void btnDeleteCache_Click(object sender, EventArgs e)
    {
        foreach (DictionaryEntry de in HttpContext.Current.Cache)
        {
            HttpContext.Current.Cache.Remove((string)de.Key);
        }

        Response.Redirect("pannello_parametri_sito.aspx?Msg=1");
    }

   
    protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        PRT_setting_Manage_SA setting = new PRT_setting_Manage_SA();

        setting.Name = e.NewValues["Name"].ToString();
        setting.Description = e.NewValues["Description"].ToString();
        setting.Value = e.NewValues["Value"].ToString();
        setting.DisplayOrder = Convert.ToInt32(e.NewValues["DisplayOrder"].ToString());
        setting.SystemParameter = Convert.ToBoolean(e.NewValues["SystemParameter"].ToString());
        setting.ReturnID = Convert.ToInt32(e.NewValues["SettingID"].ToString());

        try
        {
            setting.UpdatePRT_Setting(setting);
        }
        catch (Exception ex)
        {
            ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=0");
        }

        ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=1");
    }

    protected void ASPxGridView1_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {

        //raccolta dati

        PRT_setting_Manage_SA setting = new PRT_setting_Manage_SA();
        setting.Name = e.NewValues["Name"].ToString();
        setting.Description = e.NewValues["Description"].ToString();
        setting.Value = e.NewValues["Value"].ToString();
        setting.DisplayOrder = Convert.ToInt32(e.NewValues["DisplayOrder"].ToString());
        setting.SystemParameter = Convert.ToBoolean(e.NewValues["SystemParameter"].ToString());

        try
        {
            int lastIdSetting = setting.InsertPRT_Setting(setting);
        }
        catch (Exception ex)
        {
            ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=0");
        }

        ASPxWebControl.RedirectOnCallback("pannello_parametri_sito.aspx?Msg=1");
    }
}