<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LFT_ParameterPeriodiche.aspx.cs" Inherits="INTRA.SuperAdmin.Parametri.LFT_ParameterPeriodiche" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function TecniciSelectIndexChanged(s, e) {
            var resourceNames = new Array();
            var items = s.GetSelectedItems();
            var count = items.length;
            if (count > 0) {
                for (var i = 0; i < count; i++)
                    resourceNames.push(items[i].text.replace('; ', '').replace('PREDEFINITO', ''));
            }
            else
                resourceNames.push(ddResource.cp_Caption_ResourceNone);
            ddResource.SetValue(resourceNames.join(', '));
        }

    </script>
    <style>
        .hidecolumn{
            display: none!important;
        }
    </style>
    <dx:ASPxGridView ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" runat="server" DataSourceID="Generic_Sql" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID" OnRowUpdating="Generic_Gridview_RowUpdating" OnRowInserting="Generic_Gridview_RowInserting" OnHtmlEditFormCreated="Generic_Gridview_HtmlEditFormCreated" OnBeforeGetCallbackResult="Generic_Gridview_BeforeGetCallbackResult">
        <SettingsCommandButton>
            <NewButton ButtonType="Image" RenderMode="Image">
                <Image ToolTip="Nuovo" Url="~/img/DevExButton/new.png" Width="30px" Height="30px"></Image>
            </NewButton>
            <UpdateButton ButtonType="Image" RenderMode="Image">
                <Image ToolTip="Aggiorna" Height="30px" Url="~/img/DevExButton/update.png" Width="30px"></Image>
            </UpdateButton>
            <CancelButton ButtonType="Image" RenderMode="Image">
                <Image ToolTip="Annulla" Height="30px" Url="~/img/DevExButton/cancel.png" Width="30px"></Image>
            </CancelButton>
            <EditButton ButtonType="Image" RenderMode="Image">
                <Image ToolTip="Modifica" Height="30px" Url="~/img/DevExButton/edit.png" Width="30px"></Image>
            </EditButton>
            <DeleteButton ButtonType="Image" RenderMode="Image">
                <Image ToolTip="Elimina" Height="30px" Url="~/img/DevExButton/delete.png" Width="30px"></Image>
            </DeleteButton>
        </SettingsCommandButton>
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowEditButton="true" ShowNewButtonInHeader="true"></dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="CodParam" VisibleIndex="1"></dx:GridViewDataTextColumn>
            <dx:BootstrapGridViewMemoColumn FieldName="Value" VisibleIndex="2"></dx:BootstrapGridViewMemoColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Type" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="FieldType_Sql" TextField="Type" ValueField="Type" ValueType="System.String" ></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="Descrizione" VisibleIndex="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Cookie" VisibleIndex="5"></dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="RuoliAbilitati" VisibleIndex="6">
                <EditItemTemplate>
                    <dx:ASPxDropDownEdit ID="ddResource" runat="server" Width="100%" ClientInstanceName="ddResource" DisplayFormatString="{0}" AllowUserInput="false" Text='<%# Eval("RuoliAbilitati") %>'>
                        <DropDownWindowTemplate>
                            <dx:ASPxListBox ID="edtMultiResource" runat="server" Width="100%" DataSourceID="Ruoli_Dts" TextField="RoleName" ValueField="RoleId" Height="300px" SelectionMode="CheckColumn" Border-BorderWidth="0" OnDataBound="edtMultiResource_DataBound">
                                <ClientSideEvents SelectedIndexChanged="TecniciSelectIndexChanged" />
                            </dx:ASPxListBox>
                        </DropDownWindowTemplate>
                        <InvalidStyle BackColor="LightPink" />
                    </dx:ASPxDropDownEdit>
                </EditItemTemplate>
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="FieldType_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, FieldType as Type FROM PRT_FieldType"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Ruoli_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT RoleName, RoleId FROM aspnet_Roles"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Generic_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' InsertCommand="INSERT INTO LFT_ParameterPeriodiche(CodParam, Value, Type, Descrizione, Cookie, RuoliAbilitati) VALUES (@CodParam, @Value, @Type, @Descrizione, @Cookie, @RuoliAbilitati)" SelectCommand="SELECT LFT_ParameterPeriodiche.* FROM LFT_ParameterPeriodiche" UpdateCommand="UPDATE LFT_ParameterPeriodiche SET Value = @Value, Descrizione = @Descrizione, Cookie = @Cookie, RuoliAbilitati = @RuoliAbilitati WHERE (ID = @ID)">
        <InsertParameters>
            <asp:Parameter Name="CodParam"></asp:Parameter>
            <asp:Parameter Name="Value"></asp:Parameter>
            <asp:Parameter Name="Type"></asp:Parameter>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="Cookie"></asp:Parameter>
            <asp:Parameter Name="RuoliAbilitati"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Value"></asp:Parameter>
            <asp:Parameter Name="Descrizione"></asp:Parameter>
            <asp:Parameter Name="Cookie"></asp:Parameter>
            <asp:Parameter Name="RuoliAbilitati"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>



