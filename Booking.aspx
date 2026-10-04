<%@ Page Title="My Bookings" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="creation_car_care.Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bookings-wrapper {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .page-header {
            text-align: center;
            margin-bottom: 25px;
        }
        .page-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0;
        }
        /* Tab Navigation */
        .tab-bar {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-bottom: 30px;
        }
        .tab-btn {
            padding: 10px 36px;
            border-radius: 25px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            border: 1.5px solid #ea580c;
        }
        .tab-btn-active {
            background: #ea580c;
            color: #ffffff;
        }
        .tab-btn-inactive {
            background: #ffffff;
            color: #ea580c;
        }
        .tab-btn-inactive:hover {
            background: #fff7ed;
        }
        /* Booking Card */
        .booking-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 16px;
            padding: 24px 28px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(234, 88, 12, 0.03);
            transition: transform 0.2s;
        }
        .booking-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(234, 88, 12, 0.06);
        }
        .card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
        }
        .card-top h3 {
            font-size: 18px;
            font-weight: 700;
            color: #111827;
            margin: 0 0 4px 0;
        }
        .studio-name {
            font-size: 12.5px;
            color: #9ca3af;
            display: block;
        }
        .status-badge {
            font-size: 11px;
            font-weight: 800;
            padding: 4px 10px;
            border-radius: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .badge-progress {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .badge-upcoming {
            background: #ffedd5;
            color: #c2410c;
            border: 1px solid #fed7aa;
        }
        .badge-completed {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .badge-cancelled {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }
        .scheduled-info {
            font-size: 12px;
            color: #6b7280;
            margin: 16px 0;
            font-weight: 600;
        }
        .scheduled-info span {
            color: #111827;
            font-weight: 700;
        }
        .card-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px dashed #fed7aa;
            padding-top: 16px;
        }
        .card-actions {
            display: flex;
            gap: 12px;
        }
        .btn-action-outline {
            background: #ffffff;
            border: 1.5px solid #ea580c;
            color: #ea580c;
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-action-outline:hover {
            background: #fff7ed;
        }
        .btn-action-fill {
            background: #ea580c;
            border: 1.5px solid #ea580c;
            color: #ffffff;
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-action-fill:hover {
            background: #c2410c;
        }
        .btn-action-danger {
            background: #ffffff;
            border: 1.5px solid #ef4444;
            color: #ef4444;
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-action-danger:hover {
            background: #fef2f2;
        }
        .history-price {
            font-size: 18px;
            font-weight: 800;
            color: #ea580c;
        }
        .empty-bookings-card {
            background: #ffffff;
            border: 1.5px dashed #e5e7eb;
            border-radius: 16px;
            padding: 50px 20px;
            text-align: center;
        }
        .empty-bookings-card h3 {
            font-size: 18px;
            color: #374151;
            margin-bottom: 8px;
        }
        .empty-bookings-card p {
            font-size: 14px;
            color: #9ca3af;
            margin-bottom: 20px;
        }
        .btn-browse {
            background: #ea580c;
            color: #ffffff;
            padding: 10px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            font-size: 13px;
            display: inline-block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bookings-wrapper">
        
        <!-- Header -->
        <div class="page-header">
            <h1>My Bookings</h1>
        </div>

        <!-- Upcoming vs History Tab Bar -->
        <div class="tab-bar">
            <asp:LinkButton ID="btnTabUpcoming" runat="server" OnClick="btnTabUpcoming_Click" CssClass="tab-btn tab-btn-active">Upcoming</asp:LinkButton>
            <asp:LinkButton ID="btnTabHistory" runat="server" OnClick="btnTabHistory_Click" CssClass="tab-btn tab-btn-inactive">History</asp:LinkButton>
        </div>

        <!-- Alert Notification Panel -->
        <asp:Label ID="lblMessage" runat="server" Visible="false" style="display: block; padding: 12px 18px; border-radius: 8px; margin-bottom: 20px; font-weight: bold;"></asp:Label>

        <!-- UPCOMING BOOKINGS SECTION -->
        <asp:Panel ID="pnlUpcoming" runat="server">
            <asp:Repeater ID="rptUpcoming" runat="server" OnItemCommand="rptUpcoming_ItemCommand">
                <ItemTemplate>
                    <div class="booking-card">
                        
                        <div class="card-top">
                            <div>
                                <span style="font-size: 11px; font-weight: bold; color: #ea580c; letter-spacing: 0.5px;"><%# Eval("BookingCode") %></span>
                                <h3><%# Eval("ServiceName") %></h3>
                                <span class="studio-name">Creation Car Care Studio, Rajkot</span>
                            </div>
                            <div>
                                <span class='<%# Eval("BookingStatus").ToString() == "In Progress" ? "status-badge badge-progress" : "status-badge badge-upcoming" %>'>
                                    <%# Eval("BookingStatus") %>
                                </span>
                            </div>
                        </div>

                        <div class="scheduled-info">
                            SCHEDULED FOR: <span><%# string.Format("{0:dd MMM yyyy}", Eval("SlotDate")) %>, <%# Eval("SlotTime") %></span>
                        </div>

                        <div class="card-bottom">
                            <div>
                                <div style="font-size: 12px; color: #6b7280; font-weight: 600; margin-bottom: 2px;">
                                    <%# Eval("DiscountAmount") != DBNull.Value && Convert.ToDecimal(Eval("DiscountAmount")) > 0 ? "Discounted Amount:" : "Total Amount:" %>
                                </div>
                                <div style="display: flex; align-items: baseline; gap: 8px;">
                                    <%# Eval("OriginalAmount") != DBNull.Value && Convert.ToDecimal(Eval("OriginalAmount")) > Convert.ToDecimal(Eval("TotalAmount")) ? 
                                        "<span style='font-size: 13px; color: #9ca3af; text-decoration: line-through;'>&#8377;" + string.Format("{0:N0}", Eval("OriginalAmount")) + "</span>" : "" 
                                    %>
                                    <span style="font-size: 17px; font-weight: 800; color: #ea580c;">&#8377;<%# string.Format("{0:N0}", Eval("TotalAmount")) %></span>
                                    <span style="font-size: 11px; color: #6b7280; background: #f3f4f6; padding: 2px 7px; border-radius: 4px; font-weight: 600;"><%# Eval("PaymentMethod") %></span>
                                </div>
                                <%# Eval("DiscountAmount") != DBNull.Value && Convert.ToDecimal(Eval("DiscountAmount")) > 0 ? 
                                    "<div style='margin-top: 5px;'><span style='background: #ecfdf5; color: #059669; border: 1px solid #a7f3d0; font-size: 11px; font-weight: 800; padding: 3px 8px; border-radius: 6px; display: inline-flex; align-items: center; gap: 4px;'>&#127881; " + (Eval("OfferTitle") != DBNull.Value && !string.IsNullOrEmpty(Eval("OfferTitle").ToString()) ? Eval("OfferTitle") : "Offer Applied") + " (-&#8377;" + string.Format("{0:N0}", Eval("DiscountAmount")) + " Saved)</span></div>" : "" 
                                %>
                            </div>

                            <div class="card-actions">
                                <!-- If In Progress: Show Live Tracking -->
                                <%# Eval("BookingStatus").ToString() == "In Progress" ? 
                                    "<a href='Tracking.aspx?code=" + Eval("BookingCode") + "' class='btn-action-outline'>Live Tracking</a>" : "" 
                                %>

                                <!-- If Upcoming: Show Cancel & Reschedule -->
                                <asp:LinkButton ID="btnCancel" runat="server" 
                                    CommandName="CancelBooking" 
                                    CommandArgument='<%# Eval("BookingId") %>' 
                                    Visible='<%# Eval("BookingStatus").ToString() == "Upcoming" %>' 
                                    OnClientClick="return confirm('Are you sure you want to cancel this booking?');" 
                                    CssClass="btn-action-danger">
                                    Cancel
                                </asp:LinkButton>

                                <a href='<%# "Reschedule.aspx?id=" + Eval("BookingId") %>' 
                                   class="btn-action-fill" 
                                   style='<%# Eval("BookingStatus").ToString() == "Upcoming" ? "" : "display:none;" %>'>
                                   Reschedule
                                </a>

                                <a href='<%# "Tracking.aspx?code=" + Eval("BookingCode") %>' 
                                   class="btn-action-fill" 
                                   style='<%# Eval("BookingStatus").ToString() == "In Progress" ? "" : "display:none;" %>'>
                                   View Details
                                </a>
                            </div>
                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- If No Upcoming Bookings -->
            <asp:Panel ID="pnlNoUpcoming" runat="server" Visible="false" CssClass="empty-bookings-card">
                <span style="font-size: 40px; display: block; margin-bottom: 10px;">&#128197;</span>
                <h3>No upcoming appointments!</h3>
                <p>You don't have any scheduled car care bookings at the moment.</p>
                <div style="display: flex; justify-content: center; gap: 12px; margin-top: 15px;">
                    <a href="ServicesList.aspx" class="btn-browse">Book a Service &rarr;</a>
                    <a href="Offer.aspx" class="btn-browse" style="background: #ffffff; color: #ea580c; border: 1.5px solid #ea580c;">Special Offers &rarr;</a>
                </div>
            </asp:Panel>
        </asp:Panel>

        <!-- HISTORY BOOKINGS SECTION -->
        <asp:Panel ID="pnlHistory" runat="server" Visible="false">
            <asp:Repeater ID="rptHistory" runat="server" OnItemCommand="rptHistory_ItemCommand">
                <ItemTemplate>
                    <div class="booking-card">
                        
                        <div class="card-top">
                            <div>
                                <span style="font-size: 11px; font-weight: bold; color: #ea580c; letter-spacing: 0.5px;"><%# Eval("BookingCode") %></span>
                                <h3><%# Eval("ServiceName") %></h3>
                                <span class="studio-name">Creation Car Care Studio, Rajkot</span>
                            </div>
                            <div>
                                <span class='<%# Eval("BookingStatus").ToString() == "Completed" ? "status-badge badge-completed" : "status-badge badge-cancelled" %>'>
                                    <%# Eval("BookingStatus") %>
                                </span>
                            </div>
                        </div>

                        <div class="scheduled-info">
                            Delivered on <span><%# string.Format("{0:dd MMMM yyyy}", Eval("SlotDate")) %></span>
                        </div>

                        <!-- If Already Rated -->
                        <asp:Panel ID="pnlAlreadyRated" runat="server" Visible='<%# Eval("BookingStatus").ToString() == "Completed" && Eval("Rating") != DBNull.Value %>'>
                            <div style="background: #fffbeb; border: 1.5px solid #fef08a; padding: 12px 16px; border-radius: 10px; margin-bottom: 14px;">
                                <div style="font-size: 13px; font-weight: 800; color: #b45309; display: flex; align-items: center; gap: 8px;">
                                    <span style="color: #f59e0b; font-size: 16px;"><%# GetStarsHtml(Eval("Rating")) %></span>
                                    <span>Your Rating: <%# Eval("Rating") %>/5</span>
                                </div>
                                <%# Eval("ReviewText") != DBNull.Value && !string.IsNullOrEmpty(Eval("ReviewText").ToString()) ? 
                                    "<div style='font-size: 12.5px; color: #475569; margin-top: 6px; font-style: italic; background: #ffffff; padding: 8px 12px; border-radius: 6px; border: 1px solid #fde68a;'>\"" + Eval("ReviewText") + "\"</div>" : "" 
                                %>
                            </div>
                        </asp:Panel>

                        <!-- If Completed But Not Rated Yet -->
                        <asp:Panel ID="pnlRateNow" runat="server" Visible='<%# Eval("BookingStatus").ToString() == "Completed" && Eval("Rating") == DBNull.Value %>'>
                            <div style="background: #f8fafc; border: 1.5px solid #e2e8f0; padding: 14px 16px; border-radius: 12px; margin-bottom: 14px;">
                                <div style="font-size: 13px; font-weight: 800; color: #1e293b; margin-bottom: 10px; display: flex; align-items: center; gap: 6px;">
                                    <span>&#11088;</span> Rate &amp; Review Your Experience:
                                </div>
                                <div style="display: flex; gap: 10px; align-items: center; margin-bottom: 10px; flex-wrap: wrap;">
                                    <span style="font-size: 12px; font-weight: 700; color: #64748b;">Rating:</span>
                                    <asp:DropDownList ID="ddlRating" runat="server" style="padding: 6px 10px; border-radius: 8px; border: 1px solid #cbd5e1; font-size: 12px; font-weight: 700; color: #1e293b; background: #ffffff;">
                                        <asp:ListItem Value="5" Selected="True">&#9733;&#9733;&#9733;&#9733;&#9733; 5 Stars (Excellent)</asp:ListItem>
                                        <asp:ListItem Value="4">&#9733;&#9733;&#9733;&#9733; 4 Stars (Very Good)</asp:ListItem>
                                        <asp:ListItem Value="3">&#9733;&#9733;&#9733; 3 Stars (Good)</asp:ListItem>
                                        <asp:ListItem Value="2">&#9733;&#9733; 2 Stars (Fair)</asp:ListItem>
                                        <asp:ListItem Value="1">&#9733; 1 Star (Poor)</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="margin-bottom: 10px;">
                                    <asp:TextBox ID="txtReview" runat="server" placeholder="How was the studio detailing service? Write your feedback here..." style="width: 100%; box-sizing: border-box; padding: 8px 12px; border-radius: 8px; border: 1px solid #cbd5e1; font-size: 12px; font-family: inherit;"></asp:TextBox>
                                </div>
                                <asp:Button ID="btnSubmitReview" runat="server" CommandName="SubmitReview" CommandArgument='<%# Eval("BookingId") %>' Text="Submit Review" CssClass="btn-action-fill" style="padding: 7px 18px; font-size: 12px;" />
                            </div>
                        </asp:Panel>

                        <div class="card-bottom">
                            <div>
                                <div style="font-size: 12px; color: #6b7280; font-weight: 600; margin-bottom: 2px;">
                                    <%# Eval("DiscountAmount") != DBNull.Value && Convert.ToDecimal(Eval("DiscountAmount")) > 0 ? "Discounted Paid:" : "Total Paid:" %>
                                </div>
                                <div style="display: flex; align-items: baseline; gap: 8px;">
                                    <%# Eval("OriginalAmount") != DBNull.Value && Convert.ToDecimal(Eval("OriginalAmount")) > Convert.ToDecimal(Eval("TotalAmount")) ? 
                                        "<span style='font-size: 13px; color: #9ca3af; text-decoration: line-through;'>&#8377;" + string.Format("{0:N0}", Eval("OriginalAmount")) + "</span>" : "" 
                                    %>
                                    <span class="history-price">&#8377;<%# string.Format("{0:N0}", Eval("TotalAmount")) %></span>
                                    <span style="font-size: 11px; color: #6b7280; background: #f3f4f6; padding: 2px 7px; border-radius: 4px; font-weight: 600;"><%# Eval("PaymentMethod") %></span>
                                </div>
                                <%# Eval("DiscountAmount") != DBNull.Value && Convert.ToDecimal(Eval("DiscountAmount")) > 0 ? 
                                    "<div style='margin-top: 5px;'><span style='background: #ecfdf5; color: #059669; border: 1px solid #a7f3d0; font-size: 11px; font-weight: 800; padding: 3px 8px; border-radius: 6px; display: inline-flex; align-items: center; gap: 4px;'>&#127881; " + (Eval("OfferTitle") != DBNull.Value && !string.IsNullOrEmpty(Eval("OfferTitle").ToString()) ? Eval("OfferTitle") : "Offer Applied") + " (-&#8377;" + string.Format("{0:N0}", Eval("DiscountAmount")) + " Saved)</span></div>" : "" 
                                %>
                            </div>
                            <div>
                                <%# Eval("BookingStatus").ToString() == "Completed" ? 
                                    "<span style='font-size: 12px; color: #16a34a; font-weight: 800;'>&#10004; Service Completed</span>" : 
                                    "<span style='font-size: 12px; color: #ef4444; font-weight: 700;'>Cancelled</span>" 
                                %>
                            </div>
                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- If No History Bookings -->
            <asp:Panel ID="pnlNoHistory" runat="server" Visible="false" CssClass="empty-bookings-card">
                <span style="font-size: 40px; display: block; margin-bottom: 10px;">&#128220;</span>
                <h3>No booking history yet!</h3>
                <p>Completed services and previous visits will appear here.</p>
                <div style="display: flex; justify-content: center; gap: 12px; margin-top: 15px;">
                    <a href="ServicesList.aspx" class="btn-browse">Explore Packages &rarr;</a>
                    <a href="Offer.aspx" class="btn-browse" style="background: #ffffff; color: #ea580c; border: 1.5px solid #ea580c;">View Offers &rarr;</a>
                </div>
            </asp:Panel>
        </asp:Panel>

    </div>
</asp:Content>
