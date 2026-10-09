<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="creation_car_care.UserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 600px; margin: 40px auto; background: #fff; padding: 35px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); text-align: center;">
        <h2 style="color: #333; margin-bottom: 10px;">Welcome to Your Dashboard!</h2>
        <p style="color: #666; font-size: 15px; margin-bottom: 25px;">
            <asp:Label ID="lblUserWelcome" runat="server" Font-Bold="true" ForeColor="#ff9800"></asp:Label>
        </p>

        <div style="display: flex; gap: 15px; justify-content: center; margin-top: 20px;">
            <asp:Button ID="btnBook" runat="server" Text="Book Car Service" PostBackUrl="BookService.aspx" style="background: #ff9800; color: white; padding: 12px 25px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;" />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" style="background: #dc3545; color: white; padding: 12px 25px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;" />
        </div>
    </div>
</asp:Content>