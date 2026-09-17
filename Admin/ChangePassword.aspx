<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="creation_car_care.Admin.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pwd-container {
            max-width: 520px;
            margin: 0 auto;
        }
        .pwd-card-wrap {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1.5px solid #fed7aa;
        }
        .orange-header-banner {
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: #ffffff;
            padding: 24px;
            text-align: center;
            position: relative;
        }
        .banner-back-btn {
            position: absolute;
            top: 22px;
            left: 20px;
            color: #ffffff;
            text-decoration: none;
            font-size: 20px;
            font-weight: bold;
        }
        .pwd-body-content {
            padding: 30px;
        }
        .pwd-form-group {
            margin-bottom: 18px;
        }
        .pwd-form-lbl {
            font-size: 12.5px;
            font-weight: 700;
            color: #334155;
            margin-bottom: 6px;
            display: block;
        }
        .pwd-form-input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 10px;
            font-size: 13.5px;
            box-sizing: border-box;
            outline: none;
        }
        .pwd-form-input:focus {
            border-color: #ea580c;
        }
        .btn-update-pwd {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 13px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.25);
        }
        .btn-update-pwd:hover {
            background: #c2410c;
        }
        .alert-box {
            padding: 11px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 18px;
            display: block;
        }
        .alert-success { background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-danger { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pwd-container">
        <div class="pwd-card-wrap">
            
            <!-- Orange Banner Header -->
            <div class="orange-header-banner">
                <a href="Settings.aspx" class="banner-back-btn">&larr;</a>
                <h3 style="margin: 0; font-size: 16px; font-weight: 800;">Change Admin Password</h3>
            </div>

            <div class="pwd-body-content">
                <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert-box"></asp:Label>

                <div class="pwd-form-group">
                    <label class="pwd-form-lbl">Current Password</label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" placeholder="••••••••" CssClass="pwd-form-input"></asp:TextBox>
                </div>

                <div class="pwd-form-group">
                    <label class="pwd-form-lbl">New Password</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="••••••••" CssClass="pwd-form-input"></asp:TextBox>
                </div>

                <div class="pwd-form-group">
                    <label class="pwd-form-lbl">Confirm New Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="••••••••" CssClass="pwd-form-input"></asp:TextBox>
                </div>

                <asp:Button ID="btnUpdatePassword" runat="server" Text="UPDATE PASSWORD" OnClick="btnUpdatePassword_Click" CssClass="btn-update-pwd" />
            </div>

        </div>
    </div>
</asp:Content>
