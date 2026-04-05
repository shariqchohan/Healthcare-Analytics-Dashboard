
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

