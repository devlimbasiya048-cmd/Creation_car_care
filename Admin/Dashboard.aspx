<%@ Page Title="Dashboard Overview" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="creation_car_care.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Top Stat Metric Cards (Matching Screenshot 1 Frame 2) */
        .stat-metrics-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 28px;
        }
        .metric-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
        }
        .metric-info .metric-lbl {
            font-size: 11.5px;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.6px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .metric-info .metric-val {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.2;
        }
        .metric-badge {
            font-size: 11.5px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .badge-revenue {
            background: #ecfdf5;
            color: #059669;
            border: 1px solid #a7f3d0;
        }
        .badge-pending {
            background: #fff7ed;
            color: #ea580c;
            border: 1px solid #fed7aa;
        }
        /* Quick Management Hub Grid */
        .hub-section-heading {
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 16px 0;
        }
        .hub-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 32px;
        }
        .hub-box {
            background: #ffffff;
            border: 1.5px solid #f1f5f9;
            border-radius: 14px;
            padding: 18px 20px;
            text-decoration: none;
            color: inherit;
            display: flex;
            align-items: center;
            gap: 14px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
            transition: all 0.2s ease;
        }
        .hub-box:hover {
            transform: translateY(-2px);
            border-color: #ea580c;
            box-shadow: 0 6px 18px rgba(234, 88, 12, 0.08);
        }
        .hub-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
            background: #fff7ed;
            color: #ea580c;
        }
        .hub-info h4 {
            margin: 0 0 2px 0;
            font-size: 14px;
            font-weight: 800;
            color: #0f172a;
        }
        .hub-info span {
            font-size: 11.5px;
            color: #64748b;
        }
        /* Recent Activity Card */
        .activity-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
        }
        .activity-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }
        .activity-header h3 {
            margin: 0;
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
        }
        .link-view-all {
            color: #ea580c;
            font-size: 12.5px;
            font-weight: 700;
            text-decoration: none;
        }
        .activity-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 13px 0;
            border-bottom: 1px dashed #f1f5f9;
        }
        .activity-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        .activity-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .activity-dot {
            width: 9px;
            height: 9px;
            border-radius: 50%;
            flex-shrink: 0;
        }
        .activity-text-title {
            font-size: 13.5px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 2px;
        }
        .activity-text-desc {
            font-size: 12px;
            color: #64748b;
        }
        .activity-time {
            font-size: 11.5px;
            color: #94a3b8;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <!-- Top Stat Metric Cards -->
    <div class="stat-metrics-row">
        <!-- Revenue Card -->
        <div class="metric-card">
            <div class="metric-info">
                <div class="metric-lbl">TOTAL REVENUE (STUDIO SALES)</div>
                <div class="metric-val">&#8377;<asp:Label ID="lblTotalRevenue" runat="server" Text="45,599"></asp:Label></div>
            </div>
            <div>
                <span class="metric-badge badge-revenue">&#10004; Verified Income</span>
            </div>
        </div>

        <!-- Pending Bookings Card -->
        <div class="metric-card">
            <div class="metric-info">
                <div class="metric-lbl">PENDING APPOINTMENTS</div>
                <div class="metric-val"><asp:Label ID="lblPendingBookings" runat="server" Text="02"></asp:Label> Bookings</div>
            </div>
            <div>
                <span class="metric-badge badge-pending">&#9888; Action Required</span>
            </div>
        </div>
    </div>

    <!-- Quick Management Hub Heading -->
    <h3 class="hub-section-heading">Master Management Hub</h3>

    <!-- 8 Quick Hub Cards -->
    <div class="hub-grid">
        <a href="ManageUsers.aspx" class="hub-box">
            <div class="hub-icon">&#128101;</div>
            <div class="hub-info">
                <h4>Users</h4>
                <span>Manage Users (<asp:Label ID="lblUsersCount" runat="server" Text="0"></asp:Label>)</span>
            </div>
        </a>

        <a href="ManageBookings.aspx" class="hub-box">
            <div class="hub-icon">&#128197;</div>
            <div class="hub-info">
                <h4>Bookings</h4>
                <span>Live Slot Tracking</span>
            </div>
        </a>

        <a href="ManageServices.aspx" class="hub-box">
            <div class="hub-icon">&#128295;</div>
            <div class="hub-info">
                <h4>Services</h4>
                <span>Detailing Catalog</span>
            </div>
        </a>

        <a href="ManageCategories.aspx" class="hub-box">
            <div class="hub-icon">&#127991;</div>
            <div class="hub-info">
                <h4>Categories</h4>
                <span>Grouping System</span>
            </div>
        </a>

        <a href="ManageOffers.aspx" class="hub-box">
            <div class="hub-icon">&#127873;</div>
            <div class="hub-info">
                <h4>Offers</h4>
                <span>Deals &amp; Validity</span>
            </div>
        </a>

        <a href="ManagePayments.aspx" class="hub-box">
            <div class="hub-icon">&#128179;</div>
            <div class="hub-info">
                <h4>Payments</h4>
                <span>UPI, Card &amp; COD</span>
            </div>
        </a>

        <a href="Reports.aspx" class="hub-box">
            <div class="hub-icon">&#128196;</div>
            <div class="hub-info">
                <h4>Reports</h4>
                <span>Sales &amp; Analytics</span>
            </div>
        </a>

        <a href="Settings.aspx" class="hub-box">
            <div class="hub-icon">&#9881;</div>
            <div class="hub-info">
                <h4>Settings</h4>
                <span>Studio Shifts &amp; Hours</span>
            </div>
        </a>
    </div>

    <!-- Recent Activity Card -->
    <div class="activity-card">
        <div class="activity-header">
            <h3>Recent Activity Feed</h3>
            <a href="Activity.aspx" class="link-view-all">View All &rarr;</a>
        </div>

        <asp:Repeater ID="rptRecentActivity" runat="server">
            <ItemTemplate>
                <div class="activity-item">
                    <div class="activity-left">
                        <span class="activity-dot" style='background-color: <%# Eval("BadgeColor") %>;'></span>
                        <div>
                            <div class="activity-text-title"><%# Eval("Title") %></div>
                            <div class="activity-text-desc"><%# Eval("Description") %></div>
                        </div>
                    </div>
                    <div class="activity-time">
                        <%# string.Format("{0:dd MMM, hh:mm tt}", Eval("CreatedAt")) %>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>
