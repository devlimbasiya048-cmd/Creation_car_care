using System;
using System.Data;
using System.Data.SqlClient;

namespace creation_car_care.Admin
{
    public partial class Activity : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var master = this.Master as Admin;
                if (master != null)
                {
                    master.SetPageTitle("All Recent Activity", "Dashboard > Activity Log");
                }

                LoadActivity();
            }
        }

        private void LoadActivity()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT Title, Description, BadgeColor, CreatedAt FROM AdminActivities ORDER BY CreatedAt DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            rptAllActivity.DataSource = dt;
            rptAllActivity.DataBind();
        }
    }
}
