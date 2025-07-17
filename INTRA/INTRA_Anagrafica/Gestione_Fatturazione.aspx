<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gestione_Fatturazione.aspx.cs" Inherits="GMSL_V1.INTRA_Anagrafica.Gestione_Fatturazione" %>


<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">


    <dx:ASPxGridView ID="ListaDoc_Gridview" ClientInstanceName="ListaDoc_Gridview" DataSourceID="ListaDoc_Dts" runat="server" Width="100%" KeyFieldName="ID" AutoGenerateColumns="False"  OnCustomColumnDisplayText="ListaDoc_Gridview_CustomColumnDisplayText"  OnBeforePerformDataSelect="ListaDoc_Gridview_BeforePerformDataSelect" OnUnload="ListaDoc_Gridview_Unload">
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
            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False"></EditFormSettings>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NomeTabella" VisibleIndex="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PercorsoFile" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Obbligatorio" VisibleIndex="4"></dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn VisibleIndex="5" Name="Exist"></dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn  ShowClearFilterButton="true" ShowEditButton="True" ShowDeleteButton="True" ShowNewButtonInHeader="True" VisibleIndex="0"></dx:GridViewCommandColumn>
        </Columns>
    </dx:ASPxGridView>

    <dx:ASPxButton ID="ImportaDoc_Btn" ClientInstanceName="ImportaDoc_Btn" runat="server" Text="IMPORTA FILE" AutoPostBack="false" visible="false" >
        <ClientSideEvents Click="function(s,e){ConfermaOperazione('Confermi di voler importare questi documenti?', 'ImportaDoc_Callback', 0)}" />
    </dx:ASPxButton>


<%--    <dx:ASPxCallback ID="ImportaDoc_Callback" ClientInstanceName="ImportaDoc_Callback" runat="server" OnCallback="ImportaDoc_Callback_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){showNotification()}" />
    </dx:ASPxCallback>--%>



    <asp:SqlDataSource ID="ListaDoc_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' DeleteCommand="DELETE FROM U_KI_APPOGGIO WHERE (ID = @ID)" InsertCommand="INSERT INTO U_KI_APPOGGIO(NomeTabella, PercorsoFile, Obbligatorio, CreatedOn) VALUES (@NomeTabella, @PercorsoFile, @Obbligatorio, GETDATE())" SelectCommand="SELECT U_KI_APPOGGIO.* FROM U_KI_APPOGGIO" UpdateCommand="UPDATE U_KI_APPOGGIO SET NomeTabella = @NomeTabella, PercorsoFile = @PercorsoFile, Obbligatorio = @Obbligatorio, UpdatedOn = GETDATE() WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="NomeTabella"></asp:Parameter>
            <asp:Parameter Name="PercorsoFile"></asp:Parameter>
            <asp:Parameter Name="Obbligatorio"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="NomeTabella"></asp:Parameter>
            <asp:Parameter Name="PercorsoFile"></asp:Parameter>
            <asp:Parameter Name="Obbligatorio"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScriptArea" runat="server">
</asp:Content>
