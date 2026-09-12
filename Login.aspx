<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="creation_car_care.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display: flex; justify-content: center; align-items: center; margin: 40px 0;">
        
        <!-- Main Card Box -->
        <div style="background: linear-gradient(135deg, #fffdfa 0%, #fff6e8 100%); width: 100%; max-width: 480px; padding: clamp(22px, 5vw, 40px); border-radius: 24px; border: 1.5px solid #ffcc80; box-shadow: 0 8px 30px rgba(255, 152, 0, 0.08); box-sizing: border-box;">
            
            <!-- Heading -->
            <div style="text-align: center; margin-bottom: 30px;">
                <h2 style="color: #111827; font-size: 26px; font-weight: bold; margin: 0 0 8px 0;">Welcome Back!</h2>
                <p style="color: #6b7280; font-size: 14px; margin: 0;">Login to your Creation Car Care account</p>
            </div>

            <!-- Email or Mobile Number -->
            <div style="margin-bottom: 20px;">
                <label style="display: block; font-size: 11px; font-weight: bold; color: #4b5563; text-transform: uppercase; margin-bottom: 8px; letter-spacing: 0.5px;">Email or Mobile Number</label>
                <asp:TextBox ID="txtEmailOrMobile" runat="server" placeholder="User@creation.com" style="width: 100%; padding: 12px 15px; border: 1.5px solid #ffcc80; border-radius: 12px; font-size: 14px; box-sizing: border-box; outline: none; background: #fff;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtEmailOrMobile" ErrorMessage="Email or mobile is required!" ForeColor="Red" Display="Dynamic" style="font-size: 11px; margin-top: 4px; display: block;" />
            </div>

            <!-- Password -->
            <div style="margin-bottom: 10px;">
                <label style="display: block; font-size: 11px; font-weight: bold; color: #4b5563; text-transform: uppercase; margin-bottom: 8px; letter-spacing: 0.5px;">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="User@123" style="width: 100%; padding: 12px 15px; border: 1.5px solid #ffcc80; border-radius: 12px; font-size: 14px; box-sizing: border-box; outline: none; background: #fff;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required!" ForeColor="Red" Display="Dynamic" style="font-size: 11px; margin-top: 4px; display: block;" />
            </div>

            <!-- Forgot Password Link -->
            <div style="text-align: right; margin-bottom: 25px;">
                <a href="ForgotPassword.aspx" style="color: #ff9800; font-size: 13px; text-decoration: none; font-weight: bold;">Forgot Password?</a>
            </div>

            <!-- Login Button -->
            <asp:Button ID="btnLogin" runat="server" Text="LOGIN TO ACCOUNT" OnClick="btnLogin_Click" 
                style="width: 100%; background: #ff9800; color: #fff; padding: 14px; border: none; border-radius: 12px; font-weight: bold; font-size: 15px; cursor: pointer; letter-spacing: 0.5px; box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);" />

            <div style="text-align: center; margin-top: 15px;">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Size="13px" Font-Bold="true"></asp:Label>
            </div>

            <!-- Register Link Footer -->
            <div style="text-align: center; margin-top: 25px; font-size: 14px; color: #6b7280;">
                Don't have an account? <a href="Register.aspx" style="color: #ff9800; text-decoration: none; font-weight: bold;">Register Now</a>
            </div>

            <!-- Divider -->
            <div style="display: flex; align-items: center; margin: 24px 0 20px 0;">
                <div style="flex: 1; height: 1px; background: #fed7aa;"></div>
                <span style="padding: 0 12px; font-size: 11.5px; font-weight: 800; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.5px;">Portal Access</span>
                <div style="flex: 1; height: 1px; background: #fed7aa;"></div>
            </div>

            <!-- Admin Login Button -->
            <div style="text-align: center;">
                <a href="Admin/Login.aspx" style="display: flex; align-items: center; justify-content: center; gap: 8px; width: 100%; background: #111827; color: #ffffff; padding: 13px; border-radius: 12px; font-weight: 800; font-size: 13.5px; text-decoration: none; letter-spacing: 0.5px; box-sizing: border-box; box-shadow: 0 4px 12px rgba(17, 24, 39, 0.15); transition: all 0.2s;">
                    <span>&#128737;</span> ADMIN LOGIN
                </a>
            </div>
           
        </div>
    </div>
</asp:Content>