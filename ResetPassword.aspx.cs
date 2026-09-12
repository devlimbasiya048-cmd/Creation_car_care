using System;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ResetEmail"] == null)
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Session expired. Please request password reset again.";
                    btnResetPassword.Enabled = false;
                }
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(newPassword) || string.IsNullOrWhiteSpace(confirmPassword))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please fill in all fields!";
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Passwords do not match!";
                return;
            }

            string resetEmail = Session["ResetEmail"]?.ToString();

            if (string.IsNullOrEmpty(resetEmail))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Session expired. Please try again.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string qry = "UPDATE Users SET Password = @Pass WHERE Email = @Email OR MobileNumber = @Email";
                    using (SqlCommand cmd = new SqlCommand(qry, con))
                    {
                        cmd.Parameters.AddWithValue("@Pass", newPassword);
                        cmd.Parameters.AddWithValue("@Email", resetEmail);

                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Session.Remove("ResetEmail");
                            Session.Remove("IsResetFlow");

                            lblMsg.ForeColor = System.Drawing.Color.Green;
                            lblMsg.Text = "Password updated successfully! Redirecting to Login...";
                            Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                        }
                        else
                        {
                            lblMsg.ForeColor = System.Drawing.Color.Red;
                            lblMsg.Text = "User account not found. Password reset failed.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}