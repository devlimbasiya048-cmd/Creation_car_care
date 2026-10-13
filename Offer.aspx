<%@ Page Title="Offers" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Offer.aspx.cs" Inherits="creation_car_care.Offer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 1150px; margin: 20px auto; padding: 0 15px;">
        
        <!-- Page Title & Subtitle -->
        <div style="margin-bottom: 25px;">
            <h1 style="color: #111; font-size: 26px; margin: 0 0 5px 0;">Active Special Offer</h1>
            <p style="color: #666; font-size: 14px; margin: 0;">Explore our running festive discount. Please login to apply discount and book your service.</p>
        </div>

        <!-- Active Offer Banner -->
        <asp:Panel ID="pnlCurrentActiveOffer" runat="server" Visible="false" style="background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%); border: 1.5px solid #10b981; border-radius: 12px; padding: 16px 22px; margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 15px rgba(16, 185, 129, 0.08);">
            <div style="display: flex; align-items: center; gap: 12px;">
                <span style="font-size: 24px;">&#127881;</span>
                <div>
                    <div style="font-size: 15px; font-weight: bold; color: #065f46;">
                        Offer Currently Active: <asp:Label ID="lblCurrentOfferTitle" runat="server"></asp:Label> (<asp:Label ID="lblCurrentOfferDiscount" runat="server"></asp:Label>% OFF)
                    </div>
                    <div style="font-size: 13px; color: #047857;">
                        You have an active festival discount applied! Go to services to book with discounted rates.
                    </div>
                </div>
            </div>
            <div style="display: flex; gap: 10px;">
                <a href="ServicesList.aspx" style="background: #10b981; color: white; padding: 8px 18px; border-radius: 6px; font-size: 13px; font-weight: bold; text-decoration: none;">View Services &rarr;</a>
                <asp:LinkButton ID="btnRemoveOffer" runat="server" OnClick="btnRemoveOffer_Click" style="background: white; color: #ef4444; border: 1px solid #fca5a5; padding: 8px 14px; border-radius: 6px; font-size: 13px; font-weight: bold; text-decoration: none;">&times; Clear</asp:LinkButton>
            </div>
        </asp:Panel>

        <!-- Dynamic Offers Grid using Repeater -->
        <div style="display: flex; flex-wrap: wrap; gap: 25px;">
            <asp:Repeater ID="rptOffers" runat="server" OnItemCommand="rptOffers_ItemCommand">
                <ItemTemplate>
                    <div style="background: #fff; border-radius: 12px; border: 1px solid #f0e6d2; width: 550px; max-width: 100%; display: flex; flex-wrap: wrap; padding: 25px; box-sizing: border-box; box-shadow: 0 2px 10px rgba(0,0,0,0.02); align-items: center; gap: 15px;">
                        
                        <!-- Left Discount Badge Box -->
                        <div style="background: #fff8ec; border: 1px dashed #ffb74d; border-radius: 10px; width: 140px; padding: 20px 10px; text-align: center; margin-right: 20px; flex-shrink: 0;">
                            <div style="font-size: 32px; font-weight: bold; color: #ff9800; line-height: 1;"><%# Eval("DiscountPercentage") %></div>
                            <div style="font-size: 11px; font-weight: bold; color: #f57c00; text-transform: uppercase; margin-top: 5px;">OFF</div>
                            <div style="font-size: 10px; color: #888; margin-top: 8px; text-transform: uppercase; font-weight: bold;">FESTIVAL DEAL</div>
                        </div>

                        <!-- Right Offer Details Box -->
                        <div style="flex-grow: 1;">
                            <h3 style="color: #111; font-size: 18px; margin: 0 0 5px 0;"><%# Eval("OfferTitle") %></h3>
                            <div style="color: #ff9800; font-weight: bold; font-size: 14px; margin-bottom: 8px;"><%# Eval("OfferDescription") %></div>
                            <p style="color: #4b5563; font-size: 13px; line-height: 1.5; margin: 0 0 10px 0; font-weight: 600;"><%# Eval("ValidityDisplay") %></p>
                            
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <!-- Dynamic Status with color and clean CSS dot -->
                                <span style="display: inline-flex; align-items: center; gap: 6px; color: <%# Eval("StatusColor") %>; font-size: 12px; font-weight: bold;">
                                    <span style='width: 8px; height: 8px; border-radius: 50%; background-color: <%# Eval("StatusColor") %>; display: inline-block;'></span>
                                    <%# Eval("CalculatedStatus") %>
                                </span>
                                
                                <!-- LinkButton to Claim Offer and redirect to Services -->
                                <asp:LinkButton ID="btnBookOffer" runat="server" 
                                    CommandName="ClaimOffer" 
                                    CommandArgument='<%# Eval("OfferId") %>'
                                    Enabled='<%# Eval("IsActive").ToString() == "True" %>'
                                    style='<%# Eval("IsActive").ToString() == "True" ? "background: #ff9800; color: #fff; padding: 9px 22px; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 13px; display: inline-block; border: none; cursor: pointer;" : "background: #ccc; color: #666; padding: 9px 22px; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 13px; pointer-events: none; display: inline-block; border: none;" %>'>
                                    <%# Eval("IsActive").ToString() == "True" ? "Book Now &rarr;" : "Upcoming" %>
                                </asp:LinkButton>
                            </div>
                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</asp:Content>