using System;
using System.Web.UI;

namespace creation_car_care.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verify Admin Login Session
            if (Session["UserEmail"] == null || Session["IsAdmin"] == null || !Convert.ToBoolean(Session["IsAdmin"]))
            {
                Response.Redirect("~/Admin/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Session["UserName"] != null)
                {
                    lblAdminName.Text = Session["UserName"].ToString();
                }
            }
        }

        public string GetActiveMenuClass(string menuName)
        {
            string url = Request.Url.AbsolutePath.ToLower();
            if (url.Contains(menuName.ToLower()))
            {
                return "sidebar-link active";
            }
            return "sidebar-link";
        }

        public void SetPageTitle(string heading, string breadcrumb)
        {
            lblPageHeading.Text = heading;
            lblBreadcrumb.Text = breadcrumb;
        }

        protected void btnAdminLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Admin/Login.aspx");
        }
    }
}
