<%@ Page Title="Live Tracking - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Tracking.aspx.cs" Inherits="creation_car_care.Tracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .track-wrapper {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .track-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .track-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0;
        }
        .btn-back {
            border: 1.5px solid #d1d5db;
            color: #374151;
            padding: 8px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            background: #ffffff;
            transition: all 0.2s;
        }
        .btn-back:hover {
            border-color: #ea580c;
            color: #ea580c;
        }
        /* Top Order Info Card */
        .order-info-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 16px;
            padding: 24px 28px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.04);
        }
        .info-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }
        .info-order-id {
            font-size: 11px;
            font-weight: 800;
            color: #9ca3af;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 4px;
        }
        .info-vehicle {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
        }
        .badge-status {
            background: #dcfce7;
            color: #15803d;
            font-size: 11px;
            font-weight: 800;
            padding: 4px 12px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            border: 1px solid #bbf7d0;
        }
        .info-service {
            font-size: 14px;
            color: #4b5563;
            margin-bottom: 6px;
            font-weight: 600;
        }
        .info-est {
            font-size: 12.5px;
            color: #ea580c;
            font-weight: 700;
        }
        /* 5-Step Stepper */
        .stepper-container {
            background: #ffffff;
            border: 1.5px solid #f1f5f9;
            border-radius: 18px;
            padding: 35px 30px;
            margin-bottom: 25px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.02);
        }
        .stepper-step {
            display: flex;
            position: relative;
            padding-bottom: 35px;
        }
        .stepper-step:last-child {
            padding-bottom: 0;
        }
        /* Vertical connecting line */
        .stepper-step:not(:last-child)::before {
            content: '';
            position: absolute;
            left: 17px;
            top: 36px;
            bottom: 0;
            width: 2.5px;
            background: #e2e8f0;
        }
        .stepper-step.completed:not(:last-child)::before {
            background: #10b981;
        }
        .step-indicator {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 800;
            margin-right: 20px;
            z-index: 1;
            flex-shrink: 0;
        }
        .step-completed .step-indicator {
            background: #10b981;
            color: #ffffff;
        }
        .step-active .step-indicator {
            background: #ea580c;
            color: #ffffff;
            box-shadow: 0 0 0 6px #ffedd5;
        }
        .step-pending .step-indicator {
            background: #ffffff;
            color: #94a3b8;
            border: 2px solid #cbd5e1;
        }
        .step-content h4 {
            margin: 0 0 4px 0;
            font-size: 16px;
            font-weight: 700;
            color: #111827;
        }
        .step-completed .step-content h4 {
            color: #065f46;
        }
        .step-active .step-content h4 {
            color: #ea580c;
        }
        .step-pending .step-content h4 {
            color: #94a3b8;
        }
        .step-desc {
            font-size: 13px;
            color: #6b7280;
            line-height: 1.5;
            margin: 0;
        }
        .step-time {
            font-size: 12px;
            color: #9ca3af;
            font-weight: 600;
            margin-top: 4px;
        }
        /* Help Box */
        .help-box {
            background: #ffffff;
            border: 1.5px solid #fed7aa;
            border-radius: 14px;
            padding: 18px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .help-info h4 {
            margin: 0 0 3px 0;
            font-size: 14px;
            color: #111827;
            font-weight: 700;
        }
        .help-info span {
            font-size: 12.5px;
            color: #6b7280;
        }
        .btn-call {
            background: #fff7ed;
            color: #ea580c;
            border: 1.5px solid #ea580c;
            padding: 8px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="track-wrapper">
        
        <!-- Header -->
        <div class="track-header">
            <h1>Live Tracking</h1>
            <a href="Booking.aspx" class="btn-back">&larr; Back to Bookings</a>
        </div>

        <!-- Top Order Info Card -->
        <div class="order-info-card">
            <div class="info-top">
                <div>
                    <div class="info-order-id">
                        ORDER ID: <asp:Label ID="lblOrderId" runat="server" Text="#CCC-849206"></asp:Label>
                    </div>
                    <div class="info-vehicle">
                        <asp:Label ID="lblVehicle" runat="server" Text="Hyundai Creta (GJ 03 AB 1234)"></asp:Label>
                    </div>
                </div>
                <div>
                    <span class="badge-status">
                        <asp:Label ID="lblStatusBadge" runat="server" Text="IN PROGRESS"></asp:Label>
                    </span>
                </div>
            </div>

            <div class="info-service">
                <asp:Label ID="lblServiceName" runat="server" Text="Car Detailing &amp; Protection Treatment"></asp:Label>
            </div>

            <div class="info-est">
                <asp:Label ID="lblEstCompletion" runat="server" Text="Est. Completion: Today, 04:30 PM"></asp:Label>
            </div>
        </div>

        <!-- 5-Step Stepper -->
        <div class="stepper-container">
            
            <!-- Step 1: Booking Confirmed -->
            <div class='<%= GetStepClass(1) %>'>
                <div class="step-indicator"><%= GetStepIcon(1) %></div>
                <div class="step-content">
                    <h4>Booking Confirmed</h4>
                    <p class="step-desc">Your appointment slot has been verified and assigned to our studio.</p>
                    <div class="step-time">Slot Confirmed</div>
                </div>
            </div>

            <!-- Step 2: Vehicle Reached Studio -->
            <div class='<%= GetStepClass(2) %>'>
                <div class="step-indicator"><%= GetStepIcon(2) %></div>
                <div class="step-content">
                    <h4>Vehicle Reached Studio</h4>
                    <p class="step-desc">Car received at studio gate, initial check-in inspection completed.</p>
                    <div class="step-time">Vehicle Checked-In</div>
                </div>
            </div>

            <!-- Step 3: Work In Progress -->
            <div class='<%= GetStepClass(3) %>'>
                <div class="step-indicator"><%= GetStepIcon(3) %></div>
                <div class="step-content">
                    <h4>Work In Progress</h4>
                    <p class="step-desc">Our certified technicians are applying multi-stage detailing &amp; protection.</p>
                    <div class="step-time">Active Stage</div>
                </div>
            </div>

            <!-- Step 4: Quality Check -->
            <div class='<%= GetStepClass(4) %>'>
                <div class="step-indicator"><%= GetStepIcon(4) %></div>
                <div class="step-content">
                    <h4>Quality Check</h4>
                    <p class="step-desc">Supervisor inspection under specialized studio lighting.</p>
                </div>
            </div>

            <!-- Step 5: Ready for Delivery -->
            <div class='<%= GetStepClass(5) %>'>
                <div class="step-indicator"><%= GetStepIcon(5) %></div>
                <div class="step-content">
                    <h4>Ready for Delivery</h4>
                    <p class="step-desc">Final gloss inspection done. Vehicle ready for pickup.</p>
                </div>
            </div>

        </div>

        <!-- Need Help Card -->
        <div class="help-box">
            <div class="help-info">
                <h4>Need Live Updates?</h4>
                <span>Contact studio manager for real-time progress photo updates.</span>
            </div>
            <a href="tel:+919876543210" class="btn-call">&#128222; Call Studio</a>
        </div>

    </div>
</asp:Content>
