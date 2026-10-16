using System;
using System.Collections.Generic;
using creation_car_care.Models;
using creation_car_care.Services;

namespace creation_car_care
{
    public partial class Home : System.Web.UI.Page
    {
        // OOP Architecture: Using IStudioOperations abstraction & StudioManager Business Logic
        private readonly IStudioOperations _studioManager = new StudioManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFeaturedServices();
            }
        }

        /// <summary>
        /// Binds featured car care packages using Generic Collections (List<BaseServicePackage>) & LINQ
        /// Demonstrates Polymorphism and Abstraction in presentation layer.
        /// </summary>
        private void BindFeaturedServices()
        {
            try
            {
                List<BaseServicePackage> featured = _studioManager.GetFeaturedServices();
                rptFeaturedServices.DataSource = featured;
                rptFeaturedServices.DataBind();
            }
            catch (Exception)
            {
                // Fallback graceful degradation
            }
        }
    }
}
