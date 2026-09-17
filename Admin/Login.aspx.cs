using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString 
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Client-Side State Management: Check for persistent Admin Cookie
                if (Request.Cookies["CCC_AdminUser"] != null)
                {
                    txtEmail.Text = Request.Cookies["CCC_AdminUser"].Value;
                    chkRemember.Checked = true;
                }

                // If already logged in as Admin, redirect to dashboard
                if (Session["UserEmail"] != null && Session["IsAdmin"] != null && Convert.ToBoolean(Session["IsAdmin"]))
                {
                    Response.Redirect("Dashboard.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string pass = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(pass))
            {
                lblError.Visible = true;
                lblError.Text = "Please enter both Email and Password!";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    // Authenticate against dedicated Admins table
                    string qry = @"SELECT AdminId, FullName, Email, Role 
                                   FROM Admins 
                                   WHERE Email = @Email AND Password = @Pass AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(qry, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Pass", pass);

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                int adminId = Convert.ToInt32(dr["AdminId"]);
                                string name = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : "Dev Limbasiya";
                                string userEmail = dr["Email"] != DBNull.Value ? dr["Email"].ToString() : email;
                                string role = dr["Role"] != DBNull.Value ? dr["Role"].ToString() : "Studio Admin";

                                Session["AdminId"] = adminId;
                                Session["UserId"] = adminId;
                                Session["UserEmail"] = userEmail;
                                Session["UserName"] = name;
                                Session["AdminRole"] = role;
                                Session["IsAdmin"] = true;

                                // Client-Side State Management: Persistent cookie for Admin
                                if (chkRemember.Checked)
                                {
                                    HttpCookie adminCookie = new HttpCookie("CCC_AdminUser", userEmail)
                                    {
                                        Expires = DateTime.Now.AddDays(30)
                                    };
                                    Response.Cookies.Add(adminCookie);
                                }
                                else if (Request.Cookies["CCC_AdminUser"] != null)
                                {
                                    HttpCookie adminCookie = new HttpCookie("CCC_AdminUser")
                                    {
                                        Expires = DateTime.Now.AddDays(-1)
                                    };
                                    Response.Cookies.Add(adminCookie);
                                }

                                Response.Redirect("Dashboard.aspx");
                            }
                            else
                            {
                                lblError.Visible = true;
                                lblError.Text = "Invalid Admin credentials or inactive account!";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.Text = "Login Error: " + ex.Message;
            }
        }
    }
}
