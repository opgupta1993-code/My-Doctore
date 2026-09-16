# A to Z Application Process Flow & System Architecture
**Project:** Hello My Doctor (`flutter_hello_my_doctor`)  
**Document Type:** Process Flow Diagram & Navigation Architecture  

---

## 0. App Main Services, Purpose & Business Value

### 🩺 1. Doctor Appointments
- Search doctors by city/location and medical specialty (Cardiologist, Dentist, General Physician, Skin Specialist, etc.).
- Check real-time doctor availability, consultation fees, and book online time slots.

### 🧪 2. Pathology & Lab Tests (Home Sample Collection)
- Book lab diagnostic tests from accredited pathology labs across India.
- Enjoy home sample collection by certified lab technicians.

### 💊 3. Prescription & Medicine Home Delivery
- Doorstep delivery of prescribed medicines ordered directly through the app.

### 💳 4. Instant Online Payment & Confirmation
- Secure instant consultation fee payments via BillDesk / Paytm payment gateways.
- Receive automated digital appointment confirmation tickets and receipts.

### 🔔 5. Smart Notifications & Reminders
- Get real-time updates and reminders for upcoming appointments and lab test reports via Firebase Push Notifications.

---

### 🎯 Business Value (For Clients & End Users)
- **For Patients**: Convenient access to book doctors and diagnostic tests from home without waiting in long hospital queues.
- **For Doctors & Hospitals**: Effortlessly manage daily appointment schedules and expand patient reach.

---

## 1. High-Level A to Z System Flowchart

```mermaid
flowchart TD
    classDef startEnd fill:#1e3a8a,color:#ffffff,stroke:#1d4ed8,stroke-width:2px;
    classDef process fill:#0284c7,color:#ffffff,stroke:#0369a1,stroke-width:1.5px;
    classDef decision fill:#d97706,color:#ffffff,stroke:#b45309,stroke-width:1.5px;
    classDef screen fill:#059669,color:#ffffff,stroke:#047857,stroke-width:1.5px;

    Start(["🚀 App Launch (main.dart)"]):::startEnd --> InitDI["Dependency Injection & SharedPreferences"]:::process
    InitDI --> InitFirebase["Initialize Firebase & FCM Listener"]:::process
    InitFirebase --> CheckLogin{"Is User Logged In?"}:::decision

    %% Unauthenticated Flow
    CheckLogin -- "No" --> Splash["SplashScreen"]:::screen
    Splash --> IntroPage["IntroPageViewScreen (Onboarding)"]:::screen
    IntroPage --> Intro1["1. Doctor Appointments"]:::process
    Intro1 --> Intro2["2. Medicine Delivery"]:::process
    Intro2 --> Intro3["3. Pathology Services"]:::process
    Intro3 --> OnboardingAction{"Get Started / Skip Clicked"}:::decision
    
    OnboardingAction --> LoginWithoutLogin["LoginWithoutLoginScreen"]:::screen
    LoginWithoutLogin --> AuthChoice{"Auth Choice"}:::decision
    AuthChoice -- "Continue With Login" --> LoginScreen["LoginScreen / SignupScreen"]:::screen
    AuthChoice -- "Continue Without Login" --> SelectCity["SelectCityScreen"]:::screen
    
    LoginScreen --> OTPVerify["OTP Verification / Auth Success"]:::process
    OTPVerify --> SelectCity

    %% Authenticated Flow
    CheckLogin -- "Yes" --> CheckCity{"Is City Selected?"}:::decision
    CheckCity -- "No" --> SelectCity
    CheckCity -- "Yes" --> MainDrawer["DrawerScreen (Main Dashboard)"]:::screen

    %% City Selection Flow
    SelectCity --> FetchCities["API: NetworkCalls.getCities()"]:::process
    FetchCities --> SelectCityAction["User Selects City"]:::process
    SelectCityAction --> SaveCity["Save City in SharedPreferences"]:::process
    SaveCity --> MainDrawer

    %% Main Dashboard Features
    MainDrawer --> HomeTab["Home Feed (/wb/home)"]:::screen
    MainDrawer --> CategoryTab["Doctor Categories (/wb/categories)"]:::screen
    MainDrawer --> SearchTab["Doctor Search (/wb/doctor_search)"]:::screen
    MainDrawer --> ProfileTab["Profile Screen (/wb/update_profile)"]:::screen
    MainDrawer --> ApptTab["My Appointments (/wb/get_appointments)"]:::screen

    %% Doctor Booking Flow
    CategoryTab --> SelectDoctor["SelectDoctorScreen"]:::screen
    SearchTab --> SelectDoctor
    SelectDoctor --> DoctorDetails["DoctorDetailsScreen (/wb/doctor_details)"]:::screen
    DoctorDetails --> CheckAvail["Check Doctor Availability"]:::process
    CheckAvail --> MakeAppt["MakeAppointmentScreen"]:::screen
    MakeAppt --> InitPayment["Initiate Payment Order (/wb/create_order)"]:::process
    InitPayment --> PaymentGateway["BillDesk Payment Gateway"]:::process
    PaymentGateway --> ApptConfirm["Confirm Appointment (/wb/appointment_booking)"]:::process
    ApptConfirm --> SuccessNotice["FCM Push Notification Sent"]:::process
    SuccessNotice --> Finish(["Done / View Appointment"]):::startEnd
```

