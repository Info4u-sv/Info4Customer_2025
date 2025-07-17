<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="pannello_parametri_sito.aspx.cs" Inherits="INTRA.SuperAdmin.pannello_parametri_sito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        th > input {
            width: auto;
            max-width: 100px;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="orange">
                    <i class="material-icons">assignment</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Pannello Parametri Sito</h4>
                    <div class="col-xs-12 col-md-6 col-sm-12 col-lg-12">
                        <table class="webparts">
                            <tr>
                                <td class="details" valign="top">
                                    <small style="color: red; font-size: 20px">Tramite questa sezione puoi aggiornare i dati del tuo sito.<br />
                                        Attenzione per rendere definitivi i dati dopo l'aggiornamento devi "Cancellare la Cache"!</small>
                                    <br />
                                    <asp:LinkButton ID="btnDeleteCache" runat="server" CssClass="btn btn-labeled btn-danger" data-toggle="tooltip" title="Elimina cache" OnClick="btnDeleteCache_Click"><i class="btn-label fa fa-trash"></i>Cache</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-xs-12 col-md-12 col-lg-12 no-padding">
                        <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" ID="ASPxGridView1" Width="100%" runat="server" DataSourceID="GenericSqlDS" KeyFieldName="SettingID" AutoGenerateColumns="False"  OnRowUpdating="ASPxGridView1_RowUpdating" OnRowInserting="ASPxGridView1_RowInserting" >
                            <SettingsEditing Mode="inline"></SettingsEditing>
                            <Settings ShowFilterRow="True" />
                            <SettingsDataSecurity AllowDelete="False" />
                            <SettingsSearchPanel Visible="True" />
                            <SettingsCommandButton>
                                        <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                                        </ClearFilterButton>
                                        <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
                                        </EditButton>
                                         <DeleteButton RenderMode="Button" Image-ToolTip="Elimina" Text="Elimina" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn delete icon4u icon-delete image"></Styles>
                                        </DeleteButton>
                                        <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                                        </UpdateButton>
                                        <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                                        </CancelButton>
                                        <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                                        </NewButton>
                                         <SelectButton RenderMode="Button" Image-ToolTip="Seleziona" Text="Seleziona" Styles-CssPostfix="hidebtn">
                                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                                        </SelectButton>
                                    </SettingsCommandButton>
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" ShowClearFilterButton="True">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="SettingID" ReadOnly="True" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Name" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Value" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="4">
                                    <PropertiesTextEdit EncodeHtml="false"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn FieldName="SystemParameter" VisibleIndex="6">
                                </dx:GridViewDataCheckColumn>
                            </Columns>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="GenericSqlDS" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>"
        SelectCommand="SELECT SettingID, Name, Value, Description, DisplayOrder, SystemParameter FROM PRT_Setting ORDER BY SettingID" InsertCommand="UPDATE PRT_Documenti SET Description = Description WHERE (1 = 2)" UpdateCommand="UPDATE PRT_Documenti SET Description = Description WHERE (1 = 2)"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
