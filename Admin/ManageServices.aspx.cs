using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care.Admin
{
    public partial class ManageServices : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public string MsgType { get; set; } = "success";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Manage Services", "Dashboard > Manage Services");
            }

            if (!IsPostBack)
            {
                ViewState["SelectedCategory"] = "";
                LoadCategoryTabsAndDropdown();
                LoadServices();
            }
        }

        private void LoadCategoryTabsAndDropdown()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT CategoryName FROM Categories WHERE IsActive = 1 ORDER BY DisplayOrder ASC, CategoryId ASC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptCategoryTabs.DataSource = dt;
                    rptCategoryTabs.DataBind();

                    string prevSelected = ddlCategory.SelectedValue;
                    ddlCategory.Items.Clear();
                    foreach (DataRow row in dt.Rows)
                    {
                        string name = row["CategoryName"].ToString();
                        ddlCategory.Items.Add(new ListItem(name, name));
                    }
                    if (!string.IsNullOrEmpty(prevSelected) && ddlCategory.Items.FindByValue(prevSelected) != null)
                    {
                        ddlCategory.SelectedValue = prevSelected;
                    }
                }
            }
        }

        private void LoadServices()
        {
            string selectedCategory = ViewState["SelectedCategory"]?.ToString() ?? "";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT ServiceId, ServiceName, ShortDescription, Price, Duration, Warranty, Category, ImageUrl, ISNULL(IsActive, 1) AS IsActive FROM Services";
                if (!string.IsNullOrEmpty(selectedCategory))
                {
                    sql += " WHERE Category = @cat";
                }
                sql += " ORDER BY ServiceId DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    if (!string.IsNullOrEmpty(selectedCategory))
                    {
                        cmd.Parameters.AddWithValue("@cat", selectedCategory);
                    }

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptServices.DataSource = dt;
                    rptServices.DataBind();
                }
            }
        }

        public string GetCategoryTabClass(string category)
        {
            string current = ViewState["SelectedCategory"]?.ToString() ?? "";
            if (string.Equals(current, category, StringComparison.OrdinalIgnoreCase))
            {
                return "cat-tab-btn active";
            }
            return "cat-tab-btn";
        }

        public string GetServiceIcon(string category)
        {
            string lower = category != null ? category.ToLower() : "";
            if (lower.Contains("protection") || lower.Contains("ppf"))
            {
                return "&#128737;"; // Shield
            }
            else if (lower.Contains("ceramic"))
            {
                return "&#10024;"; // Sparkles
            }
            else if (lower.Contains("correction") || lower.Contains("scratch") || lower.Contains("stain"))
            {
                return "&#128663;"; // Car
            }
            else if (lower.Contains("spa") || lower.Contains("wash") || lower.Contains("detailing") || lower.Contains("aroma"))
            {
                return "&#128167;"; // Water droplet
            }
            else
            {
                return "&#128295;"; // Wrench
            }
        }

        protected void CategoryTab_Click(object sender, EventArgs e)
        {
            if (sender is LinkButton btn)
            {
                ViewState["SelectedCategory"] = btn.CommandArgument.Trim();
                LoadCategoryTabsAndDropdown();
                LoadServices();
            }
        }

        protected void btnToggleAddForm_Click(object sender, EventArgs e)
        {
            pnlAddEditForm.Visible = !pnlAddEditForm.Visible;
            if (pnlAddEditForm.Visible)
            {
                ClearForm();
                lblFormHeading.Text = "Add New Detailing Service";
                hfEditingServiceId.Value = "0";
            }
        }

        protected void btnCancelForm_Click(object sender, EventArgs e)
        {
            ClearForm();
            pnlAddEditForm.Visible = false;
        }

        private void ClearForm()
        {
            txtServiceName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtDuration.Text = "";
            txtWarranty.Text = "";
            hfEditingServiceId.Value = "0";
            hfExistingImageUrl.Value = "";
            imgEditPreview.Style["display"] = "none";
            pnlMsg.Visible = false;
        }

        protected void btnSaveService_Click(object sender, EventArgs e)
        {
            string name = txtServiceName.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string cat = ddlCategory.SelectedValue;
            string duration = txtDuration.Text.Trim();
            string warranty = txtWarranty.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(desc) || string.IsNullOrEmpty(txtPrice.Text.Trim()))
            {
                ShowMessage("Please enter service name, description and price.", "error");
                return;
            }

            if (!decimal.TryParse(txtPrice.Text.Trim(), out decimal price))
            {
                ShowMessage("Please enter a valid numeric price.", "error");
                return;
            }

            int editId = Convert.ToInt32(hfEditingServiceId.Value);

            // Handle image upload from PC
            string imageUrl = hfExistingImageUrl.Value;
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
                    ShowMessage("Please upload a valid image file (.jpg, .png, .webp).", "error");
                    return;
                }
            }

            if (string.IsNullOrEmpty(imageUrl))
            {
                imageUrl = "~/Images/Services/default_service.jpg";
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql;
                if (editId > 0)
                {
                    sql = @"UPDATE Services 
                            SET ServiceName = @name, ShortDescription = @desc, Price = @price, 
                                Duration = @duration, Warranty = @warranty, Category = @cat, ImageUrl = @img 
                            WHERE ServiceId = @id";
                }
                else
                {
                    sql = @"INSERT INTO Services (ServiceName, ShortDescription, Price, Duration, Warranty, Category, ImageUrl, IsActive)
                            VALUES (@name, @desc, @price, @duration, @warranty, @cat, @img, 1)";
                }

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@desc", desc);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.Parameters.AddWithValue("@duration", string.IsNullOrEmpty(duration) ? "2-3 Hours" : duration);
                    cmd.Parameters.AddWithValue("@warranty", string.IsNullOrEmpty(warranty) ? "1 Year Studio Warranty" : warranty);
                    cmd.Parameters.AddWithValue("@cat", cat);
                    cmd.Parameters.AddWithValue("@img", imageUrl);
                    if (editId > 0)
                    {
                        cmd.Parameters.AddWithValue("@id", editId);
                    }

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        pnlAddEditForm.Visible = false;
                        ClearForm();
                        ShowMessage(editId > 0 ? "Service updated successfully with photo!" : "New service added successfully with photo!", "success");
                        LoadServices();
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Database error: " + ex.Message, "error");
                    }
                }
            }
        }

        protected void rptServices_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int serviceId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ToggleActive")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "UPDATE Services SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE ServiceId = @id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@id", serviceId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadServices();
            }
            else if (e.CommandName == "EditService")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "SELECT * FROM Services WHERE ServiceId = @id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@id", serviceId);
                        con.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                hfEditingServiceId.Value = serviceId.ToString();
                                txtServiceName.Text = dr["ServiceName"].ToString();
                                txtDescription.Text = dr["ShortDescription"].ToString();
                                txtPrice.Text = Convert.ToDecimal(dr["Price"]).ToString("0.##");
                                txtDuration.Text = dr["Duration"] != DBNull.Value ? dr["Duration"].ToString() : "";
                                txtWarranty.Text = dr["Warranty"] != DBNull.Value ? dr["Warranty"].ToString() : "";

                                string cat = dr["Category"]?.ToString();
                                if (ddlCategory.Items.FindByValue(cat) != null)
                                {
                                    ddlCategory.SelectedValue = cat;
                                }

                                string imgPath = dr["ImageUrl"] != DBNull.Value ? dr["ImageUrl"].ToString() : "";
                                hfExistingImageUrl.Value = imgPath;
                                if (!string.IsNullOrEmpty(imgPath))
                                {
                                    imgEditPreview.ImageUrl = ResolveUrl(imgPath);
                                    imgEditPreview.Style["display"] = "block";
                                }
                                else
                                {
                                    imgEditPreview.Style["display"] = "none";
                                }

                                lblFormHeading.Text = "Edit Service: " + txtServiceName.Text;
                                pnlAddEditForm.Visible = true;
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteService")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    try
                    {
                        con.Open();
                        string deleteSql = "DELETE FROM Services WHERE ServiceId = @id";
                        using (SqlCommand cmd = new SqlCommand(deleteSql, con))
                        {
                            cmd.Parameters.AddWithValue("@id", serviceId);
                            cmd.ExecuteNonQuery();
                            ShowMessage("Service deleted successfully.", "success");
                        }
                    }
                    catch (Exception)
                    {
                        // If FK constraint exists in Bookings, just deactivate service
                        string deactivateSql = "UPDATE Services SET IsActive = 0 WHERE ServiceId = @id";
                        using (SqlCommand cmd = new SqlCommand(deactivateSql, con))
                        {
                            cmd.Parameters.AddWithValue("@id", serviceId);
                            cmd.ExecuteNonQuery();
                            ShowMessage("Service has existing booking records, so it was set to INACTIVE instead of deleting.", "success");
                        }
                    }
                }
                LoadServices();
            }
        }

        private void ShowMessage(string msg, string type)
        {
            pnlMsg.Visible = true;
            lblMsg.Text = msg;
            MsgType = type;
        }
    }
}