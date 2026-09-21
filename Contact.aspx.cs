using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace creation_car_care
{
    public partial class Contact : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text.Trim();
                string mobile = txtMobile.Text.Trim();
                string message = txtMessage.Text.Trim();

                // Optional: Database ma contact message save karva mate (Table na hoy to aa block remove pan kari sako cho)
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = "INSERT INTO ContactInquiries (Name, Mobile, Message) VALUES (@Name, @Mobile, @Message)";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Mobile", mobile);
                        cmd.Parameters.AddWithValue("@Message", message);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Success message alert apva mate
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Thank you! Your message has been sent successfully.'); window.location='Contact.aspx';", true);
            }
        }
    }
}