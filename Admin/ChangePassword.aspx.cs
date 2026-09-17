using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Change Password", "Settings > Change Password");
            }
        }

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            string currentPwd = txtCurrentPassword.Text.Trim();
            string newPwd = txtNewPassword.Text.Trim();
            string confirmPwd = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(currentPwd) || string.IsNullOrEmpty(newPwd) || string.IsNullOrEmpty(confirmPwd))
            {
                ShowAlert("Please fill in all password fields.", false);
                return;
            }

            if (newPwd != confirmPwd)
            {
                ShowAlert("New password and confirm password do not match.", false);
                return;
            }

            if (newPwd.Length < 6)
            {
                ShowAlert("New password must be at least 6 characters long.", false);
                return;
            }

            string adminEmail = Session["UserEmail"]?.ToString() ?? "admin@creation.com";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string checkSql = "SELECT COUNT(*) FROM Admins WHERE Email = @email AND Password = @pwd AND IsActive = 1";
                using (SqlCommand cmd = new SqlCommand(checkSql, con))
                {
                    cmd.Parameters.AddWithValue("@email", adminEmail);
                    cmd.Parameters.AddWithValue("@pwd", currentPwd);

                    try
                    {
                        con.Open();
                        int matchCount = Convert.ToInt32(cmd.ExecuteScalar());

                        if (matchCount == 0)
                        {
                            ShowAlert("Incorrect current password.", false);
                            return;
                        }

                        // Update password
                        string updateSql = "UPDATE Admins SET Password = @newPwd WHERE Email = @email";
                        using (SqlCommand updateCmd = new SqlCommand(updateSql, con))
                        {
                            updateCmd.Parameters.AddWithValue("@newPwd", newPwd);
                            updateCmd.Parameters.AddWithValue("@email", adminEmail);
                            updateCmd.ExecuteNonQuery();

                            ShowAlert("Admin password updated successfully!", true);
                            txtCurrentPassword.Text = "";
                            txtNewPassword.Text = "";
                            txtConfirmPassword.Text = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowAlert("Database error: " + ex.Message, false);
                    }
                }
            }
        }

        private void ShowAlert(string msg, bool isSuccess)
        {
            lblMsg.Visible = true;
            lblMsg.Text = msg;
            lblMsg.CssClass = isSuccess ? "alert-box alert-success" : "alert-box alert-danger";
        }
    }
}
