<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="creation_car_care.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 450px; margin: 40px auto; background: #ffffff; padding: clamp(20px, 5vw, 35px); border-radius: 20px; box-shadow: 0 8px 30px rgba(255, 152, 0, 0.15); border: 1.5px solid #ffcc80; font-family: Arial, sans-serif;">
        
        <div style="text-align: center; margin-bottom: 25px;">
            <h2 style="color: #111; font-size: 26px; font-weight: bold; margin: 0;">Create Account</h2>
            <p style="color: #666; font-size: 13.5px; margin-top: 6px;">Register to book car care services instantly</p>
        </div>

        <div style="margin-bottom: 18px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #333; margin-bottom: 6px;">Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter your full name" style="width: 100%; padding: 11px; border: 1.5px solid #d1d5db; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
        </div>

        <div style="margin-bottom: 18px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #333; margin-bottom: 6px;">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Enter your email" style="width: 100%; padding: 11px; border: 1.5px solid #d1d5db; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
        </div>

        <div style="margin-bottom: 22px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #333; margin-bottom: 6px;">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Create a password" style="width: 100%; padding: 11px; border: 1.5px solid #d1d5db; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
        </div>

        <div style="margin-bottom: 20px;">
            <asp:Button ID="btnRegister" runat="server" Text="Register & Verify OTP" OnClick="btnRegister_Click" style="width: 100%; background: #ff9800; color: white; padding: 12px; border: none; border-radius: 10px; font-weight: bold; font-size: 14px; cursor: pointer; box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);" />
        </div>

        <div style="text-align: center; margin-bottom: 15px;">
            <asp:Label ID="lblError" runat="server" style="color: red; font-size: 13px; font-weight: bold;"></asp:Label>
        </div>

        <div style="text-align: center; font-size: 13px; color: #666;">
            Already have an account? <a href="Login.aspx" style="color: #ff9800; text-decoration: none; font-weight: bold;">Login here</a>
        </div>

    </div>
</asp:Content>