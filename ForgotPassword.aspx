<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="creation_car_care.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 450px; margin: 40px auto; background: #fff; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.08); overflow: hidden; border: 1px solid #eee;">
        
        <!-- Orange Header Curve Box -->
        <div style="background: #FF8A00; padding: 30px 20px; text-align: center; color: white;">
            <h2 style="margin: 0; font-size: 24px; font-weight: bold; letter-spacing: 0.5px;">FORGOT PASSWORD</h2>
        </div>

        <!-- Form Body -->
        <div style="padding: 35px 30px;">
            <p style="color: #666; font-size: 14px; line-height: 1.5; margin-top: 0; margin-bottom: 25px; text-align: center;">
                Don't worry! It happens. Please enter the mobile number or email associated with your account to receive an OTP.
            </p>

            <div style="margin-bottom: 20px;">
                <label style="font-weight: bold; display: block; margin-bottom: 8px; color: #333; font-size: 14px;">Mobile Number / Email</label>
                <asp:TextBox ID="txtEmailOrMobile" runat="server" placeholder="Enter your mobile number or email" style="width: 100%; padding: 12px 15px; border-radius: 8px; border: 1px solid #dcdcdc; box-sizing: border-box; font-size: 14px; outline: none;"></asp:TextBox>
            </div>

            <asp:Button ID="btnSendOTP" runat="server" Text="SEND OTP" OnClick="btnSendOTP_Click" style="width: 100%; background: #FF8A00; color: white; padding: 14px; border: none; border-radius: 8px; font-weight: bold; font-size: 15px; cursor: pointer; transition: 0.3s;" />

            <div style="text-align: center; margin-top: 20px;">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Font-Size="13px"></asp:Label>
            </div>

            <div style="text-align: center; margin-top: 25px; font-size: 14px; color: #666;">
                Remember your password? <a href="Login.aspx" style="color: #FF8A00; font-weight: bold; text-decoration: none;">Login</a>
            </div>
        </div>
    </div>
</asp:Content>