-- Clinic Booking System Database Schema
-- This SQL script creates a database schema for a clinic booking system.

CREATE DATABASE IF NOT EXISTS clinic_booking_system;

USE clinic_booking_system;

-- 1. Clinic Table
CREATE TABLE Clinic (
    clinic_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    contact_number VARCHAR(20) UNIQUE
);

-- 2. Specialization Table
CREATE TABLE Specialization (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Doctor Table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES Specialization(specialization_id)
);

-- 4. Doctor_Clinic (Many-to-Many between Doctor and Clinic)
CREATE TABLE Doctor_Clinic (
    doctor_id INT,
    clinic_id INT,
    PRIMARY KEY (doctor_id, clinic_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (clinic_id) REFERENCES Clinic(clinic_id)
);

-- 5. Patient Table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- 6. Appointment Table
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    clinic_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (clinic_id) REFERENCES Clinic(clinic_id)
);

-- 7. Payment Table (One-to-One with Appointment)
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash', 'Card', 'Mobile Money', 'Insurance') NOT NULL,
    payment_date DATETIME NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- 8. Medical Record Table
CREATE TABLE Medical_Record (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    diagnosis TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- 9. Prescription Table (1:M from Medical Record)
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    duration VARCHAR(50),
    FOREIGN KEY (record_id) REFERENCES Medical_Record(record_id)
);



-- DATA INSERTION TO CLINIC TABLE
INSERT INTO Clinic (name, location, contact_number) VALUES
('Rift Valley Medical Centre', 'Nakuru CBD, Kenyatta Avenue', '0712345678'),
('Nakuru West Clinic', 'Kaptembwo, Nakuru', '0798765432'),
('Afya Bora Clinic', 'Lanet, Nakuru', '0700112233'),
('Medcare Hospital', 'Naka, Nakuru', '0721122334'),
('Nakuru East Health Centre', 'Flamingo, Nakuru', '0733445566'),
('Shalom Medical Centre', 'Free Area, Nakuru', '0700556677'),
('Prestige Health Clinic', 'Kiti, Nakuru', '0788123456'),
('New Hope Clinic', 'Kiamunyi, Nakuru', '0711002233'),
('Zion Medical Centre', 'London Estate, Nakuru', '0799887766'),
('Lakeview Hospital', 'Milimani, Nakuru', '0700889900'),
('Healing Touch Clinic', 'Kabarak Road, Nakuru', '0745123456'),
('Sunrise Medical', 'Menengai, Nakuru', '0799112233'),
('Green Cross Health', 'Kiti, Nakuru', '0700667788'),
('Mercy Care Clinic', 'Section 58, Nakuru', '0711778899'),
('Jubilee Health Centre', 'Pipeline, Nakuru', '0788776655'),
('Blessed Hands Clinic', 'Langa Langa, Nakuru', '0722889900'),
('Oasis Medical Centre', 'Ronda, Nakuru', '0744332211'),
('Family Care Clinic', 'Kiamunyeki, Nakuru', '0755110099'),
('St. Luke Clinic', 'Bahati, Nakuru', '0700554433'),
('Grace Health Clinic', 'Maili Saba, Nakuru', '0788001122'),
('Nakuru Central Hospital', 'CBD, Nakuru', '0799004455'),
('Medlink Health Centre', 'White House, Nakuru', '0700778899'),
('Hope Alive Clinic', 'Racecourse, Nakuru', '0711223344'),
('Trinity Health Centre', 'Githioro, Nakuru', '0733556677'),
('Covenant Hospital', 'Shabaab, Nakuru', '0722667788'),
('Zawadi Medical', 'Kivumbini, Nakuru', '0799556677'),
('Peacemakers Clinic', 'Menengai West, Nakuru', '0700123445'),
('Revive Health', 'Barut, Nakuru', '0744001122'),
('Nakuru Medicare', 'Lantern, Nakuru', '0788443322'),
('Wellness Point', 'Kagoto, Nakuru', '0733778899');

-- DATA INSERTION TO SPECIALIZATION TABLE
INSERT INTO Specialization (name) VALUES
('General Practitioner'),
('Pediatrics'),
('Gynecology'),
('Dermatology'),
('Cardiology'),
('Neurology'),
('Oncology'),
('Orthopedics'),
('ENT Specialist'),
('Ophthalmology'),
('Urology'),
('Endocrinology'),
('Psychiatry'),
('Dentistry'),
('Radiology'),
('Gastroenterology'),
('Nephrology'),
('Pulmonology'),
('Infectious Diseases'),
('Rheumatology'),
('Allergy & Immunology'),
('Plastic Surgery'),
('Geriatrics'),
('Anesthesiology'),
('Hematology'),
('Surgery'),
('Occupational Therapy'),
('Nutritionist'),
('Physiotherapy'),
('Public Health');

