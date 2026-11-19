using System;
using System.Data;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class ServiceDetails : System.Web.UI.Page
    {
        // Simple database connection string
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    LoadServiceDetails(id);
                }
            }
        }

        private void LoadServiceDetails(string id)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT * FROM Services WHERE ServiceId = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string sName = dr["ServiceName"].ToString();
                            lblServiceName.Text = sName;
                            lblBreadcrumbName.Text = sName;
                            lblGalleryTitle.Text = sName + " Gallery & Process";
                            lblDescription.Text = dr["ShortDescription"].ToString();
                            lblDuration.Text = dr["Duration"].ToString();
                            lblWarranty.Text = dr["Warranty"].ToString();
                            lblCategory.Text = dr["Category"] != DBNull.Value ? dr["Category"].ToString() : "Detailing";
                            string imgUrl = dr["ImageUrl"] != DBNull.Value ? dr["ImageUrl"].ToString() : "";
                            if (!string.IsNullOrEmpty(imgUrl))
                            {
                                imgService.ImageUrl = ResolveUrl(imgUrl);
                            }
                            else
                            {
                                imgService.ImageUrl = ResolveUrl("~/Images/Services/default_service.jpg");
                            }

                            decimal price = 0;
                            if (dr["Price"] != DBNull.Value)
                            {
                                price = Convert.ToDecimal(dr["Price"]);
                            }
                            lblPrice.Text = price.ToString();

                            if (Session["ActiveOfferDiscount"] != null)
                            {
                                decimal disc = Convert.ToDecimal(Session["ActiveOfferDiscount"]);
                                decimal finalPrice = price - (price * disc / 100m);
                                string offerTitle = Session["ActiveOfferTitle"] != null ? Session["ActiveOfferTitle"].ToString() : "Special Festival Offer";

                                pnlOfferNotice.Visible = true;
                                lblOfferNotice.Text = string.Format("{0} ({1}% OFF) Applied!", offerTitle, disc.ToString("0"));

                                litPriceDisplay.Text = string.Format("<div style='display: flex; align-items: baseline; gap: 10px;'><span style='font-size: 20px; color: #9ca3af; text-decoration: line-through;'>&#8377;{0:N0}</span><span style='font-size: 32px; font-weight: 800; color: #16a34a;'>&#8377;{1:N0}</span><span style='background: #dcfce7; color: #15803d; font-size: 13px; font-weight: bold; padding: 3px 8px; border-radius: 6px;'>{2}% OFF</span></div>", price, finalPrice, disc.ToString("0"));
                            }
                            else
                            {
                                pnlOfferNotice.Visible = false;
                                litPriceDisplay.Text = string.Format("<div style='font-size: 32px; font-weight: 800; color: #ff9800;'>&#8377;{0:N0}</div>", price);
                            }
                        }
                    }
                }
            }

            LoadCustomerReviews(id);
        }

        private void LoadCustomerReviews(string serviceId)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string sql = @"
                    SELECT b.BookingId, b.Rating, b.ReviewText, b.SlotDate,
                           ISNULL(u.FullName, 'Customer') AS CustomerName,
                           u.ProfileImage
                    FROM Bookings b
                    LEFT JOIN Users u ON b.UserId = u.UserId
                    WHERE b.ServiceId = @ServiceId AND b.Rating IS NOT NULL
                    ORDER BY b.SlotDate DESC, b.BookingId DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    try
                    {
                        con.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                    catch (Exception)
                    {
                        // Fallback gracefully
                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                pnlNoReviews.Visible = false;
                rptReviews.Visible = true;
                rptReviews.DataSource = dt;
                rptReviews.DataBind();

                double totalRating = 0;
                foreach (DataRow row in dt.Rows)
                {
                    totalRating += Convert.ToDouble(row["Rating"]);
                }
                double avg = totalRating / dt.Rows.Count;
                lblAvgRatingHeader.Text = avg.ToString("0.0");
                lblRating.Text = avg.ToString("0.0");
                lblTotalReviewsCount.Text = dt.Rows.Count.ToString();
            }
            else
            {
                pnlNoReviews.Visible = true;
                rptReviews.Visible = false;
                lblAvgRatingHeader.Text = "4.8";
                lblTotalReviewsCount.Text = "0";
            }
        }

        public string GetStarsHtml(object ratingObj)
        {
            if (ratingObj == null || ratingObj == DBNull.Value) return "";
            int rating = Convert.ToInt32(ratingObj);
            string stars = "";
            for (int i = 0; i < rating; i++) stars += "&#9733;";
            for (int i = rating; i < 5; i++) stars += "&#9734;";
            return stars;
        }

        public string GetAvatarInitial(string name)
        {
            if (string.IsNullOrEmpty(name)) return "U";
            return name.Trim().Substring(0, 1).ToUpper();
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            // Login check: Jo user login nathi to Login page par redirect karo
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                int serviceId = Convert.ToInt32(id);
                int userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 1;

                // Cart table ma add karo
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    string checkQry = "SELECT Quantity FROM Cart WHERE UserId = @UserId AND ServiceId = @ServiceId";
                    using (SqlCommand checkCmd = new SqlCommand(checkQry, con))
                    {
                        checkCmd.Parameters.AddWithValue("@UserId", userId);
                        checkCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                        object existing = checkCmd.ExecuteScalar();

                        if (existing != null)
                        {
                            string updateQry = "UPDATE Cart SET Quantity = Quantity + 1 WHERE UserId = @UserId AND ServiceId = @ServiceId";
                            using (SqlCommand upCmd = new SqlCommand(updateQry, con))
                            {
                                upCmd.Parameters.AddWithValue("@UserId", userId);
                                upCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                                upCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            string insertQry = "INSERT INTO Cart (UserId, ServiceId, Quantity) VALUES (@UserId, @ServiceId, 1)";
                            using (SqlCommand insCmd = new SqlCommand(insertQry, con))
                            {
                                insCmd.Parameters.AddWithValue("@UserId", userId);
                                insCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                                insCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }

            // Cart page par redirect karo
            Response.Redirect("Cart.aspx");
        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            // Login check
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                int serviceId = Convert.ToInt32(id);
                int userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 1;

                // Wishlist ma save karo
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    string checkQry = "SELECT 1 FROM Wishlist WHERE UserId = @UserId AND ServiceId = @ServiceId";
                    using (SqlCommand checkCmd = new SqlCommand(checkQry, con))
                    {
                        checkCmd.Parameters.AddWithValue("@UserId", userId);
                        checkCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                        object existing = checkCmd.ExecuteScalar();

                        if (existing == null)
                        {
                            string insertQry = "INSERT INTO Wishlist (UserId, ServiceId) VALUES (@UserId, @ServiceId)";
                            using (SqlCommand insCmd = new SqlCommand(insertQry, con))
                            {
                                insCmd.Parameters.AddWithValue("@UserId", userId);
                                insCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                                insCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }

            // Wishlist page par redirect karo
            Response.Redirect("Wishlist.aspx");
        }
    }
}