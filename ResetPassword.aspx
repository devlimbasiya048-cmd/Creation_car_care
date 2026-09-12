<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<script runat="server">
    string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Prevents JavaScript unobtrusive validation errors in standard Web Forms
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

        if (!IsPostBack)
        {
            if (Session["ResetEmail"] == null)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Session expired or invalid access. Please request a password reset again.";
                btnResetPassword.Enabled = false;
                pnlExpired.Visible = true; // Show back button
            }
        }
    }

    protected void btnResetPassword_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string resetEmail = Session["ResetEmail"]?.ToString();

        if (string.IsNullOrEmpty(resetEmail))
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Session expired. Please try again.";
            btnResetPassword.Enabled = false;
            pnlExpired.Visible = true;
            return;
        }

        string newPassword = txtNewPassword.Text.Trim();

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
                        lblMsg.Text = "User account not found. Reset failed.";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Database Error: " + ex.Message;
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password - Creation Car Care</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8fafc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .card {
            background: #ffffff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 380px;
            text-align: center;
        }
        h2 {
            margin-bottom: 8px;
            font-size: 22px;
            color: #1e293b;
        }
        p {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 24px;
        }
        .form-group {
            text-align: left;
            margin-bottom: 16px;
        }
        label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        .input-field {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
            outline: none;
        }
        .input-field:focus {
            border-color: #ff8c00;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #ff8c00;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #e07b00;
        }
        .btn-submit:disabled {
            background-color: #cbd5e1;
            cursor: not-allowed;
        }
        .btn-secondary {
            display: inline-block;
            margin-top: 12px;
            padding: 10px 16px;
            background-color: #1e293b;
            color: #ffffff;
            text-decoration: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
        }
        .val-error {
            color: #dc2626;
            font-size: 11px;
            margin-top: 4px;
            display: block;
        }
        .message {
            display: block;
            margin-top: 16px;
            font-size: 13px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <h2>Reset Password</h2>
            <p>Enter your new password below</p>

            <div class="form-group">
                <label>New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="input-field" placeholder="Enter new password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ControlToValidate="txtNewPassword" 
                    ErrorMessage="New password is required." CssClass="val-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revPassLen" runat="server" ControlToValidate="txtNewPassword"
                    ValidationExpression=".{6,}" ErrorMessage="Password must be at least 6 characters long."
                    CssClass="val-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="input-field" placeholder="Confirm new password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPass" runat="server" ControlToValidate="txtConfirmPassword" 
                    ErrorMessage="Please confirm your password." CssClass="val-error" Display="Dynamic" />
                <asp:CompareValidator ID="cvPassMatch" runat="server" ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match."
                    CssClass="val-error" Display="Dynamic" />
            </div>

            <asp:Button ID="btnResetPassword" runat="server" Text="RESET PASSWORD" OnClick="btnResetPassword_Click" CssClass="btn-submit" />

            <asp:Label ID="lblMsg" runat="server" CssClass="message"></asp:Label>

            <asp:Panel ID="pnlExpired" runat="server" Visible="false">
                <a href="ForgotPassword.aspx" class="btn-secondary">Request New Reset Link</a>
            </asp:Panel>
        </div>
    </form>
</body>
</html>