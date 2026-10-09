using System;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class EditProfile : System.Web.UI.Page
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
                LoadData();
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);
            return 1;
        }

        private void LoadData()
        {
            int userId = GetCurrentUserId();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT FullName, Email, MobileNumber FROM Users WHERE UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            string name = r["FullName"] != DBNull.Value ? r["FullName"].ToString() : "";
                            txtFullName.Text = name;
                            txtEmail.Text = r["Email"] != DBNull.Value ? r["Email"].ToString() : "";
                            txtMobile.Text = r["MobileNumber"] != DBNull.Value ? r["MobileNumber"].ToString() : "+91 98765 43210";

                            if (!string.IsNullOrEmpty(name))
                            {
                                lblAvatarInitial.Text = name.Trim().Substring(0, 1).ToUpper();
                            }
                        }
                    }
                }
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            int userId = GetCurrentUserId();
            string fullName = txtFullName.Text.Trim();
            string mobile = txtMobile.Text.Trim();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string updateQry = "UPDATE Users SET FullName = @FullName, MobileNumber = @Mobile WHERE UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(updateQry, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Session["UserName"] = fullName;

            lblSuccess.Visible = true;
            lblSuccess.Text = "Profile updated successfully!";

            if (!string.IsNullOrEmpty(fullName))
            {
                lblAvatarInitial.Text = fullName.Trim().Substring(0, 1).ToUpper();
            }
        }
    }
}
