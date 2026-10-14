<%@ Page Title="Reschedule Booking" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reschedule.aspx.cs" Inherits="creation_car_care.Reschedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .resched-wrapper {
            max-width: 1050px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .resched-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .resched-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .resched-header p {
            font-size: 14px;
            color: #6b7280;
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
        .resched-layout {
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }
        .resched-left {
            flex: 2;
        }
        .resched-right {
            flex: 1;
            min-width: 320px;
        }
        /* Top Current Booking Card */
        .curr-booking-box {
            background: #fffcf8;
            border: 1.5px solid #fed7aa;
            border-radius: 14px;
            padding: 20px 24px;
            margin-bottom: 25px;
        }
        .curr-box-lbl {
            font-size: 11px;
            font-weight: 800;
            color: #9ca3af;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 4px;
        }
        .curr-box-val {
            font-size: 16px;
            font-weight: 800;
            color: #ea580c;
        }
        /* Date Pills Grid */
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
        /* Time Slots Grid */
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
            margin-bottom: 22px;
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
        .prev-slot-box {
            font-size: 13px;
            color: #6b7280;
            margin-bottom: 18px;
        }
        .prev-slot-val {
            font-weight: 700;
            color: #111827;
            margin-top: 4px;
        }
        .new-slot-box {
            background: #fffcf8;
            border: 1.5px dashed #fdba74;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 22px;
        }
        .new-slot-lbl {
            font-size: 11px;
            font-weight: 800;
            color: #9ca3af;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .new-slot-val {
            font-size: 17px;
            font-weight: 800;
            color: #ea580c;
        }
        .btn-confirm-resched {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: background 0.2s;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }
        .btn-confirm-resched:hover {
            background: #c2410c;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="resched-wrapper">
        
        <div class="resched-header">
            <div>
                <h1>Reschedule Booking</h1>
                <p>Select a new date and time slot for your service appointment.</p>
            </div>
            <a href="Booking.aspx" class="btn-back">&larr; Back to Bookings</a>
        </div>

        <div class="resched-layout">
            
            <div class="resched-left">
                
                <!-- Current Booking Info -->
                <div class="curr-booking-box">
                    <div class="curr-box-lbl">CURRENT BOOKING</div>
                    <div class="curr-box-val">
                        <asp:Label ID="lblCurrentBookingInfo" runat="server" Text="#CCC-902371 &bull; Ceramic Coating Treatment"></asp:Label>
                    </div>
                </div>

                <div style="font-size: 15px; font-weight: 800; color: #111827; margin-bottom: 14px;">Select New Date</div>

                <asp:HiddenField ID="hfNewDate" runat="server" />
                <asp:HiddenField ID="hfNewTime" runat="server" />

                <!-- Date Pills -->
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
                <div class="slots-subtitle">Morning Slots</div>
                <div class="slots-grid">
                    <asp:LinkButton ID="btnSlot1" runat="server" OnClick="btnSlot_Click" CommandArgument="09:00 AM" CssClass="slot-btn">09:00 AM</asp:LinkButton>
                    <asp:LinkButton ID="btnSlot2" runat="server" OnClick="btnSlot_Click" CommandArgument="10:30 AM" CssClass="slot-btn">10:30 AM</asp:LinkButton>
                    <asp:LinkButton ID="btnSlot3" runat="server" OnClick="btnSlot_Click" CommandArgument="11:30 AM" CssClass="slot-btn">11:30 AM</asp:LinkButton>
                </div>

                <!-- Afternoon Slots -->
                <div class="slots-subtitle">Afternoon Slots</div>
                <div class="slots-grid">
                    <asp:LinkButton ID="btnSlot4" runat="server" OnClick="btnSlot_Click" CommandArgument="01:00 PM" CssClass="slot-btn">01:00 PM</asp:LinkButton>
                    <asp:LinkButton ID="btnSlot5" runat="server" OnClick="btnSlot_Click" CommandArgument="02:30 PM" CssClass="slot-btn">02:30 PM</asp:LinkButton>
                    <asp:LinkButton ID="btnSlot6" runat="server" OnClick="btnSlot_Click" CommandArgument="04:00 PM" CssClass="slot-btn">04:00 PM</asp:LinkButton>
                </div>

            </div>

            <!-- Right Summary -->
            <div class="resched-right">
                <div class="summary-card">
                    <h3 class="summary-title">Reschedule Summary</h3>

                    <div class="prev-slot-box">
                        <div>Previous Booking Slot:</div>
                        <div class="prev-slot-val">
                            <asp:Label ID="lblPrevSlot" runat="server" Text="12 Aug, 01:00 PM"></asp:Label>
                        </div>
                    </div>

                    <div class="new-slot-box">
                        <div class="new-slot-lbl">NEW SELECTED SLOT &amp; DATE</div>
                        <div class="new-slot-val">
                            <asp:Label ID="lblNewSlotDisplay" runat="server" Text="Select date &amp; time"></asp:Label>
                        </div>
                    </div>

                    <asp:Button ID="btnConfirmReschedule" runat="server" Text="CONFIRM RESCHEDULE" OnClick="btnConfirmReschedule_Click" CssClass="btn-confirm-resched" />
                </div>
            </div>

        </div>

    </div>
</asp:Content>
