# API Reference & Parameter Specification Document
**Project:** Hello My Doctor (`flutter_hello_my_doctor`)  
**Base URL:** `https://hellomydoctor.in`  
**Date:** September 17, 2026  

---

## Executive Summary
This document provides a comprehensive list of all 22 API endpoints integrated into the `flutter_hello_my_doctor` application, including HTTP methods, endpoint paths, required/optional payload parameters, data types, and function references.

---

## API Summary Table

| # | Feature Module | Function Name | Endpoint Path | Method | Payload Type |
|---|---|---|---|---|---|
| 1 | Auth | `login` | `/wb/login` | POST | FormData |
| 2 | Auth | `signup` | `/wb/signup` | POST | FormData |
| 3 | Auth | `verifyOTP` | `/wb/signup_otp_verify` | POST | FormData |
| 4 | Auth | `resendOTP` | `/wb/signup_resend_otp` | POST | FormData |
| 5 | Auth | `sendForgotPasswordOTP` | `/wb/forgot_password` | POST | FormData |
| 6 | Auth | `verifyForgotPasswordOTP` | `/wb/otp_verification` | POST | FormData |
| 7 | Auth | `resetPassword` | `/wb/reset_password` | POST | FormData |
| 8 | Profile | `updateProfile` | `/wb/update_profile` | POST | Multipart FormData |
| 9 | Cities | `getCities` | `/wb/locations` | POST | None |
| 10 | Categories | `getDoctorCategories` | `/wb/categories` | POST | None |
| 11 | Home | `getHome` | `/wb/home` | POST | FormData |
| 12 | Doctors | `getDoctors` | `/wb/doctor_search` | POST | FormData |
| 13 | Doctor Details | `getDoctorDetails` | `/wb/doctor_details` | POST | FormData |
| 14 | Reviews | `submitReviewRating` | `/wb/doctor_rating` | POST | FormData |
| 15 | Availability | `checkDoctorAvailability` | `/wb/check_availability` | POST | FormData |
| 16 | Location Fees | `getLocationWiseFees` | `/wb/location_fee` | POST | FormData |
| 17 | BillDesk | `createBillDeskOrder` | `/wb/create_order` | POST | FormData |
| 18 | BillDesk Direct | `createOrder` | `https://api.billdesk.com/...` | POST | JSON |
| 19 | Paytm | `initiatePayment` | `/paytm/initiate_transaction` | POST | FormData |
| 20 | Booking | `bookAppointment` | `/wb/appointment_booking` | POST | FormData |
| 21 | Appointments | `getAppointments` | `/wb/get_appointments` | POST | FormData |
| 22 | Notifications | `getNotifications` | `/wb/get_notification` | POST | FormData |

---

## Detailed API Endpoints & Parameters

### 1. User Authentication APIs

#### 1.1 Login (`/wb/login`)
* **Method:** `POST`
* **Function:** `NetworkCalls.login(data)`
* **Request Payload (FormData):**
  - `mobile_no` (String, Required): User's 10-digit mobile number.
  - `password` (String, Required): User's account password.
  - `device_id` (String, Required): FCM Token for push notifications.

#### 1.2 User Signup (`/wb/signup`)
* **Method:** `POST`
* **Function:** `NetworkCalls.signup(data)`
* **Request Payload (FormData):**
  - `username` (String, Required): Full name of the user.
  - `mobile_no` (String, Required): 10-digit mobile number.
  - `password` (String, Required): Account password.
  - `confirm_password` (String, Required): Password confirmation matching password.
  - `device_id` (String, Required): FCM Registration Token.

#### 1.3 Signup OTP Verification (`/wb/signup_otp_verify`)
* **Method:** `POST`
* **Function:** `NetworkCalls.verifyOTP(data)`
* **Request Payload (FormData):**
  - `mobile_no` (String, Required): User's mobile number.
  - `otp` (String, Required): 4/6-digit OTP code received.

#### 1.4 Resend Signup OTP (`/wb/signup_resend_otp`)
* **Method:** `POST`
* **Function:** `NetworkCalls.resendOTP(data)`
* **Request Payload (FormData):**
  - `mobile_no` (String, Required): Mobile number to resend OTP.

#### 1.5 Forgot Password - Send OTP (`/wb/forgot_password`)
* **Method:** `POST`
* **Function:** `NetworkCalls.sendForgotPasswordOTP(data)`
* **Request Payload (FormData):**
  - `mobile_no` (String, Required): Registered mobile number.

#### 1.6 Forgot Password - Verify OTP (`/wb/otp_verification`)
* **Method:** `POST`
* **Function:** `NetworkCalls.verifyForgotPasswordOTP(data)`
* **Request Payload (FormData):**
  - `mobile_no` (String, Required): Mobile number.
  - `otp` (String, Required): OTP entered by user.

#### 1.7 Reset Password (`/wb/reset_password`)
* **Method:** `POST`
* **Function:** `NetworkCalls.resetPassword(data)`
* **Request Payload (FormData):**
  - `mobile_no` (String, Required): Mobile number.
  - `new_password` (String, Required): New password string.
  - `confirm_password` (String, Required): Confirmation password string.

