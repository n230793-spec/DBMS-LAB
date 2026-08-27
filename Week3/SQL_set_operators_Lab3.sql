USE gram_panchayat_db;
SHOW TABLES;

ALTER TABLE certificate_application 
DROP COLUMN certificate_name;

ALTER TABLE certificate_application
ADD certificate_id INT,
ADD office_id INT;

DROP TABLE certificate_application;

CREATE TABLE certificate_application(
application_id INT PRIMARY KEY,citizen_id INT NOT NULL,certificate_name VARCHAR(100) NOT NULL,application_date DATE NOT NULL,purpose VARCHAR(200) NOT NULL,application_status VARCHAR(30) NOT NULL,fee_paid DECIMAL(8,2) NOT NULL,reference_number VARCHAR(30) UNIQUE NOT NULL);
INSERT INTO Certificate_Application(application_id,citizen_id,certificate_name,application_date,purpose,application_status,fee_paid,reference_number)
VALUES(1001,101,"Residence Certificate","2026-07-01","Bank account documentation","Submitted",30.00,"GP20260001"),
(1002,102,"Family Member Certificate","2026-07-02","Welfare scheme application","Under Review",40.00,"GP20260002"),
(1003,103,"Property Certificate","2026-07-03","Property documentation","Submitted",50.00,"GP20260003"),
(1004,104,"Residence Certificate","2026-07-04","College admission","Approved",30.00,"GP20260004"),
(1005,105,"No-Dues Certificate","2026-07-05","Local service requirement","Under Review",25.00,"GP20260005"),
(1006,106,"Birth Record Request","2026-07-06","Personal documentation","Rejected",20.00,"GP20260006");


UPDATE certificate_application ca JOIN certificate_type ct ON ca.purpose=ct.certificate_name SET ca.certificate_id=ct.certificate_type_id;

DESCRIBE certificate_type;
DESCRIBE certificate_application;

SET SQL_SAFE_UPDATES=0;

UPDATE certificate_application ca JOIN panchayat_office po ON ca.certificate_name=po.office_name SET ca.office_id= po.office_id;

ALTER TABLE certificate_application ADD CONSTRAINT fk_citizen FOREIGN KEY(citizen_id) REFERENCES citizen(citizen_id);

ALTER TABLE certificate_application ADD CONSTRAINT fk_certificate FOREIGN KEY(certificate_id) REFERENCES certificate_type(certificate_type_id);

ALTER TABLE certificate_application ADD CONSTRAINT fk_office FOREIGN KEY(office_id) REFERENCES panchayat_office(office_id);

SHOW CREATE TABLE certificate_application;

INSERT INTO certificate_application(application_id,citizen_id,certificate_name)
VALUES(101,9999,"panchayat_office");

INSERT INTO certificate_application(application_id,citizen_id,certificate_id,office_id)
VALUES(102,1,9999,1);

DELETE FROM citizen WHERE citizen_id=1;

DELETE FROM certificate_type WHERE certificate_id=1;

SELECT * FROM citizen;

SELECT * FROM certificate_application;

SELECT full_name FROM citizen ORDER BY full_name ASC;

SELECT DISTINCT village_name FROM citizen;

SELECT DISTINCT certificate_name FROM certificate_type;

SELECT DISTINCT office_name FROM panchayat_office;

SELECT * FROM certificate_application WHERE application_status="Pending";

SELECT * FROM citizen WHERE village_name="Ramapuram";

SELECT * FROM certificate_application WHERE YEAR(application_date)=2026;

SELECT application_date FROM certificate_application ORDER BY application_date DESC;

SELECT ca.* FROM certificate_application ca JOIN panchayat_office po ON ca.office_id = po.office_id WHERE po.office_name="Nuzvid Panchayat Office";

SELECT c.full_name FROM citizen c JOIN certificate_application ca  ON c.citizen_id = ca.citizen_id JOIN certificate_type ct ON ca.certificate_id=ct.certificate_type_id WHERE ct.certificate_name="Income Certificate";
-- 13.by using union
SELECT c.full_name FROM citizen c JOIN certificate_application ca ON c.citizen_id = ca.citizen_id JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id WHERE ct.certificate_name ='Income Certificate'
UNION 
SELECT  c.full_name FROM citizen c JOIN certificate_application ca ON c.citizen_id=ca.citizen_id JOIN certificate_type ct ON ca.certificate_id=ct.certificate_type_id WHERE ct.certificate_name='Residence Certificate';

