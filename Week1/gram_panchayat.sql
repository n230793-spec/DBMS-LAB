CREATE DATABASE gram_panchayat_db;
USE gram_panchayat_db;
CREATE TABLE Citizen(
citizen_id INT PRIMARY KEY,full_name VARCHAR(100) NOT NULL,date_of_birth DATE NOT NULL,gender VARCHAR(10) NOT NULL,mobile_number VARCHAR(15) UNIQUE NOT NULL ,occupation VARCHAR(50) ,village_name VARCHAR(50) NOT NULL,is_active BOOLEAN NOT NULL
);
INSERT INTO Citizen(citizen_id,full_name,date_of_birth,gender,mobile_number,occupation,village_name,is_active)
VALUES(101,"Ravi Kumar","1995-06-15","Male",9876500001,"Farmer","Ramapuram",TRUE),
(102,"Lakshmi Devi","1988-11-22","Female",9876500002,"Tailor","Ramapuram",TRUE),
(103,"Suresh Babu","1992-03-10","Male",9876500003,"Shopkeper","Seethampeta",TRUE),
(104,"Anjali Rao","2000-08-05","Female",9876500004,"Student","Ramapuram",TRUE),
(105,"Kiran Kumar","1985-01-18","Male",9876500005,"Electrician","Seethampeta",TRUE),
(106,"Meena Kumari","1998-12-30","Female",9876500006,"Teacher","Lakshmipuram",FALSE);

CREATE TABLE Certificate_Type(
certificate_type_id INT PRIMARY KEY,certificate_name VARCHAR(100) UNIQUE NOT NULL,description VARCHAR(200) NOT NULL,processing_days INT NOT NULL ,application_fee DECIMAL(8,2),is_available BOOLEAN NOT NULL);
INSERT INTO Certificate_Type(certificate_type_id,certificate_name,description,processing_days,application_fee,is_available)
VALUES(1,"Residence Certificate","Certifies the declared place of residence",7,30.00,TRUE),
(2,"Birth Record Request","Request for a locally maintained death record",5,20.00,TRUE),
(3,"Death Record Request","Request for a locally maintained death record",10,40.00,TRUE),
(4,"Family Member Certificate","Records declared family-member information",10,40.00,TRUE),
(5,"Property Certificate","Certificate related to locally maintained property records",15,50.00,TRUE),
(6,"No-Dues Certificate","Indicates applicable local dues status",7,25.00,FALSE);

CREATE TABLE certificate_application(
application_id INT PRIMARY KEY,citizen_id INT NOT NULL,certificate_name VARCHAR(100) NOT NULL,application_date DATE NOT NULL,purpose VARCHAR(200) NOT NULL,application_status VARCHAR(30) NOT NULL,fee_paid DECIMAL(8,2) NOT NULL,reference_number VARCHAR(30) UNIQUE NOT NULL);
INSERT INTO Certificate_Application(application_id,citizen_id,certificate_name,application_date,purpose,application_status,fee_paid,reference_number)
VALUES(1001,101,"Residence Certificate","2026-07-01","Bank account documentation","Submitted",30.00,"GP20260001"),
(1002,102,"Family Member Certificate","2026-07-02","Welfare scheme application","Under Review",40.00,"GP20260002"),
(1003,103,"Property Certificate","2026-07-03","Property documentation","Submitted",50.00,"GP20260003"),
(1004,104,"Residence Certificate","2026-07-04","College admission","Approved",30.00,"GP20260004"),
(1005,105,"No-Dues Certificate","2026-07-05","Local service requirement","Under Review",25.00,"GP20260005"),
(1006,106,"Birth Record Request","2026-07-06","Personal documentation","Rejected",20.00,"GP20260006");

