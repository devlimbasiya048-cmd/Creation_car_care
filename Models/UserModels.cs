using System;

namespace creation_car_care.Models
{
    /// <summary>
    /// Base class for all users in the studio system (Inheritance & Encapsulation)
    /// </summary>
    public abstract class UserBase : BaseEntity
    {
        public string FullName { get; set; }
        public string Email { get; set; }
        public string MobileNumber { get; set; }

        // Virtual method for Polymorphism (Method Overriding)
        public virtual string GetRoleDescription()
        {
            return "Standard Studio User";
        }

        public override string GetEntitySummary()
        {
            return $"[User #{Id}] {FullName} ({Email}) - Role: {GetRoleDescription()}";
        }
    }

    /// <summary>
    /// Derived Customer class inheriting from UserBase (Inheritance)
    /// </summary>
    public class CustomerUser : UserBase
    {
        public string PreferredVehicle { get; set; }
        public int LoyaltyPoints { get; set; } = 0;

        // Polymorphism: Overriding role description
        public override string GetRoleDescription()
        {
            return "Valued Studio Customer";
        }
    }

    /// <summary>
    /// Derived Admin class inheriting from UserBase (Inheritance)
    /// </summary>
    public class AdminUser : UserBase
    {
        public string AdminRole { get; set; } = "Studio Administrator";
        public bool HasMasterPrivileges { get; set; } = true;

        // Polymorphism: Overriding role description
        public override string GetRoleDescription()
        {
            return $"Administrator ({AdminRole})";
        }
    }
}
