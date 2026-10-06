using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class UpdateBookingStatus : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public string AlertType { get; set; } = "success";
        private int currentStep = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Update Order Status", "Bookings > Update Status");
            }

            if (!IsPostBack)
            {
                string bookingCode = Request.QueryString["code"]?.Trim();
                LoadBookingDetails(bookingCode);
            }
            else
            {
                if (int.TryParse(ddlTrackingStep.SelectedValue, out int s))
                {
                    currentStep = s;
                }
            }
        }

        private void LoadBookingDetails(string bookingCode)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"
                    SELECT TOP 1
                        b.BookingId,
                        b.BookingCode,
                        ISNULL(u.FullName, 'Customer') AS FullName,
                        ISNULL(s.ServiceName, 'Car Detailing') AS ServiceName,
                        ISNULL(b.VehicleDetails, 'Standard Vehicle') AS VehicleDetails,
                        b.SlotDate,
                        b.SlotTime,
                        ISNULL(b.TotalAmount, 0) AS TotalAmount,
                        ISNULL(b.BookingStatus, 'Pending') AS BookingStatus,
                        ISNULL(b.TrackingStep, 1) AS TrackingStep,
                        ISNULL(b.Notes, '') AS Notes,
                        ISNULL(b.CancellationReason, '') AS CancellationReason,
                        b.CreatedAt
                    FROM Bookings b
                    LEFT JOIN Users u ON b.UserId = u.UserId
                    LEFT JOIN Services s ON b.ServiceId = s.ServiceId
                    WHERE (@code IS NULL OR @code = '' OR b.BookingCode = @code)
                    ORDER BY b.BookingId DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@code", string.IsNullOrEmpty(bookingCode) ? (object)DBNull.Value : bookingCode);

                    try
                    {
                        con.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                string code = dr["BookingCode"].ToString();
                                lblBookingCode.Text = code;
                                lblCustomerName.Text = dr["FullName"].ToString();
                                lblVehicleDetails.Text = dr["VehicleDetails"].ToString();
                                lblServiceName.Text = dr["ServiceName"].ToString();

                                ViewState["CurrentBookingCode"] = code;
                                ViewState["TotalAmount"] = dr["TotalAmount"];

                                int step = Convert.ToInt32(dr["TrackingStep"]);
                                currentStep = step;
                                if (ddlTrackingStep.Items.FindByValue(step.ToString()) != null)
                                {
                                    ddlTrackingStep.SelectedValue = step.ToString();
                                }

                                txtNotes.Text = dr["Notes"].ToString();
                                txtCancellationReason.Text = dr["CancellationReason"].ToString();

                                if (dr["CreatedAt"] != DBNull.Value)
                                {
                                    DateTime dt = Convert.ToDateTime(dr["CreatedAt"]);
                                    lblStep1Date.Text = "Booking confirmed on " + dt.ToString("dd MMM, hh:mm tt");
                                }

                                string status = dr["BookingStatus"].ToString().Trim();
                                ApplyStatusToUI(status);

                                lnkViewInvoice.NavigateUrl = $"Invoice.aspx?code={Server.UrlEncode(code)}";
                            }
                            else
                            {
                                ShowAlert("Booking not found. Please select a valid booking.", "error");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowAlert("Database error: " + ex.Message, "error");
                    }
                }
            }
        }

        private void ApplyStatusToUI(string status)
        {
            rbPending.Checked = false;
            rbInProgress.Checked = false;
            rbCompleted.Checked = false;
            rbCancelled.Checked = false;

            string lower = status.ToLower();
            if (lower == "in progress")
            {
                rbInProgress.Checked = true;
                lblStatusBadge.Text = "IN PROGRESS";
                lblStatusBadge.CssClass = "booking-status-badge badge-inprogress";
            }
            else if (lower == "completed")
            {
                rbCompleted.Checked = true;
                lblStatusBadge.Text = "COMPLETED";
                lblStatusBadge.CssClass = "booking-status-badge badge-completed";
            }
            else if (lower == "cancelled")
            {
                rbCancelled.Checked = true;
                lblStatusBadge.Text = "CANCELLED";
                lblStatusBadge.CssClass = "booking-status-badge badge-cancelled";
            }
            else
            {
                rbPending.Checked = true;
                lblStatusBadge.Text = "PENDING";
                lblStatusBadge.CssClass = "booking-status-badge badge-pending";
            }
        }

        public string GetStepClass(int stepNumber)
        {
            if (stepNumber < currentStep)
            {
                return "timeline-item completed";
            }
            else if (stepNumber == currentStep)
            {
                return "timeline-item active";
            }
            else
            {
                return "timeline-item";
            }
        }

        public string GetStepDot(int stepNumber)
        {
            if (stepNumber < currentStep)
            {
                return "&#10003;"; // checkmark
            }
            else
            {
                return stepNumber.ToString();
            }
        }

        protected void ddlTrackingStep_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.TryParse(ddlTrackingStep.SelectedValue, out int s))
            {
                currentStep = s;
                if (currentStep == 5)
                {
                    rbCompleted.Checked = true;
                    rbInProgress.Checked = false;
                }
                else if (currentStep >= 2 && currentStep <= 4)
                {
                    rbInProgress.Checked = true;
                    rbCompleted.Checked = false;
                }
            }
        }

        protected void btnUpdateStatusNow_Click(object sender, EventArgs e)
        {
            string code = ViewState["CurrentBookingCode"]?.ToString();
            if (string.IsNullOrEmpty(code))
            {
                code = lblBookingCode.Text.Trim();
            }

            int step = Convert.ToInt32(ddlTrackingStep.SelectedValue);
            string newStatus = "Pending";

            if (rbInProgress.Checked)
            {
                newStatus = "In Progress";
            }
            else if (rbCompleted.Checked)
            {
                newStatus = "Completed";
                step = 5; // ensure completion stage
                ddlTrackingStep.SelectedValue = "5";
            }
            else if (rbCancelled.Checked)
            {
                newStatus = "Cancelled";
            }

            currentStep = step;
            string notes = txtNotes.Text.Trim();
            string cancellationReason = txtCancellationReason.Text.Trim();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string updateSql = @"
                    UPDATE Bookings 
                    SET BookingStatus = @status, 
                        TrackingStep = @step, 
                        Notes = @notes, 
                        CancellationReason = @reason 
                    WHERE BookingCode = @code;

                    INSERT INTO AdminActivities (ActivityType, Title, Description, BadgeColor, Amount)
                    VALUES ('Status Update', 'Booking ' + @code + ' Updated', 'Status set to ' + @status + ', Live step ' + CAST(@step AS VARCHAR), 
                            CASE WHEN @status = 'Completed' THEN '#10b981' WHEN @status = 'Cancelled' THEN '#ef4444' ELSE '#ea580c' END,
                            @amount);";

                using (SqlCommand cmd = new SqlCommand(updateSql, con))
                {
                    cmd.Parameters.AddWithValue("@status", newStatus);
                    cmd.Parameters.AddWithValue("@step", step);
                    cmd.Parameters.AddWithValue("@notes", string.IsNullOrEmpty(notes) ? (object)DBNull.Value : notes);
                    cmd.Parameters.AddWithValue("@reason", string.IsNullOrEmpty(cancellationReason) ? (object)DBNull.Value : cancellationReason);
                    cmd.Parameters.AddWithValue("@code", code);
                    cmd.Parameters.AddWithValue("@amount", ViewState["TotalAmount"] ?? 0);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        ApplyStatusToUI(newStatus);
                        ShowAlert($"Booking {code} successfully updated to '{newStatus}' (Step {step})!", "success");
                    }
                    catch (Exception ex)
                    {
                        ShowAlert("Failed to update status: " + ex.Message, "error");
                    }
                }
            }
        }

        private void ShowAlert(string msg, string type)
        {
            pnlAlert.Visible = true;
            lblAlert.Text = msg;
            AlertType = type;
        }
    }
}
