<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="creation_car_care.Admin.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .users-mgmt-container {
            max-width: 1050px;
            margin: 0 auto;
        }

        /* Top Search Bar (Exact Match Image 2 Frame 1) */
        .user-search-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            max-width: 480px;
        }

        .search-box-input {
            flex: 1;
            padding: 12px 18px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            color: #1e293b;
            background: #ffffff;
            outline: none;
            transition: border-color 0.2s;
        }

        .search-box-input:focus {
            border-color: #ea580c;
        }

        .btn-search-user {
            padding: 12px 20px;
            background: #ea580c;
            color: #ffffff;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-search-user:hover {
            background: #c2410c;
        }

        /* User Card Rows (Exact Match Image 2 Frame 1) */
        .users-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .user-row-card {
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

        .user-row-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
        }

        .user-left-info {
            display: flex;
            align-items: center;
            gap: 16px;
            min-width: 260px;
        }

        .user-avatar-circle {
            width: 46px;
            height: 46px;
            border-radius: 50%;
            background: #eff6ff;
            color: #2563eb;
            font-size: 16px;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            border: 1.5px solid #bfdbfe;
        }

        .user-meta h4 {
            margin: 0 0 3px 0;
            font-size: 15px;
            font-weight: 800;
            color: #0f172a;
        }

        .user-meta p {
            margin: 0;
            font-size: 12.5px;
            color: #64748b;
        }

        /* Stats Columns */
        .user-stat-col {
            text-align: center;
            min-width: 100px;
        }

        .stat-col-lbl {
            font-size: 11px;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 2px;
        }

        .stat-col-val {
            font-size: 14.5px;
            font-weight: 800;
            color: #0f172a;
        }

        /* Status Badge */
        .badge-user-active {
            background: #dcfce7;
            color: #15803d;
            font-size: 11px;
            font-weight: 800;
            padding: 4px 14px;
            border-radius: 20px;
            letter-spacing: 0.5px;
        }

        .badge-user-suspended {
            background: #fee2e2;
            color: #b91c1c;
            font-size: 11px;
            font-weight: 800;
            padding: 4px 14px;
            border-radius: 20px;
            letter-spacing: 0.5px;
        }

        /* Action Buttons */
        .btn-suspend-user {
            background: #ef4444;
            color: #ffffff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 12px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-suspend-user:hover {
            background: #dc2626;
        }

        .btn-unblock-user {
            background: #ffffff;
            color: #16a34a;
            border: 1.5px solid #16a34a;
            padding: 7px 16px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 12px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-unblock-user:hover {
            background: #16a34a;
            color: #ffffff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="users-mgmt-container">
        
        <!-- Search Bar (Exact Match Image 2 Frame 1) -->
        <div class="user-search-wrapper">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box-input" Placeholder="Search by name, email or phone..."></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search-user" OnClick="btnSearch_Click" />
        </div>

        <!-- Users List Cards -->
        <asp:Repeater ID="rptUsers" runat="server" OnItemCommand="rptUsers_ItemCommand">
            <HeaderTemplate>
                <div class="users-list">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="user-row-card">
                    <!-- Left: Avatar & Meta -->
                    <div class="user-left-info">
                        <div class="user-avatar-circle">
                            <%# GetInitials(Eval("FullName").ToString()) %>
                        </div>
                        <div class="user-meta">
                            <h4><%# Eval("FullName") %></h4>
                            <p><%# Eval("Email") %></p>
                        </div>
                    </div>

                    <!-- Middle 1: Total Bookings -->
                    <div class="user-stat-col">
                        <div class="stat-col-lbl">Total Bookings</div>
                        <div class="stat-col-val"><%# Eval("TotalBookings") %></div>
                    </div>

                    <!-- Middle 2: Total Spent -->
                    <div class="user-stat-col">
                        <div class="stat-col-lbl">Total Spent</div>
                        <div class="stat-col-val" style="color: #ea580c;">&#8377;<%# string.Format("{0:N0}", Eval("TotalSpent")) %></div>
                    </div>

                    <!-- Middle 3: Status Badge -->
                    <div>
                        <span class='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "badge-user-suspended" : "badge-user-active" %>'>
                            <%# Convert.ToBoolean(Eval("IsBlocked")) ? "SUSPENDED" : "ACTIVE" %>
                        </span>
                    </div>

                    <!-- Right: Action Button -->
                    <div>
                        <asp:LinkButton ID="btnToggleBlock" runat="server" 
                            CommandName="ToggleBlock" 
                            CommandArgument='<%# Eval("UserId") %>'
                            CssClass='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "btn-unblock-user" : "btn-suspend-user" %>'>
                            <%# Convert.ToBoolean(Eval("IsBlocked")) ? "UNBLOCK" : "SUSPEND" %>
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
