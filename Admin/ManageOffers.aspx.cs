using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care.Admin
{
    public partial class ManageOffers : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Manage Offers", "Dashboard > Manage Offers");
            }

            if (!IsPostBack)
            {
                LoadOffers();
            }
        }

        private void LoadOffers()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT OfferId, ISNULL(PromoCode, 'OFFER20') AS PromoCode, DiscountPercentage, OfferTitle, OfferDescription, ValidityText, ISNULL(IsActive, 1) AS IsActive FROM Offers ORDER BY OfferId DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptOffers.DataSource = dt;
                    rptOffers.DataBind();
                }
            }
        }

        protected void rptOffers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int offerId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ToggleOffer")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "UPDATE Offers SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE OfferId = @id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@id", offerId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadOffers();
            }
            else if (e.CommandName == "DeleteOffer")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "DELETE FROM Offers WHERE OfferId = @id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@id", offerId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadOffers();
            }
        }
    }
}
