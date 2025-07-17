<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Status_Print_Edit.aspx.cs" Inherits="INTRA.Print_Gest.Status_Print_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Text="Caricamento in corso..." Modal="true"></dx:ASPxLoadingPanel>
    <div class="row" style="padding-bottom: 25px">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-icon" data-background-color="blue">
                    <i class="material-icons">edit</i>
                </div>
                
               
                <div class="card-content">
                    <div class="card-content">
                        <style>
                            .sticky {
                                position: sticky;
                                top: 20px;
                                z-index: 5000 !important;
                            }
                        </style>
                        <h4 class="card-title">Edit Progetto</h4>
                        <div class="col-md-12" style="max-height: 600px; overflow: auto">
                            <dx:ASPxCallbackPanel runat="server" ID="Edit_CallbackPnl" ClientInstanceName="Edit_CallbackPnl" OnCallback="Edit_CallbackPnl_Callback">
                                <PanelCollection>
                                    <dx:PanelContent>

                                        <dx:ASPxFormLayout ID="Edit_Form" ClientInstanceName="Edit_Form" runat="server" DataSourceID="Edit_Dts" Width="100%">
                                            <Items>
                                                <dx:LayoutGroup Caption="Status_Print_ANA" ColumnCount="3">

                                                    <Items>

                                                        <%-- campo ID--%>
                                                        <dx:LayoutItem FieldName="ID" Caption="ID" Visible="true" CaptionSettings-Location="Top">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" ReadOnly="true" Width="100%"></dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%--campo testo Status--%>
                                                        <dx:LayoutItem FieldName="Status" Caption="Status" CaptionSettings-Location="Top">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxTextBox runat="server" ID="Edit_Versione" Enabled="True" Width="100%" InvalidStyle-BackColor="LightPink">
                                                                        <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="ValidazioneEdit">
                                                                        </ValidationSettings>
                                                                    </dx:ASPxTextBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <%--campo lista semaforo--%>
                                                        <dx:LayoutItem FieldName="ID_Semaforo" Caption="Semaforo" CaptionSettings-Location="Top">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxComboBox runat="server" DataSourceID="Semaforo_Dts" TextField="Semaforo_desc" ValueField="Semaforo_desc" ID="Edit_Semaforo" Width="100%">
                                                                        <ValidationSettings ValidateOnLeave="false" CausesValidation="true" ErrorDisplayMode="None" RequiredField-IsRequired="true"
                                                                            ErrorFrameStyle-BackColor="LightPink" ValidationGroup="ValidazioneEdit" />
                                                                        <InvalidStyle BackColor="LightPink" />
                                                                    </dx:ASPxComboBox>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                    </Items>
                                                </dx:LayoutGroup>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                            <%--bottone aggiorna--%>
                            <div class="col-md-12" style="padding-bottom: 40px; padding-top: 40px;">
                                <dx:ASPxButton ID="Update_Btn" runat="server" Text="Aggiorna" AutoPostBack="false" ClientInstanceName="Update_Btn" BackColor="DarkBlue">
                                    <%--funzione pop-up--%>
                                    <ClientSideEvents Click="function(s,e){if(ASPxClientEdit.ValidateGroup('ValidazioneEdit')){
ConfermaOperazione('Confermi di voler aggiornare il progetto con i dati inseriti?','Update_Callback','Aggiorna');
}
else{
showNotificationError('Alcuni dati non sono stati compilati, controllare e riprovare.')
}
}" />
                                </dx:ASPxButton>
                                <%--funzione per aggiornare i dati--%>
                                <dx:ASPxCallback ID="Update_Callback" ClientInstanceName="Update_Callback" runat="server" OnCallback="Update_Callback_Callback" Style="float: right">
                                    <ClientSideEvents
                                        BeginCallback="function(s,e){LoadingPanel.Show();}"
                                        EndCallback="function(s,e){LoadingPanel.Hide(); showNotification();Edit_CallbackPnl.PerformCallback();}" />
                                </dx:ASPxCallback>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%--Semaforo_Status_ANA--%>
    <asp:SqlDataSource runat="server" ID="Semaforo_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, Semaforo_desc FROM Semaforo_Status_ANA"></asp:SqlDataSource>

    <%--Status_Printer_ANA--%>
    <asp:SqlDataSource runat="server" ID="Edit_Dts" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, Status, ID_Semaforo FROM Status_Printer_ANA WHERE (ID = @ID)" UpdateCommand="UPDATE Status_Printer_ANA SET Status = @Status, ID_Semaforo = @ID_Semaforo WHERE (ID = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Status"></asp:Parameter>
            <asp:Parameter Name="ID_Semaforo"></asp:Parameter>
            <asp:QueryStringParameter QueryStringField="ID" DefaultValue="0" Name="ID"></asp:QueryStringParameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
