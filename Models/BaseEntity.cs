using System;

namespace creation_car_care.Models
{
    /// <summary>
    /// Abstraction: Abstract base class providing common properties and contract for all studio entities
    /// </summary>
    public abstract class BaseEntity
    {
        // Encapsulation: Private backing field with public getter/setter
        private int _id;
        public int Id
        {
            get => _id;
            set => _id = value;
        }

        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public bool IsActive { get; set; } = true;

        // Abstract method enforcing polymorphism across derived classes
        public abstract string GetEntitySummary();
    }
}