-- DATA INSERTION TO DOCTOR TABLE
INSERT INTO Doctor (first_name, last_name, email, phone, specialization_id) VALUES
('James', 'Mwangi', 'jmwangi@gmail.com', '0711000001', 1),
('Grace', 'Wanjiru', 'gwanjiru@gmail.com', '0711000002', 2),
('Peter', 'Omondi', 'pomondi@gmail.com', '0711000003', 3),
('Mary', 'Atieno', 'matieno@gmail.com', '0711000004', 4),
('David', 'Kariuki', 'dkariuki@gmail.com', '0711000005', 5),
('Naomi', 'Muthoni', 'nmuthoni@gmail.com', '0711000006', 6),
('Kevin', 'Otieno', 'kotieno@gmail.com', '0711000007', 7),
('Anne', 'Njeri', 'anjeri@gmail.com', '0711000008', 8),
('Daniel', 'Kiprono', 'dkiprono@gmail.com', '0711000009', 9),
('Susan', 'Wambui', 'swambui@gmail.com', '0711000010', 10),
('Michael', 'Odhiambo', 'modhiambo@gmail.com', '0711000011', 11),
('Agnes', 'Chebet', 'achebet@gmail.com', '0711000012', 12),
('Joseph', 'Mutua', 'jmutua@gmail.com', '0711000013', 13),
('Clara', 'Wangari', 'cwangari@gmail.com', '0711000014', 14),
('Brian', 'Njuguna', 'bnjuguna@gmail.com', '0711000015', 15),
('Diana', 'Cherono', 'dcherono@gmail.com', '0711000016', 16),
('Samuel', 'Kimani', 'skimani@gmail.com', '0711000017', 17),
('Lucy', 'Achieng', 'lachieng@gmail.com', '0711000018', 18),
('George', 'Mburu', 'gmburu@gmail.com', '0711000019', 19),
('Esther', 'Mutheu', 'emutheu@gmail.com', '0711000020', 20),
('Benjamin', 'Koech', 'bkoech@gmail.com', '0711000021', 21),
('Janet', 'Nyambura', 'jnyambura@gmail.com', '0711000022', 22),
('Tom', 'Wekesa', 'twekesa@gmail.com', '0711000023', 23),
('Linda', 'Cherop', 'lcherop@gmail.com', '0711000024', 24),
('Patrick', 'Ochieng', 'pochieng@gmail.com', '0711000025', 25),
('Joyce', 'Muli', 'jmuli@gmail.com', '0711000026', 26),
('Eric', 'Kiplangat', 'ekiplangat@gmail.com', '0711000027', 27),
('Catherine', 'Moraa', 'cmoraa@gmail.com', '0711000028', 28),
('Isaac', 'Odongo', 'iodongo@gmail.com', '0711000029', 29),
('Beatrice', 'Wekesa', 'bwekesa@gmail.com', '0711000030', 30);

-- DATA INSERTION TO DOCTOR_CLINIC TABLE
INSERT INTO Doctor_Clinic (doctor_id, clinic_id) VALUES
(1, 1), (1, 2),
(2, 2), (2, 3),
(3, 3), (3, 4),
(4, 4), (4, 5),
(5, 5), (5, 6),
(6, 6), (6, 7),
(7, 7), (7, 8),
(8, 8), (8, 9),
(9, 9), (9, 10),
(10, 10), (10, 11),
(11, 11), (11, 12),
(12, 12), (12, 13),
(13, 13), (13, 14),
(14, 14), (14, 15),
(15, 15), (15, 16),
(16, 16), (16, 17),
(17, 17), (17, 18),
(18, 18), (18, 19),
(19, 19), (19, 20),
(20, 20), (20, 21),
(21, 21), (21, 22),
(22, 22), (22, 23),
(23, 23), (23, 24),
(24, 24), (24, 25),
(25, 25), (25, 26),
(26, 26), (26, 27),
(27, 27), (27, 28),
(28, 28), (28, 29),
(29, 29), (29, 30),
(30, 30), (30, 1);

