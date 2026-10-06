using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care.Admin
{
    public partial class ManageBookings : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString 
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public bool FilterPanelVisible { get; set; } = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("All Bookings", "Dashboard > All Bookings");
            }

            if (!IsPostBack)
            {
                // Check if status passed via QueryString
                if (!string.IsNullOrEmpty(Request.QueryString["status"]))
                {
                    ViewState["SelectedStatus"] = Request.QueryString["status"].Trim().ToLower();
                }
                else
                {
                    ViewState["SelectedStatus"] = "";
                }

                if (!string.IsNullOrEmpty(Request.QueryString["q"]))
                {
                    txtSearch.Text = Request.QueryString["q"].Trim();
                }

                LoadTabCounts();
                LoadBookings();
            }
        }

        private void LoadTabCounts()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"
                    SELECT 
                        COUNT(*) AS TotalAll,
                        SUM(CASE WHEN LOWER(BookingStatus) IN ('pending', 'upcoming', 'action required') THEN 1 ELSE 0 END) AS TotalPending,
                        SUM(CASE WHEN LOWER(BookingStatus) = 'in progress' THEN 1 ELSE 0 END) AS TotalInProgress,
                        SUM(CASE WHEN LOWER(BookingStatus) = 'completed' THEN 1 ELSE 0 END) AS TotalCompleted
                    FROM Bookings;";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    try
                    {
                        con.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                lblCountAll.Text = dr["TotalAll"] != DBNull.Value ? dr["TotalAll"].ToString() : "0";
                                lblCountPending.Text = dr["TotalPending"] != DBNull.Value ? dr["TotalPending"].ToString() : "0";
                                lblCountInProgress.Text = dr["TotalInProgress"] != DBNull.Value ? dr["TotalInProgress"].ToString() : "0";
                                lblCountCompleted.Text = dr["TotalCompleted"] != DBNull.Value ? dr["TotalCompleted"].ToString() : "0";
                            }
                        }
                    }
                    catch (Exception)
                    {
                        // Fallback defaults
                        lblCountAll.Text = "0";
                        lblCountPending.Text = "0";
                        lblCountInProgress.Text = "0";
                        lblCountCompleted.Text = "0";
                    }
                }
            }
        }

        private void LoadBookings()
        {
            string selectedStatus = ViewState["SelectedStatus"]?.ToString() ?? "";
            string searchKeyword = txtSearch.Text.Trim();
            string fromDate = txtFromDate.Text.Trim();
            string toDate = txtToDate.Text.Trim();
            string payStatus = ddlPaymentStatus.SelectedValue;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"
                    SELECT 
                        b.BookingId,
                        b.BookingCode,
                        ISNULL(u.FullName, 'Customer') AS FullName,
                        ISNULL(s.ServiceName, 'Car Detailing Service') AS ServiceName,
                        ISNULL(b.VehicleDetails, 'Standard Vehicle') AS VehicleDetails,
                        b.SlotDate,
                        ISNULL(b.SlotTime, '10:00 AM') AS SlotTime,
                        ISNULL(b.TotalAmount, 0) AS TotalAmount,
                        ISNULL(b.PaymentStatus, 'Paid') AS PaymentStatus,
                        ISNULL(b.BookingStatus, 'Pending') AS BookingStatus,
                        b.TrackingStep
                    FROM Bookings b
                    LEFT JOIN Users u ON b.UserId = u.UserId
                    LEFT JOIN Services s ON b.ServiceId = s.ServiceId
                    WHERE 1 = 1 ";

                // Filter by Tab Status
                if (!string.IsNullOrEmpty(selectedStatus))
                {
                    if (selectedStatus == "pending")
                    {
                        sql += " AND LOWER(b.BookingStatus) IN ('pending', 'upcoming', 'action required') ";
                    }
                    else if (selectedStatus == "in progress")
                    {
                        sql += " AND LOWER(b.BookingStatus) = 'in progress' ";
                    }
                    else if (selectedStatus == "completed")
                    {
                        sql += " AND LOWER(b.BookingStatus) = 'completed' ";
                    }
                }

                // Filter by Search Keyword
                if (!string.IsNullOrEmpty(searchKeyword))
                {
                    sql += " AND (b.BookingCode LIKE @search OR u.FullName LIKE @search OR b.VehicleDetails LIKE @search OR s.ServiceName LIKE @search) ";
                }

                // Filter by Date
                if (!string.IsNullOrEmpty(fromDate))
                {
                    sql += " AND b.SlotDate >= @fromDate ";
                }
                if (!string.IsNullOrEmpty(toDate))
                {
                    sql += " AND b.SlotDate <= @toDate ";
                }

                // Filter by Payment Status
                if (!string.IsNullOrEmpty(payStatus))
                {
                    sql += " AND LOWER(b.PaymentStatus) = @payStatus ";
                }

                sql += " ORDER BY b.BookingId DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    if (!string.IsNullOrEmpty(searchKeyword))
                        cmd.Parameters.AddWithValue("@search", "%" + searchKeyword + "%");
                    if (!string.IsNullOrEmpty(fromDate))
                        cmd.Parameters.AddWithValue("@fromDate", fromDate);
                    if (!string.IsNullOrEmpty(toDate))
                        cmd.Parameters.AddWithValue("@toDate", toDate);
                    if (!string.IsNullOrEmpty(payStatus))
                        cmd.Parameters.AddWithValue("@payStatus", payStatus.ToLower());

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    // Add formatted SlotDateText column
                    dt.Columns.Add("SlotDateText", typeof(string));
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["SlotDate"] != DBNull.Value)
                        {
                            DateTime dtVal = Convert.ToDateTime(row["SlotDate"]);
                            row["SlotDateText"] = dtVal.ToString("dd MMM");
                        }
                        else
                        {
                            row["SlotDateText"] = "Today";
                        }
                    }

                    if (dt.Rows.Count > 0)
                    {
                        rptBookings.DataSource = dt;
                        rptBookings.DataBind();
                        rptBookings.Visible = true;
                        pnlEmpty.Visible = false;

                        if (!string.IsNullOrEmpty(searchKeyword))
                        {
                            lblResultInfo.Text = $"Showing {dt.Rows.Count:D2} result(s) for \"{Server.HtmlEncode(searchKeyword)}\"";
                        }
                        else if (!string.IsNullOrEmpty(selectedStatus))
                        {
                            lblResultInfo.Text = $"Showing {dt.Rows.Count:D2} {selectedStatus} booking(s)";
                        }
                        else
                        {
                            lblResultInfo.Text = $"Showing all {dt.Rows.Count:D2} booking(s)";
                        }
                    }
                    else
                    {
                        rptBookings.Visible = false;
                        pnlEmpty.Visible = true;
                        lblResultInfo.Text = "No matching bookings found.";
                    }
                }
            }
        }

        public string GetTabClass(string statusKey)
        {
            string current = ViewState["SelectedStatus"]?.ToString() ?? "";
            if (string.Equals(current, statusKey, StringComparison.OrdinalIgnoreCase))
            {
                return "tab-btn active";
            }
            return "tab-btn";
        }

        public string GetActionButtonHtml(string bookingCode, string bookingStatus)
        {
            string status = bookingStatus != null ? bookingStatus.Trim().ToLower() : "";
            if (status == "completed")
            {
                return $"<a href='Invoice.aspx?code={Server.UrlEncode(bookingCode)}' class='btn-view-receipt'>&#128196; View Details / Receipt</a>";
            }
            else
            {
                return $"<a href='UpdateBookingStatus.aspx?code={Server.UrlEncode(bookingCode)}' class='btn-update-status'>Update Status</a>";
            }
        }

        protected void Tab_Click(object sender, EventArgs e)
        {
            if (sender is LinkButton btn)
            {
                ViewState["SelectedStatus"] = btn.CommandArgument.Trim().ToLower();
                LoadBookings();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadBookings();
        }

        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            FilterPanelVisible = true;
            LoadBookings();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            txtFromDate.Text = "";
            txtToDate.Text = "";
            ddlPaymentStatus.SelectedIndex = 0;
            txtSearch.Text = "";
            ViewState["SelectedStatus"] = "";
            FilterPanelVisible = false;
            LoadBookings();
        }
    }
}
