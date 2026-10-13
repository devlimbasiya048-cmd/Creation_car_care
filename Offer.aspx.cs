using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class Offer : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckActiveOfferState();
                BindOffers();
            }
        }

        private void CheckActiveOfferState()
        {
            if (Session["ActiveOfferDiscount"] != null && Session["ActiveOfferTitle"] != null)
            {
                pnlCurrentActiveOffer.Visible = true;
                lblCurrentOfferTitle.Text = Session["ActiveOfferTitle"].ToString();
                lblCurrentOfferDiscount.Text = Session["ActiveOfferDiscount"].ToString();
            }
            else
            {
                pnlCurrentActiveOffer.Visible = false;
            }
        }

        private void BindOffers()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT OfferId, DiscountPercentage, OfferTitle, OfferDescription, StartDate, EndDate, ValidityText FROM Offers";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            dt.Columns.Add("CalculatedStatus", typeof(string));
            dt.Columns.Add("StatusColor", typeof(string));
            dt.Columns.Add("IsActive", typeof(bool));
            dt.Columns.Add("ValidityDisplay", typeof(string));

            DateTime today = DateTime.Now.Date;

            foreach (DataRow row in dt.Rows)
            {
                DateTime startDate = Convert.ToDateTime(row["StartDate"]);
                DateTime endDate = Convert.ToDateTime(row["EndDate"]);

                row["ValidityDisplay"] = string.Format("Valid: {0:dd MMM yyyy} to {1:dd MMM yyyy}", startDate, endDate);

                if (today < startDate)
                {
                    row["CalculatedStatus"] = "Status: Upcoming";
                    row["StatusColor"] = "#ff9800"; // Orange
                    row["IsActive"] = false;
                }
                else if (today >= startDate && today <= endDate)
                {
                    row["CalculatedStatus"] = "Status: Active & Verified";
                    row["StatusColor"] = "#00c853"; // Green
                    row["IsActive"] = true;
                }
                else
                {
                    row["CalculatedStatus"] = "Status: Expired";
                    row["StatusColor"] = "#d32f2f"; // Red
                    row["IsActive"] = false;
                }
            }

            rptOffers.DataSource = dt;
            rptOffers.DataBind();
        }

        protected void rptOffers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ClaimOffer")
            {
                int offerId = Convert.ToInt32(e.CommandArgument);

                if (Session["UserEmail"] == null)
                {
                    // Guest user: save intended offer and redirect to login
                    Session["PendingOfferId"] = offerId;
                    Response.Redirect("Login.aspx?offer=1");
                    return;
                }

                // Logged-in user: activate offer and redirect to Services page
                ActivateOffer(offerId);
                Response.Redirect("ServicesList.aspx");
            }
        }

        private void ActivateOffer(int offerId)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT OfferId, OfferTitle, DiscountPercentage FROM Offers WHERE OfferId = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", offerId);
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string title = dr["OfferTitle"].ToString();
                            string discStr = dr["DiscountPercentage"].ToString().Replace("%", "").Trim();
                            decimal discount = 10m;
                            decimal.TryParse(discStr, out discount);

                            Session["ActiveOfferId"] = offerId;
                            Session["ActiveOfferTitle"] = title;
                            Session["ActiveOfferDiscount"] = discount;
                        }
                    }
                }
            }
        }

        protected void btnRemoveOffer_Click(object sender, EventArgs e)
        {
            Session.Remove("ActiveOfferId");
            Session.Remove("ActiveOfferTitle");
            Session.Remove("ActiveOfferDiscount");

            pnlCurrentActiveOffer.Visible = false;
            BindOffers();
        }
    }
}