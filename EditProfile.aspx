<%@ Page Title="Edit Profile - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="creation_car_care.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-wrapper {
            max-width: 580px;
            margin: 40px auto;
            padding: 0 15px;
        }
        .profile-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 24px;
            padding: 40px 36px;
            box-shadow: 0 8px 30px rgba(234, 88, 12, 0.06);
            text-align: center;
        }
        .profile-title {
            font-size: 24px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 25px 0;
        }
        .avatar-wrap {
            position: relative;
            width: 86px;
            height: 86px;
            margin: 0 auto 28px auto;
        }
        .avatar-circle-big {
            width: 86px;
            height: 86px;
            border-radius: 50%;
            background: #cbd5e1;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            font-weight: 800;
        }
        .avatar-cam-badge {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #ea580c;
            color: #ffffff;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            border: 2px solid #ffffff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
            cursor: pointer;
        }
        .upload-text {
            font-size: 12px;
            color: #9ca3af;
            margin-top: 6px;
            display: block;
        }
        .form-section {
            text-align: left;
            margin-bottom: 24px;
        }
        .section-header-lbl {
            font-size: 13px;
            font-weight: 800;
            color: #374151;
            margin-bottom: 14px;
            border-bottom: 1px solid #ffedd5;
            padding-bottom: 6px;
        }
        .form-group {
            margin-bottom: 16px;
        }
        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #6b7280;
            margin-bottom: 6px;
        }
        .input-wrap {
            position: relative;
            display: flex;
            align-items: center;
        }
        .form-input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #e5e7eb;
            border-radius: 10px;
            font-size: 14px;
            color: #111827;
            background: #ffffff;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }
        .form-input:focus {
            outline: none;
            border-color: #ea580c;
        }
        .input-badge {
            position: absolute;
            right: 12px;
            background: #dcfce7;
            color: #15803d;
            font-size: 11px;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 6px;
            border: 1px solid #bbf7d0;
        }
        .btn-save {
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
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
            margin-top: 10px;
        }
        .btn-save:hover {
            background: #c2410c;
        }
        .btn-back-profile {
            display: block;
            margin-top: 12px;
            color: #6b7280;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
        }
        .btn-back-profile:hover {
            color: #ea580c;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-wrapper">
        <div class="profile-card">
            
            <h2 class="profile-title">Edit Profile Details</h2>

            <!-- Avatar -->
            <div class="avatar-wrap">
                <div class="avatar-circle-big">
                    <asp:Label ID="lblAvatarInitial" runat="server" Text="D"></asp:Label>
                </div>
                <div class="avatar-cam-badge">&#128247;</div>
                <span class="upload-text">Upload Photo</span>
            </div>

            <!-- Success Alert -->
            <asp:Label ID="lblSuccess" runat="server" Visible="false" 
                style="display: block; background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; padding: 10px; border-radius: 8px; font-size: 13px; font-weight: bold; margin-bottom: 20px;">
            </asp:Label>

            <!-- Personal Details -->
            <div class="form-section">
                <div class="section-header-lbl">Personal Details</div>

                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <div class="input-wrap">
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" placeholder="Enter Full Name"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Mobile Number</label>
                    <div class="input-wrap">
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-input" placeholder="+91 98765 43210"></asp:TextBox>
                        <span class="input-badge">&#10004; Verified</span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Email Address (Registered)</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" ReadOnly="true" style="background: #f8fafc; color: #64748b;"></asp:TextBox>
                </div>
            </div>

            <asp:Button ID="btnSaveProfile" runat="server" Text="SAVE CHANGES" OnClick="btnSaveProfile_Click" CssClass="btn-save" />
            <a href="Profile.aspx" class="btn-back-profile">&larr; Back to Profile</a>

        </div>
    </div>
</asp:Content>
