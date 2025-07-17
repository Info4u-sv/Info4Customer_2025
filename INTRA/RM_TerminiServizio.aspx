<%@ Page Title="" Language="C#" MasterPageFile="~/EmptyPublic.Master" AutoEventWireup="true" CodeBehind="RM_TerminiServizio.aspx.cs" Inherits="INTRA.RM_TerminiServizio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        @media(max-width:840px) {
            .mobileGroupIndent {
                padding-top: 20px;
            }
        }

        .mobileAlign {
            text-align: center !important;
        }

        .maxWidth {
            max-width: 360px !important;
        }

        .fullHeight {
            height: 100% !important;
        }

        .fullWidth {
            width: 100% !important;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-12 ">
            <div class="card ">
                <div class="container-fluid">
                    <div style="text-align: center">
                        <img src='<%= Page.ResolveUrl("~/ShopRM/static/img/info4u-logo.png")%>' alt="Canvas Logo" style="height: 300px" />
                    </div>
                </div>
                <h2 class="card-title text-center">Termini del servizio</h2>
                <div class="content">
                    <div class="card-body " style="padding:10px">
                        <asp:Repeater ID="Generic_Repeater" runat="server" DataSourceID="Generic_SqlDt">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "Value") %>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="Generic_SqlDt" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT * FROM [PRT_Parameter] WHERE ([CodParam] = @CodParam)">
        <SelectParameters>
            <asp:Parameter DefaultValue="TerminiServizioRM" Name="CodParam" Type="String"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
