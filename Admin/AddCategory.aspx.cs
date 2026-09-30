using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class AddCategory : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        public string AlertType { get; set; } = "success";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Add New Category", "Categories > Add New Category");
            }
        }

        protected void ddlIcon_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblIconSymbol.Text = ddlIcon.SelectedValue;
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            string name = txtCategoryName.Text.Trim();
            string desc = txtDescription.Text.Trim();
            int.TryParse(txtDisplayOrder.Text.Trim(), out int order);
            string icon = ddlIcon.SelectedValue;
            string color = ddlColorAccent.SelectedValue;
            bool isActive = chkIsActive.Checked;

            if (string.IsNullOrEmpty(name))
            {
                ShowAlert("Please enter a category name.", "error");
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"INSERT INTO Categories (CategoryName, Description, DisplayOrder, IsActive, Icon, ColorAccent)
                               VALUES (@name, @desc, @order, @isActive, @icon, @color)";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@desc", string.IsNullOrEmpty(desc) ? "Detailing care treatment package." : desc);
                    cmd.Parameters.AddWithValue("@order", order > 0 ? order : 1);
                    cmd.Parameters.AddWithValue("@isActive", isActive);
                    cmd.Parameters.AddWithValue("@icon", string.IsNullOrEmpty(icon) ? "&#128737;" : icon);
                    cmd.Parameters.AddWithValue("@color", string.IsNullOrEmpty(color) ? "#8b5cf6" : color);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        Response.Redirect("ManageCategories.aspx");
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
