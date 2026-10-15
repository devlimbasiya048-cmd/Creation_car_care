using System;
using System.Data.SqlClient;

namespace creation_car_care.Admin
{
    public partial class Settings : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var master = this.Master as Admin;
                if (master != null)
                {
                    master.SetPageTitle("Settings & Profile", "Dashboard > Settings");
                }

                LoadStudioSettings();
            }
        }

        private void LoadStudioSettings()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                string qry = "SELECT TOP 1 AdminName, ContactEmail FROM StudioSettings";
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblAdminFullName.Text = dr["AdminName"].ToString();
                            lblAdminEmail.Text = dr["ContactEmail"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnLogoutAdmin_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Admin/Login.aspx");
        }
    }
}
