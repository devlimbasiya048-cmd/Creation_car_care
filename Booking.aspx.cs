using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class Booking : System.Web.UI.Page
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
                // By default: Upcoming tab show karo
                ShowUpcomingTab();
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

        // Upcoming Bookings Load karva mate
        private void LoadUpcomingBookings()
        {
            int userId = GetCurrentUserId();
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connString))
            {
                // Upcoming ane In Progress bookings fetch karo
                string query = @"SELECT b.BookingId, b.BookingCode, b.SlotDate, b.SlotTime, b.TotalAmount, 
                                 b.BookingStatus, b.TrackingStep, b.PaymentMethod,
                                 b.OfferTitle,
                                 ISNULL(b.DiscountAmount, CASE WHEN s.Price > b.TotalAmount THEN (s.Price - b.TotalAmount) ELSE 0 END) AS DiscountAmount,
                                 ISNULL(b.OriginalAmount, s.Price) AS OriginalAmount,
                                 s.ServiceName 
                                 FROM Bookings b 
                                 INNER JOIN Services s ON b.ServiceId = s.ServiceId 
                                 WHERE b.UserId = @UserId AND b.BookingStatus IN ('Upcoming', 'In Progress')
                                 ORDER BY b.SlotDate ASC";

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
                pnlNoUpcoming.Visible = false;
                rptUpcoming.Visible = true;
                rptUpcoming.DataSource = dt;
                rptUpcoming.DataBind();
            }
            else
            {
                pnlNoUpcoming.Visible = true;
                rptUpcoming.Visible = false;
            }
        }

        // History Bookings Load karva mate
        private void LoadHistoryBookings()
        {
            int userId = GetCurrentUserId();
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connString))
            {
                // Completed ane Cancelled bookings fetch karo
                string query = @"SELECT b.BookingId, b.BookingCode, b.SlotDate, b.SlotTime, b.TotalAmount, 
                                 b.BookingStatus, b.Rating, b.ReviewText, b.PaymentMethod,
                                 b.OfferTitle,
                                 ISNULL(b.DiscountAmount, CASE WHEN s.Price > b.TotalAmount THEN (s.Price - b.TotalAmount) ELSE 0 END) AS DiscountAmount,
                                 ISNULL(b.OriginalAmount, s.Price) AS OriginalAmount,
                                 s.ServiceName 
                                 FROM Bookings b 
                                 INNER JOIN Services s ON b.ServiceId = s.ServiceId 
                                 WHERE b.UserId = @UserId AND b.BookingStatus IN ('Completed', 'Cancelled')
                                 ORDER BY b.SlotDate DESC";

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
                pnlNoHistory.Visible = false;
                rptHistory.Visible = true;
                rptHistory.DataSource = dt;
                rptHistory.DataBind();
            }
            else
            {
                pnlNoHistory.Visible = true;
                rptHistory.Visible = false;
            }
        }

        // Upcoming Tab button click
        protected void btnTabUpcoming_Click(object sender, EventArgs e)
        {
            ShowUpcomingTab();
        }

        // History Tab button click
        protected void btnTabHistory_Click(object sender, EventArgs e)
        {
            ShowHistoryTab();
        }

        private void ShowUpcomingTab()
        {
            pnlUpcoming.Visible = true;
            pnlHistory.Visible = false;

            btnTabUpcoming.CssClass = "tab-btn tab-btn-active";
            btnTabHistory.CssClass = "tab-btn tab-btn-inactive";

            LoadUpcomingBookings();
        }

        private void ShowHistoryTab()
        {
            pnlUpcoming.Visible = false;
            pnlHistory.Visible = true;

            btnTabUpcoming.CssClass = "tab-btn tab-btn-inactive";
            btnTabHistory.CssClass = "tab-btn tab-btn-active";

            LoadHistoryBookings();
        }

        // Upcoming booking par cancel button click
        protected void rptUpcoming_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CancelBooking")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = "UPDATE Bookings SET BookingStatus = 'Cancelled' WHERE BookingId = @BookingId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@BookingId", bookingId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Visible = true;
                lblMessage.Text = "Booking cancelled successfully.";
                lblMessage.BackColor = System.Drawing.ColorTranslator.FromHtml("#fee2e2");
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#991b1b");

                LoadUpcomingBookings();
            }
        }

        // Helper to format star icons
        public string GetStarsHtml(object ratingObj)
        {
            if (ratingObj == null || ratingObj == DBNull.Value) return "";
            int rating = Convert.ToInt32(ratingObj);
            string stars = "";
            for (int i = 0; i < rating; i++) stars += "&#9733;";
            for (int i = rating; i < 5; i++) stars += "&#9734;";
            return stars;
        }

        // History booking par Submit Review button click
        protected void rptHistory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SubmitReview")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                DropDownList ddlRating = (DropDownList)e.Item.FindControl("ddlRating");
                TextBox txtReview = (TextBox)e.Item.FindControl("txtReview");

                int rating = 5;
                if (ddlRating != null && !string.IsNullOrEmpty(ddlRating.SelectedValue))
                {
                    rating = Convert.ToInt32(ddlRating.SelectedValue);
                }

                string review = "";
                if (txtReview != null)
                {
                    review = txtReview.Text.Trim();
                }

                using (SqlConnection con = new SqlConnection(connString))
                {
                    string qry = "UPDATE Bookings SET Rating = @Rating, ReviewText = @ReviewText WHERE BookingId = @BookingId";
                    using (SqlCommand cmd = new SqlCommand(qry, con))
                    {
                        cmd.Parameters.AddWithValue("@Rating", rating);
                        cmd.Parameters.AddWithValue("@ReviewText", string.IsNullOrEmpty(review) ? (object)DBNull.Value : review);
                        cmd.Parameters.AddWithValue("@BookingId", bookingId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Visible = true;
                lblMessage.Text = "&#10004; Thank you! Your rating (" + rating + " &#9733;) and review have been submitted successfully.";
                lblMessage.BackColor = System.Drawing.ColorTranslator.FromHtml("#ecfdf5");
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#065f46");

                ShowHistoryTab();
            }
        }
    }
}
