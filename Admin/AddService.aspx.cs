using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class AddService : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public string AlertType { get; set; } = "success";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Add New Service", "Services > Add New Service");
            }

            if (!IsPostBack)
            {
                LoadCategoryDropdown();
            }
        }

        private void LoadCategoryDropdown()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT CategoryName FROM Categories WHERE IsActive = 1 ORDER BY DisplayOrder ASC, CategoryId ASC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    System.Data.DataTable dt = new System.Data.DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        ddlCategory.Items.Clear();
                        ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem("Select Category", ""));
                        foreach (System.Data.DataRow row in dt.Rows)
                        {
                            string name = row["CategoryName"].ToString();
                            ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem(name, name));
                        }
                    }
                }
            }
        }

        protected void btnSaveService_Click(object sender, EventArgs e)
        {
            string name = txtServiceName.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string priceStr = txtPrice.Text.Trim();
            string duration = txtDuration.Text.Trim();
            string desc = txtDescription.Text.Trim();
            bool isActive = chkIsActive.Checked;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(category) || string.IsNullOrEmpty(priceStr) || string.IsNullOrEmpty(desc))
            {
                ShowAlert("Please fill in all required fields (Name, Category, Price, Description).", "error");
                return;
            }

            if (!decimal.TryParse(priceStr, out decimal price))
            {
                ShowAlert("Please enter a valid numeric price.", "error");
                return;
            }

            string imageUrl = "~/Images/Services/default_service.jpg";
            if (fuServiceImage.HasFile)
            {
                string ext = System.IO.Path.GetExtension(fuServiceImage.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                {
                    string fileName = "service_" + DateTime.Now.Ticks + ext;
                    string saveDir = Server.MapPath("~/Images/Services/");
                    if (!System.IO.Directory.Exists(saveDir))
                    {
                        System.IO.Directory.CreateDirectory(saveDir);
                    }
                    fuServiceImage.SaveAs(System.IO.Path.Combine(saveDir, fileName));
                    imageUrl = "~/Images/Services/" + fileName;
                }
                else
                {
                    ShowAlert("Please upload a valid image file (.jpg, .png, .webp).", "error");
                    return;
                }
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"INSERT INTO Services (ServiceName, ShortDescription, Price, Duration, Warranty, Category, ImageUrl, IsActive)
                               VALUES (@name, @desc, @price, @duration, @warranty, @category, @imageUrl, @isActive)";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@desc", desc);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.Parameters.AddWithValue("@duration", string.IsNullOrEmpty(duration) ? "2 - 3 Hours" : duration);
                    cmd.Parameters.AddWithValue("@warranty", "1 Year Warranty");
                    cmd.Parameters.AddWithValue("@category", category);
                    cmd.Parameters.AddWithValue("@imageUrl", imageUrl);
                    cmd.Parameters.AddWithValue("@isActive", isActive);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        Response.Redirect("ManageServices.aspx");
                    }
                    catch (Exception ex)
                    {
                        ShowAlert("Database Error: " + ex.Message, "error");
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
