using System;
using System.Data.SqlClient;

namespace creation_car_care.Admin
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var master = this.Master as Admin;
                if (master != null)
                {
                    master.SetPageTitle("Admin Profile Details", "Settings > Profile Details");
                }

                LoadDetails();
            }
        }

        private void LoadDetails()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                string qry = "SELECT TOP 1 StudioName, AdminName, ContactEmail, ContactPhone, Address FROM StudioSettings";
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string sName = dr["StudioName"].ToString();
                            string aName = dr["AdminName"].ToString();
                            string email = dr["ContactEmail"].ToString();
                            string phone = dr["ContactPhone"].ToString();
                            string addr = dr["Address"].ToString();

                            lblDisplayName.Text = aName;
                            lblStudioName.Text = sName;
                            lblEmailAddress.Text = email;
                            lblPhone.Text = phone;
                            lblAddress.Text = addr;

                            txtAdminName.Text = aName;
                            txtStudioName.Text = sName;
                            txtEmail.Text = email;
                            txtPhone.Text = phone;
                            txtAddress.Text = addr;
                        }
                    }
                }
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string updateQry = @"UPDATE StudioSettings SET 
                                    StudioName = @Studio,
                                    AdminName = @Admin,
                                    ContactEmail = @Email,
                                    ContactPhone = @Phone,
                                    Address = @Address,
                                    UpdatedAt = GETDATE()";

                using (SqlCommand cmd = new SqlCommand(updateQry, con))
                {
                    cmd.Parameters.AddWithValue("@Studio", txtStudioName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Admin", txtAdminName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // Also update admin in Admins table
                string updateAdmin = "UPDATE Admins SET FullName = @Admin, MobileNumber = @Phone WHERE Email = @Email";
                using (SqlCommand uCmd = new SqlCommand(updateAdmin, con))
                {
                    uCmd.Parameters.AddWithValue("@Admin", txtAdminName.Text.Trim());
                    uCmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                    uCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    uCmd.ExecuteNonQuery();
                }
            }

            lblSuccessAlert.Visible = true;
            LoadDetails();
        }
    }
}
