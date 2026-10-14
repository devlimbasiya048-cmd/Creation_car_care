using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care
{
    public partial class Payment : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrderAmounts();
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);
            return 1;
        }

        private void LoadOrderAmounts()
        {
            decimal originalSubtotal = 45599m;
            decimal finalPayable = 45599m;

            if (Session["CartOriginalSubtotal"] != null)
            {
                originalSubtotal = Convert.ToDecimal(Session["CartOriginalSubtotal"]);
            }
            else if (Session["CartTotalAmount"] != null)
            {
                originalSubtotal = Convert.ToDecimal(Session["CartTotalAmount"]);
            }

            if (Session["CartTotalAmount"] != null)
            {
                finalPayable = Convert.ToDecimal(Session["CartTotalAmount"]);
            }
            else
            {
                finalPayable = originalSubtotal;
            }

            // Check if offer is active
            if (Session["ActiveOfferDiscount"] != null)
            {
                decimal discPercent = Convert.ToDecimal(Session["ActiveOfferDiscount"]);
                string offerTitle = Session["ActiveOfferTitle"] != null ? Session["ActiveOfferTitle"].ToString() : "Special Offer";
                decimal discAmount = originalSubtotal - finalPayable;

                pnlCouponRow.Visible = true;
                lblDiscountLabel.Text = offerTitle + " (" + discPercent.ToString("0") + "% OFF)";
                lblDiscountAmount.Text = string.Format("{0:N0}", discAmount);
            }
            else
            {
                pnlCouponRow.Visible = false;
            }

            lblBannerTotal.Text = string.Format("{0:N0}", finalPayable);
            lblSubtotal.Text = string.Format("{0:N0}", originalSubtotal);
            lblTotalToPay.Text = string.Format("{0:N0}", finalPayable);
        }

        // Pay Now click thaya pachi: Booking create karo ane success card batao
        protected void btnPayNow_Click(object sender, EventArgs e)
        {
            int userId = GetCurrentUserId();
            decimal totalAmount = Session["CartTotalAmount"] != null ? Convert.ToDecimal(Session["CartTotalAmount"]) : 45599m;

            // Slot Date ane Time session mathi lo (jo na hoy to default lo)
            string slotDateStr = Session["BookingSlotDate"] != null ? Session["BookingSlotDate"].ToString() : DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
            string slotTime = Session["BookingSlotTime"] != null ? Session["BookingSlotTime"].ToString() : "10:30 AM";
            string vehicleDetails = Session["BookingVehicle"] != null ? Session["BookingVehicle"].ToString() : "Hyundai Creta (GJ 03 AB 1234)";

            DateTime slotDate = DateTime.Parse(slotDateStr);

            // Selected Payment Method - hidden field thi lo, fallback Request.Form
            string paymentMethod = !string.IsNullOrEmpty(hfPaymentMethod.Value) ? hfPaymentMethod.Value : (Request.Form["paymentOption"] ?? "Online UPI");

            // Offer ane discount session details
            string offerTitle = Session["ActiveOfferTitle"] != null ? Session["ActiveOfferTitle"].ToString() : null;
            decimal discountAmount = Session["CartDiscountAmount"] != null ? Convert.ToDecimal(Session["CartDiscountAmount"]) : 0m;
            decimal originalAmount = Session["CartOriginalSubtotal"] != null ? Convert.ToDecimal(Session["CartOriginalSubtotal"]) : totalAmount;

            // Random unique booking code generate karo (#CCC-XXXXXX)
            Random rnd = new Random();
            string bookingCode = "#CCC-" + rnd.Next(100000, 999999).ToString();

            // Default ServiceId 4 (PPF) or first service from cart
            int serviceId = 4;
            string serviceName = "Paint Protection Film (PPF)";

            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();

                // Cart mathi pehli service nu id ane name lo
                string cartQuery = @"SELECT TOP 1 c.ServiceId, s.ServiceName 
                                    FROM Cart c 
                                    INNER JOIN Services s ON c.ServiceId = s.ServiceId 
                                    WHERE c.UserId = @UserId";
                using (SqlCommand cartCmd = new SqlCommand(cartQuery, con))
                {
                    cartCmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader r = cartCmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            serviceId = Convert.ToInt32(r["ServiceId"]);
                            serviceName = r["ServiceName"].ToString();
                        }
                    }
                }

                // 1. Insert into Bookings table (including OfferTitle, DiscountAmount, OriginalAmount)
                string insertBooking = @"INSERT INTO Bookings 
                    (BookingCode, UserId, ServiceId, VehicleDetails, SlotDate, SlotTime, TotalAmount, PaymentMethod, PaymentStatus, BookingStatus, TrackingStep, OfferTitle, DiscountAmount, OriginalAmount) 
                    VALUES 
                    (@Code, @UserId, @ServiceId, @Vehicle, @SlotDate, @SlotTime, @Total, @Method, 'Paid', 'Upcoming', 1, @OfferTitle, @DiscountAmount, @OriginalAmount)";

                using (SqlCommand cmd = new SqlCommand(insertBooking, con))
                {
                    cmd.Parameters.AddWithValue("@Code", bookingCode);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    cmd.Parameters.AddWithValue("@Vehicle", vehicleDetails);
                    cmd.Parameters.AddWithValue("@SlotDate", slotDate);
                    cmd.Parameters.AddWithValue("@SlotTime", slotTime);
                    cmd.Parameters.AddWithValue("@Total", totalAmount);
                    cmd.Parameters.AddWithValue("@Method", paymentMethod);
                    cmd.Parameters.AddWithValue("@OfferTitle", string.IsNullOrEmpty(offerTitle) ? (object)DBNull.Value : offerTitle);
                    cmd.Parameters.AddWithValue("@DiscountAmount", discountAmount > 0 ? (object)discountAmount : (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@OriginalAmount", originalAmount > 0 ? (object)originalAmount : (object)DBNull.Value);
                    cmd.ExecuteNonQuery();
                }

                // 2. Clear User's Cart
                string clearCart = "DELETE FROM Cart WHERE UserId = @UserId";
                using (SqlCommand delCmd = new SqlCommand(clearCart, con))
                {
                    delCmd.Parameters.AddWithValue("@UserId", userId);
                    delCmd.ExecuteNonQuery();
                }
            }

            // Success Panel par data set karo
            lblSuccessCode.Text = bookingCode;
            lblSuccessService.Text = serviceName;
            lblSuccessSlot.Text = string.Format("{0:dddd, dd MMM yyyy} at {1}", slotDate, slotTime);
            lblSuccessPaid.Text = string.Format("{0:N0}", totalAmount);
            lblSuccessMethod.Text = paymentMethod;

            if (discountAmount > 0)
            {
                pnlSuccessOffer.Visible = true;
                lblSuccessOffer.Text = (string.IsNullOrEmpty(offerTitle) ? "Offer Discount" : offerTitle) + " (-&#8377;" + string.Format("{0:N0}", discountAmount) + " Saved)";
            }
            else
            {
                pnlSuccessOffer.Visible = false;
            }

            // Step 1 hide karo, Step 2 (Success card) show karo
            pnlPaymentForm.Visible = false;
            pnlSuccess.Visible = true;
        }
    }
}