---

## 2. Detailed Phase Breakdown

### Phase 1: Application Launch & Initialization
1. **Entry Point (`lib/main.dart`)**:
   - `WidgetsFlutterBinding.ensureInitialized()` is invoked.
   - System UI overlay is configured for edge-to-edge portrait mode.
2. **Dependency Injection**:
   - Initializes `UserController`, `SelectCityController`, and `SharedPreferences`.
   - Reads stored `login`, `intro`, `userData`, and `selectedCity` states.
3. **Firebase & Push Notifications**:
   - Initializes Firebase App instance.
   - Registers FCM background and foreground listeners (`FirebaseNotifications.setupFCMListener()`).
   - Requests notification permissions.

---

### Phase 2: Onboarding & Authentication Flow
```mermaid
sequenceDiagram
    autonumber
    actor User
    participant App as App Navigation
    participant Intro as IntroPageViewScreen
    participant Auth as Login / Signup
    participant Storage as SharedPreferences

    User->>App: Launch Application
    alt First Time User
        App->>Intro: Display Onboarding Screens (1 -> 2 -> 3)
        User->>Intro: Tap "Get Started" / "Skip"
        Intro->>App: Navigate to LoginWithoutLoginScreen
        alt User Chooses Login
            User->>Auth: Enter Phone & Credentials
            Auth->>Auth: Verify OTP & Authenticate
            Auth->>Storage: Save User Token & Profile
        else User Chooses Guest Mode
            App->>App: Proceed Without Auth
        end
    end
```

---

### Phase 3: City Selection & Home Dashboard
1. **City Selection (`SelectCityScreen`)**:
   - Executes `NetworkCalls.getCities()` (`/wb/locations` API endpoint).
   - Displays cities in a search-enabled grid view.
   - Upon selection, stores `selectedCity` data in `SharedPreferences`.
2. **Main Dashboard (`DrawerScreen`)**:
   - Fetches home banners, quick categories, and recommended doctors (`/wb/home`).
   - Manages side drawer navigation (Profile, Appointments, Notifications, Help & Support).

---

### Phase 4: Doctor Appointment & Payment Lifecycle
```mermaid
sequenceDiagram
    autonumber
    actor Patient
    participant App as Flutter App
    participant Server as Hello My Doctor API
    participant BillDesk as BillDesk Payment Gateway

    Patient->>App: Select Category & Doctor
    App->>Server: Request Doctor Details (/wb/doctor_details)
    Server-->>App: Return Bio, Fees, & Schedule
    Patient->>App: Pick Date & Time Slot
    App->>Server: Check Availability (/wb/check_availability)
    Patient->>App: Tap "Confirm & Pay"
    App->>Server: Create Order (/wb/create_order)
    Server-->>App: Return Order & Transaction Details
    App->>BillDesk: Launch Payment Interface
    BillDesk-->>App: Return Payment Result (Success/Failure)
    App->>Server: Book Appointment (/wb/appointment_booking)
    Server-->>App: Return Appointment Ticket & Receipt
    App-->>Patient: Display Confirmation & Send Push Notification
```
