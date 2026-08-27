USE gram_panchayat_db;
SELECT MAX(application_date) AS latest_application_date FROM certificate_application;

SELECT MIN(application_date) AS earliest_application_date FROM certificate_application;

SELECT * FROM  certificate_application WHERE application_date = ( SELECT MAX(application_date) FROM certificate_application);

SELECT * FROM certificate_application WHERE application_date = (SELECT MIN(application_date) FROM certificate_application);

SELECT * FROM citizen WHERE citizen_id IN(SELECT citizen_id FROM certificate_application WHERE application_status='Approved');

SELECT * FROM certificate_application WHERE application_date > (SELECT MIN(application_date) FROM certificate_application );

SELECT * FROM certificate_application WHERE application_date < (SELECT MAX(application_date) FROM certificate_application);

SELECT * FROM citizen WHERE citizen_id IN(SELECT citizen_id FROM certificate_application);

SELECT * FROM citizen WHERE citizen_id NOT IN(SELECT citizen_id FROM certificate_application WHERE application_status = 'Approved');

SELECT * FROM certificate_type WHERE certificate_type_id IN (SELECT certificate_type_id FROM certificate_application WHERE application_status='Approved');

SELECT * FROM certificate_type WHERE certificate_type_id NOT IN (SELECT certificate_type_id FROM certificate_application WHERE application_status='Approved');

SELECT * FROM certificate_application WHERE application_date > (SELECT AVG(application_date) FROM certificate_application);

SELECT ct.certificate_name,ca.application_date FROM certificate_application ca JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id WHERE ca.application_date =(SELECT MAX(application_date) FROM certificate_application);

SELECT certificate_id,COUNT(*) AS application_count FROM certificate_application GROUP BY certificate_id ORDER BY application_count DESC LIMIT 1;

SELECT office_id,COUNT(*) AS application_count FROM certificate_application GROUP BY office_id ORDER BY application_count DESC LIMIT 1;

SELECT certificate_id,COUNT(*) AS application_count FROM certificate_application GROUP BY certificate_id HAVING COUNT(*) > (SELECT AVG(application_count) FROM (SELECT COUNT(*) AS application_count FROM certificate_application GROUP BY certificate_id) AS temp);

SELECT office_id,COUNT(*) AS application_count FROM certificate_application GROUP BY office_id HAVING COUNT(*) > ANY ( SELECT application_count FROM(SELECT COUNT(*) AS application_count FROM certificate_application GROUP BY office_id) AS temp);

SELECT office_id,COUNT(*) AS application_count FROM certificate_application GROUP BY office_id HAVING COUNT(*) >= ALL (SELECT application_count FROM (SELECT COUNT(*) AS application_count FROM certificate_application GROUP BY office_id )AS temp);

SELECT ct.certificate_name,ca.application_date FROM certificate_application ca JOIN certificate_type ct ON ca.certificate_id = ct.certificate_type_id WHERE ca.application_date = (SELECT MAX(application_date) FROM certificate_application);

SELECT * FROM citizen WHERE citizen_id IN(SELECT citizen_id FROM certificate_application GROUP BY citizen_id HAVING COUNT(*) >1);

SELECT application_status,COUNT(*) AS application_count FROM certificate_application GROUP BY application_status ORDER BY application_count DESC LIMIT 1;

-- OPTIONAL

SELECT * FROM certificate_application WHERE application_date =(SELECT MAX(application_date) FROM certificate_application);

SELECT * FROM certificate_application WHERE application_date=(SELECT MIN(application_date) FROM certificate_application);

SELECT * FROM citizen WHERE citizen_id IN(SELECT citizen_id FROM certificate_application WHERE application_status='Approved');

SELECT * FROM certificate_type WHERE certificate_type_id IN (SELECT certificate_type_id FROM certificate_application ) AND certificate_type_id NOT IN ( SELECT certificate_id FROM certificate_application WHERE application_status='Approved');

SELECT po.office_name,COUNT(*) AS total_applications FROM certificate_application ca JOIN panchayat_office po ON ca.office_id = po.office_id GROUP BY po.office_id, po.office_name ORDER BY total_applications DESC LIMIT 1;

SELECT ct.certificate_name,COUNT(*) AS total_applications FROM certificate_application ca JOIN certificate_type ct ON ca.certificate_id=ct.certificate_type_id GROUP BY ct.certificate_type_id,ct.certificate_name HAVING COUNT(*) > (SELECT AVG(app_count) FROM (SELECT COUNT(*) AS app_count FROM certificate_application GROUP BY certificate_id) AS temp); 

SELECT ct.certificate_name,COUNT(*) AS total_applications FROM certificate_application ca JOIN certificate_type ct ON ca.certificate_id=ct.certificate_type_id GROUP BY ct.certificate_type_id,ct.certificate_name ORDER BY total_applications DESC LIMIT 1;


SELECT ct.certificate_name AS certificate_type, COUNT(*) AS total_applications,MIN(ca.application_date) AS earliest_application_date,MAX(ca.application_date) AS latest_application_date FROM certificate_application ca JOIN certificate_type ct ON ca.certificate_id=ct.certificate_type_id GROUP BY ct.certificate_type_id,ct.certificate_name;