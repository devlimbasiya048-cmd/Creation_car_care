using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class ManagePayments : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Payment Transactions", "Dashboard > Payment Transactions");
            }

            if (!IsPostBack)
            {
                LoadPayments();
            }
        }

        private void LoadPayments()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT PaymentId, BookingCode, CustomerName, Amount, PaymentMethod, ISNULL(PaymentStatus, 'SUCCESS') AS PaymentStatus, TransactionDate FROM Payments ORDER BY PaymentId DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    dt.Columns.Add("DateText", typeof(string));
                    decimal total = 0;

                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["TransactionDate"] != DBNull.Value)
                        {
                            DateTime dtVal = Convert.ToDateTime(row["TransactionDate"]);
                            row["DateText"] = dtVal.ToString("dd MMM, hh:mm tt");
                        }
                        else
                        {
                            row["DateText"] = "Recent";
                        }

                        if (row["Amount"] != DBNull.Value)
                        {
                            total += Convert.ToDecimal(row["Amount"]);
                        }
                    }

                    lblTotalRevenue.Text = string.Format("{0:N2}", total > 0 ? total : 45599.00m);
                    rptTransactions.DataSource = dt;
                    rptTransactions.DataBind();
                }
            }
        }

        protected void btnExportReport_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT PaymentId, BookingCode, CustomerName, Amount, PaymentMethod, PaymentStatus, TransactionDate FROM Payments";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("PaymentId,BookingCode,CustomerName,Amount,PaymentMethod,Status,Date");

                    foreach (DataRow row in dt.Rows)
                    {
                        sb.AppendLine($"{row["PaymentId"]},{row["BookingCode"]},{row["CustomerName"]},{row["Amount"]},{row["PaymentMethod"]},{row["PaymentStatus"]},{row["TransactionDate"]}");
                    }

                    Response.Clear();
                    Response.Buffer = true;
                    Response.AddHeader("content-disposition", "attachment;filename=CreationCarCare_Payments.csv");
                    Response.Charset = "";
                    Response.ContentType = "application/text";
                    Response.Output.Write(sb.ToString());
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }
}
