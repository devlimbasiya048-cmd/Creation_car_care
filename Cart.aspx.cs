using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class Cart : System.Web.UI.Page
    {
        // Database Connection String
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Login check: user login na hoy to login page par redirect karo
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }

        // Helper method: Current logged in user ni ID મેળવવા માટે
        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null)
            {
                return Convert.ToInt32(Session["UserId"]);
            }

            // Fallback: Jo Session ma UserId na hoy to Email thi fetch karo
            if (Session["UserEmail"] != null)
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string qry = "SELECT UserId FROM Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(qry, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", Session["UserEmail"].ToString());
                        con.Open();
                        object val = cmd.ExecuteScalar();
                        if (val != null)
                        {
                            Session["UserId"] = Convert.ToInt32(val);
                            return Convert.ToInt32(val);
                        }
                    }
                }
            }

            return 1; // Default fallback for local testing
        }

        // Method: Cart items load karva ane Total calculate karva mate
        private void LoadCartItems()
        {
            int userId = GetCurrentUserId();
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = @"SELECT c.CartId, c.Quantity, s.ServiceId, s.ServiceName, s.Price, 
                                 (c.Quantity * s.Price) AS TotalItemPrice 
                                 FROM Cart c 
                                 INNER JOIN Services s ON c.ServiceId = s.ServiceId 
                                 WHERE c.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                pnlEmptyCart.Visible = false;
                pnlBillDetails.Visible = true;
                rptCartItems.Visible = true;

                // Dynamic pricing columns for repeater
                dt.Columns.Add("OriginalPriceFormatted", typeof(string));
                dt.Columns.Add("DiscountedPriceFormatted", typeof(string));
                dt.Columns.Add("HasDiscount", typeof(bool));
                dt.Columns.Add("DiscountBadge", typeof(string));

                bool hasOffer = (Session["ActiveOfferDiscount"] != null);
                decimal discountPercent = 0;
                if (hasOffer)
                {
                    decimal.TryParse(Session["ActiveOfferDiscount"].ToString(), out discountPercent);
                }

                decimal originalSubtotal = 0;

                foreach (DataRow row in dt.Rows)
                {
                    decimal unitPrice = Convert.ToDecimal(row["Price"]);
                    int qty = Convert.ToInt32(row["Quantity"]);
                    originalSubtotal += (unitPrice * qty);

                    if (hasOffer && discountPercent > 0)
                    {
                        decimal itemDiscount = unitPrice * (discountPercent / 100m);
                        decimal finalUnitPrice = unitPrice - itemDiscount;

                        row["HasDiscount"] = true;
                        row["OriginalPriceFormatted"] = unitPrice.ToString("N0");
                        row["DiscountedPriceFormatted"] = finalUnitPrice.ToString("N0");
                        row["DiscountBadge"] = discountPercent.ToString("0") + "% OFF";
                    }
                    else
                    {
                        row["HasDiscount"] = false;
                        row["OriginalPriceFormatted"] = unitPrice.ToString("N0");
                        row["DiscountedPriceFormatted"] = unitPrice.ToString("N0");
                        row["DiscountBadge"] = "";
                    }
                }

                rptCartItems.DataSource = dt;
                rptCartItems.DataBind();

                // Bill Details Calculation
                lblItemTotal.Text = string.Format("{0:N0}", originalSubtotal);

                if (hasOffer && discountPercent > 0)
                {
                    decimal discountAmount = originalSubtotal * (discountPercent / 100m);
                    decimal finalPayable = originalSubtotal - discountAmount;

                    // Show Offer Applied Banner
                    pnlActiveOfferBanner.Visible = true;
                    pnlCheckOffers.Visible = false;
                    string offerTitle = Session["ActiveOfferTitle"] != null ? Session["ActiveOfferTitle"].ToString() : "Special Offer";
                    lblOfferBannerTitle.Text = offerTitle;
                    lblOfferBannerPercent.Text = discountPercent.ToString("0");

                    // Show Discount Row in Bill Card
                    pnlOfferDiscountRow.Visible = true;
                    lblOfferDiscountPercent.Text = discountPercent.ToString("0");
                    lblOfferDiscountAmount.Text = string.Format("{0:N0}", discountAmount);

                    // Final Payable
                    lblTotalAmount.Text = string.Format("{0:N0}", finalPayable);

                    // Store in Session for Slot & Payment pages
                    Session["CartTotalAmount"] = finalPayable;
                    Session["CartOriginalSubtotal"] = originalSubtotal;
                    Session["CartDiscountAmount"] = discountAmount;
                }
                else
                {
                    pnlActiveOfferBanner.Visible = false;
                    pnlCheckOffers.Visible = true;
                    pnlOfferDiscountRow.Visible = false;
                    lblTotalAmount.Text = string.Format("{0:N0}", originalSubtotal);

                    Session["CartTotalAmount"] = originalSubtotal;
                    Session["CartOriginalSubtotal"] = originalSubtotal;
                    Session["CartDiscountAmount"] = 0m;
                }
            }
            else
            {
                pnlActiveOfferBanner.Visible = false;
                pnlCheckOffers.Visible = false;
                pnlEmptyCart.Visible = true;
                pnlBillDetails.Visible = false;
                rptCartItems.Visible = false;
            }
        }

        // Cart items par actions (Quantity vadharvi, ghatadvi, Delete karvi)
        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int cartId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Increase")
            {
                UpdateCartQuantity(cartId, 1);
            }
            else if (e.CommandName == "Decrease")
            {
                UpdateCartQuantity(cartId, -1);
            }
            else if (e.CommandName == "RemoveItem")
            {
                DeleteCartItem(cartId);
            }

            // Cart refresh karo
            LoadCartItems();
        }

        private void UpdateCartQuantity(int cartId, int change)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                // Jo quantity 1 hoy ane decrease kare to delete na thay etle minimum 1 rakhvu
                string query = "UPDATE Cart SET Quantity = CASE WHEN Quantity + @Change < 1 THEN 1 ELSE Quantity + @Change END WHERE CartId = @CartId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Change", change);
                    cmd.Parameters.AddWithValue("@CartId", cartId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteCartItem(int cartId)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "DELETE FROM Cart WHERE CartId = @CartId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CartId", cartId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // Proceed to Slot Booking
        protected void btnProceedSlot_Click(object sender, EventArgs e)
        {
            // BookSlot page par redirect karo
            Response.Redirect("BookSlot.aspx");
        }
    }
}
