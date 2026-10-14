<%@ Page Title="Payment - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="creation_car_care.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pay-wrapper {
            max-width: 1050px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .pay-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .pay-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .pay-header p {
            font-size: 14px;
            color: #6b7280;
            margin: 0;
        }
        .btn-back {
            border: 1.5px solid #d1d5db;
            color: #374151;
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            background: #ffffff;
            transition: all 0.2s;
        }
        .btn-back:hover {
            border-color: #ea580c;
            color: #ea580c;
        }
        .pay-layout {
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }
        .pay-left {
            flex: 2;
        }
        .pay-right {
            flex: 1;
            min-width: 320px;
        }
        /* Dark Header Banner */
        .pay-amount-banner {
            background: #1e293b;
            color: #ffffff;
            border-radius: 14px;
            padding: 20px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(30, 41, 59, 0.15);
        }
        .amount-banner-lbl {
            font-size: 12px;
            color: #94a3b8;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }
        .amount-banner-val {
            font-size: 28px;
            font-weight: 800;
            color: #ff9800;
        }
        .badge-check {
            background: #059669;
            color: #ffffff;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: bold;
        }
        /* Payment Option Cards */
        .pay-options-title {
            font-size: 15px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 15px;
        }
        .pay-option-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 18px 20px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .pay-option-card:hover {
            border-color: #fdba74;
            background: #fffcf8;
        }
        .pay-option-card.selected {
            border: 2px solid #ea580c;
            background: #fff7ed;
        }
        .pay-option-info h4 {
            margin: 0 0 3px 0;
            font-size: 15px;
            font-weight: 700;
            color: #111827;
        }
        .pay-option-info span {
            font-size: 12px;
            color: #6b7280;
        }
        /* Order Summary Box */
        .summary-card {
            background: #ffffff;
            border: 1.5px solid #fed7aa;
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.05);
        }
        .summary-title {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 20px 0;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #4b5563;
            margin-bottom: 14px;
        }
        .btn-pay-now {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: background 0.2s;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
            margin-top: 10px;
        }
        .btn-pay-now:hover {
            background: #c2410c;
        }
        /* SUCCESS PANEL */
        .success-card {
            max-width: 600px;
            margin: 40px auto;
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 20px;
            padding: 40px 35px;
            text-align: center;
            box-shadow: 0 8px 30px rgba(234, 88, 12, 0.08);
        }
        .success-icon-wrap {
            width: 72px;
            height: 72px;
            background: #059669;
            color: #ffffff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            margin: 0 auto 20px auto;
            box-shadow: 0 4px 15px rgba(5, 150, 105, 0.3);
        }
        .success-title {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 8px 0;
        }
        .success-subtitle {
            font-size: 14px;
            color: #6b7280;
            margin: 0 0 28px 0;
        }
        .details-box {
            background: #ffffff;
            border: 1px solid #fed7aa;
            border-radius: 14px;
            padding: 22px;
            text-align: left;
            margin-bottom: 28px;
        }
        .details-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            font-size: 13.5px;
        }
        .details-lbl {
            font-size: 11px;
            color: #9ca3af;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .badge-confirmed {
            background: #ecfdf5;
            color: #059669;
            font-size: 11px;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 6px;
            border: 1px solid #a7f3d0;
        }
        .btn-view-bookings {
            display: block;
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            padding: 13px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 800;
            text-decoration: none;
            box-sizing: border-box;
            margin-bottom: 12px;
            transition: background 0.2s;
        }
        .btn-view-bookings:hover {
            background: #c2410c;
        }
        .btn-home-outline {
            display: block;
            width: 100%;
            background: #ffffff;
            color: #374151;
            border: 1.5px solid #d1d5db;
            padding: 12px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            box-sizing: border-box;
            transition: all 0.2s;
        }
        .btn-home-outline:hover {
            border-color: #ea580c;
            color: #ea580c;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pay-wrapper">
        
        <!-- STEP 1: SELECT PAYMENT METHOD PANEL -->
        <asp:Panel ID="pnlPaymentForm" runat="server">
            
            <div class="pay-header">
                <div>
                    <h1>Select Payment Method</h1>
                    <p>Choose a convenient payment option to complete your booking.</p>
                </div>
                <a href="BookSlot.aspx" class="btn-back">&larr; Back</a>
            </div>

            <div class="pay-layout">
                
                <!-- Left Side: Methods -->
                <div class="pay-left">
                    
                    <!-- Dark Payable Banner -->
                    <div class="pay-amount-banner">
                        <div>
                            <div class="amount-banner-lbl">Total Amount Payable</div>
                            <div class="amount-banner-val">&#8377;<asp:Label ID="lblBannerTotal" runat="server" Text="45,599"></asp:Label></div>
                        </div>
                        <div class="badge-check">&#10004;</div>
                    </div>

                    <!-- Hidden Field to reliably track selected payment method -->
                    <asp:HiddenField ID="hfPaymentMethod" runat="server" Value="Online UPI" />

                    <!-- Payment Options -->
                    <div class="pay-options-title">Payment Options</div>

                    <div class="pay-option-card selected" onclick="selectPaymentOption('Online UPI', this);">
                        <input type="radio" id="rbUPI" name="paymentOption" value="Online UPI" checked="checked" />
                        <div class="pay-option-info">
                            <h4>Online UPI (GPay, PhonePe, Paytm)</h4>
                            <span>Instant payment via UPI Apps</span>
                        </div>
                    </div>

                    <div class="pay-option-card" onclick="selectPaymentOption('Credit / Debit Card', this);">
                        <input type="radio" id="rbCard" name="paymentOption" value="Credit / Debit Card" />
                        <div class="pay-option-info">
                            <h4>Credit / Debit Card</h4>
                            <span>Visa, Mastercard, RuPay &amp; more</span>
                        </div>
                    </div>

                    <div class="pay-option-card" onclick="selectPaymentOption('Net Banking', this);">
                        <input type="radio" id="rbNet" name="paymentOption" value="Net Banking" />
                        <div class="pay-option-info">
                            <h4>Net Banking</h4>
                            <span>All major Indian banks supported</span>
                        </div>
                    </div>

                    <div class="pay-option-card" onclick="selectPaymentOption('Cash on Delivery (COD)', this);">
                        <input type="radio" id="rbCOD" name="paymentOption" value="Cash on Delivery (COD)" />
                        <div class="pay-option-info">
                            <h4>Cash on Delivery (COD)</h4>
                            <span>Pay directly at studio after service</span>
                        </div>
                    </div>

                </div>

                <!-- Right Side: Order Summary -->
                <div class="pay-right">
                    <div class="summary-card">
                        <h3 class="summary-title">Order Summary</h3>

                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span style="font-weight: 700; color: #111827;">&#8377;<asp:Label ID="lblSubtotal" runat="server" Text="45,599"></asp:Label></span>
                        </div>

                        <!-- Active Offer Discount Row -->
                        <asp:Panel ID="pnlCouponRow" runat="server" Visible="false" CssClass="summary-row" style="color: #16a34a; font-weight: 700;">
                            <span><asp:Label ID="lblDiscountLabel" runat="server" Text="Offer Discount"></asp:Label></span>
                            <span>-&#8377;<asp:Label ID="lblDiscountAmount" runat="server" Text="0"></asp:Label></span>
                        </asp:Panel>

                        <hr style="border: none; border-top: 1.5px dashed #fed7aa; margin: 16px 0;" />

                        <div class="summary-row" style="font-size: 16px; font-weight: 800; color: #111827; margin-bottom: 22px;">
                            <span>Total to Pay</span>
                            <span style="font-size: 22px; color: #ea580c;">&#8377;<asp:Label ID="lblTotalToPay" runat="server" Text="45,599"></asp:Label></span>
                        </div>

                        <asp:Button ID="btnPayNow" runat="server" Text="PAY NOW" OnClick="btnPayNow_Click" CssClass="btn-pay-now" />
                    </div>
                </div>

            </div>

        </asp:Panel>

        <!-- STEP 2: BOOKING SUCCESSFUL PANEL (Figma Frame 2) -->
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
            
            <div class="success-card">
                
                <!-- Green Circle Check Icon -->
                <div class="success-icon-wrap">&#10004;</div>

                <h2 class="success-title">Booking Successful!</h2>
                <p class="success-subtitle">Your service appointment has been successfully placed.</p>

                <!-- Booking Details Box -->
                <div class="details-box">
                    
                    <div class="details-row">
                        <div>
                            <div class="details-lbl">BOOKING ID</div>
                            <div style="font-size: 15px; font-weight: 800; color: #111827;">
                                <asp:Label ID="lblSuccessCode" runat="server" Text="#CCC-849206"></asp:Label>
                            </div>
                        </div>
                        <span class="badge-confirmed">CONFIRMED</span>
                    </div>

                    <hr style="border: none; border-top: 1px dashed #e2e8f0; margin: 12px 0;" />

                    <div style="margin-bottom: 12px;">
                        <div class="details-lbl">SERVICE(S)</div>
                        <div style="font-size: 14px; font-weight: 700; color: #111827;">
                            <asp:Label ID="lblSuccessService" runat="server" Text="Car Detailing Package"></asp:Label>
                        </div>
                    </div>

                    <div style="margin-bottom: 12px;">
                        <div class="details-lbl">APPOINTMENT SLOT</div>
                        <div style="font-size: 13.5px; font-weight: 700; color: #111827;">
                            <asp:Label ID="lblSuccessSlot" runat="server" Text="Tuesday, 11 Aug 2026 at 10:30 AM"></asp:Label>
                        </div>
                    </div>

                    <div style="margin-bottom: 12px;">
                        <div class="details-lbl">PAYMENT METHOD</div>
                        <div style="font-size: 13.5px; font-weight: 700; color: #111827;">
                            <asp:Label ID="lblSuccessMethod" runat="server" Text="Online UPI"></asp:Label>
                        </div>
                    </div>

                    <!-- Offer Discount Row on Success -->
                    <asp:Panel ID="pnlSuccessOffer" runat="server" Visible="false" style="margin-bottom: 12px;">
                        <div class="details-lbl">OFFER SAVINGS</div>
                        <div style="font-size: 13.5px; font-weight: 800; color: #16a34a;">
                            &#127881; <asp:Label ID="lblSuccessOffer" runat="server"></asp:Label>
                        </div>
                    </asp:Panel>

                    <div>
                        <div class="details-lbl">TOTAL PAID</div>
                        <div style="font-size: 18px; font-weight: 800; color: #ea580c;">
                            &#8377;<asp:Label ID="lblSuccessPaid" runat="server" Text="45,599"></asp:Label>
                        </div>
                    </div>

                </div>

                <!-- Navigation Buttons -->
                <a href="Booking.aspx" class="btn-view-bookings">VIEW MY BOOKINGS</a>
                <a href="Home.aspx" class="btn-home-outline">Back to Home</a>

            </div>

        </asp:Panel>

    </div>

    <!-- Client-side script to switch payment option cards seamlessly -->
    <script type="text/javascript">
        function selectPaymentOption(method, cardElement) {
            // Update hidden field value for reliable server postback
            var hf = document.getElementById('<%= hfPaymentMethod.ClientID %>');
            if (hf) {
                hf.value = method;
            }

            // Remove selected class from all option cards and uncheck radios
            var cards = document.querySelectorAll('.pay-option-card');
            for (var i = 0; i < cards.length; i++) {
                cards[i].classList.remove('selected');
                var radio = cards[i].querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = false;
                }
            }

            // Mark clicked card as selected and check its radio
            if (cardElement) {
                cardElement.classList.add('selected');
                var currentRadio = cardElement.querySelector('input[type="radio"]');
                if (currentRadio) {
                    currentRadio.checked = true;
                }
            }
        }
    </script>
</asp:Content>
