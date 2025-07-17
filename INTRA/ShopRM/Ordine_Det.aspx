<%@ Page Title="" Language="C#" MasterPageFile="~/ShopRM/Catalogo.Master" AutoEventWireup="true" CodeBehind="Ordine_Det.aspx.cs" Inherits="INTRA.ShopRM.Ordine_Det" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .row {
            display: -ms-flexbox;
            display: flex;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            margin-right: -7.5px;
            margin-left: -7.5px;
        }

        .invoice {
            background-color: #fff;
            border: 1px solid rgba(0,0,0,.125);
            position: relative;
        }

        article, aside, figcaption, figure, footer, header, hgroup, main, nav, section {
            display: block;
        }

        *, ::after, ::before {
            box-sizing: border-box;
        }

        .col-12 {
            -ms-flex: 0 0 100%;
            flex: 0 0 100%;
            max-width: 100%;
        }

        .table-responsive {
            display: block;
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
            background-color: transparent;
        }

        table {
            border-collapse: collapse;
        }

        .table thead th {
            vertical-align: bottom;
            border-bottom: 2px solid #dee2e6;
        }

        .table td, .table th {
            padding: 0.75rem;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }

        th {
            text-align: inherit;
            text-align: -webkit-match-parent;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0,0,0,.05);
        }

        .table td, .table th {
            padding: 0.75rem;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContenutoPaginaContentPH" runat="server">
    <div class="information-blocks">

        <div class="content-push">

            <section class="invoice">

                <div class="row">
                    <div class="col-12">
                        <h2 class="page-header">
                            <i class="fa fa-globe"></i>AdminLTE, Inc.
                            <small class="pull-right">Date: 2/10/2014</small>
                        </h2>
                    </div>

                </div>

                <div class="row invoice-info">
                    <div class="col-sm-4 invoice-col">
                        From
                        <address>
                            <strong>Admin, Inc.</strong><br>
                            795 Folsom Ave, Suite 600<br>
                            San Francisco, CA 94107<br>
                            Phone: (804) 123-5432<br>
                            Email: info@almasaeedstudio.com
                        </address>
                    </div>

                    <div class="col-sm-4 invoice-col">
                        To
                        <address>
                            <strong>John Doe</strong><br>
                            795 Folsom Ave, Suite 600<br>
                            San Francisco, CA 94107<br>
                            Phone: (555) 539-1037<br>
                            Email: john.doe@example.com
                        </address>
                    </div>

                    <div class="col-sm-4 invoice-col">
                        <b>Invoice #007612</b><br>
                        <br>
                        <b>Order ID:</b> 4F3S8J<br>
                        <b>Payment Due:</b> 2/22/2014<br>
                        <b>Account:</b> 968-34567
                    </div>

                </div>

<div class="information-blocks">
                    <div class="table-responsive">
                        <table class="cart-table">
                            <tbody><tr>
                                <th class="column-1">Product Name</th>
                                <th class="column-2">Unit Price</th>
                                <th class="column-3">Qty</th>
                                <th class="column-4">Subtotal</th>
                                <th class="column-5"></th>
                            </tr>
                            <tr>
                                <td>
                                    <div class="traditional-cart-entry">
                                        <a href="#" class="image"><img src="img/product-minimal-1.jpg" alt=""></a>
                                        <div class="content">
                                            <div class="cell-view">
                                                <a href="#" class="tag">woman clothing</a>
                                                <a href="#" class="title">Pullover Batwing Sleeve Zigzag</a>
                                                <div class="inline-description">S / Dirty Pink</div>
                                                <div class="inline-description">Zigzag Clothing</div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>$99,00</td>
                                <td>
                                    <div class="quantity-selector detail-info-entry">
                                        <div class="entry number-minus">&nbsp;</div>
                                        <div class="entry number">10</div>
                                        <div class="entry number-plus">&nbsp;</div>
                                    </div>
                                </td>
                                <td><div class="subtotal">$990,00</div></td>
                                <td><a class="remove-button"><i class="fa fa-times"></i></a></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="traditional-cart-entry">
                                        <a href="#" class="image"><img src="img/product-minimal-1.jpg" alt=""></a>
                                        <div class="content">
                                            <div class="cell-view">
                                                <a href="#" class="tag">woman clothing</a>
                                                <a href="#" class="title">Pullover Batwing Sleeve Zigzag</a>
                                                <div class="inline-description">S / Dirty Pink</div>
                                                <div class="inline-description">Zigzag Clothing</div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>$99,00</td>
                                <td>
                                    <div class="quantity-selector detail-info-entry">
                                        <div class="entry number-minus">&nbsp;</div>
                                        <div class="entry number">10</div>
                                        <div class="entry number-plus">&nbsp;</div>
                                    </div>
                                </td>
                                <td><div class="subtotal">$990,00</div></td>
                                <td><a class="remove-button"><i class="fa fa-times"></i></a></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="traditional-cart-entry">
                                        <a href="#" class="image"><img src="img/product-minimal-1.jpg" alt=""></a>
                                        <div class="content">
                                            <div class="cell-view">
                                                <a href="#" class="tag">woman clothing</a>
                                                <a href="#" class="title">Pullover Batwing Sleeve Zigzag</a>
                                                <div class="inline-description">S / Dirty Pink</div>
                                                <div class="inline-description">Zigzag Clothing</div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>$99,00</td>
                                <td>
                                    <div class="quantity-selector detail-info-entry">
                                        <div class="entry number-minus">&nbsp;</div>
                                        <div class="entry number">10</div>
                                        <div class="entry number-plus">&nbsp;</div>
                                    </div>
                                </td>
                                <td><div class="subtotal">$990,00</div></td>
                                <td><a class="remove-button"><i class="fa fa-times"></i></a></td>
                            </tr>
                        </tbody></table>
                    </div>
                    <div class="cart-submit-buttons-box">
                        <a class="button style-15">Continue Shopping</a>
                        <a class="button style-15">Update Bag</a>
                    </div>
                    <div class="row">
                        <div class="col-md-4 information-entry">
                            <h3 class="cart-column-title">Get shipping Estimates</h3>
                            <form>
                                <label>Country</label>
                                <div class="simple-drop-down simple-field size-1">
                                    <select>
                                        <option>United States</option>
                                        <option>Great Britain</option>
                                        <option>Canada</option>
                                    </select>
                                </div>
                                <label>State</label>
                                <div class="simple-drop-down simple-field size-1">
                                    <select>
                                        <option>Alabama</option>
                                        <option>Alaska</option>
                                        <option>Idaho</option>
                                    </select>
                                </div>
                                <label>Zip Code</label>
                                <input type="text" value="" placeholder="Zip Code" class="simple-field size-1">
                                <div class="button style-16" style="margin-top: 10px;">calculate shipping<input type="submit"></div>
                            </form>
                        </div>
                        <div class="col-md-4 information-entry">
                            <h3 class="cart-column-title">Discount Codes <span class="inline-label red">Promotion</span></h3>
                            <form>
                                <label>Enter your coupon code if you have one.</label>
                                <input type="text" value="" placeholder="" class="simple-field size-1">
                                <div class="button style-16" style="margin-top: 10px;">Apply Coupon<input type="submit"></div>
                            </form>
                        </div>
                        <div class="col-md-4 information-entry">
                            <div class="cart-summary-box">
                                <div class="sub-total">Subtotal: $990,00</div>
                                <div class="grand-total">Grand Total $1029,79</div>
                                <a class="button style-10" href="#">Proceed To Checkout</a>
                                <a class="simple-link" href="#">Checkout with Multiple Addresses</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">



                    <div class="col-xs-6">
                        <p class="lead">Amount Due 2/22/2014</p>
                        <div class="table-responsive">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th style="width: 50%">Subtotal:</th>
                                        <td>$250.30</td>
                                    </tr>
                                    <tr>
                                        <th>Tax (9.3%)</th>
                                        <td>$10.34</td>
                                    </tr>
                                    <tr>
                                        <th>Shipping:</th>
                                        <td>$5.80</td>
                                    </tr>
                                    <tr>
                                        <th>Total:</th>
                                        <td>$265.24</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </section>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
