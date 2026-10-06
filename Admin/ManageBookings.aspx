<%@ Page Title="All Bookings" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageBookings.aspx.cs" Inherits="creation_car_care.Admin.ManageBookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bookings-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Top Action Bar */
        .actions-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .search-wrapper {
            position: relative;
            flex: 1;
            min-width: 280px;
            max-width: 480px;
            display: flex;
            gap: 10px;
        }

        .search-input {
            width: 100%;
            padding: 12px 18px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            background: #ffffff;
            color: #1e293b;
            outline: none;
            transition: border-color 0.2s;
        }

        .search-input:focus {
            border-color: #ea580c;
        }

        .btn-search {
            padding: 12px 20px;
            background: #ea580c;
            color: #ffffff;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            transition: background 0.2s;
            white-space: nowrap;
        }

        .btn-search:hover {
            background: #c2410c;
        }

        .btn-toggle-filter {
            padding: 12px 20px;
            background: #ffffff;
            color: #475569;
            border: 1.5px solid #cbd5e1;
            border-radius: 12px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-toggle-filter:hover {
            border-color: #ea580c;
            color: #ea580c;
        }

        /* Status Tabs (Matches Figma Screenshot 3) */
        .status-tabs {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 24px;
            overflow-x: auto;
            padding-bottom: 6px;
        }

        .tab-btn {
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 13.5px;
            font-weight: 700;
            text-decoration: none;
            color: #64748b;
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            transition: all 0.2s ease;
            white-space: nowrap;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .tab-btn:hover {
            border-color: #cbd5e1;
            color: #0f172a;
        }

        .tab-btn.active {
            background: #ea580c;
            color: #ffffff;
            border-color: #ea580c;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }

        .tab-count {
            background: rgba(0, 0, 0, 0.08);
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .tab-btn.active .tab-count {
            background: rgba(255, 255, 255, 0.25);
            color: #ffffff;
        }

        /* Filter Panel (Collapsible / Modal) */
        .filter-panel {
            background: #ffffff;
            border: 1px solid #fed7aa;
            border-radius: 16px;
            padding: 20px 24px;
            margin-bottom: 24px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
            display: none;
        }

        .filter-panel.show {
            display: block;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 16px;
        }

        .filter-group label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #475569;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #1e293b;
            background: #f8fafc;
        }

        .filter-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-filter-apply {
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
        }

        .btn-filter-reset {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
        }

        /* Results Status Text */
        .results-text {
            font-size: 13px;
            color: #64748b;
            font-weight: 600;
            margin-bottom: 16px;
        }

        /* Booking Cards Grid (Matches Figma 2-Column Responsive) */
        .bookings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(480px, 1fr));
            gap: 20px;
        }

        @media (max-width: 768px) {
            .bookings-grid {
                grid-template-columns: 1fr;
            }
        }

        .booking-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px 24px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: 16px;
            transition: all 0.2s ease;
        }

        .booking-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
            transform: translateY(-2px);
        }

        .card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 12px;
            border-bottom: 1px dashed #e2e8f0;
        }

        .booking-code {
            font-size: 15px;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: 0.5px;
        }

        .booking-time {
            font-size: 13px;
            font-weight: 600;
            color: #64748b;
        }

        .card-body {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
        }

        .customer-info {
            flex: 1;
        }

        .customer-name {
            font-size: 16.5px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px 0;
        }

        .service-title {
            font-size: 14px;
            font-weight: 700;
            color: #ea580c;
            margin: 0 0 4px 0;
        }

        .vehicle-name {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
            margin: 0;
        }

        .price-badge-box {
            text-align: right;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 6px;
        }

        .price-text {
            font-size: 18px;
            font-weight: 800;
            color: #0f172a;
        }

        .badge-paid {
            background: #dcfce7;
            color: #15803d;
            font-size: 11px;
            font-weight: 800;
            padding: 3px 10px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .badge-pending-pay {
            background: #fef3c7;
            color: #b45309;
            font-size: 11px;
            font-weight: 800;
            padding: 3px 10px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .card-footer {
            margin-top: 4px;
        }

        /* Buttons (Outlined Orange for Update, Solid Navy for Receipt) */
        .btn-update-status {
            width: 100%;
            background: #ffffff;
            color: #ea580c;
            border: 1.5px solid #ea580c;
            padding: 11px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13px;
            text-align: center;
            text-decoration: none;
            display: block;
            box-sizing: border-box;
            transition: all 0.2s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-update-status:hover {
            background: #ea580c;
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.2);
        }

        .btn-view-receipt {
            width: 100%;
            background: #f8fafc;
            color: #0f172a;
            border: 1.5px solid #cbd5e1;
            padding: 11px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13px;
            text-align: center;
            text-decoration: none;
            display: block;
            box-sizing: border-box;
            transition: all 0.2s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-view-receipt:hover {
            background: #0f172a;
            color: #ffffff;
            border-color: #0f172a;
        }

        /* Empty State */
        .empty-bookings-box {
            background: #ffffff;
            border: 1.5px dashed #cbd5e1;
            border-radius: 16px;
            padding: 60px 20px;
            text-align: center;
            color: #64748b;
        }

        .empty-icon {
            font-size: 40px;
            margin-bottom: 12px;
            color: #94a3b8;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bookings-container">
        
        <!-- Search and Filter Bar -->
        <div class="actions-bar">
            <div class="search-wrapper">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" Placeholder="Search by ID, Name or Vehicle..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <button type="button" class="btn-toggle-filter" onclick="toggleFilterPanel()">
                <span>&#128394;</span> Filter Bookings
            </button>
        </div>

        <!-- Filter Panel (Collapsible) -->
        <div id="filterPanel" class="filter-panel <%= FilterPanelVisible ? "show" : "" %>">
            <div class="filter-grid">
                <div class="filter-group">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="filter-control"></asp:TextBox>
                </div>
                <div class="filter-group">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="filter-control"></asp:TextBox>
                </div>
                <div class="filter-group">
                    <label>Payment Status</label>
                    <asp:DropDownList ID="ddlPaymentStatus" runat="server" CssClass="filter-control">
                        <asp:ListItem Text="All Payments" Value=""></asp:ListItem>
                        <asp:ListItem Text="Paid" Value="Paid"></asp:ListItem>
                        <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="filter-actions">
                <asp:Button ID="btnResetFilter" runat="server" Text="Reset All" CssClass="btn-filter-reset" OnClick="btnResetFilter_Click" />
                <asp:Button ID="btnApplyFilter" runat="server" Text="Apply Filters" CssClass="btn-filter-apply" OnClick="btnApplyFilter_Click" />
            </div>
        </div>

        <!-- Status Filter Tabs (Matches Screenshot 3) -->
        <div class="status-tabs">
            <asp:LinkButton ID="tabAll" runat="server" CssClass='<%= GetTabClass("") %>' OnClick="Tab_Click" CommandArgument="">
                All Bookings <span class="tab-count"><asp:Label ID="lblCountAll" runat="server" Text="0"></asp:Label></span>
            </asp:LinkButton>
            <asp:LinkButton ID="tabPending" runat="server" CssClass='<%= GetTabClass("pending") %>' OnClick="Tab_Click" CommandArgument="pending">
                Pending <span class="tab-count"><asp:Label ID="lblCountPending" runat="server" Text="0"></asp:Label></span>
            </asp:LinkButton>
            <asp:LinkButton ID="tabInProgress" runat="server" CssClass='<%= GetTabClass("in progress") %>' OnClick="Tab_Click" CommandArgument="in progress">
                In Progress <span class="tab-count"><asp:Label ID="lblCountInProgress" runat="server" Text="0"></asp:Label></span>
            </asp:LinkButton>
            <asp:LinkButton ID="tabCompleted" runat="server" CssClass='<%= GetTabClass("completed") %>' OnClick="Tab_Click" CommandArgument="completed">
                Completed <span class="tab-count"><asp:Label ID="lblCountCompleted" runat="server" Text="0"></asp:Label></span>
            </asp:LinkButton>
        </div>

        <!-- Showing Result Counter -->
        <div class="results-text">
            <asp:Label ID="lblResultInfo" runat="server" Text="Showing all bookings"></asp:Label>
        </div>

        <!-- Bookings Grid -->
        <asp:Repeater ID="rptBookings" runat="server">
            <HeaderTemplate>
                <div class="bookings-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="booking-card">
                    <div class="card-top">
                        <span class="booking-code"><%# Eval("BookingCode") %></span>
                        <span class="booking-time"><%# Eval("SlotDateText") %>, <%# Eval("SlotTime") %></span>
                    </div>

                    <div class="card-body">
                        <div class="customer-info">
                            <h4 class="customer-name"><%# Eval("FullName") %></h4>
                            <p class="service-title"><%# Eval("ServiceName") %></p>
                            <p class="vehicle-name"><%# Eval("VehicleDetails") %></p>
                        </div>
                        <div class="price-badge-box">
                            <span class="price-text">&#8377;<%# string.Format("{0:N0}", Eval("TotalAmount")) %></span>
                            <span class='<%# Eval("PaymentStatus").ToString().ToLower() == "paid" ? "badge-paid" : "badge-pending-pay" %>'>
                                <%# Eval("PaymentStatus") %>
                            </span>
                        </div>
                    </div>

                    <div class="card-footer">
                        <%# GetActionButtonHtml(Eval("BookingCode").ToString(), Eval("BookingStatus").ToString()) %>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <!-- No Records Found State -->
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-bookings-box">
            <div class="empty-icon">&#128197;</div>
            <h3 style="margin: 0 0 6px 0; color: #1e293b;">No bookings found</h3>
            <p style="margin: 0; font-size: 14px;">Try searching for another keyword or change your filter selection.</p>
        </asp:Panel>

    </div>

    <script>
        function toggleFilterPanel() {
            var panel = document.getElementById('filterPanel');
            if (panel.classList.contains('show')) {
                panel.classList.remove('show');
            } else {
                panel.classList.add('show');
            }
        }
    </script>
</asp:Content>
