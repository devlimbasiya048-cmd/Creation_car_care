<%@ Page Title="Services Catalog - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ServicesList.aspx.cs" Inherits="creation_car_care.ServicesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .services-container {
            max-width: 1100px;
            margin: 30px auto 60px auto;
            padding: 0 16px;
        }

        /* Header Banner */
        .catalog-header {
            background: #ffffff;
            padding: 26px 30px;
            border-radius: 16px;
            border: 1.5px solid #ffedd5;
            margin-bottom: 24px;
            box-shadow: 0 4px 16px rgba(234, 88, 12, 0.04);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .catalog-header h1 {
            color: #111827;
            margin: 0 0 6px 0;
            font-size: 26px;
            font-weight: 800;
        }
        .catalog-header p {
            color: #64748b;
            margin: 0;
            font-size: 14px;
        }

        /* Action Alert Banner */
        .action-alert {
            display: block;
            background: #ecfdf5;
            color: #065f46;
            border: 1.5px solid #a7f3d0;
            padding: 12px 20px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 22px;
        }

        /* Active Offer Banner */
        .offer-banner {
            background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
            border: 1.5px solid #10b981;
            border-radius: 14px;
            padding: 16px 22px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .offer-banner-title {
            font-size: 15px;
            font-weight: 800;
            color: #065f46;
        }
        .offer-banner-sub {
            font-size: 12.5px;
            color: #047857;
            margin-top: 2px;
        }
        .btn-remove-offer {
            background: #ffffff;
            color: #ef4444;
            border: 1px solid #fca5a5;
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
        }

        /* Category Filter Pills (Logged In View) */
        .category-filter-bar {
            display: flex;
            gap: 12px;
            margin-bottom: 26px;
            flex-wrap: wrap;
            align-items: center;
        }
        .category-filter-label {
            font-size: 13px;
            font-weight: 800;
            color: #475569;
            margin-right: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .cat-pill {
            padding: 9px 22px;
            border-radius: 25px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1.5px solid #e2e8f0;
            background: #ffffff;
            color: #475569;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .cat-pill:hover {
            border-color: #ea580c;
            color: #ea580c;
            background: #fff7ed;
        }
        .cat-pill-active {
            background: #ea580c !important;
            color: #ffffff !important;
            border-color: #ea580c !important;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }

        /* Horizontal Card Layout (Matching Figma Images 3 & 4) */
        .figma-service-card {
            background: #ffffff;
            border: 1.5px solid #fed7aa;
            border-radius: 18px;
            padding: 20px 24px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            box-shadow: 0 2px 10px rgba(234, 88, 12, 0.04);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .figma-service-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(234, 88, 12, 0.08);
            border-color: #ea580c;
        }
        .card-details-info {
            flex: 1;
        }
        .service-title-link {
            text-decoration: none;
            color: inherit;
            display: inline-block;
        }
        .service-title-link:hover h3 {
            color: #ea580c;
            text-decoration: underline;
        }
        .btn-view-details {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
            color: #ea580c;
            border: 1.5px solid #fed7aa;
            background: #fff7ed;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
        }
        .btn-view-details:hover {
            background: #ea580c;
            color: #ffffff;
            border-color: #ea580c;
        }
        .card-title-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 4px;
            flex-wrap: wrap;
        }
        .card-title-row h3 {
            margin: 0;
            font-size: 17px;
            font-weight: 800;
            color: #111827;
        }
        .star-rating-pill {
            background: #fef3c7;
            color: #b45309;
            font-size: 11.5px;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 6px;
            border: 1px solid #fde68a;
            display: inline-flex;
            align-items: center;
            gap: 3px;
        }
        .category-tag {
            background: #f1f5f9;
            color: #64748b;
            font-size: 11px;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 6px;
        }
        .card-desc-text {
            margin: 0 0 8px 0;
            font-size: 13px;
            color: #64748b;
            line-height: 1.4;
        }
        .card-pricing-meta {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }
        .card-price-val {
            font-size: 20px;
            font-weight: 800;
            color: #ea580c;
        }
        .card-original-strike {
            font-size: 14px;
            color: #94a3b8;
            text-decoration: line-through;
        }
        .card-duration-text {
            font-size: 12px;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* Right Actions */
        .card-actions-group {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-shrink: 0;
        }
        .btn-wishlist-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #ffffff;
            border: 1.5px solid #fed7aa;
            color: #ea580c;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }
        .btn-wishlist-icon:hover {
            background: #fee2e2;
            border-color: #fca5a5;
            color: #ef4444;
            transform: scale(1.08);
        }
        .btn-add-cart-pill {
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 10px 24px;
            border-radius: 20px;
            font-size: 13.5px;
            font-weight: 800;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
            box-shadow: 0 3px 10px rgba(234, 88, 12, 0.2);
            display: inline-block;
        }
        .btn-add-cart-pill:hover {
            background: #c2410c;
            color: #ffffff;
        }

        /* GUEST VIEW (3-Column Catalog Grid) */
        .guest-catalog-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }
        .guest-card {
            background: #ffffff;
            border: 1.5px solid #ffedd5;
            border-radius: 16px;
            padding: 22px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 0 3px 12px rgba(234, 88, 12, 0.03);
            transition: transform 0.2s;
        }
        .guest-card:hover {
            transform: translateY(-2px);
            border-color: #ea580c;
        }
        .guest-card-title {
            font-size: 17px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 8px 0;
        }
        .guest-card-desc {
            font-size: 13px;
            color: #64748b;
            line-height: 1.45;
            min-height: 48px;
            margin: 0 0 14px 0;
        }
        .guest-card-price {
            font-size: 20px;
            font-weight: 800;
            color: #ea580c;
            margin-bottom: 6px;
        }
        .guest-card-meta {
            font-size: 12px;
            color: #94a3b8;
            margin-bottom: 16px;
        }
        .btn-guest-book {
            background: #ea580c;
            color: #ffffff;
            padding: 11px;
            border-radius: 10px;
            text-decoration: none;
            display: block;
            text-align: center;
            font-weight: 800;
            font-size: 13px;
            transition: background 0.2s;
        }
        .btn-guest-book:hover {
            background: #c2410c;
        }

        @media (max-width: 768px) {
            .figma-service-card {
                flex-direction: column;
                align-items: flex-start;
            }
            .card-actions-group {
                width: 100%;
                justify-content: space-between;
                margin-top: 10px;
                padding-top: 10px;
                border-top: 1px dashed #fed7aa;
            }
            .guest-catalog-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="services-container">
        
        <!-- Header Banner -->
        <div class="catalog-header">
            <div>
                <h1>Professional Detailing Services</h1>
                <p>Choose from our specialized paint correction, PPF protection, and ceramic coating treatments.</p>
            </div>
        </div>


        <!-- Active Offer Banner -->
        <asp:Panel ID="pnlActiveOfferBanner" runat="server" Visible="false" CssClass="offer-banner">
            <div style="display: flex; align-items: center; gap: 14px;">
                <span style="font-size: 26px;">&#127881;</span>
                <div>
                    <div class="offer-banner-title">
                        Special Offer Active: <asp:Label ID="lblOfferTitle" runat="server"></asp:Label> (<asp:Label ID="lblOfferDiscount" runat="server"></asp:Label>% OFF)
                    </div>
                    <div class="offer-banner-sub">
                        All treatments below reflect your discounted prices!
                    </div>
                </div>
            </div>
            <asp:LinkButton ID="btnRemoveOffer" runat="server" OnClick="btnRemoveOffer_Click" CssClass="btn-remove-offer">
                &times; Remove Offer
            </asp:LinkButton>
        </asp:Panel>

        <!-- Dynamic Category Filter Bar (Loaded from Categories Table) -->
        <div class="category-filter-bar">
            <span class="category-filter-label">Categories:</span>
            <asp:LinkButton ID="btnTabAll" runat="server" OnClick="FilterCategory_Click" CommandArgument="" CssClass="cat-pill cat-pill-active">
                All Services
            </asp:LinkButton>
            <asp:Repeater ID="rptCategoryFilter" runat="server" OnItemCommand="rptCategoryFilter_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton ID="btnCategoryTab" runat="server" 
                        CommandName="FilterCategory" 
                        CommandArgument='<%# Eval("CategoryName") %>' 
                        CssClass='<%# GetCategoryPillClass(Eval("CategoryName").ToString()) %>'>
                        <%# Eval("CategoryName") %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- ========================================== -->
        <!-- LOGGED-IN VIEW: FIGMA CARDS -->
        <!-- ========================================== -->
        <asp:Panel ID="pnlLoggedInView" runat="server">

            <!-- Services List (Figma Horizontal Cards without front box) -->
            <asp:Repeater ID="rptLoggedInServices" runat="server" OnItemCommand="rptLoggedInServices_ItemCommand">
                <ItemTemplate>
                    <div class="figma-service-card">
                        
                        <div class="card-details-info">
                            <div class="card-title-row">
                                <a href='<%# "ServiceDetails.aspx?id=" + Eval("ServiceId") %>' class="service-title-link" title="Click to view full service details">
                                    <h3><%# Eval("ServiceName") %></h3>
                                </a>
                                <span class="star-rating-pill">&#9733; <%# string.Format("{0:0.0}", Eval("Rating")) %></span>
                                <span class="category-tag"><%# Eval("Category") %></span>
                            </div>
                            <a href='<%# "ServiceDetails.aspx?id=" + Eval("ServiceId") %>' style="text-decoration: none;" title="Click to view full service details">
                                <p class="card-desc-text"><%# Eval("ShortDescription") %></p>
                            </a>
                            <div class="card-pricing-meta">
                                <span class="card-price-val">&#8377;<%# Eval("DiscountedPriceFormatted") %></span>
                                <%# Convert.ToBoolean(Eval("HasDiscount")) ? "<span class='card-original-strike'>&#8377;" + Eval("OriginalPriceFormatted") + "</span>" : "" %>
                                <span class="card-duration-text">&#128337; approx <%# Eval("Duration") %></span>
                            </div>
                        </div>

                        <!-- Right Actions: View Details, Wishlist Heart & + Add Button -->
                        <div class="card-actions-group">
                            <a href='<%# "ServiceDetails.aspx?id=" + Eval("ServiceId") %>' class="btn-view-details" title="View complete service details">
                                Details &rarr;
                            </a>

                            <asp:LinkButton ID="btnWishlist" runat="server" 
                                CommandName="AddToWishlist" 
                                CommandArgument='<%# Eval("ServiceId") %>' 
                                CssClass="btn-wishlist-icon" 
                                ToolTip="Add to Wishlist">
                                &#10084;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAddToCart" runat="server" 
                                CommandName="AddToCart" 
                                CommandArgument='<%# Eval("ServiceId") %>' 
                                CssClass="btn-add-cart-pill" 
                                ToolTip="Add to Cart">
                                + Add
                            </asp:LinkButton>
                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoServicesLoggedIn" runat="server" Visible="false" style="text-align: center; padding: 40px 20px; background: #ffffff; border-radius: 16px; border: 1.5px dashed #fed7aa; margin: 20px 0;">
                <div style="font-size: 32px; margin-bottom: 8px;">&#128269;</div>
                <h4 style="margin: 0 0 6px 0; color: #1e293b; font-size: 16px; font-weight: 800;">No Services Found</h4>
                <p style="margin: 0; color: #64748b; font-size: 13px;">No treatments currently available in this category.</p>
            </asp:Panel>

        </asp:Panel>

        <!-- ========================================== -->
        <!-- GUEST VIEW: ALL SERVICES IN SINGLE CATALOG -->
        <!-- ========================================== -->
        <asp:Panel ID="pnlGuestView" runat="server" Visible="false">
            <div class="guest-catalog-grid">
                <asp:Repeater ID="rptGuestServices" runat="server">
                    <ItemTemplate>
                        <div class="guest-card">
                            <div>
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 6px;">
                                    <span class="star-rating-pill">&#9733; <%# string.Format("{0:0.0}", Eval("Rating")) %></span>
                                    <span class="category-tag"><%# Eval("Category") %></span>
                                </div>
                                <a href='<%# "ServiceDetails.aspx?id=" + Eval("ServiceId") %>' class="service-title-link" title="Click to view full service details">
                                    <h3 class="guest-card-title"><%# Eval("ServiceName") %></h3>
                                </a>
                                <p class="guest-card-desc"><%# Eval("ShortDescription") %></p>
                            </div>

                            <div>
                                <div class="guest-card-price">&#8377;<%# Eval("OriginalPriceFormatted") %></div>
                                <div class="guest-card-meta">Duration: <%# Eval("Duration") %> | Warranty: <%# Eval("Warranty") %></div>
                                <a href='<%# "ServiceDetails.aspx?id=" + Eval("ServiceId") %>' class="btn-guest-book">View Details &amp; Book &rarr;</a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlNoServicesGuest" runat="server" Visible="false" style="text-align: center; padding: 40px 20px; background: #ffffff; border-radius: 16px; border: 1.5px dashed #fed7aa; margin: 20px 0;">
                <div style="font-size: 32px; margin-bottom: 8px;">&#128269;</div>
                <h4 style="margin: 0 0 6px 0; color: #1e293b; font-size: 16px; font-weight: 800;">No Services Found</h4>
                <p style="margin: 0; color: #64748b; font-size: 13px;">No treatments currently available in this category.</p>
            </asp:Panel>
        </asp:Panel>

    </div>
</asp:Content>