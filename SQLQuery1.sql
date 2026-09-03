USE CreationCarCareDB;

-- 1. Users Table (Registration & Login mate)
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    MobileNumber NVARCHAR(20),
    Email NVARCHAR(100),
    Password NVARCHAR(100)
);

-- 2. Vehicles Table (User na registered vehicles mate jevi ke Hyundai Creta, Bike vagere)[cite: 11]
CREATE TABLE Vehicles (
    VehicleId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT,
    VehicleType NVARCHAR(50), -- Car / Bike
    Brand NVARCHAR(50),
    ModelName NVARCHAR(100),
    RegistrationNumber NVARCHAR(50),
    IsPrimary BIT DEFAULT 0
);

-- 3. Services Table (Catalog ane details mate)
CREATE TABLE Services (
    ServiceId INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(100),
    ShortDescription NVARCHAR(500),
    Price DECIMAL(18,2),
    Duration NVARCHAR(50),
    Warranty NVARCHAR(50)
);

-- 4. Bookings Table (Slot booking ane status tracking mate)[cite: 11]
CREATE TABLE Bookings (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    BookingCode NVARCHAR(50), -- e.g. #CCC-849206
    UserId INT,
    VehicleDetails NVARCHAR(200),
    SelectedServices NVARCHAR(500),
    TotalAmount DECIMAL(18,2),
    SlotDate NVARCHAR(50),
    SlotTime NVARCHAR(50),
    PaymentStatus NVARCHAR(50), -- Paid / COD
    BookingStatus NVARCHAR(50)  -- Confirmed / In Progress / Completed
);