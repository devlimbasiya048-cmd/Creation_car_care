<%@ Page Title="Admin Profile Details" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="creation_car_care.Admin.AdminProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-container {
            max-width: 620px;
            margin: 0 auto;
        }
        /* Orange Curve Banner Header (Matching Screenshot 2 Frame 1 & 2) */
        .profile-card-wrap {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1.5px solid #fed7aa;
            margin-bottom: 30px;
        }
        .orange-header-banner {
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: #ffffff;
            padding: 24px 24px 45px 24px;
            text-align: center;
            position: relative;
        }
        .banner-back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            color: #ffffff;
            text-decoration: none;
            font-size: 20px;
            font-weight: bold;
        }
        .banner-avatar {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: #ffffff;
            color: #ea580c;
            font-size: 26px;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto -36px auto;
            position: relative;
            z-index: 2;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            border: 3px solid #fff;
        }
        .profile-body-content {
            padding: 48px 30px 30px 30px;
            text-align: center;
        }
        .admin-display-name {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px 0;
        }
        .admin-display-role {
            font-size: 11px;
            font-weight: 800;
            color: #ea580c;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin: 0 0 24px 0;
        }
        .profile-details-table {
            background: #fffcf8;
            border: 1px solid #ffedd5;
            border-radius: 14px;
            padding: 16px 20px;
            text-align: left;
            margin-bottom: 24px;
        }
        .info-row {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px dashed #fed7aa;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-icon {
            font-size: 16px;
            color: #ea580c;
            width: 22px;
        }
        .info-data-label {
            font-size: 11px;
            color: #94a3b8;
            font-weight: 700;
            text-transform: uppercase;
        }
        .info-data-val {
            font-size: 13.5px;
            font-weight: 700;
            color: #1e293b;
        }
        /* Edit Form Section */
        .form-section-title {
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
            text-align: left;
            margin: 20px 0 16px 0;
            border-top: 1px solid #f1f5f9;
            padding-top: 20px;
        }
        .edit-form-group {
            text-align: left;
            margin-bottom: 16px;
        }
        .edit-form-lbl {
            font-size: 12px;
            font-weight: 700;
            color: #475569;
            margin-bottom: 6px;
            display: block;
        }
        .edit-form-input {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 10px;
            font-size: 13.5px;
            color: #0f172a;
            box-sizing: border-box;
            outline: none;
        }
        .edit-form-input:focus {
            border-color: #ea580c;
        }
        .btn-update-admin {
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
        .btn-update-admin:hover {
            background: #c2410c;
        }
        .success-msg-box {
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
            padding: 10px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 16px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-container">
        
        <div class="profile-card-wrap">
            <!-- Orange Banner Header -->
            <div class="orange-header-banner">
                <a href="Settings.aspx" class="banner-back-btn">&larr;</a>
                <h3 style="margin: 0; font-size: 16px; font-weight: 800;">Edit Admin Profile</h3>
            </div>
            
            <div class="banner-avatar">DL</div>

            <div class="profile-body-content">
                <h2 class="admin-display-name"><asp:Label ID="lblDisplayName" runat="server" Text="Dev Limbasiya"></asp:Label></h2>
                <div class="admin-display-role">Master Administrator</div>

                <asp:Label ID="lblSuccessAlert" runat="server" Visible="false" CssClass="success-msg-box">&#10004; Admin Profile details updated successfully!</asp:Label>

                <!-- Profile Read Details Box -->
                <div class="profile-details-table">
                    <div class="info-row">
                        <span class="info-icon">&#127970;</span>
                        <div>
                            <div class="info-data-label">Studio Name</div>
                            <div class="info-data-val"><asp:Label ID="lblStudioName" runat="server" Text="Creation Car Care"></asp:Label></div>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-icon">&#128231;</span>
                        <div>
                            <div class="info-data-label">Email Address</div>
                            <div class="info-data-val"><asp:Label ID="lblEmailAddress" runat="server" Text="admin@creation.com"></asp:Label></div>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-icon">&#128222;</span>
                        <div>
                            <div class="info-data-label">Contact Number</div>
                            <div class="info-data-val"><asp:Label ID="lblPhone" runat="server" Text="+91 98765 43210"></asp:Label></div>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-icon">&#128205;</span>
                        <div>
                            <div class="info-data-label">Location / Address</div>
                            <div class="info-data-val"><asp:Label ID="lblAddress" runat="server" Text="Rajkot-Gondal Road, Rajkot, Gujarat"></asp:Label></div>
                        </div>
                    </div>
                </div>

                <!-- Edit Form Fields -->
                <h3 class="form-section-title">Update Information</h3>

                <div class="edit-form-group">
                    <label class="edit-form-lbl">Administrator Full Name</label>
                    <asp:TextBox ID="txtAdminName" runat="server" CssClass="edit-form-input"></asp:TextBox>
                </div>

                <div class="edit-form-group">
                    <label class="edit-form-lbl">Studio Center Name</label>
                    <asp:TextBox ID="txtStudioName" runat="server" CssClass="edit-form-input"></asp:TextBox>
                </div>

                <div class="edit-form-group">
                    <label class="edit-form-lbl">Admin Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="edit-form-input"></asp:TextBox>
                </div>

                <div class="edit-form-group">
                    <label class="edit-form-lbl">Contact Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="edit-form-input"></asp:TextBox>
                </div>

                <div class="edit-form-group">
                    <label class="edit-form-lbl">Studio Physical Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="edit-form-input"></asp:TextBox>
                </div>

                <asp:Button ID="btnUpdateProfile" runat="server" Text="UPDATE ADMIN DETAILS" OnClick="btnUpdateProfile_Click" CssClass="btn-update-admin" />

            </div>
        </div>

    </div>
</asp:Content>
