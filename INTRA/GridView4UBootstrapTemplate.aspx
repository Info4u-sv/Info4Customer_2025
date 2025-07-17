<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GridView4UBootstrapTemplate.aspx.cs" Inherits="INTRA.GridView4UBootstrapTemplate" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxSpellChecker" Assembly="DevExpress.Web.ASPxSpellChecker.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
    <script>
        function OnCustomButtonClick(s, e) {
            var index = Generic_gridview.GetFocusedRowIndex();

            if (e.buttonID == "GoTo") {
                s.GetRowValues(e.visibleIndex, 'id', GotoNewPage);
            }
            if (e.buttonID == "Edit") {
                Generic_gridview.StartEditRow(e.visibleIndex);
            }
            if (e.buttonID == "Delete") {
                Generic_gridview.DeleteRow(e.visibleIndex);
            }
            if (e.buttonID == "NewOff") {
                window.location = "Default.aspx";
            }
        }
        function GotoNewPage(value) {
            window.location = "Prospect_Client_det.aspx?Cli=" + value;
        }
        function ShowHint(s, e) {
            var clientObject = Object.getOwnPropertyNames(s.options);

            /*alert(clientObject);*/
            e.contentElement.innerHTML = '<div class="hintContent">' +
                '<div>Click this button to add a new record.' + '' + '</div>' +
                '</div>';
            ASPxClientHint.UpdatePosition(e.hintElement);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="red">
                    <i class="material-icons">people_alt</i>
                </div>
                <div class="card-content">
                    <h4 class="card-title">Lista prospect e clienti</h4>
                    <dx:ASPxHint ID="ASPxHint1" runat="server" TargetSelector=".dx-vam">
                        <%--  <ClientSideEvents Showing="ShowHint" />--%>
                    </dx:ASPxHint>
                    <dx:ASPxHint ID="ASPxHint2" runat="server" TargetSelector=".btn:hover" Content="ccc">
                        <%--  <ClientSideEvents Showing="ShowHint" />--%>
                    </dx:ASPxHint>
                    <dx:ASPxGridView ID="Generic_gridview" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Generic_gridview" DataSourceID="Generic_Dts" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="id">
                        <Settings ShowGroupPanel="True" ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                        <Styles AlternatingRow-Enabled="True"></Styles>
                        <Toolbars>
                            <dx:GridViewToolbar>
                                <Items>
                                    <dx:GridViewToolbarItem Alignment="left">
                                        <Template>
                                            <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Cerca..." Height="100%" ClearButton-DisplayMode="Always">
                                                <Buttons>
                                                    <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                                </Buttons>
                                            </dx:ASPxButtonEdit>
                                        </Template>
                                    </dx:GridViewToolbarItem>
                                    <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" />
                                </Items>
                            </dx:GridViewToolbar>

                        </Toolbars>

                        <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                        <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                        <ClientSideEvents EndCallback="function(s, e) { ASPxClientHint.Update(); }" />
                        <SettingsCommandButton>
                            <ClearFilterButton RenderMode="Button" Image-ToolTip="ClearFilterButton" Text="ClearFilterButton" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn ClearFilter icon4u icon-ClearFilter image"></Styles>
                            </ClearFilterButton>
                            <%--  <EditButton RenderMode="Button" Image-AlternateText="Modifica" Image-ToolTip="Modifica" Text="Modifica"  Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn edit icon4u icon-edit image"></Styles>
                            </EditButton>--%>
                            <%--   <DeleteButton RenderMode="Button" Image-ToolTip="Elimina" Text="Elimina" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn delete icon4u icon-delete image"></Styles>
                            </DeleteButton>--%>
                            <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                            </UpdateButton>
                            <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                            </CancelButton>
                            <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                            </NewButton>
                            <%-- <SelectButton RenderMode="Button" Image-ToolTip="Seleziona" Text="Seleziona" Styles-CssPostfix="hidebtn">
                                <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn selectbtn icon4u icon-selectbtn image"></Styles>
                            </SelectButton>--%>
                        </SettingsCommandButton>
                        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                        <Columns>
                            <dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowSelectButton="false" ShowNewButtonInHeader="false">
                                <CustomButtons>
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo" Text="Apri Dettaglio" IconCssClass="icon4u icon-go image" CssClass="btn btn-sm btn-custom-padding action-btn go" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="NewOff" Text="Genera Offerta" IconCssClass="icon4u icon-new image" CssClass="btn btn-sm btn-custom-padding action-btn new" Visibility="FilterRow" />
                                    <%--   <dx:BootstrapGridViewCommandColumnCustomButton ID="Edit" Text="Modifica" IconCssClass="icon4u icon-edit image" CssClass="btn btn-sm btn-custom-padding action-btn edit" />
                                    <dx:BootstrapGridViewCommandColumnCustomButton ID="Delete" Text="Elimina" IconCssClass="icon4u icon-delete image" CssClass="btn btn-sm btn-custom-padding action-btn delete" />
                                    --%>
                                </CustomButtons>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="id" ReadOnly="True" VisibleIndex="1">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="2"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DisplayOrder" VisibleIndex="3"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="LabelClass" VisibleIndex="4"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Funcntions" VisibleIndex="5"></dx:GridViewDataTextColumn>
                        </Columns>

                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="Generic_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT [id], [Descrizione], [DisplayOrder], [LabelClass], [Funcntions] FROM [CRM4U_TipoAttivita_TestTemplate]" UpdateCommand="UPDATE CRM4U_TipoAttivita_TestTemplate SET Descrizione = @Descrizione, DisplayOrder = @DisplayOrder, LabelClass = @LabelClass, Funcntions = @Funcntions WHERE (id = @id)" DeleteCommand="DELETE FROM CRM4U_TipoAttivita_TestTemplate WHERE (id = @id)" InsertCommand="INSERT INTO CRM4U_TipoAttivita_TestTemplate(Descrizione, DisplayOrder, LabelClass, Funcntions) VALUES (@Descrizione, @DisplayOrder, @LabelClass, @Funcntions)">
                        <DeleteParameters>
                            <asp:Parameter Name="id"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Descrizione"></asp:Parameter>
                            <asp:Parameter Name="DisplayOrder"></asp:Parameter>
                            <asp:Parameter Name="LabelClass"></asp:Parameter>
                            <asp:Parameter Name="Funcntions"></asp:Parameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Descrizione"></asp:Parameter>
                            <asp:Parameter Name="DisplayOrder"></asp:Parameter>
                            <asp:Parameter Name="LabelClass"></asp:Parameter>
                            <asp:Parameter Name="Funcntions"></asp:Parameter>
                            <asp:Parameter Name="id"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
