<%@ Page Title="Change Password - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="creation_car_care.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pwd-wrapper {
            max-width: 520px;
            margin: 40px auto 70px auto;
            padding: 0 16px;
        }

        .pwd-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 36px 34px;
            border: 1.5px solid #fed7aa;
            box-shadow: 0 10px 30px rgba(234, 88, 12, 0.06);
        }

        .pwd-header {
            text-align: center;
            margin-bottom: 28px;
        }

        .pwd-icon-badge {
            width: 56px;
            height: 56px;
            border-radius: 16px;
            background: #fff7ed;
            color: #ea580c;
            border: 1.5px solid #fed7aa;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            margin-bottom: 12px;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.12);
        }

        .pwd-header h2 {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 6px 0;
        }

        .pwd-header p {
            font-size: 13px;
            color: #64748b;
            margin: 0;
            line-height: 1.45;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #374151;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 10px;
            font-size: 14px;
            color: #111827;
            background: #ffffff;
            box-sizing: border-box;
            transition: all 0.2s;
            outline: none;
        }

        .form-input:focus {
            border-color: #ea580c;
            box-shadow: 0 0 0 3px rgba(234, 88, 12, 0.1);
        }

        .val-error {
            display: block;
            color: #dc2626;
            font-size: 11.5px;
            font-weight: 700;
            margin-top: 4px;
        }

        .btn-update-pwd {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: background 0.2s;
            box-shadow: 0 4px 14px rgba(234, 88, 12, 0.25);
            margin-top: 10px;
        }

        .btn-update-pwd:hover {
            background: #c2410c;
        }

        .btn-back-link {
            display: inline-block;
            margin-top: 18px;
            color: #64748b;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: color 0.2s;
            text-align: center;
            width: 100%;
        }

        .btn-back-link:hover {
            color: #ea580c;
        }

        .alert-box {
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .alert-success {
            background: #ecfdf5;
            color: #065f46;
            border: 1.5px solid #a7f3d0;
        }
        .alert-danger {
            background: #fef2f2;
            color: #991b1b;
            border: 1.5px solid #fecaca;
        }

        .pwd-hint {
            background: #fffbeb;
            border: 1px solid #fef08a;
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 12px;
            color: #854d0e;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pwd-wrapper">
        <div class="pwd-card">
            
            <div class="pwd-header">
                <div class="pwd-icon-badge">&#128274;</div>
                <h2>Change Account Password</h2>
                <p>Enhance your security by updating your Creation Car Care login password.</p>
            </div>

            <!-- Alert Message -->
            <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                <div class='alert-box <%= AlertIsSuccess ? "alert-success" : "alert-danger" %>'>
                    <asp:Label ID="lblAlertMsg" runat="server"></asp:Label>
                </div>
            </asp:Panel>

            <div class="pwd-hint">
                <span>&#128161;</span> Choose a secure password with at least 6 characters.
            </div>

            <!-- Current Password -->
            <div class="form-group">
                <label class="form-label">Current Password *</label>
                <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Enter your current password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCurrent" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="Current password is required." CssClass="val-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <!-- New Password -->
            <div class="form-group">
                <label class="form-label">New Password *</label>
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Enter new password (min 6 characters)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNew" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="New password is required." CssClass="val-error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <!-- Confirm New Password -->
            <div class="form-group">
                <label class="form-label">Confirm New Password *</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Re-enter your new password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirming your password is required." CssClass="val-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword" ErrorMessage="New password and confirm password must match." CssClass="val-error" Display="Dynamic"></asp:CompareValidator>
            </div>

            <asp:Button ID="btnUpdatePassword" runat="server" Text="UPDATE PASSWORD" OnClick="btnUpdatePassword_Click" CssClass="btn-update-pwd" />
            
            <a href="Profile.aspx" class="btn-back-link">&larr; Back to Profile Hub</a>

        </div>
    </div>
</asp:Content>
