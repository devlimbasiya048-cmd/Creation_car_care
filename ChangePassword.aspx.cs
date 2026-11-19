using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public bool AlertIsSuccess { get; set; } = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Login check: If not logged in, redirect to login
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

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string currentPwd = txtCurrentPassword.Text.Trim();
            string newPwd = txtNewPassword.Text.Trim();
            string confirmPwd = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(currentPwd) || string.IsNullOrEmpty(newPwd) || string.IsNullOrEmpty(confirmPwd))
            {
                ShowAlert("Please fill in all password fields.", false);
                return;
            }

            if (newPwd.Length < 6)
            {
                ShowAlert("New password must be at least 6 characters long.", false);
                return;
            }

            if (newPwd != confirmPwd)
            {
                ShowAlert("New password and confirm password do not match.", false);
                return;
            }

            if (currentPwd == newPwd)
            {
                ShowAlert("New password cannot be the same as your current password.", false);
                return;
            }

            int userId = GetCurrentUserId();
            string userEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "";

            using (SqlConnection con = new SqlConnection(connString))
            {
                // Verify current password matches
                string checkSql = "SELECT COUNT(*) FROM Users WHERE (UserId = @UserId OR Email = @Email) AND Password = @CurrentPassword";
                using (SqlCommand cmd = new SqlCommand(checkSql, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Email", userEmail);
                    cmd.Parameters.AddWithValue("@CurrentPassword", currentPwd);

                    try
                    {
                        con.Open();
                        int matchCount = Convert.ToInt32(cmd.ExecuteScalar());

                        if (matchCount == 0)
                        {
                            ShowAlert("Your current password is incorrect. Please try again.", false);
                            return;
                        }

                        // Update password in Users table
                        string updateSql = "UPDATE Users SET Password = @NewPassword WHERE (UserId = @UserId OR Email = @Email)";
                        using (SqlCommand updateCmd = new SqlCommand(updateSql, con))
                        {
                            updateCmd.Parameters.AddWithValue("@NewPassword", newPwd);
                            updateCmd.Parameters.AddWithValue("@UserId", userId);
                            updateCmd.Parameters.AddWithValue("@Email", userEmail);
                            updateCmd.ExecuteNonQuery();

                            ShowAlert("Password updated successfully! You can now use your new password on your next login.", true);
                            txtCurrentPassword.Text = "";
                            txtNewPassword.Text = "";
                            txtConfirmPassword.Text = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowAlert("Database error occurred: " + ex.Message, false);
                    }
                }
            }
        }

        private void ShowAlert(string msg, bool isSuccess)
        {
            pnlAlert.Visible = true;
            lblAlertMsg.Text = (isSuccess ? "&#10004; " : "&#9888; ") + msg;
            AlertIsSuccess = isSuccess;
        }
    }
}
