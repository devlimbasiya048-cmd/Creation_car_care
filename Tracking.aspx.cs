using System;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class Tracking : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        // Current Tracking Step (1 to 5)
        public int CurrentStep = 3;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string code = Request.QueryString["code"];
                LoadTrackingData(code);
            }
        }

        private void LoadTrackingData(string code)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = @"SELECT TOP 1 b.BookingCode, b.VehicleDetails, b.BookingStatus, 
                                 b.TrackingStep, b.SlotDate, b.SlotTime, s.ServiceName 
                                 FROM Bookings b 
                                 INNER JOIN Services s ON b.ServiceId = s.ServiceId 
                                 WHERE (@Code IS NULL OR b.BookingCode = @Code)
                                 ORDER BY b.BookingId DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Code", string.IsNullOrEmpty(code) ? (object)DBNull.Value : code);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblOrderId.Text = reader["BookingCode"].ToString();
                            lblVehicle.Text = reader["VehicleDetails"] != DBNull.Value ? reader["VehicleDetails"].ToString() : "Hyundai Creta (GJ 03 AB 1234)";
                            lblServiceName.Text = reader["ServiceName"].ToString();
                            lblStatusBadge.Text = reader["BookingStatus"].ToString().ToUpper();

                            if (reader["TrackingStep"] != DBNull.Value)
                            {
                                CurrentStep = Convert.ToInt32(reader["TrackingStep"]);
                            }
                            else
                            {
                                CurrentStep = 3;
                            }
                        }
                    }
                }
            }
        }

        // Stepper item CSS class (completed, active, pending)
        public string GetStepClass(int stepNumber)
        {
            if (stepNumber < CurrentStep)
            {
                return "stepper-step completed step-completed";
            }
            else if (stepNumber == CurrentStep)
            {
                return "stepper-step step-active";
            }
            else
            {
                return "stepper-step step-pending";
            }
        }

        // Stepper icon (check, step number)
        public string GetStepIcon(int stepNumber)
        {
            if (stepNumber < CurrentStep)
            {
                return "&#10004;"; // Checkmark
            }
            else if (stepNumber == CurrentStep)
            {
                return stepNumber.ToString();
            }
            else
            {
                return stepNumber.ToString();
            }
        }
    }
}