-- DATA INSERTION TO PATIENT TABLE
INSERT INTO Patient (first_name, last_name, email, phone, date_of_birth, gender) VALUES
('Brian', 'Maina', 'bmaina@gmail.com', '0722000001', '1990-01-10', 'Male'),
('Mercy', 'Chebet', 'mchebet@gmail.com', '0722000002', '1985-06-12', 'Female'),
('John', 'Odhiambo', 'jodhiambo@gmail.com', '0722000003', '1992-03-15', 'Male'),
('Diana', 'Wairimu', 'dwairimu@gmail.com', '0722000004', '2000-11-22', 'Female'),
('Kevin', 'Mutua', 'kmutua@gmail.com', '0722000005', '1993-04-01', 'Male'),
('Rose', 'Akinyi', 'rakinya@gmail.com', '0722000006', '1991-02-14', 'Female'),
('Samuel', 'Kiptoo', 'skiptoo@gmail.com', '0722000007', '1996-12-10', 'Male'),
('Faith', 'Muthoni', 'fmuthoni@gmail.com', '0722000008', '1997-05-19', 'Female'),
('Dennis', 'Ochieng', 'dochieng@gmail.com', '0722000009', '1989-09-09', 'Male'),
('Gladys', 'Njeri', 'gnjeri@gmail.com', '0722000010', '1986-10-28', 'Female'),
('Isaac', 'Korir', 'ikorir@gmail.com', '0722000011', '1990-07-08', 'Male'),
('Janet', 'Moraa', 'jmoraa@gmail.com', '0722000012', '1994-11-30', 'Female'),
('George', 'Otieno', 'gotieno@gmail.com', '0722000013', '1983-03-01', 'Male'),
('Lucy', 'Chepchumba', 'lchepchumba@gmail.com', '0722000014', '1998-08-21', 'Female'),
('Alex', 'Kimani', 'akimani@gmail.com', '0722000015', '1992-02-02', 'Male'),
('Emily', 'Wambui', 'ewambui@gmail.com', '0722000016', '1996-07-07', 'Female'),
('Collins', 'Odongo', 'codongo@gmail.com', '0722000017', '1991-01-11', 'Male'),
('Esther', 'Cherop', 'echerop@gmail.com', '0722000018', '1988-04-04', 'Female'),
('Moses', 'Kiplangat', 'mkiplangat@gmail.com', '0722000019', '1984-10-10', 'Male'),
('Agnes', 'Auma', 'aauma@gmail.com', '0722000020', '1995-12-05', 'Female'),
('Frank', 'Mwangi', 'fmwangi@gmail.com', '0722000021', '1990-01-23', 'Male'),
('Nancy', 'Nyambura', 'nnyambura@gmail.com', '0722000022', '1997-06-18', 'Female'),
('Eric', 'Wekesa', 'ewekesa@gmail.com', '0722000023', '1982-09-15', 'Male'),
('Christine', 'Atieno', 'catieno@gmail.com', '0722000024', '1986-12-12', 'Female'),
('Victor', 'Ndungu', 'vndungu@gmail.com', '0722000025', '1993-03-25', 'Male'),
('Susan', 'Kipkirui', 'skipkirui@gmail.com', '0722000026', '1998-11-11', 'Female'),
('Andrew', 'Mutisya', 'amutisya@gmail.com', '0722000027', '1989-06-06', 'Male'),
('Lilian', 'Akinyi', 'lakinyi@gmail.com', '0722000028', '1991-08-08', 'Female'),
('Jackson', 'Cheruiyot', 'jcheruiyot@gmail.com', '0722000029', '1994-09-09', 'Male'),
('Peninah', 'Koech', 'pkoech@gmail.com', '0722000030', '1987-05-05', 'Female');

