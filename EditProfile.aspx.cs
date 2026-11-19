using System;
using System.Data.SqlClient;

namespace creation_car_care
{
    public partial class EditProfile : System.Web.UI.Page
    {
        string connString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Ensure form supports multipart file uploads for avatar image
            if (Page.Form != null)
            {
                Page.Form.Enctype = "multipart/form-data";
            }

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null) return Convert.ToInt32(Session["UserId"]);
            return 1;
        }

        private void LoadData()
        {
            int userId = GetCurrentUserId();

            using (SqlConnection con = new SqlConnection(connString))
            {
                string query = "SELECT FullName, Email, MobileNumber, ProfileImage FROM Users WHERE UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            string name = r["FullName"] != DBNull.Value ? r["FullName"].ToString() : "";
                            txtFullName.Text = name;
                            txtEmail.Text = r["Email"] != DBNull.Value ? r["Email"].ToString() : "";
                            txtMobile.Text = r["MobileNumber"] != DBNull.Value ? r["MobileNumber"].ToString() : "+91 98765 43210";

                            string profileImg = r["ProfileImage"] != DBNull.Value ? r["ProfileImage"].ToString() : "";
                            if (!string.IsNullOrEmpty(profileImg))
                            {
                                imgProfilePreview.ImageUrl = ResolveUrl(profileImg);
                                imgProfilePreview.Visible = true;
                                lblAvatarInitial.Visible = false;
                            }
                            else if (!string.IsNullOrEmpty(name))
                            {
                                imgProfilePreview.Visible = false;
                                lblAvatarInitial.Visible = true;
                                lblAvatarInitial.Text = name.Trim().Substring(0, 1).ToUpper();
                            }
                        }
                    }
                }
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            int userId = GetCurrentUserId();
            string fullName = txtFullName.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string profileImagePath = null;

            // Handle Profile Image Upload via Camera Icon Trigger
            if (fuProfilePic.HasFile)
            {
                string ext = System.IO.Path.GetExtension(fuProfilePic.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                {
                    try
                    {
                        string folderPath = Server.MapPath("~/Images/Users/");
                        if (!System.IO.Directory.Exists(folderPath))
                        {
                            System.IO.Directory.CreateDirectory(folderPath);
                        }

                        string fileName = $"user_{userId}_{DateTime.Now:yyyyMMddHHmmss}{ext}";
                        string fullSavePath = System.IO.Path.Combine(folderPath, fileName);
                        fuProfilePic.SaveAs(fullSavePath);

                        profileImagePath = "~/Images/Users/" + fileName;
                        Session["UserProfileImage"] = profileImagePath;
                    }
                    catch (Exception)
                    {
                        // Fallback gracefully
                    }
                }
            }

            using (SqlConnection con = new SqlConnection(connString))
            {
                string updateQry;
                if (!string.IsNullOrEmpty(profileImagePath))
                {
                    updateQry = "UPDATE Users SET FullName = @FullName, MobileNumber = @Mobile, ProfileImage = @ProfileImage WHERE UserId = @UserId";
                }
                else
                {
                    updateQry = "UPDATE Users SET FullName = @FullName, MobileNumber = @Mobile WHERE UserId = @UserId";
                }

                using (SqlCommand cmd = new SqlCommand(updateQry, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    if (!string.IsNullOrEmpty(profileImagePath))
                    {
                        cmd.Parameters.AddWithValue("@ProfileImage", profileImagePath);
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Session["UserName"] = fullName;

            lblSuccess.Visible = true;
            lblSuccess.Text = "Profile details & photo updated successfully!";

            // Update UI preview
            if (!string.IsNullOrEmpty(profileImagePath))
            {
                imgProfilePreview.ImageUrl = ResolveUrl(profileImagePath);
                imgProfilePreview.Visible = true;
                lblAvatarInitial.Visible = false;
            }
            else if (!string.IsNullOrEmpty(fullName))
            {
                lblAvatarInitial.Text = fullName.Trim().Substring(0, 1).ToUpper();
            }
        }
    }
}
