<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_HolidayCalendarXml.aspx.cs" Inherits="INTRA.SuperAdmin.PRT_CRUD.PRT_HolidayCalendarXml" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">
                             <label class="label-control">Anno inizio:</label>
                            <dx:ASPxTextBox ID="YearStart_Txt" runat="server" Width="170px"></dx:ASPxTextBox>
                            <br />
                            <br />
                             <label class="label-control">Anno fine:</label>
                            <dx:ASPxTextBox ID="YearEnd_Txt" runat="server" Width="170px"></dx:ASPxTextBox>
                            <br />
                            <br />
                            <dx:ASPxButton runat="server" Text="Crea Xml" id="SalvaXml" OnClick="SalvaXml_Click"></dx:ASPxButton>
                            <br /><br />
                            <dx:ASPxGridView Styles-AlternatingRow-Enabled="True" runat="server" ID="Generic_GridView" DataSourceID="PRT_HolidayXmlDts" AutoGenerateColumns="False" width="100%">
                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                <SettingsPopup>
                                    <HeaderFilter MinHeight="140px"></HeaderFilter>
                                </SettingsPopup>
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DisplayName" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Date" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>
                            <asp:XmlDataSource ID="PRT_HolidayXmlDts" runat="server" DataFile="~/App_Data/PRT_holidays.xml"></asp:XmlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
