using System;

namespace creation_car_care.Models
{
    /// <summary>
    /// Abstract Base Class for Car Care Services (Abstraction & Inheritance)
    /// </summary>
    public abstract class BaseServicePackage : BaseEntity
    {
        public string ServiceName { get; set; }
        public string ShortDescription { get; set; }
        public decimal BasePrice { get; set; }
        public string Duration { get; set; }
        public string Warranty { get; set; }
        public string Category { get; set; }
        public decimal Rating { get; set; } = 4.5m;
        public string ImageUrl { get; set; }

        // Virtual Method for Polymorphism: Dynamic Price Calculation with Discount
        public virtual decimal CalculateDiscountedPrice(decimal discountPercentage)
        {
            if (discountPercentage <= 0) return BasePrice;
            decimal discountAmount = BasePrice * (discountPercentage / 100m);
            return Math.Round(BasePrice - discountAmount, 2);
        }

        public override string GetEntitySummary()
        {
            return $"{ServiceName} [{Category}] - Rs. {BasePrice:N0} ({Duration})";
        }
    }

    /// <summary>
    /// Derived Detailing & Spa Service (Inheritance & Polymorphism)
    /// </summary>
    public class DetailingService : BaseServicePackage
    {
        public bool IncludesInteriorSteamSanitization { get; set; } = true;

        public override decimal CalculateDiscountedPrice(decimal discountPercentage)
        {
            // Standard seasonal discount calculation
            return base.CalculateDiscountedPrice(discountPercentage);
        }
    }

    /// <summary>
    /// Derived Paint Protection Film (PPF) Service (Inheritance & Polymorphism)
    /// </summary>
    public class PPFProtectionService : BaseServicePackage
    {
        public string FilmThicknessMicrons { get; set; } = "190 Microns TPU";
        public bool IncludesSelfHealingWarranty { get; set; } = true;

        // Polymorphism: Special promotional discount for high-value PPF packages
        public override decimal CalculateDiscountedPrice(decimal discountPercentage)
        {
            // PPF packages include an additional 2% studio loyalty voucher
            decimal effectiveDiscount = discountPercentage + 2m;
            decimal discountAmount = BasePrice * (effectiveDiscount / 100m);
            return Math.Round(BasePrice - discountAmount, 2);
        }
    }
}
