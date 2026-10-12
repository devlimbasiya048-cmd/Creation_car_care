using System;
using System.Web;

namespace creation_car_care
{
    /// <summary>
    /// Global Application Lifecycle & Application State Management
    /// </summary>
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Application State initialization: Available across all users and sessions
            Application["StudioStatus"] = "Open - Studio Operating Daily (09:00 AM - 08:00 PM)";
            Application["TotalVisitorsCount"] = 1420;
            Application["ActiveUsersOnline"] = 1;
            Application["AppInitializedAt"] = DateTime.Now;
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Thread-safe increment of Application-level visitor counters
            Application.Lock();
            int visitors = Application["TotalVisitorsCount"] != null ? Convert.ToInt32(Application["TotalVisitorsCount"]) : 1420;
            int active = Application["ActiveUsersOnline"] != null ? Convert.ToInt32(Application["ActiveUsersOnline"]) : 0;

            Application["TotalVisitorsCount"] = visitors + 1;
            Application["ActiveUsersOnline"] = active + 1;
            Application.UnLock();
        }

        void Session_End(object sender, EventArgs e)
        {
            // Thread-safe decrement when a user session ends or times out
            Application.Lock();
            int active = Application["ActiveUsersOnline"] != null ? Convert.ToInt32(Application["ActiveUsersOnline"]) : 1;
            if (active > 0)
            {
                Application["ActiveUsersOnline"] = active - 1;
            }
            Application.UnLock();
        }

        void Application_End(object sender, EventArgs e)
        {
        }

        void Application_Error(object sender, EventArgs e)
        {
        }
    }
}
