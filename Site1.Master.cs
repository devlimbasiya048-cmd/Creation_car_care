using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace creation_car_care
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    CheckLoginStatus();
                    Page.DataBind();
                }
            }
            catch (Exception)
            {
                // Prevent page crash
            }
        }

        private Control FindControlRecursive(Control root, string id)
        {
            if (root == null) return null;
            if (root.ID == id) return root;

            foreach (Control c in root.Controls)
            {
                Control t = FindControlRecursive(c, id);
                if (t != null) return t;
            }
            return null;
        }

        private void CheckLoginStatus()
        {
            bool isLoggedIn = (Session != null && Session["UserEmail"] != null);
            bool isAdmin = (isLoggedIn && Session["IsAdmin"] != null && Convert.ToBoolean(Session["IsAdmin"]));

            if (phUserNav != null) phUserNav.Visible = isLoggedIn;
            if (phGuestNav != null) phGuestNav.Visible = !isLoggedIn;
            if (hlAdminPanel != null) hlAdminPanel.Visible = isAdmin;

            if (isLoggedIn && lblAvatar != null)
            {
                string userName = Session["UserName"] != null ? Session["UserName"].ToString() : "";
                if (string.IsNullOrEmpty(userName) && Session["UserEmail"] != null)
                {
                    userName = Session["UserEmail"].ToString();
                }

                if (!string.IsNullOrEmpty(userName))
                {
                    lblAvatar.Text = userName.Trim().Substring(0, 1).ToUpper();
                }
                else
                {
                    lblAvatar.Text = "U";
                }
            }
        }

        public string GetLinkStyle(string pageName)
        {
            try
            {
                if (Request != null && Request.Url != null)
                {
                    string current = Request.Url.AbsolutePath.ToLower();
                    string p = pageName.ToLower();

                    // Home Page check
                    if (p == "home" && (current.EndsWith("/") || current.EndsWith("/home.aspx") || current.EndsWith("/default.aspx")))
                    {
                        return "color: #ea580c; font-weight: 700;";
                    }

                    // Services Page check (ServicesList.aspx & ServiceDetails.aspx)
                    if ((p == "service" || p == "services" || p == "serviceslist") &&
                        (current.Contains("serviceslist") || current.Contains("servicedetails") || current.Contains("service")))
                    {
                        return "color: #ea580c; font-weight: 700;";
                    }

                    // Booking Page check (Booking.aspx, BookSlot.aspx, Tracking.aspx, Reschedule.aspx)
                    if (p == "booking" && (current.Contains("booking") || current.Contains("bookslot") || current.Contains("tracking") || current.Contains("reschedule")))
                    {
                        return "color: #ea580c; font-weight: 700;";
                    }

                    // Other standard pages: Offer, About, Contact, Cart, Wishlist, Login, Register
                    if (current.EndsWith("/" + p + ".aspx") || current.Contains("/" + p + ".aspx"))
                    {
                        return "color: #ea580c; font-weight: 700;";
                    }
                }
            }
            catch { }
            return "color: #374151; font-weight: 600;";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            if (Session != null)
            {
                Session.Clear();
                Session.Abandon();
            }
            Response.Redirect("Home.aspx");
        }
    }
}