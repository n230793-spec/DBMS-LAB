USE gram_panchayat_db;

SHOW TABLES;


-- =========================================================
-- PART B – SQL JOIN OPERATIONS
-- =========================================================

-- TASK-1
-- Display the names of citizens along with the certificate
-- types they have applied for.

SELECT
    c.citizen_name,
    ct.certificate_name
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id;


-- TASK-2
-- Display the names of citizens along with the Panchayat
-- Office where their applications were submitted.

SELECT
    c.citizen_name,
    po.office_name
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Panchayat_Office po
    ON ca.office_id = po.office_id;


-- TASK-3
-- Display the Application ID, Citizen Name and Application
-- Status for every certificate application.

SELECT
    ca.application_id,
    c.citizen_name,
    ca.application_status
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id;


-- TASK-4
-- Display the Citizen Name, Certificate Type and Application
-- Date for every certificate application.

SELECT
    c.citizen_name,
    ct.certificate_name,
    ca.application_date
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id;


-- TASK-5
-- Display the complete details of every certificate
-- application including Citizen Name, Certificate Type,
-- Panchayat Office and Application Status.

SELECT
    c.citizen_name,
    ct.certificate_name,
    po.office_name,
    ca.application_status
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id
INNER JOIN Panchayat_Office po
    ON ca.office_id = po.office_id;


-- TASK-6
-- Display all citizens who have applied for an Income
-- Certificate along with the Panchayat Office name.

SELECT
    c.citizen_name,
    po.office_name
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id
INNER JOIN Panchayat_Office po
    ON ca.office_id = po.office_id
WHERE ct.certificate_name = 'Income Certificate';


-- TASK-7
-- Display all certificate applications submitted to
-- Nuzvid Panchayat Office together with citizen details.

SELECT
    ca.application_id,
    c.citizen_id,
    c.citizen_name,
    c.village,
    ca.application_status
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Panchayat_Office po
    ON ca.office_id = po.office_id
WHERE po.office_name = 'Nuzvid';


-- TASK-8
-- Display every certificate application together with
-- the certificate description and application status.

SELECT
    ca.application_id,
    ct.certificate_description,
    ca.application_status
FROM Certificate_Application ca
INNER JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id;


-- TASK-9
-- Display the Citizen Name, Village, Certificate Type,
-- Panchayat Office and Application Date for every application.

SELECT
    c.citizen_name,
    c.village,
    ct.certificate_name,
    po.office_name,
    ca.application_date
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id
INNER JOIN Panchayat_Office po
    ON ca.office_id = po.office_id;


-- TASK-10
-- Complete Gram Panchayat Certificate Application Report
-- containing Citizen details, Certificate details,
-- Panchayat Office details and Application information.

SELECT
    c.citizen_id,
    c.citizen_name,
    c.village,
    c.phone,
    ct.certificate_id,
    ct.certificate_name,
    ct.certificate_description,
    po.office_id,
    po.office_name,
    ca.application_id,
    ca.application_date,
    ca.application_status
FROM Citizen c
INNER JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id
INNER JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id
INNER JOIN Panchayat_Office po
    ON ca.office_id = po.office_id;


-- =========================================================
-- LEVEL 3 – ADVANCED JOIN OPERATIONS
-- =========================================================

-- TASK-11
-- Display all citizens including those who have not
-- submitted any certificate applications.

SELECT
    c.citizen_id,
    c.citizen_name,
    ca.application_id,
    ca.application_status
FROM Citizen c
LEFT JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id;


-- TASK-12
-- Display all certificate types including those that have
-- never been requested by any citizen.

SELECT
    ct.certificate_id,
    ct.certificate_name,
    ca.application_id,
    ca.citizen_id
FROM Certificate_Application ca
RIGHT JOIN Certificate_Type ct
    ON ca.certificate_id = ct.certificate_id;


-- TASK-13
-- Display all citizens and all certificate applications,
-- including unmatched records from both tables.
-- FULL OUTER JOIN simulation in MySQL.

SELECT
    c.citizen_id,
    c.citizen_name,
    ca.application_id,
    ca.application_status
FROM Citizen c
LEFT JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id

UNION

SELECT
    c.citizen_id,
    c.citizen_name,
    ca.application_id,
    ca.application_status
FROM Citizen c
RIGHT JOIN Certificate_Application ca
    ON c.citizen_id = ca.citizen_id;


-- TASK-14
-- Generate every possible combination of Citizens
-- and Certificate Types.

SELECT
    c.citizen_id,
    c.citizen_name,
    ct.certificate_id,
    ct.certificate_name
FROM Citizen c
CROSS JOIN Certificate_Type ct;


-- TASK-15
-- Display pairs of citizens belonging to the same village
-- without displaying the same citizen twice.

SELECT
    A.citizen_id AS citizen1_id,
    A.citizen_name AS citizen1_name,
    B.citizen_id AS citizen2_id,
    B.citizen_name AS citizen2_name,
    A.village
FROM Citizen A
INNER JOIN Citizen B
    ON A.village = B.village
    AND A.citizen_id < B.citizen_id;