-- certificate application submitted
SELECT * FROM certificate_application WHERE MONTH(application_date)=1
UNION
SELECT * FROM certificate_application WHERE MONTH(application_date)=2;

SELECT * FROM citizen WHERE village_name="Ramapuram"
UNION
SELECT * FROM citizen WHERE village_name="Lakshmipuram";

SELECT c.full_name FROM citizen c JOIN certificate_application ca ON c.citizen_id = ca.citizen_id JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id WHERE ct.certificate_name='Income Certificate'
AND c.citizen_id IN(
SELECT c.citizen_id FROM citizen c JOIN certificate_application ca ON c.citizen_id=ca.citizen_id JOIN certificate_type ct ON ca.certificate_id=ct.certificate_type_id WHERE ct.certificate_name='Residence Certificate');

SELECT c.full_name FROM citizen c JOIN certificate_application ca ON c.citizen_id=ca.citizen_id WHERE YEAR(ca.application_date)=2025
AND c.citizen_id IN (
SELECT citizen_id FROM certificate_application WHERE YEAR(application_date)=2026);

SELECT c.full_name FROM citizen c JOIN certificate_application ca ON c.citizen_id =ca.citizen_id JOIN certificate_type ct ON ca.certificate_id=ct.certificate_type_id WHERE ct.certificate_name='Income Certificate'
AND c.citizen_id NOT IN (
SELECT c.citizen_id FROM citizen c JOIN certificate_application ca ON c.citizen_id=ca.citizen_id JOIN certificate_type ct ON ca.certificate_id WHERE ct.certificate_name ='Residence Certificate');

-- display certificate applications submitted 2026
SELECT * FROM certificate_application WHERE YEAR(application_date)=2026
AND application_id NOT IN (SELECT application_id FROM certificate_application WHERE YEAR(application_date)=2025);

-- insert a invalid citizen_id
INSERT INTO certification_application(application_id,citizen_id,certificate_id,office_id,application_date,purpose,application_status,fee_paid,reference_number)
VALUES(301,9999,1,1,'2026-07-28','Income Certificate','Pending',100.00,'REF301');

DELETE FROM citizen WHERE citizen_id=1;

-- 22 is short notes on foreign key constraints

-- 23 is -  IN  operation
SELECT full_name FROM citizen WHERE citizen_id IN(SELECT citizen_id FROM certificate_application);

SELECT * FROM citizen WHERE village_name IN (
SELECT DISTINCT c.village_name FROM citizen c JOIN certificate_application ca ON c.citizen_id = ca.citizen_id JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id WHERE ct.certificate_name ='Income Certificate'
);

SELECT * FROM citizen WHERE citizen_id NOT IN (
SELECT citizen_id FROM certificate_application
);

SELECT * FROM panchayat_office WHERE office_id NOT IN (
SELECT office_id FROM certificate_application
);

SELECT * FROM citizen c WHERE EXISTS(
SELECT 1 FROM certificate_application ca WHERE c.citizen_id=ca.citizen_id
);

SELECT * FROM certificate_type ct WHERE EXISTS (
SELECT 1 FROM certificate_application ca WHERE ct.certificate_type_id=ca.certificate_id
);

SELECT * FROM citizen c WHERE NOT EXISTS(
SELECT 1 FROM certificate_application ca WHERE c.citizen_id = ca.citizen_id
);

SELECT * FROM certificate_type ct WHERE NOT EXISTS(
SELECT 1 FROM certificate_application ca WHERE ct.certificate_type_id=ca.certificate_id
);

-- 31.display age of person these 4 are not working because these columns are not present in related tabless
SELECT * FROM citizen WHERE age > ANY (
SELECT age FROM citizen WHERE village_name='Ramapuram'
);

SELECT * FROM certificate_application WHERE  processing_days >ANY(
SELECT processing_days FROM certificate_application ca JOIN panchayat_office po ON ca.office_id = po.office_name
WHERE po.office_name = 'Nuzvid Panchayat Office'
);

SELECT * FROM citizen WHERE age>ALL (
SELECT age FROM citizen WHERE village_name='Ramapuram'
);

SELECT * FROM certificate_application WHERE processing_days >ALL (
SELECT processing_days FROM certificate_application ca JOIN panchayat_office po ON ca.office_id = po.office_id WHERE po.office_name ='Nuzvid Panchayat Office'
);
