<%@ Page Title="Payment Transactions" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManagePayments.aspx.cs" Inherits="creation_car_care.Admin.ManagePayments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .payments-mgmt-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        /* Top Dark Navy Card (Exact Match Image 2 Frame 4) */
        .revenue-hero-card {
            background: #111827;
            border-radius: 20px;
            padding: 26px 32px;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
            box-shadow: 0 4px 20px rgba(17, 24, 39, 0.15);
        }

        .revenue-meta-lbl {
            font-size: 11.5px;
            font-weight: 800;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 6px;
        }

        .revenue-hero-amount {
            font-size: 32px;
            font-weight: 800;
            color: #f97316;
            margin: 0 0 4px 0;
            letter-spacing: -0.5px;
        }

        .revenue-trend-sub {
            font-size: 12.5px;
            color: #34d399;
            font-weight: 600;
        }

        .btn-export-excel {
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 12px 22px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-export-excel:hover {
            background: #c2410c;
        }

        /* Subheading */
        .section-sub-title {
            font-size: 11.5px;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: 16px;
        }

        /* Transactions List (Exact Match Image 2 Frame 4) */
        .transactions-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .trx-row-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 18px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: all 0.2s ease;
        }

        .trx-row-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
        }

        .trx-card-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .trx-icon-circle {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: #fff7ed;
            color: #ea580c;
            border: 1px solid #fed7aa;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .trx-meta-info h4 {
            margin: 0 0 3px 0;
            font-size: 15px;
            font-weight: 800;
            color: #0f172a;
        }

        .trx-meta-info p {
            margin: 0;
            font-size: 12.5px;
            color: #64748b;
            font-weight: 500;
        }

        .trx-card-right {
            text-align: right;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 4px;
        }

        .trx-amount-text {
            font-size: 16px;
            font-weight: 800;
            color: #ea580c;
        }

        .badge-trx-success {
            background: #dcfce7;
            color: #15803d;
            font-size: 10.5px;
            font-weight: 800;
            padding: 2px 10px;
            border-radius: 20px;
            letter-spacing: 0.5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="payments-mgmt-container">
        
        <!-- Top Dark Navy Hero Card (Exact Match Image 2 Frame 4) -->
        <div class="revenue-hero-card">
            <div>
                <div class="revenue-meta-lbl">TOTAL REVENUE COLLECTED</div>
                <h2 class="revenue-hero-amount">&#8377;<asp:Label ID="lblTotalRevenue" runat="server" Text="45,599.00"></asp:Label></h2>
                <div class="revenue-trend-sub">&#10003; +12.4% from last month</div>
            </div>
            <div>
                <asp:Button ID="btnExportReport" runat="server" Text="EXPORT REPORT" CssClass="btn-export-excel" OnClick="btnExportReport_Click" />
            </div>
        </div>

        <div class="section-sub-title">Recent Transactions (Paid)</div>

        <!-- Transactions List -->
        <asp:Repeater ID="rptTransactions" runat="server">
            <HeaderTemplate>
                <div class="transactions-list">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="trx-row-card">
                    <div class="trx-card-left">
                        <div class="trx-icon-circle">&#128179;</div>
                        <div class="trx-meta-info">
                            <h4><%# Eval("CustomerName") %></h4>
                            <p><%# Eval("PaymentMethod") %> &bull; <%# Eval("BookingCode") %></p>
                        </div>
                    </div>

                    <div class="trx-card-right">
                        <div class="trx-amount-text">+&#8377;<%# string.Format("{0:N0}", Eval("Amount")) %></div>
                        <div style="font-size: 11.5px; color: #94a3b8; font-weight: 500;"><%# Eval("DateText") %></div>
                        <span class="badge-trx-success"><%# Eval("PaymentStatus") %></span>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
