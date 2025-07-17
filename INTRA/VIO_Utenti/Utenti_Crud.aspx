<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Utenti_Crud.aspx.cs" Inherits="INTRA.VIO_Utenti.Utenti_Crud" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function ControlloNumeroTocken(s, e) {
            var tokens = s.GetTokenCollection();
            if (tokens.length > Number(1)) {
                s.RemoveToken(1);
            }
        }

        function ValidateEmail(inputText) {
            //alert(inputText);
            if (inputText == null) {
                return false;
            } else {
                //alert("else");
                var mailformat = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (inputText.match(mailformat)) {
                    //alert("You have entered a Valid email address!");
                    return true;
                }
                else {
                    alert("Indirizzo email non valido");
                    event.preventDefault();
                    return false;
                }
            }
        }


    </script>




    <style>
        .badge.BadgeTopBtn {
            margin-left: 0em;
            border-radius: 5px !important;
            font-size: x-large !important;
        }

        .TopBtn {
            padding: 4px !important;
        }

        .btn:not(.btn-just-icon):not(.btn-fab) .fa, .navbar .navbar-nav > li > a.btn:not(.btn-just-icon):not(.btn-fab) .fa {
            font-size: 30px !important;
        }
    </style>

    <style>
        .card .card-header.card-header-text {
            display: inline-block;
            padding-top: 15px !important;
        }

        .EditCaption {
            display: none !important;
        }
    </style>
    <style>
        .div1 {
            background-color: #f00;
        }

        .pp {
            color: #f00;
            -webkit-filter: invert(100%);
            filter: invert(100%);
        }

        div#MainContent_Cards_CallbackPnl_Generic_Gridview_DXPEForm_PW-1 {
            top: -75px !important;
        }
    </style>

    <div class="col-lg-2 col-md-3 col-sm-3">
        <div class="card">
            <div class="card-header card-header-text" data-background-color="blue">
                <h4 class="card-title">Tipologia utente</h4>
            </div>
            <div class="card-content">
                <div class="row">
                    <div class="col-lg-12">
                        <dx:ASPxGridView ID="grid" runat="server" KeyFieldName="RoleName" DataSourceID="Utenti_Dts" Width="100%" EnableRowsCache="false" AutoGenerateColumns="False" SettingsBehavior-AllowFocusedRow="true" OnFocusedRowChanged="grid_FocusedRowChanged">
                            <ClientSideEvents FocusedRowChanged="function(s,e){Cards_CallbackPnl.PerformCallback();}" />
                            <Settings ShowColumnHeaders="false" />
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="RoleName" VisibleIndex="0">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="0" Visible="false">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsPager PageSize="5" />
                        </dx:ASPxGridView>
                        <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" Text="Importazione massiva in corso..."></dx:ASPxLoadingPanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxCallback ID="Importa_Callback" ClientInstanceName="Importa_Callback" runat="server" OnCallback="Importa_Callback_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){LoadingPanel.Hide();TotaleFileTrovati_CallbackPnl.PerformCallback();}" />
    </dx:ASPxCallback>
    <div class="col-lg-10 col-md-9 col-sm-9">
        <div class="card">
            <div class="card-content">
                <script>
                    var comando;
                    function BeginCallbackGrid(s, e) {
                        comando = e.command;
                        //alert(comando);
                        //ADDNEWROW
                    }
                    function EndCallbackGrid(s, e) {
                        //alert(comando);
                        if (comando == "STARTEDIT") {
                            /*Password_Txt.SetVisible(false);*/
                            /* CheckPassword_Txt.SetVisible(false);*/
                            EditForm_CallbackPanel.PerformCallback(3);
                        }
                        else {
                            //Password_Txt.SetVisible(true);
                            //CheckPassword_Txt.SetVisible(true);
                        }
                        if (comando == "CUSTOMBUTTON") {
                            if (s.cpCambiaPassword == 1) {
                                UtenteDaMod_CallbackPnl.PerformCallback();
                            } else {
                                showNotification();
                            }

                        }
                    }
                </script>
                <dx:ASPxCallbackPanel ID="Cards_CallbackPnl" ClientInstanceName="Cards_CallbackPnl" runat="server" Width="100%" OnCallback="Cards_CallbackPnl_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxGridView SettingsBehavior-ConfirmDelete="true" SettingsText-ConfirmDelete="Confermi l'eliminazione dell'utente?" SettingsText-PopupEditFormCaption="Modifica/Inserisci utente" Styles-AlternatingRow-Enabled="True" ID="Generic_Gridview" ClientInstanceName="Generic_Gridview" DataSourceID="EditCardView_Dts" runat="server" Width="100%" AutoGenerateColumns="False" OnRowInserting="Generic_Gridview_RowInserting" OnRowUpdating="Generic_Gridview_RowUpdating" KeyFieldName="ID" OnStartRowEditing="Generic_Gridview_StartRowEditing" OnEditFormLayoutCreated="Generic_Gridview_EditFormLayoutCreated" OnRowDeleted="Generic_Gridview_RowDeleted" OnCustomButtonInitialize="Generic_Gridview_CustomButtonInitialize" OnCustomButtonCallback="Generic_Gridview_CustomButtonCallback" OnRowDeleting="Generic_Gridview_RowDeleting" OnRowInserted="Generic_Gridview_RowInserted">
                                <Styles AlternatingRow-Enabled="True"></Styles>
                                <Styles Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
                                <ClientSideEvents CustomButtonClick="
                           function(s,e){
                           if(e.buttonID == 'Riattiva')
                           {  

                           if (confirm('Sei sicuro di voler riattivare questo utente?'))  
                                {  
                                    e.processOnServer = true;  
                                }  
                                else  
                                {  
                                   e.processOnServer = false;  
                                }  
                           }
                            if(e.buttonID == 'Sospendi')
                            {  
                            if (confirm('Sei sicuro di voler sospendere questo utente?'))  
                                {  
                                    e.processOnServer = true;  
                                }  
                                else  
                                {  
                                   e.processOnServer = false;  
                                } 

                              }

                            if(e.buttonID == 'Password'){ 
                             
                             e.processOnServer = true;  
                                   
                                } 
                           }" />
                                <ClientSideEvents BeginCallback="BeginCallbackGrid" EndCallback="EndCallbackGrid" />
                                <SettingsPopup>
                                    <EditForm Modal="true" Width="1000px" HorizontalAlign="WindowCenter" VerticalAlign="TopSides">
                                    </EditForm>
                                </SettingsPopup>
                                <Styles>
                                    <AlternatingRow Enabled="True"></AlternatingRow>
                                </Styles>
                                <SettingsAdaptivity>
                                    <AdaptiveDetailLayoutProperties ColCount="2">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                    </AdaptiveDetailLayoutProperties>
                                </SettingsAdaptivity>
                                <SettingsPager PageSize="100" Visible="False"></SettingsPager>
                                <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />

                                <Settings ShowFilterRow="True"></Settings>

                                <SettingsPopup EditForm-Modal="true" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter">
                                    <EditForm HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" AllowResize="True" Modal="True"></EditForm>
                                </SettingsPopup>
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
                                <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true"></SettingsDataSecurity>
                                <EditFormLayoutProperties ColCount="2">
                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                                </EditFormLayoutProperties>
                                <Columns>
                                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowClearFilterButton="True">
                                        <CustomButtons>
                                            <dx:GridViewCommandColumnCustomButton ID="Riattiva">
                                                <Image Url="~/assets/img/DevExButton/Start-on-go.png" Width="30px">
                                                </Image>
                                            </dx:GridViewCommandColumnCustomButton>
                                            <dx:GridViewCommandColumnCustomButton ID="Sospendi">
                                                <Image Url="~/assets/img/DevExButton/stop.png" Width="30px">
                                                </Image>
                                            </dx:GridViewCommandColumnCustomButton>
                                            <dx:GridViewCommandColumnCustomButton ID="Password" Image-ToolTip="Modifica password">
                                                <Image Url="../../assets/img/DevExButton/Cambia.png" Width="30px">
                                                </Image>
                                            </dx:GridViewCommandColumnCustomButton>
                                        </CustomButtons>
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="UtenteIntranet" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="EmailContatto" VisibleIndex="2" Visible="false"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Cognome" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Nome" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="DataBlocco" Caption="Data scadenza" VisibleIndex="3"></dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn FieldName="LastActivityDate" Caption="Ultima attività" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn VisibleIndex="5" FieldName="Scaduto"></dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataTextColumn VisibleIndex="6" FieldName="CodAge" Visible="false"></dx:GridViewDataTextColumn>
                                </Columns>
                                <Templates>
                                    <EditForm>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <dx:ASPxCallbackPanel runat="server" ID="EditForm_CallbackPanel" ClientInstanceName="EditForm_CallbackPanel" Width="100%" OnCallback="EditForm_CallbackPanel_Callback">
                                                    <ClientSideEvents EndCallback="function(s,e){ 
                                              if(ASPxClientEdit.ValidateGroup('NuovoUtenteValid')){
                                                                                if(EditForm_CallbackPanel.cpDatiValidi == 1){
                                                Cards_CallbackPnl.PerformCallback();
                                                showNotification();
                                                delete EditForm_CallbackPanel.cpDatiValidi;}
                                                                            }
                                                if(EditForm_CallbackPanel.cpUpdate == 1)
                                                {
                                                 Cards_CallbackPnl.PerformCallback();
                                                showNotification();
                                               delete EditForm_CallbackPanel.cpUpdate;
                                                }
                                                }" />
                                                    <PanelCollection>
                                                        <dx:PanelContent>
                                                            <dx:ASPxFormLayout ID="Edit_FormLayout" ClientInstanceName="Edit_FormLayout" runat="server" Width="100%">
                                                                <Items>
                                                                    <dx:LayoutGroup ColumnCount="12" Caption="Utente intranet" Paddings-Padding="0">
                                                                        <Items>
                                                                            <dx:LayoutItem Caption="Nome utente" ColumnSpan="2" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="NomeUtenteIntranet_Txt" Caption="Nome utente" CaptionSettings-Position="Top" EnableClientSideAPI="True" ClientInstanceName="NomeUtenteIntranet_Txt" Width="100%" Text='<%# Bind("UtenteIntranet") %>' ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                                            <ClientSideEvents Validation="function(s,e){
                                                                                        if(EditForm_CallbackPanel.cpNomeUtenteValido != null)
                                                                                        {     
                                                                                               if(EditForm_CallbackPanel.cpNomeUtenteValido == 1 )
                                                                                               {
                                                                                                     e.isValid = true;
                                                                                                     delete EditForm_CallbackPanel.cpNomeUtenteValido; 
                                                                                                     return false;
                                                                                               }
                                                                                               else
                                                                                               {
                                                                                                    e.isValid = false;
                                                                                                    delete EditForm_CallbackPanel.cpNomeUtenteValido; 
                                                                                                    return true;
                                                                                               }
                                                                                        }
                                                                                        else
                                                                                        {    
                                                                                            if(NomeUtenteIntranet_Txt.GetText() != '')
                                                                                             {   
                                                                                                e.isValid = true;
                                                                                             }
                                                                                        }
                                                                                               }" />
                                                                                            <ValidationSettings ValidateOnLeave="false" ErrorDisplayMode="None">
                                                                                                <RequiredField IsRequired="true" />
                                                                                            </ValidationSettings>
                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Password" ColumnSpan="2" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="Password_Txt" Caption="Password" CaptionSettings-Position="Top" EnableClientSideAPI="True" ClientInstanceName="Password_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                                            <ValidationSettings ErrorDisplayMode="None">
                                                                                                <RequiredField IsRequired="true" />
                                                                                            </ValidationSettings>
                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                        </dx:ASPxTextBox>

                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem Caption="Conferma password" ColumnSpan="2" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="CheckPassword_Txt" Caption="Conferma password" CaptionSettings-Position="Top" EnableClientSideAPI="True" ClientInstanceName="CheckPassword_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                                            <ClientSideEvents Validation="function(s, e) {
	                                                                                                    var originalPasswd = Password_Txt.GetText();
                                                                                                        var currentPasswd = s.GetText();
                                                                                                        e.isValid = (originalPasswd  == currentPasswd );
                                                                                                    }" />
                                                                                            <ValidationSettings ErrorDisplayMode="None">
                                                                                                <RequiredField IsRequired="true" />
                                                                                            </ValidationSettings>
                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>


                                                                            <%--<dx:LayoutItem Caption="Email" ColumnSpan="4" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox AutoCompleteType="Email" Caption="Email Registrazione" CaptionSettings-Position="Top" EnableClientSideAPI="True" runat="server" ID="Email_Txt" ClientInstanceName="Email_Txt" Width="100%" Text='<%# Bind("EmailContatto") %>' ValidationSettings-ValidationGroup="NuovoUtenteValid">
                                                                                            <ClientSideEvents Validation="
                                                                                        function(s,e)
                                                                                        { e.isValid = false;
                                                                                            if(ValidateEmail(s.GetValue())){
                                                                                            if(EditForm_CallbackPanel.cpEmailValido != null)
                                                                                              {
                                                                                               if(EditForm_CallbackPanel.cpEmailValido == 1)
                                                                                                    {
                                                                                                        e.isValid = true;
                                                                                      
                                                                                                        delete EditForm_CallbackPanel.cpEmailValido; 
                                                                                                        return false;
                                                                                                    }
                                                                                               else
                                                                                                     {
                                                                                                         e.isValid = false;
                                                                                                         alert('questa mail è già presente nel sistema');
                                                                                                         delete EditForm_CallbackPanel.cpEmailValido; 
                                                                                                         return true;
                                                                                                     }
                                                                                             } 
                                                                                            else
                                                                                             {
                                                                                               if(Email_Txt.GetText() != '')
                                                                                                     {
                                                                                                         e.isValid = true;
                                                                                                     }
                                                                                             }}
                                                                                        }" />
                                                                                            <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="None">
                                                                                                <RegularExpression ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorText="Email non valida" />
                                                                                                <RequiredField IsRequired="True" ErrorText="Obbligatoria" />
                                                                                            </ValidationSettings>
                                                                                            <InvalidStyle BackColor="LightPink" />

                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>--%>
                                                                            <dx:LayoutItem Caption="Data scadenza account" ColumnSpan="2" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxDateEdit ID="DataBlocco_DateEdit" Caption="Data scadenza account" CaptionSettings-Position="Top" EnableClientSideAPI="True" ClientInstanceName="DataBlocco_DateEdit" Width="100%" runat="server" Value='<%# Bind("DataBlocco") %>' ValidationSettings-ValidationGroup="NuovoUtenteValid" OnDataBinding="DataBlocco_DateEdit_DataBinding">
                                                                                        </dx:ASPxDateEdit>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>

                                                                        </Items>
                                                                    </dx:LayoutGroup>
                                                                    <dx:LayoutGroup ColumnCount="12" Caption="Anagrafica utente" Paddings-Padding="0">
                                                                        <Items>
                                                                            <dx:LayoutItem ColumnSpan="4" Caption="Codice agente" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTokenBox ID="CodAge_Combobox" Caption="Codice agente" CaptionSettings-Position="Top" runat="server" ItemValueType="System.String" TextField="CodAge" ValueField="ID" DataSourceID="Agenti_Dts" Width="100%" OnDataBinding="CodAge_Combobox_DataBinding">
                                                                                            <ClientSideEvents ValueChanged="ControlloNumeroTocken" />
                                                                                            <ValidationSettings ValidationGroup="NuovoUtenteValid" ErrorDisplayMode="None">
                                                                                                <RequiredField IsRequired="true" />
                                                                                            </ValidationSettings>
                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                        </dx:ASPxTokenBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem ColumnSpan="2" Caption="Nome" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" ID="Nome_txt" CaptionCellStyle-CssClass="dxflHALSys dxflVATSys dxflCaptionCell_Office365 dxflCaptionCellSys" Caption="Nome" CaptionSettings-Position="Top" ClientInstanceName="Nome_txt" Width="100%">
                                                                                            <ValidationSettings ErrorDisplayMode="None" ValidationGroup="NuovoUtenteValid">
                                                                                                <RequiredField IsRequired="true" />
                                                                                            </ValidationSettings>
                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>
                                                                            <dx:LayoutItem ColumnSpan="2" Caption="Cognome" ShowCaption="False" RequiredMarkDisplayMode="Hidden">
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <dx:ASPxTextBox runat="server" CaptionCellStyle-CssClass="dxflCaption_Office365" Caption="Cognome" CaptionSettings-Position="Top" ID="Cognome_Txt" ClientInstanceName="Cognome_Txt" Width="100%">
                                                                                            <ValidationSettings ErrorDisplayMode="None" ValidationGroup="NuovoUtenteValid">
                                                                                                <RequiredField IsRequired="true" />
                                                                                            </ValidationSettings>
                                                                                            <InvalidStyle BackColor="LightPink" />
                                                                                        </dx:ASPxTextBox>
                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <CaptionSettings VerticalAlign="Top" Location="Top" />
                                                                            </dx:LayoutItem>
                                                                        </Items>
                                                                    </dx:LayoutGroup>
                                                                </Items>
                                                            </dx:ASPxFormLayout>
                                                            <dx:ASPxFormLayout runat="server" ID="RagioneSociale_fl" ClientInstanceName="RagioneSociale_fl" Width="100%" Paddings-Padding="0" BackColor="White" ValidateRequestMode="Disabled" ClientVisible="false">
                                                                <SettingsAdaptivity AdaptivityMode="Off" SwitchToSingleColumnAtWindowInnerWidth="800"></SettingsAdaptivity>
                                                                <Border BorderWidth="0px" />
                                                                <Items>
                                                                    <dx:LayoutGroup ColumnCount="12" Caption="" ShowCaption="False" Paddings-Padding="0">
                                                                        <Border BorderStyle="None" BorderWidth="0px"></Border>

                                                                        <Paddings Padding="0px"></Paddings>
                                                                        <Items>
                                                                            <dx:LayoutItem Caption="" ColumnSpan="12" ShowCaption="False" RequiredMarkDisplayMode="Hidden" Border-BorderStyle="None">
                                                                                <Border BorderWidth="0px" />
                                                                                <LayoutItemNestedControlCollection>
                                                                                    <dx:LayoutItemNestedControlContainer>
                                                                                        <div class="col-md-12 no-padding" style="padding-top: 15px;">
                                                                                            <%-- Prima riga (Ragione sociale,Nazione,Agente)--%>
                                                                                            <div class="col-md-9">
                                                                                                <dx:ASPxTextBox ID="Denom_text" ClientInstanceName="Denom_text" Caption="Ragione Sociale" CaptionCellStyle-CssClass="dx-caption" Width="100%" runat="server">
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px"></CaptionCellStyle>
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid" ValidateOnLeave="false">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxTextBox>
                                                                                            </div>
                                                                                            <div class="col-md-3">
                                                                                                <dx:ASPxComboBox runat="server" ID="Nazione_Combox" ClientInstanceName="Nazione_Combox" Width="100%" Caption="Nazione" DataSourceID="Nazioni_Dts" ValueField="CodNaz" TextField="Descrizione" ValueType="System.String">
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxComboBox>

                                                                                            </div>




                                                                                            <%-- Riga due (Ind,Prov,Cap,Loc) --%>
                                                                                            <div class="col-md-5">
                                                                                                <dx:ASPxTextBox ID="Indirizzo_Txt" ClientInstanceName="Indirizzo_Txt" Caption="Indirizzo:" Width="100%" runat="server">
                                                                                                    <%--<CssClasses Caption="TitleCell"></CssClasses>--%>
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxTextBox>
                                                                                            </div>
                                                                                            <div class="col-md-2">
                                                                                                <dx:ASPxComboBox ID="Provincia_Combobox" ClientInstanceName="Provincia_Combobox" Caption="Provincia:" runat="server" Width="100%">
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ClearButton DisplayMode="Always"></ClearButton>
                                                                                                    <Items>
                                                                                                        <dx:ListEditItem Text="AG" Value="AG" />
                                                                                                        <dx:ListEditItem Text="AL" Value="AL" />
                                                                                                        <dx:ListEditItem Text="AN" Value="AN" />
                                                                                                        <dx:ListEditItem Text="AO" Value="AO" />
                                                                                                        <dx:ListEditItem Text="AQ" Value="AQ" />
                                                                                                        <dx:ListEditItem Text="AR" Value="AR" />
                                                                                                        <dx:ListEditItem Text="AP" Value="AP" />
                                                                                                        <dx:ListEditItem Text="AT" Value="AT" />
                                                                                                        <dx:ListEditItem Text="AV" Value="AV" />
                                                                                                        <dx:ListEditItem Text="BA" Value="BA" />
                                                                                                        <dx:ListEditItem Text="BT" Value="BT" />
                                                                                                        <dx:ListEditItem Text="BL" Value="BL" />
                                                                                                        <dx:ListEditItem Text="BN" Value="BN" />
                                                                                                        <dx:ListEditItem Text="BG" Value="BG" />
                                                                                                        <dx:ListEditItem Text="BI" Value="BI" />
                                                                                                        <dx:ListEditItem Text="BO" Value="BO" />
                                                                                                        <dx:ListEditItem Text="BZ" Value="BZ" />
                                                                                                        <dx:ListEditItem Text="BS" Value="BS" />
                                                                                                        <dx:ListEditItem Text="BR" Value="BR" />
                                                                                                        <dx:ListEditItem Text="CA" Value="CA" />
                                                                                                        <dx:ListEditItem Text="CL" Value="CL" />
                                                                                                        <dx:ListEditItem Text="CB" Value="CB" />
                                                                                                        <dx:ListEditItem Text="CI" Value="CI" />
                                                                                                        <dx:ListEditItem Text="CE" Value="CE" />
                                                                                                        <dx:ListEditItem Text="CT" Value="CT" />
                                                                                                        <dx:ListEditItem Text="CZ" Value="CZ" />
                                                                                                        <dx:ListEditItem Text="CH" Value="CH" />
                                                                                                        <dx:ListEditItem Text="CO" Value="CO" />
                                                                                                        <dx:ListEditItem Text="CS" Value="CS" />
                                                                                                        <dx:ListEditItem Text="CR" Value="CR" />
                                                                                                        <dx:ListEditItem Text="KR" Value="KR" />
                                                                                                        <dx:ListEditItem Text="CN" Value="CN" />
                                                                                                        <dx:ListEditItem Text="EN" Value="EN" />
                                                                                                        <dx:ListEditItem Text="FM" Value="FM" />
                                                                                                        <dx:ListEditItem Text="FE" Value="FE" />
                                                                                                        <dx:ListEditItem Text="FI" Value="FI" />
                                                                                                        <dx:ListEditItem Text="FG" Value="FG" />
                                                                                                        <dx:ListEditItem Text="FC" Value="FC" />
                                                                                                        <dx:ListEditItem Text="FR" Value="FR" />
                                                                                                        <dx:ListEditItem Text="GE" Value="GE" />
                                                                                                        <dx:ListEditItem Text="GO" Value="GO" />
                                                                                                        <dx:ListEditItem Text="GR" Value="GR" />
                                                                                                        <dx:ListEditItem Text="IM" Value="IM" />
                                                                                                        <dx:ListEditItem Text="IS" Value="IS" />
                                                                                                        <dx:ListEditItem Text="SP" Value="SP" />
                                                                                                        <dx:ListEditItem Text="LT" Value="LT" />
                                                                                                        <dx:ListEditItem Text="LE" Value="LE" />
                                                                                                        <dx:ListEditItem Text="LC" Value="LC" />
                                                                                                        <dx:ListEditItem Text="LI" Value="LI" />
                                                                                                        <dx:ListEditItem Text="LO" Value="LO" />
                                                                                                        <dx:ListEditItem Text="LU" Value="LU" />
                                                                                                        <dx:ListEditItem Text="MC" Value="MC" />
                                                                                                        <dx:ListEditItem Text="MN" Value="MN" />
                                                                                                        <dx:ListEditItem Text="MS" Value="MS" />
                                                                                                        <dx:ListEditItem Text="MT" Value="MT" />
                                                                                                        <dx:ListEditItem Text="VS" Value="VS" />
                                                                                                        <dx:ListEditItem Text="ME" Value="ME" />
                                                                                                        <dx:ListEditItem Text="MI" Value="MI" />
                                                                                                        <dx:ListEditItem Text="MO" Value="MO" />
                                                                                                        <dx:ListEditItem Text="MB" Value="MB" />
                                                                                                        <dx:ListEditItem Text="NA" Value="NA" />
                                                                                                        <dx:ListEditItem Text="NO" Value="NO" />
                                                                                                        <dx:ListEditItem Text="NU" Value="NU" />
                                                                                                        <dx:ListEditItem Text="OG" Value="OG" />
                                                                                                        <dx:ListEditItem Text="OT" Value="OT" />
                                                                                                        <dx:ListEditItem Text="OR" Value="OR" />
                                                                                                        <dx:ListEditItem Text="PD" Value="PD" />
                                                                                                        <dx:ListEditItem Text="PA" Value="PA" />
                                                                                                        <dx:ListEditItem Text="PR" Value="PR" />
                                                                                                        <dx:ListEditItem Text="PV" Value="PV" />
                                                                                                        <dx:ListEditItem Text="PG" Value="PG" />
                                                                                                        <dx:ListEditItem Text="PU" Value="PU" />
                                                                                                        <dx:ListEditItem Text="PE" Value="PE" />
                                                                                                        <dx:ListEditItem Text="PC" Value="PC" />
                                                                                                        <dx:ListEditItem Text="PI" Value="PI" />
                                                                                                        <dx:ListEditItem Text="PT" Value="PT" />
                                                                                                        <dx:ListEditItem Text="PN" Value="PN" />
                                                                                                        <dx:ListEditItem Text="PZ" Value="PZ" />
                                                                                                        <dx:ListEditItem Text="PO" Value="PO" />
                                                                                                        <dx:ListEditItem Text="RG" Value="RG" />
                                                                                                        <dx:ListEditItem Text="RA" Value="RA" />
                                                                                                        <dx:ListEditItem Text="RC" Value="RC" />
                                                                                                        <dx:ListEditItem Text="RE" Value="RE" />
                                                                                                        <dx:ListEditItem Text="RI" Value="RI" />
                                                                                                        <dx:ListEditItem Text="RN" Value="RN" />
                                                                                                        <dx:ListEditItem Text="RM" Value="RM" />
                                                                                                        <dx:ListEditItem Text="RO" Value="RO" />
                                                                                                        <dx:ListEditItem Text="SA" Value="SA" />
                                                                                                        <dx:ListEditItem Text="SS" Value="SS" />
                                                                                                        <dx:ListEditItem Text="SV" Value="SV" />
                                                                                                        <dx:ListEditItem Text="SI" Value="SI" />
                                                                                                        <dx:ListEditItem Text="SR" Value="SR" />
                                                                                                        <dx:ListEditItem Text="SO" Value="SO" />
                                                                                                        <dx:ListEditItem Text="TA" Value="TA" />
                                                                                                        <dx:ListEditItem Text="TE" Value="TE" />
                                                                                                        <dx:ListEditItem Text="TR" Value="TR" />
                                                                                                        <dx:ListEditItem Text="TO" Value="TO" />
                                                                                                        <dx:ListEditItem Text="TP" Value="TP" />
                                                                                                        <dx:ListEditItem Text="TN" Value="TN" />
                                                                                                        <dx:ListEditItem Text="TV" Value="TV" />
                                                                                                        <dx:ListEditItem Text="TS" Value="TS" />
                                                                                                        <dx:ListEditItem Text="UD" Value="UD" />
                                                                                                        <dx:ListEditItem Text="VA" Value="VA" />
                                                                                                        <dx:ListEditItem Text="VE" Value="VE" />
                                                                                                        <dx:ListEditItem Text="VB" Value="VB" />
                                                                                                        <dx:ListEditItem Text="VC" Value="VC" />
                                                                                                        <dx:ListEditItem Text="VR" Value="VR" />
                                                                                                        <dx:ListEditItem Text="VV" Value="VV" />
                                                                                                        <dx:ListEditItem Text="VI" Value="VI" />
                                                                                                        <dx:ListEditItem Text="VT" Value="VT" />
                                                                                                        <dx:ListEditItem Text="EE" Value="EE" />
                                                                                                    </Items>
                                                                                                    <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid"></ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxComboBox>
                                                                                            </div>
                                                                                            <div class="col-md-2">
                                                                                                <dx:ASPxTextBox ID="Cap_text" ClientInstanceName="Cap_text" Caption="Cap:" CssClasses-Caption="TitleCell" Width="100%" runat="server" MaxLength="5">
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />

                                                                                                </dx:ASPxTextBox>
                                                                                            </div>
                                                                                            <div class="col-md-3">
                                                                                                <dx:ASPxTextBox ID="Local_Txt" ClientInstanceName="Local_Txt" Caption="Località" Width="100%" runat="server">
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxTextBox>
                                                                                            </div>

                                                                                            <%-- Riga tre (Referente,Email,Telefono) --%>

                                                                                            <div class="col-md-4">
                                                                                                <dx:ASPxTextBox runat="server" ID="SitoWeb_txt" ClientInstanceName="SitoWeb_txt" Width="100%" Caption="Sito Web">
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />

                                                                                                </dx:ASPxTextBox>
                                                                                            </div>
                                                                                            <div class="col-md-4">
                                                                                                <dx:ASPxTextBox ID="EMail_text" ClientInstanceName="EMail_text" Caption="EMail:" Width="100%" runat="server">
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="NuovoUtenteValid" RegularExpression-ValidationExpression="^\w+([-+.'%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorDisplayMode="None">
                                                                                                        <RegularExpression ValidationExpression="^\w+([-+.&#39;%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"></RegularExpression>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxTextBox>
                                                                                            </div>
                                                                                            <div class="col-md-4">
                                                                                                <dx:ASPxTextBox ID="Tel_text" ClientInstanceName="Tel_text" Caption="Tel:" Width="100%" runat="server">
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="none" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxTextBox>
                                                                                            </div>

                                                                                            <div class="col-md-4">
                                                                                                <dx:ASPxTextBox ID="PIva_text" ClientInstanceName="PIva_text" Caption="P.Iva:" runat="server" MaxLength="11" Width="100%">
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ValidationSettings CausesValidation="true" ValidateOnLeave="true" RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />
                                                                                                </dx:ASPxTextBox>
                                                                                            </div>
                                                                                            <div class="col-md-3">
                                                                                                <dx:ASPxSpinEdit runat="server" ID="Ricarico_spin" ClientInstanceName="Ricarico_spin" Caption="Percentuale ricarico" DisplayFormatString="{0}%" MinValue="0" MaxValue="100" ClearButton-DisplayMode="Always" Number="10">
                                                                                                    <CaptionSettings Position="Top" />
                                                                                                    <CaptionCellStyle Paddings-PaddingBottom="10px" CssClass="dx-caption"></CaptionCellStyle>
                                                                                                    <ValidationSettings CausesValidation="false" ValidateOnLeave="false" RequiredField-IsRequired="true" ErrorDisplayMode="None" ValidationGroup="NuovoUtenteValid">
                                                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                                                    </ValidationSettings>
                                                                                                    <InvalidStyle BackColor="LightPink" />

                                                                                                </dx:ASPxSpinEdit>
                                                                                            </div>

                                                                                        </div>

                                                                                    </dx:LayoutItemNestedControlContainer>
                                                                                </LayoutItemNestedControlCollection>
                                                                                <Paddings Padding="0px"></Paddings>

                                                                            </dx:LayoutItem>



                                                                            <%-- Non usato --%>
                                                                        </Items>
                                                                    </dx:LayoutGroup>
                                                                </Items>
                                                                <Paddings Padding="0px"></Paddings>
                                                            </dx:ASPxFormLayout>
                                                            <div class="col-lg-12 text-right">
                                                                <dx:BootstrapButton runat="server" Text="" ClientInstanceName="Salva_Btn" ID="Salva_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ValidationGroup="NuovoUtenteValid">
                                                                    <ClientSideEvents Click="function(s,e){ 
                                                            if(ASPxClientEdit.ValidateGroup('NuovoUtenteValid')){EditForm_CallbackPanel.PerformCallback(1);}}" />
                                                                    <Badge Text="SALVA" IconCssClass="fa fa-save" />
                                                                    <SettingsBootstrap RenderOption="Success" />
                                                                </dx:BootstrapButton>
                                                                <dx:BootstrapButton runat="server" Text="" ClientInstanceName="SalvaEdit_Btn" ID="SalvaEdit_Btn" ClientVisible="false" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ValidationGroup="NuovoUtenteValid">
                                                                    <ClientSideEvents Click="function(s,e){  if(ASPxClientEdit.ValidateGroup('NuovoUtenteValid')){
                                                             EditForm_CallbackPanel.PerformCallback(2);}}" />
                                                                    <Badge Text="SALVA MODIFICHE" IconCssClass="fa fa-save" />
                                                                    <SettingsBootstrap RenderOption="Success" />
                                                                </dx:BootstrapButton>
                                                            </div>
                                                        </dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>
                                            </div>
                                        </div>
                                    </EditForm>
                                </Templates>
                            </dx:ASPxGridView>

                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </div>
        </div>

    </div>
    <dx:ASPxPopupControl ID="CambiaPassword_Popup" HeaderText="Modifica password" ClientInstanceName="CambiaPassword_Popup" runat="server" Width="700px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides">
        <ContentCollection>
            <dx:PopupControlContentControl>

                <dx:ASPxCallbackPanel runat="server" ID="UtenteDaMod_CallbackPnl" ClientInstanceName="UtenteDaMod_CallbackPnl" Width="100%" OnCallback="UtenteDaMod_CallbackPnl_Callback">
                    <ClientSideEvents EndCallback="function(s,e){CambiaPassword_Popup.Show();ModPassword_Txt.SetText('');CheckModPassword_Txt.SetText('');}" />
                    <PanelCollection>
                        <dx:PanelContent>
                            Utente:
                                <dx:ASPxLabel runat="server" ID="UtenteModPassword_Lbl" Font-Size="Large"></dx:ASPxLabel>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>

                <br />
                <dx:ASPxTextBox runat="server" ID="ModPassword_Txt" Caption="Nuova password" Password="true" EnableClientSideAPI="True" ClientInstanceName="ModPassword_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid">
                    <ValidationSettings ValidationGroup="ModPasswordValid" ErrorDisplayMode="None">
                        <RequiredField IsRequired="true" />
                    </ValidationSettings>
                    <InvalidStyle BackColor="LightPink" />
                    <CaptionSettings Position="Top" />
                </dx:ASPxTextBox>
                <dx:ASPxTextBox runat="server" ID="CheckModPassword_Txt" Caption="Conferma nuova password" Password="true" EnableClientSideAPI="True" ClientInstanceName="CheckModPassword_Txt" Width="100%" ValidationSettings-ValidationGroup="NuovoUtenteValid">
                    <ClientSideEvents Validation="function(s, e) {
	                                        var originalPasswd = ModPassword_Txt.GetText();
                                            var currentPasswd = s.GetText();
                                            e.isValid = (originalPasswd  == currentPasswd );
                                        }" />
                    <ValidationSettings ValidationGroup="ModPasswordValid" ErrorDisplayMode="None">
                        <RequiredField IsRequired="true" />
                    </ValidationSettings>
                    <InvalidStyle BackColor="LightPink" />
                    <CaptionSettings Position="Top" />
                </dx:ASPxTextBox>

                <dx:BootstrapButton runat="server" Text="" ClientInstanceName="SalvaPsw_Btn" ID="SalvaPsw_Btn" AutoPostBack="false" Badge-CssClass="BadgeBtn" CssClasses-Control="btn btn-sm btn-custom-padding" ValidationGroup="NuovoUtenteValid">
                    <ClientSideEvents Click="function(s,e){ 
                                                            if(ASPxClientEdit.ValidateGroup('ModPasswordValid')){
                                                            
                                                            SalvaPsw_Callback.PerformCallback();
                                                            } }" />
                    <Badge Text="SALVA PASSWORD" IconCssClass="fa fa-save" />
                    <SettingsBootstrap RenderOption="Success" />
                </dx:BootstrapButton>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxCallback ID="SalvaPsw_Callback" ClientInstanceName="SalvaPsw_Callback" runat="server" OnCallback="SalvaPsw_Callback_Callback">
        <ClientSideEvents EndCallback="function(s,e){showNotification();CambiaPassword_Popup.Hide();}" />
    </dx:ASPxCallback>

    <asp:SqlDataSource ID="Agenti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT ID, CodAge FROM CRM4U_Agenti WHERE (UsernameIntra IS NULL)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Utenti_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT RoleName, Description FROM aspnet_Roles WHERE (Description LIKE '%AbilitaFrontEnd%')"></asp:SqlDataSource>
    <asp:SqlDataSource ID="EditCardView_Dts" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT DISTINCT VIO_Utenti.ID, VIO_Utenti.UtenteIntranet, VIO_Utenti.EmailContatto, VIO_Utenti.DataBlocco, aspnet_Users.LastActivityDate, aspnet_Membership.Password, VIO_Utenti.Scaduto, VIO_Utenti.Nome, VIO_Utenti.Cognome, VIO_Utenti.CodAge, VIO_Utenti.TipoAge FROM VIO_Utenti LEFT OUTER JOIN aspnet_Membership INNER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId AND aspnet_Membership.UserId = aspnet_Users.UserId AND aspnet_Membership.UserId = aspnet_Users.UserId AND aspnet_Membership.UserId = aspnet_Users.UserId ON VIO_Utenti.UtenteIntranet = aspnet_Users.UserName WHERE (VIO_Utenti.Tipologia = @Tipologia)" InsertCommand="VIO_Utenti_Insert_CRM4U" InsertCommandType="StoredProcedure" UpdateCommand="UPDATE VIO_Utenti SET  DataBlocco = @DataBlocco where ID = @ID" DeleteCommand="VIO_Utenti_Delete" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UtenteIntranet"></asp:Parameter>
            <asp:Parameter Name="EmailContatto"></asp:Parameter>
            <asp:Parameter Name="DataBlocco"></asp:Parameter>
            <asp:Parameter Name="Tipologia"></asp:Parameter>
            <asp:Parameter Name="Azienda"></asp:Parameter>
            <asp:Parameter Name="CodAge"></asp:Parameter>
            <asp:Parameter Name="Nome"></asp:Parameter>
            <asp:Parameter Name="Cognome"></asp:Parameter>
            <asp:Parameter Name="TipoAge"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="TipologiaSession" Name="Tipologia"></asp:SessionParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DataBlocco"></asp:Parameter>
            <asp:Parameter Name="ID"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="Nazioni_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT CodNaz, Descrizione FROM TabNaz"></asp:SqlDataSource>

</asp:Content>
