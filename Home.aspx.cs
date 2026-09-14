using System;

namespace creation_car_care
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Home page is public for both guest and logged-in users.
            // The navbar in Site1.Master switches automatically between guest and logged-in states.
        }
    }
}