using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace creation_car_care.Admin
{
    public partial class WorkingHours : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var master = this.Master as Admin;
                if (master != null)
                {
                    master.SetPageTitle("Working Hours & Shifts", "Settings > Shifts & Timing");
                }

                LoadSlots();
            }
        }

        private void LoadSlots()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string qry = "SELECT SlotId, SlotTime, ShiftType, IsEnabled FROM WorkingHours ORDER BY DisplayOrder ASC";
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            rptSlots.DataSource = dt;
            rptSlots.DataBind();
        }

        protected void btnSaveSlots_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                foreach (RepeaterItem item in rptSlots.Items)
                {
                    HiddenField hf = (HiddenField)item.FindControl("hfSlotId");
                    CheckBox chk = (CheckBox)item.FindControl("chkSlotEnabled");

                    if (hf != null && chk != null)
                    {
                        int slotId = Convert.ToInt32(hf.Value);
                        bool isEnabled = chk.Checked;

                        string updateQry = "UPDATE WorkingHours SET IsEnabled = @Enabled WHERE SlotId = @Id";
                        using (SqlCommand cmd = new SqlCommand(updateQry, con))
                        {
                            cmd.Parameters.AddWithValue("@Enabled", isEnabled);
                            cmd.Parameters.AddWithValue("@Id", slotId);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }

            lblSuccess.Visible = true;
            LoadSlots();
        }
    }
}
