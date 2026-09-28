using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class ServicesList : System.Web.UI.Page
    {
        // Database Connection String
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckActiveOfferState();
                ViewState["SelectedCategory"] = "";
                BindCategoryFilterTabs();

                // Check login status: Guest vs Logged-In
                if (Session["UserEmail"] != null)
                {
                    // User Logged In -> Show category tabs and figma cards
                    pnlLoggedInView.Visible = true;
                    pnlGuestView.Visible = false;
                    BindLoggedInServices("");
                }
                else
                {
                    // Guest User -> Show single catalog with all services & ratings
                    pnlLoggedInView.Visible = false;
                    pnlGuestView.Visible = true;
                    BindGuestServices("");
                }
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);

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

            return 1;
        }

        private void CheckActiveOfferState()
        {
            if (Session["ActiveOfferDiscount"] != null && Session["ActiveOfferTitle"] != null)
            {
                pnlActiveOfferBanner.Visible = true;
                lblOfferTitle.Text = Session["ActiveOfferTitle"].ToString();
                lblOfferDiscount.Text = Session["ActiveOfferDiscount"].ToString();
            }
            else
            {
                pnlActiveOfferBanner.Visible = false;
            }
        }

        // Helper to format prices with discounts
        private DataTable FormatServiceDataTable(DataTable dt)
        {
            dt.Columns.Add("OriginalPriceFormatted", typeof(string));
            dt.Columns.Add("DiscountedPriceFormatted", typeof(string));
            dt.Columns.Add("HasDiscount", typeof(bool));
            dt.Columns.Add("DiscountBadge", typeof(string));

            bool hasOffer = (Session["ActiveOfferDiscount"] != null);
            decimal discountPercent = 0;
            if (hasOffer)
            {
                decimal.TryParse(Session["ActiveOfferDiscount"].ToString(), out discountPercent);
            }

            foreach (DataRow row in dt.Rows)
            {
                decimal originalPrice = 0;
                if (row["Price"] != DBNull.Value)
                {
                    originalPrice = Convert.ToDecimal(row["Price"]);
                }

                if (hasOffer && discountPercent > 0)
                {
                    decimal discountAmount = originalPrice * (discountPercent / 100m);
                    decimal finalPrice = originalPrice - discountAmount;

                    row["HasDiscount"] = true;
                    row["OriginalPriceFormatted"] = originalPrice.ToString("N0");
                    row["DiscountedPriceFormatted"] = finalPrice.ToString("N0");
                    row["DiscountBadge"] = discountPercent.ToString("0") + "% OFF";
                }
                else
                {
                    row["HasDiscount"] = false;
                    row["OriginalPriceFormatted"] = originalPrice.ToString("N0");
                    row["DiscountedPriceFormatted"] = originalPrice.ToString("N0");
                    row["DiscountBadge"] = "";
                }
            }

            return dt;
        }

        // Bind Dynamic Category Filter Pills from Categories Table
        private void BindCategoryFilterTabs()
        {
            string selected = ViewState["SelectedCategory"] != null ? ViewState["SelectedCategory"].ToString() : "";
            btnTabAll.CssClass = "cat-pill" + (string.IsNullOrEmpty(selected) ? " cat-pill-active" : "");

            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT CategoryName FROM Categories WHERE IsActive = 1 ORDER BY DisplayOrder ASC, CategoryId ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            rptCategoryFilter.DataSource = dt;
            rptCategoryFilter.DataBind();
        }

        // Helper to highlight active category pill
        public string GetCategoryPillClass(string categoryName)
        {
            string selected = ViewState["SelectedCategory"] != null ? ViewState["SelectedCategory"].ToString() : "";
            if (string.Equals(selected, categoryName, StringComparison.OrdinalIgnoreCase))
            {
                return "cat-pill cat-pill-active";
            }
            return "cat-pill";
        }

        // Apply Category Filter to whichever view is active
        private void ApplyCategoryFilter(string category)
        {
            ViewState["SelectedCategory"] = category;
            BindCategoryFilterTabs();

            if (Session["UserEmail"] != null)
            {
                BindLoggedInServices(category);
            }
            else
            {
                BindGuestServices(category);
            }
        }

        // All Services Click
        protected void FilterCategory_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string category = btn.CommandArgument;
            ApplyCategoryFilter(category);
        }

        // Category Tab Click inside Repeater
        protected void rptCategoryFilter_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "FilterCategory")
            {
                string category = e.CommandArgument != null ? e.CommandArgument.ToString() : "";
                ApplyCategoryFilter(category);
            }
        }

        // Guest View: Loads all services (or filtered by category)
        private void BindGuestServices(string category = "")
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query;
                if (string.IsNullOrEmpty(category))
                {
                    query = "SELECT * FROM Services ORDER BY ServiceId ASC";
                }
                else
                {
                    query = "SELECT * FROM Services WHERE Category = @Category ORDER BY ServiceId ASC";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(category))
                    {
                        cmd.Parameters.AddWithValue("@Category", category);
                    }

                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            dt = FormatServiceDataTable(dt);
            rptGuestServices.DataSource = dt;
            rptGuestServices.DataBind();

            pnlNoServicesGuest.Visible = (dt.Rows.Count == 0);
        }

        // Logged-in View: Loads services filtered by category
        private void BindLoggedInServices(string category)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query;
                if (string.IsNullOrEmpty(category))
                {
                    query = "SELECT * FROM Services ORDER BY ServiceId ASC";
                }
                else
                {
                    query = "SELECT * FROM Services WHERE Category = @Category ORDER BY ServiceId ASC";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(category))
                    {
                        cmd.Parameters.AddWithValue("@Category", category);
                    }

                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            dt = FormatServiceDataTable(dt);
            rptLoggedInServices.DataSource = dt;
            rptLoggedInServices.DataBind();

            pnlNoServicesLoggedIn.Visible = (dt.Rows.Count == 0);
        }

        // Add to Cart and Add to Wishlist handlers
        protected void rptLoggedInServices_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int serviceId = Convert.ToInt32(e.CommandArgument);
            int userId = GetCurrentUserId();

            // Fetch service name for feedback message
            string serviceName = "Service";
            using (SqlConnection con = new SqlConnection(connString))
            {
                string nameQry = "SELECT ServiceName FROM Services WHERE ServiceId = @ServiceId";
                using (SqlCommand cmd = new SqlCommand(nameQry, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    con.Open();
                    object objName = cmd.ExecuteScalar();
                    if (objName != null) serviceName = objName.ToString();
                }
            }

            if (e.CommandName == "AddToCart")
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    // Check if already in cart
                    string checkQry = "SELECT CartId FROM Cart WHERE UserId = @UserId AND ServiceId = @ServiceId";
                    using (SqlCommand checkCmd = new SqlCommand(checkQry, con))
                    {
                        checkCmd.Parameters.AddWithValue("@UserId", userId);
                        checkCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                        object existingCart = checkCmd.ExecuteScalar();

                        if (existingCart != null)
                        {
                            // Update quantity
                            string upQry = "UPDATE Cart SET Quantity = Quantity + 1 WHERE CartId = @CartId";
                            using (SqlCommand upCmd = new SqlCommand(upQry, con))
                            {
                                upCmd.Parameters.AddWithValue("@CartId", Convert.ToInt32(existingCart));
                                upCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            // Insert new cart row
                            string insQry = "INSERT INTO Cart (UserId, ServiceId, Quantity, AddedAt) VALUES (@UserId, @ServiceId, 1, GETDATE())";
                            using (SqlCommand insCmd = new SqlCommand(insQry, con))
                            {
                                insCmd.Parameters.AddWithValue("@UserId", userId);
                                insCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                                insCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }

                // Redirect immediately to Cart page
                Response.Redirect("Cart.aspx");
            }
            else if (e.CommandName == "AddToWishlist")
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    // Check if already in wishlist
                    string checkQry = "SELECT WishlistId FROM Wishlist WHERE UserId = @UserId AND ServiceId = @ServiceId";
                    using (SqlCommand checkCmd = new SqlCommand(checkQry, con))
                    {
                        checkCmd.Parameters.AddWithValue("@UserId", userId);
                        checkCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                        object existingWish = checkCmd.ExecuteScalar();

                        if (existingWish == null)
                        {
                            // Insert new wishlist row
                            string insQry = "INSERT INTO Wishlist (UserId, ServiceId, AddedAt) VALUES (@UserId, @ServiceId, GETDATE())";
                            using (SqlCommand insCmd = new SqlCommand(insQry, con))
                            {
                                insCmd.Parameters.AddWithValue("@UserId", userId);
                                insCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                                insCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }

                // Redirect immediately to Wishlist page
                Response.Redirect("Wishlist.aspx");
            }
        }

        protected void btnRemoveOffer_Click(object sender, EventArgs e)
        {
            Session.Remove("ActiveOfferId");
            Session.Remove("ActiveOfferTitle");
            Session.Remove("ActiveOfferDiscount");

            pnlActiveOfferBanner.Visible = false;

            string cat = ViewState["SelectedCategory"] != null ? ViewState["SelectedCategory"].ToString() : "";
            if (Session["UserEmail"] != null)
            {
                BindLoggedInServices(cat);
            }
            else
            {
                BindGuestServices(cat);
            }
        }
    }
}