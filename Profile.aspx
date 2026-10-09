<%@ Page Title="My Profile - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="creation_car_care.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-page-container {
            max-width: 860px;
            margin: 35px auto 60px auto;
            padding: 0 16px;
        }

        /* Top Profile Banner */
        .profile-hero-card {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            border-radius: 20px;
            padding: 32px 36px;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.15);
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
        }
        .profile-hero-card::after {
            content: "";
            position: absolute;
            right: -40px;
            bottom: -40px;
            width: 180px;
            height: 180px;
            background: radial-gradient(circle, rgba(234, 88, 12, 0.25) 0%, rgba(234, 88, 12, 0) 70%);
            border-radius: 50%;
            pointer-events: none;
        }
        .hero-left-info {
            display: flex;
            align-items: center;
            gap: 22px;
        }
        .profile-avatar-circle {
            width: 82px;
            height: 82px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            font-weight: 800;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.35);
            border: 3px solid rgba(255, 255, 255, 0.2);
            flex-shrink: 0;
        }
        .hero-text h2 {
            margin: 0 0 6px 0;
            font-size: 24px;
            font-weight: 800;
            color: #ffffff;
        }
        .hero-text .hero-sub {
            margin: 0 0 10px 0;
            font-size: 13px;
            color: #94a3b8;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .verified-badge {
            background: rgba(34, 197, 94, 0.2);
            color: #4ade80;
            font-size: 11px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 12px;
            border: 1px solid rgba(34, 197, 94, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .btn-edit-header {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-edit-header:hover {
            background: #ea580c;
            border-color: #ea580c;
            color: #ffffff;
        }

        /* Stats Strip */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 28px;
        }
        .stat-card {
            background: #ffffff;
            border: 1.5px solid #f1f5f9;
            border-radius: 16px;
            padding: 18px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
        }
        .stat-info .stat-num {
            font-size: 24px;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.2;
        }
        .stat-info .stat-title {
            font-size: 12px;
            font-weight: 600;
            color: #64748b;
        }
        .stat-icon-wrap {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .stat-icon-orange { background: #fff7ed; color: #ea580c; }
        .stat-icon-blue { background: #eff6ff; color: #2563eb; }
        .stat-icon-emerald { background: #ecfdf5; color: #059669; }

        /* Hub Section Heading */
        .section-title {
            font-size: 17px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Action Menu Cards */
        .hub-cards-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .hub-card {
            background: #ffffff;
            border: 1.5px solid #ffedd5;
            border-radius: 18px;
            padding: 22px 24px;
            display: flex;
            align-items: flex-start;
            gap: 16px;
            text-decoration: none;
            color: inherit;
            transition: all 0.2s ease;
            box-shadow: 0 3px 12px rgba(234, 88, 12, 0.04);
            position: relative;
        }
        .hub-card:hover {
            transform: translateY(-2px);
            border-color: #ea580c;
            box-shadow: 0 8px 24px rgba(234, 88, 12, 0.12);
        }
        .hub-card-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            background: #fff7ed;
            color: #ea580c;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            flex-shrink: 0;
            border: 1px solid #fed7aa;
        }
        .hub-card-content h3 {
            margin: 0 0 6px 0;
            font-size: 15px;
            font-weight: 800;
            color: #111827;
        }
        .hub-card-content p {
            margin: 0;
            font-size: 12px;
            color: #64748b;
            line-height: 1.45;
        }
        .hub-card-arrow {
            position: absolute;
            top: 22px;
            right: 20px;
            color: #cbd5e1;
            font-size: 16px;
            transition: transform 0.2s;
        }
        .hub-card:hover .hub-card-arrow {
            color: #ea580c;
            transform: translateX(3px);
        }

        /* Logout Row */
        .logout-wrap {
            text-align: center;
            margin-top: 32px;
        }
        .btn-logout {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 28px;
            background: #fee2e2;
            color: #b91c1c;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-logout:hover {
            background: #fecaca;
            color: #991b1b;
        }

        @media (max-width: 640px) {
            .profile-hero-card {
                flex-direction: column;
                align-items: flex-start;
                gap: 18px;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .hub-cards-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-page-container">
        
        <!-- Profile Hero Card -->
        <div class="profile-hero-card">
            <div class="hero-left-info">
                <div class="profile-avatar-circle">
                    <asp:Label ID="lblAvatarInitial" runat="server" Text="U"></asp:Label>
                </div>
                <div class="hero-text">
                    <h2><asp:Label ID="lblFullName" runat="server" Text="User Profile"></asp:Label></h2>
                    <div class="hero-sub">
                        <span>&#128231; <asp:Label ID="lblEmail" runat="server" Text="user@example.com"></asp:Label></span>
                        <span>&#128222; <asp:Label ID="lblMobile" runat="server" Text="+91 98765 43210"></asp:Label></span>
                        <span class="verified-badge">&#10004; Verified Customer</span>
                    </div>
                </div>
            </div>
            <div>
                <a href="EditProfile.aspx" class="btn-edit-header">&#9998; Edit Profile</a>
            </div>
        </div>

        <!-- Quick Stats Strip -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <div class="stat-num"><asp:Label ID="lblVehiclesCount" runat="server" Text="2"></asp:Label></div>
                    <div class="stat-title">My Registered Vehicles</div>
                </div>
                <div class="stat-icon-wrap stat-icon-orange">&#128663;</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <div class="stat-num"><asp:Label ID="lblBookingsCount" runat="server" Text="3"></asp:Label></div>
                    <div class="stat-title">Total Bookings</div>
                </div>
                <div class="stat-icon-wrap stat-icon-blue">&#128197;</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <div class="stat-num"><asp:Label ID="lblWishlistCount" runat="server" Text="1"></asp:Label></div>
                    <div class="stat-title">Saved Wishlist Items</div>
                </div>
                <div class="stat-icon-wrap stat-icon-emerald">&#10084;</div>
            </div>
        </div>

        <!-- Navigation Hub Cards -->
        <div class="section-title">
            <span>&#9881;</span> Quick Account Navigation
        </div>

        <div class="hub-cards-grid">
            
            <!-- My Vehicles -->
            <a href="Vehicles.aspx" class="hub-card">
                <div class="hub-card-icon">&#128663;</div>
                <div class="hub-card-content">
                    <h3>My Vehicles</h3>
                    <p>Manage your garage, view primary car &amp; bike, add new vehicle with license plate.</p>
                </div>
                <div class="hub-card-arrow">&rarr;</div>
            </a>

            <!-- My Bookings -->
            <a href="Booking.aspx" class="hub-card">
                <div class="hub-card-icon">&#128197;</div>
                <div class="hub-card-content">
                    <h3>My Bookings &amp; History</h3>
                    <p>Track ongoing detailing jobs, reschedule upcoming slots, and give ratings/reviews.</p>
                </div>
                <div class="hub-card-arrow">&rarr;</div>
            </a>

            <!-- Help & Support -->
            <a href="HelpSupport.aspx" class="hub-card">
                <div class="hub-card-icon">&#128172;</div>
                <div class="hub-card-content">
                    <h3>Help &amp; Support</h3>
                    <p>Browse FAQs, connect with studio experts, or call customer care instantly.</p>
                </div>
                <div class="hub-card-arrow">&rarr;</div>
            </a>

            <!-- My Wishlist -->
            <a href="Wishlist.aspx" class="hub-card">
                <div class="hub-card-icon">&#10084;</div>
                <div class="hub-card-content">
                    <h3>My Wishlist</h3>
                    <p>View saved paint protection, ceramic coatings, and one-tap move to cart.</p>
                </div>
                <div class="hub-card-arrow">&rarr;</div>
            </a>

            <!-- Edit Profile -->
            <a href="EditProfile.aspx" class="hub-card">
                <div class="hub-card-icon">&#128100;</div>
                <div class="hub-card-content">
                    <h3>Edit Profile Details</h3>
                    <p>Update your personal information, phone number, and avatar details.</p>
                </div>
                <div class="hub-card-arrow">&rarr;</div>
            </a>

            <!-- Studio Services -->
            <a href="ServicesList.aspx" class="hub-card">
                <div class="hub-card-icon">&#11088;</div>
                <div class="hub-card-content">
                    <h3>Browse Services</h3>
                    <p>Explore category-wise correction, PPF protection, and premium packages.</p>
                </div>
                <div class="hub-card-arrow">&rarr;</div>
            </a>

        </div>

        <!-- Logout -->
        <div class="logout-wrap">
            <asp:LinkButton ID="btnLogoutProfile" runat="server" OnClick="btnLogoutProfile_Click" CssClass="btn-logout">&#128682; Log Out from Account</asp:LinkButton>
        </div>

    </div>
</asp:Content>
