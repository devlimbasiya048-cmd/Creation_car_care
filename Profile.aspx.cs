using System;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class Profile : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Login check: If not logged in, redirect to Login
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfileHubData();
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);
            return 1;
        }

        private void LoadProfileHubData()
        {
            int userId = GetCurrentUserId();

            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();

                // 1. Fetch User Information
                string userQry = "SELECT FullName, Email, MobileNumber FROM Users WHERE UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(userQry, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            string fullName = r["FullName"] != DBNull.Value ? r["FullName"].ToString() : "Customer";
                            string email = r["Email"] != DBNull.Value ? r["Email"].ToString() : "";
                            string mobile = r["MobileNumber"] != DBNull.Value ? r["MobileNumber"].ToString() : "+91 98765 43210";

                            lblFullName.Text = fullName;
                            lblEmail.Text = email;
                            lblMobile.Text = mobile;

                            if (!string.IsNullOrEmpty(fullName))
                            {
                                lblAvatarInitial.Text = fullName.Trim().Substring(0, 1).ToUpper();
                            }
                        }
                    }
                }

                // 2. Fetch Count of Registered Vehicles
                string vehQry = "SELECT COUNT(*) FROM Vehicles WHERE UserId = @UserId";
                using (SqlCommand cmdVeh = new SqlCommand(vehQry, con))
                {
                    cmdVeh.Parameters.AddWithValue("@UserId", userId);
                    int vCount = Convert.ToInt32(cmdVeh.ExecuteScalar());
                    lblVehiclesCount.Text = vCount.ToString();
                }

                // 3. Fetch Count of Bookings
                string bookQry = "SELECT COUNT(*) FROM Bookings WHERE UserId = @UserId";
                using (SqlCommand cmdBook = new SqlCommand(bookQry, con))
                {
                    cmdBook.Parameters.AddWithValue("@UserId", userId);
                    int bCount = Convert.ToInt32(cmdBook.ExecuteScalar());
                    lblBookingsCount.Text = bCount.ToString();
                }

                // 4. Fetch Count of Saved Wishlist Items
                string wishQry = "SELECT COUNT(*) FROM Wishlist WHERE UserId = @UserId";
                using (SqlCommand cmdWish = new SqlCommand(wishQry, con))
                {
                    cmdWish.Parameters.AddWithValue("@UserId", userId);
                    int wCount = Convert.ToInt32(cmdWish.ExecuteScalar());
                    lblWishlistCount.Text = wCount.ToString();
                }
            }
        }

        protected void btnLogoutProfile_Click(object sender, EventArgs e)
        {
            if (Session != null)
            {
                Session.Clear();
                Session.Abandon();
            }
            Response.Redirect("Home.aspx");
        }
    }
}
