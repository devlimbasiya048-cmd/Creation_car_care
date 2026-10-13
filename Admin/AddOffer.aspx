<%@ Page Title="Add New Offer" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddOffer.aspx.cs" Inherits="creation_car_care.Admin.AddOffer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .add-offer-container {
            max-width: 540px;
            margin: 0 auto;
        }

        .offer-form-card {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            border: 1.5px solid #fed7aa;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        }

        /* Orange Banner Header (Exact Match Image 1 Frame 4) */
        .offer-header-banner {
            background: linear-gradient(135deg, #ea580c, #f97316);
            color: #ffffff;
            padding: 22px;
            text-align: center;
            position: relative;
        }

        .offer-header-banner h3 {
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
            padding: 30px 32px;
        }

        .form-group {
            margin-bottom: 18px;
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
            padding: 12px 14px;
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

        .btn-publish-offer {
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
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.25);
        }

        .btn-publish-offer:hover {
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
    <div class="add-offer-container">
        
        <div class="offer-form-card">
            
            <!-- Orange Banner Header -->
            <div class="offer-header-banner">
                <a href="ManageOffers.aspx" class="banner-back-arrow">&larr;</a>
                <h3>Add New Offer</h3>
            </div>

            <div class="form-body-wrapper">
                
                <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                    <div class='alert-box <%= AlertType == "success" ? "alert-success" : "alert-error" %>'>
                        <asp:Label ID="lblAlert" runat="server"></asp:Label>
                    </div>
                </asp:Panel>

                <!-- PROMO CODE -->
                <div class="form-group">
                    <label class="form-label">PROMO CODE *</label>
                    <asp:TextBox ID="txtPromoCode" runat="server" CssClass="form-control" Placeholder="e.g. FESTIVE20"></asp:TextBox>
                </div>

                <!-- OFFER TITLE -->
                <div class="form-group">
                    <label class="form-label">OFFER TITLE *</label>
                    <asp:TextBox ID="txtOfferTitle" runat="server" CssClass="form-control" Placeholder="e.g. 20% OFF on Complete Detailing"></asp:TextBox>
                </div>

                <!-- DISCOUNT VALUE -->
                <div class="form-group">
                    <label class="form-label">DISCOUNT VALUE *</label>
                    <asp:TextBox ID="txtDiscountValue" runat="server" CssClass="form-control" Placeholder="e.g. 20% OFF or ₹500 OFF"></asp:TextBox>
                </div>

                <!-- OFFER VALIDITY / DESCRIPTION -->
                <div class="form-group">
                    <label class="form-label">OFFER VALIDITY / DESCRIPTION *</label>
                    <asp:TextBox ID="txtOfferDesc" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" Placeholder="e.g. Valid on all sedan & SUV vehicles until 31st Oct. Minimum spend ₹3,000 required."></asp:TextBox>
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnPublishOffer" runat="server" Text="PUBLISH LIVE OFFER" CssClass="btn-publish-offer" OnClick="btnPublishOffer_Click" />

            </div>

        </div>

    </div>
</asp:Content>
