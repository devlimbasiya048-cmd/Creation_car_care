using System;
using System.Web.UI;

namespace creation_car_care.Controls
{
    /// <summary>
    /// Reusable ASP.NET Web User Control (Syllabus Section II, Unit 6: Controls & Web User Control)
    /// Encapsulates Studio Operational Metrics, Live Application State counters, and Booth capacity.
    /// </summary>
    public partial class StudioStatBanner : UserControl
    {
        // Encapsulation: Custom property allowing parent pages to customize the badge text
        public string CustomBannerTitle { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudioOperationalStats();
            }
        }

        private void BindStudioOperationalStats()
        {
            // Read from thread-safe Application State (Syllabus Unit 8: State Management)
            if (Application["StudioStatus"] != null)
            {
                lblStudioStatus.Text = Application["StudioStatus"].ToString();
            }
            else
            {
                lblStudioStatus.Text = "Studio Operating Daily (09:00 AM - 08:00 PM)";
            }

            if (Application["TotalVisitorsCount"] != null)
            {
                int visitors = Convert.ToInt32(Application["TotalVisitorsCount"]);
                lblTotalVisitors.Text = string.Format("{0:N0}+", visitors);
            }

            if (Application["ActiveUsersOnline"] != null)
            {
                lblOnlineUsers.Text = Application["ActiveUsersOnline"].ToString();
            }

            // If parent page provided a custom title, display it
            if (!string.IsNullOrWhiteSpace(CustomBannerTitle))
            {
                lblStudioStatus.Text = CustomBannerTitle;
            }
        }
    }
}
