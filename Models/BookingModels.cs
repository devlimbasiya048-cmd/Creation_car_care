using System;

namespace creation_car_care.Models
{
    /// <summary>
    /// Strongly typed Studio Booking Entity
    /// </summary>
    public class StudioBooking : BaseEntity
    {
        public string BookingCode { get; set; }
        public int UserId { get; set; }
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public string VehicleDetails { get; set; }
        public DateTime SlotDate { get; set; }
        public string SlotTime { get; set; }
        public decimal TotalAmount { get; set; }
        public string PaymentMethod { get; set; }
        public string PaymentStatus { get; set; } = "Paid";
        public string BookingStatus { get; set; } = "Upcoming";
        public int TrackingStep { get; set; } = 1;
        public string Notes { get; set; }

        public override string GetEntitySummary()
        {
            return $"Booking {BookingCode} - {ServiceName} on {SlotDate:dd MMM yyyy} ({SlotTime}) - Status: {BookingStatus}";
        }
    }
}