---

### 2. User Profile API

#### 2.1 Update Profile (`/wb/update_profile`)
* **Method:** `POST` (Multipart)
* **Function:** `NetworkCalls.updateProfile(data)`
* **Request Payload (Multipart FormData):**
  - `user_id` (String, Required): Authenticated user ID.
  - `name` (String, Required): User's full name.
  - `contact` (String, Required): Contact number.
  - `dob` (String, Required): Date of birth (`yyyy-MM-dd`).
  - `location` (String, Required): Address/City.
  - `user_img` (File/Multipart, Optional): Profile image avatar file.

---

### 3. Master Data & Home Feed APIs

#### 3.1 Fetch Locations / Cities (`/wb/locations`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getCities()`
* **Request Payload:** None (Returns list of available cities with ID, name, image).

#### 3.2 Fetch Doctor Categories (`/wb/categories`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getDoctorCategories()`
* **Request Payload:** None (Returns doctor specialties and category IDs).

#### 3.3 Fetch Home Feed (`/wb/home`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getHome(data)`
* **Request Payload (FormData):**
  - `location_id` (String, Required): ID of the selected city/location.

---

### 4. Doctor Listing, Details & Reviews APIs

#### 4.1 Search Doctors (`/wb/doctor_search`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getDoctors(data)`
* **Request Payload (FormData):**
  - `location_id` (String, Required): Selected city ID.
  - `category_id` (String, Optional): Filter by specialty category ID.
  - `search_key` (String, Optional): Query text for searching doctor name.

#### 4.2 Fetch Doctor Details (`/wb/doctor_details`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getDoctorDetails(data)`
* **Request Payload (FormData):**
  - `doctor_id` (String, Required): Target doctor ID.
  - `user_id` (String, Required): Current user ID.

#### 4.3 Submit Doctor Rating & Review (`/wb/doctor_rating`)
* **Method:** `POST`
* **Function:** `NetworkCalls.submitReviewRating(data)`
* **Request Payload (FormData):**
  - `user_id` (String, Required): Current user ID.
  - `doctor_id` (String, Required): Target doctor ID.
  - `rating` (Double/Num, Required): Star rating value (1 to 5).
  - `description` (String, Required): Review text feedback.

---

### 5. Appointment Booking & Payment APIs

#### 5.1 Check Doctor Availability (`/wb/check_availability`)
* **Method:** `POST`
* **Function:** `NetworkCalls.checkDoctorAvailability(data)`
* **Request Payload (FormData):**
  - `doctor_id` (String, Required): Doctor ID.
  - `booking_date` (String, Required): Date formatted as `yyyy-MM-dd`.

#### 5.2 Fetch Location-wise Fees (`/wb/location_fee`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getLocationWiseFees(data)`
* **Request Payload (FormData):**
  - `location_id` (String, Required): Selected city ID.

#### 5.3 Create BillDesk Order (`/wb/create_order`)
* **Method:** `POST`
* **Function:** `NetworkCalls.createBillDeskOrder(data)`
* **Request Payload (FormData):**
  - `user_id` (String, Required): Current user ID.
  - `amount` (Double/Num, Required): Payable transaction fee.

#### 5.4 BillDesk Order Creation Direct (`https://api.billdesk.com/payments/ve1_2/orders/create`)
* **Method:** `POST` (JSON)
* **Function:** `NetworkCalls.createOrder(jsonEncodedData, headers)`
* **Request Payload (JSON Body):**
  - `mercid`, `orderid`, `amount`, `currency`, `itemcode`, `device` object, headers.

#### 5.5 Finalize Appointment Booking (`/wb/appointment_booking`)
* **Method:** `POST`
* **Function:** `NetworkCalls.bookAppointment(data)`
* **Request Payload (FormData):**
  - `user_id` (String, Required): User ID.
  - `location_id` (String, Required): Selected city ID.
  - `category_id` (String, Required): Doctor specialty category ID.
  - `doctor_id` (String, Required): Doctor ID.
  - `patient_name` (String, Required): Patient name.
  - `age` (String, Required): Patient age.
  - `age_type` (String, Required): Age unit (`years` / `months` / `days`).
  - `father_name` (String, Required): Father/Husband name.
  - `husband_name` (String, Required): Husband/Father name.
  - `mobile_number` (String, Required): Patient contact number.
  - `address` (String, Required): Residential address.
  - `date` (String, Required): Booking date (`yyyy-MM-dd`).
  - `fees` (Double/Num, Required): Total paid amount.
  - `orderid` (String, Required): BillDesk Transaction Order ID.
  - `hf_type` (String, Optional): Name type flag (for specialty category 19).

---

### 6. User Appointments & Push Notifications APIs

#### 6.1 Get User Appointments (`/wb/get_appointments`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getAppointments(data)`
* **Request Payload (FormData):**
  - `user_id` (String, Required): Authenticated user ID.

#### 6.2 Get Notifications (`/wb/get_notification`)
* **Method:** `POST`
* **Function:** `NetworkCalls.getNotifications(data)`
* **Request Payload (FormData):**
  - `user_id` (String, Required): Authenticated user ID.
