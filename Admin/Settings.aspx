<%@ Page Title="Settings & Profile" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="creation_car_care.Admin.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .settings-container {
            max-width: 760px;
        }
        /* Admin Profile Card */
        .profile-summary-box {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
        }
        .profile-summary-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .avatar-dl {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            background: #ea580c;
            color: #ffffff;
            font-size: 18px;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }
        .profile-summary-text h3 {
            margin: 0 0 4px 0;
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
        }
        .profile-summary-text p {
            margin: 0;
            font-size: 12.5px;
            color: #64748b;
        }
        /* Section Group */
        .settings-section-lbl {
            font-size: 11.5px;
            font-weight: 800;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin: 0 0 10px 4px;
        }
        .settings-group-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
        }
        .setting-nav-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 22px;
            text-decoration: none;
            color: inherit;
            border-bottom: 1px solid #f1f5f9;
            transition: background 0.15s;
        }
        .setting-nav-row:last-child {
            border-bottom: none;
        }
        .setting-nav-row:hover {
            background-color: #f8fafc;
        }
        .setting-nav-left {
            display: flex;
            align-items: center;
            gap: 14px;
            font-size: 14px;
            font-weight: 700;
            color: #1e293b;
        }
        .setting-nav-left .row-icon {
            font-size: 16px;
            color: #64748b;
            width: 22px;
            text-align: center;
        }
        .setting-nav-arrow {
            color: #cbd5e1;
            font-size: 16px;
            font-weight: bold;
        }
        /* Toggle Switch */
        .switch {
            position: relative;
            display: inline-block;
            width: 44px;
            height: 24px;
        }
        .switch input { 
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #e2e8f0;
            transition: .3s;
            border-radius: 24px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .3s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #ea580c;
        }
        input:checked + .slider:before {
            transform: translateX(20px);
        }
        .btn-logout-danger {
            width: 100%;
            background: #fff5f5;
            color: #e11d48;
            border: 1.5px solid #fecdd3;
            padding: 14px;
            border-radius: 12px;
            font-size: 13.5px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.2s;
            display: block;
            text-align: center;
            text-decoration: none;
            box-sizing: border-box;
            margin-top: 10px;
        }
        .btn-logout-danger:hover {
            background: #ffe4e6;
            border-color: #fda4af;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="settings-container">
        
        <!-- Admin Profile Box (Matches Screenshot 1 Frame 4) -->
        <div class="profile-summary-box">
            <div class="profile-summary-left">
                <div class="avatar-dl">DL</div>
                <div class="profile-summary-text">
                    <h3><asp:Label ID="lblAdminFullName" runat="server" Text="Dev Limbasiya"></asp:Label></h3>
                    <p><asp:Label ID="lblAdminEmail" runat="server" Text="admin@creation.com"></asp:Label></p>
                </div>
            </div>
            <div>
                <a href="AdminProfile.aspx" style="color: #ea580c; font-size: 13px; font-weight: 700; text-decoration: none;">View Profile &rarr;</a>
            </div>
        </div>

        <!-- Group 1: STUDIO MANAGEMENT -->
        <div class="settings-section-lbl">Studio Management</div>
        <div class="settings-group-card">
            <a href="AdminProfile.aspx" class="setting-nav-row">
                <div class="setting-nav-left">
                    <span class="row-icon">&#128100;</span>
                    <span>Edit Profile Details</span>
                </div>
                <span class="setting-nav-arrow">&rarr;</span>
            </a>

            <a href="WorkingHours.aspx" class="setting-nav-row">
                <div class="setting-nav-left">
                    <span class="row-icon">&#128337;</span>
                    <span>Working Hours &amp; Shifts</span>
                </div>
                <span class="setting-nav-arrow">&rarr;</span>
            </a>
        </div>

        <!-- Group 2: APP PREFERENCES -->
        <div class="settings-section-lbl">App Preferences</div>
        <div class="settings-group-card">
            <div class="setting-nav-row" style="cursor: default;">
                <div class="setting-nav-left">
                    <span class="row-icon">&#128276;</span>
                    <span>Push Notifications</span>
                </div>
                <label class="switch">
                    <input type="checkbox" checked="checked" />
                    <span class="slider"></span>
                </label>
            </div>

            <a href="ChangePassword.aspx" class="setting-nav-row">
                <div class="setting-nav-left">
                    <span class="row-icon">&#128274;</span>
                    <span>Change Password</span>
                </div>
                <span class="setting-nav-arrow">&rarr;</span>
            </a>
        </div>

        <!-- Log Out from Admin Button -->
        <asp:LinkButton ID="btnLogoutAdmin" runat="server" OnClick="btnLogoutAdmin_Click" CssClass="btn-logout-danger">
            LOG OUT FROM ADMIN
        </asp:LinkButton>

    </div>
</asp:Content>
