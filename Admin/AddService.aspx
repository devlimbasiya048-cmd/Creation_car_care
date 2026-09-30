<%@ Page Title="Add New Service" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddService.aspx.cs" Inherits="creation_car_care.Admin.AddService" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .add-service-container {
            max-width: 580px;
            margin: 0 auto;
        }

        .service-form-card {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            border: 1.5px solid #fed7aa;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        }

        /* Orange Top Banner (Matches Image 1 Frame 2) */
        .service-header-banner {
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: #ffffff;
            padding: 22px;
            text-align: center;
            position: relative;
        }

        .service-header-banner h3 {
            margin: 0;
            font-size: 17px;
            font-weight: 800;
            letter-spacing: 0.5px;
        }

        .banner-back-arrow {
            position: absolute;
            left: 20px;
            top: 20px;
            color: #ffffff;
            text-decoration: none;
            font-size: 20px;
            font-weight: 800;
        }

        .form-body-wrapper {
            padding: 28px 32px;
        }

        /* Image Upload Box */
        .upload-icon-box {
            border: 1.5px dashed #cbd5e1;
            border-radius: 14px;
            padding: 20px;
            text-align: center;
            background: #f8fafc;
            margin-bottom: 20px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .upload-icon-box:hover {
            border-color: #ea580c;
            background: #fffaf5;
        }

        .upload-arrow {
            font-size: 24px;
            color: #ea580c;
            margin-bottom: 4px;
        }

        .upload-title {
            font-size: 13.5px;
            font-weight: 700;
            color: #1e293b;
            margin: 0 0 2px 0;
        }

        .upload-hint {
            font-size: 11.5px;
            color: #94a3b8;
            margin: 0;
        }

        /* Form Fields */
        .form-group {
            margin-bottom: 16px;
        }

        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #475569;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 10px;
            font-size: 13.5px;
            color: #1e293b;
            background: #ffffff;
            box-sizing: border-box;
            outline: none;
            font-family: inherit;
        }

        .form-control:focus {
            border-color: #ea580c;
        }

        .form-row-2col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        /* Make Service Active Toggle Box */
        .toggle-status-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 16px;
            margin: 20px 0;
        }

        .toggle-text-left h5 {
            margin: 0 0 2px 0;
            font-size: 13.5px;
            font-weight: 800;
            color: #0f172a;
        }

        .toggle-text-left span {
            font-size: 11.5px;
            color: #64748b;
        }

        /* Save Button */
        .btn-save-service-main {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 14px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.25);
        }

        .btn-save-service-main:hover {
            background: #c2410c;
        }

        .alert-box {
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .alert-success { background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-error { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="add-service-container">
        
        <div class="service-form-card">
            
            <!-- Orange Banner Header (Exact Match Image 1 Frame 2) -->
            <div class="service-header-banner">
                <a href="ManageServices.aspx" class="banner-back-arrow">&larr;</a>
                <h3>Add New Service</h3>
            </div>

            <div class="form-body-wrapper">
                
                <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                    <div class='alert-box <%= AlertType == "success" ? "alert-success" : "alert-error" %>'>
                        <asp:Label ID="lblAlert" runat="server"></asp:Label>
                    </div>
                </asp:Panel>

                <!-- Upload Service Image / Icon Box -->
                <div class="upload-icon-box" style="text-align: left; padding: 18px 20px;">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 10px;">
                        <span style="font-size: 26px;">&#128247;</span>
                        <div>
                            <div class="upload-title" style="margin: 0; font-size: 14px; font-weight: 700;">Upload Service Photo</div>
                            <div class="upload-hint" style="margin: 0; font-size: 11.5px; color: #64748b;">JPG, PNG, WEBP from your computer</div>
                        </div>
                    </div>
                    <asp:FileUpload ID="fuServiceImage" runat="server" CssClass="form-control" accept=".jpg,.jpeg,.png,.webp" />
                </div>

                <!-- Service Name -->
                <div class="form-group">
                    <label class="form-label">Service Name *</label>
                    <asp:TextBox ID="txtServiceName" runat="server" CssClass="form-control" Placeholder="e.g. Premium Ceramic Coating"></asp:TextBox>
                </div>

                <!-- Category Dropdown -->
                <div class="form-group">
                    <label class="form-label">Category *</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Category" Value=""></asp:ListItem>
                        <asp:ListItem Text="Protection (PPF)" Value="Protection (PPF)"></asp:ListItem>
                        <asp:ListItem Text="Ceramic Coating" Value="Ceramic Coating"></asp:ListItem>
                        <asp:ListItem Text="Correction" Value="Correction"></asp:ListItem>
                        <asp:ListItem Text="Spa & Detailing" Value="Spa & Detailing"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Price and Duration (2-Col) -->
                <div class="form-row-2col">
                    <div class="form-group">
                        <label class="form-label">Price (&#8377;) *</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" Placeholder="e.g. 599"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Est. Duration *</label>
                        <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" Placeholder="e.g. 2 - 3 Hours"></asp:TextBox>
                    </div>
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label class="form-label">Description *</label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" Placeholder="Enter a brief description of the detailing service..."></asp:TextBox>
                </div>

                <!-- Make Service Active Toggle -->
                <div class="toggle-status-box">
                    <div class="toggle-text-left">
                        <h5>Make Service Active</h5>
                        <span>Active services will appear immediately on user website</span>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkIsActive" runat="server" Checked="true" style="transform: scale(1.4); accent-color: #10b981; cursor: pointer;" />
                    </div>
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnSaveService" runat="server" Text="SAVE SERVICE" CssClass="btn-save-service-main" OnClick="btnSaveService_Click" />

            </div>

        </div>

    </div>
</asp:Content>
