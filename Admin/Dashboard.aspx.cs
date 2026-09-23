using System;
using System.Data;
using System.Data.SqlClient;

namespace creation_car_care.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var master = this.Master as Admin;
                if (master != null)
                {
                    master.SetPageTitle("Dashboard Overview", "Admin > Overview");
                }

                LoadDashboardStats();
                LoadRecentActivity();
            }
        }

        private void LoadDashboardStats()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();

                // Total Revenue from Bookings
                string revenueQry = "SELECT ISNULL(SUM(TotalAmount), 0) FROM Bookings WHERE BookingStatus != 'Cancelled'";
                using (SqlCommand cmd = new SqlCommand(revenueQry, con))
                {
                    decimal rev = Convert.ToDecimal(cmd.ExecuteScalar());
                    lblTotalRevenue.Text = string.Format("{0:N0}", rev);
                }

                // Pending Bookings count
                string pendingQry = "SELECT COUNT(*) FROM Bookings WHERE BookingStatus = 'Upcoming'";
                using (SqlCommand cmd = new SqlCommand(pendingQry, con))
                {
                    int pending = Convert.ToInt32(cmd.ExecuteScalar());
                    lblPendingBookings.Text = pending.ToString("D2");
                }

                // Users count (Normal Customers)
                string usersQry = "SELECT COUNT(*) FROM Users";
                using (SqlCommand cmd = new SqlCommand(usersQry, con))
                {
                    int users = Convert.ToInt32(cmd.ExecuteScalar());
                    lblUsersCount.Text = users.ToString();
                }
            }
        }

        private void LoadRecentActivity()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT TOP 5 Title, Description, BadgeColor, CreatedAt FROM AdminActivities ORDER BY CreatedAt DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            rptRecentActivity.DataSource = dt;
            rptRecentActivity.DataBind();
        }
    }
}
