<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="ClientiTec.aspx.cs" Inherits="INTRA.ShopRM.TecZone.ClientiTec" %>

<%@ Register Src="~/ShopRM/TecZone/Controls/LeftMenuTecnico.ascx" TagPrefix="uc1" TagName="LeftMenuTecnico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <style>
        .button.style-10, .button.style-12, .button.style-18 {
            line-height: 15px !important;
        }

        .edit-button {
            float: right;
            width: 45px;
            height: 45px;
            background-color: orange !important;
            position: relative;
            transition: all 0.15s ease-out;
        }

            .edit-button:hover {
                background-color: #8e8a8a !important;
            }


            .edit-button .fa {
                display: block;
                line-height: 45px;
                text-align: center;
                color: #fff;
                font-size: 23px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuTecnico runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">Clienti</h2>
            </div>
            <div>


                <dx:ASPxGridView ID="Generic_gridview" Settings-ShowHeaderFilterButton="true" Styles-AlternatingRow-Enabled="True" ClientInstanceName="Generic_gridview" DataSourceID="ClientiTec_Dts" runat="server" Width="100%" AutoGenerateColumns="False">
                    <Settings ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
                    <SettingsBehavior AllowFocusedRow="false" />
                    <Styles AlternatingRow-Enabled="True" Header-Wrap="True" Cell-Paddings-Padding="3" Header-Paddings-Padding="3" FilterBar-Paddings-Padding="3" CommandColumn-Paddings-Padding="3" FilterBarImageCell-Paddings-Padding="3" FilterCell-Paddings-Padding="3"></Styles>
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
                            </Items>
                        </dx:GridViewToolbar>
                    </Toolbars>
                    <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="350" />
                    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"
                        AllowHideDataCellsByColumnMinWidth="true">
                    </SettingsAdaptivity>
                    <SettingsSearchPanel Visible="True" CustomEditorID="tbToolbarSearch"></SettingsSearchPanel>
                    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" Landscape="true" LeftMargin="30" FileName="Lista" />
                    <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
                    <%-- <ClientSideEvents EndCallback="function(s, e) { ASPxClientHint.Update(); }" />--%>
                    <%--<ClientSideEvents FocusedRowChanged="function(s,e){alert(e.visibleIndex);}" />--%>
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
                        <dx:GridViewDataTextColumn VisibleIndex="0" AdaptivePriority="0" MaxWidth="70">
                            <DataItemTemplate>

                                <%--                                                          <button id="Ordina_HtmlBtn" onclick="SetCookies('<%# Eval("CodCli") %>|<%# Eval("Cognome") %>|<%# Eval("Nome") %>','Ordina')" class="button style-12 no-padding" style="min-width: 0px !important;"><i class="fa fa-shopping-cart" style="display: none;"></i>Ordina</button>
                                <button id="Edit_HtmlBtn" onclick="SetCookies('<%# Eval("CodCli") %>|<%# Eval("Cognome") %>|<%# Eval("Nome") %>','Edit')" class="button style-12 no-padding" style="min-width: 0px !important;"><i class="fa fa-edit" style="display: none;"></i>Edit</button>
      <div class="col-md-6 no-padding">
                                    <button id="Ordina_HtmlBtn" onclick="SetCookies('<%# Eval("CodCli") %>|<%# Eval("Cognome") %>|<%# Eval("Nome") %>','Ordina')" class="button style-12 no-padding" style="min-width: 0px !important;"><i class="fa fa-shopping-cart"></i></button>
                                    </div>
                                <div class="col-md-6 no-padding">
                                    <button id="Edit_HtmlBtn" onclick="SetCookies('<%# Eval("CodCli") %>|<%# Eval("Cognome") %>|<%# Eval("Nome") %>','Edit')" class="button style-12 no-padding" style="min-width: 0px !important;"><i class="fa fa-edit"></i></button>
                                </div>--%>
                                <div style="width: 60px;">
                                    <div style="display: inherit; text-align: center;">
                                        <a href="javascript:SetCookies('<%# Eval("CodCli") %>|<%# Eval("Denom") %>','Ordina');">
                                            <span class="search-button" style="padding-bottom: 10px !important; margin-left: 5px; margin-right: 5px; float: right">
                                                <i class="fa fa-shopping-cart"></i>
                                            </span>
                                        </a>
                                        <%--<a href="javascript:SetCookies('<%# Eval("CodCli") %>','Edit');">
                                            <span class="edit-button" style="padding-bottom: 10px !important; margin-left: 5px; margin-right: 5px; float: right; background-color: orange;">
                                                <i class="fa fa-edit"></i>
                                            </span>
                                        </a>--%>
                                    </div>
                                </div>
                                <%--  <dx:ASPxButton ID="Ordina_Btn" runat="server" Text="Ordina" Native="true" class="button style-12 no-padding" AutoPostBack="false" ClientVisible="true">
                                    <ClientSideEvents Click="function(s,e){
                                   
                                        Generic_gridview.GetRowValues(index,'CodCli',SetCookies);
                                        }" />
                                </dx:ASPxButton>--%>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Denom" VisibleIndex="1" AdaptivePriority="1" MaxWidth="200" Caption="Società"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_I_NotePosizione" VisibleIndex="2" AdaptivePriority="2" MaxWidth="200" Caption="Posizione"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="U_I_Ind" Caption="Indirizzo" VisibleIndex="3" MaxWidth="120" AdaptivePriority="4"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CodCli" VisibleIndex="4" MaxWidth="60" AdaptivePriority="5"></dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource runat="server" ID="ClientiTec_Dts" ConnectionString='<%$ ConnectionStrings:GestionaleConnectionString %>' SelectCommand="SELECT Clienti.Nome, Clienti.Cognome, Clienti.CodCli, Clienti.Ind, TabDep.U_I_Ind, TabDep.U_I_Prov, TabDep.U_I_Loc, TabDep.U_I_Cap, TabDep.U_Intranet, Clienti.Denom, TabDep.U_I_NotePosizione FROM Clienti INNER JOIN TabDep ON Clienti.CodCli = TabDep.CodCli WHERE (TabDep.U_Intranet = 1)">
                </asp:SqlDataSource>

                <dx:ASPxCallback runat="server" ID="GeneraCookieCli_Callback" ClientInstanceName="GeneraCookieCli_Callback" OnCallback="GeneraCookieCli_Callback_Callback">
                </dx:ASPxCallback>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script>
        function SetCookies(values, action) {
            if (values != null && values != '' && values != 'undefined') {
                GeneraCookieCli_Callback.PerformCallback(values + ';' + action);
            } else {
                showNotificationError("Codice cliente non presente");
            }
        }


        function OpenWindow(url) {
            window.location.href = url;
        }
    </script>
</asp:Content>
