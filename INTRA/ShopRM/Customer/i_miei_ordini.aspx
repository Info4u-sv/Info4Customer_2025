<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="i_miei_ordini.aspx.cs" Inherits="INTRA.ShopRM.Customer.i_miei_ordini" %>

<%@ Register Src="~/ShopRM/Customer/Controls/LeftMenuCustomer.ascx" TagPrefix="uc1" TagName="LeftMenuCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   

        <script>
            function OnCustomButtonClick(s, e) {
            switch (e.buttonID) {
                case "GoTo":
            //alert('Ciao');
            s.GetRowValues(e.visibleIndex, "OrderID", Goto);
            break;
            }
        }

            function Goto(value) {
                window.location.href = "OrdineDet.aspx?OrderId=" + value;
        }
        </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="row">
        <div class="col-md-3 col-sm-12 sidebar-column">
            <uc1:LeftMenuCustomer runat="server" ID="LeftMenuCustomer" />

        </div>
        <div class="col-md-9 col-sm-12 information-entry">
            <div class="heading-article">
                <h2 class="title">Filtra gli ordini</h2>
            </div>
            <div class="">
                <p>In questa pagina potrai controllare in qualsiasi momento tutti gli ordini on line da te  richiesti e  verificarne il loro stato.</p>
                <dx:ASPxGridView runat="server" ID="Ordini_grw" ClientInstanceName="Ordini_grw" Width="100%" DataSourceID="OrdersSqlDS" Styles-AlternatingRow-Enabled="True" AutoGenerateColumns="False" KeyFieldName="OrderID">
                    <Settings ShowHeaderFilterButton="True" ShowFilterRow="True"></Settings>
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
                                <dx:GridViewToolbarItem Command="ExportToXlsx" Text="Esporta" Visible="false" />
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

                        <UpdateButton RenderMode="Button" Image-ToolTip="UpdateButton" Text="UpdateButton" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn update icon4u icon-update image"></Styles>
                        </UpdateButton>
                        <CancelButton RenderMode="Button" Image-ToolTip="CancelButton" Text="CancelButton" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn cancel icon4u icon-cancel image"></Styles>
                        </CancelButton>
                        <NewButton RenderMode="Button" Image-ToolTip="Nuovo" Text="Nuovo" Styles-CssPostfix="hidebtn">
                            <Styles Style-CssClass="btn btn-sm btn-custom-padding action-btn new icon4u icon-new image"></Styles>
                        </NewButton>

                    </SettingsCommandButton>
                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                    <Columns>
                        <%--<dx:GridViewCommandColumn ShowClearFilterButton="true" ShowRecoverButton="true" VisibleIndex="0" ButtonRenderMode="Image" ShowSelectButton="false" ShowNewButtonInHeader="false">
                            <CustomButtons>
                                <dx:BootstrapGridViewCommandColumnCustomButton ID="GoTo" Text="Apri Dettaglio" />
                            </CustomButtons>
                        </dx:GridViewCommandColumn>--%>
                        <dx:GridViewDataTextColumn FieldName="OrderID" Caption="Ordine N°" VisibleIndex="0"  CellStyle-HorizontalAlign="Center" Width="100px" >
                            <DataItemTemplate>
                                <a href='OrdineDet.aspx?OrderId=<%# Eval("OrderID")%>'><%# Eval("OrderID")%></a>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NomeCli" Visible="false" VisibleIndex="0" ></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OrderDate" VisibleIndex="1" Caption="Data Odine" PropertiesTextEdit-DisplayFormatString="{0:dd/MM/yyyy}"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="iva" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="trasporto" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DateInsert"  Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="EsitoEsteso"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="note_admin" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="note_customer" Visible="false"></dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="OrdersSqlDS" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>'
                    SelectCommand="SELECT TabTotali.TOTAL, ESK_Orders.OrderID, ESK_Orders.CustomerID, ESK_Orders.OrderDate, ESK_Orders.esito, ESK_Orders.iva, ESK_Orders.trasporto, ESK_Orders.aff, ESK_Orders.aff_story, ESK_Orders.referer, ESK_Orders.DateInsert, ESK_Orders.DateUpdate, ESK_Orders.note_admin, ESK_Orders.note_customer, ESK_OrderStatus.DisplayName AS EsitoEsteso, Clienti.Nome + ' ' + Clienti.Cognome AS NomeCli, CatMiele.CodiceClienteCat FROM (SELECT SUM(UnitCost * Quantity) AS TOTAL, OrderID FROM ESK_OrderDetails GROUP BY OrderID) AS TabTotali INNER JOIN ESK_Orders ON TabTotali.OrderID = ESK_Orders.OrderID INNER JOIN ESK_OrderStatus ON ESK_Orders.esito = ESK_OrderStatus.esito INNER JOIN Clienti ON ESK_Orders.CustomerID = Clienti.CodCli INNER JOIN VIO_Utenti ON ESK_Orders.CustomerID = VIO_Utenti.UtenteIntranet INNER JOIN CatMiele ON VIO_Utenti.CodCat = CatMiele.CatCode WHERE (ESK_Orders.CustomerID = @CustomerID)">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="CodCli" Name="CustomerID"></asp:SessionParameter>
                    </SelectParameters>

                </asp:SqlDataSource>


            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
