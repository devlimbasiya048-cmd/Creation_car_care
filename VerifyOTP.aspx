<%@ Page Title="Phone Verification" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="VerifyOTP.aspx.cs" Inherits="creation_car_care.VerifyOTP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 450px; margin: 40px auto; background: #fff; border-radius: 20px; box-shadow: 0 5px 25px rgba(0,0,0,0.08); padding: 40px 30px; border: 1px solid #eee; text-align: center;">
        
        <h2 style="color: #111; margin-bottom: 10px; font-size: 24px; font-weight: bold;">Phone Verification</h2>
        <p style="color: #666; font-size: 14px; margin-bottom: 30px;">
            Enter the 4-digit code sent to your mobile number. <br/><b>(Demo OTP: 1234)</b>
        </p>

        <!-- 4 Digit OTP Inputs Style -->
        <div style="display: flex; justify-content: center; gap: 12px; margin-bottom: 25px;">
            <asp:TextBox ID="txtOTP" runat="server" MaxLength="4" placeholder="1234" style="width: 180px; padding: 12px; font-size: 20px; text-align: center; letter-spacing: 8px; border: 1px solid #dcdcdc; border-radius: 10px; outline: none;"></asp:TextBox>
        </div>

        <asp:Button ID="btnVerify" runat="server" Text="VERIFY & PROCEED" OnClick="btnVerify_Click" style="width: 100%; background: #FF8A00; color: white; padding: 14px; border: none; border-radius: 10px; font-weight: bold; font-size: 15px; cursor: pointer;" />

        <div style="margin-top: 20px;">
            <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Font-Size="13px"></asp:Label>
        </div>

        <div style="margin-top: 20px; font-size: 13px; color: #666;">
            Didn't receive code? <asp:LinkButton ID="lnkResend" runat="server" style="color: #FF8A00; text-decoration: none; font-weight: bold;">Resend OTP (30s)</asp:LinkButton>
        </div>
    </div>
</asp:Content>