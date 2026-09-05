using System;

namespace creation_car_care
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtFullName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblError.Text = "Please fill in all fields!";
                return;
            }

            try
            {
                // Save registration details in Session for OTP verification
                Session["RegFullName"] = txtFullName.Text.Trim();
                Session["RegEmail"] = txtEmail.Text.Trim();
                Session["RegPassword"] = txtPassword.Text.Trim();

                // If you have a mobile textbox, un-comment the line below:
                // Session["RegMobile"] = txtMobile.Text.Trim();

                Response.Redirect("VerifyOTP.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }
        }
    }
}