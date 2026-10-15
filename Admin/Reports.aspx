<%@ Page Title="Reports & Analytics" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="creation_car_care.Admin.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .analytics-container {
            max-width: 1100px;
            margin: 0 auto;
        }

        /* Top 3 Metric Cards (Exact Match Image 2 Frame 5) */
        .top-metrics-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1.4fr;
            gap: 20px;
            margin-bottom: 28px;
        }

        @media (max-width: 900px) {
            .top-metrics-row {
                grid-template-columns: 1fr;
            }
        }

        .metric-white-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            padding: 22px 26px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .metric-card-lbl {
            font-size: 11px;
            font-weight: 800;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: 8px;
        }

        .metric-big-val {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 6px 0;
            line-height: 1.1;
        }

        .metric-sub-green {
            font-size: 12px;
            color: #10b981;
            font-weight: 700;
        }

        /* Dark Navy Action Card */
        .dark-export-card {
            background: #111827;
            border-radius: 18px;
            padding: 22px 26px;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 16px rgba(17, 24, 39, 0.2);
        }

        .dark-export-left h4 {
            margin: 0 0 4px 0;
            font-size: 15px;
            font-weight: 800;
            letter-spacing: 0.5px;
        }

        .dark-export-left p {
            margin: 0;
            font-size: 12px;
            color: #94a3b8;
        }

        .btn-export-csv {
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 11px 20px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.2s;
            white-space: nowrap;
        }

        .btn-export-csv:hover {
            background: #c2410c;
        }

        /* 2-Column Analytics Content Grid */
        .charts-2col-grid {
            display: grid;
            grid-template-columns: 1.3fr 1fr;
            gap: 20px;
        }

        @media (max-width: 860px) {
            .charts-2col-grid {
                grid-template-columns: 1fr;
            }
        }

        .analytics-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            padding: 24px 28px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
        }

        .card-heading-title {
            font-size: 15px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 20px 0;
        }

        /* CSS Bar Chart (Exact Match Image 2 Frame 5) */
        .bar-chart-container {
            display: flex;
            align-items: flex-end;
            justify-content: space-around;
            height: 220px;
            padding-top: 30px;
            border-bottom: 1.5px solid #f1f5f9;
        }

        .bar-chart-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            position: relative;
        }

        .chart-bar-pillar {
            width: 38px;
            border-radius: 8px 8px 0 0;
            background: #fed7aa;
            transition: all 0.3s ease;
        }

        .chart-bar-pillar.active-month {
            background: #ea580c;
            box-shadow: 0 4px 14px rgba(234, 88, 12, 0.35);
        }

        .month-name-lbl {
            font-size: 12px;
            font-weight: 700;
            color: #64748b;
        }

        .active-pillar-val-pill {
            position: absolute;
            top: -26px;
            background: #ea580c;
            color: #ffffff;
            font-size: 10.5px;
            font-weight: 800;
            padding: 2px 8px;
            border-radius: 12px;
            white-space: nowrap;
        }

        /* Top Services List */
        .top-services-list {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .top-service-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 16px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .top-service-meta h5 {
            margin: 0 0 2px 0;
            font-size: 13.5px;
            font-weight: 800;
            color: #0f172a;
        }

        .top-service-meta span {
            font-size: 11.5px;
            color: #64748b;
        }

        .top-service-val {
            font-size: 14px;
            font-weight: 800;
            color: #ea580c;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="analytics-container">
        
        <!-- Top 3 Metrics Cards (Exact Match Image 2 Frame 5) -->
        <div class="top-metrics-row">
            <!-- Card 1: Total Orders -->
            <div class="metric-white-card">
                <div>
                    <div class="metric-card-lbl">TOTAL ORDERS</div>
                    <h3 class="metric-big-val"><asp:Label ID="lblTotalOrders" runat="server" Text="120"></asp:Label></h3>
                </div>
                <div class="metric-sub-green">&#10003; +8% vs last month</div>
            </div>

            <!-- Card 2: Net Revenue -->
            <div class="metric-white-card">
                <div>
                    <div class="metric-card-lbl">NET REVENUE</div>
                    <h3 class="metric-big-val" style="color: #ea580c;">&#8377;<asp:Label ID="lblNetRevenue" runat="server" Text="1.45 Lakh"></asp:Label></h3>
                </div>
                <div class="metric-sub-green">&#10003; +15% vs target</div>
            </div>

            <!-- Card 3: Export Report (Dark Navy Card) -->
            <div class="dark-export-card">
                <div class="dark-export-left">
                    <h4>EXPORT TAX REPORT</h4>
                    <p>Download monthly financial overview slip</p>
                </div>
                <div>
                    <asp:Button ID="btnExportCsv" runat="server" Text="EXPORT CSV" CssClass="btn-export-csv" OnClick="btnExportCsv_Click" />
                </div>
            </div>
        </div>

        <!-- 2-Column Analytics Content Grid -->
        <div class="charts-2col-grid">
            
            <!-- Left: Monthly Revenue Trend Bar Chart -->
            <div class="analytics-card">
                <h4 class="card-heading-title">Monthly Revenue Trend</h4>

                <div class="bar-chart-container">
                    <!-- May -->
                    <div class="bar-chart-item">
                        <div class="chart-bar-pillar" style="height: 60px;"></div>
                        <span class="month-name-lbl">May</span>
                    </div>

                    <!-- Jun -->
                    <div class="bar-chart-item">
                        <div class="chart-bar-pillar" style="height: 95px;"></div>
                        <span class="month-name-lbl">Jun</span>
                    </div>

                    <!-- Jul -->
                    <div class="bar-chart-item">
                        <div class="chart-bar-pillar" style="height: 125px;"></div>
                        <span class="month-name-lbl">Jul</span>
                    </div>

                    <!-- Aug (Current Active Month with Pill) -->
                    <div class="bar-chart-item">
                        <div class="active-pillar-val-pill">&#8377;45.5k</div>
                        <div class="chart-bar-pillar active-month" style="height: 165px;"></div>
                        <span class="month-name-lbl" style="color: #ea580c; font-weight: 800;">Aug</span>
                    </div>

                    <!-- Sep -->
                    <div class="bar-chart-item">
                        <div class="chart-bar-pillar" style="height: 80px;"></div>
                        <span class="month-name-lbl">Sep</span>
                    </div>
                </div>

                <div style="display: flex; justify-content: space-between; margin-top: 16px; font-size: 12px; color: #64748b;">
                    <span>Lowest: &#8377;18,200 (May)</span>
                    <span style="color: #ea580c; font-weight: 700;">Peak: &#8377;45,599 (Current)</span>
                </div>
            </div>

            <!-- Right: Top Services by Revenue -->
            <div class="analytics-card">
                <h4 class="card-heading-title">Top Services by Revenue</h4>

                <div class="top-services-list">
                    <asp:Repeater ID="rptTopServices" runat="server">
                        <ItemTemplate>
                            <div class="top-service-item">
                                <div class="top-service-meta">
                                    <h5><%# Eval("ServiceName") %></h5>
                                    <span><%# Eval("OrdersText") %></span>
                                </div>
                                <div class="top-service-val">
                                    &#8377;<%# string.Format("{0:N0}", Eval("Revenue")) %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

        </div>

    </div>
</asp:Content>
