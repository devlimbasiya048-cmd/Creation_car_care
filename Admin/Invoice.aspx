<%@ Page Title="Invoice Details" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="creation_car_care.Admin.Invoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .invoice-page-container {
            max-width: 650px;
            margin: 0 auto;
        }

        /* Printable Invoice Card (Exact Figma Screenshot 5 Frame 2 Match) */
        .invoice-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 20px;
            padding: 36px 40px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            margin-bottom: 24px;
        }

        .studio-brand-center {
            text-align: center;
            margin-bottom: 24px;
        }

        .brand-logo-icon {
            width: 44px;
            height: 44px;
            background: #ea580c;
            color: #ffffff;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 8px;
        }

        .studio-title {
            margin: 0 0 4px 0;
            font-size: 18px;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #0f172a;
        }

        .studio-subtitle {
            margin: 0;
            font-size: 12.5px;
            color: #64748b;
            font-weight: 500;
            line-height: 1.4;
        }

        .invoice-divider {
            border: 0;
            border-top: 1.5px dashed #cbd5e1;
            margin: 20px 0;
        }

        /* 2-Column Info Row */
        .meta-row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 16px;
        }

        .meta-col-left, .meta-col-right {
            flex: 1;
        }

        .meta-col-right {
            text-align: right;
        }

        .meta-label {
            font-size: 11px;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .meta-value-bold {
            font-size: 14.5px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 2px;
        }

        .meta-value-sub {
            font-size: 12.5px;
            color: #64748b;
            font-weight: 500;
            margin: 0;
        }

        /* Invoice Items Table */
        .items-list {
            margin: 16px 0;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
        }

        .item-desc-box h5 {
            margin: 0 0 2px 0;
            font-size: 14px;
            font-weight: 700;
            color: #1e293b;
        }

        .item-desc-box span {
            font-size: 12px;
            color: #64748b;
        }

        .item-amount {
            font-size: 14px;
            font-weight: 700;
            color: #0f172a;
        }

        .item-discount {
            color: #16a34a;
            font-weight: 700;
        }

        /* Total Block */
        .total-block {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
        }

        .payment-mode-label {
            font-size: 12px;
            font-weight: 600;
            color: #64748b;
            margin: 0 0 6px 0;
        }

        .paid-stamp-pill {
            display: inline-block;
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
            font-size: 11px;
            font-weight: 800;
            padding: 3px 12px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .total-price-box {
            text-align: right;
        }

        .total-title {
            font-size: 11.5px;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 0 0 4px 0;
        }

        .total-amount-display {
            font-size: 24px;
            font-weight: 800;
            color: #16a34a;
            margin: 0;
        }

        .invoice-footer-thanks {
            text-align: center;
            margin-top: 24px;
            padding-top: 16px;
            font-size: 12px;
            color: #94a3b8;
            font-weight: 600;
        }

        /* Action Buttons */
        .invoice-actions-row {
            display: flex;
            gap: 12px;
            justify-content: center;
            margin-bottom: 16px;
        }

        .btn-print-slip {
            flex: 1;
            padding: 13px 20px;
            background: #ffffff;
            color: #16a34a;
            border: 1.5px solid #16a34a;
            border-radius: 12px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-print-slip:hover {
            background: #16a34a;
            color: #ffffff;
        }

        .btn-download-pdf {
            flex: 1;
            padding: 13px 20px;
            background: #111827;
            color: #ffffff;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-download-pdf:hover {
            background: #000000;
        }

        .back-nav-box {
            text-align: center;
            margin-top: 10px;
        }

        .back-nav-box a {
            color: #64748b;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
        }

        .back-nav-box a:hover {
            color: #ea580c;
        }

        /* Print Media Styles: only the invoice card is printed */
        @media print {
            @page {
                size: A4 portrait;
                margin: 12mm;
            }
            body {
                background: #ffffff !important;
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
            }
            .admin-sidebar, .admin-header, .invoice-actions-row, .back-nav-box {
                display: none !important;
            }
            .admin-main {
                margin-left: 0 !important;
            }
            .admin-content {
                padding: 0 !important;
            }
            .invoice-page-container {
                max-width: 100% !important;
                margin: 0 !important;
            }
            .invoice-card {
                border: 1px solid #cbd5e1 !important;
                box-shadow: none !important;
                padding: 24px 28px !important;
                page-break-inside: avoid;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="invoice-page-container">
        
        <!-- The Tax Invoice Card (Matches Figma Screenshot 5 Frame 2) -->
        <div class="invoice-card" id="printableInvoice">
            
            <!-- Studio Brand Center -->
            <div class="studio-brand-center">
                <div class="brand-logo-icon">&#128663;</div>
                <h3 class="studio-title">CREATION CAR CARE</h3>
                <p class="studio-subtitle">
                    Road 9, Surat, Gujarat - 395006<br />
                    Phone: +91 91404 10410 &bull; info@creationcarcare.com
                </p>
            </div>

            <hr class="invoice-divider" />

            <!-- 2 Column Customer & Invoice Details -->
            <div class="meta-row">
                <div class="meta-col-left">
                    <div class="meta-label">Billed To</div>
                    <div class="meta-value-bold"><asp:Label ID="lblCustomerName" runat="server" Text="Rahul Patel"></asp:Label></div>
                    <p class="meta-value-sub"><asp:Label ID="lblCustomerPhone" runat="server" Text="+91 98981 23456"></asp:Label></p>
                    <p class="meta-value-sub"><asp:Label ID="lblVehicleDetails" runat="server" Text="White Honda City Sedan"></asp:Label></p>
                </div>
                <div class="meta-col-right">
                    <div class="meta-label">Invoice Details</div>
                    <div class="meta-value-bold"><asp:Label ID="lblInvoiceCode" runat="server" Text="#CCC-INV-100231"></asp:Label></div>
                    <p class="meta-value-sub">Date: <asp:Label ID="lblInvoiceDate" runat="server" Text="18 Aug 2024"></asp:Label></p>
                    <p class="meta-value-sub">Slot: <asp:Label ID="lblSlotTime" runat="server" Text="09:30 PM"></asp:Label></p>
                </div>
            </div>

            <hr class="invoice-divider" />

            <!-- Service Items Breakdown -->
            <div class="items-list">
                <!-- Main Service Item -->
                <div class="item-row">
                    <div class="item-desc-box">
                        <h5><asp:Label ID="lblServiceName" runat="server" Text="Ceramic Top Glaze"></asp:Label></h5>
                        <span>Premium paint protection & hydrophobic coating</span>
                    </div>
                    <div class="item-amount">&#8377;<asp:Label ID="lblServicePrice" runat="server" Text="5,500.00"></asp:Label></div>
                </div>

                <!-- Studio Detailing & Consumables -->
                <div class="item-row">
                    <div class="item-desc-box">
                        <h5>Studio Preparation & Detailing</h5>
                        <span>Clay bar, foam prep & micro-finish buffer</span>
                    </div>
                    <div class="item-amount">&#8377;<asp:Label ID="lblLaborPrice" runat="server" Text="0.00"></asp:Label></div>
                </div>

                <!-- Taxes -->
                <div class="item-row">
                    <div class="item-desc-box">
                        <h5>GST Taxes (18% SGST + CGST)</h5>
                        <span>Applicable standard taxes</span>
                    </div>
                    <div class="item-amount">Included</div>
                </div>

                <!-- Promo Discount (Optional) -->
                <asp:Panel ID="pnlDiscountRow" runat="server" Visible="false">
                    <div class="item-row">
                        <div class="item-desc-box">
                            <h5 style="color: #16a34a;">Promo Code Applied (<asp:Label ID="lblOfferTitle" runat="server" Text="OFFER"></asp:Label>)</h5>
                            <span style="color: #16a34a;">Special seasonal discount</span>
                        </div>
                        <div class="item-amount item-discount">- &#8377;<asp:Label ID="lblDiscountAmount" runat="server" Text="0.00"></asp:Label></div>
                    </div>
                </asp:Panel>
            </div>

            <hr class="invoice-divider" />

            <!-- Total Amount & Payment Badge -->
            <div class="total-block">
                <div>
                    <p class="payment-mode-label">Payment Mode: <asp:Label ID="lblPaymentMethod" runat="server" Text="GPay (UPI)"></asp:Label></p>
                    <span class="paid-stamp-pill"><asp:Label ID="lblPaymentStatus" runat="server" Text="PAID"></asp:Label></span>
                </div>
                <div class="total-price-box">
                    <div class="total-title">Total Amount Paid</div>
                    <h2 class="total-amount-display">&#8377;<asp:Label ID="lblTotalAmount" runat="server" Text="5,500.00"></asp:Label></h2>
                </div>
            </div>

            <div class="invoice-footer-thanks">
                Thank you for choosing Creation Car Care! Drive clean & drive safe.
            </div>

        </div>

        <!-- Action Buttons (Print / Download / Back) -->
        <div class="invoice-actions-row">
            <button type="button" class="btn-print-slip" onclick="window.print()">
                <span>&#128424;</span> Print Invoice / Slip
            </button>
            <button type="button" class="btn-download-pdf" onclick="window.print()">
                <span>&#128229;</span> Download PDF
            </button>
        </div>

        <div class="back-nav-box">
            <a href="ManageBookings.aspx">&larr; Back to All Bookings</a>
        </div>

    </div>
</asp:Content>
