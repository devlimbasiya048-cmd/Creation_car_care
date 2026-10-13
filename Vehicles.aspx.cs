using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class Vehicles : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadVehicles();
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);
            return 1;
        }

        private void LoadVehicles()
        {
            int userId = GetCurrentUserId();
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT VehicleId, VehicleType, Brand, ModelName, RegistrationNumber, IsPrimary, Color FROM Vehicles WHERE UserId = @UserId ORDER BY IsPrimary DESC, VehicleId ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                pnlNoVehicles.Visible = false;
                rptVehicles.Visible = true;
                rptVehicles.DataSource = dt;
                rptVehicles.DataBind();
            }
            else
            {
                pnlNoVehicles.Visible = true;
                rptVehicles.Visible = false;
            }
        }

        protected void rptVehicles_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteVehicle")
            {
                int vehicleId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = "DELETE FROM Vehicles WHERE VehicleId = @VehicleId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@VehicleId", vehicleId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMsg.Visible = true;
                lblMsg.Text = "Vehicle removed successfully.";
                lblMsg.BackColor = System.Drawing.ColorTranslator.FromHtml("#ecfdf5");
                lblMsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#065f46");

                LoadVehicles();
            }
        }
    }
}
