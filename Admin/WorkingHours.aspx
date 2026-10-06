<%@ Page Title="Working Hours & Shifts" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="WorkingHours.aspx.cs" Inherits="creation_car_care.Admin.WorkingHours" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .shifts-container {
            max-width: 620px;
            margin: 0 auto;
        }
        .shifts-card-wrap {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1.5px solid #fed7aa;
            margin-bottom: 30px;
        }
        .orange-header-banner {
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: #ffffff;
            padding: 24px;
            text-align: center;
            position: relative;
        }
        .banner-back-btn {
            position: absolute;
            top: 22px;
            left: 20px;
            color: #ffffff;
            text-decoration: none;
            font-size: 20px;
            font-weight: bold;
        }
        .shifts-body-content {
            padding: 26px;
        }
        .studio-status-box {
            background: #fff8ec;
            border: 1.5px dashed #fed7aa;
            border-radius: 14px;
            padding: 16px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 24px;
        }
        .status-clock-icon {
            font-size: 24px;
        }
        .status-title {
            font-size: 14px;
            font-weight: 800;
            color: #b45309;
        }
        .status-sub {
            font-size: 12px;
            color: #78350f;
        }
        .shifts-list-lbl {
            font-size: 11.5px;
            font-weight: 800;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 12px;
        }
        .shift-slot-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 14px 18px;
            margin-bottom: 10px;
            transition: all 0.15s;
        }
        .shift-slot-row:hover {
            border-color: #fdba74;
            background: #fffcf8;
        }
        .shift-slot-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .slot-name {
            font-size: 13.5px;
            font-weight: 700;
            color: #1e293b;
        }
        .slot-type {
            font-size: 11px;
            color: #64748b;
            background: #f1f5f9;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 600;
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
            background-color: #cbd5e1;
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
        .btn-save-schedule {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 13px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            margin-top: 20px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.25);
        }
        .btn-save-schedule:hover {
            background: #c2410c;
        }
        .success-box {
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
            padding: 10px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 16px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="shifts-container">
        <div class="shifts-card-wrap">
            
            <!-- Orange Banner Header -->
            <div class="orange-header-banner">
                <a href="Settings.aspx" class="banner-back-btn">&larr;</a>
                <h3 style="margin: 0; font-size: 16px; font-weight: 800;">Working Hours &amp; Shifts</h3>
            </div>

            <div class="shifts-body-content">
                
                <asp:Label ID="lblSuccess" runat="server" Visible="false" CssClass="success-box">&#10004; Studio schedule configurations saved successfully!</asp:Label>

                <!-- Studio Working Status Box -->
                <div class="studio-status-box">
                    <span class="status-clock-icon">&#128337;</span>
                    <div>
                        <div class="status-title">Open Daily (9:00 AM - 8:00 PM)</div>
                        <div class="status-sub">Customer slot booking active on creationcarcare.com</div>
                    </div>
                </div>

                <div class="shifts-list-lbl">AVAILABLE DAILY SERVICING TIME SLOTS</div>

                <!-- Slots Repeater with Toggles -->
                <asp:Repeater ID="rptSlots" runat="server">
                    <ItemTemplate>
                        <div class="shift-slot-row">
                            <div class="shift-slot-info">
                                <span class="slot-name"><%# Eval("SlotTime") %></span>
                                <span class="slot-type"><%# Eval("ShiftType") %></span>
                            </div>
                            <asp:HiddenField ID="hfSlotId" runat="server" Value='<%# Eval("SlotId") %>' />
                            <label class="switch">
                                <asp:CheckBox ID="chkSlotEnabled" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsEnabled")) %>' />
                                <span class="slider"></span>
                            </label>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Button ID="btnSaveSlots" runat="server" Text="SAVE SCHEDULE CONFIGURATION" OnClick="btnSaveSlots_Click" CssClass="btn-save-schedule" />

            </div>

        </div>
    </div>
</asp:Content>
