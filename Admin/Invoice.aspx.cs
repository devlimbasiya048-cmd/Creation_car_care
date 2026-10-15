using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class Invoice : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Invoice Details", "Bookings > Invoice");
            }

            if (!IsPostBack)
            {
                string code = Request.QueryString["code"]?.Trim();
                LoadInvoice(code);
            }
        }

        private void LoadInvoice(string bookingCode)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"
                    SELECT TOP 1
                        b.BookingId,
                        b.BookingCode,
                        b.VehicleDetails,
                        b.SlotDate,
                        b.SlotTime,
                        b.TotalAmount,
                        b.OriginalAmount,
                        b.DiscountAmount,
                        b.OfferTitle,
                        b.PaymentMethod,
                        b.PaymentStatus,
                        ISNULL(u.FullName, 'Valued Customer') AS FullName,
                        ISNULL(u.MobileNumber, '+91 98981 23456') AS MobileNumber,
                        ISNULL(s.ServiceName, 'Car Detailing Package') AS ServiceName,
                        ISNULL(s.Price, b.TotalAmount) AS ServiceBasePrice
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
                                lblInvoiceCode.Text = code.Replace("#CCC-", "#CCC-INV-");
                                lblCustomerName.Text = dr["FullName"].ToString();
                                lblCustomerPhone.Text = !string.IsNullOrEmpty(dr["MobileNumber"].ToString()) ? dr["MobileNumber"].ToString() : "+91 98981 23456";
                                lblVehicleDetails.Text = dr["VehicleDetails"].ToString();

                                if (dr["SlotDate"] != DBNull.Value)
                                {
                                    DateTime dt = Convert.ToDateTime(dr["SlotDate"]);
                                    lblInvoiceDate.Text = dt.ToString("dd MMM yyyy");
                                }
                                else
                                {
                                    lblInvoiceDate.Text = DateTime.Now.ToString("dd MMM yyyy");
                                }

                                lblSlotTime.Text = dr["SlotTime"].ToString();
                                lblServiceName.Text = dr["ServiceName"].ToString();

                                decimal total = dr["TotalAmount"] != DBNull.Value ? Convert.ToDecimal(dr["TotalAmount"]) : 0;
                                decimal original = dr["OriginalAmount"] != DBNull.Value ? Convert.ToDecimal(dr["OriginalAmount"]) : 0;
                                decimal discount = dr["DiscountAmount"] != DBNull.Value ? Convert.ToDecimal(dr["DiscountAmount"]) : 0;

                                decimal basePrice = original > 0 ? original : total;
                                lblServicePrice.Text = string.Format("{0:N2}", basePrice);

                                if (discount > 0)
                                {
                                    pnlDiscountRow.Visible = true;
                                    lblOfferTitle.Text = dr["OfferTitle"] != DBNull.Value ? dr["OfferTitle"].ToString() : "PROMO DISCOUNT";
                                    lblDiscountAmount.Text = string.Format("{0:N2}", discount);
                                }
                                else
                                {
                                    pnlDiscountRow.Visible = false;
                                }

                                lblTotalAmount.Text = string.Format("{0:N2}", total);
                                lblPaymentMethod.Text = dr["PaymentMethod"] != DBNull.Value ? dr["PaymentMethod"].ToString() : "Online UPI";
                                lblPaymentStatus.Text = dr["PaymentStatus"] != DBNull.Value ? dr["PaymentStatus"].ToString().ToUpper() : "PAID";
                            }
                        }
                    }
                    catch (Exception)
                    {
                        // Fallback defaults
                        lblInvoiceCode.Text = "#CCC-INV-100231";
                        lblCustomerName.Text = "Rahul Patel";
                        lblVehicleDetails.Text = "White Honda City Sedan";
                        lblServiceName.Text = "Ceramic Top Glaze";
                        lblTotalAmount.Text = "5,500.00";
                    }
                }
            }
        }
    }
}
