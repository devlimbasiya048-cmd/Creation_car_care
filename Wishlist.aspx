<%@ Page Title="My Wishlist" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="creation_car_care.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .wishlist-wrapper {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .page-header {
            margin-bottom: 25px;
        }
        .page-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .page-header p {
            font-size: 14px;
            color: #6b7280;
            margin: 0;
        }
        .wishlist-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 16px;
            padding: 22px 26px;
            margin-bottom: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(234, 88, 12, 0.03);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .wishlist-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(234, 88, 12, 0.06);
        }
        .wishlist-info h3 {
            font-size: 18px;
            font-weight: 700;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .rating-badge {
            display: inline-block;
            font-size: 12px;
            color: #f59e0b;
            font-weight: bold;
            margin-bottom: 8px;
        }
        .wishlist-price {
            font-size: 17px;
            font-weight: 800;
            color: #ea580c;
            margin-bottom: 8px;
        }
        .wishlist-features {
            font-size: 11.5px;
            color: #9ca3af;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-weight: 600;
        }
        .wishlist-actions {
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .btn-trash {
            background: #ffffff;
            border: 1.5px solid #fed7aa;
            border-radius: 8px;
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #9ca3af;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-trash:hover {
            color: #ef4444;
            border-color: #fca5a5;
            background: #fef2f2;
        }
        .btn-move-cart {
            background: #ffffff;
            color: #ea580c;
            border: 1.5px solid #ea580c;
            padding: 9px 20px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-block;
        }
        .btn-move-cart:hover {
            background: #ea580c;
            color: #ffffff;
        }
        .empty-wishlist-card {
            background: #ffffff;
            border: 1.5px dashed #e5e7eb;
            border-radius: 16px;
            padding: 50px 20px;
            text-align: center;
        }
        .empty-wishlist-card h3 {
            font-size: 18px;
            color: #374151;
            margin-bottom: 8px;
        }
        .empty-wishlist-card p {
            font-size: 14px;
            color: #9ca3af;
            margin-bottom: 20px;
        }
        .btn-browse {
            background: #ea580c;
            color: #ffffff;
            padding: 10px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            font-size: 13px;
            display: inline-block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wishlist-wrapper">
        
        <!-- Page Title & Subtitle -->
        <div class="page-header">
            <h1>My Wishlist</h1>
            <p>Services you have saved for later bookings.</p>
        </div>

        <!-- Alert Notification Panel -->
        <asp:Label ID="lblMessage" runat="server" Visible="false" style="display: block; padding: 12px 18px; border-radius: 8px; margin-bottom: 20px; font-weight: bold;"></asp:Label>

        <!-- If Wishlist is Empty -->
        <asp:Panel ID="pnlEmptyWishlist" runat="server" Visible="false" CssClass="empty-wishlist-card">
            <span style="font-size: 40px; display: block; margin-bottom: 10px;">&#9825;</span>
            <h3>Your wishlist is empty!</h3>
            <p>Save services you want to book in the future for quick access.</p>
            <a href="ServicesList.aspx" class="btn-browse">Explore Services &rarr;</a>
        </asp:Panel>

        <!-- Repeater for Wishlist Items -->
        <asp:Repeater ID="rptWishlist" runat="server" OnItemCommand="rptWishlist_ItemCommand">
            <ItemTemplate>
                <div class="wishlist-card">
                    
                    <!-- Left Side Service Details -->
                    <div class="wishlist-info">
                        <h3><%# Eval("ServiceName") %></h3>
                        <div class="rating-badge">&#9733; 4.8 (120 reviews)</div>
                        <div class="wishlist-price">
                            &#8377;<%# string.Format("{0:N0}", Eval("Price")) %> &bull; <span style="font-size: 13px; font-weight: 500; color: #6b7280;">1 Session</span>
                        </div>
                        <div class="wishlist-features">
                            <%# Eval("ShortDescription") %>
                        </div>
                    </div>

                    <!-- Right Side Actions -->
                    <div class="wishlist-actions">
                        <!-- Trash / Delete Button -->
                        <asp:LinkButton ID="btnDelete" runat="server" 
                            CommandName="DeleteWishlist" 
                            CommandArgument='<%# Eval("WishlistId") %>' 
                            CssClass="btn-trash" 
                            ToolTip="Remove from wishlist">
                            &#128465;
                        </asp:LinkButton>

                        <!-- Move to Cart Button -->
                        <asp:LinkButton ID="btnMoveToCart" runat="server" 
                            CommandName="MoveToCart" 
                            CommandArgument='<%# Eval("WishlistId") + "|" + Eval("ServiceId") %>' 
                            CssClass="btn-move-cart">
                            Move to Cart
                        </asp:LinkButton>
                    </div>

                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
