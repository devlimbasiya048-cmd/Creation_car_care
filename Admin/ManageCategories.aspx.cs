using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care.Admin
{
    public partial class ManageCategories : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CreationCarCareDB"]?.ConnectionString
            ?? @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Master is Admin adminMaster)
            {
                adminMaster.SetPageTitle("Category Management", "Dashboard > Category Management");
            }

            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"
                    SELECT 
                        c.CategoryId,
                        c.CategoryName,
                        ISNULL(c.Icon, '&#128737;') AS Icon,
                        ISNULL(c.ColorAccent, '#8b5cf6') AS ColorAccent,
                        ISNULL(c.IsActive, 1) AS IsActive,
                        c.DisplayOrder,
                        COUNT(s.ServiceId) AS ServicesCount
                    FROM Categories c
                    LEFT JOIN Services s ON s.Category = c.CategoryName
                    GROUP BY c.CategoryId, c.CategoryName, c.Icon, c.ColorAccent, c.IsActive, c.DisplayOrder
                    ORDER BY c.DisplayOrder ASC, c.CategoryId ASC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    dt.Columns.Add("ColorAccentLight", typeof(string));
                    dt.Columns.Add("ColorAccentBorder", typeof(string));

                    foreach (DataRow row in dt.Rows)
                    {
                        string hex = row["ColorAccent"]?.ToString() ?? "#8b5cf6";
                        if (hex.Contains("8b5cf6") || hex.ToLower().Contains("purple"))
                        {
                            row["ColorAccentLight"] = "#f5f3ff";
                            row["ColorAccentBorder"] = "#ddd6fe";
                        }
                        else if (hex.Contains("ea580c") || hex.ToLower().Contains("orange"))
                        {
                            row["ColorAccentLight"] = "#fff7ed";
                            row["ColorAccentBorder"] = "#fed7aa";
                        }
                        else if (hex.Contains("10b981") || hex.ToLower().Contains("green"))
                        {
                            row["ColorAccentLight"] = "#ecfdf5";
                            row["ColorAccentBorder"] = "#a7f3d0";
                        }
                        else
                        {
                            row["ColorAccentLight"] = "#eff6ff";
                            row["ColorAccentBorder"] = "#bfdbfe";
                        }
                    }

                    rptCategories.DataSource = dt;
                    rptCategories.DataBind();
                }
            }
        }

        public string GetCleanCategoryIcon(string icon, string catName)
        {
            if (!string.IsNullOrEmpty(icon) && !icon.Contains("?"))
            {
                return icon;
            }
            if (catName.Contains("Protection") || catName.Contains("PPF")) return "&#128737;";
            if (catName.Contains("Ceramic")) return "&#10024;";
            if (catName.Contains("Correction") || catName.Contains("Restoration")) return "&#128663;";
            if (catName.Contains("Spa") || catName.Contains("Wash") || catName.Contains("Detailing")) return "&#128167;";
            return "&#128295;";
        }

        protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int catId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ToggleCat")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "UPDATE Categories SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE CategoryId = @id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@id", catId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadCategories();
            }
            else if (e.CommandName == "DeleteCat")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "DELETE FROM Categories WHERE CategoryId = @id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@id", catId);
                        con.Open();
                        try
                        {
                            cmd.ExecuteNonQuery();
                        }
                        catch (Exception)
                        {
                            // FK safe fallback
                        }
                    }
                }
                LoadCategories();
            }
        }
    }
}
