🏥 Clinic Booking System 
A complete relational database system designed for managing patient appointments, doctor schedules, medical records, and clinic operations using MySQL.

📌 Project Overview
This Clinic Booking System allows clinics to manage:

Doctor specializations & clinic locations

Patient registrations

Doctor-clinic relationships

Appointment scheduling

Medical records & prescriptions

Payment tracking

This project uses MySQL only — no external application logic. It’s intended for database design, querying practice, and foundational backend development.

🛠️ Features
Normalized relational structure

1-1, 1-M, and M-M relationships with proper constraints

Referential integrity via foreign keys

ENUMs for status and gender

Scalable table design for multiple clinics and doctors

🚀 Setup Instructions
Clone or download the project repository.

Open your preferred MySQL client (MySQL Workbench, phpMyAdmin, VS Code with SQL extension, etc.).

Import the database:

Option 1: Run schema.sql directly.

Option 2: Copy & paste the SQL into your editor and execute.

Optional: Add sample data or test queries to explore the system.

SQL File Included:

schema.sql → contains all CREATE TABLE statements.


clinic-booking-system/
├── clinic-booking-system.sql            # MySQL CREATE TABLE statements
├── README.md                            # Project description and setup
└── erd.png                    # Screenshot of the ERD
