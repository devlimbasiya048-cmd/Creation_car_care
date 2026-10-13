<%@ Page Title="Add New Vehicle - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddVehicle.aspx.cs" Inherits="creation_car_care.AddVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .add-veh-wrapper {
            max-width: 580px;
            margin: 35px auto;
            padding: 0 15px;
        }
        .add-veh-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 24px;
            padding: 38px 36px;
            box-shadow: 0 8px 30px rgba(234, 88, 12, 0.06);
        }
        .add-veh-header {
            margin-bottom: 25px;
        }
        .add-veh-header h1 {
            font-size: 24px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .add-veh-header p {
            font-size: 13.5px;
            color: #6b7280;
            margin: 0;
        }
        /* Toggle Car vs Bike */
        .type-toggle-bar {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 22px;
        }
        .type-toggle-btn {
            padding: 12px;
            border-radius: 10px;
            border: 1.5px solid #e5e7eb;
            background: #ffffff;
            color: #374151;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .type-toggle-btn.active {
            border: 2px solid #ea580c;
            background: #fff7ed;
            color: #ea580c;
        }
        /* Form fields */
        .form-group {
            margin-bottom: 18px;
        }
        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 800;
            color: #4b5563;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 6px;
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
        /* Plate input with IND badge */
        .plate-input-wrap {
            display: flex;
            align-items: stretch;
            border: 1.5px solid #93c5fd;
            border-radius: 10px;
            overflow: hidden;
            background: #ffffff;
        }
        .plate-ind-tag {
            background: #2563eb;
            color: #ffffff;
            font-size: 11px;
            font-weight: 800;
            padding: 12px 12px;
            display: flex;
            align-items: center;
            letter-spacing: 0.5px;
        }
        .plate-input-field {
            flex: 1;
            border: none;
            padding: 12px 14px;
            font-size: 15px;
            font-family: monospace;
            font-weight: 800;
            color: #1e3a8a;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }
        .plate-input-field:focus {
            outline: none;
        }
        /* Switch Toggle */
        .primary-switch-wrap {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 22px 0 28px 0;
            padding: 12px 0;
            border-top: 1px dashed #fed7aa;
            border-bottom: 1px dashed #fed7aa;
        }
        .primary-switch-lbl {
            font-size: 13.5px;
            font-weight: 700;
            color: #111827;
        }
        .btn-save-veh {
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
            margin-bottom: 12px;
        }
        .btn-save-veh:hover {
            background: #c2410c;
        }
        .btn-cancel-veh {
            display: block;
            width: 100%;
            background: #ffffff;
            color: #6b7280;
            border: 1.5px solid #d1d5db;
            padding: 12px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            text-align: center;
            box-sizing: border-box;
            transition: all 0.2s;
        }
        .btn-cancel-veh:hover {
            color: #111827;
            border-color: #9ca3af;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="add-veh-wrapper">
        <div class="add-veh-card">
            
            <div class="add-veh-header">
                <h1><asp:Label ID="lblPageTitle" runat="server" Text="Add New Vehicle"></asp:Label></h1>
                <p>Enter your vehicle details to link it with your account for fast bookings.</p>
            </div>

            <!-- Error / Validation label -->
            <asp:Label ID="lblError" runat="server" Visible="false" style="display: block; background: #fee2e2; color: #991b1b; padding: 10px; border-radius: 8px; margin-bottom: 18px; font-size: 13px; font-weight: bold;"></asp:Label>

            <!-- Vehicle Type Toggle Bar (Car vs Bike) -->
            <div class="type-toggle-bar">
                <asp:LinkButton ID="btnTypeCar" runat="server" OnClick="btnTypeCar_Click" CssClass="type-toggle-btn active">
                    &#128663; Car
                </asp:LinkButton>
                <asp:LinkButton ID="btnTypeBike" runat="server" OnClick="btnTypeBike_Click" CssClass="type-toggle-btn">
                    &#127949; Bike
                </asp:LinkButton>
            </div>

            <asp:HiddenField ID="hfVehicleType" runat="server" Value="Car" />

            <!-- Brand Field -->
            <div class="form-group">
                <label class="form-label">Brand</label>
                <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-input">
                    <asp:ListItem Text="Hyundai" Value="Hyundai" />
                    <asp:ListItem Text="Tata Motors" Value="Tata" />
                    <asp:ListItem Text="Mahindra" Value="Mahindra" />
                    <asp:ListItem Text="Maruti Suzuki" Value="Maruti Suzuki" />
                    <asp:ListItem Text="Honda" Value="Honda" />
                    <asp:ListItem Text="Toyota" Value="Toyota" />
                    <asp:ListItem Text="Kia" Value="Kia" />
                    <asp:ListItem Text="Royal Enfield" Value="Royal Enfield" />
                    <asp:ListItem Text="Other Brand" Value="Other" />
                </asp:DropDownList>
            </div>

            <!-- Model Name Field -->
            <div class="form-group">
                <label class="form-label">Model Name</label>
                <asp:TextBox ID="txtModelName" runat="server" CssClass="form-input" placeholder="e.g. Creta / Swift / Classic 350"></asp:TextBox>
            </div>

            <!-- Color Field -->
            <div class="form-group">
                <label class="form-label">Vehicle Color</label>
                <asp:TextBox ID="txtColor" runat="server" CssClass="form-input" placeholder="e.g. White Color / Black Color"></asp:TextBox>
            </div>

            <!-- Registration Number Field -->
            <div class="form-group">
                <label class="form-label">Registration Number</label>
                <div class="plate-input-wrap">
                    <span class="plate-ind-tag">IND</span>
                    <asp:TextBox ID="txtRegNumber" runat="server" CssClass="plate-input-field" placeholder="GJ 03 AB 1234"></asp:TextBox>
                </div>
            </div>

            <!-- Set as Primary Toggle -->
            <div class="primary-switch-wrap">
                <span class="primary-switch-lbl">Set as primary vehicle</span>
                <asp:CheckBox ID="chkIsPrimary" runat="server" Checked="true" style="transform: scale(1.3); cursor: pointer;" />
            </div>

            <!-- Submit & Cancel Buttons -->
            <asp:Button ID="btnSaveVehicle" runat="server" Text="SAVE VEHICLE" OnClick="btnSaveVehicle_Click" CssClass="btn-save-veh" />
            <a href="Vehicles.aspx" class="btn-cancel-veh">Cancel</a>

        </div>
    </div>
</asp:Content>
