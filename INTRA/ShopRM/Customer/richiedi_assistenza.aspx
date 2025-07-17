<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="richiedi_assistenza.aspx.cs" Inherits="INTRA.ShopRM.Customer.richiedi_assistenza" %>

<%@ Register Src="~/ShopRM/Customer/Controls/LeftMenuCustomer.ascx" TagPrefix="uc1" TagName="LeftMenuCustomer" %>
<%@ Register Src="~/ShopRM/Controls/MyMessageBox.ascx" TagPrefix="msgbox" TagName="MyMessageBox" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .min-heigth {
            min-height: 150px !important;
        }

        .btn-container {
            margin: 0 auto;
            padding-top: 10px !important;
            text-align: right;
            width: 100%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">

    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuCustomer runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">Richiedi Assistenza</h2>
            </div>
            <div class="article-container">
                <h3 class="block-title inline-product-column-title">Come Funziona?</h3>
                <p>
                    Per tutte le tue richieste di assistenza puoi utilizzare il contact form di questa pagina.
                   
                </p>

                <p>
                    Compila con cura in ogni sua parte e la tua richiesta verrà inoltrata direttamente ai nostri tecnici che provvederanno a contattarti tempestivamente sul tuo indirizzo e- mail.
                   
                </p>

                <div class="col-md-12 col-sm-12">
                    <dx:ASPxTextBox runat="server" ID="Oggetto_txt" ClientInstanceName="Oggetto_txt" Width="100%" Caption="Oggetto richiesta" CaptionSettings-Position="Top">
                        <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="ValidEmail" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink"></ValidationSettings>
                        <InvalidStyle BackColor="LightPink" />
                    </dx:ASPxTextBox>

                </div>
                <div class="col-md-12 col-sm-12">
                    <dx:ASPxMemo runat="server" ID="Message_memo" ClientInstanceName="Message_memo" Width="100%" Height="100%" CssClass="min-heigth" Caption="Richiesta" CaptionSettings-Position="Top">
                        <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="ValidEmail" ErrorDisplayMode="None" ErrorFrameStyle-BackColor="LightPink"></ValidationSettings>
                        <InvalidStyle BackColor="LightPink" />

                    </dx:ASPxMemo>
                </div>
                <div class="col-md-12 btn-container">
                    <dx:BootstrapButton ID="BootstrapButton1" ClientInstanceName="Salva_Btn" runat="server" AutoPostBack="false" ValidationGroup="NuovoProspectValidator"
                        rel="tooltip" data-placement="top" data-original-title="Salva" Text="INVIA" UseSubmitBehavior="false" CssClasses-Control="button style-12">


                        <ClientSideEvents
                            Click="function(s,e){
                                            if (ASPxClientEdit.ValidateGroup('ValidEmail')) {                                                     
                                                      InviaEmail_callback.PerformCallback();
                                             }else{
                                                    showNotificationErrortoastr('Compilare prima tutti i campi richiesti');
                                                }
                                            } " />
                    </dx:BootstrapButton>
                </div>
                <dx:ASPxCallback runat="server" ID="InviaEmail_callback" ClientInstanceName="InviaEmail_callback" OnCallback="InviaEmail_callback_Callback">
                    <ClientSideEvents CallbackError="function(s,e){
                        showNotificationErrortoastr(s.cpError);
                        }"
                        EndCallback="function(s,e){
                        var container = document.getElementsByClassName('information-entry')[0];
                        ASPxClientEdit.ClearEditorsInContainer(container);
                        showNotificationtoastr();
                        }" />
                </dx:ASPxCallback>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
