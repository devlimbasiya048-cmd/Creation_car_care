<%@ Page Title="Category Management" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageCategories.aspx.cs" Inherits="creation_car_care.Admin.ManageCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cat-mgmt-container {
            max-width: 1050px;
            margin: 0 auto;
        }

        /* Top Action Button */
        .btn-add-cat-nav {
            background: #111827;
            color: #ffffff;
            border: none;
            padding: 12px 22px;
            border-radius: 12px;
            font-size: 13.5px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            margin-bottom: 24px;
        }

        .btn-add-cat-nav:hover {
            background: #000000;
            transform: translateY(-1px);
        }

        /* 2x2 Grid of Category Cards */
        .categories-2x2-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        @media (max-width: 768px) {
            .categories-2x2-grid {
                grid-template-columns: 1fr;
            }
        }

        .cat-card-item {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px 26px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: all 0.2s ease;
        }

        .cat-card-item:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
        }

        .cat-card-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .cat-icon-badge {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            flex-shrink: 0;
            line-height: 1;
        }

        .cat-info-text h4 {
            margin: 0 0 4px 0;
            font-size: 15.5px;
            font-weight: 800;
            color: #0f172a;
        }

        .cat-info-text span {
            font-size: 12.5px;
            color: #64748b;
            font-weight: 500;
        }

        .cat-card-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* Toggle Button */
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

        .btn-delete-cat {
            color: #ef4444;
            font-size: 15px;
            padding: 6px;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cat-mgmt-container">
        
        <!-- Action Button (Exact Match Image 2 Frame 2) -->
        <a href="AddCategory.aspx" class="btn-add-cat-nav">
            <span>&#43;</span> Add New Category
        </a>

        <!-- 2x2 Categories Grid -->
        <asp:Repeater ID="rptCategories" runat="server" OnItemCommand="rptCategories_ItemCommand">
            <HeaderTemplate>
                <div class="categories-2x2-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="cat-card-item">
                    <div class="cat-card-left">
                        <div class="cat-icon-badge" style='background-color: <%# Eval("ColorAccentLight") %>; border: 1.5px solid <%# Eval("ColorAccentBorder") %>;'>
                            <%# GetCleanCategoryIcon(Eval("Icon").ToString(), Eval("CategoryName").ToString()) %>
                        </div>
                        <div class="cat-info-text">
                            <h4><%# Eval("CategoryName") %></h4>
                            <span><%# Eval("ServicesCount") %> Services Available</span>
                        </div>
                    </div>

                    <div class="cat-card-right">
                        <!-- Active Toggle Switch -->
                        <asp:LinkButton ID="btnToggleActive" runat="server" 
                            CommandName="ToggleCat" 
                            CommandArgument='<%# Eval("CategoryId") %>'
                            CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "toggle-switch-btn toggle-on" : "toggle-switch-btn toggle-off" %>'>
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "&#9679; ON" : "&#9675; OFF" %>
                        </asp:LinkButton>

                        <!-- Delete -->
                        <asp:LinkButton ID="btnDelete" runat="server" 
                            CommandName="DeleteCat" 
                            CommandArgument='<%# Eval("CategoryId") %>'
                            CssClass="btn-delete-cat" 
                            OnClientClick="return confirm('Delete this category?');" 
                            ToolTip="Delete Category">
                            &#128465;
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
