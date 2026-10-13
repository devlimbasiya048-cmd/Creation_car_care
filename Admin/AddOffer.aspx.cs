using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class AddOffer : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public string AlertType { get; set; } = "success";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Add New Offer", "Offers > Add New Offer");
            }
        }

        protected void btnPublishOffer_Click(object sender, EventArgs e)
        {
            string promo = txtPromoCode.Text.Trim();
            string title = txtOfferTitle.Text.Trim();
            string disc = txtDiscountValue.Text.Trim();
            string desc = txtOfferDesc.Text.Trim();

            if (string.IsNullOrEmpty(promo) || string.IsNullOrEmpty(title) || string.IsNullOrEmpty(disc))
            {
                ShowAlert("Please fill in Promo Code, Offer Title, and Discount Value.", "error");
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"INSERT INTO Offers (PromoCode, OfferTitle, DiscountPercentage, OfferDescription, ValidityText, StartDate, EndDate, IsActive)
                               VALUES (@promo, @title, @disc, @desc, 'Valid for Limited Time', GETDATE(), DATEADD(month, 1, GETDATE()), 1)";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@promo", promo.ToUpper());
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@disc", disc);
                    cmd.Parameters.AddWithValue("@desc", string.IsNullOrEmpty(desc) ? "Valid on all vehicle packages." : desc);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        Response.Redirect("ManageOffers.aspx");
                    }
                    catch (Exception ex)
                    {
                        ShowAlert("Database error: " + ex.Message, "error");
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
