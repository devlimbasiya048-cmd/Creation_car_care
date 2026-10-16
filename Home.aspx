<%@ Page Title="Home - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="creation_car_care.Home" %>
<%@ Register Src="~/Controls/StudioStatBanner.ascx" TagPrefix="uc" TagName="StudioStatBanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Hero Banner Container */
        .hero-banner {
            background: linear-gradient(135deg, #f5730a 0%, #ea580c 100%);
            border-radius: 24px;
            padding: 42px 48px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 30px rgba(234, 88, 12, 0.15);
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
            box-sizing: border-box;
        }

        .hero-content {
            flex: 1;
            max-width: 540px;
            z-index: 1;
        }

        .hero-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.22);
            color: #ffffff;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 16px;
        }

        .hero-title {
            font-size: 38px;
            font-weight: 800;
            color: #ffffff;
            margin: 0 0 14px 0;
            letter-spacing: 0.5px;
            line-height: 1.15;
        }

        .hero-desc {
            font-size: 15px;
            color: #ffffff;
            margin: 0 0 24px 0;
            font-weight: 500;
            line-height: 1.5;
            max-width: 480px;
            opacity: 0.95;
        }

        .hero-btn {
            background: #182230;
            color: #ffffff;
            padding: 12px 26px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: background 0.2s, transform 0.2s;
            box-shadow: 0 4px 12px rgba(0,0,0,0.18);
        }

        .hero-btn:hover {
            background: #0f172a;
            transform: translateY(-2px);
            color: #ffffff;
        }

        .hero-image-wrap {
            margin-left: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1;
        }

        .hero-img {
            max-height: 250px;
            width: auto;
            max-width: 320px;
            border-radius: 14px;
            object-fit: cover;
            box-shadow: 0 8px 24px rgba(0,0,0,0.22);
        }

        /* Section Header */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .section-header h2 {
            font-size: 22px;
            font-weight: 800;
            color: #111827;
            margin: 0;
        }

        .view-all-link {
            color: #ea580c;
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.2s;
        }

        .view-all-link:hover {
            color: #c2410c;
            text-decoration: underline;
        }

        /* Featured Services Cards */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }

        .service-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.04);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 210px;
            box-sizing: border-box;
            text-decoration: none;
            color: inherit;
            transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
        }

        .service-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(234, 88, 12, 0.08);
            border-color: #fdba74;
        }

        .service-title {
            font-size: 16.5px;
            font-weight: 700;
            color: #111827;
            margin: 0 0 10px 0;
        }

        .service-desc {
            font-size: 13.5px;
            color: #6b7280;
            line-height: 1.55;
            margin: 0 0 20px 0;
        }

        .service-price {
            font-size: 18px;
            font-weight: 800;
            color: #ea580c;
            margin: 0;
        }

        @media (max-width: 900px) {
            .hero-banner {
                flex-direction: column;
                text-align: center;
                padding: 35px 24px;
            }
            .hero-content {
                max-width: 100%;
            }
            .hero-desc {
                max-width: 100%;
            }
            .hero-image-wrap {
                margin-left: 0;
                margin-top: 24px;
            }
            .hero-img {
                max-width: 100%;
            }
            .services-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Top Hero Banner (Orange Box with Studio Image) -->
    <div class="hero-banner">
        <div class="hero-content">
            <span class="hero-badge">&#10024; PREMIUM STUDIO</span>
            <h1 class="hero-title">CREATION CAR CARE</h1>
            <p class="hero-desc">Give your car the luxury treatment it deserves with Ceramic Coating, PPF &amp; Spa.</p>
            <a href="ServicesList.aspx" class="hero-btn">Explore Services</a>
        </div>
        <div class="hero-image-wrap">
            <img src="Images/Creation_car_care_Studio.png" alt="Creation Car Care Studio" class="hero-img" />
        </div>
    </div>

    <!-- Reusable ASP.NET Web User Control (Syllabus Section II, Unit 6) -->
    <uc:StudioStatBanner ID="ucStudioStatBanner" runat="server" />

    <!-- Featured Services Section (Dynamically bound using OOP StudioManager & Collections) -->
    <div class="section-header">
        <h2>Featured Services</h2>
        <a href="ServicesList.aspx" class="view-all-link">View All Services &rarr;</a>
    </div>

    <div class="services-grid">
        <asp:Repeater ID="rptFeaturedServices" runat="server">
            <ItemTemplate>
                <a href='<%# "ServiceDetails.aspx?id=" + Eval("Id") %>' class="service-card">
                    <div>
                        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px;">
                            <span style="font-size: 11px; font-weight: 700; color: #ea580c; background: #ffedd5; padding: 3px 8px; border-radius: 6px; text-transform: uppercase;"><%# Eval("Category") %></span>
                            <span style="font-size: 12px; font-weight: 700; color: #16a34a;">&#9733; <%# Eval("Rating") %></span>
                        </div>
                        <h3 class="service-title"><%# Eval("ServiceName") %></h3>
                        <p class="service-desc"><%# Eval("ShortDescription") %></p>
                    </div>
                    <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px dashed #fed7aa; padding-top: 14px; margin-top: auto;">
                        <span class="service-price">&#8377;<%# string.Format("{0:N0}", Eval("BasePrice")) %></span>
                        <span style="font-size: 13px; font-weight: bold; color: #ea580c;">View Details &rarr;</span>
                    </div>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
