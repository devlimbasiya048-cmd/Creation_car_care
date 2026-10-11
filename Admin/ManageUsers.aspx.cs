using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Manage Users", "Dashboard > Manage Users");
            }

            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            string keyword = txtSearch.Text.Trim();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"
                    SELECT 
                        u.UserId,
                        u.FullName,
                        u.Email,
                        u.MobileNumber,
                        ISNULL(u.IsBlocked, 0) AS IsBlocked,
                        COUNT(b.BookingId) AS TotalBookings,
                        ISNULL(SUM(b.TotalAmount), 0) AS TotalSpent
                    FROM Users u
                    LEFT JOIN Bookings b ON u.UserId = b.UserId
                    WHERE (@kw IS NULL OR @kw = '' OR u.FullName LIKE @kw OR u.Email LIKE @kw OR u.MobileNumber LIKE @kw)
                    GROUP BY u.UserId, u.FullName, u.Email, u.MobileNumber, u.IsBlocked
                    ORDER BY TotalSpent DESC, u.UserId ASC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@kw", string.IsNullOrEmpty(keyword) ? (object)DBNull.Value : "%" + keyword + "%");

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptUsers.DataSource = dt;
                    rptUsers.DataBind();
                }
            }
        }

        public string GetInitials(string fullName)
        {
            if (string.IsNullOrEmpty(fullName)) return "U";
            string[] parts = fullName.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length >= 2)
            {
                return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
            }
            return parts[0].Substring(0, Math.Min(2, parts[0].Length)).ToUpper();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadUsers();
        }

        protected void rptUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ToggleBlock")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "UPDATE Users SET IsBlocked = CASE WHEN IsBlocked = 1 THEN 0 ELSE 1 END WHERE UserId = @id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@id", userId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadUsers();
            }
        }
    }
}
