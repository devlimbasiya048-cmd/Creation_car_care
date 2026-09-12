using System;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmailOrMobile.Text))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please enter Email or Mobile number!";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string qry = "SELECT COUNT(*) FROM Users WHERE Email = @Email OR MobileNumber = @Email";
                    using (SqlCommand cmd = new SqlCommand(qry, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", txtEmailOrMobile.Text.Trim());
                        con.Open();
                        int count = Convert.ToInt32(cmd.ExecuteScalar());

                        if (count > 0)
                        {
                            // Clear registration sessions if any exist to avoid conflicts
                            Session.Remove("RegEmail");
                            Session.Remove("RegFullName");
                            Session.Remove("RegPassword");
                            Session.Remove("RegMobile");

                            // Store password reset details and OTP in Session
                            Session["ResetEmail"] = txtEmailOrMobile.Text.Trim();
                            Session["IsResetFlow"] = true;
                            Session["OTP"] = "1234";

                            // Thread-safe redirect to VerifyOTP.aspx
                            Response.Redirect("VerifyOTP.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
                        else
                        {
                            lblMsg.ForeColor = System.Drawing.Color.Red;
                            lblMsg.Text = "Email or Mobile number not found!";
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