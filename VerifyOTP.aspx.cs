using System;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class VerifyOTP : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            if (txtOTP.Text.Trim() == "1234")
            {
                // Check if this is a Password Reset flow
                bool isResetFlow = Session["IsResetFlow"] != null && (bool)Session["IsResetFlow"];
                string resetEmail = Session["ResetEmail"]?.ToString();

                if (isResetFlow && !string.IsNullOrEmpty(resetEmail))
                {
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "OTP Verified! Redirecting to reset password...";
                    Response.AddHeader("REFRESH", "2;URL=ResetPassword.aspx");
                    return;
                }

                // Registration flow
                string fullName = Session["RegFullName"]?.ToString();
                string mobile = Session["RegMobile"]?.ToString() ?? "";
                string email = Session["RegEmail"]?.ToString() ?? Session["RegisteredEmail"]?.ToString();
                string password = Session["RegPassword"]?.ToString();

                if (!string.IsNullOrEmpty(email))
                {
                    try
                    {
                        using (SqlConnection con = new SqlConnection(connString))
                        {
                            string qry = "INSERT INTO Users (FullName, MobileNumber, Email, Password) VALUES (@Name, @Mobile, @Email, @Pass)";
                            using (SqlCommand cmd = new SqlCommand(qry, con))
                            {
                                cmd.Parameters.AddWithValue("@Name", (object)fullName ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Mobile", (object)mobile ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Email", email);
                                cmd.Parameters.AddWithValue("@Pass", (object)password ?? DBNull.Value);

                                con.Open();
                                cmd.ExecuteNonQuery();
                            }
                        }

                        // Clear registration session variables
                        Session.Remove("RegFullName");
                        Session.Remove("RegMobile");
                        Session.Remove("RegEmail");
                        Session.Remove("RegPassword");

                        lblMsg.ForeColor = System.Drawing.Color.Green;
                        lblMsg.Text = "Phone Verified & Registration Successful! Redirecting to login...";
                        Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                    }
                    catch (Exception ex)
                    {
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        lblMsg.Text = "Database Error: " + ex.Message;
                    }
                }
                else
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Session expired. Please register again.";
                }
            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Invalid OTP. Please enter 1234.";
            }
        }
    }
}