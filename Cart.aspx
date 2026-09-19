<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="creation_car_care.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-wrapper {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .page-header {
            margin-bottom: 25px;
        }
        .page-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .page-header p {
            font-size: 14px;
            color: #6b7280;
            margin: 0;
        }
        .cart-layout {
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }
        .cart-items-section {
            flex: 2;
        }
        .bill-details-section {
            flex: 1;
            min-width: 320px;
        }
        .cart-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 16px;
            padding: 22px 24px;
            margin-bottom: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(234, 88, 12, 0.03);
        }
        .cart-card-info h3 {
            font-size: 17px;
            font-weight: 700;
            color: #111827;
            margin: 0 0 5px 0;
        }
        .cart-card-info span {
            font-size: 12px;
            color: #9ca3af;
            display: block;
            margin-bottom: 10px;
        }
        .cart-card-price {
            font-size: 18px;
            font-weight: 800;
            color: #ea580c;
        }
        .qty-controls {
            display: inline-flex;
            align-items: center;
            border: 1.5px solid #fed7aa;
            border-radius: 8px;
            background: #ffffff;
            overflow: hidden;
            margin-right: 15px;
        }
        .qty-btn {
            background: none;
            border: none;
            color: #ea580c;
            font-size: 16px;
            font-weight: bold;
            width: 32px;
            height: 32px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-btn:hover {
            background: #fff7ed;
        }
        .qty-val {
            font-size: 14px;
            font-weight: bold;
            padding: 0 8px;
            color: #111827;
        }
        .btn-remove {
            color: #ef4444;
            background: none;
            border: none;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: underline;
        }
        .bill-card {
            background: #ffffff;
            border: 1.5px solid #93c5fd;
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.05);
        }
        .bill-title {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 20px 0;
        }
        .bill-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            margin-bottom: 14px;
            color: #4b5563;
        }
        .bill-divider {
            border: none;
            border-top: 1.5px dashed #e2e8f0;
            margin: 18px 0;
        }
        .bill-total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 16px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 22px;
        }
        .bill-total-price {
            font-size: 22px;
            color: #ea580c;
        }
        .btn-proceed {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: background 0.2s;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }
        .btn-proceed:hover {
            background: #c2410c;
        }
        .empty-cart-card {
            background: #ffffff;
            border: 1.5px dashed #e5e7eb;
            border-radius: 16px;
            padding: 50px 20px;
            text-align: center;
        }
        .empty-cart-card h3 {
            font-size: 18px;
            color: #374151;
            margin-bottom: 8px;
        }
        .empty-cart-card p {
            font-size: 14px;
            color: #9ca3af;
            margin-bottom: 20px;
        }
        .btn-browse {
            background: #ea580c;
            color: #ffffff;
            padding: 10px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            font-size: 13px;
            display: inline-block;
        }
        @media (max-width: 800px) {
            .cart-layout {
                flex-direction: column;
            }
            .bill-details-section {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-wrapper">
        
        <!-- Page Title & Subtitle -->
        <div class="page-header">
            <h1>My Cart</h1>
            <p>Review your selected services and proceed to slot booking.</p>
        </div>

        <!-- Active Offer Applied Banner -->
        <asp:Panel ID="pnlActiveOfferBanner" runat="server" Visible="false" style="background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%); border: 1.5px solid #10b981; border-radius: 14px; padding: 14px 20px; margin-bottom: 22px; display: flex; align-items: center; justify-content: space-between;">
            <div style="display: flex; align-items: center; gap: 12px;">
                <span style="font-size: 24px;">&#127881;</span>
                <div>
                    <div style="font-size: 14px; font-weight: 800; color: #065f46;">
                        <asp:Label ID="lblOfferBannerTitle" runat="server"></asp:Label> (<asp:Label ID="lblOfferBannerPercent" runat="server"></asp:Label>% OFF) Applied!
                    </div>
                    <div style="font-size: 12.5px; color: #047857; margin-top: 2px;">
                        Special discount has been calculated and deducted below!
                    </div>
                </div>
            </div>
            <span style="background: #10b981; color: #ffffff; font-size: 11px; font-weight: 800; padding: 4px 10px; border-radius: 12px;">&#10004; Applied</span>
        </asp:Panel>

        <!-- Check Offers Banner (Shown when no offer is applied) -->
        <asp:Panel ID="pnlCheckOffers" runat="server" Visible="false" style="background: #fffcf8; border: 1.5px dashed #fed7aa; border-radius: 14px; padding: 13px 20px; margin-bottom: 22px; display: flex; align-items: center; justify-content: space-between;">
            <div style="display: flex; align-items: center; gap: 10px;">
                <span style="font-size: 20px;">&#127881;</span>
                <span style="font-size: 13.5px; color: #b45309; font-weight: 700;">Looking for festive savings? Check our active studio offers!</span>
            </div>
            <a href="Offer.aspx" style="background: #ea580c; color: #ffffff; padding: 6px 16px; border-radius: 8px; font-size: 12px; font-weight: 800; text-decoration: none;">View Offers &rarr;</a>
        </asp:Panel>

        <div class="cart-layout">
            
            <!-- Left Side: Cart Items List -->
            <div class="cart-items-section">
                
                <!-- If Cart is Empty -->
                <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="empty-cart-card">
                    <span style="font-size: 40px; display: block; margin-bottom: 10px;">&#128722;</span>
                    <h3>Your cart is empty!</h3>
                    <p>Looks like you haven't added any car detailing services yet.</p>
                    <a href="ServicesList.aspx" class="btn-browse">Browse Services &rarr;</a>
                </asp:Panel>

                <!-- Repeater for Cart Items -->
                <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                    <ItemTemplate>
                        <div class="cart-card">
                            <div class="cart-card-info">
                                <h3><%# Eval("ServiceName") %></h3>
                                <span>Creation Car Care Studio</span>
                                <div class="cart-card-price">
                                    <%# Convert.ToBoolean(Eval("HasDiscount")) ? 
                                        "<div style='display:flex; align-items:baseline; gap:8px;'>" +
                                        "<span style='font-size:13px; color:#9ca3af; text-decoration:line-through;'>&#8377;" + Eval("OriginalPriceFormatted") + "</span>" +
                                        "<span style='font-size:18px; font-weight:800; color:#16a34a;'>&#8377;" + Eval("DiscountedPriceFormatted") + "</span>" +
                                        "<span style='background:#dcfce7; color:#15803d; font-size:11px; font-weight:bold; padding:2px 6px; border-radius:4px;'>" + Eval("DiscountBadge") + "</span>" +
                                        "</div>"
                                        :
                                        "&#8377;" + Eval("OriginalPriceFormatted")
                                    %>
                                </div>
                            </div>

                            <div style="display: flex; align-items: center;">
                                <!-- Quantity Controls -->
                                <div class="qty-controls">
                                    <asp:LinkButton ID="btnMinus" runat="server" CommandName="Decrease" CommandArgument='<%# Eval("CartId") %>' CssClass="qty-btn">-</asp:LinkButton>
                                    <span class="qty-val"><%# Eval("Quantity") %></span>
                                    <asp:LinkButton ID="btnPlus" runat="server" CommandName="Increase" CommandArgument='<%# Eval("CartId") %>' CssClass="qty-btn">+</asp:LinkButton>
                                </div>

                                <!-- Remove Button -->
                                <asp:LinkButton ID="btnRemove" runat="server" CommandName="RemoveItem" CommandArgument='<%# Eval("CartId") %>' CssClass="btn-remove">Remove</asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>

            <!-- Right Side: Bill Details Card -->
            <div class="bill-details-section">
                <asp:Panel ID="pnlBillDetails" runat="server">
                    <div class="bill-card">
                        <h3 class="bill-title">Bill Details</h3>

                        <div class="bill-row">
                            <span>Item Total (Subtotal)</span>
                            <span style="font-weight: 700; color: #111827;">&#8377;<asp:Label ID="lblItemTotal" runat="server" Text="0"></asp:Label></span>
                        </div>

                        <!-- Active Offer Discount Row -->
                        <asp:Panel ID="pnlOfferDiscountRow" runat="server" Visible="false" CssClass="bill-row" style="color: #15803d; font-weight: 700;">
                            <span>&#127881; Offer Discount (<asp:Label ID="lblOfferDiscountPercent" runat="server"></asp:Label>% OFF)</span>
                            <span>-&#8377;<asp:Label ID="lblOfferDiscountAmount" runat="server" Text="0"></asp:Label></span>
                        </asp:Panel>

                        <div class="bill-row">
                            <span>Studio Visit / Doorstep Fee</span>
                            <span style="color: #16a34a; font-weight: 700;">FREE</span>
                        </div>

                        <hr class="bill-divider" />

                        <div class="bill-total-row">
                            <span>Total Amount Payable</span>
                            <span class="bill-total-price">&#8377;<asp:Label ID="lblTotalAmount" runat="server" Text="0"></asp:Label></span>
                        </div>

                        <asp:Button ID="btnProceedSlot" runat="server" Text="PROCEED TO SLOT &amp; TIME" OnClick="btnProceedSlot_Click" CssClass="btn-proceed" />
                    </div>
                </asp:Panel>
            </div>

        </div>

    </div>
</asp:Content>
