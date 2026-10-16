using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using creation_car_care.Models;

namespace creation_car_care.Services
{
    #region Custom Exceptions (Syllabus Section I, Unit 3: Exception Handling)
    /// <summary>
    /// Custom Application Exception for Studio Booking Conflicts
    /// Demonstrates user-defined exception handling in C# .NET
    /// </summary>
    public class StudioBookingConflictException : Exception
    {
        public string ConflictingSlot { get; }
        public DateTime RequestedDate { get; }

        public StudioBookingConflictException(string message, string slot, DateTime date) 
            : base(message)
        {
            ConflictingSlot = slot;
            RequestedDate = date;
        }

        public StudioBookingConflictException(string message, Exception innerException) 
            : base(message, innerException)
        {
        }
    }

    /// <summary>
    /// Custom Application Exception for Invalid Coupon or Promotion
    /// </summary>
    public class InvalidPromoCodeException : Exception
    {
        public string InvalidPromoCode { get; }

        public InvalidPromoCodeException(string message, string code) 
            : base(message)
        {
            InvalidPromoCode = code;
        }
    }
    #endregion

    #region Delegates & Events (Syllabus Section I, Unit 3: Delegates and Events)
    /// <summary>
    /// Event Arguments carrying booking progress update details
    /// </summary>
    public class BookingEventArgs : EventArgs
    {
        public string BookingCode { get; set; }
        public string ServiceName { get; set; }
        public string Status { get; set; }
        public DateTime UpdatedAt { get; set; }

        public BookingEventArgs(string code, string service, string status)
        {
            BookingCode = code;
            ServiceName = service;
            Status = status;
            UpdatedAt = DateTime.Now;
        }
    }

    /// <summary>
    /// Custom Delegate defining the contract for Studio Detailing Status change notifications
    /// </summary>
    public delegate void BookingStatusChangedEventHandler(object sender, BookingEventArgs e);
    #endregion

    /// <summary>
    /// Abstraction: Interface defining studio operational contracts
    /// </summary>
    public interface IStudioOperations
    {
        List<BaseServicePackage> GetFeaturedServices();
        Dictionary<string, decimal> GetCategoryDiscountRates();
        List<BaseServicePackage> FilterServicesByCategory(string categoryName);
        decimal CalculateFinalPrice(BaseServicePackage service, string promoCode);
        void EnqueueBayBooking(StudioBooking booking);
        StudioBooking DequeueNextBayBooking();
        void PushAuditLog(string message);
        string PopAuditLog();
    }

    /// <summary>
    /// Business Logic Layer implementing IStudioOperations and Collection Management
    /// Covers: List<T>, Dictionary<TKey, TValue>, Queue<T>, Stack<T>, ArrayList, Hashtable, Delegates & Custom Exceptions
    /// </summary>
    public class StudioManager : IStudioOperations
    {
        // 1. Generic Collection: List<T> of strongly typed service packages
        private readonly List<BaseServicePackage> _catalogServices;

        // 2. Generic Collection: Dictionary<TKey, TValue> for active festival promo rates
        private readonly Dictionary<string, decimal> _promoDiscountRates;

        // 3. Generic Collection: Queue<T> for FIFO Detailing Bay Service Schedule
        private readonly Queue<StudioBooking> _bayServiceQueue;

        // 4. Generic Collection: Stack<T> for LIFO Detailing Stage Audit Trail / Rollback
        private readonly Stack<string> _stageAuditStack;

        // 5. Non-Generic Collection: ArrayList for Studio Equipment inventory
        private readonly ArrayList _studioEquipmentList;

        // 6. Non-Generic Collection: Hashtable for studio configuration metadata
        private readonly Hashtable _studioMetaHashtable;

        // Event for Booking Status Notifications (Syllabus Unit 3)
        public event BookingStatusChangedEventHandler OnBookingStatusChanged;

        public StudioManager()
        {
            _catalogServices = new List<BaseServicePackage>();
            _promoDiscountRates = new Dictionary<string, decimal>(StringComparer.OrdinalIgnoreCase);
            _bayServiceQueue = new Queue<StudioBooking>();
            _stageAuditStack = new Stack<string>();
            _studioEquipmentList = new ArrayList();
            _studioMetaHashtable = new Hashtable();

            InitializeCatalog();
            InitializePromotions();
            InitializeBayQueue();
            InitializeNonGenericCollections();
        }

