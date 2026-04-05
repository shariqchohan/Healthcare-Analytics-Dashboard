

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

