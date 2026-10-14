using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class Reschedule : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public string SelectedDateString
        {
            get { return hfNewDate.Value; }
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
                string id = Request.QueryString["id"];

                // Default new date: 7 days from now
                DateTime defaultDate = DateTime.Now.AddDays(7);
                hfNewDate.Value = defaultDate.ToString("yyyy-MM-dd");
                hfNewTime.Value = "11:30 AM";

                LoadBookingDetails(id);
                GenerateDateList();
                UpdateSummaryDisplay();
                HighlightActiveSlotButton("11:30 AM");
            }
        }

        private void LoadBookingDetails(string bookingId)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = @"SELECT TOP 1 b.BookingId, b.BookingCode, b.SlotDate, b.SlotTime, s.ServiceName 
                                 FROM Bookings b 
                                 INNER JOIN Services s ON b.ServiceId = s.ServiceId 
                                 WHERE (@Id IS NULL OR b.BookingId = @Id)
                                 ORDER BY b.BookingId DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", string.IsNullOrEmpty(bookingId) ? (object)DBNull.Value : bookingId);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            ViewState["RescheduleBookingId"] = reader["BookingId"];
                            lblCurrentBookingInfo.Text = string.Format("{0} • {1}", reader["BookingCode"], reader["ServiceName"]);

                            DateTime prevDate = Convert.ToDateTime(reader["SlotDate"]);
                            string prevTime = reader["SlotTime"].ToString();
                            lblPrevSlot.Text = string.Format("{0:dd MMM}, {1}", prevDate, prevTime);
                        }
                    }
                }
            }
        }

        private void GenerateDateList()
        {
            DataTable dtDates = new DataTable();
            dtDates.Columns.Add("DayName", typeof(string));
            dtDates.Columns.Add("DayNumber", typeof(string));
            dtDates.Columns.Add("DateValue", typeof(string));

            DateTime start = DateTime.Now.AddDays(7);
            for (int i = 0; i < 6; i++)
            {
                DateTime d = start.AddDays(i);
                DataRow r = dtDates.NewRow();
                r["DayName"] = d.ToString("ddd");
                r["DayNumber"] = d.ToString("dd");
                r["DateValue"] = d.ToString("yyyy-MM-dd");
                dtDates.Rows.Add(r);
            }

            rptDates.DataSource = dtDates;
            rptDates.DataBind();
        }

        protected void btnDateSelect_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            hfNewDate.Value = btn.CommandArgument;
            GenerateDateList();
            UpdateSummaryDisplay();
            HighlightActiveSlotButton(hfNewTime.Value);
        }

        protected void btnSlot_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string slot = btn.CommandArgument;
            hfNewTime.Value = slot;

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
            if (!string.IsNullOrEmpty(hfNewDate.Value) && !string.IsNullOrEmpty(hfNewTime.Value))
            {
                DateTime dt = DateTime.Parse(hfNewDate.Value);
                lblNewSlotDisplay.Text = string.Format("{0:dd MMM}, {1}", dt, hfNewTime.Value);
            }
        }

        protected void btnConfirmReschedule_Click(object sender, EventArgs e)
        {
            if (ViewState["RescheduleBookingId"] != null)
            {
                int bookingId = Convert.ToInt32(ViewState["RescheduleBookingId"]);
                DateTime newDate = DateTime.Parse(hfNewDate.Value);
                string newTime = hfNewTime.Value;

                using (SqlConnection con = new SqlConnection(connString))
                {
                    string updateQry = "UPDATE Bookings SET SlotDate = @NewDate, SlotTime = @NewTime, BookingStatus = 'Upcoming' WHERE BookingId = @BookingId";
                    using (SqlCommand cmd = new SqlCommand(updateQry, con))
                    {
                        cmd.Parameters.AddWithValue("@NewDate", newDate);
                        cmd.Parameters.AddWithValue("@NewTime", newTime);
                        cmd.Parameters.AddWithValue("@BookingId", bookingId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            // Redirect back to bookings page
            Response.Redirect("Booking.aspx");
        }
    }
}
