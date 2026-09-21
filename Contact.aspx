<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="creation_car_care.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 1150px; margin: 30px auto; padding: 0 15px; font-family: Arial, sans-serif;">
        
        <!-- Page Header -->
        <div style="margin-bottom: 25px;">
            <h1 style="color: #111827; font-size: 26px; font-weight: bold; margin: 0 0 6px 0;">Get in Touch with Us</h1>
            <p style="color: #6b7280; font-size: 14px; margin: 0;">Have questions about our car care services or want to visit our studio? Send us a message.</p>
        </div>

        <!-- Main Layout (Form Left, Info Right) -->
        <div style="display: flex; gap: 25px; flex-wrap: wrap;">
            
            <!-- Left Form Box -->
            <div style="flex: 2; min-width: 320px; background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 30px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                <h3 style="color: #111827; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">Send Us a Message</h3>

                <!-- Name -->
                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 11px; font-weight: bold; color: #4b5563; text-transform: uppercase; margin-bottom: 6px;">Your Name</label>
                    <asp:TextBox ID="txtName" runat="server" placeholder="Enter your full name" style="width: 100%; padding: 11px 14px; border: 1.5px solid #ffcc80; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
                </div>

                <!-- Mobile -->
                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 11px; font-weight: bold; color: #4b5563; text-transform: uppercase; margin-bottom: 6px;">Mobile Number</label>
                    <asp:TextBox ID="txtMobile" runat="server" placeholder="+91 98765 43210" style="width: 100%; padding: 11px 14px; border: 1.5px solid #ffcc80; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
                </div>

                <!-- Message -->
                <div style="margin-bottom: 22px;">
                    <label style="display: block; font-size: 11px; font-weight: bold; color: #4b5563; text-transform: uppercase; margin-bottom: 6px;">Your Message / Inquiry</label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" placeholder="Write your message here regarding ceramic coating, PPF or wash..." style="width: 100%; padding: 11px 14px; border: 1.5px solid #ffcc80; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none; resize: none;"></asp:TextBox>
                </div>

                <!-- Send Button -->
                <asp:Button ID="btnSend" runat="server" Text="SEND MESSAGE" OnClick="btnSend_Click" 
                    style="width: 100%; background: #ff9800; color: #fff; padding: 13px; border: none; border-radius: 10px; font-weight: bold; font-size: 14px; cursor: pointer; box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);" />
            </div>

            <!-- Right Info Cards -->
            <div style="flex: 1; min-width: 260px; display: flex; flex-direction: column; gap: 20px;">
                
                <div style="background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 22px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                    <span style="font-size: 12px; font-weight: bold; color: #ea580c; display: block; margin-bottom: 5px;">&#128205; Studio Location</span>
                    <div style="font-size: 14px; font-weight: bold; color: #111827; margin-bottom: 3px;">Creation Car Care Detailing Studio</div>
                    <div style="font-size: 13px; color: #4b5563;">Nagrik Bank Chowk, Rajkot, Gujarat</div>
                </div>

                <div style="background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 22px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                    <span style="font-size: 12px; font-weight: bold; color: #ea580c; display: block; margin-bottom: 5px;">&#128340; Working Hours</span>
                    <div style="font-size: 14px; font-weight: bold; color: #111827; margin-bottom: 3px;">Monday to Sunday</div>
                    <div style="font-size: 13px; color: #4b5563;">09:00 AM - 08:00 PM (Open All Days)</div>
                </div>

                <div style="background: #fff; border: 1.5px solid #ffcc80; border-radius: 20px; padding: 22px; box-shadow: 0 4px 20px rgba(255, 152, 0, 0.05);">
                    <span style="font-size: 12px; font-weight: bold; color: #ea580c; display: block; margin-bottom: 5px;">&#128222; Call / WhatsApp Support</span>
                    <div style="font-size: 15px; font-weight: bold; color: #111827; margin-bottom: 3px;">+91 98765 43210</div>
                    <div style="font-size: 12px; color: #6b7280;">Instant booking assistance available</div>
                </div>

            </div>

        </div>

    </div>
</asp:Content>