-- DATA INSERTION TO APPOINTMENT TABLE
INSERT INTO Appointment (patient_id, doctor_id, clinic_id, appointment_date, reason, status) VALUES
(1, 1, 1, '2025-05-01 09:00:00', 'Checkup for recurring headaches', 'Completed'),
(2, 2, 2, '2025-05-02 10:30:00', 'Prenatal consultation', 'Completed'),
(3, 3, 3, '2025-05-03 11:00:00', 'Flu symptoms', 'Completed'),
(4, 4, 4, '2025-05-04 14:00:00', 'Back pain', 'Completed'),
(5, 5, 5, '2025-05-05 15:30:00', 'Annual physical exam', 'Completed'),
(6, 6, 6, '2025-05-06 09:00:00', 'Chest tightness', 'Completed'),
(7, 7, 7, '2025-05-07 10:00:00', 'Skin rash', 'Completed'),
(8, 8, 8, '2025-05-08 11:30:00', 'Routine follow-up', 'Completed'),
(9, 9, 9, '2025-05-09 12:00:00', 'Kidney checkup', 'Scheduled'),
(10, 10, 10, '2025-05-10 13:00:00', 'Fatigue and body pain', 'Scheduled'),
(11, 11, 11, '2025-05-11 09:15:00', 'Fever and sore throat', 'Completed'),
(12, 12, 12, '2025-05-12 10:00:00', 'Migraine evaluation', 'Completed'),
(13, 13, 13, '2025-05-13 11:00:00', 'Eye infection', 'Completed'),
(14, 14, 14, '2025-05-14 14:00:00', 'Abdominal discomfort', 'Completed'),
(15, 15, 15, '2025-05-15 15:30:00', 'Follow-up on diabetes', 'Completed'),
(16, 16, 16, '2025-05-16 09:00:00', 'Post-surgery review', 'Completed'),
(17, 17, 17, '2025-05-17 10:00:00', 'Cough and cold', 'Completed'),
(18, 18, 18, '2025-05-18 11:30:00', 'Allergy treatment', 'Completed'),
(19, 19, 19, '2025-05-19 12:00:00', 'Joint pain', 'Completed'),
(20, 20, 20, '2025-05-20 13:00:00', 'Nutrition advice', 'Completed'),
(21, 21, 21, '2025-05-21 09:00:00', 'High blood pressure', 'Completed'),
(22, 22, 22, '2025-05-22 10:30:00', 'Sleep disorder', 'Completed'),
(23, 23, 23, '2025-05-23 11:00:00', 'Hearing issue', 'Completed'),
(24, 24, 24, '2025-05-24 14:00:00', 'Pediatric check', 'Completed'),
(25, 25, 25, '2025-05-25 15:30:00', 'Dizziness and nausea', 'Completed'),
(26, 26, 26, '2025-05-26 09:00:00', 'Wound dressing', 'Completed'),
(27, 27, 27, '2025-05-27 10:00:00', 'TB screening', 'Completed'),
(28, 28, 28, '2025-05-28 11:30:00', 'Anemia check', 'Scheduled'),
(29, 29, 29, '2025-05-29 12:00:00', 'Dental pain', 'Scheduled'),
(30, 30, 30, '2025-05-30 13:00:00', 'Vaccination review', 'Scheduled');

-- DATA INSERTION TO PAYMENT TABLE
INSERT INTO Payment (appointment_id, amount, payment_method, payment_date) VALUES
(1, 1500.00, 'Mobile Money', '2025-05-01 09:15:00'),
(2, 3000.00, 'Insurance', '2025-05-02 11:00:00'),
(3, 1000.00, 'Cash', '2025-05-03 11:15:00'),
(4, 1200.00, 'Card', '2025-05-04 14:15:00'),
(5, 2000.00, 'Mobile Money', '2025-05-05 16:00:00'),
(6, 1800.00, 'Mobile Money', '2025-05-06 09:30:00'),
(7, 1700.00, 'Cash', '2025-05-07 10:30:00'),
(8, 2500.00, 'Card', '2025-05-08 12:00:00'),
(9, 1100.00, 'Cash', '2025-05-09 12:15:00'),
(10, 1600.00, 'Mobile Money', '2025-05-10 13:30:00'),
(11, 2100.00, 'Insurance', '2025-05-11 08:45:00'),
(12, 1400.00, 'Card', '2025-05-12 10:00:00'),
(13, 1900.00, 'Cash', '2025-05-13 09:30:00'),
(14, 2300.00, 'Mobile Money', '2025-05-14 11:00:00'),
(15, 1200.00, 'Card', '2025-05-15 14:45:00'),
(16, 2600.00, 'Insurance', '2025-05-16 10:15:00'),
(17, 1350.00, 'Cash', '2025-05-17 15:00:00'),
(18, 1750.00, 'Mobile Money', '2025-05-18 08:30:00'),
(19, 2200.00, 'Card', '2025-05-19 09:45:00'),
(20, 2000.00, 'Mobile Money', '2025-05-20 10:00:00'),
(21, 1450.00, 'Cash', '2025-05-21 11:30:00'),
(22, 2800.00, 'Insurance', '2025-05-22 13:00:00'),
(23, 1650.00, 'Card', '2025-05-23 14:15:00'),
(24, 1250.00, 'Mobile Money', '2025-05-24 15:30:00'),
(25, 1950.00, 'Cash', '2025-05-25 16:45:00'),
(26, 2300.00, 'Mobile Money', '2025-05-26 09:00:00'),
(27, 1700.00, 'Card', '2025-05-27 10:30:00'),
(28, 1850.00, 'Insurance', '2025-05-28 11:15:00'),
(29, 1600.00, 'Cash', '2025-05-29 12:00:00'),
(30, 1400.00, 'Insurance', '2025-05-30 13:30:00');

