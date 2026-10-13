<%@ Page Title="My Vehicles - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Vehicles.aspx.cs" Inherits="creation_car_care.Vehicles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .vehicles-wrapper {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .vehicles-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .vehicles-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .vehicles-header p {
            font-size: 14px;
            color: #6b7280;
            margin: 0;
        }
        .btn-add-vehicle {
            background: #ea580c;
            color: #ffffff;
            padding: 12px 24px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 12px rgba(234, 88, 12, 0.25);
            transition: background 0.2s;
        }
        .btn-add-vehicle:hover {
            background: #c2410c;
        }
        /* Vehicle Card */
        .vehicle-card {
            background: #fffcf8;
            border: 1.5px solid #ffedd5;
            border-radius: 18px;
            padding: 24px 28px;
            margin-bottom: 22px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            box-shadow: 0 2px 10px rgba(234, 88, 12, 0.03);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .vehicle-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(234, 88, 12, 0.06);
        }
        .vehicle-card.is-primary {
            border: 2px solid #ea580c;
            background: #fff9f2;
        }
        .primary-badge {
            position: absolute;
            top: -12px;
            left: 28px;
            background: #ea580c;
            color: #ffffff;
            font-size: 10px;
            font-weight: 800;
            padding: 3px 12px;
            border-radius: 12px;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }
        .card-main {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .vehicle-icon-box {
            width: 64px;
            height: 64px;
            background: #ffedd5;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            flex-shrink: 0;
        }
        .vehicle-info h3 {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 4px 0;
        }
        .vehicle-type-color {
            font-size: 13px;
            color: #6b7280;
            font-weight: 600;
            margin-bottom: 8px;
        }
        /* IND License Plate */
        .ind-plate {
            display: inline-flex;
            align-items: center;
            background: #ffffff;
            border: 1.5px solid #93c5fd;
            border-radius: 6px;
            overflow: hidden;
            font-family: monospace;
            font-weight: 800;
            font-size: 13px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
        }
        .ind-flag {
            background: #2563eb;
            color: #ffffff;
            font-size: 10px;
            font-weight: 800;
            padding: 3px 7px;
            letter-spacing: 0.5px;
        }
        .ind-number {
            padding: 3px 10px;
            color: #1e3a8a;
            letter-spacing: 1px;
        }
        .btn-delete-veh {
            background: #ffffff;
            border: 1.5px solid #fecaca;
            color: #ef4444;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-delete-veh:hover {
            background: #fef2f2;
            border-color: #ef4444;
        }
        .empty-vehicles-card {
            background: #ffffff;
            border: 1.5px dashed #e5e7eb;
            border-radius: 16px;
            padding: 50px 20px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="vehicles-wrapper">
        
        <!-- Header -->
        <div class="vehicles-header">
            <div>
                <h1>My Vehicles</h1>
                <p>Manage your registered cars and bikes for quick service bookings.</p>
            </div>
            <a href="AddVehicle.aspx" class="btn-add-vehicle">+ Add New Vehicle</a>
        </div>

        <!-- Alert Notification Panel -->
        <asp:Label ID="lblMsg" runat="server" Visible="false" style="display: block; padding: 12px 18px; border-radius: 8px; margin-bottom: 20px; font-weight: bold;"></asp:Label>

        <!-- If No Vehicles -->
        <asp:Panel ID="pnlNoVehicles" runat="server" Visible="false" CssClass="empty-vehicles-card">
            <span style="font-size: 40px; display: block; margin-bottom: 10px;">🚗</span>
            <h3>No vehicles added yet!</h3>
            <p>Add your car or motorcycle to book doorstep &amp; studio services instantly.</p>
            <a href="AddVehicle.aspx" class="btn-add-vehicle" style="display: inline-block;">+ Add Vehicle Now</a>
        </asp:Panel>

        <!-- Repeater for Vehicles -->
        <asp:Repeater ID="rptVehicles" runat="server" OnItemCommand="rptVehicles_ItemCommand">
            <ItemTemplate>
                <div class='<%# Convert.ToBoolean(Eval("IsPrimary")) ? "vehicle-card is-primary" : "vehicle-card" %>'>
                    
                    <!-- Primary Badge -->
                    <%# Convert.ToBoolean(Eval("IsPrimary")) ? "<div class='primary-badge'>PRIMARY</div>" : "" %>

                    <div class="card-main">
                        <!-- Vehicle Icon Box -->
                        <div class="vehicle-icon-box">
                            <%# Eval("VehicleType").ToString().ToLower().Contains("bike") ? "&#127949;" : "&#128663;" %>
                        </div>

                        <!-- Vehicle Information -->
                        <div class="vehicle-info">
                            <h3><%# Eval("ModelName") %></h3>
                            <div class="vehicle-type-color">
                                <%# Eval("VehicleType") %> &bull; <%# Eval("Color") != DBNull.Value ? Eval("Color") : "Standard" %>
                            </div>

                            <!-- License Plate -->
                            <div class="ind-plate">
                                <span class="ind-flag">IND</span>
                                <span class="ind-number"><%# Eval("RegistrationNumber") %></span>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Button -->
                    <asp:LinkButton ID="btnDelete" runat="server" 
                        CommandName="DeleteVehicle" 
                        CommandArgument='<%# Eval("VehicleId") %>' 
                        OnClientClick="return confirm('Are you sure you want to remove this vehicle?');" 
                        CssClass="btn-delete-veh" 
                        ToolTip="Delete Vehicle">
                        &#128465;
                    </asp:LinkButton>

                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
