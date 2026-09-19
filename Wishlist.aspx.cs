using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class Wishlist : System.Web.UI.Page
    {
        // Database Connection String
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Login Check
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadWishlist();
            }
        }

        // Helper method: Logged in user ni ID મેળવવા માટે
        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null)
            {
                return Convert.ToInt32(Session["UserId"]);
            }

            if (Session["UserEmail"] != null)
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string qry = "SELECT UserId FROM Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(qry, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", Session["UserEmail"].ToString());
                        con.Open();
                        object val = cmd.ExecuteScalar();
                        if (val != null)
                        {
                            Session["UserId"] = Convert.ToInt32(val);
                            return Convert.ToInt32(val);
                        }
                    }
                }
            }

            return 1; // Default fallback for local testing
        }

        // Method: Wishlist data load karva mate
        private void LoadWishlist()
        {
            int userId = GetCurrentUserId();
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = @"SELECT w.WishlistId, s.ServiceId, s.ServiceName, s.Price, 
                                 s.ShortDescription, s.Duration, s.Warranty 
                                 FROM Wishlist w 
                                 INNER JOIN Services s ON w.ServiceId = s.ServiceId 
                                 WHERE w.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                pnlEmptyWishlist.Visible = false;
                rptWishlist.Visible = true;
                rptWishlist.DataSource = dt;
                rptWishlist.DataBind();
            }
            else
            {
                pnlEmptyWishlist.Visible = true;
                rptWishlist.Visible = false;
            }
        }

        // Repeater actions: Delete or MoveToCart
        protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId = GetCurrentUserId();

            if (e.CommandName == "DeleteWishlist")
            {
                int wishlistId = Convert.ToInt32(e.CommandArgument);
                DeleteFromWishlist(wishlistId);

                ShowMessage("Item removed from wishlist.", false);
                LoadWishlist();
            }
            else if (e.CommandName == "MoveToCart")
            {
                // Argument contains: "WishlistId|ServiceId"
                string[] parts = e.CommandArgument.ToString().Split('|');
                int wishlistId = Convert.ToInt32(parts[0]);
                int serviceId = Convert.ToInt32(parts[1]);

                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();

                    // Step 1: Check karo ke cart ma already che?
                    string checkQuery = "SELECT Quantity FROM Cart WHERE UserId = @UserId AND ServiceId = @ServiceId";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.AddWithValue("@UserId", userId);
                        checkCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                        object existing = checkCmd.ExecuteScalar();

                        if (existing != null)
                        {
                            // Already che to Quantity + 1 karo
                            string updateQuery = "UPDATE Cart SET Quantity = Quantity + 1 WHERE UserId = @UserId AND ServiceId = @ServiceId";
                            using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                            {
                                updateCmd.Parameters.AddWithValue("@UserId", userId);
                                updateCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                                updateCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            // Nathi to Cart ma Add karo
                            string insertQuery = "INSERT INTO Cart (UserId, ServiceId, Quantity) VALUES (@UserId, @ServiceId, 1)";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                            {
                                insertCmd.Parameters.AddWithValue("@UserId", userId);
                                insertCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }

                    // Step 2: Wishlist mathi remove karo
                    string deleteQuery = "DELETE FROM Wishlist WHERE WishlistId = @WishlistId";
                    using (SqlCommand delCmd = new SqlCommand(deleteQuery, con))
                    {
                        delCmd.Parameters.AddWithValue("@WishlistId", wishlistId);
                        delCmd.ExecuteNonQuery();
                    }
                }

                // Redirect to Cart page
                Response.Redirect("Cart.aspx");
            }
        }

        private void DeleteFromWishlist(int wishlistId)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "DELETE FROM Wishlist WHERE WishlistId = @WishlistId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@WishlistId", wishlistId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = msg;
            if (isSuccess)
            {
                lblMessage.BackColor = System.Drawing.ColorTranslator.FromHtml("#ecfdf5");
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#065f46");
            }
            else
            {
                lblMessage.BackColor = System.Drawing.ColorTranslator.FromHtml("#fef2f2");
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#991b1b");
            }
        }
    }
}