-- DATA INSERTION TO MEDICAL_RECORD TABLE
INSERT INTO Medical_Record (appointment_id, diagnosis, notes) VALUES
(1, 'Migraine', 'Recommended rest and hydration.'),
(2, 'Normal Pregnancy Progress', 'All vitals stable.'),
(3, 'Common Flu', 'Prescribed paracetamol and fluids.'),
(4, 'Lumbar Strain', 'Advised physiotherapy.'),
(5, 'General Checkup', 'All readings normal.'),
(6, 'Bronchitis', 'Advised on inhaler use.'),
(7, 'Allergic Dermatitis', 'Topical cream prescribed.'),
(8, 'Hypertension', 'Lifestyle changes suggested.'),
(9, 'UTI', 'Antibiotics prescribed.'),
(10, 'Vitamin Deficiency', 'Supplements recommended.'),
(11, 'Asthma', 'Inhaler dosage adjusted.'),
(12, 'Back Pain', 'Scheduled for MRI.'),
(13, 'Diabetes Type II', 'Diet plan given.'),
(14, 'Sinus Infection', 'Nasal spray and antibiotics.'),
(15, 'Sprained Ankle', 'Compression and rest advised.'),
(16, 'Pregnancy - 2nd Trimester', 'Routine scan completed.'),
(17, 'Malaria', 'Prescribed artemisinin combination therapy.'),
(18, 'Gastritis', 'Advised diet modification.'),
(19, 'Anxiety', 'Referred to counselor.'),
(20, 'Routine Child Wellness', 'Growth is on track.'),
(21, 'Ear Infection', 'Eardrops prescribed.'),
(22, 'Arthritis', 'Pain management discussed.'),
(23, 'Toothache', 'Referred to dental unit.'),
(24, 'Eye Strain', 'Advised screen time reduction.'),
(25, 'Minor Burn', 'Topical antibiotic applied.'),
(26, 'High Cholesterol', 'Statin prescribed.'),
(27, 'Menstrual Cramps', 'Pain relief medication given.'),
(28, 'Skin Rash', 'Hydrocortisone prescribed.'),
(29, 'HIV Follow-up', 'CD4 count stable.'),
(30, 'Immunization Review', 'All vaccines up-to-date.');

-- DATA INSERTION TO PRESCRIPTION TABLE
INSERT INTO Prescription (record_id, medication_name, dosage, duration) VALUES
(1, 'Paracetamol', '500mg', '3 days'),
(2, 'Folic Acid', '5mg', 'Daily until delivery'),
(3, 'Antihistamines', '10mg', '5 days'),
(4, 'Ibuprofen', '400mg', '5 days'),
(5, 'Multivitamin', '1 tablet', '30 days'),
(6, 'Salbutamol Inhaler', '2 puffs', 'As needed'),
(7, 'Hydrocortisone Cream', 'Apply twice daily', '1 week'),
(8, 'Amlodipine', '5mg', '30 days'),
(9, 'Nitrofurantoin', '100mg', '7 days'),
(10, 'Ferrous Sulphate', '200mg', '2 weeks'),
(11, 'Salbutamol', '2 puffs', 'As needed'),
(12, 'Naproxen', '250mg', '7 days'),
(13, 'Metformin', '500mg', 'Twice daily'),
(14, 'Amoxicillin', '500mg', '7 days'),
(15, 'Diclofenac', '50mg', '5 days'),
(16, 'Iron Supplements', '1 tablet', 'Daily until delivery'),
(17, 'Artemether-Lumefantrine', '1 dose', '3 days'),
(18, 'Omeprazole', '20mg', '14 days'),
(19, 'Fluoxetine', '20mg', 'Daily'),
(20, 'Vitamin A Syrup', '1 dose', 'Single administration'),
(21, 'Ciprofloxacin', '500mg', '7 days'),
(22, 'Celecoxib', '200mg', '30 days'),
(23, 'Ibuprofen', '400mg', '5 days'),
(24, 'Artificial Tears', '1 drop each eye', '3 times daily'),
(25, 'Silver Sulfadiazine Cream', 'Apply once daily', '1 week'),
(26, 'Atorvastatin', '10mg', '30 days'),
(27, 'Mefenamic Acid', '500mg', '3 days'),
(28, 'Calamine Lotion', 'Apply as needed', '5 days'),
(29, 'Cotrimoxazole', '960mg', 'Prophylaxis daily'),
(30, 'No medication needed', NULL, NULL);

-- END OF SQL SCRIPT