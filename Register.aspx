<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="creation_car_care.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .validation-summary-card {
            background-color: #fef2f2;
            border: 1.5px solid #fecaca;
            border-radius: 10px;
            padding: 12px 16px;
            margin-bottom: 20px;
            font-size: 13px;
            color: #991b1b;
        }
        .validation-summary-card ul {
            margin: 6px 0 0 18px;
            padding: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 460px; margin: 40px auto; background: #ffffff; padding: clamp(20px, 5vw, 35px); border-radius: 20px; box-shadow: 0 8px 30px rgba(255, 152, 0, 0.15); border: 1.5px solid #ffcc80; font-family: Arial, sans-serif;">
        
        <div style="text-align: center; margin-bottom: 25px;">
            <h2 style="color: #111; font-size: 26px; font-weight: bold; margin: 0;">Create Account</h2>
            <p style="color: #666; font-size: 13.5px; margin-top: 6px;">Register to book car care services instantly</p>
        </div>

        <!-- ASP.NET Validation Controls: ValidationSummary (Syllabus Section II, Unit 6) -->
        <asp:ValidationSummary ID="valSummary" runat="server" CssClass="validation-summary-card" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />

        <div style="margin-bottom: 18px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #333; margin-bottom: 6px;">Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter your full name" style="width: 100%; padding: 11px; border: 1.5px solid #d1d5db; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." Display="Dynamic" ForeColor="#dc2626" Font-Size="12px" />
        </div>

        <div style="margin-bottom: 18px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #333; margin-bottom: 6px;">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Enter your email" style="width: 100%; padding: 11px; border: 1.5px solid #d1d5db; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email address is required." Display="Dynamic" ForeColor="#dc2626" Font-Size="12px" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Please enter a valid email format." Display="Dynamic" ForeColor="#dc2626" Font-Size="12px" />
        </div>

        <div style="margin-bottom: 18px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #333; margin-bottom: 6px;">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Create a password" style="width: 100%; padding: 11px; border: 1.5px solid #d1d5db; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." Display="Dynamic" ForeColor="#dc2626" Font-Size="12px" />
        </div>

        <div style="margin-bottom: 22px;">
            <label style="display: block; font-size: 13px; font-weight: bold; color: #333; margin-bottom: 6px;">Confirm Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm your password" style="width: 100%; padding: 11px; border: 1.5px solid #d1d5db; border-radius: 10px; font-size: 14px; box-sizing: border-box; outline: none;"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required." Display="Dynamic" ForeColor="#dc2626" Font-Size="12px" />
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." Display="Dynamic" ForeColor="#dc2626" Font-Size="12px" />
        </div>

        <div style="margin-bottom: 20px;">
            <asp:Button ID="btnRegister" runat="server" Text="Register &amp; Verify OTP" OnClick="btnRegister_Click" style="width: 100%; background: #ff9800; color: white; padding: 12px; border: none; border-radius: 10px; font-weight: bold; font-size: 14px; cursor: pointer; box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);" />
        </div>

        <div style="text-align: center; margin-bottom: 15px;">
            <asp:Label ID="lblError" runat="server" style="color: red; font-size: 13px; font-weight: bold;"></asp:Label>
        </div>

        <div style="text-align: center; font-size: 13px; color: #666;">
            Already have an account? <a href="Login.aspx" style="color: #ff9800; text-decoration: none; font-weight: bold;">Login here</a>
        </div>

    </div>
</asp:Content>
