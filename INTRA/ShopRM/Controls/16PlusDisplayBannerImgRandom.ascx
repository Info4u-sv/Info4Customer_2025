<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="16PlusDisplayBannerImgRandom.ascx.cs" Inherits="INTRA.ShopRM.Controls._16PlusDisplayBannerImgRandom" %>
<style>
    .banner-title {
        width: 85%;
        background: #f0eeee;
        opacity: .80;
        padding: 10px;
        padding-left: 60px;
    }
</style>

<div class="row">
    <div class="row">
        <div class="row">
            <div class="row">
                <div class="breadcrumb-entry align-left" style="background-image: url(<% = ImageBanner %>); background-position: 0 0; min-height: 300px; padding: 0">
                    <div class="container" style="display: table; padding: 0; margin: 0; position:relative; top: 100%; margin-top:202px">
                        <div class="breadcrumb-title style-2 " style="vertical-align: bottom; display: table-cell; position:relative; top: 100%">
                            <div class="banner-title">
                                <h1>
                                    <asp:Label ID="LabelTitleSection" runat="server" Text="" Visible="true"></asp:Label></h1>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="contact-spacer"></div>