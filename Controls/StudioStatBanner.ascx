<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StudioStatBanner.ascx.cs" Inherits="creation_car_care.Controls.StudioStatBanner" %>

<!-- Reusable ASP.NET Web User Control (Syllabus Unit 6: Web User Controls) -->
<style>
    .studio-stat-container {
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        border: 1px solid #334155;
        border-radius: 20px;
        padding: 24px 32px;
        margin-bottom: 32px;
        color: #ffffff;
        box-shadow: 0 10px 25px rgba(15, 23, 42, 0.12);
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
    }

    .stat-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: rgba(234, 88, 12, 0.18);
        border: 1px solid rgba(234, 88, 12, 0.4);
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 700;
        color: #fb923c;
        letter-spacing: 0.5px;
    }

    .pulse-dot {
        width: 8px;
        height: 8px;
        background-color: #22c55e;
        border-radius: 50%;
        display: inline-block;
        box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.3);
    }

    .stat-metrics-group {
        display: flex;
        align-items: center;
        gap: 36px;
        flex-wrap: wrap;
    }

    .stat-metric-item {
        display: flex;
        flex-direction: column;
    }

    .stat-metric-num {
        font-size: 24px;
        font-weight: 800;
        color: #ffffff;
        line-height: 1.1;
    }

    .stat-metric-num.highlight {
        color: #f97316;
    }

    .stat-metric-lbl {
        font-size: 11.5px;
        color: #94a3b8;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.6px;
        margin-top: 4px;
    }

    .stat-divider {
        width: 1px;
        height: 38px;
        background-color: #334155;
    }

    @media (max-width: 768px) {
        .studio-stat-container {
            padding: 20px;
            flex-direction: column;
            align-items: flex-start;
        }
        .stat-metrics-group {
            gap: 20px;
            width: 100%;
            justify-content: space-between;
        }
        .stat-divider {
            display: none;
        }
    }
</style>

<div class="studio-stat-container">
    <div>
        <div class="stat-badge">
            <span class="pulse-dot"></span>
            <asp:Label ID="lblStudioStatus" runat="server" Text="Studio Operating Daily (09:00 AM - 08:00 PM)"></asp:Label>
        </div>
        <div style="margin-top: 8px; font-size: 13.5px; color: #cbd5e1; font-weight: 500;">
            Rajkot's premier ceramic coating &amp; self-healing PPF detailing studio.
        </div>
    </div>

    <div class="stat-metrics-group">
        <div class="stat-metric-item">
            <span class="stat-metric-num highlight">
                <asp:Label ID="lblTotalVisitors" runat="server" Text="1,420+"></asp:Label>
            </span>
            <span class="stat-metric-lbl">Visitors Served</span>
        </div>

        <div class="stat-divider"></div>

        <div class="stat-metric-item">
            <span class="stat-metric-num">
                <asp:Label ID="lblActiveDetailingBays" runat="server" Text="4 Bays"></asp:Label>
            </span>
            <span class="stat-metric-lbl">Dust-Free Booths</span>
        </div>

        <div class="stat-divider"></div>

        <div class="stat-metric-item">
            <span class="stat-metric-num highlight">4.9 &#9733;</span>
            <span class="stat-metric-lbl">Customer Rating</span>
        </div>

        <div class="stat-divider"></div>

        <div class="stat-metric-item">
            <span class="stat-metric-num">
                <asp:Label ID="lblOnlineUsers" runat="server" Text="1"></asp:Label>
            </span>
            <span class="stat-metric-lbl">Active Online</span>
        </div>
    </div>
</div>
