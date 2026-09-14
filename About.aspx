<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="creation_car_care.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 1150px; margin: 30px auto; padding: 0 15px; font-family: Arial, sans-serif;">
        
        <!-- Page Header -->
        <div style="margin-bottom: 25px;">
            <h1 style="color: #111827; font-size: 26px; font-weight: bold; margin: 0 0 6px 0;">About Creation Car Care</h1>
            <p style="color: #6b7280; font-size: 14px; margin: 0;">Your trusted destination for premium car detailing, PPF protection, and spa services.</p>
        </div>

        <!-- Top Section (Mission & Studio Info) -->
        <div style="display: flex; gap: 25px; flex-wrap: wrap; margin-bottom: 25px;">
            
            <!-- Mission Card -->
            <div style="flex: 2; min-width: 280px; max-width: 100%; box-sizing: border-box; background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 30px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                <h3 style="color: #111827; font-size: 18px; margin: 0 0 12px 0; font-weight: bold;">Our Mission & Expertise</h3>
                <p style="color: #4b5563; font-size: 13.5px; line-height: 1.6; margin: 0 0 20px 0;">
                    At Creation Car Care Detailing Studio, we treat every vehicle like our own masterpiece. Equipped with advanced tools, premium ceramic coatings, and self-healing PPF films, we ensure ultimate gloss, long-lasting protection, and complete customer satisfaction.
                </p>
                <div style="display: flex; gap: 20px; flex-wrap: wrap; font-size: 13px; font-weight: bold; color: #374151;">
                    <span style="display: inline-flex; align-items: center; gap: 6px;"><span style="color: #ea580c;">&#10004;</span> 100% Genuine Products</span>
                    <span style="display: inline-flex; align-items: center; gap: 6px;"><span style="color: #ea580c;">&#10004;</span> Expert Certified Technicians</span>
                </div>
            </div>

            <!-- Studio Location Card -->
            <div style="flex: 1; min-width: 250px; max-width: 100%; box-sizing: border-box; background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 30px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                <h3 style="color: #111827; font-size: 18px; margin: 0 0 15px 0; font-weight: bold;">Visit Our Studio</h3>
                
                <div style="margin-bottom: 15px;">
                    <span style="font-size: 12px; font-weight: bold; color: #ea580c; display: block; margin-bottom: 3px;"> STUDIO LOCATION:</span>
                    <span style="font-size: 13px; color: #4b5563;">Nagrik Bank Chowk, Rajkot</span>
                </div>

                <div style="margin-bottom: 15px;">
                    <span style="font-size: 12px; font-weight: bold; color: #ea580c; display: block; margin-bottom: 3px;"> CONTACT SUPPORT:</span>
                    <span style="font-size: 13px; color: #4b5563; font-weight: bold;">+91 98765 43210</span>
                </div>

                <div>
                    <span style="font-size: 12px; font-weight: bold; color: #059669; display: block; margin-bottom: 3px;"> TIMINGS:</span>
                    <span style="font-size: 13px; color: #4b5563;">Open All Days: 09:00 AM - 08:00 PM</span>
                </div>
            </div>

        </div>

        <!-- Bottom Stats Cards -->
        <div style="display: flex; gap: 25px; flex-wrap: wrap;">
            
            <div style="flex: 1; min-width: 200px; max-width: 100%; box-sizing: border-box; background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 25px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                <div style="font-size: 28px; font-weight: bold; color: #ff9800; margin-bottom: 5px;">1,500+</div>
                <div style="font-size: 13px; color: #4b5563; font-weight: bold;">Cars Detailed & Protected</div>
            </div>

            <div style="flex: 1; min-width: 200px; max-width: 100%; box-sizing: border-box; background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 25px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                <div style="font-size: 28px; font-weight: bold; color: #ff9800; margin-bottom: 5px;">100%</div>
                <div style="font-size: 13px; color: #4b5563; font-weight: bold;">Customer Satisfaction Rate</div>
            </div>

            <div style="flex: 1; min-width: 200px; max-width: 100%; box-sizing: border-box; background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 25px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                <div style="font-size: 28px; font-weight: bold; color: #ff9800; margin-bottom: 5px;">2 Years</div>
                <div style="font-size: 13px; color: #4b5563; font-weight: bold;">Warranty Assurance</div>
            </div>

        </div>

    </div>
</asp:Content>