        private void InitializeCatalog()
        {
            _catalogServices.Add(new PPFProtectionService
            {
                Id = 4,
                ServiceName = "Full Body PPF Protection",
                ShortDescription = "Self-healing TPU film, ultimate scratch protection and stone-chip guard.",
                BasePrice = 45000m,
                Duration = "2 Days",
                Warranty = "5 Years Warranty",
                Category = "Protection (PPF)",
                Rating = 4.9m,
                FilmThicknessMicrons = "200 Microns Hydrophobic",
                ImageUrl = "Images/Services/full_body_ppf.jpg"
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
                IncludesInteriorSteamSanitization = true,
                ImageUrl = "Images/Services/ceramic_top_shield.jpg"
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
                IncludesInteriorSteamSanitization = true,
                ImageUrl = "Images/Services/car_aroma_therapy.jpg"
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
                IncludesInteriorSteamSanitization = true,
                ImageUrl = "Images/Services/interior_deep_spa.jpg"
            });

            _catalogServices.Add(new PPFProtectionService
            {
                Id = 14,
                ServiceName = "Gloss Auto PPF (Full Body)",
                ShortDescription = "Self-healing TPU with UV and acid rain protection and mirror finish.",
                BasePrice = 51500m,
                Duration = "2 Days",
                Warranty = "5 Years Warranty",
                Category = "Protection (PPF)",
                Rating = 4.7m,
                FilmThicknessMicrons = "190 Microns TPU",
                ImageUrl = "Images/Services/gloss_auto_ppf.jpg"
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

        private void InitializeBayQueue()
        {
            // Queue<T> FIFO: Pre-load active studio detailing bays
            _bayServiceQueue.Enqueue(new StudioBooking
            {
                Id = 1,
                BookingCode = "CCC-100229",
                ServiceName = "Full Body PPF Protection",
                VehicleDetails = "Hyundai Creta",
                SlotDate = DateTime.Today,
                SlotTime = "10:00 AM",
                BookingStatus = "In Progress",
                TrackingStep = 4
            });

            _bayServiceQueue.Enqueue(new StudioBooking
            {
                Id = 2,
                BookingCode = "CCC-100231",
                ServiceName = "Ceramic Top Shield",
                VehicleDetails = "Honda City",
                SlotDate = DateTime.Today,
                SlotTime = "01:00 PM",
                BookingStatus = "Pending",
                TrackingStep = 1
            });

            // Stack<T> LIFO: Pre-load audit action trace
            _stageAuditStack.Push("System initialized Detailing Bay 1 for CCC-100229");
            _stageAuditStack.Push("Surface decontamination and clay bar treatment completed");
            _stageAuditStack.Push("Paint inspection completed: 0 scratches detected");
        }

        private void InitializeNonGenericCollections()
        {
            // Non-Generic: ArrayList (Adding diverse equipment items)
            _studioEquipmentList.Add("Rupes BigFoot Dual Action Polisher LHR21");
            _studioEquipmentList.Add("Steamer Vapor Clean SV9");
            _studioEquipmentList.Add("Ceramic Coating IR Curing Lamps (3000W)");
            _studioEquipmentList.Add("PPF Hot Air Edge Sealer Gun");

            // Non-Generic: Hashtable (Key-Value configuration metadata)
            _studioMetaHashtable["WorkshopName"] = "Creation Car Care Studio";
            _studioMetaHashtable["City"] = "Rajkot, Gujarat";
            _studioMetaHashtable["MaxSimultaneousBays"] = 4;
            _studioMetaHashtable["IsDustFreeChamberActive"] = true;
        }

        #region Collection Operations: List<T> & LINQ
        public List<BaseServicePackage> GetFeaturedServices()
        {
            return _catalogServices
                .Where(s => s.IsActive)
                .OrderByDescending(s => s.Rating)
                .ToList();
        }

        public Dictionary<string, decimal> GetCategoryDiscountRates()
        {
            return _promoDiscountRates;
        }

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
        #endregion

        #region Polymorphism & Pricing Calculations
        public decimal CalculateFinalPrice(BaseServicePackage service, string promoCode)
        {
            if (service == null) return 0m;

            decimal discount = 0m;
            if (!string.IsNullOrWhiteSpace(promoCode))
            {
                if (_promoDiscountRates.ContainsKey(promoCode))
                {
                    discount = _promoDiscountRates[promoCode];
                }
                else
                {
                    // Demonstrating Custom Exception (Syllabus Unit 3)
                    throw new InvalidPromoCodeException($"The promotional coupon '{promoCode}' is expired or invalid.", promoCode);
                }
            }

            // Polymorphism in action: invokes derived service's overridden CalculateDiscountedPrice method
            return service.CalculateDiscountedPrice(discount);
        }
        #endregion

        #region Generic Queue<T> Operations (FIFO - First In, First Out)
        public void EnqueueBayBooking(StudioBooking booking)
        {
            if (booking == null) return;
            _bayServiceQueue.Enqueue(booking);
        }

        public StudioBooking DequeueNextBayBooking()
        {
            return _bayServiceQueue.Count > 0 ? _bayServiceQueue.Dequeue() : null;
        }

        public StudioBooking PeekNextBayBooking()
        {
            return _bayServiceQueue.Count > 0 ? _bayServiceQueue.Peek() : null;
        }

        public int GetBayQueueCount()
        {
            return _bayServiceQueue.Count;
        }
        #endregion

        #region Generic Stack<T> Operations (LIFO - Last In, First Out)
        public void PushAuditLog(string message)
        {
            if (!string.IsNullOrWhiteSpace(message))
            {
                _stageAuditStack.Push($"[{DateTime.Now:HH:mm:ss}] {message}");
            }
        }

        public string PopAuditLog()
        {
            return _stageAuditStack.Count > 0 ? _stageAuditStack.Pop() : null;
        }

        public string PeekRecentAuditLog()
        {
            return _stageAuditStack.Count > 0 ? _stageAuditStack.Peek() : "No recent activity";
        }

        public List<string> GetAllAuditLogs()
        {
            return _stageAuditStack.ToList();
        }
        #endregion

        #region Non-Generic Collections: ArrayList & Hashtable (Syllabus Unit 4)
        public ArrayList GetStudioEquipmentList()
        {
            return _studioEquipmentList;
        }

        public Hashtable GetStudioMetadata()
        {
            return _studioMetaHashtable;
        }
        #endregion

        #region Event Notification Invocation (Syllabus Unit 3: Event Handling)
        public void NotifyBookingStatusChanged(string bookingCode, string serviceName, string newStatus)
        {
            // Push to audit stack
            PushAuditLog($"Status changed for booking {bookingCode}: {newStatus}");

            // Raise the delegate event to all registered subscribers
            OnBookingStatusChanged?.Invoke(this, new BookingEventArgs(bookingCode, serviceName, newStatus));
        }
        #endregion
    }
}
