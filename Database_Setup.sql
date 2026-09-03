/****** CreationCarCareDB Full Database & Tables Export Script ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'CreationCarCareDB')
BEGIN
    CREATE DATABASE CreationCarCareDB;
END
GO
USE CreationCarCareDB;
GO

-- =============================================
-- Table: Categories
-- =============================================
IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL DROP TABLE dbo.Categories;
GO
CREATE TABLE [dbo].[Categories] (
    [CategoryId] INT IDENTITY(1,1) NOT NULL,
    [CategoryName] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(255) NULL,
    [DisplayOrder] INT NULL DEFAULT ((1)),
    [IsActive] BIT NULL DEFAULT ((1)),
    [CreatedAt] DATETIME NULL DEFAULT (getdate()),
    [Icon] NVARCHAR(50) NULL DEFAULT ('???'),
    [ColorAccent] NVARCHAR(50) NULL DEFAULT ('#8b5cf6'),
    CONSTRAINT [PK_Categories] PRIMARY KEY ([CategoryId])
);
GO

SET IDENTITY_INSERT [dbo].[Categories] ON;
GO
INSERT INTO [dbo].[Categories] ([CategoryId], [CategoryName], [Description], [DisplayOrder], [IsActive], [CreatedAt], [Icon], [ColorAccent]) VALUES (2002, N'Protection (PPF)', N'Self-healing Paint Protection Film shields', 1, 1, N'11-10-2026 13:17:16', N'&#128737;', N'#8b5cf6');
INSERT INTO [dbo].[Categories] ([CategoryId], [CategoryName], [Description], [DisplayOrder], [IsActive], [CreatedAt], [Icon], [ColorAccent]) VALUES (2003, N'Ceramic Coating', N'High gloss hydrophobic 9H ceramic coating protection', 2, 1, N'11-10-2026 13:17:16', N'&#10024;', N'#ea580c');
INSERT INTO [dbo].[Categories] ([CategoryId], [CategoryName], [Description], [DisplayOrder], [IsActive], [CreatedAt], [Icon], [ColorAccent]) VALUES (2004, N'Correction', N'Paint swirl marks and scratch correction treatments', 3, 1, N'11-10-2026 13:17:16', N'&#128663;', N'#10b981');
INSERT INTO [dbo].[Categories] ([CategoryId], [CategoryName], [Description], [DisplayOrder], [IsActive], [CreatedAt], [Icon], [ColorAccent]) VALUES (2005, N'Spa & Detailing', N'Interior sanitization, steam spa and deep cleaning', 4, 1, N'11-10-2026 13:17:16', N'&#128167;', N'#3b82f6');
SET IDENTITY_INSERT [dbo].[Categories] OFF;
GO
GO

-- =============================================
-- Table: StudioSettings
-- =============================================
IF OBJECT_ID('dbo.StudioSettings', 'U') IS NOT NULL DROP TABLE dbo.StudioSettings;
GO
CREATE TABLE [dbo].[StudioSettings] (
    [SettingId] INT IDENTITY(1,1) NOT NULL,
    [StudioName] NVARCHAR(100) NOT NULL,
    [AdminName] NVARCHAR(100) NOT NULL,
    [ContactEmail] NVARCHAR(100) NOT NULL,
    [ContactPhone] NVARCHAR(50) NOT NULL,
    [Address] NVARCHAR(255) NOT NULL,
    [WorkingHoursText] NVARCHAR(100) NOT NULL,
    [NotificationsEnabled] BIT NULL DEFAULT ((1)),
    [UpdatedAt] DATETIME NULL DEFAULT (getdate()),
    CONSTRAINT [PK_StudioSettings] PRIMARY KEY ([SettingId])
);
GO

SET IDENTITY_INSERT [dbo].[StudioSettings] ON;
GO
INSERT INTO [dbo].[StudioSettings] ([SettingId], [StudioName], [AdminName], [ContactEmail], [ContactPhone], [Address], [WorkingHoursText], [NotificationsEnabled], [UpdatedAt]) VALUES (1, N'Creation Car Care', N'Dev Limbasiya', N'admin@creation.com', N'+91 96622 81476', N'Nagrik Bank Chowk, Opposite Madhuram Hospital, near Dhebar Road, Bhaktinagar Society, Bhakti Nagar, Rajkot, Gujarat 360002', N'Open Daily (9am - 8pm)', 1, N'11-10-2026 13:01:38');
SET IDENTITY_INSERT [dbo].[StudioSettings] OFF;
GO
GO

-- =============================================
-- Table: WorkingHours
-- =============================================
IF OBJECT_ID('dbo.WorkingHours', 'U') IS NOT NULL DROP TABLE dbo.WorkingHours;
GO
CREATE TABLE [dbo].[WorkingHours] (
    [SlotId] INT IDENTITY(1,1) NOT NULL,
    [SlotTime] NVARCHAR(50) NOT NULL,
    [ShiftType] NVARCHAR(50) NOT NULL,
    [IsEnabled] BIT NULL DEFAULT ((1)),
    [DisplayOrder] INT NULL DEFAULT ((1)),
    CONSTRAINT [PK_WorkingHours] PRIMARY KEY ([SlotId])
);
GO

SET IDENTITY_INSERT [dbo].[WorkingHours] ON;
GO
INSERT INTO [dbo].[WorkingHours] ([SlotId], [SlotTime], [ShiftType], [IsEnabled], [DisplayOrder]) VALUES (1, N'09:00 AM - 10:30 AM', N'Morning Shift', 1, 1);
INSERT INTO [dbo].[WorkingHours] ([SlotId], [SlotTime], [ShiftType], [IsEnabled], [DisplayOrder]) VALUES (2, N'10:30 AM - 12:00 PM', N'Morning Shift', 1, 2);
INSERT INTO [dbo].[WorkingHours] ([SlotId], [SlotTime], [ShiftType], [IsEnabled], [DisplayOrder]) VALUES (3, N'12:00 PM - 01:00 PM (Lunch Break)', N'Break Time', 0, 3);
INSERT INTO [dbo].[WorkingHours] ([SlotId], [SlotTime], [ShiftType], [IsEnabled], [DisplayOrder]) VALUES (4, N'01:00 PM - 02:30 PM', N'Afternoon Shift', 1, 4);
INSERT INTO [dbo].[WorkingHours] ([SlotId], [SlotTime], [ShiftType], [IsEnabled], [DisplayOrder]) VALUES (5, N'02:30 PM - 04:00 PM', N'Afternoon Shift', 1, 5);
INSERT INTO [dbo].[WorkingHours] ([SlotId], [SlotTime], [ShiftType], [IsEnabled], [DisplayOrder]) VALUES (6, N'04:00 PM - 06:00 PM', N'Evening Shift', 1, 6);
SET IDENTITY_INSERT [dbo].[WorkingHours] OFF;
GO
GO

-- =============================================
-- Table: AdminActivities
-- =============================================
IF OBJECT_ID('dbo.AdminActivities', 'U') IS NOT NULL DROP TABLE dbo.AdminActivities;
GO
CREATE TABLE [dbo].[AdminActivities] (
    [ActivityId] INT IDENTITY(1,1) NOT NULL,
    [ActivityType] NVARCHAR(50) NOT NULL,
    [Title] NVARCHAR(150) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    [BadgeColor] NVARCHAR(50) NULL DEFAULT ('#10b981'),
    [Amount] DECIMAL(18, 2) NULL,
    [CreatedAt] DATETIME NULL DEFAULT (getdate()),
    CONSTRAINT [PK_AdminActivities] PRIMARY KEY ([ActivityId])
);
GO

SET IDENTITY_INSERT [dbo].[AdminActivities] ON;
GO
INSERT INTO [dbo].[AdminActivities] ([ActivityId], [ActivityType], [Title], [Description], [BadgeColor], [Amount], [CreatedAt]) VALUES (1, N'Booking Completed', N'Booking #CCC-849206 Completed', N'Payment of Rs. 45,599 received via UPI (Full Body PPF)', N'#10b981', 45599.00, N'11-10-2026 09:34:41');
INSERT INTO [dbo].[AdminActivities] ([ActivityId], [ActivityType], [Title], [Description], [BadgeColor], [Amount], [CreatedAt]) VALUES (2, N'User Registered', N'New User Registered', N'Rahul Patel registered account and verified mobile number', N'#3b82f6', NULL, N'11-10-2026 07:34:41');
INSERT INTO [dbo].[AdminActivities] ([ActivityId], [ActivityType], [Title], [Description], [BadgeColor], [Amount], [CreatedAt]) VALUES (3, N'Booking Cancelled', N'Booking Cancelled', N'Booking #CCC-1103 was cancelled by customer (Reason: Out of station)', N'#ef4444', NULL, N'11-10-2026 05:34:41');
INSERT INTO [dbo].[AdminActivities] ([ActivityId], [ActivityType], [Title], [Description], [BadgeColor], [Amount], [CreatedAt]) VALUES (4, N'Support Inquiry', N'New Support Ticket Raised', N'Customer requested detailed warranty information for PPF', N'#f59e0b', NULL, N'10-10-2026 09:34:41');
INSERT INTO [dbo].[AdminActivities] ([ActivityId], [ActivityType], [Title], [Description], [BadgeColor], [Amount], [CreatedAt]) VALUES (5, N'Booking Rescheduled', N'Booking Rescheduled', N'Booking #CCC-721004 rescheduled slot to 18 Aug, 10:30 AM', N'#8b5cf6', NULL, N'09-10-2026 09:34:41');
INSERT INTO [dbo].[AdminActivities] ([ActivityId], [ActivityType], [Title], [Description], [BadgeColor], [Amount], [CreatedAt]) VALUES (6, N'Review Added', N'New 5-Star Review Added', N'Hemal Vala rated 5 stars: Awesome studio detailing work!', N'#10b981', NULL, N'08-10-2026 09:34:41');
SET IDENTITY_INSERT [dbo].[AdminActivities] OFF;
GO
GO

-- =============================================
-- Table: Offers
-- =============================================
IF OBJECT_ID('dbo.Offers', 'U') IS NOT NULL DROP TABLE dbo.Offers;
GO
CREATE TABLE [dbo].[Offers] (
    [OfferId] INT IDENTITY(1,1) NOT NULL,
    [DiscountPercentage] VARCHAR(10) NULL,
    [OfferTitle] VARCHAR(100) NULL,
    [OfferDescription] VARCHAR(255) NULL,
    [StartDate] DATE NULL,
    [EndDate] DATE NULL,
    [ValidityText] VARCHAR(150) NULL,
    [PromoCode] NVARCHAR(50) NULL DEFAULT ('OFFER20'),
    [IsActive] BIT NOT NULL DEFAULT ((1)),
    CONSTRAINT [PK_Offers] PRIMARY KEY ([OfferId])
);
GO

SET IDENTITY_INSERT [dbo].[Offers] ON;
GO
INSERT INTO [dbo].[Offers] ([OfferId], [DiscountPercentage], [OfferTitle], [OfferDescription], [StartDate], [EndDate], [ValidityText], [PromoCode], [IsActive]) VALUES (1, N'20%', N'Navratri Special Offer 2026', N'Get 20% Flat OFF on Ceramic Coating & Car Detailing Services during Navratri Festival.', N'01-10-2026 00:00:00', N'25-10-2026 00:00:00', N'Valid: 01 Oct 2026 to 25 Oct 2026', NULL, 1);
INSERT INTO [dbo].[Offers] ([OfferId], [DiscountPercentage], [OfferTitle], [OfferDescription], [StartDate], [EndDate], [ValidityText], [PromoCode], [IsActive]) VALUES (2, N'25%', N'Diwali Dhamaka Offer 2026', N'Get 25% Flat OFF on Paint Protection Film (PPF) & Full Body Polishing for Diwali.', N'01-11-2026 00:00:00', N'20-11-2026 00:00:00', N'Valid: 01 Nov 2026 to 20 Nov 2026', NULL, 1);
SET IDENTITY_INSERT [dbo].[Offers] OFF;
GO
GO

-- =============================================
-- Table: Payments
-- =============================================
IF OBJECT_ID('dbo.Payments', 'U') IS NOT NULL DROP TABLE dbo.Payments;
GO
CREATE TABLE [dbo].[Payments] (
    [PaymentId] INT IDENTITY(1,1) NOT NULL,
    [BookingId] INT NULL,
    [BookingCode] NVARCHAR(50) NOT NULL,
    [CustomerName] NVARCHAR(100) NOT NULL,
    [Amount] DECIMAL(18, 2) NOT NULL,
    [PaymentMethod] NVARCHAR(50) NOT NULL,
    [PaymentStatus] NVARCHAR(50) NULL DEFAULT ('Paid'),
    [TransactionDate] DATETIME NULL DEFAULT (getdate()),
    CONSTRAINT [PK_Payments] PRIMARY KEY ([PaymentId])
);
GO

SET IDENTITY_INSERT [dbo].[Payments] ON;
GO
INSERT INTO [dbo].[Payments] ([PaymentId], [BookingId], [BookingCode], [CustomerName], [Amount], [PaymentMethod], [PaymentStatus], [TransactionDate]) VALUES (1, NULL, N'#CCC-849206', N'Dev Limbasiya', 45599.00, N'Online UPI', N'Paid', N'11-10-2026 09:34:41');
INSERT INTO [dbo].[Payments] ([PaymentId], [BookingId], [BookingCode], [CustomerName], [Amount], [PaymentMethod], [PaymentStatus], [TransactionDate]) VALUES (2, NULL, N'#CCC-902371', N'Rahul Patel', 12000.00, N'Credit Card', N'Paid', N'10-10-2026 09:34:41');
INSERT INTO [dbo].[Payments] ([PaymentId], [BookingId], [BookingCode], [CustomerName], [Amount], [PaymentMethod], [PaymentStatus], [TransactionDate]) VALUES (3, NULL, N'#CCC-721004', N'Amit Sharma', 14999.00, N'Net Banking', N'Paid', N'09-10-2026 09:34:41');
INSERT INTO [dbo].[Payments] ([PaymentId], [BookingId], [BookingCode], [CustomerName], [Amount], [PaymentMethod], [PaymentStatus], [TransactionDate]) VALUES (4, NULL, N'#CCC-618492', N'Priya Shah', 6500.00, N'Online UPI', N'Paid', N'08-10-2026 09:34:41');
INSERT INTO [dbo].[Payments] ([PaymentId], [BookingId], [BookingCode], [CustomerName], [Amount], [PaymentMethod], [PaymentStatus], [TransactionDate]) VALUES (5, NULL, N'#CCC-132145', N'Keval Mehta', 36000.00, N'Cash on Delivery', N'Paid', N'07-10-2026 09:34:41');
SET IDENTITY_INSERT [dbo].[Payments] OFF;
GO
GO

-- =============================================
-- Table: Services
-- =============================================
IF OBJECT_ID('dbo.Services', 'U') IS NOT NULL DROP TABLE dbo.Services;
GO
CREATE TABLE [dbo].[Services] (
    [ServiceId] INT IDENTITY(1,1) NOT NULL,
    [ServiceName] NVARCHAR(100) NULL,
    [ShortDescription] NVARCHAR(500) NULL,
    [Price] DECIMAL(18, 2) NULL,
    [Duration] NVARCHAR(50) NULL,
    [Warranty] NVARCHAR(50) NULL,
    [Category] NVARCHAR(50) NULL DEFAULT ('Correction'),
    [Rating] DECIMAL(2, 1) NULL DEFAULT ((4.5)),
    [IsActive] BIT NOT NULL DEFAULT ((1)),
    [ImageUrl] NVARCHAR(300) NULL,
    CONSTRAINT [PK_Services] PRIMARY KEY ([ServiceId])
);
GO

SET IDENTITY_INSERT [dbo].[Services] ON;
GO
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (4, N'Full Body PPF Protection', N'Self-healing TPU film, ultimate protection.', 45000.00, N'2 Days', N'5 Years Warranty', N'Protection (PPF)', 4.9, 1, N'~/Images/Services/full_body_ppf.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (5, N'Ceramic Top Shield', N'Extreme gloss-like glass finish with advanced hydrophobic layer.', 12000.00, N'4 - 5 Hours', N'2 Years Warranty', N'Ceramic Coating', 4.8, 1, N'~/Images/Services/ceramic_top_shield.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (6, N'Car aroma therapy - Basic', N'Protects from bacteria & cleans seats.', 599.00, N'60 mins', N'1 Month', N'Spa & Detailing', 4.0, 1, N'~/Images/Services/car_aroma_therapy.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (7, N'Interior Deep Spa & Detailing', N'Complete seat shampoo, dashboard steam cleaning and floor cleaning.', 2500.00, N'3 Hours', N'3 Months', N'Spa & Detailing', 4.5, 1, N'~/Images/Services/interior_deep_spa.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (10, N'Salt water stain removal treatment', N'Deep chemical decontamination to remove mineral & salt stains.', 2700.00, N'90 mins', N'1 Month', N'Correction', 4.0, 1, N'~/Images/Services/salt_water_stain.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (11, N'Windshield Scratch Remover', N'Glass diamond polishing to eliminate night glare and wiper marks.', 3800.00, N'150 mins', N'6 Months', N'Correction', 4.2, 1, N'~/Images/Services/windshield_scratch.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (12, N'Front Bumper PPF Guard', N'High impact self-healing polyurethane protection for front bumper.', 8500.00, N'4 Hours', N'3 Years', N'Protection (PPF)', 4.8, 1, N'~/Images/Services/bumper_ppf_guard.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (13, N'Headlight & Taillight PPF', N'Prevents yellowing, oxidation and road stone scratches on lights.', 3500.00, N'2 Hours', N'3 Years', N'Protection (PPF)', 4.7, 1, N'~/Images/Services/headlight_ppf.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (14, N'Gloss Auto PPF (Full Body)', N'Self-healing TPU with UV/acid rain protection and premium gloss finish.', 51500.00, N'2 Days', N'5 Years Warranty', N'Protection (PPF)', 4.5, 1, N'~/Images/Services/gloss_auto_ppf.jpg');
INSERT INTO [dbo].[Services] ([ServiceId], [ServiceName], [ShortDescription], [Price], [Duration], [Warranty], [Category], [Rating], [IsActive], [ImageUrl]) VALUES (15, N'9H Ceramic Coating', N'High gloss, hydrophobic layer that shields dirty, harsh water and scratches.', 14200.00, N'1 Day', N'3 Years Warranty', N'Ceramic Coating', 4.5, 1, N'~/Images/Services/9h_ceramic_coating.jpg');
SET IDENTITY_INSERT [dbo].[Services] OFF;
GO
GO

-- =============================================
-- Table: ContactInquiries
-- =============================================
IF OBJECT_ID('dbo.ContactInquiries', 'U') IS NOT NULL DROP TABLE dbo.ContactInquiries;
GO
CREATE TABLE [dbo].[ContactInquiries] (
    [InquiryId] INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Mobile] NVARCHAR(20) NOT NULL,
    [Message] NVARCHAR(MAX) NOT NULL,
    [SubmittedAt] DATETIME NULL DEFAULT (getdate()),
    CONSTRAINT [PK_ContactInquiries] PRIMARY KEY ([InquiryId])
);
GO

SET IDENTITY_INSERT [dbo].[ContactInquiries] ON;
GO
INSERT INTO [dbo].[ContactInquiries] ([InquiryId], [Name], [Mobile], [Message], [SubmittedAt]) VALUES (1, N'dev', N'6354057812', N'your services is best in Rajkot', N'11-10-2026 12:52:11');
SET IDENTITY_INSERT [dbo].[ContactInquiries] OFF;
GO
GO

-- =============================================
-- Table: Cart
-- =============================================
IF OBJECT_ID('dbo.Cart', 'U') IS NOT NULL DROP TABLE dbo.Cart;
GO
CREATE TABLE [dbo].[Cart] (
    [CartId] INT IDENTITY(1,1) NOT NULL,
    [UserId] INT NOT NULL,
    [ServiceId] INT NOT NULL,
    [Quantity] INT NOT NULL DEFAULT ((1)),
    [AddedAt] DATETIME NULL DEFAULT (getdate()),
    CONSTRAINT [PK_Cart] PRIMARY KEY ([CartId])
);
GO

SET IDENTITY_INSERT [dbo].[Cart] ON;
GO
INSERT INTO [dbo].[Cart] ([CartId], [UserId], [ServiceId], [Quantity], [AddedAt]) VALUES (10, 25, 4, 2, N'08-10-2026 20:20:25');
SET IDENTITY_INSERT [dbo].[Cart] OFF;
GO
GO

-- =============================================
-- Table: Admins
-- =============================================
IF OBJECT_ID('dbo.Admins', 'U') IS NOT NULL DROP TABLE dbo.Admins;
GO
CREATE TABLE [dbo].[Admins] (
    [AdminId] INT IDENTITY(1,1) NOT NULL,
    [FullName] NVARCHAR(100) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL,
    [Password] NVARCHAR(100) NOT NULL,
    [MobileNumber] NVARCHAR(20) NULL,
    [Role] NVARCHAR(50) NULL DEFAULT ('Super Admin'),
    [ProfileImage] NVARCHAR(255) NULL,
    [IsActive] BIT NOT NULL DEFAULT ((1)),
    [CreatedAt] DATETIME NULL DEFAULT (getdate()),
    CONSTRAINT [PK_Admins] PRIMARY KEY ([AdminId])
);
GO

SET IDENTITY_INSERT [dbo].[Admins] ON;
GO
INSERT INTO [dbo].[Admins] ([AdminId], [FullName], [Email], [Password], [MobileNumber], [Role], [ProfileImage], [IsActive], [CreatedAt]) VALUES (1, N'Dev Limbasiya', N'admin@creation.com', N'admin123', N'+91 96622 81476', N'Super Admin', NULL, 1, N'11-10-2026 10:51:28');
SET IDENTITY_INSERT [dbo].[Admins] OFF;
GO
GO

-- =============================================
-- Table: Wishlist
-- =============================================
IF OBJECT_ID('dbo.Wishlist', 'U') IS NOT NULL DROP TABLE dbo.Wishlist;
GO
CREATE TABLE [dbo].[Wishlist] (
    [WishlistId] INT IDENTITY(1,1) NOT NULL,
    [UserId] INT NOT NULL,
    [ServiceId] INT NOT NULL,
    [AddedAt] DATETIME NULL DEFAULT (getdate()),
    CONSTRAINT [PK_Wishlist] PRIMARY KEY ([WishlistId])
);
GO

SET IDENTITY_INSERT [dbo].[Wishlist] ON;
GO
INSERT INTO [dbo].[Wishlist] ([WishlistId], [UserId], [ServiceId], [AddedAt]) VALUES (6, 1, 6, N'08-10-2026 18:22:01');
INSERT INTO [dbo].[Wishlist] ([WishlistId], [UserId], [ServiceId], [AddedAt]) VALUES (7, 25, 4, N'08-10-2026 20:18:41');
INSERT INTO [dbo].[Wishlist] ([WishlistId], [UserId], [ServiceId], [AddedAt]) VALUES (8, 1, 4, N'08-10-2026 20:36:36');
SET IDENTITY_INSERT [dbo].[Wishlist] OFF;
GO
GO

-- =============================================
-- Table: Users
-- =============================================
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
GO
CREATE TABLE [dbo].[Users] (
    [UserId] INT IDENTITY(1,1) NOT NULL,
    [FullName] NVARCHAR(100) NULL,
    [MobileNumber] NVARCHAR(20) NULL,
    [Email] NVARCHAR(100) NULL,
    [Password] NVARCHAR(100) NULL,
    [IsAdmin] BIT NULL DEFAULT ((0)),
    [ProfileImage] NVARCHAR(255) NULL,
    [IsBlocked] BIT NOT NULL DEFAULT ((0)),
    CONSTRAINT [PK_Users] PRIMARY KEY ([UserId])
);
GO

SET IDENTITY_INSERT [dbo].[Users] ON;
GO
INSERT INTO [dbo].[Users] ([UserId], [FullName], [MobileNumber], [Email], [Password], [IsAdmin], [ProfileImage], [IsBlocked]) VALUES (1, N'dev Limbasiya', N'+91 98765 43210', N'dev123@gmail.com', N'123456', NULL, NULL, 0);
INSERT INTO [dbo].[Users] ([UserId], [FullName], [MobileNumber], [Email], [Password], [IsAdmin], [ProfileImage], [IsBlocked]) VALUES (25, N'Karan Dave', N'+91 97240 11223', N'karan123@gmail.com', N'karan123', 0, NULL, 0);
INSERT INTO [dbo].[Users] ([UserId], [FullName], [MobileNumber], [Email], [Password], [IsAdmin], [ProfileImage], [IsBlocked]) VALUES (26, N'Rahul Patel', N'+91 98981 23456', N'rahul@gmail.com', N'rahul123', 0, NULL, 0);
INSERT INTO [dbo].[Users] ([UserId], [FullName], [MobileNumber], [Email], [Password], [IsAdmin], [ProfileImage], [IsBlocked]) VALUES (27, N'Amit Sharma', N'+91 98250 99887', N'amit@gmail.com', N'amit123', 0, NULL, 1);
INSERT INTO [dbo].[Users] ([UserId], [FullName], [MobileNumber], [Email], [Password], [IsAdmin], [ProfileImage], [IsBlocked]) VALUES (1026, N'Priya Shah', N'+91 98980 44556', N'priya@gmail.com', N'priya123', 0, NULL, 0);
INSERT INTO [dbo].[Users] ([UserId], [FullName], [MobileNumber], [Email], [Password], [IsAdmin], [ProfileImage], [IsBlocked]) VALUES (1027, N'Keval Mehta', N'+91 99090 77889', N'keval@gmail.com', N'keval123', 0, NULL, 0);
SET IDENTITY_INSERT [dbo].[Users] OFF;
GO
GO

-- =============================================
-- Table: Vehicles
-- =============================================
IF OBJECT_ID('dbo.Vehicles', 'U') IS NOT NULL DROP TABLE dbo.Vehicles;
GO
CREATE TABLE [dbo].[Vehicles] (
    [VehicleId] INT IDENTITY(1,1) NOT NULL,
    [UserId] INT NULL,
    [VehicleType] NVARCHAR(50) NULL,
    [Brand] NVARCHAR(50) NULL,
    [ModelName] NVARCHAR(100) NULL,
    [RegistrationNumber] NVARCHAR(50) NULL,
    [IsPrimary] BIT NULL DEFAULT ((0)),
    [Color] NVARCHAR(50) NULL,
    CONSTRAINT [PK_Vehicles] PRIMARY KEY ([VehicleId])
);
GO

SET IDENTITY_INSERT [dbo].[Vehicles] ON;
GO
INSERT INTO [dbo].[Vehicles] ([VehicleId], [UserId], [VehicleType], [Brand], [ModelName], [RegistrationNumber], [IsPrimary], [Color]) VALUES (1, 1, N'SUV', N'Hyundai', N'Hyundai Creta', N'GJ 03 AB 1234', 1, N'White Color');
INSERT INTO [dbo].[Vehicles] ([VehicleId], [UserId], [VehicleType], [Brand], [ModelName], [RegistrationNumber], [IsPrimary], [Color]) VALUES (2, 1, N'Bike', N'Royal Enfield', N'Royal Enfield Classic', N'GJ 03 XY 9876', 0, N'Black Color');
INSERT INTO [dbo].[Vehicles] ([VehicleId], [UserId], [VehicleType], [Brand], [ModelName], [RegistrationNumber], [IsPrimary], [Color]) VALUES (3, 25, N'SUV / Car', N'Kia', N'kia +', N'GJO36345', 1, N'Black');
SET IDENTITY_INSERT [dbo].[Vehicles] OFF;
GO
GO

-- =============================================
-- Table: Bookings
-- =============================================
IF OBJECT_ID('dbo.Bookings', 'U') IS NOT NULL DROP TABLE dbo.Bookings;
GO
CREATE TABLE [dbo].[Bookings] (
    [BookingId] INT IDENTITY(1,1) NOT NULL,
    [BookingCode] NVARCHAR(50) NOT NULL,
    [UserId] INT NOT NULL,
    [ServiceId] INT NOT NULL,
    [VehicleDetails] NVARCHAR(150) NULL,
    [SlotDate] DATE NOT NULL,
    [SlotTime] NVARCHAR(50) NOT NULL,
    [TotalAmount] DECIMAL(18, 2) NOT NULL,
    [PaymentMethod] NVARCHAR(50) NULL DEFAULT ('Online UPI'),
    [PaymentStatus] NVARCHAR(50) NULL DEFAULT ('Paid'),
    [BookingStatus] NVARCHAR(50) NULL DEFAULT ('Upcoming'),
    [TrackingStep] INT NULL DEFAULT ((1)),
    [Notes] NVARCHAR(500) NULL,
    [CancellationReason] NVARCHAR(255) NULL,
    [CreatedAt] DATETIME NULL DEFAULT (getdate()),
    [Rating] INT NULL,
    [ReviewText] NVARCHAR(500) NULL,
    [OfferTitle] NVARCHAR(150) NULL,
    [DiscountAmount] DECIMAL(18, 2) NULL,
    [OriginalAmount] DECIMAL(18, 2) NULL,
    CONSTRAINT [PK_Bookings] PRIMARY KEY ([BookingId])
);
GO

SET IDENTITY_INSERT [dbo].[Bookings] ON;
GO
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (2, N'#CCC-902371', 1, 5, N'Hyundai Creta (GJ 03 AB 1234)', N'15-10-2026 00:00:00', N'01:00 PM', 12000.00, N'Credit / Debit Card', N'Paid', N'Cancelled', 1, NULL, NULL, N'08-10-2026 18:06:19', NULL, NULL, NULL, NULL, 12000.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (3, N'#CCC-721004', 1, 4, N'Hyundai Creta (GJ 03 AB 1234)', N'08-08-2026 00:00:00', N'11:00 AM', 14999.00, N'Online UPI', N'Paid', N'Completed', 5, NULL, NULL, N'08-10-2026 18:06:19', NULL, NULL, NULL, NULL, 14999.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (4, N'#CCC-618492', 1, 7, N'Hyundai Creta (GJ 03 AB 1234)', N'08-07-2026 00:00:00', N'02:30 PM', 6500.00, N'Cash on Delivery (COD)', N'Paid', N'Completed', 5, NULL, NULL, N'08-10-2026 18:06:19', 3, NULL, NULL, NULL, 6500.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (5, N'#CCC-843080', 1, 4, N'Hyundai Creta (GJ 03 AB 1234)', N'19-10-2026 00:00:00', N'04:00 PM', 69000.00, N'Online UPI', N'Paid', N'Cancelled', 1, NULL, NULL, N'08-10-2026 18:37:56', NULL, NULL, NULL, NULL, 69000.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (6, N'#CCC-109111', 1, 6, N'Hyundai Creta (GJ 03 AB 1234)', N'09-10-2026 00:00:00', N'10:30 AM', 599.00, N'Online UPI', N'Paid', N'Upcoming', 1, NULL, NULL, N'08-10-2026 19:59:30', NULL, NULL, NULL, NULL, 599.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (7, N'#CCC-441206', 1, 4, N'Hyundai Creta (GJ 03 AB 1234)', N'09-10-2026 00:00:00', N'10:30 AM', 45600.00, N'Online UPI', N'Paid', N'Upcoming', 1, NULL, NULL, N'08-10-2026 20:38:05', NULL, NULL, NULL, NULL, 45600.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (8, N'#CCC-132145', 1, 4, N'Hyundai Creta (GJ 03 AB 1234)', N'09-10-2026 00:00:00', N'10:30 AM', 36000.00, N'Online UPI', N'Paid', N'Upcoming', 1, NULL, NULL, N'08-10-2026 20:40:46', NULL, NULL, N'Diwali Special Offer (10% OFF)', 4000.00, 40000.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (9, N'#CCC-448379', 1, 4, N'Hyundai Creta (GJ 03 AB 1234)', N'09-10-2026 00:00:00', N'10:30 AM', 36000.00, N'Online UPI', N'Paid', N'Upcoming', 1, NULL, NULL, N'08-10-2026 20:40:59', NULL, NULL, N'Diwali Special Offer (10% OFF)', 4000.00, 40000.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (10, N'#CCC-243053', 1, 4, N'Hyundai Creta (GJ 03 AB 1234)', N'09-10-2026 00:00:00', N'10:30 AM', 36000.00, N'Cash on Delivery (COD)', N'Paid', N'Upcoming', 1, NULL, NULL, N'08-10-2026 20:58:31', NULL, NULL, N'Navratri Special Offer 2026', 9000.00, 45000.00);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (11, N'#CCC-100231', 26, 5, N'White Honda City Sedan', N'11-10-2026 00:00:00', N'09:30 PM', 5500.00, N'Online UPI', N'Paid', N'Pending', 1, N'Customer requested special attention on hood swirl marks.', NULL, N'10-10-2026 09:46:55', NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (12, N'#CCC-100229', 1, 4, N'White Hyundai Creta', N'11-10-2026 00:00:00', N'10:00 AM', 4249.00, N'Online UPI', N'Paid', N'In Progress', 4, N'Currently on final detailing process by Bhargav/staff.', NULL, N'09-10-2026 09:46:55', NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[Bookings] ([BookingId], [BookingCode], [UserId], [ServiceId], [VehicleDetails], [SlotDate], [SlotTime], [TotalAmount], [PaymentMethod], [PaymentStatus], [BookingStatus], [TrackingStep], [Notes], [CancellationReason], [CreatedAt], [Rating], [ReviewText], [OfferTitle], [DiscountAmount], [OriginalAmount]) VALUES (13, N'#CCC-100215', 27, 5, N'Blue Tata Harrier', N'08-10-2026 00:00:00', N'11:00 AM', 14000.00, N'Credit Card', N'Paid', N'Completed', 5, N'Full detailing and coating done successfully. Delivered to customer.', NULL, N'08-10-2026 09:46:55', NULL, NULL, NULL, NULL, NULL);
SET IDENTITY_INSERT [dbo].[Bookings] OFF;
GO
GO

-- =============================================
-- Performance Indexes: Speed up Analytics & Filtering
-- =============================================
IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = 'IX_Bookings_UserId')
    CREATE NONCLUSTERED INDEX [IX_Bookings_UserId] ON [dbo].[Bookings] ([UserId]);
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = 'IX_Bookings_SlotDate')
    CREATE NONCLUSTERED INDEX [IX_Bookings_SlotDate] ON [dbo].[Bookings] ([SlotDate]);
GO

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = 'IX_Services_Category')
    CREATE NONCLUSTERED INDEX [IX_Services_Category] ON [dbo].[Services] ([Category]);
GO


