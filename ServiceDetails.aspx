<%@ Page Title="Service Details" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ServiceDetails.aspx.cs" Inherits="creation_car_care.ServiceDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width: 1150px; margin: 20px auto; padding: 0 15px;">
        
        <!-- Breadcrumb -->
        <div style="font-size: 14px; color: #666; margin-bottom: 20px;">
            <a href="ServicesList.aspx" style="color: #ff9800; text-decoration: none;">Services</a> > <span style="color: #e65100; font-weight: bold;"><asp:Label ID="lblBreadcrumbName" runat="server" Text="Service"></asp:Label></span>
        </div>

        <!-- Main Layout -->
        <div style="display: flex; gap: 30px; align-items: flex-start; flex-wrap: wrap;">
            
            <!-- Left Side Details -->
            <div style="flex: 2; background: #fff; padding: 30px; border-radius: 12px; border: 1px solid #f0e6d2; box-shadow: 0 2px 10px rgba(0,0,0,0.02); min-width: 300px;">
                
                <!-- Service Feature Banner Image -->
                <div style="position: relative; width: 100%; height: 320px; border-radius: 14px; overflow: hidden; margin-bottom: 25px; border: 1.5px solid #fed7aa; box-shadow: 0 4px 16px rgba(234, 88, 12, 0.08); background: #f8fafc;">
                    <asp:Image ID="imgService" runat="server" style="width: 100%; height: 100%; object-fit: cover; display: block;" AlternateText="Service Photo" />
                    <div style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(to top, rgba(0,0,0,0.75), transparent); padding: 16px 20px; color: #ffffff; display: flex; align-items: center; justify-content: space-between;">
                        <span style="font-size: 13.5px; font-weight: 700; color: #ffedd5; letter-spacing: 0.5px;">&#10024; Studio Premium Detailing</span>
                        <span style="font-size: 12px; font-weight: 600; color: #ffffff; background: rgba(234, 88, 12, 0.9); padding: 4px 12px; border-radius: 6px;"><asp:Label ID="lblGalleryTitle" runat="server" Text="Service Gallery"></asp:Label></span>
                    </div>
                </div>

                <div style="display: flex; align-items: center; gap: 12px; margin-top: 0; margin-bottom: 14px; flex-wrap: wrap;">
                    <h2 style="color: #111827; font-size: 24px; font-weight: 800; margin: 0;"><asp:Label ID="lblServiceName" runat="server" Text="Service Name"></asp:Label></h2>
                    <span style="background: #fef3c7; color: #b45309; font-size: 13px; font-weight: 800; padding: 4px 10px; border-radius: 6px; border: 1px solid #fde68a;">&#9733; <asp:Label ID="lblRating" runat="server" Text="4.8"></asp:Label></span>
                    <span style="background: #f1f5f9; color: #64748b; font-size: 12px; font-weight: 700; padding: 4px 10px; border-radius: 6px;"><asp:Label ID="lblCategory" runat="server" Text="Detailing"></asp:Label></span>
                </div>
                
                <p style="color: #666; font-size: 14px; line-height: 1.6; margin-bottom: 25px;">
                    <asp:Label ID="lblDescription" runat="server" Text="Service description goes here..."></asp:Label>
                </p>

                <h4 style="color: #111; font-size: 16px; margin-bottom: 15px;">What's Included in this Package:</h4>
                <ul style="list-style: none; padding: 0; margin: 0; font-size: 14px; color: #444; line-height: 2;">
                    <li>Complete Multi-Stage Professional Treatment</li>
                    <li>High-Quality Material Application</li>
                    <li>Inspection & Quality Check</li>
                    <li>Standard Warranty Support</li>
                </ul>

                <!-- Customer Reviews & Feedback Section -->
                <hr style="border: none; border-top: 1.5px solid #f1f5f9; margin: 30px 0 24px 0;" />
                
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 12px;">
                    <div>
                        <h3 style="color: #111827; font-size: 18px; font-weight: 800; margin: 0 0 4px 0;">Customer Reviews &amp; Feedback</h3>
                        <p style="color: #64748b; font-size: 12.5px; margin: 0;">Verified detailing experiences from studio car owners</p>
                    </div>
                    <div style="display: flex; align-items: center; gap: 8px; background: #fff7ed; border: 1.5px solid #fed7aa; padding: 6px 14px; border-radius: 20px;">
                        <span style="color: #f59e0b; font-size: 16px;">&#9733;</span>
                        <span style="font-size: 14.5px; font-weight: 800; color: #ea580c;"><asp:Label ID="lblAvgRatingHeader" runat="server" Text="4.8"></asp:Label> / 5.0</span>
                        <span style="font-size: 12px; color: #9a3412; font-weight: 600;">(<asp:Label ID="lblTotalReviewsCount" runat="server" Text="0"></asp:Label> reviews)</span>
                    </div>
                </div>

                <!-- Verified Reviews Repeater -->
                <asp:Repeater ID="rptReviews" runat="server">
                    <ItemTemplate>
                        <div style="background: #fafaf9; border: 1px solid #f5f5f4; border-radius: 12px; padding: 16px 18px; margin-bottom: 14px; transition: transform 0.15s ease;">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px; flex-wrap: wrap; gap: 8px;">
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <div style="width: 38px; height: 38px; border-radius: 50%; background: linear-gradient(135deg, #ea580c, #f97316); color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 14px; overflow: hidden; flex-shrink: 0; box-shadow: 0 2px 6px rgba(234, 88, 12, 0.2);">
                                        <%# Eval("ProfileImage") != DBNull.Value && !string.IsNullOrEmpty(Eval("ProfileImage").ToString()) ? 
                                            "<img src='" + ResolveUrl(Eval("ProfileImage").ToString()) + "' style='width:100%; height:100%; object-fit:cover;' />" : 
                                            GetAvatarInitial(Eval("CustomerName").ToString()) 
                                        %>
                                    </div>
                                    <div>
                                        <div style="font-size: 13.5px; font-weight: 800; color: #1c1917; display: flex; align-items: center; gap: 6px;">
                                            <span><%# Eval("CustomerName") %></span>
                                            <span style="font-size: 10px; background: #dcfce7; color: #166534; padding: 2px 6px; border-radius: 4px; font-weight: 700; border: 1px solid #bbf7d0;">&#10004; Verified Customer</span>
                                        </div>
                                        <div style="font-size: 11.5px; color: #a8a29e; margin-top: 2px;">
                                            Delivered on <%# string.Format("{0:dd MMM yyyy}", Eval("SlotDate")) %>
                                        </div>
                                    </div>
                                </div>
                                <div style="color: #f59e0b; font-size: 15px; letter-spacing: 1px;">
                                    <%# GetStarsHtml(Eval("Rating")) %>
                                </div>
                            </div>
                            <div style="font-size: 13px; color: #44403c; line-height: 1.5; margin-left: 50px; background: #ffffff; padding: 10px 14px; border-radius: 8px; border: 1px solid #e7e5e4;">
                                <%# Eval("ReviewText") != DBNull.Value && !string.IsNullOrEmpty(Eval("ReviewText").ToString()) ? 
                                    Eval("ReviewText") : 
                                    "Rated " + Eval("Rating") + " Stars for outstanding studio detailing quality and vehicle care." 
                                %>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- Empty State If No Reviews Yet -->
                <asp:Panel ID="pnlNoReviews" runat="server" Visible="false" style="text-align: center; padding: 24px 20px; background: #fafaf9; border: 1.5px dashed #e7e5e4; border-radius: 12px;">
                    <span style="font-size: 30px; display: block; margin-bottom: 6px;">&#11088;</span>
                    <div style="font-size: 13.5px; font-weight: 700; color: #44403c; margin-bottom: 4px;">No customer reviews yet for this package</div>
                    <p style="font-size: 12px; color: #78716c; margin: 0;">Be the first studio customer to book this treatment and share your feedback!</p>
                </asp:Panel>
            </div>

            <!-- Right Side Pricing & Booking Box -->
            <div style="flex: 1; background: #fff; padding: 30px; border-radius: 12px; border: 1px solid #f0e6d2; box-shadow: 0 2px 10px rgba(0,0,0,0.02); min-width: 280px;">
                
                <!-- Offer Notice Box -->
                <asp:Panel ID="pnlOfferNotice" runat="server" Visible="false" style="background: #ecfdf5; border: 1px solid #a7f3d0; border-radius: 8px; padding: 10px 14px; margin-bottom: 15px;">
                    <span style="font-size: 13px; font-weight: bold; color: #065f46;">
                        &#127881; <asp:Label ID="lblOfferNotice" runat="server"></asp:Label>
                    </span>
                </asp:Panel>

                <div style="font-size: 12px; color: #888; text-transform: uppercase; font-weight: bold; margin-bottom: 5px;">Package Pricing</div>
                <div style="margin-bottom: 20px;">
                    <asp:Literal ID="litPriceDisplay" runat="server"></asp:Literal>
                    <asp:Label ID="lblPrice" runat="server" Visible="false"></asp:Label>
                </div>

                <div style="display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap;">
                    <span style="background: #fff8e1; color: #f57c00; padding: 8px 12px; border-radius: 6px; font-size: 12px; font-weight: bold; border: 1px solid #ffe0b2;">&#9201; <asp:Label ID="lblDuration" runat="server" Text="Duration"></asp:Label></span>
                    <span style="background: #fff8e1; color: #f57c00; padding: 8px 12px; border-radius: 6px; font-size: 12px; font-weight: bold; border: 1px solid #ffe0b2;">&#128737; <asp:Label ID="lblWarranty" runat="server" Text="Warranty"></asp:Label></span>
                </div>

                <hr style="border: none; border-top: 1px solid #eee; margin-bottom: 20px;" />

                <asp:Button ID="btnBook" runat="server" Text="BOOK THIS SERVICE NOW" OnClick="btnBook_Click" style="background: #ea580c; color: #fff; border: none; padding: 14px; width: 100%; font-size: 14px; border-radius: 8px; cursor: pointer; font-weight: bold; text-align: center; margin-bottom: 10px;" />
                <asp:Button ID="btnWishlist" runat="server" Text="&#9825; Wishlist" OnClick="btnWishlist_Click" style="background: #ffffff; color: #ea580c; border: 1.5px solid #ea580c; padding: 11px; width: 100%; font-size: 13px; border-radius: 8px; cursor: pointer; font-weight: bold; text-align: center;" />
            </div>

        </div>
    </div>
</asp:Content>