CREATE TABLE Panchayat_Office (
office_id INT PRIMARY KEY,office_name VARCHAR(100) NOT NULL,village_name VARCHAR(50) NOT NULL,pincode VARCHAR(6) NOT NULL,contact_number VARCHAR(15) UNIQUE,office_email VARCHAR(100) UNIQUE , opening_time TIME NOT NULL , is_operational BOOLEAN NOT NULL);
INSERT INTO Panchayat_Office(office_id,office_name,village_name,pincode,contact_number,office_email,opening_time,is_operational)
VALUES(1,"Ramapuram Grama Panchayat","Ramapuram","521101","0866000001","ramapuram@gp.example","09:00:00",TRUE),
(2,"Seethampeta Grama Panchayat","Seethampeta","521102","0866000002","seethampeta@gp.example","09:30:00",TRUE),
(3,"Lakshmipuram Grama Panchayat","Lakshmipuram","521103","0866000003","lakshmipuram@gp.example","09:00:00",TRUE),
(4,"Krishnapuram Grama Panchayat","Krishnapuram","521104","0866000004","krishnapuram@gp.example","10:00:00",TRUE),
(5,"Venkatapuram Grama Panchayat","Venkatapuram","521105","0866000005","venkatapuram@gp.example","09:30:00",TRUE),
(6,"Gopalapuram Grama Panchayat","Gopalapuram","521106","0866000006","gopalapuram@gp.example","09:00:00",FALSE);

DROP TABLE certifate_applicion

INSERT INTO Citizen(
citizen_id,full_name,date_of_birth,gender,mobile_number,occupation,village_name,is_active)
VALUES(107,"janu","2026-09-06","Female","9809334564","Teacher","Nuzvidu",TRUE);

INSERT INTO Certificate_Type(
certificate_type_id,certificate_name,description,processing_days,application_fee,is_available)
VALUES(7,"Income Certificate","certifies the income of a person",7,100.00,TRUE);

UPDATE certificate_application SET application_status="Under Review"
WHERE application_id=1001;

UPDATE certificate_application SET application_status="Approved"
WHERE application_id=1002;

UPDATE Citizen SET occupation="Electrical Technician"
WHERE citizen_id=105;

UPDATE Certificate_Type SET processing_days = 12
WHERE certificate_type_id=5;

UPDATE Certificate_Type SET is_available = TRUE
WHERE certificate_name = N0-Dues Certificate;

DELETE FROM Citizen WHERE citizen_id=107;
	
ALTER TABLE  Citizen ADD COLUMN address VARCHAR(50) NOT NULL;

ALTER TABLE Certificate_Application ADD COLUMN issued_date DATE;

ALTER TABLE Certificate_Application MODIFY COLUMN purpose VARCHAR(300) NOT NULL;

ALTER TABLE Panchayat_Office ADD COLUMN closing_time TIME;

CREATE TABLE Temporary_Request(
request_id INT Primary Key,request_name VARCHAR(50) NOT NULL,request_date NOT NULL);
INSERT INTO Temporary_Request(request_id,request_name,request_date)
VALUES (101,"laptop issue","2026-09-06"),
(102,"outpass issue","2026-09-08"),
(103,"books issue","2026-04-03");

SELECT * FROM Temporary_Request;
TRUNCATE Temporary_Request;
SHOW TABLES;
DROP TABLE Temporary_Request;
SHOW TABLES;

-- CONSTRAINT EXPERIMENT

insert into Citizen
(citizen_id,full_name,date_of_birth,gender,mobile_number,occupation,village_name,is_active)
values
(101,"Ravi","1998-04-20","Male",9756421378,"teacher","nuzvid",TRUE);

insert into Citizen
(citizen_id,full_name,date_of_birth,gender,mobile_number,occupation,village_name,is_active,address)
values
(107,"Raju","1998-04-20","Male",9876500001,"worker","Palnadu",TRUE,"Guntur");


insert into Certificate_Type 
(certificate_type_id,descriptin,processing_days,application_fee,is_available)
values
(8,"Certifies the declared place of residence",7,30.00,TRUE);

INSERT INTO Certificate_Application(application_id,citizen_id,certificate_name,application_date,purpose,application_status,fee_paid,reference_number)
VALUES(18,111,"STUDY Certificate","2026-07-01","FOR STUDY PURPOSE","Submitted",40.00,"GP20260001"),


CREATE TABLE Certificate_Application(
application_id INT PRIMARY KEY,
citizen_id INT NOT NULL,
certificate_name VARCHAR(50)
);

INSERT INTO Certificate_Application values
(1001,999,"Unknown Certificate");




