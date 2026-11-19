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
            int offerId = GetOfferIdFromQuery();

            if (this.Master is Admin adminMaster)
            {
                if (offerId > 0)
                {
                    adminMaster.SetPageTitle("Edit Offer", "Offers > Edit Offer");
                    lblPageHeading.Text = "Edit Offer Details";
                    btnPublishOffer.Text = "UPDATE OFFER";
                }
                else
                {
                    adminMaster.SetPageTitle("Add New Offer", "Offers > Add New Offer");
                    lblPageHeading.Text = "Add New Offer";
                    btnPublishOffer.Text = "PUBLISH LIVE OFFER";
                }
            }

            if (!IsPostBack && offerId > 0)
            {
                LoadOfferForEdit(offerId);
            }
        }

        private int GetOfferIdFromQuery()
        {
            if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out int id))
            {
                return id;
            }
            return 0;
        }

        private void LoadOfferForEdit(int id)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT OfferId, PromoCode, OfferTitle, DiscountPercentage, OfferDescription, ValidityText FROM Offers WHERE OfferId = @id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    try
                    {
                        con.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                txtPromoCode.Text = dr["PromoCode"] != DBNull.Value ? dr["PromoCode"].ToString() : "";
                                txtOfferTitle.Text = dr["OfferTitle"] != DBNull.Value ? dr["OfferTitle"].ToString() : "";
                                txtDiscountValue.Text = dr["DiscountPercentage"] != DBNull.Value ? dr["DiscountPercentage"].ToString() : "";
                                txtOfferDesc.Text = dr["OfferDescription"] != DBNull.Value ? dr["OfferDescription"].ToString() : "";
                            }
                            else
                            {
                                ShowAlert("Offer not found.", "error");
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

            int offerId = GetOfferIdFromQuery();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql;
                if (offerId > 0)
                {
                    sql = @"UPDATE Offers 
                            SET PromoCode = @promo, OfferTitle = @title, DiscountPercentage = @disc, OfferDescription = @desc 
                            WHERE OfferId = @id";
                }
                else
                {
                    sql = @"INSERT INTO Offers (PromoCode, OfferTitle, DiscountPercentage, OfferDescription, ValidityText, StartDate, EndDate, IsActive)
                            VALUES (@promo, @title, @disc, @desc, 'Valid for Limited Time', GETDATE(), DATEADD(month, 1, GETDATE()), 1)";
                }

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@promo", promo.ToUpper());
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@disc", disc);
                    cmd.Parameters.AddWithValue("@desc", string.IsNullOrEmpty(desc) ? "Valid on all vehicle packages." : desc);
                    if (offerId > 0)
                    {
                        cmd.Parameters.AddWithValue("@id", offerId);
                    }

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
