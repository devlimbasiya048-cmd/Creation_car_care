<%@ Page Title="Update Order Status" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="UpdateBookingStatus.aspx.cs" Inherits="creation_car_care.Admin.UpdateBookingStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .update-status-container {
            max-width: 860px;
            margin: 0 auto;
        }

        /* Top Booking Header Card (Matches Screenshot 4) */
        .booking-header-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px 28px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            flex-wrap: wrap;
            gap: 16px;
        }

        .booking-meta-title {
            font-size: 12px;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .booking-customer-name {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px 0;
        }

        .booking-vehicle-sub {
            font-size: 13.5px;
            color: #64748b;
            font-weight: 500;
            margin: 0;
        }

        .booking-status-badge {
            font-size: 12px;
            font-weight: 800;
            padding: 6px 16px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .badge-inprogress {
            background: #fff7ed;
            color: #ea580c;
            border: 1.5px solid #fed7aa;
        }

        .badge-completed {
            background: #dcfce7;
            color: #15803d;
            border: 1.5px solid #bbf7d0;
        }

        .badge-pending {
            background: #fef3c7;
            color: #b45309;
            border: 1.5px solid #fde68a;
        }

        .badge-cancelled {
            background: #fee2e2;
            color: #b91c1c;
            border: 1.5px solid #fecaca;
        }

        /* Section Heading */
        .section-heading {
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 16px 0;
        }

        /* Card Wrapper */
        .content-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 28px;
            margin-bottom: 24px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
        }

        /* Live Tracking Stepper UI (Exact Match Screenshot 4) */
        .tracking-timeline {
            position: relative;
            padding-left: 36px;
            margin-bottom: 24px;
        }

        .tracking-timeline::before {
            content: '';
            position: absolute;
            left: 13px;
            top: 15px;
            bottom: 20px;
            width: 3px;
            background: #e2e8f0;
            border-radius: 2px;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 26px;
        }

        .timeline-item:last-child {
            margin-bottom: 0;
        }

        .timeline-dot {
            position: absolute;
            left: -36px;
            top: 2px;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 800;
            background: #ffffff;
            border: 2.5px solid #cbd5e1;
            color: #64748b;
            z-index: 2;
        }

        .timeline-item.completed .timeline-dot {
            background: #10b981;
            border-color: #10b981;
            color: #ffffff;
        }

        .timeline-item.active .timeline-dot {
            background: #ffffff;
            border-color: #ea580c;
            color: #ea580c;
            box-shadow: 0 0 0 4px #ffedd5;
        }

        .timeline-title {
            font-size: 14.5px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 4px 0;
        }

        .timeline-item.active .timeline-title {
            color: #ea580c;
        }

        .timeline-desc {
            font-size: 13px;
            color: #64748b;
            margin: 0;
            line-height: 1.4;
        }

        .timeline-input-box {
            margin-top: 10px;
        }

        .stepper-note-input {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #fed7aa;
            background: #fffaf5;
            border-radius: 10px;
            font-size: 13px;
            color: #1e293b;
            outline: none;
            box-sizing: border-box;
            font-family: inherit;
        }

        .stepper-note-input:focus {
            border-color: #ea580c;
            background: #ffffff;
        }

        /* Step Select Dropdown / Pills */
        .step-select-row {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 18px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            margin-bottom: 20px;
        }

        .step-select-label {
            font-size: 13px;
            font-weight: 700;
            color: #334155;
            white-space: nowrap;
        }

        .step-select-dropdown {
            flex: 1;
            padding: 9px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            color: #1e293b;
            background: #ffffff;
        }

        /* Order Status Radio Grid (Screenshot 5 Frame 1) */
        .status-options-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }

        .status-radio-card {
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 14px 18px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.2s;
            background: #ffffff;
        }

        .status-radio-card:hover {
            border-color: #ea580c;
            background: #fffaf5;
        }

        .status-radio-card input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: #ea580c;
            cursor: pointer;
        }

        .status-radio-text {
            font-size: 14px;
            font-weight: 700;
            color: #1e293b;
        }

        .status-radio-card.cancel .status-radio-text {
            color: #dc2626;
        }

        /* Cancellation Reason Box */
        .cancel-reason-box {
            margin-top: 16px;
            padding: 16px;
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 12px;
        }

        .cancel-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #991b1b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .cancel-input {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #fca5a5;
            border-radius: 8px;
            font-size: 13.5px;
            color: #1e293b;
            background: #ffffff;
            box-sizing: border-box;
            outline: none;
            font-family: inherit;
        }

        /* Buttons (Solid Orange) */
        .btn-update-now {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 15px;
            border-radius: 12px;
            font-weight: 800;
            font-size: 14.5px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 14px rgba(234, 88, 12, 0.3);
        }

        .btn-update-now:hover {
            background: #c2410c;
            transform: translateY(-1px);
        }

        /* Sub-action navigation links */
        .secondary-actions-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 20px;
            gap: 16px;
            flex-wrap: wrap;
        }

        .btn-invoice-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 20px;
            background: #ffffff;
            border: 1.5px solid #10b981;
            color: #10b981;
            border-radius: 10px;
            font-size: 13.5px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-invoice-link:hover {
            background: #10b981;
            color: #ffffff;
        }

        .btn-back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #64748b;
            font-size: 13.5px;
            font-weight: 700;
            text-decoration: none;
        }

        .btn-back-link:hover {
            color: #0f172a;
        }

        .alert-msg {
            padding: 14px 18px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="update-status-container">

        <!-- Notification Message -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false">
            <div class='<%= AlertType == "success" ? "alert-msg alert-success" : "alert-msg alert-error" %>'>
                <span>&#10003;</span> <asp:Label ID="lblAlert" runat="server"></asp:Label>
            </div>
        </asp:Panel>

        <!-- Top Header Card (Matches Screenshot 4) -->
        <div class="booking-header-card">
            <div>
                <div class="booking-meta-title">
                    Booking: <asp:Label ID="lblBookingCode" runat="server" Text="#CCC-100229"></asp:Label>
                </div>
                <h2 class="booking-customer-name">
                    <asp:Label ID="lblCustomerName" runat="server" Text="Dev Limbasiya"></asp:Label>
                </h2>
                <p class="booking-vehicle-sub">
                    <asp:Label ID="lblVehicleDetails" runat="server" Text="White Honda City Sedan"></asp:Label> &bull; 
                    <asp:Label ID="lblServiceName" runat="server" Text="Ceramic Top Glaze" ForeColor="#ea580c" Font-Bold="true"></asp:Label>
                </p>
            </div>
            <div>
                <asp:Label ID="lblStatusBadge" runat="server" CssClass="booking-status-badge badge-inprogress" Text="IN PROGRESS"></asp:Label>
            </div>
        </div>

        <!-- Section 1: Manage Live Tracking Stepper (Matches Screenshot 4) -->
        <div class="content-card">
            <h3 class="section-heading">&#128663; Manage Live Tracking</h3>

            <!-- Step Selector Dropdown -->
            <div class="step-select-row">
                <span class="step-select-label">Current Progress Stage:</span>
                <asp:DropDownList ID="ddlTrackingStep" runat="server" CssClass="step-select-dropdown" AutoPostBack="true" OnSelectedIndexChanged="ddlTrackingStep_SelectedIndexChanged">
                    <asp:ListItem Text="Step 1: Booking Confirmed" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Step 2: Vehicle Reached Studio" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Step 3: Work in Progress" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Step 4: Quality Check" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Step 5: Ready for Delivery" Value="5"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Stepper Timeline Preview -->
            <div class="tracking-timeline">
                
                <!-- Step 1 -->
                <div class='<%= GetStepClass(1) %>'>
                    <div class="timeline-dot"><%= GetStepDot(1) %></div>
                    <div class="timeline-title">Booking Confirmed</div>
                    <p class="timeline-desc"><asp:Label ID="lblStep1Date" runat="server" Text="Booking registered in system."></asp:Label></p>
                </div>

                <!-- Step 2 -->
                <div class='<%= GetStepClass(2) %>'>
                    <div class="timeline-dot"><%= GetStepDot(2) %></div>
                    <div class="timeline-title">Vehicle Reached Studio</div>
                    <p class="timeline-desc">Customer handed over car at Creation Car Care studio bay.</p>
                </div>

                <!-- Step 3 -->
                <div class='<%= GetStepClass(3) %>'>
                    <div class="timeline-dot"><%= GetStepDot(3) %></div>
                    <div class="timeline-title">Work in Progress - UPDATED</div>
                    <p class="timeline-desc">Exterior foam washing, clay treatment, and polishing active.</p>
                </div>

                <!-- Step 4 -->
                <div class='<%= GetStepClass(4) %>'>
                    <div class="timeline-dot"><%= GetStepDot(4) %></div>
                    <div class="timeline-title">Quality Check</div>
                    <div class="timeline-input-box">
                        <asp:TextBox ID="txtNotes" runat="server" CssClass="stepper-note-input" Placeholder="Enter process notes (e.g. Currently on final detailing process by Bhargav/staff)"></asp:TextBox>
                    </div>
                </div>

                <!-- Step 5 -->
                <div class='<%= GetStepClass(5) %>'>
                    <div class="timeline-dot"><%= GetStepDot(5) %></div>
                    <div class="timeline-title">Ready for Delivery</div>
                    <p class="timeline-desc">Inspection verified. Vehicle ready for customer pickup.</p>
                </div>

            </div>
        </div>

        <!-- Section 2: Manage Booking Status (Matches Screenshot 5 Frame 1) -->
        <div class="content-card">
            <h3 class="section-heading">&#9881; Select Overall Order Status</h3>

            <div class="status-options-grid">
                <label class="status-radio-card">
                    <asp:RadioButton ID="rbPending" runat="server" GroupName="BookingStatusGroup" />
                    <span class="status-radio-text">&#9203; Pending / Action Required</span>
                </label>
                <label class="status-radio-card">
                    <asp:RadioButton ID="rbInProgress" runat="server" GroupName="BookingStatusGroup" />
                    <span class="status-radio-text">&#9881; In Progress (Start Work)</span>
                </label>
                <label class="status-radio-card">
                    <asp:RadioButton ID="rbCompleted" runat="server" GroupName="BookingStatusGroup" />
                    <span class="status-radio-text">&#10003; Completed (Work Done)</span>
                </label>
                <label class="status-radio-card cancel">
                    <asp:RadioButton ID="rbCancelled" runat="server" GroupName="BookingStatusGroup" />
                    <span class="status-radio-text">&#10005; Cancel Booking</span>
                </label>
            </div>

            <!-- Optional Cancellation Reason -->
            <div class="cancel-reason-box">
                <label class="cancel-label">Cancellation Reason (Optional)</label>
                <asp:TextBox ID="txtCancellationReason" runat="server" CssClass="cancel-input" Placeholder="Please enter why customer has cancelled..."></asp:TextBox>
            </div>

            <div style="margin-top: 24px;">
                <asp:Button ID="btnUpdateStatusNow" runat="server" Text="Update Status Now" CssClass="btn-update-now" OnClick="btnUpdateStatusNow_Click" />
            </div>
        </div>

        <!-- Secondary Action Links -->
        <div class="secondary-actions-bar">
            <a href="ManageBookings.aspx" class="btn-back-link">&larr; Back to All Bookings</a>
            <asp:HyperLink ID="lnkViewInvoice" runat="server" CssClass="btn-invoice-link">
                <span>&#128196;</span> View / Print Tax Invoice
            </asp:HyperLink>
        </div>

    </div>
</asp:Content>
