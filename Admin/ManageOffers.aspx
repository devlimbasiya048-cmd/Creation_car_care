<%@ Page Title="Manage Offers" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageOffers.aspx.cs" Inherits="creation_car_care.Admin.ManageOffers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .offers-mgmt-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        /* Top Action Button (Exact Match Image 1 Frame 3) */
        .btn-add-offer-nav {
            background: #111827;
            color: #ffffff;
            border: none;
            padding: 12px 22px;
            border-radius: 12px;
            font-size: 13.5px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            margin-bottom: 24px;
        }

        .btn-add-offer-nav:hover {
            background: #000000;
            transform: translateY(-1px);
        }

        .section-sub-title {
            font-size: 11.5px;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: 16px;
        }

        /* Offer Card (Exact Match Image 1 Frame 3) */
        .offers-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .offer-row-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: all 0.2s ease;
        }

        .offer-row-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
        }

        .offer-card-left {
            display: flex;
            align-items: center;
            gap: 20px;
            flex: 1;
        }

        /* Dashed Promo Badge Box */
        .promo-coupon-badge {
            border: 1.5px dashed #f87171;
            background: #fef2f2;
            padding: 12px 16px;
            border-radius: 12px;
            text-align: center;
            min-width: 100px;
            flex-shrink: 0;
        }

        .coupon-code-text {
            font-size: 13.5px;
            font-weight: 800;
            color: #dc2626;
            margin: 0 0 2px 0;
            letter-spacing: 0.5px;
        }

        .coupon-val-text {
            font-size: 11px;
            font-weight: 700;
            color: #ef4444;
            margin: 0;
        }

        .offer-details-box h4 {
            margin: 0 0 4px 0;
            font-size: 15.5px;
            font-weight: 800;
            color: #0f172a;
        }

        .offer-details-box p {
            margin: 0 0 6px 0;
            font-size: 13px;
            color: #64748b;
            line-height: 1.4;
        }

        .offer-validity-tag {
            font-size: 12px;
            font-weight: 700;
            color: #16a34a;
        }

        .offer-card-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        /* Toggle Button */
        .toggle-switch-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 800;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            border: none;
        }

        .toggle-on {
            background: #dcfce7;
            color: #15803d;
            border: 1.5px solid #86efac;
        }

        .toggle-off {
            background: #f1f5f9;
            color: #64748b;
            border: 1.5px solid #cbd5e1;
        }

        .btn-delete-offer {
            color: #ef4444;
            font-size: 15px;
            padding: 6px;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="offers-mgmt-container">
        
        <!-- Add New Offer Button (Exact Match Image 1 Frame 3) -->
        <a href="AddOffer.aspx" class="btn-add-offer-nav">
            <span>&#43;</span> Add New Offer
        </a>

        <div class="section-sub-title">Active Offers</div>

        <!-- Offers List -->
        <asp:Repeater ID="rptOffers" runat="server" OnItemCommand="rptOffers_ItemCommand">
            <HeaderTemplate>
                <div class="offers-list">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="offer-row-card">
                    <div class="offer-card-left">
                        <!-- Coupon Badge -->
                        <div class="promo-coupon-badge">
                            <div class="coupon-code-text"><%# Eval("PromoCode") %></div>
                            <div class="coupon-val-text"><%# Eval("DiscountPercentage") %></div>
                        </div>

                        <!-- Details -->
                        <div class="offer-details-box">
                            <h4><%# Eval("OfferTitle") %></h4>
                            <p><%# Eval("OfferDescription") %></p>
                            <span class="offer-validity-tag">&#10003; <%# Eval("ValidityText") %></span>
                        </div>
                    </div>

                    <div class="offer-card-right">
                        <!-- Toggle Switch -->
                        <asp:LinkButton ID="btnToggleActive" runat="server" 
                            CommandName="ToggleOffer" 
                            CommandArgument='<%# Eval("OfferId") %>'
                            CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "toggle-switch-btn toggle-on" : "toggle-switch-btn toggle-off" %>'>
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "&#9679; ON" : "&#9675; OFF" %>
                        </asp:LinkButton>

                        <!-- Delete -->
                        <asp:LinkButton ID="btnDelete" runat="server" 
                            CommandName="DeleteOffer" 
                            CommandArgument='<%# Eval("OfferId") %>'
                            CssClass="btn-delete-offer" 
                            OnClientClick="return confirm('Delete this offer?');" 
                            ToolTip="Delete Offer">
                            &#128465;
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
