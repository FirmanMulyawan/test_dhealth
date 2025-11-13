## Mini HRIS Attendance App (Flutter)

A simple Human Resource Information System (HRIS) Attendance application built using Flutter 3.27.4.
This project demonstrates basic features like login (dummy), real-time clock, attendance check-in/out, location tracking, and local data storage.

🚀 Features
1. Login Page (Dummy)
- Simple login form with username email = "firmanmulyawan@gmail.com", password = "password".

No real authentication — username is stored temporarily using GetX state management.

After login, user is redirected to the dashboard.

2. Dashboard Page

Displays:

Username (from login)

Real-time date & clock (updated every second)

Includes two main buttons:

Absen Masuk

Absen Pulang

3. Attendance Recording

When the user presses a button:

App retrieves current location (latitude & longitude) using Geolocator.

Stores the attendance data locally using SharedPreferences.

Displays the attendance history in a list below (sorted from latest to oldest).

Each attendance record includes:

Type (Absen Masuk or Absen Pulang)

Time

Date

Latitude & Longitude