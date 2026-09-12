using System;
using System.Data.SqlClient;
using System.Web;

namespace creation_car_care
{
    public partial class Login : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";

                // Client-Side State Management: Check for persistent login cookie
                if (Request.Cookies["CCC_RememberUser"] != null)
                {
                    txtEmailOrMobile.Text = Request.Cookies["CCC_RememberUser"].Value;
                }

                if (Request.QueryString["offer"] == "1")
                {
                    lblError.ForeColor = System.Drawing.Color.DarkGreen;
                    lblError.Text = "Please login to activate and claim your special offer!";
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userInput = txtEmailOrMobile.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(userInput) || string.IsNullOrEmpty(password))
            {
                lblError.ForeColor = System.Drawing.Color.Red;
                lblError.Text = "Please enter both Email/Mobile and Password.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();

                    // 1. First check in Customer Users table
                    string userQry = "SELECT UserId, FullName, Email, ISNULL(IsBlocked, 0) AS IsBlocked FROM Users WHERE (Email = @User OR MobileNumber = @User) AND Password = @Pass";
                    using (SqlCommand cmd = new SqlCommand(userQry, con))
                    {
                        cmd.Parameters.AddWithValue("@User", userInput);
                        cmd.Parameters.AddWithValue("@Pass", password);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                bool isBlocked = Convert.ToBoolean(reader["IsBlocked"]);
                                if (isBlocked)
                                {
                                    lblError.ForeColor = System.Drawing.Color.Red;
                                    lblError.Text = "Your account has been suspended by administration. Please contact support.";
                                    return;
                                }

                                int userId = Convert.ToInt32(reader["UserId"]);
                                string fullName = reader["FullName"] != DBNull.Value ? reader["FullName"].ToString() : "";
                                string email = reader["Email"] != DBNull.Value ? reader["Email"].ToString() : userInput;

                                Session["UserId"] = userId;
                                Session["UserEmail"] = email;
                                Session["UserName"] = !string.IsNullOrEmpty(fullName) ? fullName : email;
                                Session["IsAdmin"] = false;

                                // Client-Side State Management: Save persistent cookie
                                HttpCookie remCookie = new HttpCookie("CCC_RememberUser", email)
                                {
                                    Expires = DateTime.Now.AddDays(30)
                                };
                                Response.Cookies.Add(remCookie);

                                if (Session["PendingOfferId"] != null)
                                {
                                    int offerId = Convert.ToInt32(Session["PendingOfferId"]);
                                    Session.Remove("PendingOfferId");
                                    reader.Close();
                                    ActivateOffer(offerId);
                                    Response.Redirect("~/ServicesList.aspx");
                                }
                                else
                                {
                                    Response.Redirect("~/Home.aspx");
                                }
                                return;
                            }
                        }
                    }

                    // 2. Check in separate Admins table
                    string adminQry = "SELECT AdminId, FullName, Email, Role FROM Admins WHERE Email = @User AND Password = @Pass AND IsActive = 1";
                    using (SqlCommand aCmd = new SqlCommand(adminQry, con))
                    {
                        aCmd.Parameters.AddWithValue("@User", userInput);
                        aCmd.Parameters.AddWithValue("@Pass", password);

                        using (SqlDataReader aReader = aCmd.ExecuteReader())
                        {
                            if (aReader.Read())
                            {
                                Session["AdminId"] = aReader["AdminId"];
                                Session["UserId"] = aReader["AdminId"];
                                Session["UserEmail"] = aReader["Email"].ToString();
                                Session["UserName"] = aReader["FullName"].ToString();
                                Session["AdminRole"] = aReader["Role"].ToString();
                                Session["IsAdmin"] = true;

                                Response.Redirect("~/Admin/Dashboard.aspx");
                                return;
                            }
                        }
                    }

                    lblError.ForeColor = System.Drawing.Color.Red;
                    lblError.Text = "Invalid Email/Mobile or Password!";
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }
        }

        private void ActivateOffer(int offerId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = "SELECT OfferId, OfferTitle, DiscountPercentage FROM Offers WHERE OfferId = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", offerId);
                        con.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                string title = dr["OfferTitle"].ToString();
                                string discStr = dr["DiscountPercentage"].ToString().Replace("%", "").Trim();
                                decimal discount = 10m;
                                decimal.TryParse(discStr, out discount);

                                Session["ActiveOfferId"] = offerId;
                                Session["ActiveOfferTitle"] = title;
                                Session["ActiveOfferDiscount"] = discount;
                            }
                        }
                    }
                }
            }
            catch { }
        }
    }
}