<%@ Page Title="All Recent Activity" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Activity.aspx.cs" Inherits="creation_car_care.Admin.Activity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .activity-page-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px 28px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
        }
        .activity-page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            border-bottom: 1px solid #f1f5f9;
            padding-bottom: 16px;
        }
        .activity-page-header h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 800;
            color: #0f172a;
        }
        .feed-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 0;
            border-bottom: 1px solid #f8fafc;
        }
        .feed-row:last-child {
            border-bottom: none;
        }
        .feed-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .status-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            flex-shrink: 0;
        }
        .feed-title {
            font-size: 14px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 2px;
        }
        .feed-desc {
            font-size: 12.5px;
            color: #64748b;
        }
        .feed-time {
            font-size: 12px;
            color: #94a3b8;
            font-weight: 600;
        }
        .pagination-bar {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
        }
        .page-btn {
            padding: 7px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            background: #ffffff;
            color: #475569;
            font-size: 12.5px;
            font-weight: 700;
            text-decoration: none;
        }
        .page-btn.active {
            background: #ea580c;
            color: #ffffff;
            border-color: #ea580c;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="activity-page-card">
        <div class="activity-page-header">
            <h2>Live Studio Operations &amp; Events</h2>
            <span style="font-size: 12px; color: #64748b; font-weight: 600;">Automated audit trail</span>
        </div>

        <asp:Repeater ID="rptAllActivity" runat="server">
            <ItemTemplate>
                <div class="feed-row">
                    <div class="feed-left">
                        <span class="status-dot" style='background-color: <%# Eval("BadgeColor") %>;'></span>
                        <div>
                            <div class="feed-title"><%# Eval("Title") %></div>
                            <div class="feed-desc"><%# Eval("Description") %></div>
                        </div>
                    </div>
                    <div class="feed-time">
                        <%# string.Format("{0:dd MMM, hh:mm tt}", Eval("CreatedAt")) %>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <div class="pagination-bar">
            <a href="#" class="page-btn">Previous</a>
            <a href="#" class="page-btn active">1</a>
            <a href="#" class="page-btn">2</a>
            <a href="#" class="page-btn">Next</a>
        </div>
    </div>
</asp:Content>
