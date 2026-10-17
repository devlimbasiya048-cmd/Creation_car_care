<%@ Page Title="Select Date & Slot" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookSlot.aspx.cs" Inherits="creation_car_care.BookSlot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .slot-wrapper {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .slot-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .slot-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .slot-header p {
            font-size: 14px;
            color: #6b7280;
            margin: 0;
        }
        .btn-back {
            border: 1.5px solid #d1d5db;
            color: #374151;
            padding: 8px 20px;
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
        .slot-layout {
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }
        .slot-left {
            flex: 2;
        }
        .slot-right {
            flex: 1;
            min-width: 320px;
        }
        /* Registered Vehicle Box */
        .vehicle-box {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 16px;
            padding: 20px 24px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(234, 88, 12, 0.03);
            transition: border-color 0.2s;
        }
        .vehicle-subtitle {
            font-size: 11px;
            font-weight: 800;
            color: #9ca3af;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 4px;
        }
        .vehicle-title {
            font-size: 16px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 4px;
        }
        .vehicle-badge {
            font-size: 11.5px;
            color: #15803d;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .btn-change-veh {
            color: #ea580c;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            background: #fff7ed;
            border: 1.5px solid #fed7aa;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .btn-change-veh:hover {
            background: #ea580c;
            color: #ffffff;
            border-color: #ea580c;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.2);
        }

        /* Success Message Box */
        .veh-alert-box {
            background: #f0fdf4;
            border: 1.5px solid #bbf7d0;
            color: #166534;
            padding: 12px 18px;
            border-radius: 12px;
            margin-bottom: 22px;
            font-size: 13.5px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Modal Styles */
        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.65);
            -webkit-backdrop-filter: blur(4px);
            backdrop-filter: blur(4px);
            z-index: 9999;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            box-sizing: border-box;
        }

        .modal-dialog {
            background: #ffffff;
            border-radius: 20px;
            width: 100%;
            max-width: 540px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            animation: modalSlideIn 0.22s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-20px) scale(0.97);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .modal-header {
            padding: 20px 24px;
            background: #fffcf8;
            border-bottom: 1.5px solid #ffedd5;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
            margin: 0;
        }

        .modal-close-btn {
            background: transparent;
            border: none;
            font-size: 26px;
            color: #9ca3af;
            cursor: pointer;
            line-height: 1;
            padding: 4px;
            text-decoration: none;
            transition: color 0.2s;
        }

        .modal-close-btn:hover {
            color: #ea580c;
        }

        .modal-body {
            padding: 24px;
            max-height: 65vh;
            overflow-y: auto;
        }

        .veh-option-card {
            background: #ffffff;
            border: 1.5px solid #e5e7eb;
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.2s;
        }

        .veh-option-card:hover {
            border-color: #ea580c;
            background: #fffcf8;
        }

        .veh-card-name {
            font-size: 15px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .veh-card-plate {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #f3f4f6;
            border: 1px solid #d1d5db;
            padding: 3px 8px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 800;
            color: #374151;
            letter-spacing: 0.5px;
        }

        .btn-select-veh {
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-select-veh:hover {
            background: #c2410c;
        }

        .custom-veh-box {
            margin-top: 18px;
            padding-top: 18px;
            border-top: 1px dashed #fed7aa;
        }

        /* Date Section */
        .section-title {
            font-size: 15px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .month-label {
            font-size: 13px;
            color: #ea580c;
            font-weight: 700;
        }
        .dates-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 10px;
            margin-bottom: 25px;
        }
        .date-card {
            background: #ffffff;
            border: 1.5px solid #e5e7eb;
            border-radius: 12px;
            padding: 12px 6px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: block;
            color: inherit;
        }
        .date-card:hover {
            border-color: #fdba74;
            background: #fffcf8;
        }
        .date-card.active {
            background: #ea580c;
            border-color: #ea580c;
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }
        .date-day {
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
            opacity: 0.8;
        }
        .date-num {
            font-size: 18px;
            font-weight: 800;
        }
        /* Time Slots Section */
        .slots-group {
            margin-bottom: 22px;
        }
        .slots-subtitle {
            font-size: 13px;
            color: #6b7280;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .slots-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }
        .slot-btn {
            background: #ffffff;
            border: 1.5px solid #e5e7eb;
            border-radius: 10px;
            padding: 12px;
            text-align: center;
            font-size: 13px;
            font-weight: 700;
            color: #374151;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: block;
        }
        .slot-btn:hover {
            border-color: #fdba74;
            background: #fffcf8;
        }
        .slot-btn.active {
            border: 2px solid #ea580c;
            background: #fff7ed;
            color: #ea580c;
            font-weight: 800;
        }
        /* Summary Box */
        .summary-card {
            background: #ffffff;
            border: 1.5px solid #fed7aa;
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.05);
        }
        .summary-title {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 18px 0;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #4b5563;
            margin-bottom: 18px;
        }
        .selected-slot-box {
            background: #fffcf8;
            border: 1.5px dashed #fdba74;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 22px;
        }
        .slot-box-lbl {
            font-size: 11px;
            font-weight: 800;
            color: #9ca3af;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .slot-box-val {
            font-size: 17px;
            font-weight: 800;
            color: #ea580c;
        }
        .btn-proceed-pay {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: background 0.2s;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }
        .btn-proceed-pay:hover {
            background: #c2410c;
        }
        @media (max-width: 800px) {
            .slot-layout {
                flex-direction: column;
            }
            .slot-right {
                width: 100%;
            }
            .dates-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="slot-wrapper">
        
        <!-- Header -->
        <div class="slot-header">
            <div>
                <h1>Select Date &amp; Slot</h1>
                <p>Choose your preferred vehicle, date and time slot for service execution.</p>
            </div>
            <a href="Cart.aspx" class="btn-back">&larr; Back to Cart</a>
        </div>

        <!-- Vehicle Updated Notification Alert -->
        <asp:Panel ID="pnlVehicleSuccessMsg" runat="server" Visible="false" CssClass="veh-alert-box">
            <span>&#10004; <asp:Label ID="lblVehicleSuccessMsg" runat="server"></asp:Label></span>
            <asp:LinkButton ID="btnCloseVehMsg" runat="server" OnClick="btnCloseVehMsg_Click" style="color: #166534; text-decoration: none; font-size: 18px; font-weight: bold; line-height: 1;">&times;</asp:LinkButton>
        </asp:Panel>

        <div class="slot-layout">
            
            <!-- Left Side Controls -->
            <div class="slot-left">
                
                <!-- Registered Vehicle Card -->
                <div class="vehicle-box">
                    <div>
                        <div class="vehicle-subtitle">SELECTED VEHICLE FOR SERVICE</div>
                        <div class="vehicle-title">
                            <asp:Label ID="lblVehicleDetails" runat="server" Text="Hyundai Creta (GJ 03 AB 1234)"></asp:Label>
                        </div>
                        <div>
                            <asp:Label ID="lblVehicleBadge" runat="server" CssClass="vehicle-badge" Text="&#9679; Primary Vehicle"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <!-- Change Vehicle Trigger Button -->
                        <asp:LinkButton ID="btnChangeVehicle" runat="server" OnClick="btnChangeVehicle_Click" CssClass="btn-change-veh">
                            Change Vehicle &rarr;
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Select Date Section -->
                <div class="section-title">
                    <span>Select Date</span>
                    <span class="month-label"><asp:Label ID="lblCurrentMonth" runat="server"></asp:Label></span>
                </div>

                <!-- Hidden field to hold selected date and time -->
                <asp:HiddenField ID="hfSelectedDate" runat="server" />
                <asp:HiddenField ID="hfSelectedTime" runat="server" />

                <!-- Date Pills Grid -->
                <div class="dates-grid">
                    <asp:Repeater ID="rptDates" runat="server">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDateSelect" runat="server" 
                                OnClick="btnDateSelect_Click" 
                                CommandArgument='<%# Eval("DateValue") %>'
                                CssClass='<%# Eval("DateValue").ToString() == SelectedDateString ? "date-card active" : "date-card" %>'>
                                <div class="date-day"><%# Eval("DayName") %></div>
                                <div class="date-num"><%# Eval("DayNumber") %></div>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- Morning Slots -->
                <div class="slots-group">
                    <div class="slots-subtitle">Morning Slots</div>
                    <div class="slots-grid">
                        <asp:LinkButton ID="btnSlot1" runat="server" OnClick="btnSlot_Click" CommandArgument="09:00 AM" CssClass="slot-btn">09:00 AM</asp:LinkButton>
                        <asp:LinkButton ID="btnSlot2" runat="server" OnClick="btnSlot_Click" CommandArgument="10:30 AM" CssClass="slot-btn">10:30 AM</asp:LinkButton>
                        <asp:LinkButton ID="btnSlot3" runat="server" OnClick="btnSlot_Click" CommandArgument="11:30 AM" CssClass="slot-btn">11:30 AM</asp:LinkButton>
                    </div>
                </div>

                <!-- Afternoon Slots -->
                <div class="slots-group">
                    <div class="slots-subtitle">Afternoon Slots</div>
                    <div class="slots-grid">
                        <asp:LinkButton ID="btnSlot4" runat="server" OnClick="btnSlot_Click" CommandArgument="01:00 PM" CssClass="slot-btn">01:00 PM</asp:LinkButton>
                        <asp:LinkButton ID="btnSlot5" runat="server" OnClick="btnSlot_Click" CommandArgument="02:30 PM" CssClass="slot-btn">02:30 PM</asp:LinkButton>
                        <asp:LinkButton ID="btnSlot6" runat="server" OnClick="btnSlot_Click" CommandArgument="04:00 PM" CssClass="slot-btn">04:00 PM</asp:LinkButton>
                    </div>
                </div>

            </div>

            <!-- Right Side Booking Summary -->
            <div class="slot-right">
                <div class="summary-card">
                    <h3 class="summary-title">Booking Summary</h3>

                    <div class="summary-row">
                        <span>Services Selected:</span>
                        <span style="font-weight: 700; color: #111827;">
                            <asp:Label ID="lblServiceCount" runat="server" Text="1 Service"></asp:Label> 
                            (&#8377;<asp:Label ID="lblSummaryAmount" runat="server" Text="0"></asp:Label>)
                        </span>
                    </div>

                    <!-- Active Offer Discount Row -->
                    <asp:Panel ID="pnlSlotOfferRow" runat="server" Visible="false" CssClass="summary-row" style="color: #15803d; font-weight: 700; font-size: 13px;">
                        <span>&#127881; Offer Applied:</span>
                        <span><asp:Label ID="lblSlotOfferText" runat="server"></asp:Label></span>
                    </asp:Panel>

                    <div class="selected-slot-box">
                        <div class="slot-box-lbl">SELECTED SLOT &amp; DATE</div>
                        <div class="slot-box-val">
                            <asp:Label ID="lblSelectedSlotDisplay" runat="server" Text="Select date &amp; time"></asp:Label>
                        </div>
                    </div>

                    <asp:Button ID="btnProceedPay" runat="server" Text="PROCEED TO PAY" OnClick="btnProceedPay_Click" CssClass="btn-proceed-pay" />
                </div>
            </div>

        </div>

    </div>

    <!-- Vehicle Selection Modal Dialog -->
    <asp:Panel ID="pnlVehicleModal" runat="server" Visible="false" CssClass="modal-backdrop">
        <div class="modal-dialog">
            <div class="modal-header">
                <div>
                    <h3 class="modal-title">Select Vehicle for Detailing</h3>
                    <p style="margin: 4px 0 0 0; font-size: 12.5px; color: #6b7280;">Choose from your registered vehicles or enter another vehicle</p>
                </div>
                <asp:LinkButton ID="btnCloseVehicleModal" runat="server" OnClick="btnCloseVehicleModal_Click" CssClass="modal-close-btn">&times;</asp:LinkButton>
            </div>
            <div class="modal-body">
                
                <!-- User's Existing Vehicles from Garage -->
                <div style="font-size: 12px; font-weight: 800; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.6px; margin-bottom: 12px;">
                    YOUR REGISTERED VEHICLES
                </div>

                <asp:Repeater ID="rptUserVehicles" runat="server" OnItemCommand="rptUserVehicles_ItemCommand">
                    <ItemTemplate>
                        <div class="veh-option-card">
                            <div>
                                <div class="veh-card-name">
                                    <%# Eval("Brand") %> <%# Eval("ModelName") %>
                                    <%# Convert.ToBoolean(Eval("IsPrimary")) ? "<span style='font-size: 10px; background: #dcfce7; color: #15803d; font-weight: bold; padding: 2px 6px; border-radius: 4px; margin-left: 6px;'>PRIMARY</span>" : "" %>
                                </div>
                                <div style="display: flex; gap: 8px; align-items: center; margin-top: 4px;">
                                    <span class="veh-card-plate">
                                        <span style="font-size: 9px; color: #ea580c; font-weight: 900;">IND</span>
                                        <%# Eval("RegistrationNumber") %>
                                    </span>
                                    <span style="font-size: 11px; color: #6b7280; font-weight: 600;">
                                        <%# Eval("VehicleType") %> &bull; <%# Eval("Color") %>
                                    </span>
                                </div>
                            </div>
                            <div>
                                <asp:Button ID="btnSelectThisVehicle" runat="server" Text="Select" 
                                    CommandName="SelectVehicle" 
                                    CommandArgument='<%# Eval("ModelName") + " (" + Eval("RegistrationNumber") + ")" %>' 
                                    CssClass="btn-select-veh" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- Fallback if no vehicles in garage -->
                <asp:Panel ID="pnlNoGarageVehicles" runat="server" Visible="false" style="text-align: center; padding: 20px; background: #fffcf8; border: 1px dashed #fed7aa; border-radius: 12px; margin-bottom: 16px;">
                    <p style="margin: 0 0 6px 0; font-weight: 700; color: #374151; font-size: 14px;">No vehicles found in your garage.</p>
                    <p style="margin: 0; font-size: 12.5px; color: #6b7280;">You can enter your vehicle details below.</p>
                </asp:Panel>

                <!-- Quick Custom Vehicle Input Section -->
                <div class="custom-veh-box">
                    <div style="font-size: 12px; font-weight: 800; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.6px; margin-bottom: 8px;">
                        OR ENTER ANOTHER VEHICLE
                    </div>
                    <div style="display: flex; gap: 10px;">
                        <asp:TextBox ID="txtCustomVehicle" runat="server" placeholder="e.g. Honda City (GJ 03 XY 5678)" style="flex: 1; padding: 10px 14px; border: 1.5px solid #d1d5db; border-radius: 8px; font-size: 13px; outline: none;"></asp:TextBox>
                        <asp:Button ID="btnApplyCustomVehicle" runat="server" Text="Apply" OnClick="btnApplyCustomVehicle_Click" CssClass="btn-select-veh" style="padding: 10px 18px;" />
                    </div>
                </div>

                <!-- Manage Garage Link -->
                <div style="margin-top: 18px; text-align: center;">
                    <a href="Vehicles.aspx" style="color: #ea580c; font-size: 12.5px; font-weight: 700; text-decoration: none;">
                        + Manage or Add Vehicles in Garage &rarr;
                    </a>
                </div>

            </div>
        </div>
    </asp:Panel>
</asp:Content>
