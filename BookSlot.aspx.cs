using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class BookSlot : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        // Property to track selected date for Repeater active class
        public string SelectedDateString
        {
            get { return hfSelectedDate.Value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Month header set karo (e.g. "October 2026")
                lblCurrentMonth.Text = DateTime.Now.ToString("MMMM yyyy");

                // Default date: Tomorrow
                DateTime defaultDate = DateTime.Now.AddDays(1);
                hfSelectedDate.Value = defaultDate.ToString("yyyy-MM-dd");

                // Default slot: 10:30 AM
                hfSelectedTime.Value = "10:30 AM";

                LoadVehicleDetails();
                LoadCartSummary();
                GenerateDateList();
                UpdateSummaryDisplay();
                HighlightActiveSlotButton("10:30 AM");
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);
            return 1;
        }

        // User ni registered vehicle fetch karo
        private void LoadVehicleDetails()
        {
            int userId = GetCurrentUserId();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT Brand, ModelName, RegistrationNumber FROM Vehicles WHERE UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string model = reader["ModelName"].ToString();
                            string reg = reader["RegistrationNumber"].ToString();
                            lblVehicleDetails.Text = string.Format("{0} ({1})", model, reg);
                            Session["BookingVehicle"] = lblVehicleDetails.Text;
                        }
                        else
                        {
                            lblVehicleDetails.Text = "Hyundai Creta (GJ 03 AB 1234)";
                            Session["BookingVehicle"] = lblVehicleDetails.Text;
                        }
                    }
                }
            }
        }

        // Cart mathi total items ane price load karo
        private void LoadCartSummary()
        {
            int userId = GetCurrentUserId();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = @"SELECT COUNT(c.CartId) AS TotalItems, SUM(c.Quantity * s.Price) AS TotalAmount 
                                 FROM Cart c 
                                 INNER JOIN Services s ON c.ServiceId = s.ServiceId 
                                 WHERE c.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read() && reader["TotalItems"] != DBNull.Value && Convert.ToInt32(reader["TotalItems"]) > 0)
                        {
                            int count = Convert.ToInt32(reader["TotalItems"]);
                            decimal subtotal = Convert.ToDecimal(reader["TotalAmount"]);

                            lblServiceCount.Text = count == 1 ? "1 Service" : count + " Services";

                            // Check active offer discount
                            bool hasOffer = (Session["ActiveOfferDiscount"] != null);
                            if (hasOffer)
                            {
                                decimal discountPercent = Convert.ToDecimal(Session["ActiveOfferDiscount"]);
                                decimal discountAmount = subtotal * (discountPercent / 100m);
                                decimal finalAmount = subtotal - discountAmount;

                                lblSummaryAmount.Text = string.Format("{0:N0}", finalAmount);

                                pnlSlotOfferRow.Visible = true;
                                lblSlotOfferText.Text = discountPercent.ToString("0") + "% OFF (-&#8377;" + string.Format("{0:N0}", discountAmount) + ")";

                                Session["CartTotalAmount"] = finalAmount;
                                Session["CartOriginalSubtotal"] = subtotal;
                                Session["CartDiscountAmount"] = discountAmount;
                            }
                            else
                            {
                                pnlSlotOfferRow.Visible = false;
                                lblSummaryAmount.Text = string.Format("{0:N0}", subtotal);

                                Session["CartTotalAmount"] = subtotal;
                                Session["CartOriginalSubtotal"] = subtotal;
                                Session["CartDiscountAmount"] = 0m;
                            }
                        }
                        else
                        {
                            // Fallback default amount
                            lblServiceCount.Text = "1 Service";
                            lblSummaryAmount.Text = "2,700";
                            Session["CartTotalAmount"] = 2700m;
                        }
                    }
                }
            }
        }

        // Next 6 days ni list create karo
        private void GenerateDateList()
        {
            DataTable dtDates = new DataTable();
            dtDates.Columns.Add("DayName", typeof(string));
            dtDates.Columns.Add("DayNumber", typeof(string));
            dtDates.Columns.Add("DateValue", typeof(string));

            DateTime start = DateTime.Now.AddDays(1);
            for (int i = 0; i < 6; i++)
            {
                DateTime d = start.AddDays(i);
                DataRow r = dtDates.NewRow();
                r["DayName"] = d.ToString("ddd"); // Tue, Wed, etc.
                r["DayNumber"] = d.ToString("dd"); // 11, 12, etc.
                r["DateValue"] = d.ToString("yyyy-MM-dd");
                dtDates.Rows.Add(r);
            }

            rptDates.DataSource = dtDates;
            rptDates.DataBind();
        }

        // Date selection click
        protected void btnDateSelect_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            hfSelectedDate.Value = btn.CommandArgument;
            GenerateDateList();
            UpdateSummaryDisplay();
            HighlightActiveSlotButton(hfSelectedTime.Value);
        }

        // Time slot selection click
        protected void btnSlot_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string slot = btn.CommandArgument;
            hfSelectedTime.Value = slot;

            UpdateSummaryDisplay();
            HighlightActiveSlotButton(slot);
        }

        private void HighlightActiveSlotButton(string activeSlot)
        {
            LinkButton[] allSlots = new LinkButton[] { btnSlot1, btnSlot2, btnSlot3, btnSlot4, btnSlot5, btnSlot6 };
            foreach (LinkButton b in allSlots)
            {
                if (b.CommandArgument == activeSlot)
                {
                    b.CssClass = "slot-btn active";
                }
                else
                {
                    b.CssClass = "slot-btn";
                }
            }
        }

        private void UpdateSummaryDisplay()
        {
            if (!string.IsNullOrEmpty(hfSelectedDate.Value) && !string.IsNullOrEmpty(hfSelectedTime.Value))
            {
                DateTime dt = DateTime.Parse(hfSelectedDate.Value);
                lblSelectedSlotDisplay.Text = string.Format("{0:dd MMM}, {1}", dt, hfSelectedTime.Value);
            }
        }

        // Proceed to Payment page
        protected void btnProceedPay_Click(object sender, EventArgs e)
        {
            Session["BookingSlotDate"] = hfSelectedDate.Value;
            Session["BookingSlotTime"] = hfSelectedTime.Value;
            Session["BookingVehicle"] = lblVehicleDetails.Text;

            Response.Redirect("Payment.aspx");
        }
    }
}
