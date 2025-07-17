<%@ Page Title="" Language="C#" MasterPageFile="~/SiteRBUtente.Master" AutoEventWireup="true" CodeBehind="Default_2.aspx.cs" Inherits="INTRA.Age_Ordini.BR_Documenti.Default_2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <dx:ASPxHiddenField runat="server" ID="Hf_Hf" ClientInstanceName="Hf_Hf"></dx:ASPxHiddenField>
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-yellow">
                    <span class="widget-caption" style="float: inherit !important;">
                        <div style="float: left;">Documenti Online</div>
                        <div style="float: right; padding-right: 10px; padding-top: 4px;">
                        </div>
                    </span>

                    <div class="widget-buttons">
                    </div>
                </div>
                <style>
                    th > input {
                        width: auto;
                        max-width: 150px;
                    }

                    .profile-container .profile-header {
                        min-height: 100px;
                        margin: 15px 0px 0;
                    }

                    .p1 {
                        background-color: rgba(255, 242, 0, 0.60);
                    }
                </style>
                <div class="widget-body">
                    <fieldset>
                        <asp:Panel ID="Panel1" runat="server" Visible="true">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="320"
                                    NullText="Seleziona i file da caricare..." UploadMode="Advanced" FileUploadMode="OnPageLoad" ShowUploadButton="false" ShowProgressPanel="True"
                                    OnFileUploadComplete="UploadControl_FileUploadComplete" Theme="MetropolisBlue">
                                    <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="True" />
                                    <ValidationSettings
                                   MaxFileSize="9999999999999999" AllowedFileExtensions=".pdf, .xps, .oxps, .xpz, .docx, .docm, .dotx, .dotm, .doc, .dot, .rtf, .odt, .ott, .xlsx, .xlsm, .xltx, .xltm, .xlam, .xlsb, .xls, .xlt, .xml, .csv, .tsv, .dif, .ods, .ots, .pptx, .pptm, .potx, .potm, .ppsx, .ppsm, .ppt, .pps, .odp, .otp, .vsdx, .vsdm, .vstx, .vstm, .vssx, .vssm, .vdx, .vsx, .vtx, .vsd, .vss, .vst, .vdw, .mpp, .mpt, .mpx, .msg, .eml, .emlx, .epub, .mobi, .html, .htm, .mht, .mhtml, .web, .txt, .dwg, .dxf, .tif, .tiff, .djvu, .dcm, .ps, .svg, .emf, .xaml, .psd, .jpg, .jpeg, .jpe, .jfif, .jp2, .jpf, .jpx, .j2k, .j2c, .jpc, .jxr, .wdp, .hdp, .png, .gif, .webp, .bmp, .wmf, .dib">
                                    </ValidationSettings>
                                    <ClientSideEvents FileUploadComplete="onFileUploadComplete" FilesUploadComplete="OnSaveClick" />
                                </dx:ASPxUploadControl>

                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 20px">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 no-padding">
                                    Titolo Documento:
                            <dx:ASPxTextBox ID="TitoloDoc_Txt" runat="server" NullText=" " Width="80%" Theme="MetropolisBlue"></dx:ASPxTextBox>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div style="float: right; padding-top: 20px">
                                        <dx:ASPxButton ID="SalvaEcarica" runat="server" Text="Carica e salva" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s,e){UploadControl.Upload()}" />
                                        </dx:ASPxButton>
                                    </div>
                                </div>
                            </div>


                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="padding-top: 20px">
                                Descrizione Documento:
                            <dx:ASPxHtmlEditor ID="DescrizioneDoc_HtmlEdit" runat="server" Theme="MetropolisBlue" Width="100%"></dx:ASPxHtmlEditor>
                            </div>
                            <br />


                            <%--   <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="ASPxCallback1" OnCallback="ASPxCallback1_Callback">
                                <ClientSideEvents  BeginCallback="function(s,e){UploadControl.Upload()}" />
                            </dx:ASPxCallback>--%>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                            <dx:ASPxGridView ID="ListaDocumenti_Grw" ClientInstanceName="ListaDocumenti_Grw" runat="server" DataSourceID="ListaDocumenti_Linq" AutoGenerateColumns="False" KeyFieldName="DocumentoID" Width="100%">
                                <Settings ShowFilterRow="True" />
                                <SettingsSearchPanel Visible="True"  />
                                <Columns> 
                                    <dx:GridViewDataTextColumn FieldName="DisplayName" VisibleIndex="3" Caption="Titolo">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="4" Caption="Descrizione">
                                        <DataItemTemplate>
                                            <div style="height: 100%;">
                                                <dx:ASPxLabel ID="ASPxLabel1" EncodeHtml="false" runat="server" Text='<%# Eval("Description").ToString().PadRight(140).Substring(0,140).TrimEnd()%>' ToolTip='<%# System.Web.HttpUtility.HtmlDecode(Eval("Description").ToString())%>'></dx:ASPxLabel>
                                            </div>
                                        </DataItemTemplate>
                                        <PropertiesTextEdit EncodeHtml="false"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="CreatedUser" VisibleIndex="17" Caption="Utente">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="CreatedOn" VisibleIndex="19" Caption="Data Creazione">
                                        <DataItemTemplate>
                                            <%# Convert.ToDateTime(Eval("CreatedOn")).ToShortDateString() %>
                                        </DataItemTemplate>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn Caption="Azioni" VisibleIndex="1">
                                        <DataItemTemplate>
                                          <a href='<%# Convert.ToString(Eval("PathFolder")).Replace("~/Brico_Documenti/","") %>' class="btn btn-large icon-only btn-sky"><i class="fa fa-download" style="color:white;"></i></a>
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>
                        </div>
                        </asp:Panel>
                           <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-padding">
                            <dx:ASPxGridView ID="ASPxGridView1" ClientInstanceName="ListaDocumenti_Grw" runat="server" DataSourceID="ListaDocumenti_Linq" AutoGenerateColumns="False" KeyFieldName="DocumentoID" Width="100%" Visible="false">
                                <Settings ShowFilterRow="True" />
                                <SettingsSearchPanel Visible="True"  />
                                <Columns> 
                                    <dx:GridViewDataTextColumn FieldName="DisplayName" VisibleIndex="3" Caption="Titolo">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="4" Caption="Descrizione">
                                        <DataItemTemplate>
                                            <div style="height: 100%;">
                                                <dx:ASPxLabel ID="ASPxLabel2" EncodeHtml="false" runat="server" Text='<%# Eval("Description").ToString().PadRight(140).Substring(0,140).TrimEnd()%>' ToolTip='<%# System.Web.HttpUtility.HtmlDecode(Eval("Description").ToString())%>'></dx:ASPxLabel>
                                            </div>
                                        </DataItemTemplate>
                                        <PropertiesTextEdit EncodeHtml="false"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="CreatedUser" VisibleIndex="17" Caption="Utente">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="CreatedOn" VisibleIndex="19" Caption="Data Creazione">
                                        <DataItemTemplate>
                                            <%# Convert.ToDateTime(Eval("CreatedOn")).ToShortDateString() %>
                                        </DataItemTemplate>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn Caption="Azioni" VisibleIndex="1">
                                        <DataItemTemplate>
                                          <a href='<%# Convert.ToString(Eval("PathFolder")).Replace("~/Brico_Documenti/","") %>' class="btn btn-large icon-only btn-sky"><i class="fa fa-download" style="color:white;"></i></a>
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="ListaDocumenti_Linq" runat="server" ConnectionString="<%$ ConnectionStrings:info4portaleConnectionString %>" SelectCommand="SELECT PRT_Documenti_New.* FROM PRT_Documenti_New"></asp:SqlDataSource>
  
</asp:Content>
