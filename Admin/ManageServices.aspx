<%@ Page Title="Manage Services" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageServices.aspx.cs" Inherits="creation_car_care.Admin.ManageServices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .services-mgmt-container {
            max-width: 1100px;
            margin: 0 auto;
        }

        /* Top Action Bar (Matches Figma Screenshot 5 Frame 3) */
        .services-top-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .btn-add-service-main {
            background: #111827;
            color: #ffffff;
            border: none;
            padding: 12px 22px;
            border-radius: 12px;
            font-size: 13.5px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-add-service-main:hover {
            background: #000000;
            transform: translateY(-1px);
        }

        /* Category Filter Tabs (Matches Screenshot 5 Frame 3) */
        .category-filter-tabs {
            display: flex;
            align-items: center;
            gap: 10px;
            overflow-x: auto;
            padding-bottom: 4px;
        }

        .cat-tab-btn {
            padding: 10px 18px;
            border-radius: 25px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            color: #64748b;
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            transition: all 0.2s;
            cursor: pointer;
            white-space: nowrap;
        }

        .cat-tab-btn:hover {
            color: #0f172a;
            border-color: #cbd5e1;
        }

        .cat-tab-btn.active {
            background: #ea580c;
            color: #ffffff;
            border-color: #ea580c;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
        }

        /* Add / Edit Form Card */
        .form-card {
            background: #ffffff;
            border: 1.5px solid #fed7aa;
            border-radius: 16px;
            padding: 24px 28px;
            margin-bottom: 28px;
            box-shadow: 0 4px 16px rgba(234, 88, 12, 0.06);
        }

        .form-card-title {
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 16px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 16px;
            margin-bottom: 16px;
        }

        .form-group label {
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
            padding: 10px 14px;
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

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 10px;
        }

        .btn-save-service {
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 11px 26px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-save-service:hover {
            background: #c2410c;
        }

        .btn-cancel-service {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            padding: 11px 20px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
        }

        /* Service Cards List (Exact Figma Screenshot 5 Frame 3 Match) */
        .services-list-grid {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .service-row-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: all 0.2s ease;
        }

        .service-row-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
        }

        .service-left-box {
            display: flex;
            align-items: center;
            gap: 16px;
            flex: 1;
        }

        .service-icon-box {
            width: 44px;
            height: 44px;
            background: #fff7ed;
            border: 1px solid #fed7aa;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .service-info h4 {
            margin: 0 0 4px 0;
            font-size: 15px;
            font-weight: 800;
            color: #0f172a;
        }

        .service-info p {
            margin: 0;
            font-size: 12.5px;
            color: #64748b;
            line-height: 1.4;
        }

        .service-category-tag {
            display: inline-block;
            font-size: 10.5px;
            font-weight: 700;
            color: #ea580c;
            background: #fff7ed;
            padding: 2px 8px;
            border-radius: 6px;
            margin-top: 4px;
            text-transform: uppercase;
        }

        .service-right-box {
            display: flex;
            align-items: center;
            gap: 24px;
            text-align: right;
        }

        .service-price-block {
            min-width: 110px;
        }

        .service-price-main {
            font-size: 17px;
            font-weight: 800;
            color: #ea580c;
            margin: 0;
        }

        .service-tax-sub {
            font-size: 11px;
            color: #94a3b8;
            font-weight: 600;
            margin: 0;
        }

        /* Toggle Button (Matches Toggle Switch in Screenshot) */
        .toggle-switch-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 800;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            border: none;
        }

        .toggle-on {
            background: #dcfce7;
            color: #15803d;
            border: 1.5px solid #86efac;
        }

        .toggle-off {
            background: #f1f5f9;
            color: #64748b;
            border: 1.5px solid #cbd5e1;
        }

        .btn-action-icon {
            background: #f8fafc;
            border: 1px solid #cbd5e1;
            color: #475569;
            padding: 6px 10px;
            border-radius: 8px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-action-icon:hover {
            background: #0f172a;
            color: #ffffff;
            border-color: #0f172a;
        }

        .btn-delete-icon:hover {
            background: #ef4444;
            color: #ffffff;
            border-color: #ef4444;
        }

        .alert-msg-bar {
            padding: 12px 18px;
            border-radius: 12px;
            font-size: 13.5px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .alert-success {
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="services-mgmt-container">

        <!-- Notification Message -->
        <asp:Panel ID="pnlMsg" runat="server" Visible="false">
            <div class='alert-msg-bar <%= MsgType == "success" ? "alert-success" : "alert-error" %>'>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
        </asp:Panel>

        <!-- Top Action Bar -->
        <div class="services-top-bar">
            <!-- Add New Service Button -->
            <asp:LinkButton ID="btnToggleAddForm" runat="server" CssClass="btn-add-service-main" OnClick="btnToggleAddForm_Click">
                <span>&#43;</span> Add New Service
            </asp:LinkButton>

            <!-- Category Filter Tabs -->
            <div class="category-filter-tabs">
                <asp:LinkButton ID="tabAll" runat="server" CssClass='<%= GetCategoryTabClass("") %>' OnClick="CategoryTab_Click" CommandArgument="">
                    Detailing [All]
                </asp:LinkButton>
                <asp:Repeater ID="rptCategoryTabs" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnTab" runat="server" 
                            CssClass='<%# GetCategoryTabClass(Eval("CategoryName").ToString()) %>' 
                            OnClick="CategoryTab_Click" 
                            CommandArgument='<%# Eval("CategoryName") %>'>
                            <%# Eval("CategoryName") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Add / Edit Service Form Panel (Expandable) -->
        <asp:Panel ID="pnlAddEditForm" runat="server" Visible="false" CssClass="form-card">
            <div class="form-card-title">
                <asp:Label ID="lblFormHeading" runat="server" Text="Add New Detailing Service"></asp:Label>
                <asp:HiddenField ID="hfEditingServiceId" runat="server" Value="0" />
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label>Service Name *</label>
                    <asp:TextBox ID="txtServiceName" runat="server" CssClass="form-control" Placeholder="e.g. Car Aroma Therapy + Wash"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Category *</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Correction" Value="Correction"></asp:ListItem>
                        <asp:ListItem Text="Protection (PPF)" Value="Protection (PPF)"></asp:ListItem>
                        <asp:ListItem Text="Ceramic Coating" Value="Ceramic Coating"></asp:ListItem>
                        <asp:ListItem Text="Spa & Detailing" Value="Spa & Detailing"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Price (&#8377;) *</label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" Placeholder="e.g. 599"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Duration</label>
                    <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" Placeholder="e.g. 2 - 3 Hours"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Warranty</label>
                    <asp:TextBox ID="txtWarranty" runat="server" CssClass="form-control" Placeholder="e.g. 1 Year Studio Warranty"></asp:TextBox>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 16px;">
                <label>Short Description *</label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" Placeholder="Describe key benefits and detailing process..."></asp:TextBox>
            </div>

            <div class="form-group" style="margin-bottom: 16px;">
                <label>Service Image / Photo</label>
                <div style="display: flex; gap: 16px; align-items: center; background: #fffaf5; border: 1.5px dashed #fed7aa; padding: 12px 16px; border-radius: 10px;">
                    <asp:Image ID="imgEditPreview" runat="server" style="width: 70px; height: 50px; object-fit: cover; border-radius: 8px; border: 1px solid #cbd5e1; display: none;" />
                    <div style="flex: 1;">
                        <asp:FileUpload ID="fuServiceImage" runat="server" CssClass="form-control" accept=".jpg,.jpeg,.png,.webp" />
                        <small style="color: #64748b; font-size: 11.5px; display: block; margin-top: 4px;">Upload new photo from your computer (.jpg, .png, .webp) to update this service image.</small>
                    </div>
                    <asp:HiddenField ID="hfExistingImageUrl" runat="server" Value="" />
                </div>
            </div>

            <div class="form-actions">
                <asp:Button ID="btnCancelForm" runat="server" Text="Cancel" CssClass="btn-cancel-service" OnClick="btnCancelForm_Click" CausesValidation="false" />
                <asp:Button ID="btnSaveService" runat="server" Text="Save Service" CssClass="btn-save-service" OnClick="btnSaveService_Click" />
            </div>
        </asp:Panel>

        <!-- Services List (Exact Match Screenshot 5 Frame 3) -->
        <asp:Repeater ID="rptServices" runat="server" OnItemCommand="rptServices_ItemCommand">
            <HeaderTemplate>
                <div class="services-list-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="service-row-card">
                    <div class="service-left-box">
                        <div class="service-icon-box" style="padding: 0; overflow: hidden; width: 50px; height: 50px; border-radius: 10px; border: 1.5px solid #fed7aa; flex-shrink: 0;">
                            <img src='<%# ResolveUrl(Eval("ImageUrl") != DBNull.Value && !string.IsNullOrEmpty(Eval("ImageUrl").ToString()) ? Eval("ImageUrl").ToString() : "~/Images/Services/default_service.jpg") %>' 
                                 alt="Service" style="width: 100%; height: 100%; object-fit: cover; display: block;" />
                        </div>
                        <div class="service-info">
                            <h4><%# Eval("ServiceName") %></h4>
                            <p><%# Eval("ShortDescription") %></p>
                            <span class="service-category-tag"><%# Eval("Category") %></span>
                        </div>
                    </div>

                    <div class="service-right-box">
                        <div class="service-price-block">
                            <h3 class="service-price-main">&#8377;<%# string.Format("{0:N0}", Eval("Price")) %></h3>
                            <p class="service-tax-sub">+18% taxes</p>
                        </div>

                        <!-- Active Toggle Button -->
                        <div>
                            <asp:LinkButton ID="btnToggleActive" runat="server" 
                                CommandName="ToggleActive" 
                                CommandArgument='<%# Eval("ServiceId") %>'
                                CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "toggle-switch-btn toggle-on" : "toggle-switch-btn toggle-off" %>'>
                                <%# Convert.ToBoolean(Eval("IsActive")) ? "&#9679; ACTIVE" : "&#9675; OFF" %>
                            </asp:LinkButton>
                        </div>

                        <!-- Edit & Delete Buttons -->
                        <div style="display: flex; gap: 6px;">
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditService" CommandArgument='<%# Eval("ServiceId") %>' CssClass="btn-action-icon" ToolTip="Edit Service">
                                &#9998;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteService" CommandArgument='<%# Eval("ServiceId") %>' CssClass="btn-action-icon btn-delete-icon" ToolTip="Delete Service" OnClientClick="return confirm('Are you sure you want to delete this service?');">
                                &#128465;
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>