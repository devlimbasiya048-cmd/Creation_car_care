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
            width: 90px;
            height: 90px;
            margin: 0 auto 28px auto;
        }
        .avatar-circle-big {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            font-weight: 800;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.25);
            border: 3px solid #ffffff;
            cursor: pointer;
        }
        .avatar-img-big {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            display: block;
        }
        .avatar-cam-badge {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #ea580c;
            color: #ffffff;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            border: 2.5px solid #ffffff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.25);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .avatar-cam-badge:hover {
            background: #c2410c;
            transform: scale(1.12);
        }
        .upload-text {
            font-size: 12px;
            color: #ea580c;
            font-weight: 700;
            margin-top: 8px;
            display: block;
            cursor: pointer;
        }
        .upload-text:hover {
            text-decoration: underline;
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
            margin-top: 14px;
            color: #6b7280;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: color 0.2s;
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

            <!-- Avatar & Camera Click Upload Trigger -->
            <div class="avatar-wrap">
                <!-- Avatar circle: click to choose photo -->
                <div class="avatar-circle-big" onclick="document.getElementById('<%= fuProfilePic.ClientID %>').click();" title="Click to upload profile photo">
                    <asp:Image ID="imgProfilePreview" runat="server" CssClass="avatar-img-big" Visible="false" />
                    <asp:Label ID="lblAvatarInitial" runat="server" Text="D"></asp:Label>
                </div>

                <!-- Hidden FileUpload control -->
                <asp:FileUpload ID="fuProfilePic" runat="server" style="display: none;" onchange="previewSelectedImage(this);" accept="image/*" />

                <!-- Camera Badge Icon (Clicking this directly opens file selector) -->
                <label for="<%= fuProfilePic.ClientID %>" class="avatar-cam-badge" title="Click camera to select photo">
                    &#128247;
                </label>

                <label for="<%= fuProfilePic.ClientID %>" class="upload-text" title="Click to choose a photo">
                  
                </label>
            </div>

            <!-- Success Alert -->
            <asp:Label ID="lblSuccess" runat="server" Visible="false" 
                style="display: block; background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; padding: 12px; border-radius: 10px; font-size: 13.5px; font-weight: bold; margin-bottom: 20px;">
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

                <!-- Account Security Shortcut -->
                <div style="background: #fff7ed; border: 1.5px solid #fed7aa; border-radius: 10px; padding: 12px 16px; margin-top: 14px; display: flex; align-items: center; justify-content: space-between; gap: 10px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <span style="font-size: 20px;">&#128274;</span>
                        <div>
                            <div style="font-size: 13px; font-weight: 800; color: #9a3412;">Account Security</div>
                            <div style="font-size: 11.5px; color: #c2410c;">Want to update your password?</div>
                        </div>
                    </div>
                    <a href="ChangePassword.aspx" style="background: #ffffff; color: #ea580c; border: 1.5px solid #ea580c; padding: 6px 14px; border-radius: 8px; font-size: 12px; font-weight: 800; text-decoration: none; transition: all 0.2s; white-space: nowrap;">
                        Change Password &rarr;
                    </a>
                </div>
            </div>

            <asp:Button ID="btnSaveProfile" runat="server" Text="SAVE CHANGES" OnClick="btnSaveProfile_Click" CssClass="btn-save" />
            <a href="Profile.aspx" class="btn-back-profile">&larr; Back to Profile</a>

        </div>
    </div>

    <!-- Live Image Preview Script -->
    <script type="text/javascript">
        function previewSelectedImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var previewImg = document.getElementById('<%= imgProfilePreview.ClientID %>');
                    var initialLbl = document.getElementById('<%= lblAvatarInitial.ClientID %>');

                    if (previewImg) {
                        previewImg.src = e.target.result;
                        previewImg.style.display = 'block';
                    }
                    if (initialLbl) {
                        initialLbl.style.display = 'none';
                    }
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
