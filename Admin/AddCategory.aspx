<%@ Page Title="Add New Category" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddCategory.aspx.cs" Inherits="creation_car_care.Admin.AddCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .add-cat-container {
            max-width: 860px;
            margin: 0 auto;
        }

        .cat-form-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        }

        .cat-form-grid {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 32px;
            margin-bottom: 28px;
        }

        @media (max-width: 768px) {
            .cat-form-grid {
                grid-template-columns: 1fr;
            }
        }

        .section-label-sub {
            font-size: 11.5px;
            font-weight: 800;
            color: #ea580c;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: 16px;
        }

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

        /* Right Column: Icon Preview & Palette */
        .icon-preview-box {
            border: 1.5px dashed #cbd5e1;
            border-radius: 14px;
            padding: 20px;
            text-align: center;
            background: #f8fafc;
            margin-bottom: 20px;
        }

        .icon-symbol {
            font-size: 32px;
            margin-bottom: 6px;
        }

        .color-palette-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .color-dot {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid transparent;
            transition: transform 0.2s;
        }

        .color-dot:hover, .color-dot.active {
            transform: scale(1.15);
            border-color: #0f172a;
        }

        /* Tip Box */
        .tip-callout {
            background: #fffbeb;
            border: 1px solid #fef3c7;
            border-radius: 12px;
            padding: 14px 18px;
            font-size: 12.5px;
            color: #92400e;
            line-height: 1.4;
            margin-top: 16px;
        }

        /* Bottom Action Buttons */
        .form-bottom-actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 14px;
            border-top: 1px solid #f1f5f9;
            padding-top: 20px;
        }

        .btn-cancel-cat {
            padding: 11px 22px;
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 13.5px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
        }

        .btn-save-cat {
            padding: 11px 28px;
            background: #ea580c;
            color: #ffffff;
            border: none;
            border-radius: 10px;
            font-size: 13.5px;
            font-weight: 800;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: background 0.2s;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }

        .btn-save-cat:hover {
            background: #c2410c;
        }

        .alert-box {
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .alert-success { background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-error { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="add-cat-container">
        
        <asp:Panel ID="pnlAlert" runat="server" Visible="false">
            <div class='alert-box <%= AlertType == "success" ? "alert-success" : "alert-error" %>'>
                <asp:Label ID="lblAlert" runat="server"></asp:Label>
            </div>
        </asp:Panel>

        <div class="cat-form-card">
            
            <div class="cat-form-grid">
                
                <!-- Left Column: Category Details -->
                <div>
                    <div class="section-label-sub">Category Details</div>

                    <div class="form-group">
                        <label class="form-label">Category Name *</label>
                        <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" Placeholder="e.g. Glass & Windshield Detailing"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Display Order / Priority</label>
                        <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control" Text="5"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" Placeholder="Treatment for water marks, rain repellant glass coating..."></asp:TextBox>
                    </div>
                </div>

                <!-- Right Column: Icon & Accent Color (Exact Match Image 2 Frame 3) -->
                <div>
                    <div class="section-label-sub">Category Icon & Accent Color</div>

                    <!-- Icon Preview Box -->
                    <div class="icon-preview-box">
                        <div class="icon-symbol"><asp:Label ID="lblIconSymbol" runat="server" Text="✨"></asp:Label></div>
                        <div style="font-size: 13px; font-weight: 700; color: #0f172a; margin-bottom: 4px;">Choose Category Icon</div>
                        <asp:DropDownList ID="ddlIcon" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlIcon_SelectedIndexChanged">
                            <asp:ListItem Text="Shield (Protection PPF)" Value="&#128737;"></asp:ListItem>
                            <asp:ListItem Text="Sparkles (Ceramic)" Value="&#10024;"></asp:ListItem>
                            <asp:ListItem Text="Car (Restoration & Spa)" Value="&#128663;"></asp:ListItem>
                            <asp:ListItem Text="Water Droplet (Wash & Detailing)" Value="&#128167;"></asp:ListItem>
                            <asp:ListItem Text="Diamond (Luxury Coating)" Value="&#128142;"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Color Accent Selection -->
                    <div class="form-group">
                        <label class="form-label">Accent Theme Color</label>
                        <asp:DropDownList ID="ddlColorAccent" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Purple (#8b5cf6)" Value="#8b5cf6"></asp:ListItem>
                            <asp:ListItem Text="Orange (#ea580c)" Value="#ea580c"></asp:ListItem>
                            <asp:ListItem Text="Green (#10b981)" Value="#10b981"></asp:ListItem>
                            <asp:ListItem Text="Blue (#3b82f6)" Value="#3b82f6"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Active Toggle -->
                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 10px 0;">
                        <span style="font-size: 13px; font-weight: 700; color: #334155;">Category Status: ACTIVE</span>
                        <asp:CheckBox ID="chkIsActive" runat="server" Checked="true" style="transform: scale(1.3); accent-color: #10b981; cursor: pointer;" />
                    </div>

                    <!-- Quick Tip -->
                    <div class="tip-callout">
                        <strong>Quick Tip:</strong> Active categories appear immediately on the customer booking portal and category tab bar.
                    </div>
                </div>

            </div>

            <!-- Bottom Actions Bar -->
            <div class="form-bottom-actions">
                <a href="ManageCategories.aspx" class="btn-cancel-cat">Cancel</a>
                <asp:Button ID="btnSaveCategory" runat="server" Text="SAVE CATEGORY" CssClass="btn-save-cat" OnClick="btnSaveCategory_Click" />
            </div>

        </div>

    </div>
</asp:Content>
