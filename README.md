# Creation Car Care - Automobile Detailing Studio Portal

An enterprise-grade web application built with **ASP.NET WebForms**, **C#**, **ADO.NET**, and **Microsoft SQL Server** for managing car detailing studio operations, online slot reservations, service tracking, and financial analytics.

---

## 👥 Project Team & Contributors

* **Dev Limbasiya** - *Project Lead & Full Stack Developer* ([@devlimbasiya048-cmd](https://github.com/devlimbasiya048-cmd))
  * Architecture Design, Customer Master Layout, Booking & Payment Gateway, Fixed Responsive Header.
* **Ravi Sharma** - *Backend & Database Developer* ([@ravisharma05](https://github.com/ravisharma05))
  * User Authentication & Security, Studio Admin Portal, Reports & Tax CSV Export Engine, Live Order Tracking.
* **K. Goraniya** - *Systems Architect & OOP Specialist* ([@kgoraniya841-alt](https://github.com/kgoraniya841-alt))
  * OOP Class Hierarchy (Inheritance, Polymorphism & Abstraction), Collection Processing (`List<T>`, `Dictionary`), Global Application State & Persistent Cookies.

---

## 🏛️ Object-Oriented Architecture (OOP) & Collections

This project strictly adheres to Object-Oriented Design principles and collection-based data structures:
* **Abstraction:** Defined through abstract base classes (`BaseEntity`, `BaseServicePackage`, `UserBase`) and operational contract interfaces (`IStudioOperations`).
* **Inheritance:** Derived specializations such as `CustomerUser` and `AdminUser` extending `UserBase`, plus `DetailingService` and `PPFProtectionService` extending `BaseServicePackage`.
* **Polymorphism (Method Overriding):** Dynamic runtime execution of `CalculateDiscountedPrice(decimal discount)` and `GetRoleDescription()` tailored per package type.
* **Encapsulation:** Strongly typed properties with private backing fields, data protection, and validation guards.
* **Collections Implementation:** High-performance in-memory processing via generic collections (`List<BaseServicePackage>`, `Dictionary<string, decimal>`) and LINQ querying (`.Where()`, `.OrderByDescending()`).

---

## 💾 State Management Matrix

| State Mechanism | Scope | Implementation Example |
| :--- | :--- | :--- |
| **Application State** | Global (All Users) | `Global.asax`: `Application["StudioStatus"]`, `Application["TotalVisitorsCount"]`, `Application["ActiveUsersOnline"]` |
| **Session State** | User Specific | User Auth (`Session["UserId"]`, `Session["UserEmail"]`, `Session["IsAdmin"]`), Cart Amount, Active Promo |
| **Cookies** | Persistent Client-Side | `HttpCookie("CCC_RememberUser")`, `HttpCookie("CCC_AdminUser")` with 30-day expiration |
| **ViewState** | Page Specific | Automatic control state and GridView persistence across postbacks |
| **HiddenField** | Form Specific | Slot reservation details (`hfSelectedDate`, `hfSelectedTime`, `hfPaymentMethod`) |
| **QueryString** | URL Parameters | Navigation parameters (`?id=`, `?status=`, `?code=`) |

## 🚀 Key Modules & Features

### 1. Customer Portal
* **Dynamic Services Catalog:** Filter ceramic coating, PPF, steam spa, and paint correction services by category.
* **Slot & Shift Booking:** Select available morning, afternoon, and evening slots with vehicle selection.
* **Live Car Tracking:** Track vehicle detailing progress in real-time through 5 studio stages.
* **Customer Profile & Vehicle Management:** Manage registered vehicles, primary car preferences, and review booking history.
* **Offers & Promo Engine:** Apply festival discounts and promotional codes at checkout.

### 2. Studio Admin Portal
* **Analytics Dashboard:** Live revenue metric cards, top-performing services breakdown, and monthly revenue bar charts.
* **Booking Management:** Filter orders by status (Pending, In Progress, Completed, Cancelled), reassign slots, and cancel bookings.
* **Export Tax Report (CSV):** Native ASP.NET CSV streaming for financial records and tax audit compliance.
* **Service & Category CRUD:** Add and update services with image upload validation, pricing, and warranty text.
* **User & Staff Management:** Monitor registered customers, block/suspend abusive accounts, and audit admin activities.

---

## 🛠️ Technology Stack

| Layer | Technologies Used |
| :--- | :--- |
| **Presentation Layer** | ASP.NET WebForms, HTML5, CSS3, JavaScript, Bootstrap Glyphs |
| **Business Logic Layer** | C# (.NET Framework 4.8), Master Pages, Session State Management |
| **Data Access Layer** | ADO.NET (`SqlConnection`, `SqlCommand`, `SqlDataAdapter`, `SqlDataReader`) |
| **Database** | Microsoft SQL Server (LocalDB / Express) |
| **Export Engine** | Native ASP.NET `HttpResponse` with `System.Text.StringBuilder` (Zero third-party dependencies) |

---

## 🗄️ Database Setup Instructions

1. Open **SQL Server Management Studio (SSMS)** or Visual Studio SQL Server Object Explorer.
2. Connect to `(localdb)\MSSQLLocalDB` or your local SQL Server instance.
3. Open and execute the script:
   ```sql
   Database_Setup.sql
   ```
4. Verify that the connection string in `Web.config` matches your instance:
   ```xml
   <connectionStrings>
     <add name="CreationCarCareDB" connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CreationCarCareDB;Integrated Security=True" providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```

---

## 🔐 Security Features

* **Multi-Layer Validation:** Combined ASP.NET Validation Controls (`RequiredFieldValidator`, `CompareValidator`, `RegularExpressionValidator`), HTML5 constraints, and server-side C# validation.
* **SQL Injection Prevention:** 100% parameterized queries across all database operations.
* **Role-Based Authorization:** Dedicated `Admin.Master` session validation redirecting unauthorized visitors.
* **Account Status Guard:** Automatic detection and suspension of blocked user accounts during login.

---

## 📄 License
This project is developed for academic evaluation and studio management purposes. All rights reserved.