-- ============================================
-- Project: Clinical Operations Intelligence System
-- Tech: MySQL + Power BI
-- ============================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS HealthcareAnalyticsDB;
USE HealthcareAnalyticsDB;

-- ============================================
-- 2. TABLE CREATION
-- ============================================

CREATE TABLE Patient_Records (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    diagnosis VARCHAR(100),
    admission_date DATE,
    discharge_date DATE
);

CREATE TABLE Doctor_Directory (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE Appointment_Transactions (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient_Records(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor_Directory(doctor_id)
);

CREATE TABLE Billing_Transactions (
    billing_id INT PRIMARY KEY,
    patient_id INT,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient_Records(patient_id)
);

-- ============================================
-- 3. INSERT DATA
-- ============================================

INSERT INTO Patient_Records VALUES
(101, 'Ali Khan', 28, 'Male', 'Flu', '2025-01-01', '2025-01-03'),
(102, 'Ahmed Raza', 45, 'Male', 'Diabetes', '2025-01-02', '2025-01-07'),
(103, 'Sara Malik', 32, 'Female', 'Hypertension', '2025-01-04', '2025-01-08'),
(104, 'Usman Tariq', 55, 'Male', 'Heart Disease', '2025-01-03', '2025-01-10'),
(105, 'Ayesha Noor', 26, 'Female', 'Fever', '2025-01-06', '2025-01-08'),
(106, 'Bilal Hussain', 38, 'Male', 'Diabetes', '2025-01-07', '2025-01-12'),
(107, 'Hina Shah', 29, 'Female', 'Flu', '2025-01-08', '2025-01-10'),
(108, 'Zain Ali', 41, 'Male', 'Hypertension', '2025-01-09', '2025-01-13');

INSERT INTO Doctor_Directory VALUES
(201, 'Dr. Hassan', 'Cardiologist', 'Cardiology'),
(202, 'Dr. Fatima', 'General Physician', 'General Medicine'),
(203, 'Dr. Imran', 'Endocrinologist', 'Diabetes'),
(204, 'Dr. Ayesha', 'Neurologist', 'Neurology');

INSERT INTO Appointment_Transactions VALUES
(301, 101, 202, '2025-01-01', 'Completed'),
(302, 102, 203, '2025-01-02', 'Completed'),
(303, 103, 202, '2025-01-04', 'Cancelled'),
(304, 104, 201, '2025-01-03', 'Completed'),
(305, 105, 202, '2025-01-06', 'Completed'),
(306, 106, 203, '2025-01-07', 'Completed'),
(307, 107, 202, '2025-01-08', 'Cancelled'),
(308, 108, 201, '2025-01-09', 'Completed');

INSERT INTO Billing_Transactions VALUES
(401, 101, 4000, 'Paid'),
(402, 102, 15000, 'Paid'),
(403, 103, 7000, 'Unpaid'),
(404, 104, 25000, 'Paid'),
(405, 105, 3000, 'Paid'),
(406, 106, 12000, 'Pending'),
(407, 107, 4500, 'Paid'),
(408, 108, 10000, 'Paid');

-- ============================================
-- 4. ANALYSIS QUERIES (FOR REPORTING)
-- ============================================

-- KPI SUMMARY
SELECT 
    COUNT(DISTINCT p.patient_id) AS total_patients,
    SUM(b.total_amount) AS total_revenue,
    COUNT(a.appointment_id) AS total_appointments
FROM Patient_Records p
LEFT JOIN Billing_Transactions b ON p.patient_id = b.patient_id
LEFT JOIN Appointment_Transactions a ON p.patient_id = a.patient_id;

-- AVG LENGTH OF STAY (MySQL format)
SELECT 
    AVG(DATEDIFF(discharge_date, admission_date)) AS avg_length_of_stay
FROM Patient_Records;

-- DOCTOR PERFORMANCE
SELECT 
    d.doctor_name,
    d.department,
    COUNT(a.appointment_id) AS patients_handled
FROM Appointment_Transactions a
JOIN Doctor_Directory d ON a.doctor_id = d.doctor_id
WHERE a.appointment_status = 'Completed'
GROUP BY d.doctor_name, d.department
ORDER BY patients_handled DESC;

-- REVENUE BY DEPARTMENT
SELECT 
    d.department,
    SUM(b.total_amount) AS total_revenue
FROM Billing_Transactions b
JOIN Appointment_Transactions a ON b.patient_id = a.patient_id
JOIN Doctor_Directory d ON a.doctor_id = d.doctor_id
GROUP BY d.department
ORDER BY total_revenue DESC;

-- DISEASE ANALYSIS
SELECT 
    diagnosis,
    COUNT(*) AS total_cases
FROM Patient_Records
GROUP BY diagnosis
ORDER BY total_cases DESC;

-- MONTHLY TREND
SELECT 
    MONTH(admission_date) AS month,
    COUNT(*) AS total_patients
FROM Patient_Records
GROUP BY MONTH(admission_date)
ORDER BY month;

-- APPOINTMENT STATUS
SELECT 
    appointment_status,
    COUNT(*) AS total
FROM Appointment_Transactions
GROUP BY appointment_status;

-- PAYMENT STATUS
SELECT 
    payment_status,
    COUNT(*) AS total,
    SUM(total_amount) AS amount
FROM Billing_Transactions
GROUP BY payment_status;

-- HIGH VALUE PATIENTS
SELECT 
    patient_id,
    total_amount,
    CASE 
        WHEN total_amount >= 15000 THEN 'High Value'
        WHEN total_amount >= 7000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS patient_category
FROM Billing_Transactions;

-- ============================================
-- END OF FILE
-- ============================================