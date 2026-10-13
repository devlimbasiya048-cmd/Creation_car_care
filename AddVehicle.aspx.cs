using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care
{
    public partial class AddVehicle : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);
            return 1;
        }

        protected void btnTypeCar_Click(object sender, EventArgs e)
        {
            hfVehicleType.Value = "Car";
            btnTypeCar.CssClass = "type-toggle-btn active";
            btnTypeBike.CssClass = "type-toggle-btn";
            lblPageTitle.Text = "Add New Vehicle";
            btnSaveVehicle.Text = "SAVE VEHICLE";
            txtModelName.Attributes["placeholder"] = "e.g. Creta / Swift / City";
        }

        protected void btnTypeBike_Click(object sender, EventArgs e)
        {
            hfVehicleType.Value = "Bike";
            btnTypeCar.CssClass = "type-toggle-btn";
            btnTypeBike.CssClass = "type-toggle-btn active";
            lblPageTitle.Text = "Add New Bike";
            btnSaveVehicle.Text = "SAVE BIKE";
            txtModelName.Attributes["placeholder"] = "e.g. Classic 350 / Activa / Splendor";

            // If brand is not already set for bike, select Royal Enfield
            if (ddlBrand.SelectedValue == "Hyundai")
            {
                ddlBrand.SelectedValue = "Royal Enfield";
            }
        }

        protected void btnSaveVehicle_Click(object sender, EventArgs e)
        {
            string model = txtModelName.Text.Trim();
            string reg = txtRegNumber.Text.Trim().ToUpper();
            string color = txtColor.Text.Trim();
            string brand = ddlBrand.SelectedValue;
            string vType = hfVehicleType.Value;
            bool isPrimary = chkIsPrimary.Checked;

            if (string.IsNullOrEmpty(model) || string.IsNullOrEmpty(reg))
            {
                lblError.Visible = true;
                lblError.Text = "Please enter both Model Name and Registration Number.";
                return;
            }

            if (reg.Length < 6 || reg.Length > 15)
            {
                lblError.Visible = true;
                lblError.Text = "Please enter a valid vehicle registration number (e.g. GJ 03 AB 1234).";
                return;
            }

            int userId = GetCurrentUserId();

            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();

                // Jo aa primary vehicle hoy, to pehla baki badha ne IsPrimary = 0 karo
                if (isPrimary)
                {
                    string resetPrimary = "UPDATE Vehicles SET IsPrimary = 0 WHERE UserId = @UserId";
                    using (SqlCommand resetCmd = new SqlCommand(resetPrimary, con))
                    {
                        resetCmd.Parameters.AddWithValue("@UserId", userId);
                        resetCmd.ExecuteNonQuery();
                    }
                }

                // Insert into Vehicles table
                string insertQuery = @"INSERT INTO Vehicles (UserId, VehicleType, Brand, ModelName, RegistrationNumber, IsPrimary, Color) 
                                       VALUES (@UserId, @Type, @Brand, @Model, @Reg, @IsPrimary, @Color)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Type", vType == "Bike" ? "Bike" : "SUV / Car");
                    cmd.Parameters.AddWithValue("@Brand", brand);
                    cmd.Parameters.AddWithValue("@Model", model);
                    cmd.Parameters.AddWithValue("@Reg", reg);
                    cmd.Parameters.AddWithValue("@IsPrimary", isPrimary ? 1 : 0);
                    cmd.Parameters.AddWithValue("@Color", !string.IsNullOrEmpty(color) ? color : "Standard Color");
                    cmd.ExecuteNonQuery();
                }
            }

            // Redirect back to My Vehicles
            Response.Redirect("Vehicles.aspx");
        }
    }
}
