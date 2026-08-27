USE gram_panchayat_db;
SHOW TABLES;

CREATE VIEW All_Applications AS SELECT * FROM certificate_application;

CREATE VIEW Application_Basic_Details AS SELECT application_id,citizen_id,application_status FROM certificate_application;

CREATE VIEW Approved_Applications AS SELECT * FROM certificate_application WHERE application_status = 'Approved';

SELECT * FROM Approved_Applications ;

SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

CREATE VIEW Application_Certificate_Details AS SELECT ca.application_id ,ct.certificate_name , ca.application_date FROM certificate_application ca JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id;

CREATE VIEW Citizen_Application_Status AS SELECT c.full_name , ca.application_status FROM citizen c JOIN certificate_application ca ON c.citizen_id = ca.citizen_id;

CREATE VIEW Applications_By_Office AS SELECT po.office_name,ca.application_id,ca.application_status FROM panchayat_office po JOIN certificate_application ca ON po.office_id = ca.office_id;

CREATE VIEW Applications_By_Cert  AS SELECT ct.certificate_name,COUNT(ca.application_id) AS total_applications FROM certificate_type ct LEFT JOIN certificate_application ca ON ct.certificate_type_id = ca.certificate_id GROUP BY ct.certificate_type_id,ct.certificate_name;

CREATE VIEW Applications_By_Panchayat_Office AS SELECT po.office_name,COUNT(ca.application_id) AS total_applications FROM panchayat_office po LEFT JOIN certificate_application ca ON po.office_id = ca.office_id GROUP BY po.office_id,po.office_name;

CREATE VIEW Pending_Applications AS SELECT ca.application_id,ct.certificate_name,ca.citizen_id,ca.application_date,ca.application_status FROM certificate_application ca JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id WHERE ca.application_status = 'Pending';

-- suppose we use the Application_Certificate_Details View 
SELECT application_id,certificate_name FROM Application_Certificate_Details WHERE certificate_name = 'Income Certificate';

SHOW CREATE VIEW Application_Certificate_Details;

CREATE VIEW Certificate_Application_Counts AS SELECT ct.certificate_name ,COUNT(ca.application_id) AS total_applications FROM certificate_type ct LEFT JOIN certificate_application ca ON ct.certificate_type_id = ca.certificate_id GROUP BY ct.certificate_type_id , ct.certificate_name;
SELECT * FROM  Certificate_Application_Counts;

CREATE VIEW Offices_More_Than_One_Application AS SELECT po.office_name,COUNT(ca.application_id) AS total_applications FROM panchayat_office po JOIN certificate_application ca ON po.office_id = ca.office_id GROUP BY po.office_id,po.office_name HAVING COUNT(ca.application_id) > 1;

CREATE VIEW Certificate_Application_Dates AS SELECT ct.certificate_name,MIN(ca.application_date) AS earliest_application_date ,MAX(ca.application_date) AS latest_application_date FROM certificate_type ct JOIN certificate_application ca ON ct.certificate_type_id = ca.certificate_id GROUP BY ct.certificate_type_id ,ct.certificate_name;

CREATE VIEW Citizen_Application_Counts AS SELECT c.full_name ,COUNT(ca.application_id) FROM citizen c LEFT JOIN  certificate_application ca ON c.citizen_id = ca.citizen_id GROUP BY c.citizen_id,c.full_name;

CREATE VIEW Complete_Application_Details AS SELECT c.full_name,ct.certificate_name,ca.application_id,ca.application_date,ca.application_status FROM  certificate_application ca JOIN citizen c ON ca.citizen_id = c.citizen_id JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id;

CREATE VIEW Approved_Details AS SELECT ca.application_id,c.full_name,ct.certificate_name,ca.application_date,ca.application_status FROM certificate_application ca JOIN citizen c ON ca.citizen_id = c.citizen_id JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id WHERE ca.application_status = 'Approved';

SELECT * FROM Approved_Details;

SELECT application_id,full_name,certificate_name,application_date FROM Approved_Details WHERE application_date >= '2026-01-01' ORDER BY application_date DESC;

DROP VIEW Approved_Details;

SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

-- Optional
CREATE VIEW All_status_Approved AS SELECT * FROM certificate_application WHERE application_status = 'Approved';

SELECT * FROM All_status_Approved;

CREATE VIEW Certificate_Wise_Statistics AS SELECT ct.certificate_name ,COUNT(ca.application_id) AS total_applications ,MIN(ca.application_date) AS earliest_application,MAX(ca.application_date) AS latest_application FROM certificate_type ct LEFT JOIN certificate_application ca ON ct.certificate_type_id = ca.certificate_id GROUP BY ct.certificate_type_id,ct.certificate_name;

CREATE VIEW Office_Wise_Statistics AS SELECT po.office_name,COUNT(ca.application_id) AS total_applications,MIN(ca.application_date) AS earliest_application,MAX(application_date) AS latest_application FROM panchayat_office po LEFT JOIN  certificate_application ca ON po.office_id = ca.office_id GROUP BY po.office_id,po.office_name;

CREATE VIEW Citizen_Wise_Application_Counts AS SELECT c.full_name,COUNT(ca.application_id) AS total_applications FROM citizen c LEFT JOIN certificate_application ca ON c.citizen_id = ca.citizen_id GROUP BY c.citizen_id,c.full_name;

CREATE VIEW Complete_GramPanchayat_Applications AS SELECT ca.application_id,c.full_name,ct.certificate_name,ca.application_date,ca.application_status FROM certificate_application ca JOIN citizen c ON ca.citizen_id = c.citizen_id JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id JOIN panchayat_office po ON ca.office_id = po.office_id;

-- TO DISPLAY THE VIEW
SELECT * FROM Complete_GramPanchayat_Applications;

CREATE VIEW Gram_Panchayat_Dashboard AS SELECT COUNT(*) AS total_applications ,SUM(CASE WHEN application_status = 'Approved' THEN ELSE 0 END) AS approved_applications,
SUM(CASE WHEN application_status = 'Pending' THEN 1 ELSE 0 END) AS pending_applications,
SUM(CASE WHEN application_status = 'Rejected' THEN 1 ELSE 0 END) AS rejected_applications FROM certificate_application;