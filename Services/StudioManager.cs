using System;
using System.Collections.Generic;
using System.Linq;
using creation_car_care.Models;

namespace creation_car_care.Services
{
    /// <summary>
    /// Abstraction: Interface defining studio operational contracts
    /// </summary>
    public interface IStudioOperations
    {
        List<BaseServicePackage> GetFeaturedServices();
        Dictionary<string, decimal> GetCategoryDiscountRates();
        List<BaseServicePackage> FilterServicesByCategory(string categoryName);
        decimal CalculateFinalPrice(BaseServicePackage service, string promoCode);
    }

    /// <summary>
    /// Business Logic Layer implementing IStudioOperations and Collection Management
    /// </summary>
    public class StudioManager : IStudioOperations
    {
        // Collection Implementation: List<T> of strongly typed service packages
        private readonly List<BaseServicePackage> _catalogServices;

        // Collection Implementation: Dictionary<TKey, TValue> for active festival promo rates
        private readonly Dictionary<string, decimal> _promoDiscountRates;

        public StudioManager()
        {
            _catalogServices = new List<BaseServicePackage>();
            _promoDiscountRates = new Dictionary<string, decimal>(StringComparer.OrdinalIgnoreCase);

            InitializeCatalog();
            InitializePromotions();
        }

        private void InitializeCatalog()
        {
            _catalogServices.Add(new PPFProtectionService
            {
                Id = 4,
                ServiceName = "Full Body PPF Protection",
                ShortDescription = "Self-healing TPU film, ultimate scratch protection.",
                BasePrice = 45000m,
                Duration = "2 Days",
                Warranty = "5 Years Warranty",
                Category = "Protection (PPF)",
                Rating = 4.9m,
                FilmThicknessMicrons = "200 Microns Hydrophobic"
            });

            _catalogServices.Add(new DetailingService
            {
                Id = 5,
                ServiceName = "Ceramic Top Shield",
                ShortDescription = "Extreme glass-like gloss finish with advanced 9H hydrophobic layer.",
                BasePrice = 12000m,
                Duration = "4 - 5 Hours",
                Warranty = "2 Years Warranty",
                Category = "Ceramic Coating",
                Rating = 4.8m,
                IncludesInteriorSteamSanitization = true
            });

            _catalogServices.Add(new DetailingService
            {
                Id = 6,
                ServiceName = "Car Aroma Therapy - Basic",
                ShortDescription = "Antibacterial fogging, seat shampooing and AC vent cleaning.",
                BasePrice = 599m,
                Duration = "60 mins",
                Warranty = "1 Month",
                Category = "Spa & Detailing",
                Rating = 4.0m,
                IncludesInteriorSteamSanitization = true
            });

            _catalogServices.Add(new DetailingService
            {
                Id = 7,
                ServiceName = "Interior Deep Spa & Detailing",
                ShortDescription = "Complete seat shampoo, dashboard steam cleaning and floor sterilization.",
                BasePrice = 2500m,
                Duration = "3 Hours",
                Warranty = "3 Months",
                Category = "Spa & Detailing",
                Rating = 4.5m,
                IncludesInteriorSteamSanitization = true
            });

            _catalogServices.Add(new PPFProtectionService
            {
                Id = 14,
                ServiceName = "Gloss Auto PPF (Full Body)",
                ShortDescription = "Self-healing TPU with UV and acid rain protection.",
                BasePrice = 51500m,
                Duration = "2 Days",
                Warranty = "5 Years Warranty",
                Category = "Protection (PPF)",
                Rating = 4.5m,
                FilmThicknessMicrons = "190 Microns TPU"
            });
        }

        private void InitializePromotions()
        {
            // Dictionary Collection mapping Promo Codes to Discount Percentages
            _promoDiscountRates["NAVRATRI20"] = 20.0m;
            _promoDiscountRates["DIWALI25"] = 25.0m;
            _promoDiscountRates["STUDIO10"] = 10.0m;
            _promoDiscountRates["FESTIVE15"] = 15.0m;
        }

        /// <summary>
        /// Collection operation: returns top featured services using LINQ
        /// </summary>
        public List<BaseServicePackage> GetFeaturedServices()
        {
            return _catalogServices
                .Where(s => s.IsActive)
                .OrderByDescending(s => s.Rating)
                .ToList();
        }

        /// <summary>
        /// Collection operation: returns promo dictionary
        /// </summary>
        public Dictionary<string, decimal> GetCategoryDiscountRates()
        {
            return _promoDiscountRates;
        }

        /// <summary>
        /// LINQ Collection Filtering by Category
        /// </summary>
        public List<BaseServicePackage> FilterServicesByCategory(string categoryName)
        {
            if (string.IsNullOrWhiteSpace(categoryName) || categoryName.Equals("All", StringComparison.OrdinalIgnoreCase))
            {
                return _catalogServices;
            }

            return _catalogServices
                .Where(s => s.Category.IndexOf(categoryName, StringComparison.OrdinalIgnoreCase) >= 0)
                .ToList();
        }

        /// <summary>
        /// Polymorphic price computation with Dictionary lookup
        /// </summary>
        public decimal CalculateFinalPrice(BaseServicePackage service, string promoCode)
        {
            if (service == null) return 0m;

            decimal discount = 0m;
            if (!string.IsNullOrWhiteSpace(promoCode) && _promoDiscountRates.ContainsKey(promoCode))
            {
                discount = _promoDiscountRates[promoCode];
            }

            // Polymorphism in action: invokes derived service's overridden CalculateDiscountedPrice method
            return service.CalculateDiscountedPrice(discount);
        }
    }
}
